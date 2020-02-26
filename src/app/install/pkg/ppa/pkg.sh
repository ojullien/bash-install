## -----------------------------------------------------------------------------
## ppa.
## ppa install package functions.
##
## @package ojullien\bash\app\install\pkg\ppa
## @license MIT <https://github.com/ojullien/bash-install/blob/master/LICENSE>
## -----------------------------------------------------------------------------

## -----------------------------------------------------------------------------
## Constants
## -----------------------------------------------------------------------------


## -----------------------------------------------------------------------------
## Functions
## -----------------------------------------------------------------------------
Ppa::configure() {

    # Init
    local -i iReturn=1

    add-apt-repository --yes --no-update ppa:git-core/ppa
    iReturn=$?
    ((0!=iReturn)) && return ${iReturn}

#    add-apt-repository --yes --no-update ppa:ondrej/apache2
#    iReturn=$?
#    ((0!=iReturn)) && return ${iReturn}

    add-apt-repository --yes ppa:ondrej/php
    iReturn=$?

    return ${iReturn}
}
