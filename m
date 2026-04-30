Return-Path: <cgroups+bounces-15562-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAzaIGwZ82nNxAEAu9opvQ
	(envelope-from <cgroups+bounces-15562-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2026 10:57:16 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C57549F875
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2026 10:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94EAB3016904
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2026 08:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907493DBD71;
	Thu, 30 Apr 2026 08:53:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0B13EF678;
	Thu, 30 Apr 2026 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777539237; cv=none; b=GWWOJP8xEM5K4ebeO6uns976dGLkHGWrxvOSr0Mp21zAoQRtL+GZhmJwFnSa3DLVCUk2E0JVmLh5FfLKEccLpV6El/egr5BuI1ECl+0qs0teteSqBgTIGgSbSS9iFMDXx9jrYN49EJCBvbn2bK3g0OvuOhfDNXyt0VVEtVYpavQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777539237; c=relaxed/simple;
	bh=EAcp2IzJQyxYs7ZO3fHH0ZLgZsznHlYPkBVRqKjSykw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dGFc38dd+N0GmQptvb94diEXZmMvKCw5559wcSIdcOE8vCcmhFv/q1b1vmMEhMJ1bBcLPeXdrmOLTnu8FuXhp/qrj8LjAcaJVjLkMb/r/ekB7cHqd9hRqvNIABUvARgQEGB7sJuNjSIirfYwNDZGnHRZSdQU0aXSz8vM1C5DD9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 191e0e02447211f1aa26b74ffac11d73-20260430
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:658b91cc-6f23-492f-8de8-13735f7e4a68,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:658b91cc-6f23-492f-8de8-13735f7e4a68,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:d08d52f4cac3c751deef057e7d04ecc3,BulkI
	D:26042210141563B83QR0,BulkQuantity:5,Recheck:0,SF:17|19|38|64|66|78|80|81
	|82|83|102|127|841|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:nil,
	RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DK
	P:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 191e0e02447211f1aa26b74ffac11d73-20260430
X-User: zhangguopeng@kylinos.cn
Received: from [10.60.98.3] [(223.160.129.158)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 2034152250; Thu, 30 Apr 2026 16:53:46 +0800
Message-ID: <7a993bd9-2fc2-496c-b6ba-713f2c893cdc@kylinos.cn>
Date: Thu, 30 Apr 2026 16:53:42 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: make DL attach bandwidth reservation
 root-domain aware
To: Waiman Long <longman@redhat.com>, tj@kernel.org, juri.lelli@redhat.com,
 chenridong@huaweicloud.com, mkoutny@suse.com
Cc: hannes@cmpxchg.org, mingo@redhat.com, peterz@infradead.org,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20260421083449.95750-1-zhangguopeng@kylinos.cn>
 <6840e385-ef47-4f83-bf4c-8f80843f8c1d@redhat.com>
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
In-Reply-To: <6840e385-ef47-4f83-bf4c-8f80843f8c1d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2C57549F875
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.959];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangguopeng@kylinos.cn,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15562-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]



