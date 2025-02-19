Return-Path: <cgroups+bounces-6610-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC160A3C72A
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 19:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0893E3BA9CA
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 18:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE60E214A6C;
	Wed, 19 Feb 2025 18:14:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6361B1DF24F;
	Wed, 19 Feb 2025 18:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988871; cv=none; b=bLLdQpnWIe4874LYHDfeRo0qUsbbB2XFCCvfx2SrYEbHOFjGhvCkFPfg/VjcPWU+ZEKYBxe/OzAeviN5wMkvO/EI77749dsZB/FCAVwb6BKP/a1BXU28GfRdYB5N5xQQ9JkZcXsZ/vcYAMuKBFzXSvRd8fdlRd2ZbSw/1VR3HkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988871; c=relaxed/simple;
	bh=9wO09/baENOGWizfEKktqBM0KGmhWcIn532dmJrrca0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bV1sIQyt7SYHuQ86hyLrq2YNVGFxXkN2iNQWUu9Sf8ExCBsV54E8/wbghFZMOktc8okgmNCJhFDxWs1xZ6KmZsh/j6u3V9fxG8Hk1pebYehYfYPWYMRTfPKaI8pyq8AmG7r9HjWiNZMVe6ftBbkQae9NS7Mgkg5fHiJY/3duU0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2F021682;
	Wed, 19 Feb 2025 10:14:45 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74ADF3F6A8;
	Wed, 19 Feb 2025 10:14:23 -0800 (PST)
Message-ID: <537f2207-b46b-4a5e-884c-d6b42f56cb02@arm.com>
Date: Wed, 19 Feb 2025 19:14:14 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Jon Hunter <jonathanh@nvidia.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Thierry Reding <treding@nvidia.com>, Waiman Long <longman@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Phil Auld <pauld@redhat.com>, Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>, Aashish Sharma <shraash@google.com>,
 Shin Kawamura <kawasin@google.com>,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb>
 <78f627fe-dd1e-4816-bbf3-58137fdceda6@nvidia.com>
 <Z62ONLX4OLisCLKw@jlelli-thinkpadt14gen4.remote.csb>
 <30a8cda5-0fd0-4e47-bafe-5deefc561f0c@nvidia.com>
 <151884eb-ad6d-458e-a325-92cbe5b8b33f@nvidia.com>
 <Z7Ne49MSXS2I06jW@jlelli-thinkpadt14gen4.remote.csb>
 <Z7RZ4141H-FnoQPW@jlelli-thinkpadt14gen4.remote.csb>
 <d7cc3a3c-155e-4872-a426-cbd239d79cac@arm.com>
 <Z7SWvr86RXlBbJlw@jlelli-thinkpadt14gen4.remote.csb>
 <a0f03e3e-bced-4be7-8589-1e65042b39aa@arm.com>
 <Z7WsRvsVCWu_By1c@jlelli-thinkpadt14gen4.remote.csb>
 <4c045707-6f5a-44fd-b2d1-3ad13c2b11ba@arm.com>
Content-Language: en-US
In-Reply-To: <4c045707-6f5a-44fd-b2d1-3ad13c2b11ba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/02/2025 14:09, Dietmar Eggemann wrote:
> On 19/02/2025 11:02, Juri Lelli wrote:
>> On 19/02/25 10:29, Dietmar Eggemann wrote:

[...]

