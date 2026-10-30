# gbc：在 Grok Bot 里一句话（或语音）派活给 Mac 上的 Claude Code

**这是什么**：Grok Bot 里的一个小 bot（「终端遥控」），加上 Mac 上的一个脚本 `gbc`。你对 bot 说要干什么，它交给你 Mac 前台的 Claude Code 去做，做完用两三句话报给你。Claude 干活的过程开在一个终端窗口里，你随时能看。

**好在哪**
- 快：同一个小任务，经过终端遥控端到端约 38 秒，经过一个上下文很长的「大管家」bot 要约 184 秒。gbc 自己的开销约 0.4 秒。
- 一次调用拿回结果：发话、等 Claude 做完、取回复都在一条命令里，bot 不用反复截屏轮询。
- 上下文不会越用越慢：Claude 那边到 28% 自动写交接、开新对话（约 50 秒）；bot 自己按「换代」新建一个，不靠压缩。

**怎么装**（macOS，需要已装好 Claude Code）

```
curl -fsSL https://raw.githubusercontent.com/chennian080403/gbc/main/install.sh | zsh
```

它会把 gbc 装到 `~/bin`，补好 PATH，然后跑 `gbc doctor`。按 ❌ 后面的提示修，修到全部 ✅，再跑 `gbc doctor --full` 实测一轮。配置写在 `~/.config/gbc/config.zsh`，有哪些变量见 `gbc` 不带参数时打印的说明。

**建 bot**：[`终端遥控-Grok Bot设定.md`](终端遥控-Grok%20Bot设定.md) 是 Grok Bot 那头的设定，包括简介、11 条规则、第一次上手的自检引导、上下文满了怎么换代。把它整份发给你的 Grok Bot（或者让大管家照着建一个），它会带你装好 gbc，然后就能派活了。

**怎么用**

| 要做什么 | 命令（bot 替你跑） |
|---|---|
| 检查装好没有 | `gbc doctor`；实测一轮用 `gbc doctor --full` |
| 开一个 Claude 会话 | `gbc open ~/某个项目` |
| 派活并拿回结果 | `gbc send "任务" 120` |
| 长任务 | `gbc send -n "任务"`，再 `gbc wait 300` |
| 打断 / 看上下文 / 手动换新对话 | `gbc esc` / `gbc ctx` / `gbc jj` |
| 关掉 | `gbc close` |
