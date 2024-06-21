# 💤 My LazyVim Config

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

- added clipboard (install xclip)
- added ripgrep
- added clangd


#### 解决 clipboard 不能用的问题

在Ubuntu上出现"ubuntu clipboard: No provider. Try"的问题通常是由于系统剪贴板服务出现错误或未正确配置引起的。这可能会导致无法正常使用剪贴板功能。

要解决这个问题，可以尝试重启剪贴板服务或者重新配置剪贴板服务。以下是一些可能的解决方法：

1. 在终端中输入以下命令以重启剪贴板服务：

```
sudo killall -9 gnome-shell || sudo killall -9 cinnamon-screensaver
```

1. 如果上述方法无效，可以尝试重新安装剪贴板服务：

```
sudo apt-get install --reinstall xclip xsel
```

1. 检查系统中是否安装了其他剪贴板管理器，并尝试禁用或卸载它们。

如果以上方法无效，您可能需要进一步调查问题的根本原因。您可以通过以下链接了解更多关于Ubuntu剪贴板的信息：

#### 解决无法全局搜索的问题

安装 ripgrep

#### 解决 clangd 不能检索问题

1. 安装 clangd
2. 安装 bear ，使用 bear -- make （接自己make的参数）