>> If you already had the patch ignoring sugovs bandwidth in your set, could
>> you please share the full dmesg?
> 
> Will do later today ... busy with other stuff right now ;-(

l B B l l l
      ^^^
      isolcpus=[3,4]

w/o sugov tasks:

The issue seems to be that we call partition_sched_domains() for CPU4
during suspend. Which does not issue a:

  build_sched_domains() -> cpu_attach_domain() -> rq_attach_root() ->   
  __dl_server_[de|at]tach_root()



[  171.006436] dl_bw_deactivate() called cpu=4
...
[  171.006639] __dl_overflow() dl_b->bw=996147 cap=446 cap_scale(dl_b->bw, cap)=433868 dl_b->total_bw=104856 old_bw=52428 new_bw=0 type=DEF rd->span=3-5
                                                                                       ^^^^^^^^^^^^^^^^^^^^^(*)
[  171.006652] dl_bw_manage() cpu=4 cap=446 overflow=0 req=0 return=0 type=DEF
...
[  171.007971] dl_bw_deactivate() called cpu=3
...
[  171.007999] dl_bw_manage: cpu=3 cap=0 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=1 type=DEF span=3-5
                                                              ^^^^^^^^^^^^^^^ (*) 
[  171.008010] dl_bw_cpus() cpu=3 rd->span=3-5 cpu_active_mask=0-3 cpus=1 type=DEF
[  171.008019] dl_bw_manage() cpu=3 cap=0 overflow=1 req=0 return=-16 type=DEF
[  171.008069] Error taking CPU3 down: -16

You can see how 'dl_b->total_bw' stays 104856 (2 x util = 51) even
though CPU4 is off (*).

If total_bw would be 52428 for CPU3 going down we would still fail with
the current code (taking the else path):

3604  if (dl_bw_cpus(cpu) - 1)
3605    overflow = __dl_overflow(dl_b, cap, fair_server_bw, 0);
3606  else
3607    overflow = 1;

but if we would take the if path even when 'dl_bw_cpus(cpu) = 1'
_dl_overflow() would return false:

280  return dl_b->bw != -1 &&
281    cap_scale(dl_b->bw, cap) < dl_b->total_bw - old_bw + new_bw;

       '0 < 52428 - 52428 + 0' is false

---

[  170.847396] PM: suspend entry (deep)
[  170.852093] Filesystems sync: 0.000 seconds
[  170.859274] Freezing user space processes
[  170.864616] Freezing user space processes completed (elapsed 0.001 seconds)
[  170.871614] OOM killer disabled.
[  170.874861] Freezing remaining freezable tasks
[  170.880499] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  170.887936] printk: Suspending console(s) (use no_console_suspend to debug)
[  171.000031] arm-scmi arm-scmi.1.auto: timed out in resp(caller: do_xfer+0x114/0x494)
[  171.001421] Disabling non-boot CPUs ...
[  171.001501] dl_bw_deactivate() called cpu=5
[  171.001518] __dl_bw_capacity() mask=0-2,5 cap=2940
[  171.001530] dl_bw_cpus() cpu=5 rd->span=0-2,5 cpu_active_mask=0-5 cpumask_weight(rd->span)=4 type=DYN
[  171.001541] dl_bw_manage: cpu=5 cap=2494 fair_server_bw=52428 total_bw=209712 dl_bw_cpus=4 type=DYN span=0-2,5
[  171.001553] dl_bw_cpus() cpu=5 rd->span=0-2,5 cpu_active_mask=0-5 cpumask_weight(rd->span)=4 type=DYN
[  171.001567] CPU: 5 UID: 0 PID: 41 Comm: cpuhp/5 Not tainted 6.13.0-09343-g9ce523149e08-dirty #172
[  171.001578] Hardware name: ARM Juno development board (r0) (DT)
[  171.001583] Call trace:
[  171.001587]  show_stack+0x18/0x24 (C)
[  171.001605]  dump_stack_lvl+0x74/0x8c
[  171.001621]  dump_stack+0x18/0x24
[  171.001634]  dl_bw_manage+0x3a0/0x500
[  171.001650]  dl_bw_deactivate+0x40/0x50
[  171.001661]  sched_cpu_deactivate+0x34/0x24c
[  171.001676]  cpuhp_invoke_callback+0x138/0x694
[  171.001689]  cpuhp_thread_fun+0xb0/0x198
[  171.001702]  smpboot_thread_fn+0x200/0x224
[  171.001715]  kthread+0x12c/0x204
[  171.001727]  ret_from_fork+0x10/0x20
[  171.001741] __dl_overflow() dl_b->bw=996147 cap=2494 cap_scale(dl_b->bw, cap)=2426162 dl_b->total_bw=209712 old_bw=52428 new_bw=0 type=DYN rd->span=0-2,5
[  171.001754] dl_bw_manage() cpu=5 cap=2494 overflow=0 req=0 return=0 type=DYN
[  171.001814] partition_sched_domains() called
[  171.001821] CPU: 5 UID: 0 PID: 41 Comm: cpuhp/5 Not tainted 6.13.0-09343-g9ce523149e08-dirty #172
[  171.001831] Hardware name: ARM Juno development board (r0) (DT)
[  171.001835] Call trace:
[  171.001838]  show_stack+0x18/0x24 (C)
[  171.001849]  dump_stack_lvl+0x74/0x8c
[  171.001862]  dump_stack+0x18/0x24
[  171.001875]  partition_sched_domains+0x48/0x7c
[  171.001886]  sched_cpu_deactivate+0x1a8/0x24c
[  171.001900]  cpuhp_invoke_callback+0x138/0x694
[  171.001913]  cpuhp_thread_fun+0xb0/0x198
[  171.001925]  smpboot_thread_fn+0x200/0x224
[  171.001937]  kthread+0x12c/0x204
[  171.001948]  ret_from_fork+0x10/0x20
[  171.001961] partition_sched_domains_locked() ndoms_new=1
[  171.002012] cpu_attach_domain() called cpu=0 type=DEF
[  171.002018] CPU0 attaching NULL sched-domain.
[  171.002022] span=3-4
[  171.002029] rq_attach_root() called cpu=0 type=DEF
[  171.002043] dl_bw_cpus() cpu=0 rd->span=0-2,5 cpu_active_mask=0-4 cpus=3 type=DYN
[  171.002053] __dl_server_detach_root() called cpu=0
[  171.002059] dl_bw_cpus() cpu=0 rd->span=0-2,5 cpu_active_mask=0-4 cpus=3 type=DYN
[  171.002068] __dl_sub() tsk_bw=52428 dl_b->total_bw=157284 type=DYN rd->span=0-2,5
[  171.002077] __dl_update() (3) cpu=0 rq->dl.extra_bw=603812
[  171.002083] __dl_update() (3) cpu=1 rq->dl.extra_bw=869446
[  171.002089] __dl_update() (3) cpu=2 rq->dl.extra_bw=1013623
[  171.002098] dl_bw_cpus() cpu=0 rd->span=0,3-4 cpu_active_mask=0-4 cpumask_weight(rd->span)=3 type=DEF
[  171.002109] __dl_server_attach_root() called cpu=0
[  171.002114] dl_bw_cpus() cpu=0 rd->span=0,3-4 cpu_active_mask=0-4 cpumask_weight(rd->span)=3 type=DEF
[  171.002124] __dl_add() tsk_bw=52428 dl_b->total_bw=157284 type=DEF rd->span=0,3-4
[  171.002133] __dl_update() (3) cpu=0 rq->dl.extra_bw=586336
[  171.002139] __dl_update() (3) cpu=3 rq->dl.extra_bw=1004885
[  171.002145] __dl_update() (3) cpu=4 rq->dl.extra_bw=1017992
[  171.002153] cpu_attach_domain() called cpu=1 type=DEF
[  171.002159] CPU1 attaching NULL sched-domain.
[  171.002163] span=0,3-4
[  171.002169] rq_attach_root() called cpu=1 type=DEF
[  171.002181] dl_bw_cpus() cpu=1 rd->span=1-2,5 cpu_active_mask=0-4 cpus=2 type=DYN
[  171.002191] __dl_server_detach_root() called cpu=1
[  171.002196] dl_bw_cpus() cpu=1 rd->span=1-2,5 cpu_active_mask=0-4 cpus=2 type=DYN
[  171.002206] __dl_sub() tsk_bw=52428 dl_b->total_bw=104856 type=DYN rd->span=1-2,5
[  171.002215] __dl_update() (3) cpu=1 rq->dl.extra_bw=895660
[  171.002221] __dl_update() (3) cpu=2 rq->dl.extra_bw=1039837
[  171.002228] dl_bw_cpus() cpu=1 rd->span=0-1,3-4 cpu_active_mask=0-4 cpumask_weight(rd->span)=4 type=DEF
[  171.002238] __dl_server_attach_root() called cpu=1
[  171.002243] dl_bw_cpus() cpu=1 rd->span=0-1,3-4 cpu_active_mask=0-4 cpumask_weight(rd->span)=4 type=DEF
[  171.002253] __dl_add() tsk_bw=52428 dl_b->total_bw=209712 type=DEF rd->span=0-1,3-4
[  171.002262] __dl_update() (3) cpu=0 rq->dl.extra_bw=573229
[  171.002267] __dl_update() (3) cpu=1 rq->dl.extra_bw=882553
[  171.002273] __dl_update() (3) cpu=3 rq->dl.extra_bw=991778
[  171.002279] __dl_update() (3) cpu=4 rq->dl.extra_bw=1004885
[  171.002286] cpu_attach_domain() called cpu=2 type=DEF
[  171.002291] CPU2 attaching NULL sched-domain.
[  171.002296] span=0-1,3-4
[  171.002301] rq_attach_root() called cpu=2 type=DEF
[  171.002314] dl_bw_cpus() cpu=2 rd->span=2,5 cpu_active_mask=0-4 cpus=1 type=DYN
[  171.002323] __dl_server_detach_root() called cpu=2
[  171.002329] dl_bw_cpus() cpu=2 rd->span=2,5 cpu_active_mask=0-4 cpus=1 type=DYN
[  171.002338] __dl_sub() tsk_bw=52428 dl_b->total_bw=52428 type=DYN rd->span=2,5
[  171.002346] __dl_update() (3) cpu=2 rq->dl.extra_bw=1092265
[  171.002353] dl_bw_cpus() cpu=2 rd->span=0-4 cpu_active_mask=0-4 cpumask_weight(rd->span)=5 type=DEF
[  171.002363] __dl_server_attach_root() called cpu=2
[  171.002368] dl_bw_cpus() cpu=2 rd->span=0-4 cpu_active_mask=0-4 cpumask_weight(rd->span)=5 type=DEF
[  171.002377] __dl_add() tsk_bw=52428 dl_b->total_bw=262140 type=DEF rd->span=0-4
[  171.002385] __dl_update() (3) cpu=0 rq->dl.extra_bw=562744
[  171.002391] __dl_update() (3) cpu=1 rq->dl.extra_bw=872068
[  171.002397] __dl_update() (3) cpu=2 rq->dl.extra_bw=1081780
[  171.002403] __dl_update() (3) cpu=3 rq->dl.extra_bw=981293
[  171.002409] __dl_update() (3) cpu=4 rq->dl.extra_bw=994400
[  171.002416] cpu_attach_domain() called cpu=5 type=DEF
[  171.002421] CPU5 attaching NULL sched-domain.
[  171.002425] span=0-4
[  171.002431] rq_attach_root() called cpu=5 type=DEF
[  171.002438] build_sched_domains() called cpu_map=0-2
[  171.002556] cpu_attach_domain() called cpu=0 type=DYN
[  171.002565] CPU0 attaching sched-domain(s):
[  171.002571]  domain-0: span=0-2 level=PKG
[  171.002583]   groups: 0:{ span=0 cap=445 }, 1:{ span=1-2 cap=2045 }
[  171.002619] rq_attach_root() called cpu=0 type=DYN
[  171.002630] dl_bw_cpus() cpu=0 rd->span=0-5 cpu_active_mask=0-4 cpus=5 type=DEF
[  171.002639] __dl_server_detach_root() called cpu=0
[  171.002644] dl_bw_cpus() cpu=0 rd->span=0-5 cpu_active_mask=0-4 cpus=5 type=DEF
[  171.002653] __dl_sub() tsk_bw=52428 dl_b->total_bw=209712 type=DEF rd->span=0-5
[  171.002662] __dl_update() (3) cpu=0 rq->dl.extra_bw=573229
[  171.002668] __dl_update() (3) cpu=1 rq->dl.extra_bw=882553
[  171.002674] __dl_update() (3) cpu=2 rq->dl.extra_bw=1092265
[  171.002680] __dl_update() (3) cpu=3 rq->dl.extra_bw=991778
[  171.002686] __dl_update() (3) cpu=4 rq->dl.extra_bw=1004885
[  171.002693] dl_bw_cpus() cpu=0 rd->span=0 cpu_active_mask=0-4 cpumask_weight(rd->span)=1 type=DYN
[  171.002702] __dl_server_attach_root() called cpu=0
[  171.002707] dl_bw_cpus() cpu=0 rd->span=0 cpu_active_mask=0-4 cpumask_weight(rd->span)=1 type=DYN
[  171.002716] __dl_add() tsk_bw=52428 dl_b->total_bw=52428 type=DYN rd->span=0
[  171.002724] __dl_update() (3) cpu=0 rq->dl.extra_bw=520801
[  171.002731] cpu_attach_domain() called cpu=1 type=DYN
[  171.002738] CPU1 attaching sched-domain(s):
[  171.002743]  domain-0: span=1-2 level=MC
[  171.002753]   groups: 1:{ span=1 cap=1022 }, 2:{ span=2 cap=1023 }
[  171.002787]   domain-1: span=0-2 level=PKG
[  171.002798]    groups: 1:{ span=1-2 cap=2045 }, 0:{ span=0 cap=445 }
[  171.002831] rq_attach_root() called cpu=1 type=DYN
[  171.002841] dl_bw_cpus() cpu=1 rd->span=1-5 cpu_active_mask=0-4 cpus=4 type=DEF
[  171.002851] __dl_server_detach_root() called cpu=1
[  171.002856] dl_bw_cpus() cpu=1 rd->span=1-5 cpu_active_mask=0-4 cpus=4 type=DEF
[  171.002865] __dl_sub() tsk_bw=52428 dl_b->total_bw=157284 type=DEF rd->span=1-5
[  171.002873] __dl_update() (3) cpu=1 rq->dl.extra_bw=895660
[  171.002879] __dl_update() (3) cpu=2 rq->dl.extra_bw=1105372
[  171.002885] __dl_update() (3) cpu=3 rq->dl.extra_bw=1004885
[  171.002891] __dl_update() (3) cpu=4 rq->dl.extra_bw=1017992
[  171.002898] dl_bw_cpus() cpu=1 rd->span=0-1 cpu_active_mask=0-4 cpumask_weight(rd->span)=2 type=DYN
[  171.002907] __dl_server_attach_root() called cpu=1
[  171.002912] dl_bw_cpus() cpu=1 rd->span=0-1 cpu_active_mask=0-4 cpumask_weight(rd->span)=2 type=DYN
[  171.002922] __dl_add() tsk_bw=52428 dl_b->total_bw=104856 type=DYN rd->span=0-1
[  171.002930] __dl_update() (3) cpu=0 rq->dl.extra_bw=494587
[  171.002936] __dl_update() (3) cpu=1 rq->dl.extra_bw=869446
[  171.002943] cpu_attach_domain() called cpu=2 type=DYN
[  171.002950] CPU2 attaching sched-domain(s):
[  171.002954]  domain-0: span=1-2 level=MC
[  171.002965]   groups: 2:{ span=2 cap=1023 }, 1:{ span=1 cap=1022 }
[  171.002998]   domain-1: span=0-2 level=PKG
[  171.003009]    groups: 1:{ span=1-2 cap=2045 }, 0:{ span=0 cap=445 }
[  171.003043] rq_attach_root() called cpu=2 type=DYN
[  171.003053] dl_bw_cpus() cpu=2 rd->span=2-5 cpu_active_mask=0-4 cpus=3 type=DEF
[  171.003062] __dl_server_detach_root() called cpu=2
[  171.003067] dl_bw_cpus() cpu=2 rd->span=2-5 cpu_active_mask=0-4 cpus=3 type=DEF
[  171.003076] __dl_sub() tsk_bw=52428 dl_b->total_bw=104856 type=DEF rd->span=2-5
[  171.003085] __dl_update() (3) cpu=2 rq->dl.extra_bw=1122848
[  171.003091] __dl_update() (3) cpu=3 rq->dl.extra_bw=1022361
[  171.003096] __dl_update() (3) cpu=4 rq->dl.extra_bw=1035468
[  171.003103] dl_bw_cpus() cpu=2 rd->span=0-2 cpu_active_mask=0-4 cpumask_weight(rd->span)=3 type=DYN
[  171.003113] __dl_server_attach_root() called cpu=2
[  171.003118] dl_bw_cpus() cpu=2 rd->span=0-2 cpu_active_mask=0-4 cpumask_weight(rd->span)=3 type=DYN
[  171.003127] __dl_add() tsk_bw=52428 dl_b->total_bw=157284 type=DYN rd->span=0-2
[  171.003136] __dl_update() (3) cpu=0 rq->dl.extra_bw=477111
[  171.003141] __dl_update() (3) cpu=1 rq->dl.extra_bw=851970
[  171.003147] __dl_update() (3) cpu=2 rq->dl.extra_bw=1105372
[  171.003188] root domain span: 0-2
[  171.003194] default domain span: 3-5
[  171.003220] rd 0-2: Checking EAS, schedutil is mandatory
[  171.005840] psci: CPU5 killed (polled 0 ms)
[  171.006436] dl_bw_deactivate() called cpu=4
[  171.006446] __dl_bw_capacity() mask=3-5 cap=892
[  171.006454] dl_bw_cpus() cpu=4 rd->span=3-5 cpu_active_mask=0-4 cpus=2 type=DEF
[  171.006464] dl_bw_manage: cpu=4 cap=446 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=2 type=DEF span=3-5
[  171.006475] dl_bw_cpus() cpu=4 rd->span=3-5 cpu_active_mask=0-4 cpus=2 type=DEF
[  171.006485] CPU: 4 UID: 0 PID: 36 Comm: cpuhp/4 Not tainted 6.13.0-09343-g9ce523149e08-dirty #172
[  171.006495] Hardware name: ARM Juno development board (r0) (DT)
[  171.006499] Call trace:
[  171.006502]  show_stack+0x18/0x24 (C)
[  171.006514]  dump_stack_lvl+0x74/0x8c
[  171.006528]  dump_stack+0x18/0x24
[  171.006541]  dl_bw_manage+0x3a0/0x500
[  171.006554]  dl_bw_deactivate+0x40/0x50
[  171.006564]  sched_cpu_deactivate+0x34/0x24c
[  171.006579]  cpuhp_invoke_callback+0x138/0x694
[  171.006591]  cpuhp_thread_fun+0xb0/0x198
[  171.006604]  smpboot_thread_fn+0x200/0x224
[  171.006616]  kthread+0x12c/0x204
[  171.006627]  ret_from_fork+0x10/0x20
[  171.006639] __dl_overflow() dl_b->bw=996147 cap=446 cap_scale(dl_b->bw, cap)=433868 dl_b->total_bw=104856 old_bw=52428 new_bw=0 type=DEF rd->span=3-5
[  171.006652] dl_bw_manage() cpu=4 cap=446 overflow=0 req=0 return=0 type=DEF
[  171.006706] partition_sched_domains() called
[  171.006713] CPU: 4 UID: 0 PID: 36 Comm: cpuhp/4 Not tainted 6.13.0-09343-g9ce523149e08-dirty #172
[  171.006722] Hardware name: ARM Juno development board (r0) (DT)
[  171.006727] Call trace:
[  171.006730]  show_stack+0x18/0x24 (C)
[  171.006740]  dump_stack_lvl+0x74/0x8c
[  171.006754]  dump_stack+0x18/0x24
[  171.006767]  partition_sched_domains+0x48/0x7c
[  171.006778]  sched_cpu_deactivate+0x1a8/0x24c
[  171.006792]  cpuhp_invoke_callback+0x138/0x694
[  171.006805]  cpuhp_thread_fun+0xb0/0x198
[  171.006817]  smpboot_thread_fn+0x200/0x224
[  171.006829]  kthread+0x12c/0x204
[  171.006840]  ret_from_fork+0x10/0x20
[  171.006852] partition_sched_domains_locked() ndoms_new=1
[  171.006861] partition_sched_domains_locked() goto match2
[  171.006867] rd 0-2: Checking EAS, schedutil is mandatory
[  171.007774] psci: CPU4 killed (polled 4 ms)
[  171.007971] dl_bw_deactivate() called cpu=3
[  171.007981] __dl_bw_capacity() mask=3-5 cap=446
[  171.007989] dl_bw_cpus() cpu=3 rd->span=3-5 cpu_active_mask=0-3 cpus=1 type=DEF
[  171.007999] dl_bw_manage: cpu=3 cap=0 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=1 type=DEF span=3-5
[  171.008010] dl_bw_cpus() cpu=3 rd->span=3-5 cpu_active_mask=0-3 cpus=1 type=DEF
[  171.008019] dl_bw_manage() cpu=3 cap=0 overflow=1 req=0 return=-16 type=DEF
[  171.008069] Error taking CPU3 down: -16
[  171.008076] Non-boot CPUs are not disabled
[  171.008080] Enabling non-boot CPUs ...
[  171.008397] Detected VIPT I-cache on CPU4
[  171.008472] CPU4: Booted secondary processor 0x0000000102 [0x410fd030]
[  171.008862] partition_sched_domains() called
[  171.008869] CPU: 4 UID: 0 PID: 36 Comm: cpuhp/4 Not tainted 6.13.0-09343-g9ce523149e08-dirty #172
[  171.008880] Hardware name: ARM Juno development board (r0) (DT)
[  171.008884] Call trace:
[  171.008887]  show_stack+0x18/0x24 (C)
[  171.008899]  dump_stack_lvl+0x74/0x8c
[  171.008913]  dump_stack+0x18/0x24
[  171.008926]  partition_sched_domains+0x48/0x7c
[  171.008937]  sched_cpu_activate+0x194/0x1f8
[  171.008951]  cpuhp_invoke_callback+0x138/0x694
[  171.008963]  cpuhp_thread_fun+0xb0/0x198
[  171.008976]  smpboot_thread_fn+0x200/0x224
[  171.008987]  kthread+0x12c/0x204
[  171.008999]  ret_from_fork+0x10/0x20
[  171.009011] partition_sched_domains_locked() ndoms_new=1
[  171.009019] partition_sched_domains_locked() goto match2
[  171.009025] rd 0-2: Checking EAS, schedutil is mandatory
[  171.009048] CPU4 is up
[  171.009323] Detected VIPT I-cache on CPU5
[  171.009377] CPU5: Booted secondary processor 0x0000000103 [0x410fd030]
[  171.009787] partition_sched_domains() called
[  171.009795] CPU: 5 UID: 0 PID: 41 Comm: cpuhp/5 Not tainted 6.13.0-09343-g9ce523149e08-dirty #172
[  171.009806] Hardware name: ARM Juno development board (r0) (DT)
[  171.009810] Call trace:
[  171.009813]  show_stack+0x18/0x24 (C)
[  171.009825]  dump_stack_lvl+0x74/0x8c
[  171.009839]  dump_stack+0x18/0x24
[  171.009851]  partition_sched_domains+0x48/0x7c
[  171.009862]  sched_cpu_activate+0x194/0x1f8
[  171.009876]  cpuhp_invoke_callback+0x138/0x694
[  171.009889]  cpuhp_thread_fun+0xb0/0x198
[  171.009901]  smpboot_thread_fn+0x200/0x224
[  171.009912]  kthread+0x12c/0x204
[  171.009924]  ret_from_fork+0x10/0x20
[  171.009936] partition_sched_domains_locked() ndoms_new=1
[  171.009980] cpu_attach_domain() called cpu=0 type=DEF
[  171.009986] CPU0 attaching NULL sched-domain.
[  171.009991] span=3-5
[  171.009997] rq_attach_root() called cpu=0 type=DEF
[  171.010011] dl_bw_cpus() cpu=0 rd->span=0-2 cpu_active_mask=0-5 cpumask_weight(rd->span)=3 type=DYN
[  171.010021] __dl_server_detach_root() called cpu=0
[  171.010026] dl_bw_cpus() cpu=0 rd->span=0-2 cpu_active_mask=0-5 cpumask_weight(rd->span)=3 type=DYN
[  171.010036] __dl_sub() tsk_bw=52428 dl_b->total_bw=104856 type=DYN rd->span=0-2
[  171.010044] __dl_update() (3) cpu=0 rq->dl.extra_bw=494587
[  171.010050] __dl_update() (3) cpu=1 rq->dl.extra_bw=869446
[  171.010056] __dl_update() (3) cpu=2 rq->dl.extra_bw=1122848
[  171.010064] dl_bw_cpus() cpu=0 rd->span=0,3-5 cpu_active_mask=0-5 cpumask_weight(rd->span)=4 type=DEF
[  171.010074] __dl_server_attach_root() called cpu=0
[  171.010079] dl_bw_cpus() cpu=0 rd->span=0,3-5 cpu_active_mask=0-5 cpumask_weight(rd->span)=4 type=DEF
[  171.010089] __dl_add() tsk_bw=52428 dl_b->total_bw=157284 type=DEF rd->span=0,3-5
[  171.010098] __dl_update() (3) cpu=0 rq->dl.extra_bw=481480
[  171.010104] __dl_update() (3) cpu=3 rq->dl.extra_bw=1009254
[  171.010109] __dl_update() (3) cpu=4 rq->dl.extra_bw=1022361
[  171.010115] __dl_update() (3) cpu=5 rq->dl.extra_bw=1156925
[  171.010123] cpu_attach_domain() called cpu=1 type=DEF
[  171.010129] CPU1 attaching NULL sched-domain.
[  171.010133] span=0,3-5
[  171.010139] rq_attach_root() called cpu=1 type=DEF
[  171.010149] dl_bw_cpus() cpu=1 rd->span=1-2 cpu_active_mask=0-5 cpumask_weight(rd->span)=2 type=DYN
[  171.010159] __dl_server_detach_root() called cpu=1
[  171.010164] dl_bw_cpus() cpu=1 rd->span=1-2 cpu_active_mask=0-5 cpumask_weight(rd->span)=2 type=DYN
[  171.010174] __dl_sub() tsk_bw=52428 dl_b->total_bw=52428 type=DYN rd->span=1-2
[  171.010182] __dl_update() (3) cpu=1 rq->dl.extra_bw=895660
[  171.010188] __dl_update() (3) cpu=2 rq->dl.extra_bw=1149062
[  171.010195] dl_bw_cpus() cpu=1 rd->span=0-1,3-5 cpu_active_mask=0-5 cpumask_weight(rd->span)=5 type=DEF
[  171.010205] __dl_server_attach_root() called cpu=1
[  171.010210] dl_bw_cpus() cpu=1 rd->span=0-1,3-5 cpu_active_mask=0-5 cpumask_weight(rd->span)=5 type=DEF
[  171.010220] __dl_add() tsk_bw=52428 dl_b->total_bw=209712 type=DEF rd->span=0-1,3-5
[  171.010229] __dl_update() (3) cpu=0 rq->dl.extra_bw=470995
[  171.010235] __dl_update() (3) cpu=1 rq->dl.extra_bw=885175
[  171.010241] __dl_update() (3) cpu=3 rq->dl.extra_bw=998769
[  171.010247] __dl_update() (3) cpu=4 rq->dl.extra_bw=1011876
[  171.010252] __dl_update() (3) cpu=5 rq->dl.extra_bw=1146440
[  171.010259] cpu_attach_domain() called cpu=2 type=DEF
[  171.010265] CPU2 attaching NULL sched-domain.
[  171.010269] span=0-1,3-5
[  171.010275] rq_attach_root() called cpu=2 type=DEF
[  171.010286] dl_bw_cpus() cpu=2 rd->span=2 cpu_active_mask=0-5 cpumask_weight(rd->span)=1 type=DYN
[  171.010296] __dl_server_detach_root() called cpu=2
[  171.010301] dl_bw_cpus() cpu=2 rd->span=2 cpu_active_mask=0-5 cpumask_weight(rd->span)=1 type=DYN
[  171.010310] __dl_sub() tsk_bw=52428 dl_b->total_bw=0 type=DYN rd->span=2
[  171.010318] __dl_update() (3) cpu=2 rq->dl.extra_bw=1201490
[  171.010324] dl_bw_cpus() cpu=2 rd->span=0-5 cpu_active_mask=0-5 cpumask_weight(rd->span)=6 type=DEF
[  171.010334] __dl_server_attach_root() called cpu=2
[  171.010339] dl_bw_cpus() cpu=2 rd->span=0-5 cpu_active_mask=0-5 cpumask_weight(rd->span)=6 type=DEF
[  171.010348] __dl_add() tsk_bw=52428 dl_b->total_bw=262140 type=DEF rd->span=0-5
[  171.010357] __dl_update() (3) cpu=0 rq->dl.extra_bw=462257
[  171.010362] __dl_update() (3) cpu=1 rq->dl.extra_bw=876437
[  171.010368] __dl_update() (3) cpu=2 rq->dl.extra_bw=1192752
[  171.010374] __dl_update() (3) cpu=3 rq->dl.extra_bw=990031
[  171.010380] __dl_update() (3) cpu=4 rq->dl.extra_bw=1003138
[  171.010385] __dl_update() (3) cpu=5 rq->dl.extra_bw=1137702
[  171.010393] build_sched_domains() called cpu_map=0-2,5
[  171.010520] cpu_attach_domain() called cpu=0 type=DYN
[  171.010529] CPU0 attaching sched-domain(s):
[  171.010534]  domain-0: span=0,5 level=MC
[  171.010546]   groups: 0:{ span=0 cap=445 }, 5:{ span=5 cap=445 }
[  171.010580]   domain-1: span=0-2,5 level=PKG
[  171.010591]    groups: 0:{ span=0,5 cap=890 }, 1:{ span=1-2 cap=2044 }
[  171.010625] rq_attach_root() called cpu=0 type=DYN
[  171.010636] dl_bw_cpus() cpu=0 rd->span=0-5 cpu_active_mask=0-5 cpumask_weight(rd->span)=6 type=DEF
[  171.010645] __dl_server_detach_root() called cpu=0
[  171.010651] dl_bw_cpus() cpu=0 rd->span=0-5 cpu_active_mask=0-5 cpumask_weight(rd->span)=6 type=DEF
[  171.010660] __dl_sub() tsk_bw=52428 dl_b->total_bw=209712 type=DEF rd->span=0-5
[  171.010669] __dl_update() (3) cpu=0 rq->dl.extra_bw=470995
[  171.010675] __dl_update() (3) cpu=1 rq->dl.extra_bw=885175
[  171.010680] __dl_update() (3) cpu=2 rq->dl.extra_bw=1201490
[  171.010686] __dl_update() (3) cpu=3 rq->dl.extra_bw=998769
[  171.010692] __dl_update() (3) cpu=4 rq->dl.extra_bw=1011876
[  171.010697] __dl_update() (3) cpu=5 rq->dl.extra_bw=1146440
[  171.010705] dl_bw_cpus() cpu=0 rd->span=0 cpu_active_mask=0-5 cpumask_weight(rd->span)=1 type=DYN
[  171.010714] __dl_server_attach_root() called cpu=0
[  171.010719] dl_bw_cpus() cpu=0 rd->span=0 cpu_active_mask=0-5 cpumask_weight(rd->span)=1 type=DYN
[  171.010728] __dl_add() tsk_bw=52428 dl_b->total_bw=52428 type=DYN rd->span=0
[  171.010736] __dl_update() (3) cpu=0 rq->dl.extra_bw=418567
[  171.010743] cpu_attach_domain() called cpu=1 type=DYN
[  171.010750] CPU1 attaching sched-domain(s):
[  171.010755]  domain-0: span=1-2 level=MC
[  171.010766]   groups: 1:{ span=1 cap=1021 }, 2:{ span=2 cap=1023 }
[  171.010799]   domain-1: span=0-2,5 level=PKG
[  171.010811]    groups: 1:{ span=1-2 cap=2044 }, 0:{ span=0,5 cap=890 }
[  171.010844] rq_attach_root() called cpu=1 type=DYN
[  171.010854] dl_bw_cpus() cpu=1 rd->span=1-5 cpu_active_mask=0-5 cpumask_weight(rd->span)=5 type=DEF
[  171.010864] __dl_server_detach_root() called cpu=1
[  171.010869] dl_bw_cpus() cpu=1 rd->span=1-5 cpu_active_mask=0-5 cpumask_weight(rd->span)=5 type=DEF
[  171.010879] __dl_sub() tsk_bw=52428 dl_b->total_bw=157284 type=DEF rd->span=1-5
[  171.010887] __dl_update() (3) cpu=1 rq->dl.extra_bw=895660
[  171.010893] __dl_update() (3) cpu=2 rq->dl.extra_bw=1211975
[  171.010899] __dl_update() (3) cpu=3 rq->dl.extra_bw=1009254
[  171.010905] __dl_update() (3) cpu=4 rq->dl.extra_bw=1022361
[  171.010911] __dl_update() (3) cpu=5 rq->dl.extra_bw=1156925
[  171.010918] dl_bw_cpus() cpu=1 rd->span=0-1 cpu_active_mask=0-5 cpumask_weight(rd->span)=2 type=DYN
[  171.010927] __dl_server_attach_root() called cpu=1
[  171.010932] dl_bw_cpus() cpu=1 rd->span=0-1 cpu_active_mask=0-5 cpumask_weight(rd->span)=2 type=DYN
[  171.010941] __dl_add() tsk_bw=52428 dl_b->total_bw=104856 type=DYN rd->span=0-1
[  171.010950] __dl_update() (3) cpu=0 rq->dl.extra_bw=392353
[  171.010956] __dl_update() (3) cpu=1 rq->dl.extra_bw=869446
[  171.010962] cpu_attach_domain() called cpu=2 type=DYN
[  171.010969] CPU2 attaching sched-domain(s):
[  171.010974]  domain-0: span=1-2 level=MC
[  171.010985]   groups: 2:{ span=2 cap=1023 }, 1:{ span=1 cap=1021 }
[  171.011018]   domain-1: span=0-2,5 level=PKG
[  171.011029]    groups: 1:{ span=1-2 cap=2044 }, 0:{ span=0,5 cap=890 }
[  171.011063] rq_attach_root() called cpu=2 type=DYN
[  171.011073] dl_bw_cpus() cpu=2 rd->span=2-5 cpu_active_mask=0-5 cpumask_weight(rd->span)=4 type=DEF
[  171.011083] __dl_server_detach_root() called cpu=2
[  171.011088] dl_bw_cpus() cpu=2 rd->span=2-5 cpu_active_mask=0-5 cpumask_weight(rd->span)=4 type=DEF
[  171.011097] __dl_sub() tsk_bw=52428 dl_b->total_bw=104856 type=DEF rd->span=2-5
[  171.011105] __dl_update() (3) cpu=2 rq->dl.extra_bw=1225082
[  171.011111] __dl_update() (3) cpu=3 rq->dl.extra_bw=1022361
[  171.011117] __dl_update() (3) cpu=4 rq->dl.extra_bw=1035468
[  171.011123] __dl_update() (3) cpu=5 rq->dl.extra_bw=1170032
[  171.011130] dl_bw_cpus() cpu=2 rd->span=0-2 cpu_active_mask=0-5 cpumask_weight(rd->span)=3 type=DYN
[  171.011139] __dl_server_attach_root() called cpu=2
[  171.011144] dl_bw_cpus() cpu=2 rd->span=0-2 cpu_active_mask=0-5 cpumask_weight(rd->span)=3 type=DYN
[  171.011154] __dl_add() tsk_bw=52428 dl_b->total_bw=157284 type=DYN rd->span=0-2
[  171.011162] __dl_update() (3) cpu=0 rq->dl.extra_bw=374877
[  171.011168] __dl_update() (3) cpu=1 rq->dl.extra_bw=851970
[  171.011174] __dl_update() (3) cpu=2 rq->dl.extra_bw=1207606
[  171.011181] cpu_attach_domain() called cpu=5 type=DYN
[  171.011188] CPU5 attaching sched-domain(s):
[  171.011192]  domain-0: span=0,5 level=MC
[  171.011203]   groups: 5:{ span=5 cap=445 }, 0:{ span=0 cap=445 }
[  171.011237]   domain-1: span=0-2,5 level=PKG
[  171.011248]    groups: 0:{ span=0,5 cap=890 }, 1:{ span=1-2 cap=2044 }
[  171.011281] rq_attach_root() called cpu=5 type=DYN
[  171.011288] dl_bw_cpus() cpu=5 rd->span=0-2,5 cpu_active_mask=0-5 cpumask_weight(rd->span)=4 type=DYN
[  171.011299] __dl_server_attach_root() called cpu=5
[  171.011304] dl_bw_cpus() cpu=5 rd->span=0-2,5 cpu_active_mask=0-5 cpumask_weight(rd->span)=4 type=DYN
[  171.011313] __dl_add() tsk_bw=52428 dl_b->total_bw=209712 type=DYN rd->span=0-2,5
[  171.011322] __dl_update() (3) cpu=0 rq->dl.extra_bw=361770
[  171.011328] __dl_update() (3) cpu=1 rq->dl.extra_bw=838863
[  171.011334] __dl_update() (3) cpu=2 rq->dl.extra_bw=1194499
[  171.011339] __dl_update() (3) cpu=5 rq->dl.extra_bw=1156925
[  171.011381] root domain span: 0-2,5
[  171.011387] default domain span: 3-4
[  171.011410] rd 0-2,5: Checking EAS, schedutil is mandatory
[  171.012325] partition_and_rebuild_sched_domains() called
[  171.012331] partition_sched_domains_locked() ndoms_new=1
[  171.012338] partition_sched_domains_locked() goto match2
[  171.012344] rd 0-2,5: Checking EAS, schedutil is mandatory
[  171.012369] CPU5 is up
[  171.226240] atkbd serio0: keyboard reset failed on 1c060000.kmi
[  173.340005] OOM killer enabled.
[  173.343148] Restarting tasks ... done.
[  173.347458] random: crng reseeded on system resumption
[  173.352939] PM: suspend exit

