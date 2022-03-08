Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0B04D0E03
	for <lists+cgroups@lfdr.de>; Tue,  8 Mar 2022 03:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344353AbiCHCbR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Mar 2022 21:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244900AbiCHCbQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Mar 2022 21:31:16 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F33235DC4
        for <cgroups@vger.kernel.org>; Mon,  7 Mar 2022 18:30:20 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id g19so4527062pfc.9
        for <cgroups@vger.kernel.org>; Mon, 07 Mar 2022 18:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FsQ0UgHwnYj3Ac3LsvaFOaO6AxALcfSdSK/yiU2zb0s=;
        b=Wxy20qgDJ1I6Vr55GunQQ/zrvuZ0QeYh6Ccvn6D3lHW6CenESItuz9E2wimN+tmzdP
         xMVsnFEd4bkjp+/k9/VSqmScKHhc9yn37JTOEkVyEB4CYWjHjzxK4RWP8KMr6cXutqLd
         XpzKwnzJp3DqhRwsYByIhJyGwFPvtUxskCPjTvZc/JrYHDp0pWxCvyTnEOepmn1eABS1
         5aH4Ca+u7v2cYQLiBpU3Ww6q4YRgFTTsae7YFOdd6mUjygqLOE3aJW7ETeADJZEBf61q
         WrFjx0F7pFdFD9nTfEHagkQtuTIq70M0zM3Ga9adRl3mr8KxPpj8/5w8H1Qzc2Hox54p
         qtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FsQ0UgHwnYj3Ac3LsvaFOaO6AxALcfSdSK/yiU2zb0s=;
        b=HUk4WXv47ZrjfKOL6l/hC2JC7qCuGKiOzVtFmk/f8DKJV1NIfXHSaZvpVNwwTsoMZm
         Or+blJznaAoQFWjrqsDsqK3xbFsA97DqgcK8AQH6A9bKqQO4cC3eDVXmjbs6H9YdpS9c
         2xEgS25PDT3Pl0GkXARJTK9UyF/ihqdz9lrcorCBuIzDkf0Zvqo2FNZ6U6WP7BTJKLfj
         enE4wORfm7jC2FDV/SOxJ+e4vkR7of/uM+dPtqU7y4Jwg7UKQKIOaiToWsenMv2HFZUN
         VLEPX6HxE0g8I4Ko/vVNyUzsvHoPSaIW8iSnDE1cOikOVieUEbsO1RyKR4/vtlpzoJR2
         ULCQ==
X-Gm-Message-State: AOAM5300gvaH9TF2LFmB6CKJ0ylkrZFO99MH7Jtec9wkBj2iFxeU5ia+
        bPzzJaPog2q0nmcoczODIwUjbw==
X-Google-Smtp-Source: ABdhPJx9jVWaIwfG+AlgILvYI6a1TuqApXMoMTvgoA0arcOThrAmx8Toz4nNJD7GV5fdaGU1wnKg7Q==
X-Received: by 2002:a05:6a02:19a:b0:378:4f44:b1da with SMTP id bj26-20020a056a02019a00b003784f44b1damr12251834pgb.568.1646706619806;
        Mon, 07 Mar 2022 18:30:19 -0800 (PST)
Received: from [10.255.253.61] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id j67-20020a636e46000000b003740d689ca9sm12665590pgc.62.2022.03.07.18.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 18:30:19 -0800 (PST)
Message-ID: <3b74b687-96ed-7601-f23d-8659dc9ad245@bytedance.com>
Date:   Tue, 8 Mar 2022 10:30:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [External] WARNING: suspicious RCU usage since next-20220304
Content-Language: en-US
To:     Corentin Labbe <clabbe.montjoie@gmail.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <YiXe+BFGuZR6Eg5y@Red>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YiXe+BFGuZR6Eg5y@Red>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022/3/7 6:31 下午, Corentin Labbe wrote:
> Hello
> 
> Booting my sun8i-a83t-bananapi-m3 since next-20220304 lead to lot of RCU warning:

