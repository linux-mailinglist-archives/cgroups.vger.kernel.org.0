Return-Path: <cgroups+bounces-16300-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHdDOpRpFWrgUwcAu9opvQ
	(envelope-from <cgroups+bounces-16300-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 11:36:20 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 262B35D36CD
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 11:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39D34301441F
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 09:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D13B3D811C;
	Tue, 26 May 2026 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="rD3NwkWa"
X-Original-To: cgroups@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5A13D79E2;
	Tue, 26 May 2026 09:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788174; cv=none; b=WPi4/bC/g+tXLHyfLRRrW2q/2PyznbSWVeXOMS2Abs8DJ9naQwRXNXyKAbsABgPy6cJl34uN1hODRcmivS0Y7t2juOIik84P7RrQ3lH6uoXngWSCTEuGR3T5ZhVeAQrU2uwrQojhvTUS1q0CUi+3FWr6TAJRR5p6il++u8lhk+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788174; c=relaxed/simple;
	bh=0ylD8vRzY5ZU2GCl3ZbUjwEvqJ8HjrIvNIC8qtxqEWU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=jVFE9GWx7770r7zjKamfvcO+xEtOks70hrD56hPTUuc41/ZB83utrhtwhv2ZO8yYPRc44cHMa6qqrGrN62S01Wpk8CBt3RLokc4EYIwgeBr8JRE6Yq1Oqo+uKXjHoBOi417NkhFQ9bOfkI+Purc8byE4cvNyqPYD2uosLJgVw94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=rD3NwkWa; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8SYJQ3CptkqQFWxP5DyW3osYt/qUujWZDMivD6o146Q=;
	b=rD3NwkWaEyX7r/2PReDBiisSSpHchyMM1iC5uhjlt7SbRHQPNe++LYz7KvmXcSsROl0X876KY
	4xTi4gFPS5SZZDoSmWvA2Wvfc+FrhsMoLfF/Llj711e1PpxbqQpXXOMlZ/mbL7FBhXYotQozBs3
	lcV0su/5oie8g0vv/iv/iCc=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gPnVZ6g1fz1cyNs;
	Tue, 26 May 2026 17:28:22 +0800 (CST)
Received: from dggpemf100017.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id C05DF40561;
	Tue, 26 May 2026 17:36:06 +0800 (CST)
Received: from [10.67.111.186] (10.67.111.186) by
 dggpemf100017.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 26 May 2026 17:36:05 +0800
Message-ID: <e87dc1e1-78d9-b803-8c43-a712472630eb@huawei.com>
Date: Tue, 26 May 2026 17:36:04 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
From: Zhang Qiao <zhangqiao22@huawei.com>
Subject: Re: [PATCH v2 10/10] sched/eevdf: Move to a single runqueue
To: K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra
	<peterz@infradead.org>, <mingo@kernel.org>
CC: <longman@redhat.com>, <chenridong@huaweicloud.com>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <tj@kernel.org>,
	<hannes@cmpxchg.org>, <mkoutny@suse.com>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jstultz@google.com>, <qyousef@layalina.io>,
	Hui Tang <tanghui20@huawei.com>
References: <20260511113104.563854162@infradead.org>
 <20260511120628.206700041@infradead.org>
 <a06e4744-2393-724c-14ff-154f1caa22a6@huawei.com>
 <85116808-8643-47d7-b4e7-2a11c3999b20@amd.com>
In-Reply-To: <85116808-8643-47d7-b4e7-2a11c3999b20@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf100017.china.huawei.com (7.185.36.74)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-16300-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangqiao22@huawei.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:email,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Queue-Id: 262B35D36CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Prateek,

在 2026/5/26 17:15, K Prateek Nayak 写道:
> Hello Zhang,
> 
> On 5/26/2026 1:23 PM, Zhang Qiao wrote:
>> Testing sched/flat branch on AMD EPYC 9654 (384 CPUs, 8 NUMA nodes)
>> with a 2-level cgroup hierarchy and cfs_bandwidth quota enabled,
>> hackbench triggers a divide-by-zero oops:
>>
>>   [  142.308571] divide error: 0000 [#1] SMP NOPTI
>>   [  142.308582] RIP: 0010:task_tick_fair+0x19e/0x410
>>   [  142.308601] Call Trace:
>>   [  142.308604]  <IRQ>
>>   [  142.308607]  scheduler_tick+0x6a/0x110
>>   [  142.308609]  update_process_times+0x6b/0x90
>>   [  142.308611]  tick_sched_handle+0x2a/0x70
>>   [  142.308613]  tick_sched_timer+0x57/0xb0
> 
> More of this trace would have been helpful.
> 
>>
>> faddr2line confirms:
>>
>>   task_tick_fair+0x19e/0x410:
>>   __calc_prop_weight at kernel/sched/fair.c:4085
>>   (inlined by) task_tick_fair at kernel/sched/fair.c:13576
> 
> Those line numbers don't match on the latest sched/flat but since you
> mention this happens with throttling, I believe it is tick hitting
> somewhere in between the task being dequeued by throttle_cfs_rq_work()
> and the CPU rescheduling and taking the task off the runqueue.
> 

Sorry for the confusion on the line numbers — the mismatch was due
to some local debug code I had added on top of sched/flat,
not a difference in the base tree.

> Dequeue from throttle is slightly special since it keeps the task on
> runqueue but the sched entity goes off the cfs_rq changing the
> hierarchical weights.
> > Can you check if this helps:
> 
>   (Lightly tested with your reproducer)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b8bae794f063..d96e5915fb3e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -14815,18 +14815,21 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr) {}
>  static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>  {
>  	struct sched_entity *se = &curr->se;
> -	unsigned long weight = NICE_0_LOAD;
> -	struct cfs_rq *cfs_rq;
>  
> -	for_each_sched_entity(se) {
> -		cfs_rq = cfs_rq_of(se);
> -		entity_tick(cfs_rq, se, queued);
> +	if (se->on_rq) {
> +		unsigned long weight = NICE_0_LOAD;
> +		struct cfs_rq *cfs_rq;
>  
> -		weight = __calc_prop_weight(cfs_rq, se, weight);
> -	}
> +		for_each_sched_entity(se) {
> +			cfs_rq = cfs_rq_of(se);
> +			entity_tick(cfs_rq, se, queued);
> +
> +			weight = __calc_prop_weight(cfs_rq, se, weight);
> +		}
>  
> -	se = &curr->se;
> -	reweight_eevdf(cfs_rq, se, weight, se->on_rq);
> +		se = &curr->se;
> +		reweight_eevdf(cfs_rq, se, weight, se->on_rq);
> +	}
>  

throttle_cfs_rq_work() sets se->on_rq = 0 while the task is still running as
rq->curr, and the subsequent tick should not attempt to reweight an
already-dequeued entity. The unthrottle enqueue will handle the reweight anyway.

I've tested your suggested diff on my AMD EPYC 9654 (384 CPUs, 8 NUMA
nodes) and it resolves the crash. The reproducer no longer triggers the
divide error after running for several minutes.

Tested-by: Zhang Qiao <zhangqiao22@huawei.com>


Thanks,
Zhang Qiao

.

>  	if (queued)
>  		return;
> ---
> 
> I don't think it makes too much sense to reweight an entity that
> has been dequeued. The enqueue at unthrottle will do it anyways.
> 
>>
>> ===========================================================
>> Reproduction
>> ===========================================================
>>
>> Kernel: sched/flat branch (54d493980e00 and later)
>> Hardware: AMD EPYC 9654, 2S 384 logical CPUs
>>
>>   # 2-level cgroup, quota = 50% of one period
>>   cgcreate -g cpu:/bw/l1/l2
>>   cgset -r cpu.cfs_quota_us=50000  /bw/l1/l2
>>   cgset -r cpu.cfs_period_us=100000 /bw/l1/l2
>>
>>   # high task count amplifies the throttle→tick race window
>>   cgexec -g cpu:/bw/l1/l2 hackbench -g 48 -l 1000 -s 512 -T
>>
>> Typically crashes within 30 seconds on this machine.  A single-CPU
>> kernel or a very loose quota (e.g. 90%) is unlikely to trigger it
>> because the race window is narrow.
> 
> This was helpful! I see:
> 
> [  209.935597] Oops: divide error: 0000 [#1] SMP NOPTI
> [  209.941061] CPU: 329 UID: 0 PID: 8247 Comm: sched-messaging Not tainted 7.1.0-rc2-test+ #73 PREEMPT(full)
> [  209.951841] Hardware name: AMD Corporation Titanite_4G/Titanite_4G, BIOS RTI100CC 03/28/2024
> [  209.961254] RIP: 0010:task_tick_fair+0x10d/0x850
> [  209.966420] Code: dc 00 00 00 4c 89 f7 e8 f1 52 ff ff 45 85 e4 0f 85 ba 00 00 00 49 8b 06 4d 8b b6 b8 00 00 00 48 0f af c3 4d 85 f6 74 19 31 d2 <49> f7 37 ba 02 00 00 00 48 89 d3 48 39 d0 48 0f 43 d8 e9 20 ff ff
> [  209.987382] RSP: 0018:ff581fd71e1fce58 EFLAGS: 00010046
> [  209.993216] RAX: 0000010000000000 RBX: 0000000000100000 RCX: ff295dbfa9ad8080
> [  210.001179] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ff295dbfa9ad8080
> [  210.009141] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000063eb
> [  210.017104] R10: 0000000000000000 R11: ff581fd71e1fcff8 R12: 0000000000000000
> [  210.025061] R13: ff295dbfa9ad8000 R14: ff295dc06c6eac00 R15: ff295dbfd9bc8600
> [  210.033027] FS:  00007faef8c8b640(0000) GS:ff295e7c4acca000(0000) knlGS:0000000000000000
> [  210.042060] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  210.048474] CR2: 00007f9884292d30 CR3: 000000011aa26001 CR4: 0000000000f71ef0
> [  210.056430] PKRU: 55555554
> [  210.059448] Call Trace:
> [  210.062177]  <IRQ>
> [  210.064426]  sched_tick+0x94/0x250
> [  210.068229]  update_process_times+0x99/0xc0
> [  210.072903]  tick_nohz_handler+0x95/0x1a0
> [  210.077380]  ? __pfx_tick_nohz_handler+0x10/0x10
> [  210.082534]  __hrtimer_run_queues+0xfe/0x260
> [  210.087304]  hrtimer_interrupt+0x122/0x1f0
> [  210.091880]  __sysvec_apic_timer_interrupt+0x55/0x130
> [  210.097525]  sysvec_apic_timer_interrupt+0x7a/0xb0
> [  210.102873]  </IRQ>
> [  210.105203]  <TASK>
> [  210.107542]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [  210.113284] RIP: 0010:_raw_spin_unlock_irqrestore+0x1d/0x40
> [  210.119511] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 c6 07 00 0f 1f 00 f7 c6 00 02 00 00 74 06 fb 0f 1f 44 00 00 <65> ff 0d ec 20 fd 01 74 05 e9 c0 81 d4 fe e8 00 93 ec fe e9 b6 81
> [  210.140469] RSP: 0018:ff581fd74032fe88 EFLAGS: 00000206
> [  210.146308] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000004
> [  210.154271] RDX: 0000000000000000 RSI: 0000000000000246 RDI: ff295dbfa9ad8d64
> [  210.162235] RBP: ff295dbfa9ad8000 R08: 0000000000000000 R09: 0000000000000000
> [  210.170196] R10: 0000000000000000 R11: 0000000000000000 R12: ff295dbfa9ad8d64
> [  210.178159] R13: ff581fd74032ff48 R14: ff295dbfa9ad8000 R15: 00fffffffffff000
> [  210.186139]  task_work_run+0x5c/0x90
> [  210.190137]  exit_to_user_mode_loop+0x16e/0x550
> [  210.195198]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  210.200552]  ? ksys_read+0xc5/0xe0
> [  210.204352]  do_syscall_64+0x26e/0x750
> [  210.208540]  ? do_syscall_64+0xaa/0x750
> [  210.212823]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  210.218174]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> ---
> 
> So the theory of throttle work causing this checks out.
> 


> The suggested diff above solves the crash in my case but your
> mileage may vary. Peter can comment if this is the right thing
> to do or not :-)
> 

