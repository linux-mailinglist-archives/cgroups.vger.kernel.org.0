Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DCF6A5AA1
	for <lists+cgroups@lfdr.de>; Tue, 28 Feb 2023 15:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjB1OJR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Feb 2023 09:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjB1OJP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Feb 2023 09:09:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 860B610413;
        Tue, 28 Feb 2023 06:09:12 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C5D6C14;
        Tue, 28 Feb 2023 06:09:55 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78A883F67D;
        Tue, 28 Feb 2023 06:09:08 -0800 (PST)
Message-ID: <5a1e58bf-7eb2-bd7a-7e19-7864428a2b83@arm.com>
Date:   Tue, 28 Feb 2023 15:09:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] sched: cpuset: Don't rebuild root domains on
 suspend-resume
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Zefan Li <lizefan.x@bytedance.com>, linux-s390@vger.kernel.org,
        x86@kernel.org
References: <20230206221428.2125324-1-qyousef@layalina.io>
 <20230223153859.37tqoqk33oc6tv7o@airbuntu>
 <5f087dd8-3e39-ce83-fe24-afa5179c05d9@arm.com>
 <20230227205725.dipvh3i7dvyrv4tv@airbuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230227205725.dipvh3i7dvyrv4tv@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 27/02/2023 21:57, Qais Yousef wrote:
> On 02/24/23 16:14, Dietmar Eggemann wrote:
>> On 23/02/2023 16:38, Qais Yousef wrote:
>>
>> IMHO the patch title is misleading since what you want to avoid in
>> certain cases is that the RD DL accounting is updated.
> 
> The code calls it rebuild_root_domain() ..
> 
>>
>>> On 02/06/23 22:14, Qais Yousef wrote:
>>>> Commit f9a25f776d78 ("cpusets: Rebuild root domain deadline accounting information")
> 
> .. and so is the original patch title.
> 
> I think I have enough explanation in the commit message and renamed the
> function name to be more descriptive too.

True but the title doesn't really mention the actual issue here ...
which is DL accounting. Once I read your email it became clear.

[...]

>> There is already a somehow hidden interface for `sd/rd rebuild`
>>
>>   int __weak arch_update_cpu_topology(void)
>>
>> which lets partition_sched_domains_locked() figure out whether sched
>> domains have to be rebuild..
>>
>> But in your case it is more on the interface `cpuset/hotplug -> sd/rd
>> rebuild` and not only `arch -> `sd/rd rebuild``.
>>
>> IMHO, it would be still nice to have only one way to tell `sd/rd
>> rebuild` what to do and what not to do during sd/rd/(pd) rebuild.
> 
> IIUC you're suggesting to introduce some new mechanism to detect if hotplug has
> lead to a cpu to disappear or not and use that instead? Are you saying I can
> use arch_update_cpu_topology() for that? Something like this?
> 
> 	diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> 	index e5ddc8e11e5d..60c3dcf06f0d 100644
> 	--- a/kernel/cgroup/cpuset.c
> 	+++ b/kernel/cgroup/cpuset.c
> 	@@ -1122,7 +1122,7 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
> 	 {
> 		mutex_lock(&sched_domains_mutex);
> 		partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
> 	-       if (update_dl_accounting)
> 	+       if (arch_update_cpu_topology())
> 			update_dl_rd_accounting();
> 		mutex_unlock(&sched_domains_mutex);
> 	 }

No, this is not what I meant. I'm just saying the:

  partition_sched_domains_locked()
    new_topology = arch_update_cpu_topology();

has to be considered here as well since we do a
`dl_clear_root_domain(rd)` (1) in partition_sched_domains_locked() for
!new_topology.

And (1) requires the `update_tasks_root_domain()` to happen later.

So there are cases now, e.g. `rebuild_sched_domains_energy()` in which
`new_topology=0` and `update_dl_accounting=false` which now clean the rd
but don't do a new DL accounting anymore.
rebuild_root_domains() itself cleans the `default root domain`, not the
other root domains which could exists as well.

Example: Switching CPUfreq policy [0,3-5] performance to schedutil (slow
switching, i.e. we have sugov:X DL task(s)):

[  862.479906] CPU4 partition_sched_domains_locked() new_topology=0
[  862.499073] Workqueue: events rebuild_sd_workfn
[  862.503646] Call trace:
...
[  862.520789]  partition_sched_domains_locked+0x6c/0x670
[  862.525962]  rebuild_sched_domains_locked+0x204/0x8a0
[  862.531050]  rebuild_sched_domains+0x2c/0x50
[  862.535351]  rebuild_sd_workfn+0x38/0x54                        <-- !
...
[  862.554047] CPU4 dl_clear_root_domain() rd->span=0-5 total_bw=0
def_root_domain=0                                                  <-- !
[  862.561597] CPU4 dl_clear_root_domain() rd->span= total_bw=0
def_root_domain=1
[  862.568960] CPU4 dl_add_task_root_domain() [sugov:0 1801]
total_bw=104857 def_root_domain=0 rd=0xffff0008015f0000            <-- !

The dl_clear_root_domain() of the def_root_domain and the
dl_add_task_root_domain() to the rd in use won't happen.

[sugov:0 1801] is only a simple example here. I could have spawned a
couple of DL tasks before this to illustrate the issue more obvious.

---

The same seems to happen during suspend/resume (system with 2 frequency
domains, both with slow switching schedutil CPUfreq gov):

[   27.735821] CPU5 partition_sched_domains_locked() new_topology=0
...
[   27.735864] Workqueue: events cpuset_hotplug_workfn
[   27.735894] Call trace:
...
[   27.735984]  partition_sched_domains_locked+0x6c/0x670
[   27.736004]  rebuild_sched_domains_locked+0x204/0x8a0
[   27.736026]  cpuset_hotplug_workfn+0x254/0x52c                  <-- !
...
[   27.736155] CPU5 dl_clear_root_domain() rd->span=0-5 total_bw=0
def_root_domain=0                                                  <-- !
[   27.736178] CPU5 dl_clear_root_domain() rd->span= total_bw=0
def_root_domain=1
[   27.736296] CPU5 dl_add_task_root_domain() [sugov:0 80]         <-- !
 total_bw=104857 def_root_domain=0 rd=0xffff000801728000
[   27.736318] CPU5 dl_add_task_root_domain() [sugov:1 81]
total_bw=209714 def_root_domain=0 rd=0xffff000801728000            <-- !
...

> I am not keen on this. arm64 seems to just read a value without a side effect.

Arm64 (among others) sets `update_topology=1` before
`rebuild_sched_domains()` and `update_topology=0` after it in
update_topology_flags_workfn(). This then makes `new_topology=1` in
partition_sched_domains_locked().

> But x86 does reset this value so we can't read it twice in the same call tree
> and I'll have to extract it.
> 
> The better solution that was discussed before is to not iterate through every
> task in the system and let cpuset track when dl tasks are added to it and do
> smarter iteration. ATM even if there are no dl tasks in the system we'll
> blindly go through every task in the hierarchy to update nothing.

Yes, I can see the problem. And IMHO this solution approach seems to be
better than parsing update_dl_accounting` through the stack of involved
functions.

[...]




