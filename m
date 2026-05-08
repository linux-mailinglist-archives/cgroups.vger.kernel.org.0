Return-Path: <cgroups+bounces-15680-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FYPLSDf/Wn0jwAAu9opvQ
	(envelope-from <cgroups+bounces-15680-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 15:03:28 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F304F6BC2
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 15:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C4C9300723A
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2026 13:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC703DCD92;
	Fri,  8 May 2026 13:03:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2DA2773CA;
	Fri,  8 May 2026 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778245397; cv=none; b=u4JiaWLzVPc89ek/nAk44Nw008o7Y+Q3bEfmrBMZ3wpn3L1T/0EEEWOEGiMZrsxjwymPf06GSpA9nYQTEuN+Nb2udKQG6OwmzyonWoSNEN7H7mG+jOD6OeqszkeNSE/FApP86cmRVmSGtPgQZ2HrCzx9vvDqHaaF7L17coUmtio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778245397; c=relaxed/simple;
	bh=7oB/+DePViaR7ZJoD7CuSrkDH/F8poHPtJococJIuFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTbmDxvwwzYICLqG1C1fIUdJlik+82VBleyC78sT6X/YkMYgkRu8F+97Cdmw+3Cv5ewj6g2xAg8RIJgakm0Iu4pL5D1kXjgbwDNZSPh9JVxra4aGWCoyMG6p3v8gra54AuTBWagOw/J1tmCWzW4y+XNiTNCHX/BsHkc6pulzLCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 43706d044ade11f1aa26b74ffac11d73-20260508
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:34c4b75c-3af8-429a-897c-940f9f314b9d,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:34c4b75c-3af8-429a-897c-940f9f314b9d,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:8ef4b3f12a0bbcd439f9e2e7c04c78de,BulkI
	D:260507223123V6O1L4NK,BulkQuantity:4,Recheck:0,SF:17|19|38|64|66|78|80|81
	|82|83|102|127|841|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:nil,
	RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DK
	P:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 43706d044ade11f1aa26b74ffac11d73-20260508
X-User: zhangguopeng@kylinos.cn
Received: from [192.168.109.140] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 60703710; Fri, 08 May 2026 21:03:09 +0800
Message-ID: <a1b8898f-eb52-4345-937c-a549617de553@kylinos.cn>
Date: Fri, 8 May 2026 21:03:04 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cgroup/cpuset: reset DL migration state on
 can_attach() failure
To: Waiman Long <longman@redhat.com>, Chen Ridong
 <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Gabriele Monaco <gmonaco@redhat.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20260507103310.35849-1-zhangguopeng@kylinos.cn>
 <20260507103310.35849-2-zhangguopeng@kylinos.cn>
 <6410d11c-1d8a-4e72-ac22-43058027b304@redhat.com>
 <5d69e8bb-c925-4de2-8d50-0880b23864e0@huaweicloud.com>
 <ff904e7f-60bd-40ce-818e-b03b47a79e6f@redhat.com>
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
In-Reply-To: <ff904e7f-60bd-40ce-818e-b03b47a79e6f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 73F304F6BC2
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
	NEURAL_HAM(-0.00)[-0.991];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangguopeng@kylinos.cn,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,kylinos.cn:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15680-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Action: no action



在 2026/5/8 10:26, Waiman Long 写道:
> 
> On 5/7/26 10:14 PM, Chen Ridong wrote:
>>
>> On 2026/5/7 22:31, Waiman Long wrote:
>>> On 5/7/26 6:33 AM, Guopeng Zhang wrote:
>>>> cpuset_can_attach() accumulates temporary SCHED_DEADLINE migration
>>>> state in the destination cpuset while walking the taskset.
>>>>
>>>> If a later task_can_attach() or security_task_setscheduler() check
>>>> fails, cgroup_migrate_execute() treats cpuset as the failing subsystem
>>>> and does not call cpuset_cancel_attach() for it. The partially
>>>> accumulated state is then left behind and can be consumed by a later
>>>> attach, corrupting cpuset DL task accounting and pending DL bandwidth
>>>> accounting.
>>>>
>>>> Reset the pending DL migration state before returning from those
>>>> per-task failure paths.
>>>>
>>>> Fixes: 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach() fails")
>>>> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
>>>> ---
>>>>    kernel/cgroup/cpuset.c | 8 ++++++--
>>>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>>> index e3a081a07c6d..ae41736399a1 100644
>>>> --- a/kernel/cgroup/cpuset.c
>>>> +++ b/kernel/cgroup/cpuset.c
>>>> @@ -3029,12 +3029,12 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>>>>        cgroup_taskset_for_each(task, css, tset) {
>>>>            ret = task_can_attach(task);
>>>>            if (ret)
>>>> -            goto out_unlock;
>>>> +            goto out_reset_dl_data;
>>>>              if (setsched_check) {
>>>>                ret = security_task_setscheduler(task);
>>>>                if (ret)
>>>> -                goto out_unlock;
>>>> +                goto out_reset_dl_data;
>>>>            }
>>>>              if (dl_task(task)) {
>>>> @@ -3070,6 +3070,10 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>>>>         * changes which zero cpus/mems_allowed.
>>>>         */
>>>>        cs->attach_in_progress++;
>>>> +    goto out_unlock;
>>>> +
>>>> +out_reset_dl_data:
>>>> +    reset_migrate_dl_data(cs);
>>>>    out_unlock:
>>>>        mutex_unlock(&cpuset_mutex);
>>>>        return ret;
>>> I would prefer the likely success path be a straight line instead of doing a
>>> goto. IOW, move out_reset_dl_data below return. Other than that, this patch
>>> looks good to me.
>>>
>> I've read the code and found several places that call reset_migrate_dl_data(cs).
>>
>> I think it would be better to call reset_migrate_dl_data(cs) only when we
>> encounter an error, for example:
>>
>> ```
>> static int cpuset_can_attach(struct cgroup_taskset *tset)
>> {
>> ...
>> out_unlock:
>>     if (ret)
>>         reset_migrate_dl_data(cs);
>>     mutex_unlock(&cpuset_mutex);
>>     return ret;
>> }
>> ```
>> After that, no other places would need to call reset_migrate_dl_data(cs), right?
>>
> Yes, that should work too.
> 
Thanks for the review.

Yes, I will update cpuset_can_attach() to use the common ret-based
cleanup in out_unlock.

Thanks,
Guopeng
> Cheers,
> Longman


