Return-Path: <cgroups+bounces-17365-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WX/jIN4DQmq4ygkAu9opvQ
	(envelope-from <cgroups+bounces-17365-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 07:34:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0836B6D60DF
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 07:34:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=HI6NjzKO;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17365-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17365-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 404CA3009525
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 05:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC34138AC64;
	Mon, 29 Jun 2026 05:34:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA0738C2D0;
	Mon, 29 Jun 2026 05:34:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782711257; cv=none; b=LytBVXpxE/z9pxAJ/1Se3KMU4npaS7oKBUE5XR5qb6Jnn3pNAAWf7KLayYtddqlIOmyXkHUhtoKLFy+SFXxuqOq/sU8Kk+vRmDlgafwPSchXgTGoe3leMzIqKOvkb2w/AUPzUZTXaxZsCxKH6YLf0UjyP2DoEzvzSGX/vgpIju8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782711257; c=relaxed/simple;
	bh=twJxANRV4/8ZUJYYZa1HHFVUG2s+6DHakpe5jbUhDFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ID1yQEMky9eqG9PqNQSLBm0D4j1ZoM9Y2/EfYNCx5RDrsF9nH1YS/2wiKtlpcRRQ5lsDzDxF8ZF9bGNdZy6Ip7vWa6QpDzsSsSxROJGcycwlGHHWUMXUZdLD6ytFL43rYW1CBO28gtB1gJidOGgzKwygG5GboQTfy5loNtyRC78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HI6NjzKO; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T3INKO2098905;
	Mon, 29 Jun 2026 05:33:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Jk9mqL
	QrGTOtVv9651WmCNXPgc/e6swsLlpW4qFhSKo=; b=HI6NjzKOHebiXVO8gxW4Ty
	UTupPbk5NGZfmTUVhQ4LcMSNQSK8ChyUk+AfsK4gkabbokt2aciLjqSwfn/9ryUW
	CSTijKNoNMvIe6ZbIZiff8H03lfnfQtq9KsSxHla22o4tyEHHvBf7Drvyznvjxs2
	XuZecUEQfuBRjD+P2G2gwz5SRtOnidJyI96VouKD+uGnv6lDdce/EWBUOCSSGs1X
	dmbp/ZcsXTBE98Eo01YATvlO0puIEbA/Ey7r8AfQnb1ZceN5/FZiXwW2ZVNDVcCO
	DJMXi6sGTtpQfjyk4hVutqbxVaDcI0JyuxeFI33PjlcHNQlyIQiQomTap/0URUxA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pdqng1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 05:33:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65T5Jcvg003596;
	Mon, 29 Jun 2026 05:33:33 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbh3x3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 05:33:33 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65T5XX5w25363194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2026 05:33:33 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A15858059;
	Mon, 29 Jun 2026 05:33:33 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D1C158043;
	Mon, 29 Jun 2026 05:33:29 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jun 2026 05:33:29 +0000 (GMT)
Message-ID: <c44fcd50-6341-4617-b6cb-cad3c65a7a75@linux.ibm.com>
Date: Mon, 29 Jun 2026 11:03:28 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] blk-cgroup: fix race between policy activation and
 blkg destruction
To: yukuai@fygo.io, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc: Zheng Qixing <zhengqixing@huawei.com>, Christoph Hellwig <hch@lst.de>,
        Tang Yizhou <yizhou.tang@shopee.com>, Ming Lei <ming.lei@redhat.com>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260624064625.1743650-1-yukuai@kernel.org>
 <20260624064625.1743650-5-yukuai@kernel.org>
 <6580506d-3baa-4ceb-bf2e-5f6c974f3d10@linux.ibm.com>
 <7ebbf312-7c1b-4024-a35d-89a95d82b4f4@fygo.io>
 <749d17be-ff9f-4f70-a948-0133f02eec93@fygo.io>
 <866644be-3b07-49f9-9c5d-e0f94ad1c793@linux.ibm.com>
 <5f5a4729-0c90-4f6f-b97e-cab9d0289dc2@fygo.io>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <5f5a4729-0c90-4f6f-b97e-cab9d0289dc2@fygo.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fYNevrjts4ObRU8b1D8rzrfmsejwYhdB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA0MyBTYWx0ZWRfX0CR+fij5ehMa
 Vc+c4G96+CTTLreaBg1T9qzOuADlwisXiaetzpInLgeVAgBTT73VxUIT3CQu/64bNdttGmnmpBl
 NI1PfcyPhdIUOW9svHczSpd9P5QR1I0=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a4203ae cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=XbbiLa-TNhvNMnDTbA4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA0MyBTYWx0ZWRfX1aGiwIW7GH2s
 3f/pZiWuFOGqur06YK4gWXDJjvqyqfOUfGqaqWVCZwMwhXD0E37A840m5irGSVBkJwMl4/bsmZf
 wtgoPArp04A9ynxF5l+dWUtlly+almVfVgdK8IzspgEsABuds/fy1CRAuENpA6MRX1aENUWe3x1
 9M709c38vQqTtRhxR1xTZiY7wrvgJKcTsvLU7oVKKfpREKDhyGkvDxUe27bS/LInXQSi6Cw8jeC
 sit87M9AB/tL2AzBBUUawA0r0akGauzdu6NaiMC/hdd3o/6E7PilcfLNvlW88oaNrdeG/w3dA+/
 dmxp9KwbrXrC+jeKxioWj0zqyx44nTzzNmb2pc7/Sv8GzAvrFVR2weXrYW5/p135b/2rStxMD0g
 e/FZGF0Wb399t22vh54+0SeYs6w3JtYtwb8bFTeVx9KLHCIirDg7bWrimQJPTknjoJtHqr5e8sF
 xQUetN58tsFHzEVYqig==
