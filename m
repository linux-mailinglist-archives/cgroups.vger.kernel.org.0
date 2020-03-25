Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECD751930F9
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2020 20:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgCYTRA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Mar 2020 15:17:00 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39907 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727766AbgCYTRA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Mar 2020 15:17:00 -0400
Received: by mail-qk1-f193.google.com with SMTP id b62so3856783qkf.6
        for <cgroups@vger.kernel.org>; Wed, 25 Mar 2020 12:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=xgCvi6yF+dPZiq/At6y9qjlcSPVC7rXJLeBVwZqYKww=;
        b=KJ2GhhpFdpATondYqDphBLBndUgsfxq3SaxRCaHxUWhWHyLZ+cuOMCZ/tE4Ro6j6I7
         10WlooC1pz76upHfwqu2/PZ/Ptu8WkE/c96mqLW75wI5wP1OJcmKh/w8jfEnYQ0cCZWf
         Aj9mOJKzBJVESFlhDwm173FTpZPRwI/+pCxKrGuqc7vQQeGd2jCS9qAwPBYGV6FeMjlv
         dA4DWSwJIXvMcM5xGOtxm7SyzSdVBjLiqPFkvw0qbdxHTZ6KQGNHHhVtCj9/WG+2oTCW
         xX8F8sqe3Px2NmqyXGxuuYWJUOhikSwXEtVZkWGBKzAj1XCh6m7xCWGQ662a5R9jpRHT
         6XOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=xgCvi6yF+dPZiq/At6y9qjlcSPVC7rXJLeBVwZqYKww=;
        b=Lab5C1IIbBc0w4SwicpKFNilNnni/25U4/VTicLHu3I2CSX6Sw9wwMJUezKw7qgBpz
         7Pog9nQe35l7dcCQPMrRwbZRoJJKnMrj+w1DyJ410fIDZP8sCOFk9X6b42jVSAQDbDJJ
         HaIzU8gYmNWGkHItljnZbRE+G+h2PN9YGgM+dSGGvvfZ3Ny+P/7dfSgXTPmwxaVZkDNe
         tACKXfpJb0fMlgNsyQnkSLCAACiag3ZUFesOG9qpQyOJa/jZsMUz4LJ8OOHq5pZHU7Zp
         6Lkyl6nbzozkCuSgdDbRf9kBYMYpdImv0UfTZDovwcKllGApcBxf6jLkM+R1zIdRXq+S
         Pjkw==
X-Gm-Message-State: ANhLgQ3kOxzNPJlNJEadxu2fqNq1Q1y8wQGSZvVBTb56VGmQmsdBFngP
        1oFiICS2g86mRHeTthWDmHv9Xg==
X-Google-Smtp-Source: ADFU+vuzmE2hf/xArRqLK+Bqmzxx3QZHWtNCv+jpv3l1ZuXV2Yr2x5AIQZXcFzwW0xosqTN6xD/CfA==
X-Received: by 2002:ae9:c312:: with SMTP id n18mr4336578qkg.472.1585163818759;
        Wed, 25 Mar 2020 12:16:58 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g6sm17013402qtd.85.2020.03.25.12.16.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 12:16:57 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Deadlock due to "cpuset: Make cpuset hotplug synchronous"
Message-Id: <F0388D99-84D7-453B-9B6B-EEFF0E7BE4CC@lca.pw>
Date:   Wed, 25 Mar 2020 15:16:56 -0400
Cc:     Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
To:     Prateek Sood <prsood@codeaurora.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The linux-next commit a49e4629b5ed (=E2=80=9Ccpuset: Make cpuset hotplug =
synchronous=E2=80=9D)
introduced real deadlocks with CPU hotplug as showed in the lockdep =
splat, since it is
now making a relation from cpu_hotplug_lock =E2=80=94> cgroup_mutex.

[17602.773334][   T15] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
[17602.780207][   T15] WARNING: possible circular locking dependency =
detected
[17602.787081][   T15] 5.6.0-rc7-next-20200325+ #13 Tainted: G           =
  L  =20
