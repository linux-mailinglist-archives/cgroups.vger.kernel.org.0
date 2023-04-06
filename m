Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695D36D96F0
	for <lists+cgroups@lfdr.de>; Thu,  6 Apr 2023 14:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjDFMSr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Apr 2023 08:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjDFMSq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Apr 2023 08:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E041985
        for <cgroups@vger.kernel.org>; Thu,  6 Apr 2023 05:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680783485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x1I6xnPQCFgaa8GiBqNBRb9FGr8oj3ORM8xu7RlaLgc=;
        b=Sn2KDd8AQckFQTsVi8OJ4pDxV7CDrO9KXgYfwfXeIUyW9IT8qHVGDcYirKR/m86yrSTwcJ
        PnbYMbvlGa06ujMc+ZVK+yG+MuBGlTVCVx9WB780M62EV0XT7XuBBSaF8TogUoC1MYdU5f
        cRGgur/X8JbMCdmbjm6+sPnD43o3VNc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-247-XgrpVXFHNnOhM06Sbit5sw-1; Thu, 06 Apr 2023 08:18:00 -0400
X-MC-Unique: XgrpVXFHNnOhM06Sbit5sw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3F8B8996E2;
        Thu,  6 Apr 2023 12:17:59 +0000 (UTC)
Received: from [10.22.9.26] (unknown [10.22.9.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22F002166B26;
        Thu,  6 Apr 2023 12:17:59 +0000 (UTC)
Message-ID: <1f5e2876-8230-32b5-7bd8-99415d079896@redhat.com>
Date:   Thu, 6 Apr 2023 08:17:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/3] cgroup/cpuset: Make cpuset_fork() handle
 CLONE_INTO_CGROUP properly
Content-Language: en-US
To:     kernel test robot <yujie.liu@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        gscrivan@redhat.com
References: <202304061003.e5e0dc9c-yujie.liu@intel.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <202304061003.e5e0dc9c-yujie.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/5/23 22:51, kernel test robot wrote:
> Hello,
>
> kernel test robot noticed "WARNING:suspicious_RCU_usage" on:
>
> commit: a53ab2ba098e6839db602212831c8b62a38c2956 ("[PATCH 1/3] cgroup/cpuset: Make cpuset_fork() handle CLONE_INTO_CGROUP properly")
> url: https://github.com/intel-lab-lkp/linux/commits/Waiman-Long/cgroup-cpuset-Make-cpuset_fork-handle-CLONE_INTO_CGROUP-properly/20230331-225527
> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 62bad54b26db8bc98e28749cd76b2d890edb4258
> patch link: https://lore.kernel.org/all/20230331145045.2251683-2-longman@redhat.com/
> patch subject: [PATCH 1/3] cgroup/cpuset: Make cpuset_fork() handle CLONE_INTO_CGROUP properly
>
> in testcase: boot
>
> compiler: gcc-11
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <yujie.liu@intel.com>
> | Link: https://lore.kernel.org/oe-lkp/202304061003.e5e0dc9c-yujie.liu@intel.com
>
>
> [    2.798551][    T2] WARNING: suspicious RCU usage
> [    2.799473][    T2] 6.3.0-rc4-00162-ga53ab2ba098e #1 Not tainted
> [    2.799901][    T2] -----------------------------
> [    2.800551][    T2] include/linux/cgroup.h:437 suspicious rcu_dereference_check() usage!
> [    2.802044][    T2]
> [    2.802044][    T2] other info that might help us debug this:
> [    2.802044][    T2]
> [    2.803158][    T2]
> [    2.803158][    T2] rcu_scheduler_active = 1, debug_locks = 1
> [    2.804024][    T2] 1 lock held by kthreadd/2:
> [ 2.804851][ T2] #0: ffffffff84c38230 (cgroup_threadgroup_rwsem){.+.+}-{0:0}, at: cgroup_can_fork (kernel/cgroup/cgroup.c:6515)
> [    2.806112][    T2]
> [    2.806112][    T2] stack backtrace:
> [    2.806958][    T2] CPU: 0 PID: 2 Comm: kthreadd Not tainted 6.3.0-rc4-00162-ga53ab2ba098e #1
> [    2.807537][    T2] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
> [    2.807537][    T2] Call Trace:
> [    2.807537][    T2]  <TASK>
> [ 2.807537][ T2] dump_stack_lvl (lib/dump_stack.c:107)
> [ 2.807537][ T2] lockdep_rcu_suspicious (include/linux/context_tracking.h:153 kernel/locking/lockdep.c:6600)
> [ 2.807537][ T2] cpuset_fork (include/linux/cgroup.h:437 kernel/cgroup/cpuset.c:240 kernel/cgroup/cpuset.c:3262)
> [ 2.807537][ T2] cgroup_post_fork (kernel/cgroup/cgroup.c:6635 (discriminator 6))
> [ 2.807537][ T2] ? cgroup_cancel_fork (kernel/cgroup/cgroup.c:6573)
> [ 2.807537][ T2] ? mark_held_locks (kernel/locking/lockdep.c:4237)
> [ 2.807537][ T2] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4529)
> [ 2.807537][ T2] copy_process (kernel/fork.c:2499)
> [ 2.807537][ T2] ? __cleanup_sighand (kernel/fork.c:2013)
> [ 2.807537][ T2] ? __lock_acquire (kernel/locking/lockdep.c:186 kernel/locking/lockdep.c:3836 kernel/locking/lockdep.c:5056)
> [ 2.807537][ T2] kernel_clone (include/linux/random.h:26 kernel/fork.c:2680)
> [ 2.807537][ T2] ? create_io_thread (kernel/fork.c:2639)
> [ 2.807537][ T2] ? mark_usage (kernel/locking/lockdep.c:4914)
> [ 2.807537][ T2] ? finish_task_switch+0x21c/0x910
> [ 2.807537][ T2] ? __switch_to (arch/x86/include/asm/bitops.h:55 include/asm-generic/bitops/instrumented-atomic.h:29 include/linux/thread_info.h:89 arch/x86/include/asm/fpu/sched.h:65 arch/x86/kernel/process_64.c:623)
> [ 2.807537][ T2] kernel_thread (kernel/fork.c:2729)
> [ 2.807537][ T2] ? __ia32_sys_clone3 (kernel/fork.c:2729)
> [ 2.807537][ T2] ? lock_downgrade (kernel/locking/lockdep.c:5321)
> [ 2.807537][ T2] ? kthread_complete_and_exit (kernel/kthread.c:331)
> [ 2.807537][ T2] ? do_raw_spin_unlock (arch/x86/include/asm/atomic.h:29 include/linux/atomic/atomic-instrumented.h:28 include/asm-generic/qspinlock.h:57 kernel/locking/spinlock_debug.c:100 kernel/locking/spinlock_debug.c:140)
> [ 2.807537][ T2] kthreadd (kernel/kthread.c:400 kernel/kthread.c:746)
> [ 2.807537][ T2] ? kthread_is_per_cpu (kernel/kthread.c:719)
> [ 2.807537][ T2] ret_from_fork (arch/x86/entry/entry_64.S:314)
> [    2.807537][    T2]  </TASK>
>
It looks like task_cs() can only be used under rcu_read_lock(). I will 
update the patch to add that.

Thanks,
Longman