X-Proofpoint-ORIG-GUID: fYNevrjts4ObRU8b1D8rzrfmsejwYhdB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290043
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17365-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nilay@linux.ibm.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:yukuai@fygo.io,m:tj@kernel.org,m:josef@toxicpanda.com,m:axboe@kernel.dk,m:zhengqixing@huawei.com,m:hch@lst.de,m:yizhou.tang@shopee.com,m:ming.lei@redhat.com,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nilay@linux.ibm.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0836B6D60DF

On 6/27/26 9:43 AM, yu kuai wrote:
> Hi,
> 
> 在 2026/6/26 14:12, Nilay Shroff 写道:
>> On 6/26/26 7:22 AM, yu kuai wrote:
>>> Hi,
>>>
>>> 在 2026/6/26 9:50, yu kuai 写道:
>>>> Hi,
>>>>
>>>> 在 2026/6/25 23:08, Nilay Shroff 写道:
>>>>> On 6/24/26 12:16 PM, Yu Kuai wrote:
>>>>>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>>>>>> index 7baccfb690fe..f7e788a7fe95 100644
>>>>>> --- a/block/blk-cgroup.c
>>>>>> +++ b/block/blk-cgroup.c
>>>>>> @@ -1563,10 +1563,12 @@ int blkcg_activate_policy(struct gendisk
>>>>>> *disk, const struct blkcg_policy *pol)
>>>>>>          if (WARN_ON_ONCE(!pol->pd_alloc_fn || !pol->pd_free_fn))
>>>>>>              return -EINVAL;
>>>>>>            if (queue_is_mq(q))
>>>>>>              memflags = blk_mq_freeze_queue(q);
>>>>>> +
>>>>>> +    mutex_lock(&q->blkcg_mutex);
>>>>>>      retry:
>>>>>>          spin_lock_irq(&q->queue_lock);
>>>>>>            /* blkg_list is pushed at the head, reverse walk to
>>>>>> initialize parents first */
>>>>>>          list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
>>>>>> @@ -1625,10 +1627,11 @@ int blkcg_activate_policy(struct gendisk
>>>>>> *disk, const struct blkcg_policy *pol)
>>>>>>          __set_bit(pol->plid, q->blkcg_pols);
>>>>>>          ret = 0;
>>>>>>            spin_unlock_irq(&q->queue_lock);
>>>>>>      out:
>>>>>> +    mutex_unlock(&q->blkcg_mutex);
>>>>>>          if (queue_is_mq(q))
>>>>>>              blk_mq_unfreeze_queue(q, memflags);
>>>>>>          if (pinned_blkg)
>>>>>>              blkg_put(pinned_blkg);
>>>>>>          if (pd_prealloc)
>>>>> If the policy allocation fails, we jump to the lable enomem: and
>>>>> teardown pds.
>>>>> But I see this path still only acquires ->queue_lock. Don't we also
>>>>> need
>>>>> to protect it with ->blkcg_mutex?
>>>> Yes, I agree we should protect it as well.
>>>
>>> Just take a closer look at the code, the enomem is already protected by
>>> blkcg_mutex :)
>>>
>>
>> Oh yes, but the ->blkcg_mutex is never released if we jump to enomem.
>> So that may potentially cause deadlock. We need to release ->blkcg_mutex
>> once blkcg_policy_teardown_pds() returns. Or may be refactor code (or add
>> comment) so that it's easy to realize or spot the ->blkcg_mutex is
>> acquired
>> and then released around blkcg_policy_teardown_pds().
> 
> the enomem will goto out at last, and blkcg_mutex do released. The code is
> a bit hacky.
> 
>>
>>>>
>>>>> Moreover I still see race between blkg insertion in blkg_create()
>>>>> which
>>>>> still doesn't use ->blkcg_mutex and so list traversal in
>>>>> bfq_end_wr_async()
>>>>> may still race with blkg_create(), isn't it? I remember you once told
>>>>> this will be handled in another series but I couldn't find that yet.
>>>> This is the set:
>>>>
>>>> [PATCH 0/8] blk-cgroup: remove queue_lock nesting from blkcg paths - Yu
>>>> Kuai <https://lore.kernel.org/all/cover.1780621988.git.yukuai@fygo.io/>
>>>>
>>>> Noted that set just make sure queue_lock is not nested under other
>>>> atomic
>>>> context, and that set do not acquire blkcg_mutex for blkg_create()
>>>> yet. Howerver,
>>>> with that set it'll be easy to convert all queue_lock to blkcg_mtuex
>>>> for blkg
>>>> protection, and together with lots of blk-cgroup code cleanups.
>>>>
>>
>> Okay, so are you planning to send a follow-up patchset that replaces
>> ->queue_lock
>> with ->blkcg_mutex for protecting the blkg_list? If so, I'd still
>> prefer acquiring
>> ->blkcg_mutex around blkg_create() in this patchset. That would
>> address the race
>> between blkg_create() and the blkg_list traversal in
>> bfq_end_wr_async(), while the
>> subsequent series can focus on cleaning up and removing the remaining
>> ->queue_lock
>> usage for blkg protection.
> 
> Yes, there is a follow-up patchset. When this set was posted, blkg_create is still
> called with queue_lock held, so I can't do that. However, not that the other set
> is already applied, I can hold blkcg_mutex for blkg_create() now.
> 

If you already have a follow-up patchset that replaces ->queue_lock with
->blkcg_mutex for protecting blkg_list, then I think it might make sense
to send that out first (if you haven't already) and hold off this series for
now. That way, the blkg_create() race can be addressed first, and this
series can build on top of those changes.

BTW, if that follow-up series is merged first, I suspect the first two patches in
this series may no longer be necessary, leaving only patches 3/4 and 4/4.

Thanks,
--Nilay



