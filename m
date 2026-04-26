Return-Path: <cgroups+bounces-15511-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2I69IbYX7mmZqgAAu9opvQ
	(envelope-from <cgroups+bounces-15511-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 26 Apr 2026 15:48:38 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF1746A12E
	for <lists+cgroups@lfdr.de>; Sun, 26 Apr 2026 15:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C9FD1300250A
	for <lists+cgroups@lfdr.de>; Sun, 26 Apr 2026 13:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE73136215E;
	Sun, 26 Apr 2026 13:48:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402AB146A66;
	Sun, 26 Apr 2026 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777211310; cv=none; b=Vsv4ulDYRxiYURDPcaWcKKyz4ms1wMjhN80nioCv0D5Qb08ShTjOAmzfYS36J8rbKYEYlW2ssyETnDAyl9WVu1NqVHRVQPZtQSRJ9rZ6QzZn9j4rKCa37XV45O0xeCDZEcXNCWZVTNfTo5zV3SDN/BhxGfEFxRTWwU0SaMnyKCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777211310; c=relaxed/simple;
	bh=RCZPMytAoLSu1Vjyg2TYJjw0rfSKQIeUhSJ1bXnTA24=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=j7d5l4ZZrIAlEHKbwg7otyUzaRklqnpvbjyg0MMxNOVdUwssLhpz/+W5q3yHPnOU/yLpS/BePLamZ28zyLXq/57697zvEijFTksgJNkunyK7KguIx0R5qrTVGmsuDWFnqF8yDDgdfXibXdvALkLfEXS5MWVxqH7jH87iWWMhGAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9169dc8c417611f1aa26b74ffac11d73-20260426
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:826416b8-b667-435d-b86a-e4cb713ebb6b,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:826416b8-b667-435d-b86a-e4cb713ebb6b,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:bafbcb62351823e7e39f018eb48c1f4e,BulkI
	D:26042210141563B83QR0,BulkQuantity:3,Recheck:0,SF:17|19|38|64|66|78|80|81
	|82|83|102|127|841|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:nil,
	RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DK
	P:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9169dc8c417611f1aa26b74ffac11d73-20260426
X-User: zhangguopeng@kylinos.cn
Received: from [10.73.232.3] [(223.160.129.179)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 895363318; Sun, 26 Apr 2026 21:48:12 +0800
Message-ID: <ed0fa795-10f4-4dd0-a6f5-cbc6e29b38c4@kylinos.cn>
Date: Sun, 26 Apr 2026 21:48:04 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
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
In-Reply-To: <6840e385-ef47-4f83-bf4c-8f80843f8c1d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7DF1746A12E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangguopeng@kylinos.cn,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15511-lists,cgroups=lfdr.de];
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
...
>> @@ -3137,6 +3135,16 @@ static void set_cpus_allowed_dl(struct task_struct *p,
>>       set_cpus_allowed_common(p, ctx);
>>   }
>>   +bool dl_task_needs_bw_move(struct task_struct *p,
>> +               const struct cpumask *new_mask)
>> +{
>> +    if (!dl_task(p))
>> +        return false;
>> +
>> +    guard(rcu)();
> 
> What do you need a RCU guard here?
Hi Longman,

Thanks for the review.

I added the RCU guard in the first version because the helper reads
task_rq(p)->rd->span, and root domains are replaced and freed through
RCU. My initial thought was to make the helper self-contained for the
rq->rd/span lifetime aspect.

After re-checking the current callers more carefully,
dl_task_needs_bw_move() is only used by cpuset_can_attach() and
set_cpus_allowed_dl() in this patch.

cpuset_can_attach() runs in the cgroup attach path, which already holds
cpus_read_lock(), and cpuset itself also holds cpuset_mutex there.
set_cpus_allowed_dl() runs under task_rq_lock()/rq->lock in the affinity
change path.

So for the current callers, the RCU guard does not appear to be
strictly necessary.

I plan to drop guard(rcu)() in the next version. Does that sound
reasonable to you?

I am also checking the Sashiko bot comments and will address them in the
next revision as appropriate.

Thanks,
Guopeng
> 
> Cheers,
> Longman
> 
>> +    return !cpumask_intersects(task_rq(p)->rd->span, new_mask);
>> +}
>> +
>>   /* Assumes rq->lock is held */
>>   static void rq_online_dl(struct rq *rq)
>>   {


