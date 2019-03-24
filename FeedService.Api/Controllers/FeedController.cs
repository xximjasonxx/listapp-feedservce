using System;
using System.Collections.Generic;
using FeedService.Api.Models;
using Microsoft.AspNetCore.Mvc;

namespace FeedService.Api.Controllers
{
    public class FeedController : Controller
    {
        [HttpGet]
        public IActionResult GetAction()
        {
            return Ok(new List<FeedEntry>
            {
                new FeedEntry { ActionText = "This is action 1" },
                new FeedEntry { ActionText = "This is action 2" },
                new FeedEntry { ActionText = "This is action 3" },
                new FeedEntry { ActionText = "This is action 4" },
                new FeedEntry { ActionText = "This is action 5" },
                new FeedEntry { ActionText = "This is action 6" }
            });
        }
    }
}
