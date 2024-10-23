using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MvcStudentPortal.Data;
using MvcStudentPortal.Models;
using MvcStudentPortal.Models.Entities;

namespace MvcStudentPortal.Controllers
{
    public class StudentsController : Controller
    {
        private readonly ApplicationDbContext dbContext;
        public StudentsController(ApplicationDbContext dbContext)
        {
            this.dbContext = dbContext;
        }

        [HttpGet]
        public IActionResult Add()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Add(StudentViewModel studentViewModel)
        {
            var student = new Student
            {
                Lastname = studentViewModel.Lastname,
                Firstname = studentViewModel.Firstname,
                Email = studentViewModel.Email
            };
            await dbContext.AddAsync(student);
            await dbContext.SaveChangesAsync();
            dbContext.SaveChanges();

            return RedirectToAction("List", "Students");
        }

         [HttpGet]
        public async Task<IActionResult> List()
        {
            var students = await dbcontext.Students.ToListAsync();
            //var students = await dbcontext.GetStudentsAsync();
            return View(students);
        }

        [HttpGet]
        public async Task<IActionResult> Edit(Guid id)
        {
            var student = await dbContext.Students.FindAsync(id);

            return View(student);
        }

        [HttpPost]
        public async Task<IActionResult> Edit(Student viewModel)
        {
            var student = await dbContext.Students.FindAsync(viewModel.Id);

            if (student is not null)
            {
                student.Firstname = viewModel.Firstname;
                student.Lastname = viewModel.Lastname;
                student.Email = viewModel.Email;
         
                await dbContext.SaveChangesAsync();
            }
            return RedirectToAction("List", "Students");

        }

        [HttpPost]
        public async Task<IActionResult> Delete(Student viewModel)
        {
            var student = await dbContext.Students
                .AsNoTracking()
                .FirstOrDefaultAsync(x => x.Id == viewModel.Id);

            if (student is not null)
            {
                dbContext.Students.Remove(viewModel);
                await dbContext.SaveChangesAsync();
            }
            return RedirectToAction("List", "Students");
        }
    }
}
