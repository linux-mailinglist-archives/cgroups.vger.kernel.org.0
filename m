Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBB85EBF0C
	for <lists+cgroups@lfdr.de>; Tue, 27 Sep 2022 11:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiI0Jyr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Sep 2022 05:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiI0Jyp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Sep 2022 05:54:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2482716;
        Tue, 27 Sep 2022 02:54:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BEA8821CFD;
        Tue, 27 Sep 2022 09:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664272478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QJfGdq9baQH2ScX6nHHu6Y6xKBY8N+rt3EDU2OoSPuU=;
        b=W62LZAXmL7LuA2+8iKdZJJ6p2TczKN8aX/TVKkDaB3kC745rAziOdT0nehKsb1KlCJXW6p
        0LS38Ph5NCG4dfDfv0hfc/ONtL9Imk2Y0SJWnZI7Fir23Btd3vY3PISsksefNm1yds0Fay
        6qeHzv6ndOzvwj9qXmZMW8aA/BJGuow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664272478;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QJfGdq9baQH2ScX6nHHu6Y6xKBY8N+rt3EDU2OoSPuU=;
        b=VGxsD5THLCFE4mBmKkrTUBGAff9uopovzR8xdfIU4ZBXDchGk1tzX+NTBGSL0JpQYcZjoD
        bwU3w9R2E6lyB4BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 758EE139B3;
        Tue, 27 Sep 2022 09:54:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gcULHF7IMmMqQAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 27 Sep 2022 09:54:38 +0000
Message-ID: <eca7d9b3-9831-5d04-1f39-8976765df87a@suse.cz>
Date:   Tue, 27 Sep 2022 11:54:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [sparc64] fails to boot, (was: Re: [PATCH memcg v6] net: set
 proper memcg for net_init hooks allocations)
To:     Anatoly Pugachev <matorola@gmail.com>,
        Vasily Averin <vvs@openvz.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, cgroups@vger.kernel.org,
        sparclinux@vger.kernel.org, regressions@lists.linux.dev
References: <6b362c6e-9c80-4344-9430-b831f9871a3c@openvz.org>
 <f9394752-e272-9bf9-645f-a18c56d1c4ec@openvz.org>
 <20220918092849.GA10314@u164.east.ru>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220918092849.GA10314@u164.east.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/18/22 11:28, Anatoly Pugachev wrote:
