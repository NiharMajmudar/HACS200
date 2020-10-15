'use strict';

module.exports = {
    local: false,
    debug : true,
    logToInstructor: {
        enabled: false,
        host: 'XXXXXXXXXXXXX',
        user: 'students',
        password: 'XXXXXXXXXXXXXXXXXXX',
        database: 'XXXXXXXXXXX',
        connectionLimit : 5
    },
    container : {
        mountPath: {
            prefix: '/var/lib/lxc/',
            suffix: 'rootfs'
        },
    },
    logging : {
        streamOutput : '/root/MITM_data/sessions',
        loginAttempts : '/root/MITM_data/login_attempts',
        logins : '/root/MITM_data/logins'
    },
    server : {
        maxAttemptsPerConnection: 6,
        listenIP : '0.0.0.0',
        identifier : '',
        banner : '/root/MITM/config/banner.txt'
    },
    autoAccess : {
        enabled: true,
        cacheSize : 5000,
        barrier: {
            normalDist: {
                enabled: false,
                mean: 6,
                standardDeviation: 1,
            },
            fixed: {
                enabled: true,
                attempts: 3,
            }
        }

    }
};

