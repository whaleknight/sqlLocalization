using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.Extensions.Logging.Console;
using Microsoft.Extensions.Logging;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using System.Globalization;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Localization.SqlLocalizer.DbStringLocalizer;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Localization;
using Microsoft.Extensions.Options;
using Microsoft.AspNetCore.Mvc;
using System.Reflection;

namespace sqllocalization
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            var sqlConnectionString = Configuration["DbStringLocalizer:ConnectionString"];

            services.AddDbContext<LocalizationModelContext>(options =>
            options.UseMySql(
                        sqlConnectionString,
                        b => b.MigrationsAssembly("sqllocalization")
                ),
                ServiceLifetime.Singleton,
                ServiceLifetime.Singleton
            );


            var useTypeFullNames = false;
            var useOnlyPropertyNames = false;
            var returnOnlyKeyIfNotFound = false;
            var createNewRecordWhenLocalisedStringDoesNotExist = true;

            // Requires that LocalizationModelContext is defined
            services.AddSqlLocalization(options => options.UseSettings(useTypeFullNames, useOnlyPropertyNames, returnOnlyKeyIfNotFound, createNewRecordWhenLocalisedStringDoesNotExist));
            // services.AddSqlLocalization(options => options.ReturnOnlyKeyIfNotFound = true);
            // services.AddLocalization(options => options.ResourcesPath = "Resources");
            //services.AddSqlLocalization();

            services.AddMvc(option => option.EnableEndpointRouting = false)
                    .AddViewLocalization()
                    .AddDataAnnotationsLocalization();

            services.AddScoped<LanguageActionFilter>();

            services.Configure<RequestLocalizationOptions>(
                    options =>
                    {
                        var supportedCultures = new List<CultureInfo>
                                    {
                                        new CultureInfo("en-US"),
                                        new CultureInfo("zh-CHS"),
                                        new CultureInfo("ja-JP"),
                                        new CultureInfo("ms-MY"),
                                        new CultureInfo("th-TH")
                                    };

                        options.DefaultRequestCulture = new RequestCulture(culture: "en-US", uiCulture: "en-US");
                        options.SupportedCultures = supportedCultures;
                        options.SupportedUICultures = supportedCultures;
                    });

            services.AddControllersWithViews()
                .AddDataAnnotationsLocalization(options =>
                {
                    options.DataAnnotationLocalizerProvider = (type, factory) =>
                    {
                        var assemblyName = new AssemblyName(typeof(SharedResource).GetTypeInfo().Assembly.FullName);
                        return factory.Create("SharedResource", assemblyName.Name);
                    };
                });
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {

            var locOptions = app.ApplicationServices.GetService<IOptions<RequestLocalizationOptions>>();
            app.UseRequestLocalization(locOptions.Value);

            app.UseStaticFiles();

            app.UseMvc();

            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }
            app.UseHttpsRedirection();
            app.UseStaticFiles();

            app.UseRouting();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllerRoute(
                    name: "default",
                    pattern: "{controller=Home}/{action=Index}/{id?}");
            });
        }
    }
}