> On Fri, Jun 03, 2022 at 07:19:43AM +0300, Vasily Averin wrote:
>> __register_pernet_operations() executes init hook of registered
>> pernet_operation structure in all existing net namespaces.
>> 
>> Typically, these hooks are called by a process associated with
>> the specified net namespace, and all __GFP_ACCOUNT marked
>> allocation are accounted for corresponding container/memcg.
>> 
>> However __register_pernet_operations() calls the hooks in the same
>> context, and as a result all marked allocations are accounted
>> to one memcg for all processed net namespaces.
>> 
>> This patch adjusts active memcg for each net namespace and helps
>> to account memory allocated inside ops_init() into the proper memcg.
>> 
>> Signed-off-by: Vasily Averin <vvs@openvz.org>
>> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
>> Acked-by: Shakeel Butt <shakeelb@google.com>
>> ---
>> v6: re-based to current upstream (v5.18-11267-gb00ed48bb0a7)
> 
> 
> Hello!
> 
> I'm unable to boot my sparc64 VM anymore (5.19 still boots, 6.0-rc1 does not),
> bisected up to this patch,
> 
> mator@ttip:~/linux-2.6$ git bisect bad
> 1d0403d20f6c281cb3d14c5f1db5317caeec48e9 is the first bad commit
> commit 1d0403d20f6c281cb3d14c5f1db5317caeec48e9
> Author: Vasily Averin <vvs@openvz.org>
> Date:   Fri Jun 3 07:19:43 2022 +0300
> 
>     net: set proper memcg for net_init hooks allocations
> 
>     __register_pernet_operations() executes init hook of registered
>     pernet_operation structure in all existing net namespaces.
> 
>     Typically, these hooks are called by a process associated with the
>     specified net namespace, and all __GFP_ACCOUNT marked allocation are
>     accounted for corresponding container/memcg.
> 
>     However __register_pernet_operations() calls the hooks in the same
>     context, and as a result all marked allocations are accounted to one memcg
>     for all processed net namespaces.
> 
>     This patch adjusts active memcg for each net namespace and helps to
>     account memory allocated inside ops_init() into the proper memcg.
> 
>     Link: https://lkml.kernel.org/r/f9394752-e272-9bf9-645f-a18c56d1c4ec@openvz.org
>     Signed-off-by: Vasily Averin <vvs@openvz.org>
>     Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
>     Acked-by: Shakeel Butt <shakeelb@google.com>
>     Cc: Michal Koutný <mkoutny@suse.com>
>     Cc: Vlastimil Babka <vbabka@suse.cz>
>     Cc: Michal Hocko <mhocko@suse.com>
>     Cc: Florian Westphal <fw@strlen.de>
>     Cc: David S. Miller <davem@davemloft.net>
>     Cc: Jakub Kicinski <kuba@kernel.org>
>     Cc: Paolo Abeni <pabeni@redhat.com>
>     Cc: Eric Dumazet <edumazet@google.com>
>     Cc: Johannes Weiner <hannes@cmpxchg.org>
>     Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>     Cc: Linux Kernel Functional Testing <lkft@linaro.org>
>     Cc: Muchun Song <songmuchun@bytedance.com>
>     Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
>     Cc: Qian Cai <quic_qiancai@quicinc.com>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
>  include/linux/memcontrol.h | 47 +++++++++++++++++++++++++++++++++++++++++++++-
>  net/core/net_namespace.c   |  7 +++++++
>  2 files changed, 53 insertions(+), 1 deletion(-)
> 
> getting the following kernel OOPS:
> 
> 
> [    0.000010] PROMLIB: Sun IEEE Boot Prom 'OBP 4.38.17 2019/01/25 08:22'
> [    0.000028] PROMLIB: Root node compatible: sun4v
> [    0.000070] Linux version 5.19.0-rc2-00025-g1d0403d20f6c (mator@ttip) (gcc (Debian 12.2.0-2) 12.2.0, GNU ld (GNU Binutils for Debian) 2.38.90.20220713) #376 SMP Sun Sep 18 02:22:43 MSK 2022
> [    0.000098] printk: debug: skip boot console de-registration.
> [    0.000438] printk: bootconsole [earlyprom0] enabled
> [    0.000491] ARCH: SUN4V
> [    0.000534] Ethernet address: 00:14:4f:fa:06:f2
> [    0.000583] MM: PAGE_OFFSET is 0xfff8000000000000 (max_phys_bits == 47)
> [    0.000644] MM: VMALLOC [0x0000000100000000 --> 0x0006000000000000]
> [    0.000704] MM: VMEMMAP [0x0006000000000000 --> 0x000c000000000000]
> [    0.014651] Kernel: Using 5 locked TLB entries for main kernel image.
> [    0.014719] Remapping the kernel...
> [    0.014750] done.
> [    0.033774] OF stdout device is: /virtual-devices@100/console@1
> [    0.033838] PROM: Built device tree with 67601 bytes of memory.
> [    0.033896] MDESC: Size is 24208 bytes.
> [    0.033989] PLATFORM: banner-name [SPARC T5-2]
> [    0.034034] PLATFORM: name [ORCL,SPARC-T5-2]
> [    0.034076] PLATFORM: hostid [84fa06f2]
> [    0.034113] PLATFORM: serial# [0035260e]
> [    0.034154] PLATFORM: stick-frequency [3b9aca00]
> [    0.034196] PLATFORM: mac-address [144ffa06f2]
> [    0.034238] PLATFORM: watchdog-resolution [1000 ms]
> [    0.034284] PLATFORM: watchdog-max-timeout [31536000000 ms]
> [    0.034335] PLATFORM: max-cpus [1024]
> [    0.034419] Top of RAM: 0x42f948000, Total RAM: 0x3ff3a0000
> [    0.034474] Memory hole size: 773MB
> [    0.036430] Allocated 24576 bytes for kernel page tables.
> [    0.036506] Zone ranges:
> [    0.036541]   Normal   [mem 0x0000000030400000-0x000000042f947fff]
> [    0.036602] Movable zone start for each node
> [    0.036645] Early memory node ranges
> [    0.036679]   node   0: [mem 0x0000000030400000-0x000000006febffff]
> [    0.036738]   node   0: [mem 0x000000006ff40000-0x000000006ff65fff]
> [    0.036796]   node   0: [mem 0x0000000070000000-0x000000042f8b1fff]
> [    0.036854]   node   0: [mem 0x000000042f940000-0x000000042f947fff]
> [    0.036912] Initmem setup node 0 [mem 0x0000000030400000-0x000000042f947fff]
> [    0.046980] On node 0, zone Normal: 98816 pages in unavailable ranges
> [    0.047007] On node 0, zone Normal: 64 pages in unavailable ranges
> [    0.048447] On node 0, zone Normal: 77 pages in unavailable ranges
> [    0.048516] On node 0, zone Normal: 71 pages in unavailable ranges
> [    0.050336] On node 0, zone Normal: 33628 pages in unavailable ranges
> [    0.050400] Booting Linux...
> [    0.050500] CPU CAPS: [flush,stbar,swap,muldiv,v9,blkinit,n2,mul32]
> [    0.050581] CPU CAPS: [div32,v8plus,popc,vis,vis2,ASIBlkInit,fmaf,vis3]
> [    0.050663] CPU CAPS: [hpc,ima,pause,cbcond,aes,des,kasumi,camellia]
> [    0.050744] CPU CAPS: [md5,sha1,sha256,sha512,mpmul,montmul,montsqr,crc32c]
> [    0.093786] percpu: Embedded 18 pages/cpu s105824 r8192 d33440 u262144
> [    0.095225] SUN4V: Mondo queue sizes [cpu(131072) dev(16384) r(8192) nr(256)]
> [    0.095510] Built 1 zonelists, mobility grouping on.  Total pages: 2077148
> [    0.095587] Kernel command line: BOOT_IMAGE=/vmlinux-5.19.0-rc2-00025-g1d0403d20f6c root=/dev/vdiska2 ro keep_bootcon
> [    0.095745] Unknown kernel command line parameters "BOOT_IMAGE=/vmlinux-5.19.0-rc2-00025-g1d0403d20f6c", will be passed to user space.
> [    0.095851] printk: log_buf_len individual max cpu contribution: 4096 bytes
> [    0.095914] printk: log_buf_len total cpu_extra contributions: 1044480 bytes
> [    0.095973] printk: log_buf_len min size: 131072 bytes
> [    0.097772] printk: log_buf_len: 2097152 bytes
> [    0.097818] printk: early log buf free: 126264(96%)
> [    0.099466] Dentry cache hash table entries: 2097152 (order: 11, 16777216 bytes, linear)
> [    0.100365] Inode-cache hash table entries: 1048576 (order: 10, 8388608 bytes, linear)
> [    0.100439] Sorting __ex_table...
> [    0.100692] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.105101] Memory: 1259512K/16764544K available (8962K kernel code, 1702K rwdata, 3048K rodata, 632K init, 3160K bss, 289008K reserved, 0K cma-reserved)
> [    0.108565] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=256, Nodes=1
> [    0.109364] ftrace: allocating 27588 entries in 54 pages
> [    0.120238] ftrace: allocated 54 pages with 4 groups
> [    0.120513] trace event string verifier disabled
> [    0.124589] rcu: Hierarchical RCU implementation.
> [    0.124642] rcu:     RCU debug extended QS entry/exit.
> [    0.124689]  Rude variant of Tasks RCU enabled.
> [    0.124733]  Tracing variant of Tasks RCU enabled.
> [    0.124778] rcu: RCU calculated value of scheduler-enlistment delay is 26 jiffies.
> [    0.131351] NR_IRQS: 2048, nr_irqs: 2048, preallocated irqs: 1
> [    0.131438] SUN4V: Using IRQ API major 3, cookie only virqs enabled
> [    0.135353] rcu: srcu_init: Setting srcu_struct sizes to big.
> [    0.135477] clocksource: stick: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
> [    0.135579] clocksource: mult[800000] shift[23]
> [    0.135626] clockevent: mult[80000000] shift[31]
> [    0.136279] Console: colour dummy device 80x25
> [    0.136333] printk: console [tty0] enabled
> [    0.136393] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> [    0.136482] ... MAX_LOCKDEP_SUBCLASSES:  8
> [    0.136536] ... MAX_LOCK_DEPTH:          48
> [    0.136589] ... MAX_LOCKDEP_KEYS:        8192
> [    0.136645] ... CLASSHASH_SIZE:          4096
> [    0.136699] ... MAX_LOCKDEP_ENTRIES:     16384
> [    0.136756] ... MAX_LOCKDEP_CHAINS:      32768
> [    0.136811] ... CHAINHASH_SIZE:          16384
> [    0.136868]  memory used by lock dependency info: 2603 kB
> [    0.136933]  per task-struct memory footprint: 1920 bytes
> [    0.215908] Calibrating delay using timer specific routine.. 2007.88 BogoMIPS (lpj=4015778)
> [    0.216049] pid_max: default: 262144 minimum: 2048
> [    0.216772] LSM: Security Framework initializing
> [    0.217017] Unable to handle kernel paging request at virtual address 000612000002e000
> [    0.217116] tsk->{mm,active_mm}->context = 0000000000000000
> [    0.217184] tsk->{mm,active_mm}->pgd = fff8000070002000
> [    0.217247]               \|/ ____ \|/
> [    0.217247]               "@'/ .. \`@"
> [    0.217247]               /_| \__/ |_\
> [    0.217247]                  \__U_/
> [    0.217406] swapper/0(0): Oops [#1]
> [    0.217458] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc2-00025-g1d0403d20f6c #376
> [    0.217559] TSTATE: 0000009180001607 TPC: 00000000006c9118 TNPC: 00000000006c911c Y: df1f6831    Not tainted
> [    0.217673] TPC: <mem_cgroup_from_obj+0x78/0x120>
> [    0.217742] g0: 0000000000000000 g1: 0000004000000a89 g2: 0006000000000000 g3: 54256f3ea00db3c0
> [    0.217843] g4: 0000000000fdf680 g5: fff800042960e000 g6: 0000000000fc0000 g7: 0000000000000002
> [    0.217943] o0: 000612000002f688 o1: 0000000000fdffa0 o2: 22645555e843a019 o3: 24f02a9c57a00000
> [    0.218043] o4: 000000000000000d o5: 9b8bf183d547acad sp: 0000000000fc3191 ret_pc: 00000000006c90c8
> [    0.218145] RPC: <mem_cgroup_from_obj+0x28/0x120>
> [    0.218207] l0: 00000000011f31c0 l1: 0000000000000000 l2: 0000000000000000 l3: ffffffffffffffff
> [    0.218309] l4: ffffffff0000003c l5: 00000000014e3800 l6: 0000000000000000 l7: 0000000000fdac00
> [    0.218409] i0: 0000000001512d80 i1: 0000000000000000 i2: 0000000000000000 i3: 0000000000000002
> [    0.218509] i4: 00000000011f31c0 i5: 0000000000000000 i6: 0000000000fc3241 i7: 0000000000ae012c
> [    0.218609] I7: <__register_pernet_operations+0xcc/0x420>
> [    0.218681] Call Trace:
> [    0.218718] [<0000000000ae012c>] __register_pernet_operations+0xcc/0x420
> [    0.218800] [<0000000000ae04e4>] register_pernet_operations+0x64/0xa0
> [    0.218878] [<0000000000ae053c>] register_pernet_subsys+0x1c/0x40
> [    0.218955] [<0000000001199010>] net_ns_init+0xe8/0x148
> [    0.219028] [<0000000001170ed4>] start_kernel+0x5e0/0x660
> [    0.219096] [<0000000001173e28>] start_early_boot+0x2a0/0x2b0
> [    0.219169] [<0000000000cb6fe0>] tlb_fixup_done+0x4c/0x6c
> [    0.219240] [<0000000000027414>] 0x27414
> [    0.219293] Disabling lock debugging due to kernel taint
> [    0.219345] Caller[0000000000ae012c]: __register_pernet_operations+0xcc/0x420
> [    0.220423] Caller[0000000000ae04e4]: register_pernet_operations+0x64/0xa0
> [    0.220490] Caller[0000000000ae053c]: register_pernet_subsys+0x1c/0x40
> [    0.220551] Caller[0000000001199010]: net_ns_init+0xe8/0x148
> [    0.220608] Caller[0000000001170ed4]: start_kernel+0x5e0/0x660
> [    0.220664] Caller[0000000001173e28]: start_early_boot+0x2a0/0x2b0
> [    0.220723] Caller[0000000000cb6fe0]: tlb_fixup_done+0x4c/0x6c
> [    0.220780] Caller[0000000000027414]: 0x27414
> [    0.220823] Instruction DUMP:
> [    0.220825]  90020001
> [    0.220858]  912a3003
> [    0.220886]  90020002
> [    0.220912] <c25a2008>
> [    0.220939]  84086001
> [    0.220967]  82007fff
> [    0.220993]  83788408
> [    0.221020]  90100001
> [    0.221047]  c25a0000
> [    0.221074]
> [    0.221120] Kernel panic - not syncing: Attempted to kill the idle task!
> [    0.221183] Unable to handle kernel NULL pointer dereference
> [    0.221237] tsk->{mm,active_mm}->context = 0000000000000000
> [    0.221287] tsk->{mm,active_mm}->pgd = fff8000070002000
> [    0.221335]               \|/ ____ \|/
> [    0.221335]               "@'/ .. \`@"
> [    0.221335]               /_| \__/ |_\
> [    0.221335]                  \__U_/
> [    0.221457] swapper/0(0): Oops [#2]
> [    0.221494] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D           5.19.0-rc2-00025-g1d0403d20f6c #376
> [    0.221580] TSTATE: 0000004480e01607 TPC: 0000000000a64030 TNPC: 0000000000a64034 Y: 000008a3    Tainted: G      D
> [    0.221678] TPC: <sunhv_migrate_hvcons_irq+0x30/0x60>
> [    0.221731] g0: 00000000014e3800 g1: 0000000000000020 g2: 0000000000000000 g3: 000000000000009d
> [    0.221808] g4: 0000000000fdf680 g5: fff800042960e000 g6: 0000000000fc0000 g7: 0000000000000001
> [    0.222888] o0: 000000000000003c o1: 0000000000cc9400 o2: 0000000000000000 o3: 0000000000ece2a0
> [    0.222966] o4: 6c65207461736b21 o5: 0000000000000000 sp: 0000000000fc2b21 ret_pc: 00000000004dbfdc
> [    0.223046] RPC: <vprintk+0x5c/0x80>
> [    0.223087] l0: 0000000001228e40 l1: 0000000000000020 l2: 0000000000eceb78 l3: 0000000f477791df
> [    0.223167] l4: f477792d02f140eb l5: 00000000014e3800 l6: 0000000000000000 l7: 0000000000000001
> [    0.223243] i0: 0000000000000000 i1: 0000000000fc3508 i2: 0000000000eceb78 i3: 0000000000fc35c8
> [    0.223320] i4: 0000000000a1c888 i5: 0000000001229220 i6: 0000000000fc2bd1 i7: 0000000000440a1c
> [    0.223397] I7: <smp_send_stop+0x3c/0x100>
> [    0.223443] Call Trace:
> [    0.223470] [<0000000000440a1c>] smp_send_stop+0x3c/0x100
> [    0.223522] [<0000000000cac4a0>] panic+0x104/0x374
> [    0.223572] [<000000000046a4fc>] make_task_dead+0x5c/0xe0
> [    0.223629] [<0000000000cab660>] die_if_kernel+0x258/0x264
> [    0.223681] [<0000000000cc3624>] unhandled_fault+0x98/0xb4
> [    0.223737] [<0000000000cc3e54>] do_sparc64_fault+0x814/0xa00
> [    0.223792] [<0000000000407714>] sparc64_realfault_common+0x10/0x20
> [    0.223858] [<00000000006c9118>] mem_cgroup_from_obj+0x78/0x120
> [    0.223914] [<0000000000ae012c>] __register_pernet_operations+0xcc/0x420
> [    0.223976] [<0000000000ae04e4>] register_pernet_operations+0x64/0xa0
> [    0.224038] [<0000000000ae053c>] register_pernet_subsys+0x1c/0x40
> [    0.224094] [<0000000001199010>] net_ns_init+0xe8/0x148
> [    0.224147] [<0000000001170ed4>] start_kernel+0x5e0/0x660
> [    0.224198] [<0000000001173e28>] start_early_boot+0x2a0/0x2b0
> [    0.224254] [<0000000000cb6fe0>] tlb_fixup_done+0x4c/0x6c
> [    0.225308] [<0000000000027414>] 0x27414
> [    0.225349] Caller[0000000000440a1c]: smp_send_stop+0x3c/0x100
> [    0.225406] Caller[0000000000cac4a0]: panic+0x104/0x374
> [    0.225456] Caller[000000000046a4fc]: make_task_dead+0x5c/0xe0
> [    0.225512] Caller[0000000000cab660]: die_if_kernel+0x258/0x264
> [    0.225567] Caller[0000000000cc3624]: unhandled_fault+0x98/0xb4
> [    0.225624] Caller[0000000000cc3e54]: do_sparc64_fault+0x814/0xa00
> [    0.225685] Caller[0000000000407714]: sparc64_realfault_common+0x10/0x20
> [    0.225747] Caller[00000000006c90c8]: mem_cgroup_from_obj+0x28/0x120
> [    0.225806] Caller[0000000000ae012c]: __register_pernet_operations+0xcc/0x420
> [    0.225875] Caller[0000000000ae04e4]: register_pernet_operations+0x64/0xa0
> [    0.225940] Caller[0000000000ae053c]: register_pernet_subsys+0x1c/0x40
> [    0.226001] Caller[0000000001199010]: net_ns_init+0xe8/0x148
> [    0.226058] Caller[0000000001170ed4]: start_kernel+0x5e0/0x660
> [    0.226113] Caller[0000000001173e28]: start_early_boot+0x2a0/0x2b0
> [    0.226172] Caller[0000000000cb6fe0]: tlb_fixup_done+0x4c/0x6c
> [    0.226228] Caller[0000000000027414]: 0x27414
> [    0.226271] Instruction DUMP:
> [    0.226273]  83287005
> [    0.226305]  13003325
> [    0.226333]  82204018
> [    0.226359] <d000a0d8>
> [    0.226385]  92126358
> [    0.226412]  7fe9f0e2
> [    0.226439]  92024001
> [    0.226465]  81cfe008
> [    0.226492]  01000000
> [    0.226519]
> [    0.226562] Kernel panic - not syncing: Attempted to kill the idle task!
> [    0.226626] Unable to handle kernel NULL pointer dereference
> [    0.226678] tsk->{mm,active_mm}->context = 0000000000000000
> [    0.226729] tsk->{mm,active_mm}->pgd = fff8000070002000
> 

#regzbot introduced: 1d0403d20f6c
