Return-Path: <cgroups+bounces-15362-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDyfAdiN5WnXlQEAu9opvQ
	(envelope-from <cgroups+bounces-15362-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 04:22:16 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 72206426346
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 04:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 53BB53007485
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 02:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F7837756A;
	Mon, 20 Apr 2026 02:21:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0641A6815;
	Mon, 20 Apr 2026 02:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776651709; cv=none; b=AalWzXrsW2BH7mYLoeZWXgngk2yvzxF/smrqIctB680eJcGBHlo2ZTcIFOpacbbdM+0VF6xjzl8TL4irkrFA4bNsWX9uKZg+yJ8Tj2ntUuufYPmcl2bMo4SsKrIs0fsbw9mfPg/CCO9HoarB8/VUJMU8DYRPrcqB0UNn8miuCv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776651709; c=relaxed/simple;
	bh=t4u4wTWP1BbggkuhMvzs6ldT2BayjtuWIvdPkOfD1dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NS8912Iu9bsMkSsdNR+Z6BZhBGeycPFYjG4Xksb+FYxN2BjCnNSt8o9R7Fp/OAwRSGTr4w+DQ4S2QgsvnHSBCN6r4SkS9OBwASpDYQyVeWNOO3hPU/iUD8DV5gg6K6Mx75BBXarS619H/zwkzNlhGLd4ztuRHYc4XUvG5Fby2RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ab0e13683c5f11f1aa26b74ffac11d73-20260420
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:3427aa08-ee52-4069-8f53-dfa285773378,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:3427aa08-ee52-4069-8f53-dfa285773378,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:9f0511151a07bdd9f37d7d552cf04fa4,BulkI
	D:260418025220HY7ZQDDV,BulkQuantity:1,Recheck:0,SF:17|19|38|64|66|78|80|81
	|82|83|102|127|841|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:nil,
	RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DK
	P:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ab0e13683c5f11f1aa26b74ffac11d73-20260420
X-User: zhangguopeng@kylinos.cn
Received: from [192.168.109.140] [(183.242.174.20)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 233657790; Mon, 20 Apr 2026 10:21:41 +0800
Message-ID: <6aca2465-1ea7-417a-beb8-e385fa3902bf@kylinos.cn>
Date: Mon, 20 Apr 2026 10:21:36 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cgroup/cpuset: record DL BW alloc CPU for attach
 rollback
To: Waiman Long <longman@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
 changwoo@igalia.com, shuah@kernel.org, chenridong@huaweicloud.com,
 Juri Lelli <juri.lelli@redhat.com>, Valentin Schneider
 <vschneid@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: cgroups@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260417033742.40793-1-zhangguopeng@kylinos.cn>
 <20260417033742.40793-2-zhangguopeng@kylinos.cn>
 <fd28bea7-83bd-48b7-8c3c-ad44474b8b5b@redhat.com>
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
In-Reply-To: <fd28bea7-83bd-48b7-8c3c-ad44474b8b5b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangguopeng@kylinos.cn,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kylinos.cn:mid,kylinos.cn:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15362-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 72206426346
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



在 2026/4/18 2:51, Waiman Long 写道:
> On 4/16/26 11:37 PM, Guopeng Zhang wrote:
>> cpuset_can_attach() allocates DL bandwidth only when migrating
>> deadline tasks to a disjoint CPU mask, but cpuset_cancel_attach()
>> rolls back based only on nr_migrate_dl_tasks. This makes the DL
>> bandwidth alloc/free paths asymmetric: rollback can call dl_bw_free()
>> even when no dl_bw_alloc() was done.
>>
>> Rollback also needs to undo the reservation against the same CPU/root
>> domain that was charged. Record the CPU used by dl_bw_alloc() and use
>> that state in cpuset_cancel_attach(). If no allocation happened,
>> dl_bw_cpu stays at -1 and rollback skips dl_bw_free(). If allocation
>> did happen, bandwidth is returned to the same CPU/root domain.
>>
>> Successful attach paths are unchanged. This only fixes failed attach
>> rollback accounting.
>>
>> Fixes: 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach() fails")
>> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
...
> 
> The patch looks correct to me.
> 
> Reviewed-by: Waiman Long <longman@redhat.com>
Hi Waiman,

Thank you for the review and for the Reviewed-by.
> 
> However, I have a DL bandwidth accounting question unrelated to this patch that I would like the scheduler people to clarify. The allocation of additional DL BW is based on the condition
> 
>         if (!cpumask_intersects(oldcs->effective_cpus, cs->effective_cpus)) {
> 
> IOW, additional DL BW will need to be allocated when the old and new cpuset doesn't overlap. However, they could still be in the same root domain. Does that mean we will be double counting it?
I think you are right to call this out. Looking at the
current logic, !cpumask_intersects(oldcs->effective_cpus, cs->effective_cpus)
does not obviously guarantee that the migration is crossing into a different
root domain. If the old and new cpusets are disjoint but still belong to the
same root domain, it does look possible that we reserve bandwidth on the
destination side without a corresponding subtraction from the source side.
I will try to reproduce that configuration and follow up with results.
> 
> Looking from the other side, the root domain may have enough DL BW for the task migration, but the subset of CPUs in the cpuset itself may not have enough total DL BW to host all the DL tasks to be migrated, is that a problem?
my current understanding is that the DL bandwidth
accounting is done at root-domain granularity, not at arbitrary cpuset-subset
granularity. That also seems consistent with
Documentation/scheduler/sched-deadline.rst, which says that deadline tasks
cannot have a CPU affinity mask smaller than the root domain they are created
on, and that a restricted CPU set should be achieved by creating a restricted
root domain with cpuset.

So if a cpuset is only a subset inside a larger root domain, it does not seem
to get an independent DL bandwidth limit of its own. If that understanding is
correct, then the smaller cpuset not having enough bandwidth by itself would
be a limitation of that model rather than something this code checks
separately. I'd appreciate confirmation from the scheduler folks on that
point.

Thanks,
Guopeng
> 
> Cheers,
> Longman


