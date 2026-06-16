using BoxAssembly.Application.Contracts;
using BoxAssembly.Domain;
using BoxAssembly.EntityFrameworkCore;
using Volo.Abp.Application;
using Volo.Abp.Modularity;

namespace BoxAssembly.Application;

/// <summary>
/// 应用层模块,包含应用服务实现和业务用例编排。
/// </summary>
/// <remarks>
/// 应用层负责协调领域对象完成业务操作,处理 DTO 与实体之间的转换,
/// 并通过仓储接口与数据库交互。依赖领域层和基础设施层。
/// </remarks>
[DependsOn(
    typeof(BoxAssemblyDomainModule),
    typeof(BoxAssemblyApplicationContractsModule),
    typeof(BoxAssemblyEntityFrameworkCoreModule),
    typeof(AbpDddApplicationModule))]
public class BoxAssemblyApplicationModule : AbpModule
{
}