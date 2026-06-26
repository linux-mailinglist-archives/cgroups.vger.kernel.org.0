Return-Path: <cgroups+bounces-17307-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ajb5JHcYPmoo/wgAu9opvQ
	(envelope-from <cgroups+bounces-17307-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 08:13:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE306CA926
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 08:13:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=S4GDROLO;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17307-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17307-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02916304002A
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 06:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AA03D332C;
	Fri, 26 Jun 2026 06:13:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547F93D25D2;
	Fri, 26 Jun 2026 06:13:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782454386; cv=none; b=ibc88RuKZk+WZ8bMF5B6PGAkkLc1rA3CcxndD+cijXVRJdjT3qYzHMLSvyew+zQBZzO7Lw8d6WfBfbYYhPxPRDu5TcgEtCkanmh8V81U3xo88jpYV8Yz4z3CYVnurD+NXeOXqMgSr3NQBEIdTGD8kDMEMIBFwAyrSd/kK6n7PAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782454386; c=relaxed/simple;
	bh=rfUHVSWJ6KJbX8UVy6+SYKCJsVy2+5rsjmWAztx8GyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F5+QRVg+A3xLx5rHAE4gZSJaqNzW/0K0H7SK5x/vv/wv3lMafvI+zG0IlFSzbwpLANqjLnUjFP6Xd/qNrWeY6zvHpkGpyspLEdJ0T9/mjq63culXhuXMreRpSH0Ldtte/gnnrFMMJMKzRYQLan74t+3oB5WrBeYYWVfHokqLOKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S4GDROLO; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q2mdhr1836845;
	Fri, 26 Jun 2026 06:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qAuL1K
	Pu1Oe89n/i93dJ0DUiGvkfVt2SDZbzYq1i9EQ=; b=S4GDROLOsgJN02wkGuf+lE
	pahKeJiEFJA7ZEL7fAt2vFEukuzRSsYtFXxbyD1QoA2ef8CFvzRG/avIL1I6d4em
	5qUQ6QVhRPlOU827KAGmwKQtFrahueHGR4+1mg7owrIZXpdzHc98A7W66G+hRoVf
	hLGSA/L1mGtUfhsvzYDHSww9Uy1MkSLSP2BwqDmSR1pZJTUbN+mkOkpAjzkWmRFW
	Jid1rFO+TQT7noatbID8jxwL7EpRrKjyCa9SNWw8YqVb3Ailk5pAiKDV9K/M2g1y
	fXi0uIPVbSvs9sxVxRbUu4r2S/J81EZscYTtgLf2JoY1nu8zLfzwkEiAClQRrymA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3wmh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 06:12:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65Q64clZ000905;
	Fri, 26 Jun 2026 06:12:36 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7w01eeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 06:12:36 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65Q6CZeZ29557372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2026 06:12:35 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5465B58056;
	Fri, 26 Jun 2026 06:12:35 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A041558052;
	Fri, 26 Jun 2026 06:12:31 +0000 (GMT)
Received: from [9.43.104.77] (unknown [9.43.104.77])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jun 2026 06:12:31 +0000 (GMT)
Message-ID: <866644be-3b07-49f9-9c5d-e0f94ad1c793@linux.ibm.com>
Date: Fri, 26 Jun 2026 11:42:29 +0530
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
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <749d17be-ff9f-4f70-a948-0133f02eec93@fygo.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3e1855 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=jnGvk4DWCy_5bwawZD4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA0NCBTYWx0ZWRfXxBVKuF1sYO3C
 zUr4gH6ouym/4MjTBBsIXro8WA2lO0SGBk2wlC6fjYP74hrTM8tag9oPFvKj4UyXWLgLjcqBfFt
 U97AgZmhoUGnGshduGVswzmf9JaLhAQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA0NCBTYWx0ZWRfX2MPm1EBhVYqJ
 wSVwSVw4pvVjRAU2tZCUKV9Bcl41bSFHvxh4MfWA+2mFjz6u7cGwpViUtVSVJn0+ZJR8f1c5dkA
 XTgs7KbbebtSjioiOeWrly8cTaRxhrtIzEPqLJrdw7fYhFgVy9Ov//0zre7EMPXlenaZ54vIPHs
 Gn6dWAhtjsi1qtlgsEHXYIF4/eGeSWBSH3QadR1Nr4w+7Q9hqN0ygP4EeBhvTleY/7018H9qe5w
 y7e5aKuGV4MZEEF/KqVMzp+1jY7nK8yzT4gsg+gxnPBQgcX5qRmQYbZVRSk9mYcNE7r6vztrL9T
 gph/RSgvaimy/ZJyEmIjI5LCtLnSQfZHcOGV0dLGogQBH7NVq3XgyDdBGWcRxhTZIhyydE6LHNu
 ebakIVssP3reXXjYRFqMpLRREU+nF6OnDsD5IraLxbjZQ74P3OaflC9KnxZ8RRShFX5y1kLefvp
 OfHcjuqUeQvZcd2/VCA==
X-Proofpoint-ORIG-GUID: WqYWIr7yKeVAbMmNjnWcyP5CgghYDwv-
X-Proofpoint-GUID: WqYWIr7yKeVAbMmNjnWcyP5CgghYDwv-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260044
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17307-lists,cgroups=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.ibm.com:mid,linux.ibm.com:from_mime];
	FORGED_RECIPIENTS(0.00)[m:yukuai@fygo.io,m:tj@kernel.org,m:josef@toxicpanda.com,m:axboe@kernel.dk,m:zhengqixing@huawei.com,m:hch@lst.de,m:yizhou.tang@shopee.com,m:ming.lei@redhat.com,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[nilay@linux.ibm.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nilay@linux.ibm.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BE306CA926

On 6/26/26 7:22 AM, yu kuai wrote:
> Hi,
> 
> 在 2026/6/26 9:50, yu kuai 写道:
>> Hi,
>>
>> 在 2026/6/25 23:08, Nilay Shroff 写道:
>>> On 6/24/26 12:16 PM, Yu Kuai wrote:
>>>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>>>> index 7baccfb690fe..f7e788a7fe95 100644
>>>> --- a/block/blk-cgroup.c
>>>> +++ b/block/blk-cgroup.c
>>>> @@ -1563,10 +1563,12 @@ int blkcg_activate_policy(struct gendisk
>>>> *disk, const struct blkcg_policy *pol)
>>>>         if (WARN_ON_ONCE(!pol->pd_alloc_fn || !pol->pd_free_fn))
>>>>             return -EINVAL;
>>>>           if (queue_is_mq(q))
>>>>             memflags = blk_mq_freeze_queue(q);
>>>> +
>>>> +    mutex_lock(&q->blkcg_mutex);
>>>>     retry:
>>>>         spin_lock_irq(&q->queue_lock);
>>>>           /* blkg_list is pushed at the head, reverse walk to
>>>> initialize parents first */
>>>>         list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
>>>> @@ -1625,10 +1627,11 @@ int blkcg_activate_policy(struct gendisk
>>>> *disk, const struct blkcg_policy *pol)
>>>>         __set_bit(pol->plid, q->blkcg_pols);
>>>>         ret = 0;
>>>>           spin_unlock_irq(&q->queue_lock);
>>>>     out:
>>>> +    mutex_unlock(&q->blkcg_mutex);
>>>>         if (queue_is_mq(q))
>>>>             blk_mq_unfreeze_queue(q, memflags);
>>>>         if (pinned_blkg)
>>>>             blkg_put(pinned_blkg);
>>>>         if (pd_prealloc)
>>> If the policy allocation fails, we jump to the lable enomem: and
>>> teardown pds.
>>> But I see this path still only acquires ->queue_lock. Don't we also need
>>> to protect it with ->blkcg_mutex?
>> Yes, I agree we should protect it as well.
> 
> Just take a closer look at the code, the enomem is already protected by
> blkcg_mutex :)
> 

Oh yes, but the ->blkcg_mutex is never released if we jump to enomem.
So that may potentially cause deadlock. We need to release ->blkcg_mutex
once blkcg_policy_teardown_pds() returns. Or may be refactor code (or add
comment) so that it's easy to realize or spot the ->blkcg_mutex is acquired
and then released around blkcg_policy_teardown_pds().

>>
>>> Moreover I still see race between blkg insertion in blkg_create() which
>>> still doesn't use ->blkcg_mutex and so list traversal in
>>> bfq_end_wr_async()
>>> may still race with blkg_create(), isn't it? I remember you once told
>>> this will be handled in another series but I couldn't find that yet.
>> This is the set:
>>
>> [PATCH 0/8] blk-cgroup: remove queue_lock nesting from blkcg paths - Yu
>> Kuai <https://lore.kernel.org/all/cover.1780621988.git.yukuai@fygo.io/>
>>
>> Noted that set just make sure queue_lock is not nested under other atomic
>> context, and that set do not acquire blkcg_mutex for blkg_create() yet. Howerver,
>> with that set it'll be easy to convert all queue_lock to blkcg_mtuex for blkg
>> protection, and together with lots of blk-cgroup code cleanups.
>>

Okay, so are you planning to send a follow-up patchset that replaces ->queue_lock
with ->blkcg_mutex for protecting the blkg_list? If so, I'd still prefer acquiring
->blkcg_mutex around blkg_create() in this patchset. That would address the race
between blkg_create() and the blkg_list traversal in bfq_end_wr_async(), while the
subsequent series can focus on cleaning up and removing the remaining ->queue_lock
usage for blkg protection.

Thanks,
--Nilay


