using Volo.Abp.Application;
using Volo.Abp.Modularity;

namespace BoxAssembly.Application.Contracts;

/// <summary>
/// 应用契约层模块,包含应用服务接口和数据传输对象(DTO)。
/// </summary>
/// <remarks>
/// 此层定义应用服务的对外契约,供接口层(Api)或其他消费者调用。
/// 仅依赖 ABP 应用契约抽象,不依赖具体实现。
/// </remarks>
[DependsOn(typeof(AbpDddApplicationContractsModule))]
public class BoxAssemblyApplicationContractsModule : AbpModule
{
}