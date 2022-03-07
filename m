Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842284CFC4A
	for <lists+cgroups@lfdr.de>; Mon,  7 Mar 2022 12:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbiCGLJk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Mar 2022 06:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241518AbiCGLJK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Mar 2022 06:09:10 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C9973065;
        Mon,  7 Mar 2022 02:31:24 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j26so12075963wrb.1;
        Mon, 07 Mar 2022 02:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=xLnzYDLYheb8EHYEyiymkaq0+GyHWExGgRc6Etv2XG8=;
        b=o9+mroNCBA0Rvqc6hYCtXIqQasJ5Nkdg28o4D7F5f5hVwjgUIsaZO/gmrvami1roSg
         b0chE+GdzTyhNYASmzWIQzTOU+w81umIsYQV0p5GG3vLFPwQcCUydfX+NwBmyRORzKp3
         veIlesAOqvAxPvfRge8BBGCj1uVe3thjdIKCwy4ALc4jLSRfSCQs6rgmaSWdYIn4h7ow
         3gmyJLK+ssbADfwrC/DZEct7o+an0b1A3aov4tqul3UgY59syzvsmhkE+9PvAyPAepcc
         kcjhnWXUSD+cdfqmWuQIiNMkgJ6doFaJFtn5oqibZs5CGbX4Gfc95/LN/nA69Qd/lryy
         8kbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xLnzYDLYheb8EHYEyiymkaq0+GyHWExGgRc6Etv2XG8=;
        b=1OyjdOAtpirxD9yEz6fgDKp279JfEXxyW7bolmbas4b9MHjWHV8d/a6liK2s44WobQ
         KJzUBqevkndvNekn+I6FW7sSP5xiBxGm7tbYReQ1h0MzE3UDT2k/Qy5eYTycIuioFrmy
         62zW1di8hQdh2T8aPFCEc96oi8jzoJi0p6HNek0+FyPWJ6yufjut06D+Rly8fM0aMdXF
         mQAiqBnBhHl+Pu9qJyK0CZ74yWwjpJD58Uc8SDz7Tis+SuT5E9QR1fsMRxe+keCIpSZg
         l++wfNkRUFFk5gPpTwIlkCcw98elEYVi1X/0jDaf/anDMfOZNDzPWKjSkXZdUrXix4ek
         0jxg==
X-Gm-Message-State: AOAM533RvbNqv9AnlSiI1HyFazNBE12XZ2mhUrlQXaH50B1lRXhQH7g/
        wTtjXiXSrSBNYqFU/xkhrUU=
X-Google-Smtp-Source: ABdhPJz6T8addN0Kbj7Lj+UNgFNrXQ02akA2rxzM9XUK/xrFY6JJ8IY+O9i00Vlh1LDDQCSQawC8eA==
X-Received: by 2002:a5d:490f:0:b0:1f0:6791:a215 with SMTP id x15-20020a5d490f000000b001f06791a215mr7854253wrq.422.1646649082573;
        Mon, 07 Mar 2022 02:31:22 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id bj7-20020a0560001e0700b001f1d7822865sm6727591wrb.43.2022.03.07.02.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 02:31:22 -0800 (PST)
Date:   Mon, 7 Mar 2022 11:31:20 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, zhouchengming@bytedance.com
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: WARNING: suspicious RCU usage since next-20220304
Message-ID: <YiXe+BFGuZR6Eg5y@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello

