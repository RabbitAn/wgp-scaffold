using BoxAssembly.Application;
using BoxAssembly.Application.Contracts;
using BoxAssembly.EntityFrameworkCore;
using Volo.Abp;
using Volo.Abp.AspNetCore.Mvc;
using Volo.Abp.Autofac;
using Volo.Abp.Modularity;

namespace BoxAssembly.Web;

/// <summary>
/// Web 接口层模块,配置 ASP.NET Core 应用和 API 端点。
/// </summary>
/// <remarks>
/// 接口层是应用的入口,配置 Swagger 文档、路由、认证授权等中间件。
/// 通过 ABP 的约定式控制器自动暴露应用服务为 API。
/// </remarks>
[DependsOn(
    typeof(AbpAspNetCoreMvcModule),
    typeof(AbpAutofacModule),
    typeof(BoxAssemblyEntityFrameworkCoreModule),
    typeof(BoxAssemblyApplicationContractsModule))]
public class BoxAssemblyWebModule : AbpModule
{
    /// <summary>
    /// 配置应用启动时的中间件管道。
    /// </summary>
    /// <param name="context">应用初始化上下文</param>
    public override void OnApplicationInitialization(ApplicationInitializationContext context)
    {
        var app = context.GetApplicationBuilder();
        var env = context.GetEnvironment();

        // 开发环境下启用 Swagger
        if (env.IsDevelopment())
        {
            app.UseSwagger();
            app.UseSwaggerUI();
        }

        // 配置请求处理管道
        app.UseRouting();
        app.UseCors();
        app.UseAuthentication();
        app.UseAuthorization();
        app.UseConfiguredEndpoints();
    }

    /// <summary>
    /// 配置应用服务,包括 API 控制器和 Swagger。
    /// </summary>
    /// <param name="context">服务配置上下文</param>
    public override void ConfigureServices(ServiceConfigurationContext context)
    {
        // 配置 ABP 约定式控制器,自动将应用服务暴露为 API
        Configure<AbpAspNetCoreMvcOptions>(options =>
        {
            options.ConventionalControllers.Create(typeof(BoxAssemblyApplicationModule).Assembly);
        });

        // 添加 Swagger 文档生成
        context.Services.AddSwaggerGen();
    }
}