Hello, thanks for the report. I've send a fix patch[1] for review.

[1] https://lore.kernel.org/lkml/20220305034103.57123-1-zhouchengming@bytedance.com/

> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> [    0.000000] OF: fdt: Machine model: Banana Pi BPI-M3
> [    0.000000] earlycon: uart0 at MMIO32 0x01c28000 (options '')
> [    0.000000] printk: bootconsole [uart0] enabled
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] cma: Reserved 16 MiB at 0xbf000000
> [    0.000000] Zone ranges:
> [    0.000000]   Normal   [mem 0x0000000040000000-0x000000006fffffff]
> [    0.000000]   HighMem  [mem 0x0000000070000000-0x00000000bfffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000040000000-0x00000000bfffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x00000000bfffffff]
> [    0.000000] percpu: Embedded 16 pages/cpu s34740 r8192 d22604 u65536
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 522752
> [    0.000000] Kernel command line: console=ttyS0,115200n8 root=/dev/ram0 earlycon=uart,mmio32,0x01c28000 ip=dhcp
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
> [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.000000] Memory: 2017876K/2097152K available (8192K kernel code, 1395K rwdata, 2956K rodata, 1024K init, 7184K bss, 62892K reserved, 16384K cma-reserved, 1294336K highmem)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
> [    0.000000] trace event string verifier disabled
> [    0.000000] Running RCU self tests
> [    0.000000] rcu: Hierarchical RCU implementation.
> [    0.000000] rcu: 	RCU event tracing is enabled.
> [    0.000000] rcu: 	RCU lockdep checking is enabled.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
> [    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
> [    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
> [    0.000000] random: get_random_bytes called from start_kernel+0x534/0x6cc with crng_init=0
> [    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (virt).
> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
> [    0.000003] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
> [    0.008649] Switching to timer-based delay loop, resolution 41ns
> [    0.015608] clocksource: timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
> [    0.026505] Console: colour dummy device 80x30
> [    0.031367] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> [    0.039759] ... MAX_LOCKDEP_SUBCLASSES:  8
> [    0.044185] ... MAX_LOCK_DEPTH:          48
> [    0.048693] ... MAX_LOCKDEP_KEYS:        8192
> [    0.053417] ... CLASSHASH_SIZE:          4096
> [    0.058117] ... MAX_LOCKDEP_ENTRIES:     32768
> [    0.062911] ... MAX_LOCKDEP_CHAINS:      65536
> [    0.067721] ... CHAINHASH_SIZE:          32768
> [    0.072516]  memory used by lock dependency info: 4061 kB
> [    0.078364]  memory used for stack traces: 2112 kB
> [    0.083533]  per task-struct memory footprint: 1536 bytes
> [    0.089482] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=240000)
> [    0.100709] pid_max: default: 32768 minimum: 301
> [    0.106465] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
> [    0.114435] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
> [    0.125719] CPU: Testing write buffer coherency: ok
> [    0.132334] 
> [    0.134009] =============================
> [    0.138348] WARNING: suspicious RCU usage
> [    0.142679] 5.17.0-rc6-next-20220307-00130-g074e6e0284df-dirty #222 Not tainted
> [    0.150565] -----------------------------
> [    0.154901] include/linux/cgroup.h:481 suspicious rcu_dereference_check() usage!
> [    0.162883] 
> [    0.162883] other info that might help us debug this:
> [    0.162883] 
> [    0.171509] 
> [    0.171509] rcu_scheduler_active = 1, debug_locks = 1
> [    0.178546] 2 locks held by kthreadd/2:
> [    0.182694]  #0: c19216b4 (&p->pi_lock){....}-{2:2}, at: task_rq_lock+0x34/0x134
> [    0.190763]  #1: eef68b50 (&rq->__lock){-...}-{2:2}, at: task_rq_lock+0x5c/0x134
> [    0.198810] 
> [    0.198810] stack backtrace:
> [    0.203522] CPU: 0 PID: 2 Comm: kthreadd Not tainted 5.17.0-rc6-next-20220307-00130-g074e6e0284df-dirty #222
> [    0.214132] Hardware name: Allwinner A83t board
> [    0.219031]  unwind_backtrace from show_stack+0x10/0x14
> [    0.224690]  show_stack from 0xf0835e8c
> [    0.228933] 
> [    0.230564] =============================
> [    0.234891] WARNING: suspicious RCU usage
> [    0.239217] 5.17.0-rc6-next-20220307-00130-g074e6e0284df-dirty #222 Not tainted
> [    0.247108] -----------------------------
> [    0.251433] include/linux/cgroup.h:481 suspicious rcu_dereference_check() usage!
> [    0.259419] 
> [    0.259419] other info that might help us debug this:
> [    0.259419] 
> [    0.268061] 
> [    0.268061] rcu_scheduler_active = 1, debug_locks = 1
> [    0.275103] no locks held by kthreadd/2.
> [    0.279336] 
> [    0.279336] stack backtrace:
> [    0.284043] CPU: 0 PID: 2 Comm: kthreadd Not tainted 5.17.0-rc6-next-20220307-00130-g074e6e0284df-dirty #222
> [    0.294643] Hardware name: Allwinner A83t board
> [    0.299534]  unwind_backtrace from show_stack+0x10/0x14
> [    0.305193]  show_stack from 0xf0801efc
> [    0.309508] /cpus/cpu@0 missing clock-frequency property
> [    0.315324] /cpus/cpu@1 missing clock-frequency property
> [    0.321178] /cpus/cpu@2 missing clock-frequency property
> [    0.326983] /cpus/cpu@3 missing clock-frequency property
> [    0.332833] /cpus/cpu@100 missing clock-frequency property
> [    0.338835] /cpus/cpu@101 missing clock-frequency property
> [    0.344897] /cpus/cpu@102 missing clock-frequency property
> [    0.350930] /cpus/cpu@103 missing clock-frequency property
> [    0.356920] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> [    0.366264] Setting up static identity map for 0x40100000 - 0x40100060
> [    0.374286] ARM CCI driver probed
> [    0.378726] sunxi multi cluster SMP support installed
> [    0.385497] rcu: Hierarchical SRCU implementation.
> [    0.391811] 
> [    0.393463] =============================
> [    0.397800] WARNING: suspicious RCU usage
> [    0.402138] 5.17.0-rc6-next-20220307-00130-g074e6e0284df-dirty #222 Not tainted
> [    0.410033] -----------------------------
> [    0.414358] include/linux/cgroup.h:481 suspicious rcu_dereference_check() usage!
> [    0.422337] 
> [    0.422337] other info that might help us debug this:
> [    0.422337] 
> [    0.430972] 
> [    0.430972] rcu_scheduler_active = 1, debug_locks = 1
> [    0.438016] 1 lock held by migration/0/12:
> [    0.442441]  #0: eef68b50 (&rq->__lock){-...}-{2:2}, at: __schedule+0xf4/0xaa4
> [    0.450325] 
> [    0.450325] stack backtrace:
> [    0.455037] CPU: 0 PID: 12 Comm: migration/0 Not tainted 5.17.0-rc6-next-20220307-00130-g074e6e0284df-dirty #222
> [    0.466027] Hardware name: Allwinner A83t board
> [    0.470920] Stopper: 0x0 <- 0x0
> [    0.474328]  unwind_backtrace from show_stack+0x10/0x14
> [    0.479980]  show_stack from 0xf087debc
> 
> I bisect it to dc6e0818bc9a0336d9accf3ea35d146d72aa7a18 sched/cpuacct: Optimize away RCU read lock
> reverting this commit removed some RCU but the boot is clean since I reverted also 3eba0505d03a9c1eb30d40c2330c0880b22d1b3a "sched/cpuacct: Remove redundant RCU read lock"
> 
> Regards