Booting my sun8i-a83t-bananapi-m3 since next-20220304 lead to lot of RCU warning:
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt: Machine model: Banana Pi BPI-M3
[    0.000000] earlycon: uart0 at MMIO32 0x01c28000 (options '')
[    0.000000] printk: bootconsole [uart0] enabled
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] cma: Reserved 16 MiB at 0xbf000000
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000040000000-0x000000006fffffff]
[    0.000000]   HighMem  [mem 0x0000000070000000-0x00000000bfffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000040000000-0x00000000bfffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x00000000bfffffff]
[    0.000000] percpu: Embedded 16 pages/cpu s34740 r8192 d22604 u65536
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 522752
[    0.000000] Kernel command line: console=ttyS0,115200n8 root=/dev/ram0 earlycon=uart,mmio32,0x01c28000 ip=dhcp
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 2017876K/2097152K available (8192K kernel code, 1395K rwdata, 2956K rodata, 1024K init, 7184K bss, 62892K reserved, 16384K cma-reserved, 1294336K highmem)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] trace event string verifier disabled
[    0.000000] Running RCU self tests
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] rcu: 	RCU lockdep checking is enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] random: get_random_bytes called from start_kernel+0x534/0x6cc with crng_init=0
[    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000003] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
[    0.008649] Switching to timer-based delay loop, resolution 41ns
[    0.015608] clocksource: timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
[    0.026505] Console: colour dummy device 80x30
[    0.031367] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.039759] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.044185] ... MAX_LOCK_DEPTH:          48
[    0.048693] ... MAX_LOCKDEP_KEYS:        8192
[    0.053417] ... CLASSHASH_SIZE:          4096
[    0.058117] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.062911] ... MAX_LOCKDEP_CHAINS:      65536
[    0.067721] ... CHAINHASH_SIZE:          32768
[    0.072516]  memory used by lock dependency info: 4061 kB
[    0.078364]  memory used for stack traces: 2112 kB
[    0.083533]  per task-struct memory footprint: 1536 bytes
[    0.089482] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=240000)
[    0.100709] pid_max: default: 32768 minimum: 301
[    0.106465] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    0.114435] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    0.125719] CPU: Testing write buffer coherency: ok
[    0.132334] 
[    0.134009] =============================
[    0.138348] WARNING: suspicious RCU usage
[    0.142679] 5.17.0-rc6-next-20220307-00130-g074e6e0284df-dirty #222 Not tainted
[    0.150565] -----------------------------
[    0.154901] include/linux/cgroup.h:481 suspicious rcu_dereference_check() usage!
[    0.162883] 
[    0.162883] other info that might help us debug this:
[    0.162883] 
[    0.171509] 
[    0.171509] rcu_scheduler_active = 1, debug_locks = 1
[    0.178546] 2 locks held by kthreadd/2:
[    0.182694]  #0: c19216b4 (&p->pi_lock){....}-{2:2}, at: task_rq_lock+0x34/0x134
[    0.190763]  #1: eef68b50 (&rq->__lock){-...}-{2:2}, at: task_rq_lock+0x5c/0x134
[    0.198810] 
[    0.198810] stack backtrace:
[    0.203522] CPU: 0 PID: 2 Comm: kthreadd Not tainted 5.17.0-rc6-next-20220307-00130-g074e6e0284df-dirty #222
[    0.214132] Hardware name: Allwinner A83t board
[    0.219031]  unwind_backtrace from show_stack+0x10/0x14
[    0.224690]  show_stack from 0xf0835e8c
[    0.228933] 
[    0.230564] =============================
[    0.234891] WARNING: suspicious RCU usage
[    0.239217] 5.17.0-rc6-next-20220307-00130-g074e6e0284df-dirty #222 Not tainted
[    0.247108] -----------------------------
[    0.251433] include/linux/cgroup.h:481 suspicious rcu_dereference_check() usage!
[    0.259419] 
[    0.259419] other info that might help us debug this:
[    0.259419] 
[    0.268061] 
[    0.268061] rcu_scheduler_active = 1, debug_locks = 1
[    0.275103] no locks held by kthreadd/2.
[    0.279336] 
[    0.279336] stack backtrace:
[    0.284043] CPU: 0 PID: 2 Comm: kthreadd Not tainted 5.17.0-rc6-next-20220307-00130-g074e6e0284df-dirty #222
[    0.294643] Hardware name: Allwinner A83t board
[    0.299534]  unwind_backtrace from show_stack+0x10/0x14
[    0.305193]  show_stack from 0xf0801efc
[    0.309508] /cpus/cpu@0 missing clock-frequency property
[    0.315324] /cpus/cpu@1 missing clock-frequency property
[    0.321178] /cpus/cpu@2 missing clock-frequency property
[    0.326983] /cpus/cpu@3 missing clock-frequency property
[    0.332833] /cpus/cpu@100 missing clock-frequency property
[    0.338835] /cpus/cpu@101 missing clock-frequency property
[    0.344897] /cpus/cpu@102 missing clock-frequency property
[    0.350930] /cpus/cpu@103 missing clock-frequency property
[    0.356920] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.366264] Setting up static identity map for 0x40100000 - 0x40100060
[    0.374286] ARM CCI driver probed
[    0.378726] sunxi multi cluster SMP support installed
[    0.385497] rcu: Hierarchical SRCU implementation.
[    0.391811] 
[    0.393463] =============================
[    0.397800] WARNING: suspicious RCU usage
[    0.402138] 5.17.0-rc6-next-20220307-00130-g074e6e0284df-dirty #222 Not tainted
[    0.410033] -----------------------------
[    0.414358] include/linux/cgroup.h:481 suspicious rcu_dereference_check() usage!
[    0.422337] 
[    0.422337] other info that might help us debug this:
[    0.422337] 
[    0.430972] 
[    0.430972] rcu_scheduler_active = 1, debug_locks = 1
[    0.438016] 1 lock held by migration/0/12:
[    0.442441]  #0: eef68b50 (&rq->__lock){-...}-{2:2}, at: __schedule+0xf4/0xaa4
[    0.450325] 
[    0.450325] stack backtrace:
[    0.455037] CPU: 0 PID: 12 Comm: migration/0 Not tainted 5.17.0-rc6-next-20220307-00130-g074e6e0284df-dirty #222
[    0.466027] Hardware name: Allwinner A83t board
[    0.470920] Stopper: 0x0 <- 0x0
[    0.474328]  unwind_backtrace from show_stack+0x10/0x14
[    0.479980]  show_stack from 0xf087debc

I bisect it to dc6e0818bc9a0336d9accf3ea35d146d72aa7a18 sched/cpuacct: Optimize away RCU read lock
reverting this commit removed some RCU but the boot is clean since I reverted also 3eba0505d03a9c1eb30d40c2330c0880b22d1b3a "sched/cpuacct: Remove redundant RCU read lock"

Regards
