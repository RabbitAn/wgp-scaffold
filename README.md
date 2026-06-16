# WGP Scaffold

ABP Framework 最小化项目脚手架,一行命令安装,随处可用。

---

## 🚀 安装

只需执行一次:

**PowerShell:**
```powershell
irm https://raw.githubusercontent.com/RabbitAn/wgp-scaffold/main/install.ps1 | iex
```

**CMD:**
```cmd
powershell -ExecutionPolicy Bypass -c "irm https://raw.githubusercontent.com/RabbitAn/wgp-scaffold/main/install.ps1 | iex"
```

重启终端后,`wgp` 即可全局使用。

---

## 📦 使用

```bash
wgp new MyApp                  # 当前目录创建
wgp new MyApp -o D:\Projects   # 指定目录创建
wgp                            # 查看帮助
```

---

## 🗑️ 卸载

**PowerShell:**
```powershell
irm https://raw.githubusercontent.com/RabbitAn/wgp-scaffold/main/uninstall.ps1 | iex
```

**CMD:**
```cmd
powershell -ExecutionPolicy Bypass -c "irm https://raw.githubusercontent.com/RabbitAn/wgp-scaffold/main/uninstall.ps1 | iex"
```

---

## 🔄 更新到最新版本

重新安装即可(install 会自动覆盖旧版本):

```powershell
irm https://raw.githubusercontent.com/RabbitAn/wgp-scaffold/main/install.ps1 | iex
```

---

## 生成的项目结构

```
MyApp/
├── MyApp.Domain/                  # 领域层 - 实体、仓储接口
├── MyApp.Application.Contracts/   # 应用契约 - DTO、服务接口
├── MyApp.Application/             # 应用层 - 应用服务
├── MyApp.EntityFrameworkCore/     # 数据层 - 仓储实现
├── MyApp.Web/                     # Web 层 - API、配置
└── MyApp.sln
```

生成后:

```bash
cd MyApp
dotnet restore
dotnet build
dotnet run --project MyApp.Web
```

访问 `http://localhost:5213/swagger` 查看 API 文档。

---

## 自定义模板

修改 `template/` 目录,然后 `git push` 推送。其他机器重新安装即可获取更新。

模板中所有 `BoxAssembly` 字样会被自动替换为新项目名。

---

## 仓库结构

```
wgp-scaffold/
├── template/          # ABP 项目模板
├── wgp.bat            # CLI 命令入口
├── New-Project.ps1    # 核心生成脚本
├── install.ps1        # 安装脚本
├── uninstall.ps1      # 卸载脚本
└── README.md
```

---

## 常见问题

**Q: `wgp` 命令找不到?**
A: 安装后需**重启终端**。

**Q: 项目名称限制?**
A: 必须字母开头,仅含字母数字。如 `MyApp`、`OrderService2`。

**Q: 不同电脑如何使用?**
A: 每台电脑执行一次安装命令即可。

---

## 技术栈

ABP Framework 10.5 · .NET 10.0 · PostgreSQL · Autofac · Swagger

## License

MIT