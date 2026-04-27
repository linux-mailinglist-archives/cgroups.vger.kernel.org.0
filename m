Return-Path: <cgroups+bounces-15513-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UK0PDGRq72l3BAEAu9opvQ
	(envelope-from <cgroups+bounces-15513-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 27 Apr 2026 15:53:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE19F473C92
	for <lists+cgroups@lfdr.de>; Mon, 27 Apr 2026 15:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3AAC302FEB1
	for <lists+cgroups@lfdr.de>; Mon, 27 Apr 2026 13:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E7140DFDF;
	Mon, 27 Apr 2026 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWQnk3xw"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE903CEB8A
	for <cgroups@vger.kernel.org>; Mon, 27 Apr 2026 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297695; cv=none; b=oNiAPcaEDZe/E0VwnWm5StZbq7FO737ZQwiQTDcAF7dCe5dfv/K9B1s3KF0M61YFVUbTnfTGm57btUFtJavbaz9pZvxjXyNaQoWoeqI3TaIxuVk/Dp3EIwKNUqhjAqnao/RQjrxNQfFLwnrkKvurqnuQUFsyjQ12IDRF84JhFgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297695; c=relaxed/simple;
	bh=8mp1DBUp19jjnlYN6lMO9HGXtclhHMQVo7lV5VuRn4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZabcuR938jYh7bdsQgEjVqvAB4PIGzmXPifavuWj0SulzCHqKPe6fcwDJCgQBbxIIm/sluDgPA30X8OurAWWUSRPy/+nblX3vYUKXdeCN7dmUrzEcoXou32d4wqnB8omnecyAMavsqHFCiql2AYO2ktRrikqlU2by7nKb+yqws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GWQnk3xw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777297693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKKKi3uazMIQ+0ytyS2NcN1unJ5MZAYQ6rZD4bUtvBw=;
	b=GWQnk3xwQSzuRvmCsxKNiCti4nViCmVouZB8wnxioEeXvsyKY2x7jvsxXV5V5OpLbrCGAu
	Af5Uc1L06sWOtSyDCIm58yIttF9/Kdnv+ejGiqVtNscjegx1HoM3GwDE/7klDKOShgq17/
	IxLj8mYco//oWJRjPwvcyiIqqNL5D5Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-A3EXpHVnPK-WrfEhuARYjg-1; Mon,
 27 Apr 2026 09:48:06 -0400
X-MC-Unique: A3EXpHVnPK-WrfEhuARYjg-1
X-Mimecast-MFC-AGG-ID: A3EXpHVnPK-WrfEhuARYjg_1777297684
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6629319560B2;
	Mon, 27 Apr 2026 13:48:03 +0000 (UTC)
Received: from [10.22.65.144] (unknown [10.22.65.144])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 16C5B180047F;
	Mon, 27 Apr 2026 13:47:59 +0000 (UTC)
Message-ID: <60bc60ba-670e-49f5-8482-54aed4563fae@redhat.com>
Date: Mon, 27 Apr 2026 09:47:59 -0400
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
 <ed0fa795-10f4-4dd0-a6f5-cbc6e29b38c4@kylinos.cn>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ed0fa795-10f4-4dd0-a6f5-cbc6e29b38c4@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: CE19F473C92
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
	TAGGED_FROM(0.00)[bounces-15513-lists,cgroups=lfdr.de];
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

On 4/26/26 9:48 AM, Guopeng Zhang wrote:
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
> ...
>>> @@ -3137,6 +3135,16 @@ static void set_cpus_allowed_dl(struct task_struct *p,
>>>        set_cpus_allowed_common(p, ctx);
>>>    }
>>>    +bool dl_task_needs_bw_move(struct task_struct *p,
>>> +               const struct cpumask *new_mask)
>>> +{
>>> +    if (!dl_task(p))
>>> +        return false;
>>> +
>>> +    guard(rcu)();
>> What do you need a RCU guard here?
> Hi Longman,
>
> Thanks for the review.
>
> I added the RCU guard in the first version because the helper reads
> task_rq(p)->rd->span, and root domains are replaced and freed through
> RCU. My initial thought was to make the helper self-contained for the
> rq->rd/span lifetime aspect.
>
> After re-checking the current callers more carefully,
> dl_task_needs_bw_move() is only used by cpuset_can_attach() and
> set_cpus_allowed_dl() in this patch.
>
> cpuset_can_attach() runs in the cgroup attach path, which already holds
> cpus_read_lock(), and cpuset itself also holds cpuset_mutex there.
> set_cpus_allowed_dl() runs under task_rq_lock()/rq->lock in the affinity
> change path.
>
> So for the current callers, the RCU guard does not appear to be
> strictly necessary.
>
> I plan to drop guard(rcu)() in the next version. Does that sound
> reasonable to you?
>
> I am also checking the Sashiko bot comments and will address them in the
> next revision as appropriate.

That sounds reasonable. Creation/destruction of root domains are 
controlled by cpuset. So root domains won't be changing when calling 
from the cpuset code in cpuset_can_attach().

Cheers,
Longman


