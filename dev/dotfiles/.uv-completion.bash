_uv() {
    local i cur prev opts cmd
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    cmd=""
    opts=""

    for i in ${COMP_WORDS[@]}
    do
        case "${cmd},${i}" in
            ",$1")
                cmd="uv"
                ;;
            uv,add)
                cmd="uv__add"
                ;;
            uv,build)
                cmd="uv__build"
                ;;
            uv,build-backend)
                cmd="uv__build__backend"
                ;;
            uv,cache)
                cmd="uv__cache"
                ;;
            uv,clean)
                cmd="uv__clean"
                ;;
            uv,export)
                cmd="uv__export"
                ;;
            uv,generate-shell-completion)
                cmd="uv__generate__shell__completion"
                ;;
            uv,help)
                cmd="uv__help"
                ;;
            uv,init)
                cmd="uv__init"
                ;;
            uv,lock)
                cmd="uv__lock"
                ;;
            uv,pip)
                cmd="uv__pip"
                ;;
            uv,publish)
                cmd="uv__publish"
                ;;
            uv,python)
                cmd="uv__python"
                ;;
            uv,remove)
                cmd="uv__remove"
                ;;
            uv,run)
                cmd="uv__run"
                ;;
            uv,self)
                cmd="uv__self"
                ;;
            uv,sync)
                cmd="uv__sync"
                ;;
            uv,tool)
                cmd="uv__tool"
                ;;
            uv,tree)
                cmd="uv__tree"
                ;;
            uv,venv)
                cmd="uv__venv"
                ;;
            uv,version)
                cmd="uv__version"
                ;;
            uv__build__backend,build-editable)
                cmd="uv__build__backend__build__editable"
                ;;
            uv__build__backend,build-sdist)
                cmd="uv__build__backend__build__sdist"
                ;;
            uv__build__backend,build-wheel)
                cmd="uv__build__backend__build__wheel"
                ;;
            uv__build__backend,get-requires-for-build-editable)
                cmd="uv__build__backend__get__requires__for__build__editable"
                ;;
            uv__build__backend,get-requires-for-build-sdist)
                cmd="uv__build__backend__get__requires__for__build__sdist"
                ;;
            uv__build__backend,get-requires-for-build-wheel)
                cmd="uv__build__backend__get__requires__for__build__wheel"
                ;;
            uv__build__backend,prepare-metadata-for-build-editable)
                cmd="uv__build__backend__prepare__metadata__for__build__editable"
                ;;
            uv__build__backend,prepare-metadata-for-build-wheel)
                cmd="uv__build__backend__prepare__metadata__for__build__wheel"
                ;;
            uv__cache,clean)
                cmd="uv__cache__clean"
                ;;
            uv__cache,dir)
                cmd="uv__cache__dir"
                ;;
            uv__cache,prune)
                cmd="uv__cache__prune"
                ;;
            uv__pip,check)
                cmd="uv__pip__check"
                ;;
            uv__pip,compile)
                cmd="uv__pip__compile"
                ;;
            uv__pip,freeze)
                cmd="uv__pip__freeze"
                ;;
            uv__pip,install)
                cmd="uv__pip__install"
                ;;
            uv__pip,list)
                cmd="uv__pip__list"
                ;;
            uv__pip,show)
                cmd="uv__pip__show"
                ;;
            uv__pip,sync)
                cmd="uv__pip__sync"
                ;;
            uv__pip,tree)
                cmd="uv__pip__tree"
                ;;
            uv__pip,uninstall)
                cmd="uv__pip__uninstall"
                ;;
            uv__python,dir)
                cmd="uv__python__dir"
                ;;
            uv__python,find)
                cmd="uv__python__find"
                ;;
            uv__python,install)
                cmd="uv__python__install"
                ;;
            uv__python,list)
                cmd="uv__python__list"
                ;;
            uv__python,pin)
                cmd="uv__python__pin"
                ;;
            uv__python,uninstall)
                cmd="uv__python__uninstall"
                ;;
            uv__self,update)
                cmd="uv__self__update"
                ;;
            uv__self,version)
                cmd="uv__self__version"
                ;;
            uv__tool,dir)
                cmd="uv__tool__dir"
                ;;
            uv__tool,install)
                cmd="uv__tool__install"
                ;;
            uv__tool,list)
                cmd="uv__tool__list"
                ;;
            uv__tool,run)
                cmd="uv__tool__run"
                ;;
            uv__tool,uninstall)
                cmd="uv__tool__uninstall"
                ;;
            uv__tool,update-shell)
                cmd="uv__tool__update__shell"
                ;;
            uv__tool,upgrade)
                cmd="uv__tool__upgrade"
                ;;
            uv__tool,uvx)
                cmd="uv__tool__uvx"
                ;;
            *)
                ;;
        esac
    done

    case "${cmd}" in
        uv)
            opts="-n -q -v -h -V --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help --version run init add remove sync lock export tree tool python pip venv build publish build-backend cache self clean version generate-shell-completion help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__add)
            opts="-r -c -m -i -f -U -P -C -p -n -q -v -h --requirements --constraints --marker --dev --optional --group --editable --no-editable --raw-sources --rev --tag --branch --extra --no-sync --locked --frozen --active --no-active --index --default-index --index-url --extra-index-url --find-links --no-index --upgrade --no-upgrade --upgrade-package --reinstall --no-reinstall --reinstall-package --index-strategy --keyring-provider --resolution --prerelease --pre --fork-strategy --config-setting --no-build-isolation --no-build-isolation-package --build-isolation --exclude-newer --link-mode --compile-bytecode --no-compile-bytecode --no-sources --no-build --build --no-build-package --no-binary --binary --no-binary-package --refresh --no-refresh --refresh-package --package --script --python --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help [PACKAGES]..."
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --requirements)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -r)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --constraints)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -c)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --marker)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -m)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --optional)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --group)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --rev)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --tag)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --branch)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --extra)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --default-index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -i)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --extra-index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --find-links)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -f)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --upgrade-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -P)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --reinstall-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-strategy)
                    COMPREPLY=($(compgen -W "first-index unsafe-first-match unsafe-best-match" -- "${cur}"))
                    return 0
                    ;;
                --keyring-provider)
                    COMPREPLY=($(compgen -W "disabled subprocess" -- "${cur}"))
                    return 0
                    ;;
                --resolution)
                    COMPREPLY=($(compgen -W "highest lowest lowest-direct" -- "${cur}"))
                    return 0
                    ;;
                --prerelease)
                    COMPREPLY=($(compgen -W "disallow allow if-necessary explicit if-necessary-or-explicit" -- "${cur}"))
                    return 0
                    ;;
                --fork-strategy)
                    COMPREPLY=($(compgen -W "fewest requires-python" -- "${cur}"))
                    return 0
                    ;;
                --config-setting)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -C)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-build-isolation-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --exclude-newer)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --link-mode)
                    COMPREPLY=($(compgen -W "clone copy hardlink symlink" -- "${cur}"))
                    return 0
                    ;;
                --no-build-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-binary-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --refresh-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --script)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -p)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__build)
            opts="-o -b -p -i -f -U -P -C -n -q -v -h --package --all-packages --out-dir --sdist --wheel --list --build-logs --no-build-logs --force-pep517 --build-constraints --require-hashes --no-require-hashes --verify-hashes --no-verify-hashes --python --index --default-index --index-url --extra-index-url --find-links --no-index --upgrade --no-upgrade --upgrade-package --index-strategy --keyring-provider --resolution --prerelease --pre --fork-strategy --config-setting --no-build-isolation --no-build-isolation-package --build-isolation --exclude-newer --link-mode --no-sources --no-build --build --no-build-package --no-binary --binary --no-binary-package --refresh --no-refresh --refresh-package --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help [SRC]"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --out-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -o)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --build-constraints)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -b)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -p)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --default-index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -i)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --extra-index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --find-links)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -f)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --upgrade-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -P)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-strategy)
                    COMPREPLY=($(compgen -W "first-index unsafe-first-match unsafe-best-match" -- "${cur}"))
                    return 0
                    ;;
                --keyring-provider)
                    COMPREPLY=($(compgen -W "disabled subprocess" -- "${cur}"))
                    return 0
                    ;;
                --resolution)
                    COMPREPLY=($(compgen -W "highest lowest lowest-direct" -- "${cur}"))
                    return 0
                    ;;
                --prerelease)
                    COMPREPLY=($(compgen -W "disallow allow if-necessary explicit if-necessary-or-explicit" -- "${cur}"))
                    return 0
                    ;;
                --fork-strategy)
                    COMPREPLY=($(compgen -W "fewest requires-python" -- "${cur}"))
                    return 0
                    ;;
                --config-setting)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -C)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-build-isolation-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --exclude-newer)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --link-mode)
                    COMPREPLY=($(compgen -W "clone copy hardlink symlink" -- "${cur}"))
                    return 0
                    ;;
                --no-build-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-binary-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --refresh-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__build__backend)
            opts="-n -q -v -h --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help build-sdist build-wheel build-editable get-requires-for-build-sdist get-requires-for-build-wheel prepare-metadata-for-build-wheel get-requires-for-build-editable prepare-metadata-for-build-editable"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__build__backend__build__editable)
            opts="-n -q -v -h --metadata-directory --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help <WHEEL_DIRECTORY>"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --metadata-directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__build__backend__build__sdist)
            opts="-n -q -v -h --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help <SDIST_DIRECTORY>"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__build__backend__build__wheel)
            opts="-n -q -v -h --metadata-directory --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help <WHEEL_DIRECTORY>"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --metadata-directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__build__backend__get__requires__for__build__editable)
            opts="-n -q -v -h --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__build__backend__get__requires__for__build__sdist)
            opts="-n -q -v -h --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__build__backend__get__requires__for__build__wheel)
            opts="-n -q -v -h --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__build__backend__prepare__metadata__for__build__editable)
            opts="-n -q -v -h --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help <WHEEL_DIRECTORY>"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__build__backend__prepare__metadata__for__build__wheel)
            opts="-n -q -v -h --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help <WHEEL_DIRECTORY>"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__cache)
            opts="-n -q -v -h --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help clean prune dir"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__cache__clean)
            opts="-n -q -v -h --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help [PACKAGE]..."
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__cache__dir)
            opts="-n -q -v -h --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__cache__prune)
            opts="-n -q -v -h --ci --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__clean)
            opts="-n -q -v -h --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help [PACKAGE]..."
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__export)
            opts="-o -i -f -U -P -C -p -n -q -v -h --format --all-packages --package --prune --extra --all-extras --no-extra --no-all-extras --dev --no-dev --only-dev --group --no-group --no-default-groups --only-group --all-groups --no-annotate --annotate --no-header --header --no-editable --hashes --no-hashes --output-file --no-emit-project --no-emit-workspace --no-emit-package --locked --frozen --index --default-index --index-url --extra-index-url --find-links --no-index --upgrade --no-upgrade --upgrade-package --index-strategy --keyring-provider --resolution --prerelease --pre --fork-strategy --config-setting --no-build-isolation --no-build-isolation-package --build-isolation --exclude-newer --link-mode --no-sources --no-build --build --no-build-package --no-binary --binary --no-binary-package --refresh --no-refresh --refresh-package --script --python --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --format)
                    COMPREPLY=($(compgen -W "requirements.txt pylock.toml" -- "${cur}"))
                    return 0
                    ;;
                --package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --prune)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --extra)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-extra)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --group)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-group)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --only-group)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --output-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -o)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-emit-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --default-index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -i)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --extra-index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --find-links)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -f)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --upgrade-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -P)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-strategy)
                    COMPREPLY=($(compgen -W "first-index unsafe-first-match unsafe-best-match" -- "${cur}"))
                    return 0
                    ;;
                --keyring-provider)
                    COMPREPLY=($(compgen -W "disabled subprocess" -- "${cur}"))
                    return 0
                    ;;
                --resolution)
                    COMPREPLY=($(compgen -W "highest lowest lowest-direct" -- "${cur}"))
                    return 0
                    ;;
                --prerelease)
                    COMPREPLY=($(compgen -W "disallow allow if-necessary explicit if-necessary-or-explicit" -- "${cur}"))
                    return 0
                    ;;
                --fork-strategy)
                    COMPREPLY=($(compgen -W "fewest requires-python" -- "${cur}"))
                    return 0
                    ;;
                --config-setting)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -C)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-build-isolation-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --exclude-newer)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --link-mode)
                    COMPREPLY=($(compgen -W "clone copy hardlink symlink" -- "${cur}"))
                    return 0
                    ;;
                --no-build-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-binary-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --refresh-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --script)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -p)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__generate__shell__completion)
            opts="-n -q -v -h -V --no-cache --cache-dir --python-preference --no-python-downloads --quiet --verbose --color --native-tls --offline --no-progress --config-file --no-config --help --version --managed-python --no-managed-python --allow-python-downloads --python-fetch --no-color --no-native-tls --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-installer-metadata --directory --project bash elvish fish nushell powershell zsh"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__help)
            opts="-n -q -v -h --no-pager --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help [COMMAND]..."
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__init)
            opts="-p -n -q -v -h --name --bare --virtual --package --no-package --app --lib --script --description --no-description --vcs --build-backend --backend --no-readme --author-from --no-pin-python --pin-python --no-workspace --python --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help [PATH]"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --name)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --description)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --vcs)
                    COMPREPLY=($(compgen -W "git none" -- "${cur}"))
                    return 0
                    ;;
                --build-backend)
                    COMPREPLY=($(compgen -W "hatch flit pdm poetry setuptools maturin scikit" -- "${cur}"))
                    return 0
                    ;;
                --author-from)
                    COMPREPLY=($(compgen -W "auto git none" -- "${cur}"))
                    return 0
                    ;;
                --python)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -p)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__lock)
            opts="-i -f -U -P -C -p -n -q -v -h --check --check-exists --dry-run --script --index --default-index --index-url --extra-index-url --find-links --no-index --upgrade --no-upgrade --upgrade-package --index-strategy --keyring-provider --resolution --prerelease --pre --fork-strategy --config-setting --no-build-isolation --no-build-isolation-package --build-isolation --exclude-newer --link-mode --no-sources --no-build --build --no-build-package --no-binary --binary --no-binary-package --refresh --no-refresh --refresh-package --python --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --script)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --default-index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -i)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --extra-index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --find-links)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -f)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --upgrade-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -P)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-strategy)
                    COMPREPLY=($(compgen -W "first-index unsafe-first-match unsafe-best-match" -- "${cur}"))
                    return 0
                    ;;
                --keyring-provider)
                    COMPREPLY=($(compgen -W "disabled subprocess" -- "${cur}"))
                    return 0
                    ;;
                --resolution)
                    COMPREPLY=($(compgen -W "highest lowest lowest-direct" -- "${cur}"))
                    return 0
                    ;;
                --prerelease)
                    COMPREPLY=($(compgen -W "disallow allow if-necessary explicit if-necessary-or-explicit" -- "${cur}"))
                    return 0
                    ;;
                --fork-strategy)
                    COMPREPLY=($(compgen -W "fewest requires-python" -- "${cur}"))
                    return 0
                    ;;
                --config-setting)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -C)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-build-isolation-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --exclude-newer)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --link-mode)
                    COMPREPLY=($(compgen -W "clone copy hardlink symlink" -- "${cur}"))
                    return 0
                    ;;
                --no-build-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-binary-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --refresh-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -p)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__pip)
            opts="-n -q -v -h --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help compile sync install uninstall freeze list show tree check"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__pip__check)
            opts="-p -n -q -v -h --python --system --no-system --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --python)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -p)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__pip__compile)
            opts="-c -b -i -f -U -P -C -o -p -n -q -v -h --constraints --overrides --build-constraints --extra --all-extras --no-all-extras --index --default-index --index-url --extra-index-url --find-links --no-index --upgrade --no-upgrade --upgrade-package --index-strategy --keyring-provider --resolution --prerelease --pre --fork-strategy --config-setting --no-build-isolation --no-build-isolation-package --build-isolation --exclude-newer --link-mode --no-sources --refresh --no-refresh --refresh-package --no-deps --deps --group --output-file --format --no-strip-extras --strip-extras --no-strip-markers --strip-markers --no-annotate --annotate --no-header --header --annotation-style --custom-compile-command --python --system --no-system --generate-hashes --no-generate-hashes --no-build --build --no-binary --only-binary --python-version --python-platform --universal --no-universal --no-emit-package --emit-index-url --no-emit-index-url --emit-find-links --no-emit-find-links --emit-build-options --no-emit-build-options --emit-marker-expression --no-emit-marker-expression --emit-index-annotation --no-emit-index-annotation --torch-backend --allow-unsafe --no-allow-unsafe --reuse-hashes --no-reuse-hashes --resolver --max-rounds --cert --client-cert --emit-trusted-host --no-emit-trusted-host --config --no-config --emit-options --no-emit-options --pip-args --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --help [SRC_FILE]..."
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --constraints)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -c)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --overrides)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --build-constraints)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -b)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --extra)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --default-index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -i)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --extra-index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --find-links)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -f)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --upgrade-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -P)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-strategy)
                    COMPREPLY=($(compgen -W "first-index unsafe-first-match unsafe-best-match" -- "${cur}"))
                    return 0
                    ;;
                --keyring-provider)
                    COMPREPLY=($(compgen -W "disabled subprocess" -- "${cur}"))
                    return 0
                    ;;
                --resolution)
                    COMPREPLY=($(compgen -W "highest lowest lowest-direct" -- "${cur}"))
                    return 0
                    ;;
                --prerelease)
                    COMPREPLY=($(compgen -W "disallow allow if-necessary explicit if-necessary-or-explicit" -- "${cur}"))
                    return 0
                    ;;
                --fork-strategy)
                    COMPREPLY=($(compgen -W "fewest requires-python" -- "${cur}"))
                    return 0
                    ;;
                --config-setting)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -C)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-build-isolation-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --exclude-newer)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --link-mode)
                    COMPREPLY=($(compgen -W "clone copy hardlink symlink" -- "${cur}"))
                    return 0
                    ;;
                --refresh-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --group)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --output-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -o)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --format)
                    COMPREPLY=($(compgen -W "requirements.txt pylock.toml" -- "${cur}"))
                    return 0
                    ;;
                --annotation-style)
                    COMPREPLY=($(compgen -W "line split" -- "${cur}"))
                    return 0
                    ;;
                --custom-compile-command)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -p)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-binary)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --only-binary)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-version)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-platform)
                    COMPREPLY=($(compgen -W "windows linux macos x86_64-pc-windows-msvc i686-pc-windows-msvc x86_64-unknown-linux-gnu aarch64-apple-darwin x86_64-apple-darwin aarch64-unknown-linux-gnu aarch64-unknown-linux-musl x86_64-unknown-linux-musl x86_64-manylinux2014 x86_64-manylinux_2_17 x86_64-manylinux_2_28 x86_64-manylinux_2_31 x86_64-manylinux_2_32 x86_64-manylinux_2_33 x86_64-manylinux_2_34 x86_64-manylinux_2_35 x86_64-manylinux_2_36 x86_64-manylinux_2_37 x86_64-manylinux_2_38 x86_64-manylinux_2_39 x86_64-manylinux_2_40 aarch64-manylinux2014 aarch64-manylinux_2_17 aarch64-manylinux_2_28 aarch64-manylinux_2_31 aarch64-manylinux_2_32 aarch64-manylinux_2_33 aarch64-manylinux_2_34 aarch64-manylinux_2_35 aarch64-manylinux_2_36 aarch64-manylinux_2_37 aarch64-manylinux_2_38 aarch64-manylinux_2_39 aarch64-manylinux_2_40" -- "${cur}"))
                    return 0
                    ;;
                --no-emit-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --torch-backend)
                    COMPREPLY=($(compgen -W "auto cpu cu128 cu126 cu125 cu124 cu123 cu122 cu121 cu120 cu118 cu117 cu116 cu115 cu114 cu113 cu112 cu111 cu110 cu102 cu101 cu100 cu92 cu91 cu90 cu80" -- "${cur}"))
                    return 0
                    ;;
                --resolver)
                    COMPREPLY=($(compgen -W "backtracking legacy" -- "${cur}"))
                    return 0
                    ;;
                --max-rounds)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cert)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --client-cert)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --pip-args)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__pip__freeze)
            opts="-p -n -q -v -h --exclude-editable --strict --no-strict --python --path --system --no-system --disable-pip-version-check --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --python)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -p)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__pip__install)
            opts="-r -e -c -b -i -f -U -P -C -p -n -q -v -h --requirements --editable --constraints --overrides --build-constraints --extra --all-extras --no-all-extras --index --default-index --index-url --extra-index-url --find-links --no-index --upgrade --no-upgrade --upgrade-package --reinstall --no-reinstall --reinstall-package --index-strategy --keyring-provider --resolution --prerelease --pre --fork-strategy --config-setting --no-build-isolation --no-build-isolation-package --build-isolation --exclude-newer --link-mode --compile-bytecode --no-compile-bytecode --no-sources --refresh --no-refresh --refresh-package --no-deps --deps --group --require-hashes --no-require-hashes --verify-hashes --no-verify-hashes --python --system --no-system --break-system-packages --no-break-system-packages --target --prefix --no-build --build --no-binary --only-binary --python-version --python-platform --inexact --exact --strict --no-strict --dry-run --torch-backend --disable-pip-version-check --user --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help [PACKAGE]..."
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --requirements)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -r)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --editable)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -e)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --constraints)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -c)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --overrides)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --build-constraints)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -b)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --extra)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --default-index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -i)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --extra-index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --find-links)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -f)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --upgrade-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -P)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --reinstall-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-strategy)
                    COMPREPLY=($(compgen -W "first-index unsafe-first-match unsafe-best-match" -- "${cur}"))
                    return 0
                    ;;
                --keyring-provider)
                    COMPREPLY=($(compgen -W "disabled subprocess" -- "${cur}"))
                    return 0
                    ;;
                --resolution)
                    COMPREPLY=($(compgen -W "highest lowest lowest-direct" -- "${cur}"))
                    return 0
                    ;;
                --prerelease)
                    COMPREPLY=($(compgen -W "disallow allow if-necessary explicit if-necessary-or-explicit" -- "${cur}"))
                    return 0
                    ;;
                --fork-strategy)
                    COMPREPLY=($(compgen -W "fewest requires-python" -- "${cur}"))
                    return 0
                    ;;
                --config-setting)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -C)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-build-isolation-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --exclude-newer)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --link-mode)
                    COMPREPLY=($(compgen -W "clone copy hardlink symlink" -- "${cur}"))
                    return 0
                    ;;
                --refresh-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --group)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -p)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --target)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --prefix)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-binary)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --only-binary)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-version)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-platform)
                    COMPREPLY=($(compgen -W "windows linux macos x86_64-pc-windows-msvc i686-pc-windows-msvc x86_64-unknown-linux-gnu aarch64-apple-darwin x86_64-apple-darwin aarch64-unknown-linux-gnu aarch64-unknown-linux-musl x86_64-unknown-linux-musl x86_64-manylinux2014 x86_64-manylinux_2_17 x86_64-manylinux_2_28 x86_64-manylinux_2_31 x86_64-manylinux_2_32 x86_64-manylinux_2_33 x86_64-manylinux_2_34 x86_64-manylinux_2_35 x86_64-manylinux_2_36 x86_64-manylinux_2_37 x86_64-manylinux_2_38 x86_64-manylinux_2_39 x86_64-manylinux_2_40 aarch64-manylinux2014 aarch64-manylinux_2_17 aarch64-manylinux_2_28 aarch64-manylinux_2_31 aarch64-manylinux_2_32 aarch64-manylinux_2_33 aarch64-manylinux_2_34 aarch64-manylinux_2_35 aarch64-manylinux_2_36 aarch64-manylinux_2_37 aarch64-manylinux_2_38 aarch64-manylinux_2_39 aarch64-manylinux_2_40" -- "${cur}"))
                    return 0
                    ;;
                --torch-backend)
                    COMPREPLY=($(compgen -W "auto cpu cu128 cu126 cu125 cu124 cu123 cu122 cu121 cu120 cu118 cu117 cu116 cu115 cu114 cu113 cu112 cu111 cu110 cu102 cu101 cu100 cu92 cu91 cu90 cu80" -- "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__pip__list)
            opts="-e -i -f -p -n -q -v -h --editable --exclude-editable --exclude --format --outdated --no-outdated --strict --no-strict --index --default-index --index-url --extra-index-url --find-links --no-index --index-strategy --keyring-provider --exclude-newer --python --system --no-system --disable-pip-version-check --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --exclude)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --format)
                    COMPREPLY=($(compgen -W "columns freeze json" -- "${cur}"))
                    return 0
                    ;;
                --index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --default-index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -i)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --extra-index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --find-links)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -f)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-strategy)
                    COMPREPLY=($(compgen -W "first-index unsafe-first-match unsafe-best-match" -- "${cur}"))
                    return 0
                    ;;
                --keyring-provider)
                    COMPREPLY=($(compgen -W "disabled subprocess" -- "${cur}"))
                    return 0
                    ;;
                --exclude-newer)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -p)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__pip__show)
            opts="-f -p -n -q -v -h --strict --no-strict --files --python --system --no-system --disable-pip-version-check --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help [PACKAGE]..."
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --python)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -p)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__pip__sync)
            opts="-c -b -i -f -C -p -a -n -q -v -h --constraints --build-constraints --index --default-index --index-url --extra-index-url --find-links --no-index --reinstall --no-reinstall --reinstall-package --index-strategy --keyring-provider --config-setting --no-build-isolation --build-isolation --exclude-newer --link-mode --compile-bytecode --no-compile-bytecode --no-sources --refresh --no-refresh --refresh-package --require-hashes --no-require-hashes --verify-hashes --no-verify-hashes --python --system --no-system --break-system-packages --no-break-system-packages --target --prefix --no-build --build --no-binary --only-binary --allow-empty-requirements --no-allow-empty-requirements --python-version --python-platform --strict --no-strict --dry-run --torch-backend --ask --python-executable --user --cert --client-cert --config --no-config --pip-args --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --help <SRC_FILE>..."
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --constraints)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -c)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --build-constraints)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -b)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --default-index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -i)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --extra-index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --find-links)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -f)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --reinstall-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-strategy)
                    COMPREPLY=($(compgen -W "first-index unsafe-first-match unsafe-best-match" -- "${cur}"))
                    return 0
                    ;;
                --keyring-provider)
                    COMPREPLY=($(compgen -W "disabled subprocess" -- "${cur}"))
                    return 0
                    ;;
                --config-setting)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -C)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --exclude-newer)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --link-mode)
                    COMPREPLY=($(compgen -W "clone copy hardlink symlink" -- "${cur}"))
                    return 0
                    ;;
                --refresh-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -p)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --target)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --prefix)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-binary)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --only-binary)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-version)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-platform)
                    COMPREPLY=($(compgen -W "windows linux macos x86_64-pc-windows-msvc i686-pc-windows-msvc x86_64-unknown-linux-gnu aarch64-apple-darwin x86_64-apple-darwin aarch64-unknown-linux-gnu aarch64-unknown-linux-musl x86_64-unknown-linux-musl x86_64-manylinux2014 x86_64-manylinux_2_17 x86_64-manylinux_2_28 x86_64-manylinux_2_31 x86_64-manylinux_2_32 x86_64-manylinux_2_33 x86_64-manylinux_2_34 x86_64-manylinux_2_35 x86_64-manylinux_2_36 x86_64-manylinux_2_37 x86_64-manylinux_2_38 x86_64-manylinux_2_39 x86_64-manylinux_2_40 aarch64-manylinux2014 aarch64-manylinux_2_17 aarch64-manylinux_2_28 aarch64-manylinux_2_31 aarch64-manylinux_2_32 aarch64-manylinux_2_33 aarch64-manylinux_2_34 aarch64-manylinux_2_35 aarch64-manylinux_2_36 aarch64-manylinux_2_37 aarch64-manylinux_2_38 aarch64-manylinux_2_39 aarch64-manylinux_2_40" -- "${cur}"))
                    return 0
                    ;;
                --torch-backend)
                    COMPREPLY=($(compgen -W "auto cpu cu128 cu126 cu125 cu124 cu123 cu122 cu121 cu120 cu118 cu117 cu116 cu115 cu114 cu113 cu112 cu111 cu110 cu102 cu101 cu100 cu92 cu91 cu90 cu80" -- "${cur}"))
                    return 0
                    ;;
                --python-executable)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cert)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --client-cert)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --pip-args)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__pip__tree)
            opts="-d -i -f -p -n -q -v -h --show-version-specifiers --depth --prune --package --no-dedupe --invert --outdated --strict --no-strict --index --default-index --index-url --extra-index-url --find-links --no-index --index-strategy --keyring-provider --exclude-newer --python --system --no-system --disable-pip-version-check --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --depth)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -d)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --prune)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --default-index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -i)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --extra-index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --find-links)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -f)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-strategy)
                    COMPREPLY=($(compgen -W "first-index unsafe-first-match unsafe-best-match" -- "${cur}"))
                    return 0
                    ;;
                --keyring-provider)
                    COMPREPLY=($(compgen -W "disabled subprocess" -- "${cur}"))
                    return 0
                    ;;
                --exclude-newer)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -p)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__pip__uninstall)
            opts="-r -p -n -q -v -h --requirements --python --keyring-provider --system --no-system --break-system-packages --no-break-system-packages --target --prefix --dry-run --disable-pip-version-check --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help [PACKAGE]..."
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --requirements)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -r)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -p)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --keyring-provider)
                    COMPREPLY=($(compgen -W "disabled subprocess" -- "${cur}"))
                    return 0
                    ;;
                --target)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --prefix)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__publish)
            opts="-u -p -t -n -q -v -h --index --username --password --token --trusted-publishing --keyring-provider --publish-url --check-url --skip-existing --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help [FILES]..."
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --username)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -u)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --password)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -p)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --token)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -t)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --trusted-publishing)
                    COMPREPLY=($(compgen -W "automatic always never" -- "${cur}"))
                    return 0
                    ;;
                --keyring-provider)
                    COMPREPLY=($(compgen -W "disabled subprocess" -- "${cur}"))
                    return 0
                    ;;
                --publish-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --check-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__python)
            opts="-n -q -v -h --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help list install find pin dir uninstall"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__python__dir)
            opts="-n -q -v -h --bin --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__python__find)
            opts="-n -q -v -h --no-project --system --no-system --script --show-version --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help [REQUEST]"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --script)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__python__install)
            opts="-i -r -f -n -q -v -h --install-dir --mirror --pypy-mirror --reinstall --force --default --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help [TARGETS]..."
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --install-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -i)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --mirror)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --pypy-mirror)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__python__list)
            opts="-n -q -v -h --all-versions --all-platforms --all-arches --only-installed --only-downloads --show-urls --output-format --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help [REQUEST]"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --output-format)
                    COMPREPLY=($(compgen -W "text json" -- "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__python__pin)
            opts="-n -q -v -h --resolved --no-resolved --no-project --global --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help [REQUEST]"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__python__uninstall)
            opts="-i -n -q -v -h --install-dir --all --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help <TARGETS>..."
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --install-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -i)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__remove)
            opts="-i -f -U -P -C -p -n -q -v -h --dev --optional --group --no-sync --active --no-active --locked --frozen --index --default-index --index-url --extra-index-url --find-links --no-index --upgrade --no-upgrade --upgrade-package --reinstall --no-reinstall --reinstall-package --index-strategy --keyring-provider --resolution --prerelease --pre --fork-strategy --config-setting --no-build-isolation --no-build-isolation-package --build-isolation --exclude-newer --link-mode --compile-bytecode --no-compile-bytecode --no-sources --no-build --build --no-build-package --no-binary --binary --no-binary-package --refresh --no-refresh --refresh-package --package --script --python --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help <PACKAGES>..."
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --optional)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --group)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --default-index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -i)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --extra-index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --find-links)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -f)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --upgrade-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -P)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --reinstall-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-strategy)
                    COMPREPLY=($(compgen -W "first-index unsafe-first-match unsafe-best-match" -- "${cur}"))
                    return 0
                    ;;
                --keyring-provider)
                    COMPREPLY=($(compgen -W "disabled subprocess" -- "${cur}"))
                    return 0
                    ;;
                --resolution)
                    COMPREPLY=($(compgen -W "highest lowest lowest-direct" -- "${cur}"))
                    return 0
                    ;;
                --prerelease)
                    COMPREPLY=($(compgen -W "disallow allow if-necessary explicit if-necessary-or-explicit" -- "${cur}"))
                    return 0
                    ;;
                --fork-strategy)
                    COMPREPLY=($(compgen -W "fewest requires-python" -- "${cur}"))
                    return 0
                    ;;
                --config-setting)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -C)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-build-isolation-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --exclude-newer)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --link-mode)
                    COMPREPLY=($(compgen -W "clone copy hardlink symlink" -- "${cur}"))
                    return 0
                    ;;
                --no-build-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-binary-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --refresh-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --script)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -p)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__run)
            opts="-m -s -i -f -U -P -C -p -n -q -v -h --extra --all-extras --no-extra --no-all-extras --dev --no-dev --group --no-group --no-default-groups --only-group --all-groups --module --only-dev --no-editable --inexact --exact --env-file --no-env-file --with --with-editable --with-requirements --isolated --active --no-active --no-sync --locked --frozen --script --gui-script --index --default-index --index-url --extra-index-url --find-links --no-index --upgrade --no-upgrade --upgrade-package --reinstall --no-reinstall --reinstall-package --index-strategy --keyring-provider --resolution --prerelease --pre --fork-strategy --config-setting --no-build-isolation --no-build-isolation-package --build-isolation --exclude-newer --link-mode --compile-bytecode --no-compile-bytecode --no-sources --no-build --build --no-build-package --no-binary --binary --no-binary-package --refresh --no-refresh --refresh-package --all-packages --package --no-project --python --show-resolution --max-recursion-depth --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --extra)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-extra)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --group)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-group)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --only-group)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --env-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --with)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --with-editable)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --with-requirements)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --default-index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -i)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --extra-index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --find-links)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -f)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --upgrade-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -P)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --reinstall-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-strategy)
                    COMPREPLY=($(compgen -W "first-index unsafe-first-match unsafe-best-match" -- "${cur}"))
                    return 0
                    ;;
                --keyring-provider)
                    COMPREPLY=($(compgen -W "disabled subprocess" -- "${cur}"))
                    return 0
                    ;;
                --resolution)
                    COMPREPLY=($(compgen -W "highest lowest lowest-direct" -- "${cur}"))
                    return 0
                    ;;
                --prerelease)
                    COMPREPLY=($(compgen -W "disallow allow if-necessary explicit if-necessary-or-explicit" -- "${cur}"))
                    return 0
                    ;;
                --fork-strategy)
                    COMPREPLY=($(compgen -W "fewest requires-python" -- "${cur}"))
                    return 0
                    ;;
                --config-setting)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -C)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-build-isolation-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --exclude-newer)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --link-mode)
                    COMPREPLY=($(compgen -W "clone copy hardlink symlink" -- "${cur}"))
                    return 0
                    ;;
                --no-build-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-binary-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --refresh-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -p)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-recursion-depth)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__self)
            opts="-n -q -v -h --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help update version"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__self__update)
            opts="-n -q -v -h --token --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help [TARGET_VERSION]"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --token)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__self__version)
            opts="-n -q -v -h --short --output-format --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --output-format)
                    COMPREPLY=($(compgen -W "text json" -- "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__sync)
            opts="-i -f -U -P -C -p -n -q -v -h --extra --all-extras --no-extra --no-all-extras --dev --no-dev --only-dev --group --no-group --no-default-groups --only-group --all-groups --no-editable --inexact --exact --active --no-active --no-install-project --no-install-workspace --no-install-package --locked --frozen --dry-run --index --default-index --index-url --extra-index-url --find-links --no-index --upgrade --no-upgrade --upgrade-package --reinstall --no-reinstall --reinstall-package --index-strategy --keyring-provider --resolution --prerelease --pre --fork-strategy --config-setting --no-build-isolation --no-build-isolation-package --build-isolation --exclude-newer --link-mode --compile-bytecode --no-compile-bytecode --no-sources --no-build --build --no-build-package --no-binary --binary --no-binary-package --refresh --no-refresh --refresh-package --all-packages --package --script --python --check --no-check --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --extra)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-extra)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --group)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-group)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --only-group)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-install-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --default-index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -i)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --extra-index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --find-links)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -f)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --upgrade-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -P)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --reinstall-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-strategy)
                    COMPREPLY=($(compgen -W "first-index unsafe-first-match unsafe-best-match" -- "${cur}"))
                    return 0
                    ;;
                --keyring-provider)
                    COMPREPLY=($(compgen -W "disabled subprocess" -- "${cur}"))
                    return 0
                    ;;
                --resolution)
                    COMPREPLY=($(compgen -W "highest lowest lowest-direct" -- "${cur}"))
                    return 0
                    ;;
                --prerelease)
                    COMPREPLY=($(compgen -W "disallow allow if-necessary explicit if-necessary-or-explicit" -- "${cur}"))
                    return 0
                    ;;
                --fork-strategy)
                    COMPREPLY=($(compgen -W "fewest requires-python" -- "${cur}"))
                    return 0
                    ;;
                --config-setting)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -C)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-build-isolation-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --exclude-newer)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --link-mode)
                    COMPREPLY=($(compgen -W "clone copy hardlink symlink" -- "${cur}"))
                    return 0
                    ;;
                --no-build-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-binary-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --refresh-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --script)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -p)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__tool)
            opts="-n -q -v -h --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help run uvx install upgrade list uninstall update-shell dir"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__tool__dir)
            opts="-n -q -v -h --bin --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__tool__install)
            opts="-e -c -b -i -f -U -P -C -p -n -q -v -h --from --with --with-requirements --editable --with-editable --constraints --overrides --build-constraints --index --default-index --index-url --extra-index-url --find-links --no-index --upgrade --no-upgrade --upgrade-package --reinstall --no-reinstall --reinstall-package --index-strategy --keyring-provider --resolution --prerelease --pre --fork-strategy --config-setting --no-build-isolation --no-build-isolation-package --build-isolation --exclude-newer --link-mode --compile-bytecode --no-compile-bytecode --no-sources --no-build --build --no-build-package --no-binary --binary --no-binary-package --refresh --no-refresh --refresh-package --force --python --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help <PACKAGE>"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --from)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --with)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --with-requirements)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --with-editable)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --constraints)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -c)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --overrides)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --build-constraints)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -b)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --default-index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -i)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --extra-index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --find-links)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -f)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --upgrade-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -P)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --reinstall-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-strategy)
                    COMPREPLY=($(compgen -W "first-index unsafe-first-match unsafe-best-match" -- "${cur}"))
                    return 0
                    ;;
                --keyring-provider)
                    COMPREPLY=($(compgen -W "disabled subprocess" -- "${cur}"))
                    return 0
                    ;;
                --resolution)
                    COMPREPLY=($(compgen -W "highest lowest lowest-direct" -- "${cur}"))
                    return 0
                    ;;
                --prerelease)
                    COMPREPLY=($(compgen -W "disallow allow if-necessary explicit if-necessary-or-explicit" -- "${cur}"))
                    return 0
                    ;;
                --fork-strategy)
                    COMPREPLY=($(compgen -W "fewest requires-python" -- "${cur}"))
                    return 0
                    ;;
                --config-setting)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -C)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-build-isolation-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --exclude-newer)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --link-mode)
                    COMPREPLY=($(compgen -W "clone copy hardlink symlink" -- "${cur}"))
                    return 0
                    ;;
                --no-build-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-binary-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --refresh-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -p)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__tool__list)
            opts="-n -q -v -h --show-paths --show-version-specifiers --python-preference --no-python-downloads --no-cache --cache-dir --managed-python --no-managed-python --allow-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__tool__run)
            opts="-c -b -i -f -U -P -C -p -n -q -v -h --from --with --with-editable --with-requirements --constraints --build-constraints --overrides --isolated --env-file --no-env-file --index --default-index --index-url --extra-index-url --find-links --no-index --upgrade --no-upgrade --upgrade-package --reinstall --no-reinstall --reinstall-package --index-strategy --keyring-provider --resolution --prerelease --pre --fork-strategy --config-setting --no-build-isolation --no-build-isolation-package --build-isolation --exclude-newer --link-mode --compile-bytecode --no-compile-bytecode --no-sources --no-build --build --no-build-package --no-binary --binary --no-binary-package --refresh --no-refresh --refresh-package --python --show-resolution --generate-shell-completion --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --from)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --with)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --with-editable)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --with-requirements)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --constraints)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -c)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --build-constraints)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -b)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --overrides)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --env-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --default-index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -i)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --extra-index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --find-links)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -f)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --upgrade-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -P)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --reinstall-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-strategy)
                    COMPREPLY=($(compgen -W "first-index unsafe-first-match unsafe-best-match" -- "${cur}"))
                    return 0
                    ;;
                --keyring-provider)
                    COMPREPLY=($(compgen -W "disabled subprocess" -- "${cur}"))
                    return 0
                    ;;
                --resolution)
                    COMPREPLY=($(compgen -W "highest lowest lowest-direct" -- "${cur}"))
                    return 0
                    ;;
                --prerelease)
                    COMPREPLY=($(compgen -W "disallow allow if-necessary explicit if-necessary-or-explicit" -- "${cur}"))
                    return 0
                    ;;
                --fork-strategy)
                    COMPREPLY=($(compgen -W "fewest requires-python" -- "${cur}"))
                    return 0
                    ;;
                --config-setting)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -C)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-build-isolation-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --exclude-newer)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --link-mode)
                    COMPREPLY=($(compgen -W "clone copy hardlink symlink" -- "${cur}"))
                    return 0
                    ;;
                --no-build-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-binary-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --refresh-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -p)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --generate-shell-completion)
                    COMPREPLY=($(compgen -W "bash elvish fish nushell powershell zsh" -- "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__tool__uninstall)
            opts="-n -q -v -h --all --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help <NAME>..."
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__tool__update__shell)
            opts="-n -q -v -h --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__tool__upgrade)
            opts="-p -U -P -i -f -C -n -q -v -h --all --python --upgrade --upgrade-package --index --default-index --index-url --extra-index-url --find-links --no-index --reinstall --no-reinstall --reinstall-package --index-strategy --keyring-provider --resolution --prerelease --pre --fork-strategy --config-setting --no-build-isolation --no-build-isolation-package --build-isolation --exclude-newer --link-mode --compile-bytecode --no-compile-bytecode --no-sources --no-build --build --no-build-package --no-binary --binary --no-binary-package --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help <NAME>..."
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --python)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -p)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --upgrade-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -P)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --default-index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -i)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --extra-index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --find-links)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -f)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --reinstall-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-strategy)
                    COMPREPLY=($(compgen -W "first-index unsafe-first-match unsafe-best-match" -- "${cur}"))
                    return 0
                    ;;
                --keyring-provider)
                    COMPREPLY=($(compgen -W "disabled subprocess" -- "${cur}"))
                    return 0
                    ;;
                --resolution)
                    COMPREPLY=($(compgen -W "highest lowest lowest-direct" -- "${cur}"))
                    return 0
                    ;;
                --prerelease)
                    COMPREPLY=($(compgen -W "disallow allow if-necessary explicit if-necessary-or-explicit" -- "${cur}"))
                    return 0
                    ;;
                --fork-strategy)
                    COMPREPLY=($(compgen -W "fewest requires-python" -- "${cur}"))
                    return 0
                    ;;
                --config-setting)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -C)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-build-isolation-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --exclude-newer)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --link-mode)
                    COMPREPLY=($(compgen -W "clone copy hardlink symlink" -- "${cur}"))
                    return 0
                    ;;
                --no-build-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-binary-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__tool__uvx)
            opts="-c -b -i -f -U -P -C -p -V -n -q -v -h --from --with --with-editable --with-requirements --constraints --build-constraints --overrides --isolated --env-file --no-env-file --index --default-index --index-url --extra-index-url --find-links --no-index --upgrade --no-upgrade --upgrade-package --reinstall --no-reinstall --reinstall-package --index-strategy --keyring-provider --resolution --prerelease --pre --fork-strategy --config-setting --no-build-isolation --no-build-isolation-package --build-isolation --exclude-newer --link-mode --compile-bytecode --no-compile-bytecode --no-sources --no-build --build --no-build-package --no-binary --binary --no-binary-package --refresh --no-refresh --refresh-package --python --show-resolution --generate-shell-completion --version --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --from)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --with)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --with-editable)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --with-requirements)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --constraints)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -c)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --build-constraints)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -b)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --overrides)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --env-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --default-index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -i)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --extra-index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --find-links)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -f)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --upgrade-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -P)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --reinstall-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-strategy)
                    COMPREPLY=($(compgen -W "first-index unsafe-first-match unsafe-best-match" -- "${cur}"))
                    return 0
                    ;;
                --keyring-provider)
                    COMPREPLY=($(compgen -W "disabled subprocess" -- "${cur}"))
                    return 0
                    ;;
                --resolution)
                    COMPREPLY=($(compgen -W "highest lowest lowest-direct" -- "${cur}"))
                    return 0
                    ;;
                --prerelease)
                    COMPREPLY=($(compgen -W "disallow allow if-necessary explicit if-necessary-or-explicit" -- "${cur}"))
                    return 0
                    ;;
                --fork-strategy)
                    COMPREPLY=($(compgen -W "fewest requires-python" -- "${cur}"))
                    return 0
                    ;;
                --config-setting)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -C)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-build-isolation-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --exclude-newer)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --link-mode)
                    COMPREPLY=($(compgen -W "clone copy hardlink symlink" -- "${cur}"))
                    return 0
                    ;;
                --no-build-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-binary-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --refresh-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -p)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --generate-shell-completion)
                    COMPREPLY=($(compgen -W "bash elvish fish nushell powershell zsh" -- "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__tree)
            opts="-d -i -f -U -P -C -p -n -q -v -h --universal --depth --prune --package --no-dedupe --invert --outdated --dev --only-dev --no-dev --group --no-group --no-default-groups --only-group --all-groups --locked --frozen --no-build --build --no-build-package --no-binary --binary --no-binary-package --index --default-index --index-url --extra-index-url --find-links --no-index --upgrade --no-upgrade --upgrade-package --index-strategy --keyring-provider --resolution --prerelease --pre --fork-strategy --config-setting --no-build-isolation --no-build-isolation-package --build-isolation --exclude-newer --link-mode --no-sources --script --python-version --python-platform --python --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --depth)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -d)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --prune)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --group)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-group)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --only-group)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-build-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-binary-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --default-index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -i)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --extra-index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --find-links)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -f)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --upgrade-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -P)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-strategy)
                    COMPREPLY=($(compgen -W "first-index unsafe-first-match unsafe-best-match" -- "${cur}"))
                    return 0
                    ;;
                --keyring-provider)
                    COMPREPLY=($(compgen -W "disabled subprocess" -- "${cur}"))
                    return 0
                    ;;
                --resolution)
                    COMPREPLY=($(compgen -W "highest lowest lowest-direct" -- "${cur}"))
                    return 0
                    ;;
                --prerelease)
                    COMPREPLY=($(compgen -W "disallow allow if-necessary explicit if-necessary-or-explicit" -- "${cur}"))
                    return 0
                    ;;
                --fork-strategy)
                    COMPREPLY=($(compgen -W "fewest requires-python" -- "${cur}"))
                    return 0
                    ;;
                --config-setting)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -C)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --no-build-isolation-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --exclude-newer)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --link-mode)
                    COMPREPLY=($(compgen -W "clone copy hardlink symlink" -- "${cur}"))
                    return 0
                    ;;
                --script)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-version)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-platform)
                    COMPREPLY=($(compgen -W "windows linux macos x86_64-pc-windows-msvc i686-pc-windows-msvc x86_64-unknown-linux-gnu aarch64-apple-darwin x86_64-apple-darwin aarch64-unknown-linux-gnu aarch64-unknown-linux-musl x86_64-unknown-linux-musl x86_64-manylinux2014 x86_64-manylinux_2_17 x86_64-manylinux_2_28 x86_64-manylinux_2_31 x86_64-manylinux_2_32 x86_64-manylinux_2_33 x86_64-manylinux_2_34 x86_64-manylinux_2_35 x86_64-manylinux_2_36 x86_64-manylinux_2_37 x86_64-manylinux_2_38 x86_64-manylinux_2_39 x86_64-manylinux_2_40 aarch64-manylinux2014 aarch64-manylinux_2_17 aarch64-manylinux_2_28 aarch64-manylinux_2_31 aarch64-manylinux_2_32 aarch64-manylinux_2_33 aarch64-manylinux_2_34 aarch64-manylinux_2_35 aarch64-manylinux_2_36 aarch64-manylinux_2_37 aarch64-manylinux_2_38 aarch64-manylinux_2_39 aarch64-manylinux_2_40" -- "${cur}"))
                    return 0
                    ;;
                --python)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -p)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__venv)
            opts="-p -i -f -n -q -v -h --python --system --no-system --no-project --seed --allow-existing --prompt --system-site-packages --relocatable --index --default-index --index-url --extra-index-url --find-links --no-index --index-strategy --keyring-provider --exclude-newer --link-mode --refresh --no-refresh --refresh-package --clear --no-seed --no-pip --no-setuptools --no-wheel --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help [PATH]"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --python)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -p)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --prompt)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --default-index)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -i)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --extra-index-url)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --find-links)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -f)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --index-strategy)
                    COMPREPLY=($(compgen -W "first-index unsafe-first-match unsafe-best-match" -- "${cur}"))
                    return 0
                    ;;
                --keyring-provider)
                    COMPREPLY=($(compgen -W "disabled subprocess" -- "${cur}"))
                    return 0
                    ;;
                --exclude-newer)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --link-mode)
                    COMPREPLY=($(compgen -W "clone copy hardlink symlink" -- "${cur}"))
                    return 0
                    ;;
                --refresh-package)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        uv__version)
            opts="-n -q -v -h --bump --dry-run --short --output-format --no-cache --cache-dir --python-preference --managed-python --no-managed-python --allow-python-downloads --no-python-downloads --python-fetch --quiet --verbose --no-color --color --native-tls --no-native-tls --offline --no-offline --allow-insecure-host --preview --no-preview --isolated --show-settings --no-progress --no-installer-metadata --directory --project --config-file --no-config --help [VALUE]"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --bump)
                    COMPREPLY=($(compgen -W "major minor patch" -- "${cur}"))
                    return 0
                    ;;
                --output-format)
                    COMPREPLY=($(compgen -W "text json" -- "${cur}"))
                    return 0
                    ;;
                --cache-dir)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --python-preference)
                    COMPREPLY=($(compgen -W "only-managed managed system only-system" -- "${cur}"))
                    return 0
                    ;;
                --python-fetch)
                    COMPREPLY=($(compgen -W "automatic manual never" -- "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --allow-insecure-host)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --project)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --config-file)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
    esac
}

if [[ "${BASH_VERSINFO[0]}" -eq 4 && "${BASH_VERSINFO[1]}" -ge 4 || "${BASH_VERSINFO[0]}" -gt 4 ]]; then
    complete -F _uv -o nosort -o bashdefault -o default uv
else
    complete -F _uv -o bashdefault -o default uv
fi
