# WGP Scaffold

ABP Framework 最小化项目脚手架,支持一行命令远程安装,随处可用。

## 特性

- **远程安装**: 一行 PowerShell 命令从 GitHub 安装
- **简洁命令**: `wgp new MyApp` 即在当前目录生成项目
- **自定义路径**: `wgp new MyApp -o D:\Projects`
- **最小模板**: 净的 ABP DDD 分层结构,无冗余示例代码
- **自动替换**: 项目名、命名空间、文件名一键替换

---

## 仓库结构

```
wgp-scaffold/
├── template/                    # ABP 项目模板
│   ├── BoxAssembly.Domain/
│   ├── BoxAssembly.Application.Contracts/
│   ├── BoxAssembly.Application/
│   ├── BoxAssembly.EntityFrameworkCore/
│   ├── BoxAssembly.Web/
│   └── BoxAssembly.sln
├── wgp.bat                      # CLI 命令入口
├── New-Project.ps1              # 核心生成脚本
├── install.ps1                  # 远程安装脚本
├── uninstall.ps1                # 卸载脚本
└── README.md
```

---

## 快速开始

### 步骤 1: 推送到 GitHub

将此仓库推送到你的 GitHub:

```bash
# 在 _scaffold 目录初始化 Git
cd _scaffold
git init
git add .
git commit -m "Initial scaffold"

# 推送到 GitHub (替换为你的仓库)
git remote add origin https://github.com/YOUR_USERNAME/wgp-scaffold.git
git push -u origin main
```

### 步骤 2: 安装

打开 PowerShell,执行一行命令安装:

```powershell
# 替换 YOUR_USERNAME 为你的 GitHub 用户名
$owner="YOUR_USERNAME"; $repo="wgp-scaffold"; irm "https://raw.githubusercontent.com/$owner/$repo/main/install.ps1" | iex
```

安装完成后:
- CLI 工具安装到 `%USERPROFILE%\.wgp`
- 自动添加到用户 PATH
- **重启终端** 后 `wgp` 命令生效

### 步骤 3: 使用

在任意目录执行:

```bash
# 在当前目录创建 MyApp 项目
wgp new MyApp

# 在指定目录创建
wgp new MyApp -o D:\Projects
wgp new OrderService -o E:\Solutions

# 查看版本
wgp version

# 查看帮助
wgp
```

---

## 生成的项目结构

```
MyApp/
├── MyApp.Domain/              # 领域层 - 实体、仓储接口
├── MyApp.Application.Contracts/  # 应用契约 - DTO、服务接口
├── MyApp.Application/         # 应用层 - 应用服务
├── MyApp.EntityFrameworkCore/ # 数据层 - 仓储实现
├── MyApp.Web/                 # Web 层 - API、配置
└── MyApp.sln                  # 解决方案文件
```

---

## 开发新项目

生成后立即开始开发:

```bash
cd MyApp
dotnet restore
dotnet build
dotnet run --project MyApp.Web
```

访问 `http://localhost:5213/swagger` 查看 API 文档。

---

## 自定义模板

你可以修改 `template/` 目录来定制脚手架:

### 添加常用实体

在 `template/BoxAssembly.Domain/Entities/` 放入示例实体:

```csharp
namespace BoxAssembly.Domain.Entities;

public class User : Entity<Guid>
{
    public string Name { get; set; }
}
```

生成新项目时,`BoxAssembly` 自动替换为你的项目名。

### 添加常用配置

修改 `template/BoxAssembly.Web/appsettings.json`:

```json
{
  "ConnectionStrings": {
    "Default": "Host=localhost;Database=BoxAssembly;Username=postgres"
  }
}
```

---

## 更新脚手架

修改模板后推送到 GitHub,其他机器重新安装即可:

```powershell
# 卸载旧版本
irm "https://raw.githubusercontent.com/YOUR_USERNAME/wgp-scaffold/main/uninstall.ps1" | iex

# 安装新版本
$owner="YOUR_USERNAME"; $repo="wgp-scaffold"; irm "https://raw.githubusercontent.com/$owner/$repo/main/install.ps1" | iex
```

---

## 卸载

```powershell
$owner="YOUR_USERNAME"; $repo="wgp-scaffold"; irm "https://raw.githubusercontent.com/$owner/$repo/main/uninstall.ps1" | iex
```

---

## 常见问题

**Q: `wgp` 命令找不到?**

A: 安装后需要**重启终端**才能生效。或者手动刷新 PATH:
```powershell
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","User") + ";" + [System.Environment]::GetEnvironmentVariable("Path","Machine")
```

**Q: 项目名称限制?**

A: 必须以字母开头,只包含字母和数字。如 `MyApp`、`OrderService2`。不能用 `123App` 或 `My-App`。

**Q: 如何在不同电脑使用?**

A: 每台电脑执行一次安装命令即可,模板从 GitHub 自动下载。

**Q: 公司网络无法访问 GitHub?**

A: 可以把仓库放到私有 GitLab/Gitee,修改 `install.ps1` 中的 `$ZipUrl`:

```powershell
# 原来的 GitHub URL
$ZipUrl = "https://github.com/$RepoOwner/$RepoName/archive/refs/heads/$Branch.zip"

# 改为 GitLab
$ZipUrl = "https://gitlab.com/$RepoOwner/$RepoName/-/archive/$Branch/$RepoName-$Branch.zip"
```

---

## 技术栈

- **框架**: ABP Framework 10.5.0-rc.2
- **运行时**: .NET 10.0
- **数据库**: PostgreSQL (EF Core)
- **依赖注入**: Autofac
- **API 文档**: Swagger

---

## License

MIT