using Microsoft.EntityFrameworkCore;
using PinBoardBackend.Data;

var builder = WebApplication.CreateBuilder(args);

// DB-Kontext registrieren
builder.Services.AddDbContext<PinContext>(options =>
    options.UseSqlite("Data Source=pins.db", b => b.MigrationsAssembly("DbPinLibrary")));

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();

var app = builder.Build();


app.UseHttpsRedirection();
app.UseAuthorization();
app.MapControllers();

app.Run();