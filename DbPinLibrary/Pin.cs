namespace PinBoardBackend.Models
{
    public class Pin
    {
        public int Id { get; set; }             // Primärschlüssel
        public string ImagePath { get; set; }   // Pfad zum Bild
        public double X { get; set; }           // Position X
        public double Y { get; set; }           // Position Y
    }
}