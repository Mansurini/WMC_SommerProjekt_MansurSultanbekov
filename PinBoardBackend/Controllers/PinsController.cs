using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PinBoardBackend.Data;
using PinBoardBackend.Models;
using System.Net.NetworkInformation;

namespace PinBoardBackend.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PinsController : ControllerBase
    {
        private readonly PinContext _context;

        public PinsController(PinContext context)
        {
            _context = context;
        }

        // PUT: api/pins/5
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdatePin(int id, [FromBody] Pin updatedPin)
        {
            var pin = await _context.Pins.FindAsync(id);
            if (pin == null) return NotFound();

            pin.ImagePath = updatedPin.ImagePath;
            pin.X = updatedPin.X;
            pin.Y = updatedPin.Y;

            await _context.SaveChangesAsync();
            return NoContent();
        }

        // GET: api/pins
        [HttpGet]
        public async Task<IEnumerable<Pin>> GetPins()
        {
            return await _context.Pins.ToListAsync();
        }

        // POST: api/pins
        [HttpPost]
        public async Task<ActionResult<Pin>> AddPin([FromBody] Pin pin)
        {
            _context.Pins.Add(pin);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(GetPins), new { id = pin.Id }, pin);
        }

        // Optional: DELETE /api/pins/1
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletePin(int id)
        {
            var pin = await _context.Pins.FindAsync(id);
            if (pin == null) return NotFound();

            _context.Pins.Remove(pin);
            await _context.SaveChangesAsync();
            return NoContent();
        }
    }
}