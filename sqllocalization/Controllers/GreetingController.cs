using Localization.SqlLocalizer.DbStringLocalizer;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Localization;

namespace sqllocalization.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class GreetingController : ControllerBase
    {
        private readonly IStringLocalizer<SharedResource> _localizer;
        private readonly IStringLocalizer<GreetingController> _greetLocalizerizer;
        private readonly IStringExtendedLocalizerFactory _stringExtendedLocalizerFactory;

        public GreetingController(IStringLocalizer<SharedResource> localizer, IStringLocalizer<GreetingController> greetLocalizerizer, IStringExtendedLocalizerFactory stringExtendedLocalizerFactor)
        {
            _localizer = localizer;
            _greetLocalizerizer = greetLocalizerizer;
            _stringExtendedLocalizerFactory = stringExtendedLocalizerFactor;
        }

        [HttpGet]
        public string Get()
        {
            // _localizer["Name"] 
            return _greetLocalizerizer["Greet"];
        }

        [HttpGet]
        [Route("reset")]
        public string Reset()
        {
            _stringExtendedLocalizerFactory.ResetCache();
            return _greetLocalizerizer["Greet"];
        }
    }
}