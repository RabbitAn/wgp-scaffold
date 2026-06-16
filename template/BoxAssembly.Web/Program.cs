using BoxAssembly.Web;

var builder = WebApplication.CreateBuilder(args);

// 使用 Autofac 作为依赖注入容器
builder.Host.UseAutofac();

// 添加 ABP 应用模块
await builder.AddApplicationAsync<BoxAssemblyWebModule>();

var app = builder.Build();

// 初始化 ABP 应用
await app.InitializeApplicationAsync();

await app.RunAsync();