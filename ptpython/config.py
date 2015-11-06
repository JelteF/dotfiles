__all__ = (
    'configure',
)


def configure(repl):
    repl.use_code_colorscheme('friendly')
    repl.enable_auto_suggest = True
    repl.enable_history_search = True
    repl.vi_mode = True