[17602.794125][   T15] =
------------------------------------------------------
[17602.800997][   T15] cpuhp/1/15 is trying to acquire lock:
[17602.806392][   T15] ffff900012cb7bf0 (cgroup_mutex){+.+.}-{3:3}, at: =
cgroup_transfer_tasks+0x130/0x2d8
[17602.815718][   T15]=20
[17602.815718][   T15] but task is already holding lock:
[17602.822934][   T15] ffff900012aeb2b0 (cpuhp_state-down){+.+.}-{0:0}, =
at: cpuhp_lock_acquire+0x8/0x48
[17602.832078][   T15]=20
[17602.832078][   T15] which lock already depends on the new lock.
[17602.832078][   T15]=20
[17602.842334][   T15]=20
[17602.842334][   T15] the existing dependency chain (in reverse order) =
is:
[17602.851200][   T15]=20
[17602.851200][   T15] -> #2 (cpuhp_state-down){+.+.}-{0:0}:
[17602.858780][   T15]        lock_acquire+0xe4/0x25c
[17602.863570][   T15]        cpuhp_lock_acquire+0x40/0x48
[17602.868794][   T15]        cpuhp_kick_ap_work+0x64/0x118
[17602.874107][   T15]        _cpu_down+0x16c/0x3c0
[17602.878722][   T15]        cpu_down+0x54/0x74
[17602.883079][   T15]        cpu_subsys_offline+0x24/0x30
[17602.888303][   T15]        device_offline+0x94/0xf0
[17602.893180][   T15]        online_store+0x80/0x110
[17602.897969][   T15]        dev_attr_store+0x5c/0x78
[17602.902847][   T15]        sysfs_kf_write+0x9c/0xcc
[17602.907724][   T15]        kernfs_fop_write+0x228/0x32c
[17602.912950][   T15]        __vfs_write+0x84/0x1d8
[17602.917652][   T15]        vfs_write+0x13c/0x1b4
[17602.922268][   T15]        ksys_write+0xb0/0x120
[17602.926884][   T15]        __arm64_sys_write+0x54/0x88
[17602.932021][   T15]        do_el0_svc+0x128/0x1dc
[17602.936725][   T15]        el0_sync_handler+0x150/0x250
[17602.941948][   T15]        el0_sync+0x164/0x180
[17602.946473][   T15]=20
[17602.946473][   T15] -> #1 (cpu_hotplug_lock){++++}-{0:0}:
[17602.954050][   T15]        lock_acquire+0xe4/0x25c
[17602.958841][   T15]        cpus_read_lock+0x50/0x154
[17602.963807][   T15]        static_key_slow_inc+0x18/0x30
[17602.969117][   T15]        mem_cgroup_css_alloc+0x824/0x8b0
[17602.974689][   T15]        cgroup_apply_control_enable+0x1d8/0x56c
[17602.980867][   T15]        cgroup_apply_control+0x40/0x344
[17602.986352][   T15]        cgroup_subtree_control_write+0x664/0x69c
[17602.992618][   T15]        cgroup_file_write+0x130/0x2e8
[17602.997928][   T15]        kernfs_fop_write+0x228/0x32c
[17603.003152][   T15]        __vfs_write+0x84/0x1d8
[17603.007854][   T15]        vfs_write+0x13c/0x1b4
[17603.012470][   T15]        ksys_write+0xb0/0x120
[17603.017087][   T15]        __arm64_sys_write+0x54/0x88
[17603.022223][   T15]        do_el0_svc+0x128/0x1dc
[17603.026926][   T15]        el0_sync_handler+0x150/0x250
[17603.032149][   T15]        el0_sync+0x164/0x180
[17603.036674][   T15]=20
[17603.036674][   T15] -> #0 (cgroup_mutex){+.+.}-{3:3}:
[17603.043904][   T15]        validate_chain+0x17bc/0x38b4
[17603.049128][   T15]        __lock_acquire+0xefc/0x1180
[17603.054265][   T15]        lock_acquire+0xe4/0x25c
[17603.059056][   T15]        __mutex_lock_common+0x12c/0xf38
[17603.064540][   T15]        mutex_lock_nested+0x40/0x50
[17603.069678][   T15]        cgroup_transfer_tasks+0x130/0x2d8
[17603.075337][   T15]        cpuset_hotplug_update_tasks+0x6d4/0x794
[17603.081515][   T15]        cpuset_hotplug+0x42c/0x5bc
[17603.086566][   T15]        cpuset_update_active_cpus+0x14/0x1c
[17603.092400][   T15]        sched_cpu_deactivate+0x144/0x208
[17603.097971][   T15]        cpuhp_invoke_callback+0x1dc/0x534
[17603.103628][   T15]        cpuhp_thread_fun+0x27c/0x36c
[17603.108852][   T15]        smpboot_thread_fn+0x388/0x53c
[17603.114164][   T15]        kthread+0x208/0x224
[17603.118606][   T15]        ret_from_fork+0x10/0x18
[17603.123392][   T15]=20
[17603.123392][   T15] other info that might help us debug this:
[17603.123392][   T15]=20
[17603.133473][   T15] Chain exists of:
[17603.133473][   T15]   cgroup_mutex --> cpu_hotplug_lock --> =
cpuhp_state-down
[17603.133473][   T15]=20
[17603.146256][   T15]  Possible unsafe locking scenario:
[17603.146256][   T15]=20
[17603.153560][   T15]        CPU0                    CPU1
[17603.158779][   T15]        ----                    ----
[17603.164000][   T15]   lock(cpuhp_state-down);
[17603.168357][   T15]                                =
lock(cpu_hotplug_lock);
[17603.175231][   T15]                                =
lock(cpuhp_state-down);
[17603.182103][   T15]   lock(cgroup_mutex);
[17603.186111][   T15]=20
[17603.186111][   T15]  *** DEADLOCK ***
[17603.186111][   T15]=20
[17603.194111][   T15] 2 locks held by cpuhp/1/15:
[17603.198636][   T15]  #0: ffff900012ae9408 =
(cpu_hotplug_lock){++++}-{0:0}, at: lockdep_acquire_cpus_lock+0xc/0x3c
[17603.208821][   T15]  #1: ffff900012aeb2b0 =
(cpuhp_state-down){+.+.}-{0:0}, at: cpuhp_lock_acquire+0x8/0x48
[17603.218397][   T15]=20
[17603.218397][   T15] stack backtrace:
[17603.224146][   T15] CPU: 1 PID: 15 Comm: cpuhp/1 Tainted: G           =
  L    5.6.0-rc7-next-20200325+ #13
