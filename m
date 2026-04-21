Return-Path: <cgroups+bounces-15428-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IQoOhs752no5QEAu9opvQ
	(envelope-from <cgroups+bounces-15428-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 10:53:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE604386D4
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 10:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA5CE300E5B8
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 08:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18E839A818;
	Tue, 21 Apr 2026 08:53:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A4E39DBDC;
	Tue, 21 Apr 2026 08:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761623; cv=none; b=LF6qW9eWI++45j7tSL14DVc3zVYTQ5M/AY4am6hBnV/B9VKJa/kxtYIYvVSCLVfwxJeZ/kdYZb3kEKuHW1msf/lGTns1IW02S26294ZidnLYBRQp4H64bzMS+2+sVy4AotucrBFE6Hwvez4hJJQSrTaZ6KN6wZGVeFvw0DK/DMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761623; c=relaxed/simple;
	bh=SzmPKt5yZqPTFSqj+BfxX+QUOx3prIS63aahYxX+dPI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Jsfx89up9eDlXHDzY7hUlV+zrwWZ0OhWKCmhCfJBsW8voh6LRiFQGNFnLfB4F6uVoJyuzbLeFqsL+9uwaPOxSS/5nNP7wy3tlNfxDMMnDIiFRRClDo/M01qt6qXa7YPuwq3rUbzsWW6fGaqRYkHPQgM4lYXYAtFTx+51ivXh7lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9444e5483d5f11f1aa26b74ffac11d73-20260421
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9a4d808b-35a9-4799-83de-7fe31160462f,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:9a4d808b-35a9-4799-83de-7fe31160462f,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:fe6df8a5ed6e6aa4455c96c7e29b854f,BulkI
	D:260418025220HY7ZQDDV,BulkQuantity:5,Recheck:0,SF:17|19|38|64|66|78|80|81
	|82|83|102|127|841|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:99|1,File:n
	il,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0
	,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9444e5483d5f11f1aa26b74ffac11d73-20260421
X-User: zhangguopeng@kylinos.cn
Received: from [192.168.109.140] [(183.242.174.22)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1070723433; Tue, 21 Apr 2026 16:53:34 +0800
Message-ID: <d683b3c8-f746-47cd-a306-314a8f3eecea@kylinos.cn>
Date: Tue, 21 Apr 2026 16:53:29 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
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
 <6aca2465-1ea7-417a-beb8-e385fa3902bf@kylinos.cn>
 <e0fea6ec-397c-40a6-9300-a3529a3d1167@redhat.com>
In-Reply-To: <e0fea6ec-397c-40a6-9300-a3529a3d1167@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	URIBL_RED(0.50)[kylinos.cn:mid,kylinos.cn:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_ANON_DOMAIN(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-15428-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[kylinos.cn];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangguopeng@kylinos.cn,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,kylinos.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9AE604386D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



在 2026/4/20 10:31, Waiman Long 写道:
> On 4/19/26 10:21 PM, Guopeng Zhang wrote:
>>
>> 在 2026/4/18 2:51, Waiman Long 写道:
>>> On 4/16/26 11:37 PM, Guopeng Zhang wrote:
>>>> cpuset_can_attach() allocates DL bandwidth only when migrating
>>>> deadline tasks to a disjoint CPU mask, but cpuset_cancel_attach()
>>>> rolls back based only on nr_migrate_dl_tasks. This makes the DL
>>>> bandwidth alloc/free paths asymmetric: rollback can call dl_bw_free()
>>>> even when no dl_bw_alloc() was done.
>>>>
>>>> Rollback also needs to undo the reservation against the same CPU/root
>>>> domain that was charged. Record the CPU used by dl_bw_alloc() and use
>>>> that state in cpuset_cancel_attach(). If no allocation happened,
>>>> dl_bw_cpu stays at -1 and rollback skips dl_bw_free(). If allocation
>>>> did happen, bandwidth is returned to the same CPU/root domain.
>>>>
>>>> Successful attach paths are unchanged. This only fixes failed attach
>>>> rollback accounting.
>>>>
>>>> Fixes: 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach() fails")
>>>> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
>> ...
>>> The patch looks correct to me.
>>>
>>> Reviewed-by: Waiman Long <longman@redhat.com>
>> Hi Waiman,
>>
>> Thank you for the review and for the Reviewed-by.
>>> However, I have a DL bandwidth accounting question unrelated to this patch that I would like the scheduler people to clarify. The allocation of additional DL BW is based on the condition
>>>
>>>          if (!cpumask_intersects(oldcs->effective_cpus, cs->effective_cpus)) {
>>>
>>> IOW, additional DL BW will need to be allocated when the old and new cpuset doesn't overlap. However, they could still be in the same root domain. Does that mean we will be double counting it?
>> I think you are right to call this out. Looking at the
>> current logic, !cpumask_intersects(oldcs->effective_cpus, cs->effective_cpus)
>> does not obviously guarantee that the migration is crossing into a different
>> root domain. If the old and new cpusets are disjoint but still belong to the
>> same root domain, it does look possible that we reserve bandwidth on the
>> destination side without a corresponding subtraction from the source side.
>> I will try to reproduce that configuration and follow up with results.
Hi Waiman,

I reproduced the issue you pointed out, and the result does support
your concern.

I also tested the follow-up fix here:
https://lore.kernel.org/all/20260421083449.95750-1-zhangguopeng@kylinos.cn/

I tested two cases:
1. disjoint member cpusets that still belong to the same root-domain
   setup
2. disjoint partition-root cpusets that do cross root domains

The results look consistent with the bug and with the fix.
Case 1: disjoint member cpusets
Setup:
src: cpuset.cpus = 1-15
dst: cpuset.cpus = 0
both remained "member"

Without the fix, successful back-and-forth migration of the same
SCHED_DEADLINE task caused dl_bw->total_bw on CPU0 to increase
monotonically:
BW0 = 2027221
BW1 = 2376746
BW2 = 2726271

So:
BW1 - BW0 = 349525
BW2 - BW0 = 699050

That is, after src -> dst, dl_bw->total_bw increased, and after
dst -> src it increased again by about the same amount instead of
returning to the original value.

With the fix applied, the same reproducer no longer shows any net
increase, while the attach path still succeeds:

BW0 = 2027221
BW1 = 2027221
BW2 = 2027221

So:
BW1 - BW0 = 0
BW2 - BW0 = 0

Case 2: disjoint partition-root cpusets (true cross-root-domain move)
I also tested a configuration where src and dst are separate partition
roots:
src: cpuset.cpus = 0-6, cpuset.cpus.partition = root
dst: cpuset.cpus = 8-14, cpuset.cpus.partition = root

Then I started the DL task in src and migrated it to dst.

The accounting moved as expected:
Before src -> dst:
SRC0 = 1083517
DST0 =  733992

After src -> dst:
SRC1 =  733992
DST1 = 1083517

Deltas:
SRC delta after src -> dst = -349525
DST delta after src -> dst = +349525

After moving the same task back to src:
SRC2 = 1083517
DST2 =  733992

So both sides returned to baseline:
SRC2 - SRC0 = 0
DST2 - DST0 = 0

So with the fix applied, the same-root-domain case no longer leaves
persistent extra DL bandwidth accounting, while the true cross-root-domain
case still moves the bandwidth accounting as expected.

Shortened reproducers and observed values are below.
Case 1: disjoint member cpusets

echo "+cpu +cpuset" > /sys/fs/cgroup/cgroup.subtree_control
mkdir -p /sys/fs/cgroup/dl-rd-test
echo 0-15 > /sys/fs/cgroup/dl-rd-test/cpuset.cpus
echo 0 > /sys/fs/cgroup/dl-rd-test/cpuset.mems
echo "+cpu +cpuset" > /sys/fs/cgroup/dl-rd-test/cgroup.subtree_control

mkdir -p /sys/fs/cgroup/dl-rd-test/src
mkdir -p /sys/fs/cgroup/dl-rd-test/dst
echo 1-15 > /sys/fs/cgroup/dl-rd-test/src/cpuset.cpus
echo 0 > /sys/fs/cgroup/dl-rd-test/src/cpuset.mems
echo 0 > /sys/fs/cgroup/dl-rd-test/dst/cpuset.cpus
echo 0 > /sys/fs/cgroup/dl-rd-test/dst/cpuset.mems

/tmp/dl_test &
PID=$!
echo $PID > /sys/fs/cgroup/dl-rd-test/src/cgroup.procs

# read BW0 from cpu0 dl_bw->total_bw
# move src -> dst
# read BW1
# move dst -> src
# read BW2

Observed without fix:
BW0=2027221
BW1=2376746
BW2=2726271

Observed with fix:
BW0=2027221
BW1=2027221
BW2=2027221

Case 2: disjoint partition-root cpusets
echo "+cpu +cpuset" > /sys/fs/cgroup/cgroup.subtree_control
mkdir -p /sys/fs/cgroup/dl-rd-part-test
echo 0-15 > /sys/fs/cgroup/dl-rd-part-test/cpuset.cpus
echo 0 > /sys/fs/cgroup/dl-rd-part-test/cpuset.mems
echo 0-15 > /sys/fs/cgroup/dl-rd-part-test/cpuset.cpus.exclusive
echo "+cpu +cpuset" > /sys/fs/cgroup/dl-rd-part-test/cgroup.subtree_control

mkdir -p /sys/fs/cgroup/dl-rd-part-test/src
echo 0-6 > /sys/fs/cgroup/dl-rd-part-test/src/cpuset.cpus
echo 0 > /sys/fs/cgroup/dl-rd-part-test/src/cpuset.mems
echo 0-6 > /sys/fs/cgroup/dl-rd-part-test/src/cpuset.cpus.exclusive
echo root > /sys/fs/cgroup/dl-rd-part-test/src/cpuset.cpus.partition

mkdir -p /sys/fs/cgroup/dl-rd-part-test/dst
echo 8-14 > /sys/fs/cgroup/dl-rd-part-test/dst/cpuset.cpus
echo 0 > /sys/fs/cgroup/dl-rd-part-test/dst/cpuset.mems
echo 8-14 > /sys/fs/cgroup/dl-rd-part-test/dst/cpuset.cpus.exclusive
echo root > /sys/fs/cgroup/dl-rd-part-test/dst/cpuset.cpus.partition

sh -c 'echo $$ > /sys/fs/cgroup/dl-rd-part-test/src/cgroup.procs; exec /tmp/dl_test' &
PID=$!

# read source-side and destination-side dl_bw->total_bw
# move src -> dst
# read both again
# move dst -> src
# read both again

Observed with fix:
SRC0=1083517
DST0=733992
SRC1=733992
DST1=1083517
SRC2=1083517
DST2=733992

This matches the intended behavior: no persistent increase within one
root domain, and correct bandwidth transfer across root domains.

Cheers,
Guopeng

>>> Looking from the other side, the root domain may have enough DL BW for the task migration, but the subset of CPUs in the cpuset itself may not have enough total DL BW to host all the DL tasks to be migrated, is that a problem?
>> my current understanding is that the DL bandwidth
>> accounting is done at root-domain granularity, not at arbitrary cpuset-subset
>> granularity.
> That is my understanding too.
>> That also seems consistent with
>> Documentation/scheduler/sched-deadline.rst, which says that deadline tasks
>> cannot have a CPU affinity mask smaller than the root domain they are created
>> on, and that a restricted CPU set should be achieved by creating a restricted
>> root domain with cpuset.
> 
> A root domain should be created by creating cpuset root partition for v2 or using the cpuset.cpu_exclusive flag in v1.
> 
> What is listed in the documentation is the ideal case, but users may not strictly follow the rule.
> 
> Cheers,
> Longman
> 
>>
>> So if a cpuset is only a subset inside a larger root domain, it does not seem
>> to get an independent DL bandwidth limit of its own. If that understanding is
>> correct, then the smaller cpuset not having enough bandwidth by itself would
>> be a limitation of that model rather than something this code checks
>> separately. I'd appreciate confirmation from the scheduler folks on that
>> point.
>>
>> Thanks,
>> Guopeng
>>> Cheers,
>>> Longman


