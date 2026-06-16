using Volo.Abp.Domain;
using Volo.Abp.Modularity;

namespace BoxAssembly.Domain;

/// <summary>
/// 领域层模块,包含核心业务实体、值对象、领域服务和仓储接口。
/// </summary>
/// <remarks>
/// 领域层是 DDD 分层架构的核心,不依赖任何外部框架或基础设施。
/// 所有业务规则和领域逻辑应在此层实现。
/// </remarks>
[DependsOn(typeof(AbpDddDomainModule))]
public class BoxAssemblyDomainModule : AbpModule
{
}