在 2026/4/24 22:15, Waiman Long 写道:
> On 4/21/26 4:34 AM, Guopeng Zhang wrote:
>> cpuset_can_attach() currently sums the bandwidth of all migrating
>> SCHED_DEADLINE tasks and reserves destination bandwidth whenever the
>> old and new cpuset effective CPU masks do not overlap.
>>
>> That condition is stronger than what the scheduler uses when migrating
>> a deadline task. set_cpus_allowed_dl() only subtracts bandwidth from
>> the source side when moving the task requires a DL bandwidth move
>> between root domains.
>>
>> As a result, moving a deadline task between disjoint member cpusets that
>> still belong to the same root domain can reserve destination bandwidth
>> even though no matching source-side subtraction happens. Successful
>> back-and-forth migrations between such cpusets can monotonically
>> increase dl_bw->total_bw.
>>
>> Fix this by extracting the source root-domain test already used by
>> set_cpus_allowed_dl() into a shared helper and make cpuset DL bandwidth
>> preallocation use that same condition. Count all migrating deadline
>> tasks for cpuset task accounting, but only accumulate sum_migrate_dl_bw
>> for tasks that actually need a DL bandwidth move. Reserve and rollback
>> bandwidth only for that subset.
>>
>> This keeps successful attach accounting aligned with
>> set_cpus_allowed_dl() and avoids double-accounting within a single
>> root domain.
>>
>> Fixes: 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach() fails")
>> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
>> ---
>>   include/linux/sched/deadline.h  |  9 +++++++++
>>   kernel/cgroup/cpuset-internal.h |  1 +
>>   kernel/cgroup/cpuset.c          | 34 ++++++++++++++++-----------------
>>   kernel/sched/deadline.c         | 14 +++++++++++---
>>   4 files changed, 38 insertions(+), 20 deletions(-)
>>
>> diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
>> index 1198138cb839..273538200a44 100644
>> --- a/include/linux/sched/deadline.h
>> +++ b/include/linux/sched/deadline.h
>> @@ -33,6 +33,15 @@ struct root_domain;
>>   extern void dl_add_task_root_domain(struct task_struct *p);
>>   extern void dl_clear_root_domain(struct root_domain *rd);
>>   extern void dl_clear_root_domain_cpu(int cpu);
>> +/*
>> + * Return whether moving DL task @p to @new_mask requires moving DL
>> + * bandwidth accounting between root domains. This helper is specific to
>> + * DL bandwidth move accounting semantics and is shared by
>> + * cpuset_can_attach() and set_cpus_allowed_dl() so both paths use the
>> + * same source root-domain test.
>> + */
>> +extern bool dl_task_needs_bw_move(struct task_struct *p,
>> +                  const struct cpumask *new_mask);
>>     extern u64 dl_cookie;
>>   extern bool dl_bw_visited(int cpu, u64 cookie);
>> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
>> index bb4e692bea30..f7aaf01f7cd5 100644
>> --- a/kernel/cgroup/cpuset-internal.h
>> +++ b/kernel/cgroup/cpuset-internal.h
>> @@ -167,6 +167,7 @@ struct cpuset {
>>        */
>>       int nr_deadline_tasks;
>>       int nr_migrate_dl_tasks;
>> +    /* DL bandwidth that needs destination reservation for this attach. */
>>       u64 sum_migrate_dl_bw;
>>       /*
>>        * CPU used for temporary DL bandwidth allocation during attach;
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index e3a081a07c6d..761098b45f23 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -2993,7 +2993,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>>       struct cpuset *cs, *oldcs;
>>       struct task_struct *task;
>>       bool setsched_check;
>> -    int ret;
>> +    int cpu, ret;
>>         /* used later by cpuset_attach() */
>>       cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
>> @@ -3039,31 +3039,31 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>>             if (dl_task(task)) {
>>               cs->nr_migrate_dl_tasks++;
>> -            cs->sum_migrate_dl_bw += task->dl.dl_bw;
>> +
>> +            if (dl_task_needs_bw_move(task, cs->effective_cpus))
>> +                cs->sum_migrate_dl_bw += task->dl.dl_bw;
>>           }
>>       }
>>   -    if (!cs->nr_migrate_dl_tasks)
>> +    if (!cs->sum_migrate_dl_bw)
>>           goto out_success;
> You should make sure that cs->nr_migrate_dl_tasks is cleared too. Alternatively, you can move the dl task increment under the dl_task_needs_bw_move() check. It doesn't seem to do any harm if nr_migrate_dl_tasks is non-zero, but dl_bw is 0, but it still doesn't look right.😅 Sorry, I missed this part of your review earlier and only noticed the
RCU comment at first.

For nr_migrate_dl_tasks, my understanding is that it should remain
separate from sum_migrate_dl_bw.

nr_migrate_dl_tasks is used for cpuset-level DL task accounting, while
sum_migrate_dl_bw is used for destination root-domain bandwidth
reservation. A DL task may move between cpusets without requiring a
root-domain bandwidth move, but cpuset_attach() still needs to update
the cpuset DL task counts for that task.

So, unless I am missing another use of nr_migrate_dl_tasks, moving
nr_migrate_dl_tasks++ under the dl_task_needs_bw_move() check does not
look like the right fix to me. It could miss DL tasks which still need
cpuset DL task accounting updates, even though no DL bandwidth
reservation is needed.

Please let me know if I am missing something here, or if there is a
better way to represent this state in the code.

In v2, I plan to keep nr_migrate_dl_tasks counting all migrating DL
tasks, and only restrict sum_migrate_dl_bw to tasks that actually need
destination root-domain bandwidth reservation. I will also add a separate
first patch to reset the pending DL migration state
(nr_migrate_dl_tasks, sum_migrate_dl_bw and dl_bw_cpu) on
cpuset_can_attach() internal failure paths, so these temporary states
will not leak.

I still need to do some testing after my leave, and will send v2 after
that.

Thanks,
Guopeng