[17603.233708][   T15] Hardware name: HPE Apollo 70             =
/C01_APACHE_MB         , BIOS L50_5.13_1.11 06/18/2019
[17603.244138][   T15] Call trace:
[17603.247278][   T15]  dump_backtrace+0x0/0x224
[17603.251633][   T15]  show_stack+0x20/0x2c
[17603.255643][   T15]  dump_stack+0xfc/0x184
[17603.259739][   T15]  print_circular_bug+0x3dc/0x438
[17603.264616][   T15]  check_noncircular+0x284/0x28c
[17603.269405][   T15]  validate_chain+0x17bc/0x38b4
[17603.274108][   T15]  __lock_acquire+0xefc/0x1180
[17603.278724][   T15]  lock_acquire+0xe4/0x25c
[17603.282993][   T15]  __mutex_lock_common+0x12c/0xf38
[17603.287957][   T15]  mutex_lock_nested+0x40/0x50
[17603.292573][   T15]  cgroup_transfer_tasks+0x130/0x2d8
[17603.297711][   T15]  cpuset_hotplug_update_tasks+0x6d4/0x794
remove_tasks_in_empty_cpuset at kernel/cgroup/cpuset.c:2932
(inlined by) hotplug_update_tasks_legacy at kernel/cgroup/cpuset.c:2973
(inlined by) cpuset_hotplug_update_tasks at kernel/cgroup/cpuset.c:3097
[17603.303368][   T15]  cpuset_hotplug+0x42c/0x5bc
[17603.307897][   T15]  cpuset_update_active_cpus+0x14/0x1c
cpuset_update_active_cpus at kernel/cgroup/cpuset.c:3230
[17603.313208][   T15]  sched_cpu_deactivate+0x144/0x208
[17603.318258][   T15]  cpuhp_invoke_callback+0x1dc/0x534
[17603.323394][   T15]  cpuhp_thread_fun+0x27c/0x36c
[136806][   T15]  [17608.539300][   T16] IRQ 90: no longer affine to =
CPU1

Once it happens, the system is doomed.

