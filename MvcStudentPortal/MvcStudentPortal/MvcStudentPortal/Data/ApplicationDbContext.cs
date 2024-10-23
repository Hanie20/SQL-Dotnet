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
        public async Task<List<Student>> GetStudentsAsync()
        {
            return await Students.FromSqlRaw("EXEC GetStudents").ToListAsync();
        }
    }
}
