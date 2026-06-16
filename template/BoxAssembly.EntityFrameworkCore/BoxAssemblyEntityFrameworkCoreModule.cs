using BoxAssembly.Domain;
using Volo.Abp.EntityFrameworkCore;
using Volo.Abp.Modularity;

namespace BoxAssembly.EntityFrameworkCore;

/// <summary>
/// Entity Framework Core 数据访问层模块,提供数据库上下文和仓储实现。
/// </summary>
/// <remarks>
/// 基础设施层负责实现领域层定义的仓储接口,使用 PostgreSQL 作为数据库。
/// 依赖领域层,实现依赖倒置原则。
/// </remarks>
[DependsOn(
    typeof(BoxAssemblyDomainModule),
    typeof(AbpEntityFrameworkCoreModule))]
public class BoxAssemblyEntityFrameworkCoreModule : AbpModule
{
}