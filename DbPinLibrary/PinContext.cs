using Microsoft.EntityFrameworkCore;
using PinBoardBackend.Models;
using System.Net.NetworkInformation;

namespace PinBoardBackend.Data
{
    public class PinContext : DbContext
    {
        public PinContext(DbContextOptions<PinContext> options) : base(options) { }

        public DbSet<Pin> Pins { get; set; }
    }
}