Return-Path: <cgroups+bounces-15681-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCe8CgHh/Wn0jwAAu9opvQ
	(envelope-from <cgroups+bounces-15681-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 15:11:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4084F6D13
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 15:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF110300BC81
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2026 13:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D27B3DD535;
	Fri,  8 May 2026 13:11:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B5D12CDBE;
	Fri,  8 May 2026 13:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778245881; cv=none; b=NOqKGOqkYsLS2vJz2GY+h/a04clJEN7fN5tjsgAfih7ia1lqiidMvapJsKx8jIEgHEfyAPblSxVHKYLMTg3VkrOeS+naYKyMwEKB0QnDL4DoMyU6FzqXxPxNRwWJQpX3VJPPCLctOc+np3iCZXHMA4OnywzlURMUt4uVUlq7AB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778245881; c=relaxed/simple;
	bh=sGdZav0peJgW/5MCXcnrYghoNnDkkcmwh9USdwlecpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nO5UuygIvFoV6TPiipuE+XygAFVwRbQPr+OVt0wVH+qJ7QmgaDhaCGmeqQweb9OpWgOCV8pQ5y7ge4OEMlydsThSsyQBxgLB64XscuajTUp79iKA+dTgkZZwXNn/FY82QATGjMgJQE0HBEO92FdEuDejOWYog/7UOv4sF1q4H6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 623d2a324adf11f1aa26b74ffac11d73-20260508
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9f84b302-5754-4d36-b1f0-1027f5db508a,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:9f84b302-5754-4d36-b1f0-1027f5db508a,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:06fede8ac51dee2be5ba4406ada60da0,BulkI
	D:260508055456XFUBQV8Q,BulkQuantity:1,Recheck:0,SF:17|19|38|64|66|78|80|81
	|82|83|102|127|841|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:nil,
	RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DK
	P:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 623d2a324adf11f1aa26b74ffac11d73-20260508
X-User: zhangguopeng@kylinos.cn
Received: from [192.168.109.140] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 702554823; Fri, 08 May 2026 21:11:11 +0800
Message-ID: <463a7e3b-32a6-4fa2-923b-c28e376a9d0a@kylinos.cn>
Date: Fri, 8 May 2026 21:11:06 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cgroup/cpuset: align DL bandwidth reservation with
 attach target mask
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Gabriele Monaco <gmonaco@redhat.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20260507103310.35849-1-zhangguopeng@kylinos.cn>
 <20260507103310.35849-3-zhangguopeng@kylinos.cn>
 <4e718145-5af6-40c3-83da-a004904e29d1@redhat.com>
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
In-Reply-To: <4e718145-5af6-40c3-83da-a004904e29d1@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1D4084F6D13
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
	NEURAL_HAM(-0.00)[-0.990];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangguopeng@kylinos.cn,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kylinos.cn:email,kylinos.cn:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15681-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Action: no action



在 2026/5/7 23:52, Waiman Long 写道:
> On 5/7/26 6:33 AM, Guopeng Zhang wrote:
>> cpuset_can_attach() preallocates destination SCHED_DEADLINE bandwidth
>> before the attach commit point, while set_cpus_allowed_dl() later
>> subtracts bandwidth from the source root domain when the task affinity is
>> actually updated.
>>
>> Those two decisions must be made with the same CPU mask.
>> cpuset_can_attach() used the destination cpuset effective mask directly,
>> but cpuset_attach_task() first builds a per-task target mask which is
>> constrained by task_cpu_possible_mask() and, if needed, by walking up the
>> cpuset hierarchy. On asymmetric systems, the actual target mask can
>> therefore be a strict subset of cs->effective_cpus.
> 
> The task_cpu_possible_mask() is there for a special class of arm64 CPUs where only some of the cores are able to run legacy 32-bit applications on 64-bit arm CPUs. We can argue how likely that a DL task can be a legacy 32 bit application that is inherently slower than the same application compiled into native 64-bit code. Perhaps we can just disallow such a legacy 32-bit application from moving to a DL scheduling class in the first place.
> 
> I am not in favor of the idea of making the cpuset code more complex to support such a corner case which may never be utilized. Could you strip out the task_possible_cpu_mask() part from this patch? We can revisit this with another patch if such a special use case can be useful to support in the future.
> 
Thanks for the review.

I agree. The task_cpu_possible_mask() case makes the fix broader and
adds more cpuset-side complexity than needed for this series.

I will drop the cpuset_attach_task() target-mask mirroring from v3 and
keep cpuset_can_attach() using cs->effective_cpus. The updated patch will
only share the root-domain bandwidth-move test with set_cpus_allowed_dl()
and only add a migrating DL task to sum_migrate_dl_bw when that task
actually needs a root-domain bandwidth move.

The task_cpu_possible_mask() corner case can be revisited separately if
there is a real need to support that scenario.

Thanks,
Guopeng
> Cheers,
> Longman
> 
>>
>> If the source root domain intersects cs->effective_cpus only on CPUs
>> outside the task's possible mask, can_attach() can skip the destination
>> reservation even though set_cpus_allowed_dl() later sees a real
>> root-domain move and subtracts from the source domain.
>>
>> Extract the root-domain bandwidth-move test used by
>> set_cpus_allowed_dl() into dl_task_needs_bw_move(), and make
>> cpuset_can_attach() compute the same per-task target mask that
>> cpuset_attach_task() applies.
>>
>> Keep nr_migrate_dl_tasks counting all migrating deadline tasks for
>> cpuset DL task accounting. Restrict sum_migrate_dl_bw to the subset of
>> tasks that need destination root-domain bandwidth reservation, because a
>> deadline task can move between cpusets without moving bandwidth between
>> root domains.
>>
>> This keeps the existing per-attach aggregate reservation model; it only
>> changes the per-task mask used to decide which tasks contribute to that
>> aggregate. The broader can_attach()/attach() transaction window is left
>> unchanged.
>>
>> Fixes: 431c69fac05b ("cpuset: Honour task_cpu_possible_mask() in guarantee_online_cpus()")
>> Fixes: 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach() fails")
>> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
>> ---
>>   include/linux/sched/deadline.h  |  9 +++
>>   kernel/cgroup/cpuset-internal.h |  1 +
>>   kernel/cgroup/cpuset.c          | 97 ++++++++++++++++++++++-----------
>>   kernel/sched/deadline.c         | 13 ++++-
>>   4 files changed, 86 insertions(+), 34 deletions(-)
>>



