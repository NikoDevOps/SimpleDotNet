using System;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Hosting;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

var greeting = Environment.GetEnvironmentVariable("GREETING") ?? "world";

app.MapGet("/", () => Results.Text($"Hello, {greeting}!", "text/plain"));

app.Run();