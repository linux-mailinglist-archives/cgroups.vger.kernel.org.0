Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B2A36714A
	for <lists+cgroups@lfdr.de>; Wed, 21 Apr 2021 19:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239298AbhDUR1b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Wed, 21 Apr 2021 13:27:31 -0400
Received: from jptosegrel01.sonyericsson.com ([124.215.201.71]:4469 "EHLO
        JPTOSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240604AbhDUR1b (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Apr 2021 13:27:31 -0400
X-Greylist: delayed 1262 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Apr 2021 13:27:30 EDT
Subject: Re: [RFC] memory reserve for userspace oom-killer
To:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
CC:     Greg Thelen <gthelen@google.com>,
        Dragos Sbirlea <dragoss@google.com>,
        Priya Duraisamy <padmapriyad@google.com>
References: <CALvZod7vtDxJZtNhn81V=oE-EPOf=4KZB2Bv6Giz+u3bFFyOLg@mail.gmail.com>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <699e51ba-825d-b243-8205-4d8cff478a66@sony.com>
Date:   Wed, 21 Apr 2021 19:05:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CALvZod7vtDxJZtNhn81V=oE-EPOf=4KZB2Bv6Giz+u3bFFyOLg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=DLnxHBFb c=1 sm=1 tr=0 a=9drRLWArJOlETflmpfiyCA==:117 a=IkcTkHD0fZMA:10 a=3YhXtTcJ-WEA:10 a=DDOyTI_5AAAA:8 a=upAolG9lt1D93ADSiFAA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10 a=i4HhKqK894AA:10 a=_BcfOz0m4U4ohdxiHPKc:22
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/20/21 3:44 AM, Shakeel Butt wrote:
> Proposal: Provide memory guarantees to userspace oom-killer.
>
> Background:
>
> Issues with kernel oom-killer:
> 1. Very conservative and prefer to reclaim. Applications can suffer
> for a long time.
> 2. Borrows the context of the allocator which can be resource limited
> (low sched priority or limited CPU quota).
> 3. Serialized by global lock.
> 4. Very simplistic oom victim selection policy.
>
> These issues are resolved through userspace oom-killer by:
> 1. Ability to monitor arbitrary metrics (PSI, vmstat, memcg stats) to
> early detect suffering.
> 2. Independent process context which can be given dedicated CPU quota
> and high scheduling priority.
> 3. Can be more aggressive as required.
> 4. Can implement sophisticated business logic/policies.
>
> Android's LMKD and Facebook's oomd are the prime examples of userspace
> oom-killers. One of the biggest challenges for userspace oom-killers
> is to potentially function under intense memory pressure and are prone
> to getting stuck in memory reclaim themselves. Current userspace
> oom-killers aim to avoid this situation by preallocating user memory
> and protecting themselves from global reclaim by either mlocking or
> memory.min. However a new allocation from userspace oom-killer can
> still get stuck in the reclaim and policy rich oom-killer do trigger
> new allocations through syscalls or even heap.
>
> Our attempt of userspace oom-killer faces similar challenges.
> Particularly at the tail on the very highly utilized machines we have
> observed userspace oom-killer spectacularly failing in many possible
> ways in the direct reclaim. We have seen oom-killer stuck in direct
> reclaim throttling, stuck in reclaim and allocations from interrupts
> keep stealing reclaimed memory. We have even observed systems where
> all the processes were stuck in throttle_direct_reclaim() and only
> kswapd was running and the interrupts kept stealing the memory
> reclaimed by kswapd.
>
> To reliably solve this problem, we need to give guaranteed memory to
> the userspace oom-killer. At the moment we are contemplating between
> the following options and I would like to get some feedback.
>
> 1. prctl(PF_MEMALLOC)
>
> The idea is to give userspace oom-killer (just one thread which is
> finding the appropriate victims and will be sending SIGKILLs) access
> to MEMALLOC reserves. Most of the time the preallocation, mlock and
> memory.min will be good enough but for rare occasions, when the
> userspace oom-killer needs to allocate, the PF_MEMALLOC flag will
> protect it from reclaim and let the allocation dip into the memory
> reserves.
>
> The misuse of this feature would be risky but it can be limited to
> privileged applications. Userspace oom-killer is the only appropriate
> user of this feature. This option is simple to implement.
>
> 2. Mempool
>
> The idea is to preallocate mempool with a given amount of memory for
> userspace oom-killer. Preferably this will be per-thread and
> oom-killer can preallocate mempool for its specific threads. The core
> page allocator can check before going to the reclaim path if the task
> has private access to the mempool and return page from it if yes.
>
> This option would be more complicated than the previous option as the
> lifecycle of the page from the mempool would be more sophisticated.
> Additionally the current mempool does not handle higher order pages
> and we might need to extend it to allow such allocations. Though this
> feature might have more use-cases and it would be less risky than the
> previous option.
>
> Another idea I had was to use kthread based oom-killer and provide the
> policies through eBPF program. Though I am not sure how to make it
> monitor arbitrary metrics and if that can be done without any
> allocations.
>
> Please do provide feedback on these approaches.
>
> thanks,
> Shakeel

I think this is the wrong way to go.

I sent a patch for android lowmemorykiller some years ago.

http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2017-February/100319.html

It has been improved since than, so it can act handle oom callbacks, it can act on vmpressure and psi
and as a shrinker. The patches has not been ported to resent kernels though.

I don't think vmpressure and psi is that relevant now. (They are what userspace act on)  But the basic idea is to have a priority queue
within the kernel. It need pick up new processes and dying process.  And then it has a order, and that
is set with oom adj values by activity manager in android.  I see this model can be reused for
something that is between a standard oom and userspace.  Instead of vmpressure and psi
a watchdog might be a better way.  If userspace (in android the activity manager or lmkd) does not kick the watchdog,
the watchdog bite the task according to the priority and kills it.  This priority list does not have to be a list generated 
within kernel. But it has the advantage that you inherent parents properties.  We use a rb-tree for that.

All that is missing is the watchdog.




