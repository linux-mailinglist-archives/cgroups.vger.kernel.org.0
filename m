Return-Path: <cgroups+bounces-15563-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNljHeJN82lnzQEAu9opvQ
	(envelope-from <cgroups+bounces-15563-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2026 14:41:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE644A2D54
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2026 14:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EA403036E8E
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2026 12:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA3840628F;
	Thu, 30 Apr 2026 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SrMDY0sp"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D8F40627D
	for <cgroups@vger.kernel.org>; Thu, 30 Apr 2026 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777552808; cv=none; b=mViaPb9uGql7J1FzXJis1akE9VrbVvYtMa2NjF+qr1MNekbxMZiWxv91NA2BG/7l0KKnBp7KfjWi2W8owl0fnyM6zG7KXtaR9Ikjss8Cj2Kj6cYHWiJacr9Xl+zFNcZaNiHS2dxHJf+2er8mNVQN9EjgMvxhC2tJCmLq5SDYNe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777552808; c=relaxed/simple;
	bh=92YcSSO0zB8+m1F4LrFta7xR4/xntuwy9FEPBqSi7FA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYckr5IKHw5qd3EKB341UhpZkTZsV1sLfXdli5ma+gKwHBrUTn2uPLPvcyPGIF7PYhOGrixPZ8zk7OxcSq1YJCSai26A6LQchitqtu207Zs8DIOIL+bQpQI6ZsQZYe24Aop0CzvvlKD5+Kqn9vDubC/4c7GIhQbkvCl36By5kVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SrMDY0sp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777552804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XITrm4EZUC+FjeqssSN+AOsbmS4zRVQyFUJbFjFA9qo=;
	b=SrMDY0spQ9hBygHYTMI0rSclGDW2t8es4SUNOhsfmKVAjk9T3koaxcZpSSMvxVVO65QToP
	lIGA/GIbCGiMfKb73vyz68N5PvVfB1hMGbgoqm32DrkY8R5sQqSHSgrrvElCGWbt2p32mJ
	reyhIPKm5ooTeBkIB96b8GB9Owie2A4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-w5-HySqQO8Opl4VeBT6Xuw-1; Thu,
 30 Apr 2026 08:39:59 -0400
X-MC-Unique: w5-HySqQO8Opl4VeBT6Xuw-1
X-Mimecast-MFC-AGG-ID: w5-HySqQO8Opl4VeBT6Xuw_1777552797
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 488281800352;
	Thu, 30 Apr 2026 12:39:56 +0000 (UTC)
Received: from [10.22.88.214] (unknown [10.22.88.214])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 08A5F1800446;
	Thu, 30 Apr 2026 12:39:52 +0000 (UTC)
Message-ID: <77c54abb-3568-49f6-a3c4-c2743f8810f2@redhat.com>
Date: Thu, 30 Apr 2026 08:39:51 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: make DL attach bandwidth reservation
 root-domain aware
To: Guopeng Zhang <zhangguopeng@kylinos.cn>, tj@kernel.org,
 juri.lelli@redhat.com, chenridong@huaweicloud.com, mkoutny@suse.com
Cc: hannes@cmpxchg.org, mingo@redhat.com, peterz@infradead.org,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20260421083449.95750-1-zhangguopeng@kylinos.cn>
 <6840e385-ef47-4f83-bf4c-8f80843f8c1d@redhat.com>
 <7a993bd9-2fc2-496c-b6ba-713f2c893cdc@kylinos.cn>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <7a993bd9-2fc2-496c-b6ba-713f2c893cdc@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 0AE644A2D54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-15563-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 4/30/26 4:53 AM, Guopeng Zhang wrote:
>
> 在 2026/4/24 22:15, Waiman Long 写道:
>> On 4/21/26 4:34 AM, Guopeng Zhang wrote:
>>> cpuset_can_attach() currently sums the bandwidth of all migrating
>>> SCHED_DEADLINE tasks and reserves destination bandwidth whenever the
>>> old and new cpuset effective CPU masks do not overlap.
>>>
>>> That condition is stronger than what the scheduler uses when migrating
>>> a deadline task. set_cpus_allowed_dl() only subtracts bandwidth from
>>> the source side when moving the task requires a DL bandwidth move
>>> between root domains.
>>>
>>> As a result, moving a deadline task between disjoint member cpusets that
>>> still belong to the same root domain can reserve destination bandwidth
>>> even though no matching source-side subtraction happens. Successful
>>> back-and-forth migrations between such cpusets can monotonically
>>> increase dl_bw->total_bw.
>>>
>>> Fix this by extracting the source root-domain test already used by
>>> set_cpus_allowed_dl() into a shared helper and make cpuset DL bandwidth
>>> preallocation use that same condition. Count all migrating deadline
>>> tasks for cpuset task accounting, but only accumulate sum_migrate_dl_bw
>>> for tasks that actually need a DL bandwidth move. Reserve and rollback
>>> bandwidth only for that subset.
>>>
>>> This keeps successful attach accounting aligned with
>>> set_cpus_allowed_dl() and avoids double-accounting within a single
>>> root domain.
>>>
>>> Fixes: 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach() fails")
>>> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
>>> ---
>>>    include/linux/sched/deadline.h  |  9 +++++++++
>>>    kernel/cgroup/cpuset-internal.h |  1 +
>>>    kernel/cgroup/cpuset.c          | 34 ++++++++++++++++-----------------
>>>    kernel/sched/deadline.c         | 14 +++++++++++---
>>>    4 files changed, 38 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
>>> index 1198138cb839..273538200a44 100644
>>> --- a/include/linux/sched/deadline.h
>>> +++ b/include/linux/sched/deadline.h
>>> @@ -33,6 +33,15 @@ struct root_domain;
>>>    extern void dl_add_task_root_domain(struct task_struct *p);
>>>    extern void dl_clear_root_domain(struct root_domain *rd);
>>>    extern void dl_clear_root_domain_cpu(int cpu);
>>> +/*
>>> + * Return whether moving DL task @p to @new_mask requires moving DL
>>> + * bandwidth accounting between root domains. This helper is specific to
>>> + * DL bandwidth move accounting semantics and is shared by
>>> + * cpuset_can_attach() and set_cpus_allowed_dl() so both paths use the
>>> + * same source root-domain test.
>>> + */
>>> +extern bool dl_task_needs_bw_move(struct task_struct *p,
>>> +                  const struct cpumask *new_mask);
>>>      extern u64 dl_cookie;
>>>    extern bool dl_bw_visited(int cpu, u64 cookie);
>>> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
>>> index bb4e692bea30..f7aaf01f7cd5 100644
>>> --- a/kernel/cgroup/cpuset-internal.h
>>> +++ b/kernel/cgroup/cpuset-internal.h
>>> @@ -167,6 +167,7 @@ struct cpuset {
>>>         */
>>>        int nr_deadline_tasks;
>>>        int nr_migrate_dl_tasks;
>>> +    /* DL bandwidth that needs destination reservation for this attach. */
>>>        u64 sum_migrate_dl_bw;
>>>        /*
>>>         * CPU used for temporary DL bandwidth allocation during attach;
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index e3a081a07c6d..761098b45f23 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -2993,7 +2993,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>>>        struct cpuset *cs, *oldcs;
>>>        struct task_struct *task;
>>>        bool setsched_check;
>>> -    int ret;
>>> +    int cpu, ret;
>>>          /* used later by cpuset_attach() */
>>>        cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
>>> @@ -3039,31 +3039,31 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>>>              if (dl_task(task)) {
>>>                cs->nr_migrate_dl_tasks++;
>>> -            cs->sum_migrate_dl_bw += task->dl.dl_bw;
>>> +
>>> +            if (dl_task_needs_bw_move(task, cs->effective_cpus))
>>> +                cs->sum_migrate_dl_bw += task->dl.dl_bw;
>>>            }
>>>        }
>>>    -    if (!cs->nr_migrate_dl_tasks)
>>> +    if (!cs->sum_migrate_dl_bw)
>>>            goto out_success;
>> You should make sure that cs->nr_migrate_dl_tasks is cleared too. Alternatively, you can move the dl task increment under the dl_task_needs_bw_move() check. It doesn't seem to do any harm if nr_migrate_dl_tasks is non-zero, but dl_bw is 0, but it still doesn't look right.😅 Sorry, I missed this part of your review earlier and only noticed the
> RCU comment at first.
>
> For nr_migrate_dl_tasks, my understanding is that it should remain
> separate from sum_migrate_dl_bw.
>
> nr_migrate_dl_tasks is used for cpuset-level DL task accounting, while
> sum_migrate_dl_bw is used for destination root-domain bandwidth
> reservation. A DL task may move between cpusets without requiring a
> root-domain bandwidth move, but cpuset_attach() still needs to update
> the cpuset DL task counts for that task.
>
> So, unless I am missing another use of nr_migrate_dl_tasks, moving
> nr_migrate_dl_tasks++ under the dl_task_needs_bw_move() check does not
> look like the right fix to me. It could miss DL tasks which still need
> cpuset DL task accounting updates, even though no DL bandwidth
> reservation is needed.
>
> Please let me know if I am missing something here, or if there is a
> better way to represent this state in the code.

You are right. Cpuset structure has a nr_deadline_tasks count that 
requires proper accounting of nr_migrate_dl_tasks to set this field 
correctly.

Cheers,
Longman

>
> In v2, I plan to keep nr_migrate_dl_tasks counting all migrating DL
> tasks, and only restrict sum_migrate_dl_bw to tasks that actually need
> destination root-domain bandwidth reservation. I will also add a separate
> first patch to reset the pending DL migration state
> (nr_migrate_dl_tasks, sum_migrate_dl_bw and dl_bw_cpu) on
> cpuset_can_attach() internal failure paths, so these temporary states
> will not leak.
>
> I still need to do some testing after my leave, and will send v2 after
> that.
>
> Thanks,
> Guopeng
>