[18797.018637][T25534] LTP: starting cpuhotplug02 (cpuhotplug02.sh -c 1 =
-l 1)
[18808.649761][   T16] IRQ 90: no longer affine to CPU1
[18808.655134][   T16] process 74665 (cpuhotplug_do_s) no longer affine =
to cpu1
[18808.656233][T74643] CPU1: shutdown
[18808.673016][T74643] psci: CPU1 killed (polled 10 ms)
[18816.737743][    T0] Detected PIPT I-cache on CPU1
[18816.742479][    T0] GICv3: CPU1: found redistributor 100 region =
0:0x0000000401080000
[18816.750416][    T0] CPU1: Booted secondary processor 0x0000000100 =
[0x431f0af1]
[18820.809117][T25534] LTP: starting cpuhotplug03 (cpuhotplug03.sh -c 1 =
-l 1)
[18839.239220][T74677] CPU1: shutdown
[18839.255936][T74677] psci: CPU1 killed (polled 10 ms)
[18962.232428][    T0] Detected PIPT I-cache on CPU1
[18962.237230][    T0] GICv3: CPU1: found redistributor 100 region =
0:0x0000000401080000
[18962.245291][    T0] CPU1: Booted secondary processor 0x0000000100 =
[0x431f0af1]
[19245.173443][T25534] LTP: starting cpuhotplug04 (cpuhotplug04.sh -l 1)
[19266.168715][   T12] IRQ 159: no longer affine to CPU0
[19266.174935][T79171] CPU0: shutdown
[19266.191548][T79171] psci: CPU0 killed (polled 20 ms)
[19465.919614][ T1307] INFO: task systemd:1 blocked for more than 122 =
seconds.
[19465.926605][ T1307]       Tainted: G        W    L    =
5.6.0-rc7-next-20200324+ #12
[19465.934271][ T1307] "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[19465.942854][ T1307] systemd         D24464     1      0 0x00000000
[19465.949086][ T1307] Call trace:
[19465.952287][ T1307]  __switch_to+0x13c/0x178
[19465.956578][ T1307]  __schedule+0x65c/0x6fc
[19465.960814][ T1307]  schedule+0xe4/0x1c0
[19465.964757][ T1307]  percpu_rwsem_wait+0x270/0x2f4
[19465.969600][ T1307]  __percpu_down_read+0x64/0x94
[19465.974325][ T1307]  cpus_read_lock+0x150/0x154
[19465.978876][ T1307]  static_key_slow_inc+0x18/0x30
[19465.983719][ T1307]  mem_cgroup_css_alloc+0x810/0x89c
[19465.988790][ T1307]  cgroup_apply_control_enable+0x1d8/0x564
[19465.994501][ T1307]  cgroup_mkdir+0x168/0x1ec
[19465.998879][ T1307]  kernfs_iop_mkdir+0x90/0xc4
[19466.003463][ T1307]  vfs_mkdir+0xcc/0x110
[19466.007492][ T1307]  do_mkdirat+0xe4/0x174
[19466.011641][ T1307]  __arm64_sys_mkdirat+0x54/0x88
[19466.016450][ T1307]  do_el0_svc+0x128/0x1dc
[19466.020685][ T1307]  el0_sync_handler+0xd0/0x268
[19466.025319][ T1307]  el0_sync+0x164/0x180
[19466.029352][ T1307] INFO: task cpuhp/1:15 blocked for more than 122 =
seconds.
[19466.036451][ T1307]       Tainted: G        W    L    =
5.6.0-rc7-next-20200324+ #12
[19466.044070][ T1307] "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[19466.052643][ T1307] cpuhp/1         D27984    15      2 0x00000028
[19466.058876][ T1307] Call trace:
[19466.062070][ T1307]  __switch_to+0x13c/0x178
[19466.066358][ T1307]  __schedule+0x65c/0x6fc
[19466.070593][ T1307]  schedule+0xe4/0x1c0
[19466.074534][ T1307]  schedule_preempt_disabled+0x3c/0x68
[19466.079898][ T1307]  __mutex_lock_common+0x6fc/0xf38
[19466.084882][ T1307]  mutex_lock_nested+0x40/0x50
[19466.089552][ T1307]  cgroup_transfer_tasks+0x130/0x2d8
[19466.094709][ T1307]  cpuset_hotplug_update_tasks+0x6d4/0x794
[19466.100418][ T1307]  cpuset_hotplug+0x42c/0x5bc
[19466.104967][ T1307]  cpuset_update_active_cpus+0x14/0x1c
[19466.110333][ T1307]  sched_cpu_deactivate+0x144/0x208
[19466.115402][ T1307]  cpuhp_invoke_callback+0x1dc/0x534
[19466.120592][ T1307]  cpuhp_thread_fun+0x27c/0x36c
[19466.125314][ T1307]  smpboot_thread_fn+0x388/0x53c
[19466.130156][ T1307]  kthread+0x1cc/0x1e8
[19466.134096][ T1307]  ret_from_fork+0x10/0x18
[19466.139100][ T1307] INFO: task systemd-journal:2575 blocked for more =
than 123 seconds.
[19466.147101][ T1307]       Tainted: G        W    L    =
5.6.0-rc7-next-20200324+ #12
[19466.154724][ T1307] "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[19466.163296][ T1307] systemd-journal D24384  2575      1 0x00000800
[19466.169557][ T1307] Call trace:
[19466.172718][ T1307]  __switch_to+0x13c/0x178
[19466.177007][ T1307]  __schedule+0x65c/0x6fc
[19466.181261][ T1307]  schedule+0xe4/0x1c0
[19466.185204][ T1307]  schedule_preempt_disabled+0x3c/0x68
[19466.190569][ T1307]  __mutex_lock_common+0x6fc/0xf38
[19466.195552][ T1307]  mutex_lock_nested+0x40/0x50
[19466.200221][ T1307]  proc_cgroup_show+0x64/0x328
[19466.204857][ T1307]  proc_single_show+0x84/0xbc
[19466.209406][ T1307]  seq_read+0x380/0x930
[19466.213467][ T1307]  __vfs_read+0x84/0x1d0
[19466.217582][ T1307]  vfs_read+0xec/0x120
[19466.221555][ T1307]  ksys_read+0xb0/0x120
[19466.225583][ T1307]  __arm64_sys_read+0x54/0x88
[19466.230164][ T1307]  do_el0_svc+0x128/0x1dc
[19466.234365][ T1307]  el0_sync_handler+0xd0/0x268
[19466.238999][ T1307]  el0_sync+0x164/0x180
[19466.243094][ T1307] INFO: task irqbalance:3677 blocked for more than =
123 seconds.
[19466.250656][ T1307]       Tainted: G        W    L    =
5.6.0-rc7-next-20200324+ #12
[19466.258240][ T1307] "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[19466.266818][ T1307] irqbalance      D24592  3677      1 0x00000000
[19466.273080][ T1307] Call trace:
[19466.276241][ T1307]  __switch_to+0x13c/0x178
[19466.280563][ T1307]  __schedule+0x65c/0x6fc
[19466.284765][ T1307]  schedule+0xe4/0x1c0
[19466.288706][ T1307]  schedule_preempt_disabled+0x3c/0x68
[19466.294070][ T1307]  __mutex_lock_common+0x6fc/0xf38
[19466.299053][ T1307]  mutex_lock_nested+0x40/0x50
[19466.303723][ T1307]  online_show+0x2c/0x6c
[19466.307837][ T1307]  dev_attr_show+0x50/0x90
[19466.312158][ T1307]  sysfs_kf_seq_show+0x198/0x2d4
[19466.316967][ T1307]  kernfs_seq_show+0xa4/0xcc
[19466.321461][ T1307]  seq_read+0x380/0x930
[19466.325489][ T1307]  kernfs_fop_read+0xa8/0x35c
[19466.330070][ T1307]  __vfs_read+0x84/0x1d0
[19466.334184][ T1307]  vfs_read+0xec/0x120
[19466.338124][ T1307]  ksys_read+0xb0/0x120
[19466.342185][ T1307]  __arm64_sys_read+0x54/0x88
[19466.346733][ T1307]  do_el0_svc+0x128/0x1dc
[19466.350967][ T1307]  el0_sync_handler+0xd0/0x268
[19466.355602][ T1307]  el0_sync+0x164/0x180
[19466.359988][ T1307] INFO: task kworker/1:1:74671 blocked for more =
than 123 seconds.
[19466.367661][ T1307]       Tainted: G        W    L    =
5.6.0-rc7-next-20200324+ #12
[19466.375284][ T1307] "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[19466.383856][ T1307] kworker/1:1     D29680 74671      2 0x00000028
[19466.390130][ T1307] Workqueue: events vmstat_shepherd
[19466.395202][ T1307] Call trace:
[19466.398362][ T1307]  __switch_to+0x13c/0x178
[19466.402684][ T1307]  __schedule+0x65c/0x6fc
[19466.406885][ T1307]  schedule+0xe4/0x1c0
[19466.410860][ T1307]  percpu_rwsem_wait+0x270/0x2f4
[19466.415669][ T1307]  __percpu_down_read+0x64/0x94
[19466.420425][ T1307]  cpus_read_lock+0x150/0x154
[19466.424973][ T1307]  vmstat_shepherd+0x20/0x16c
[19466.429556][ T1307]  process_one_work+0x2c0/0x4c4
[19466.434278][ T1307]  worker_thread+0x320/0x4b4
[19466.438739][ T1307]  kthread+0x1cc/0x1e8
[19466.442730][ T1307]  ret_from_fork+0x10/0x18
[19466.447021][ T1307] INFO: task cpuhotplug04.sh:79171 blocked 00324+ =
#12
[19466.471271][ T13097][ T1307]  __sule+0xe4/0x1c0
1a4/0x2b4
[19466.502725][ T1307]  __wait_for_common+0x58/0xa8
[19466.507361][ T1307]  wait_for_completion+0x2c/0x38
[19466.512210][ T1307]  __cpuhp_kick_ap+0xe8/0xf8
[19466.516671][ T1307]  cpuhp_kick_ap+0x34/0x6c
[19466.520992][ T1307]  cpuhp_kick_ap_work+0xb4/0x118
[19466.525800][ T1307]  _cpu_down+0x16c/0x3c0
[19466.529953][ T1307]  cpu_down+0x54/0x74
[19466.533808][ T1307]  cpu_subsys_offline+0x24/0x30
[19466.538529][ T1307]  device_offline+0x94/0xf0
[19466.542937][ T1307]  online_store+0x80/0x110
[19466.547224][ T1307]  dev_attr_store+0x5c/0x78
[19466.551633][ T1307]  sysfs_kf_write+0x9c/0xcc
[19466.556008][ T1307]  kernfs_fop_write+0x228/0x32c
[19466.560769][ T1307]  __vfs_write+0x84/0x1d8
[19466.564969][ T1307]  vfs_write+0x13c/0x1b4
[19466.569083][ T1307]  ksys_write+0xb0/0x120
[19466.573235][ T1307]  __arm64_sys_write+0x54/0x88
[19466.577870][ T1307]  do_el0_svc+0x128/0x1dc
[19466.582105][ T1307]  el0_sync_handler+0xd0/0x268
[19466.586739][ T1307]  el0_sync+0x164/0x180
[19466.590809][ T1307] INFO: lockdep is turned off.
[19588.799236][ T1307] INFO: task systemd:1 blocked for more than 245 =
seconds.
[19588.806218][ T1307]       Tainted: G        W    L    =
5.6.0-rc7-next-20200324+ #12
[19588.813859][ T1307] "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[19588.822433][ T1307] systemd         D24464     1      0 0x00000000
[19588.828661][ T1307] Call trace:
[19588.831858][ T1307]  __switch_to+0x13c/0x178
[19588.836146][ T1307]  __schedule+0x65c/0x6fc
[19588.840382][ T1307]  schedule+0xeown_read+0x64/0x+0x18/0x30
[195_enable+0x1d8/0x90/0xc4
[19588.05][ T1307]  __arm64_sys_mkdirat+0x54/0x88
[19588.896014][ T1307]  do_el0_svc+0x128/0x1dc
[19588.900249][ T1307]  el0_sync_handler+0xd0/0x268
[19588.904883][ T1307]  el0_sync+0x164/0x180
[19588.908915][ T1307] INFO: task cpuhp/1:15 blocked for more than 245 =
seconds.
[19588.916013][ T1307]       Tainted: G        W    L    =
5.6.0-rc7-next-20200324+ #12
[19588.923632][ T1307] "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[19588.932204][ T1307] cpuhp/1         D27984    15      2 0x00000028
[19588.938436][ T1307] Call trace:
[19588.941630][ T1307]  __switch_to+0x13c/0x178
[19588.945919][ T1307]  __schedule+0x65c/0x6fc
[19588.950154][ T1307]  schedule+0xe4/0x1c0
[19588.954095][ T1307]  schedule_preempt_disabled+0x3c/0x68
[19588.959459][ T1307]  __mutex_lock_common+0x6fc/0xf38
[19588.964443][ T1307]  mutex_lock_nested+0x40/0x50
[19588.969079][ T1307]  cgroup_transfer_tasks+0x130/0x2d8
[19588.974269][ T1307]  cpuset_hotplug_update_tasks+0x6d4/0x794
[19588.979980][ T1307]  cpuset_hotplug+0x42c/0x5bc
[19588.984529][ T1307]  cpuset_update_active_cpus+0x14/0x1c
[19588.989895][ T1307]  sched_cpu_deactivate+0x144/0x208
[19588.994965][ T1307]  cpuhp_invoke_callback+0x1dc/0x534
[19589.000154][ T1307]  cpuhp_thread_fun+0x27c/0x36c
[19589.004876][ T1307]  smpboot_thread_fn+0x388/0x53c
[19589.009717][ T1307]  kthread+0x1cc/0x1e8
[19589.013657][ T1307]  ret_from_fork+0x10/0x18
[19589.018654][ T1307] INFO: task systemd-journal:2575 blocked for more =
than 245 seconds.
[19589.026653][ T1307]       Tainted: G        W    L    =
5.6.0-rc7-next-20200324+ #12
[19589.034277][ T1307] "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[19589.042849][ T1307] systemd-journal D24384  2575      1 0x00000800
[19589.049076][ T1307] Call trace:
[19589.052271][ T1307]  __switch_to+0x13c/0x178
[19589.056560][ T1307]  __schedule+0x65c/0x6fc
[19589.060812][ T1307]  schedule+0xe4/0x1c0
[19589.064754][ T1307]  schedule_preempt_disabled+0x3c/0x68
[19589.070118][ T1307]  __mutex_lock_common+0x6fc/0xf38
[19589.075101][ T1307]  mutex_lock_nested+0x40/0x50
[19589.079770][ T1307]  proc_cgroup_show+0x64/0x328
[19589.084406][ T1307]  proc_single_show+0x84/0xbc
[19589.088953][ T1307]  seq_read+0x380/0x930
[19589.093015][ T1307]  __vfs_read+0x84/0x1d0
[19589.097129][ T1307]  vfs_read+0xec/0x120
[19589.101102][ T1307]  ksys_read+0xb0/0x120
[19589.105130][ T1307]  __arm64_sys_read+0x54/0x88
[19589.109711][ T1307]  do_el0_svc+0x128/0x1dc
[19589.113913][ T1307]  el0_sync_handler+0xd0/0x268
[19589.118547][ T1307]  el0_sync+0x164/0x180
[19589.122630][ T1307] INFO: task irqbalance:3677 blocked for more than =
246 seconds.
[19589.130165][ T1307]       Tainted: G        W    L    =
5.6.0-rc7-next-20200324+ #12
[19589.137750][ T1307] "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[19589.146321][ T1307] irqbalance      D24592  3677      1 0x00000000
[19589.152582][ T1307] Call trace:
[19589.155743][ T1307]  __switch_to+0x13c/0x178
[19589.160065][ T1307]  __schedule+0x65c/0x6fc
[19589.164266][ T1307]  schedule+0xe4/0x1c0
[19589.168207][ T1307]  schedule_preempt_disabled+0x3c/0x68
[19589.173571][ T1307]  __mutex_lock_common+0x6fc/0xf38
[19589.178554][ T1307]  mutex_lock_nested+0x40/0x50
[19589.183223][ T1307]  online_show+0x2c/0x6c
[19589.187337][ T1307]  dev_attr_show+0x50/0x90
[19589.191659][ T1307]  sysfs_kf_seq_show+0x198/0x2d4
[19589.196469][ T1307]  kernfs_seq_show+0xa4/0xcc
[19589.200963][ T1307]  seq_read+0x380/0x930
[19589.204991][ T1307]  kernfs_fop_read+0xa8/0x35c
[19589.209573][ T1307]  __vfs_read+0x84/0x1d0
[19589.213687][ T1307]  vfs_read+0xec/0x120
[19589.217627][ T1307]  ksys_read+0xb0/0x120
[19589.221688][ T1307]  __arm64_sys_read+0x54/0x88
[19589.226235][ T1307]  do_el0_svc+0x128/0x1dc
[19589.230470][ T1307]  el0_sync_handler+0xd0/0x268
[19589.235105][ T1307]  el0_sync+0x164/0x180
[19589.239491][ T1307] INFO: lockdep is turned off.
[21665.996141][ T3790] process 3847 (rngd) no longer affine to cpu1
[25274.311890][ T3790] process 3846 (rngd) no longer affine to cpu0


