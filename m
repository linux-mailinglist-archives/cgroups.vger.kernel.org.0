Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40767BED83
	for <lists+cgroups@lfdr.de>; Mon,  9 Oct 2023 23:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378682AbjJIVnr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 17:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378792AbjJIVnq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 17:43:46 -0400
X-Greylist: delayed 108229 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Oct 2023 14:43:45 PDT
Received: from out-204.mta1.migadu.com (out-204.mta1.migadu.com [IPv6:2001:41d0:203:375::cc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099C59D
        for <cgroups@vger.kernel.org>; Mon,  9 Oct 2023 14:43:45 -0700 (PDT)
Date:   Mon, 9 Oct 2023 14:43:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696887821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1A4XKHpL4U37Y/3uWnlttIXwNnAiPoRHRzYT8xs8nBY=;
        b=KFlvIrsLSr17ZzklTQ2tvr9mLaQwlNb0kyXDcwJ1Vc11nKinmN11/CZM4ZcKaoXmRFgQ+e
        VaOSfJuXEeBXVhflxnpmi1pii8pqifhnhmFZ6lwrlMu92HUjN60SQW3fO/z4zwAt6Vv1Ob
        +r/xIziKw4lVpmR5cZAL2tFwU9YyiWA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Lucas Karpinski <lkarpins@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        David Rientjes <rientjes@google.com>,
        Dennis Zhou <dennis@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: selftests: cgroup: test_core - Unable to handle kernel NULL
 pointer dereference at virtual address
Message-ID: <ZSR0BlS164-Y--ib@P9FQF9L96D>
References: <CA+G9fYsJA4fkLCDdXfCdjqJz3q3K0TErgKjypuLmPZ=EU3MbDg@mail.gmail.com>
 <ZSLNQjzoYcLq1hEo@P9FQF9L96D>
 <CA+G9fYuH_-fRHS2Kjvc8FcoV=pz9jBtYvXHOcsvUgcAHOeqXWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuH_-fRHS2Kjvc8FcoV=pz9jBtYvXHOcsvUgcAHOeqXWA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 09, 2023 at 04:08:13PM +0530, Naresh Kamboju wrote:
> On Sun, 8 Oct 2023 at 21:09, Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > On Sun, Oct 08, 2023 at 11:30:52AM +0530, Naresh Kamboju wrote:
> > > While running selftests: cgroup: test_kmem on FVP following kernel crash
> > > noticed on Linux next 6.6.0-rc4-next-20231006.
> >
> > Hi Naresh!
> >
> > Thank you for the report!
> >
> > I've tried to reproduce it, but wasn't successful so far: I've run test_kmem
> > for several hundred times and haven't seen the crash.
> 
> If you look at the problematic test case is
> selftests: cgroup: test_core

Ah, got it, and immediately reproduced (and fixed).
Thank you once again for all your effort!

The problem happens because some kernel allocations happen after
mem_cgroup_exit(), which was dropping the reference to task->objcg,
but not zeroing the pointer, so it eventually caused a double-free.

I gonna post an updated version of my patchset, which introduced the issue,
with the fix merged (and some other minor changes).

Thanks!


> 
> I recommend to run
> ./run_kselftest.sh -c cgroup
> 
> >
> > Can you, please, provide some additional information?
> > How easy to reproduce it?
> 
> It is always reproducible on qemu-arm64, FVP, x86 with a given config.
> 
> > Do you see it every time or with some probability?
> 
> Always with selftests: cgroup: test_core.
> I generally run all selftests: cgroup: *
> 
> > Do you see it on other platforms?
> qemu-arm64, FVP, x86.
> 
> > Can you, please, check where exactly the crash happens using addr2line?
> 
> I have provided links to build, test logs and steps to reproduce scripts.
> 
> Is this an interesting log ?
> 
> # selftests: cgroup: test_core
> # ok 1 test_cgcore_internal_process_constraint
> # ok 2 test_cgcore_top_down_constraint_enable
> # ok 3 test_cgcore_top_down_constraint_disable
> # ok 4 test_cgcore_no_internal_process_constraint_on_threads
> # ok 5 test_cgcore_parent_becomes_threaded
> # ok 6 test_cgcore_invalid_domain
> # ok 7 test_cgcore_populated
> # ok 8 test_cgcore_proc_migration
> # ok 9 test_cgcore_thread_migration
> # ok 10 test_cgcore_destroy
> # ok 11 test_cgcore_lesser_euid_open
> # ok 12 test_cgcore_lesser_ns_open
> <1>[  188.504854] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000000
> <1>[  188.505724] Mem abort info:
> <1>[  188.506036]   ESR = 0x0000000096000044
> <1>[  188.507539]   EC = 0x25: DABT (current EL), IL = 32 bits
> <1>[  188.508268]   SET = 0, FnV = 0
> <1>[  188.508895]   EA = 0, S1PTW = 0
> <1>[  188.509517]   FSC = 0x04: level 0 translation fault
> <1>[  188.510279] Data abort info:
> <1>[  188.511513]   ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
> <1>[  188.512757]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
> <1>[  188.513333]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> <1>[  188.514316] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000104934000
> <1>[  188.516277] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
> <0>[  188.517886] Internal error: Oops: 0000000096000044 [#1] PREEMPT SMP
> <4>[  188.518838] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce
> sha512_ce sha512_arm64 fuse drm backlight dm_mod ip_tables x_tables
> <4>[  188.521105] CPU: 0 PID: 57 Comm: kworker/0:2 Not tainted
> 6.6.0-rc4-next-20231006 #1
> <4>[  188.521750] Hardware name: linux,dummy-virt (DT)
> <4>[  188.522915] Workqueue: cgroup_destroy css_free_rwork_fn
> <4>[  188.523572] pstate: 03400009 (nzcv daif +PAN -UAO +TCO +DIT
> -SSBS BTYPE=--)
> <4>[ 188.524569] pc : percpu_ref_put_many.constprop.0
> (arch/arm64/include/asm/atomic_lse.h:169 (discriminator 1)
> arch/arm64/include/asm/atomic_lse.h:184 (discriminator 1)
> arch/arm64/include/asm/atomic_lse.h:204 (discriminator 1)
> arch/arm64/include/asm/atomic.h:92 (discriminator 1)
> include/linux/atomic/atomic-arch-fallback.h:2886 (discriminator 1)
> include/linux/atomic/atomic-arch-fallback.h:4351 (discriminator 1)
> include/linux/atomic/atomic-long.h:1543 (discriminator 1)
> include/linux/atomic/atomic-instrumented.h:4486 (discriminator 1)
> include/linux/percpu-refcount.h:334 (discriminator 1))
> <4>[ 188.525451] lr : percpu_ref_put_many.constprop.0
> (include/linux/percpu-refcount.h:174 (discriminator 2)
> include/linux/percpu-refcount.h:332 (discriminator 2))
> <4>[  188.526230] sp : ffff8000803d3ca0
> <4>[  188.526902] x29: ffff8000803d3ca0 x28: 0000000000000000 x27:
> 0000000000000000
> <4>[  188.527976] x26: 0000000000000000 x25: ffff0000c1112e80 x24:
> ffff0000c002da05
> <4>[  188.528965] x23: 0000000000000030 x22: ffffafd0c976a000 x21:
> ffffafd0c976cb70
> <4>[  188.529927] x20: ffff0000d67fa000 x19: ffff0000d32f44c0 x18:
> 0000000000000000
> <4>[  188.531096] x17: 0000000000000000 x16: 0000000000000000 x15:
> 0000000000000000
> <4>[  188.532244] x14: 0000000000000004 x13: ffffafd0c9787258 x12:
> 0000000000000000
> <4>[  188.533548] x11: ffff0000c0402e58 x10: ffff0000c0402db0 x9 :
> ffffafd0c6f86a90
> <4>[  188.535274] x8 : ffff8000803d3b68 x7 : 0000000000000000 x6 :
> 0000000000000001
> <4>[  188.536318] x5 : ffffafd0c976a000 x4 : ffffafd0c976a288 x3 :
> 0000000000000000
> <4>[  188.537144] x2 : ffff0000c0acbe00 x1 : 0000000000000000 x0 :
> ffffffffffffffff
> <4>[  188.538091] Call trace:
> <4>[ 188.538883] percpu_ref_put_many.constprop.0
> (arch/arm64/include/asm/atomic_lse.h:169 (discriminator 1)
> arch/arm64/include/asm/atomic_lse.h:184 (discriminator 1)
> arch/arm64/include/asm/atomic_lse.h:204 (discriminator 1)
> arch/arm64/include/asm/atomic.h:92 (discriminator 1)
> include/linux/atomic/atomic-arch-fallback.h:2886 (discriminator 1)
> include/linux/atomic/atomic-arch-fallback.h:4351 (discriminator 1)
> include/linux/atomic/atomic-long.h:1543 (discriminator 1)
> include/linux/atomic/atomic-instrumented.h:4486 (discriminator 1)
> include/linux/percpu-refcount.h:334 (discriminator 1))
> <4>[ 188.539208] __mem_cgroup_free (include/linux/find.h:203
> include/linux/nodemask.h:266 mm/memcontrol.c:5446)
> <4>[ 188.539559] mem_cgroup_css_free (mm/memcontrol.c:5682)
> <4>[ 188.543093] css_free_rwork_fn (include/linux/spinlock.h:356
> kernel/cgroup/cgroup.c:350 kernel/cgroup/cgroup.c:5377)
> <4>[ 188.544324] process_one_work (kernel/workqueue.c:2635)
> <4>[ 188.545045] worker_thread (kernel/workqueue.c:2697 (discriminator
> 2) kernel/workqueue.c:2784 (discriminator 2))
> <4>[ 188.545710] kthread (kernel/kthread.c:388)
> <4>[ 188.546690] ret_from_fork (arch/arm64/kernel/entry.S:858)
> <0>[ 188.547769] Code: d65f03c0 f9400661 d503201f 92800000 (f8e00020)
> All code
> ========
>    0: d65f03c0 ret
>    4: f9400661 ldr x1, [x19, #8]
>    8: d503201f nop
>    c: 92800000 mov x0, #0xffffffffffffffff    // #-1
>   10:* f8e00020 ldaddal x0, x0, [x1] <-- trapping instruction
> 
> Code starting with the faulting instruction
> ===========================================
>    0: f8e00020 ldaddal x0, x0, [x1]
> <4>[  188.549059] ---[ end trace 0000000000000000 ]---
> ok 3 selftests: cgroup: test_core
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> 
> Links:
> logs: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/naresh/tests/2WWLlrB6hfNAc0btHy8LPxuQefp
> 
> Build: https://storage.tuxsuite.com/public/linaro/naresh/builds/2WWGnN6pGnGdueSyID8ZTdS5EVv/
> Config: https://storage.tuxsuite.com/public/linaro/naresh/builds/2WWGnN6pGnGdueSyID8ZTdS5EVv/config
> 
> Steps to reproduce:
> - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/naresh/tests/2WWLlrB6hfNAc0btHy8LPxuQefp/reproducer
> 
> - Naresh
