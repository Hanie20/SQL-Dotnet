using Microsoft.EntityFrameworkCore;
using MvcStudentPortal.Models.Entities;

namespace MvcStudentPortal.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        {
        }

        public DbSet<Student> Students { get; set; }
    }
}
