Return-Path: <cgroups+bounces-17293-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W6b9L9BFPWpy0ggAu9opvQ
	(envelope-from <cgroups+bounces-17293-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 17:14:24 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 627A36C6F89
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 17:14:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=bospDCKW;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17293-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17293-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA52E301BA7A
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 15:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BBD3E8324;
	Thu, 25 Jun 2026 15:14:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDA13E7BD1;
	Thu, 25 Jun 2026 15:14:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782400446; cv=none; b=CnaKfaJit+PHcewG8XB0D/Jx53kc0c7rTphVS3SUWlziJThrd3PbNtKsNjRNu9nFgQMy2JFyVValBgPloJdyJcVbokLFyNiYl16zOGYhhyYzj6WsJj/0UTf3d99FimjFcz5nPcqTN4FnFSPpNVQ0Z6u4HzrFlNEtxuUFh2BJlOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782400446; c=relaxed/simple;
	bh=Nir5P6KD5cxlAELT/t+xEt2tkm/i9SaAtPut0lZdebk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l2PaY/03soc4EIay79CJcz0WyTYMG58/U84BBjmb+0m3ncEtUrp41Npx+XTreDrPUVyBwTmuLtNpwKDDDTbz64zOy4Qac2eW0xe/O/3Pdk6D8YlAWPeUSG8jcIH95+NZpjy24LKv2q8QE4dlba/VgIMb6ykANdovrUWU0itCTd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bospDCKW; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P3mUOZ3185838;
	Thu, 25 Jun 2026 15:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=z/d0Pq
	kHkXv4NhFvXjSEZTKq6/veLWcLNmOhrwUc2kk=; b=bospDCKW9D4ntGYT66qlb9
	AHwZooli9Usacws+xquKisaphg1KiYK1hBoCMJso1fnI1fSfHJeqGjPiH8tP7U+U
	iPgLMpk7HFV02Gtr3txfeUUns3pSSeoHddBTP++roeu9/rbKe7yvkZMP32hl+XQ8
	j/pGfFw0jVjHxs/on4lcnu9yw/syXaVkVO1LcT8oGAB+lwmbvRAFY7/2EIZf96o+
	hxBKuFj0+69azZD48i99kLj90w+/1TTwuuItgyg0/OZmtxf079q2ygPGeKOIaF6a
	gPi7FEjTZYXMnk1ojcPhDThipc6wkrbcQmlpwCwP/WlGCw6izzrbaqNDSELh0Ckw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhr2bd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 15:08:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65PF4g2t003744;
	Thu, 25 Jun 2026 15:08:45 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyxe99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 15:08:45 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65PF8jB224707772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jun 2026 15:08:45 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F5995805C;
	Thu, 25 Jun 2026 15:08:45 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DA8E58051;
	Thu, 25 Jun 2026 15:08:41 +0000 (GMT)
Received: from [9.43.51.229] (unknown [9.43.51.229])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Jun 2026 15:08:40 +0000 (GMT)
Message-ID: <6580506d-3baa-4ceb-bf2e-5f6c974f3d10@linux.ibm.com>
Date: Thu, 25 Jun 2026 20:38:39 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] blk-cgroup: fix race between policy activation and
 blkg destruction
To: Yu Kuai <yukuai@kernel.org>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc: Zheng Qixing <zhengqixing@huawei.com>, Christoph Hellwig <hch@lst.de>,
        Tang Yizhou <yizhou.tang@shopee.com>, Ming Lei <ming.lei@redhat.com>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260624064625.1743650-1-yukuai@kernel.org>
 <20260624064625.1743650-5-yukuai@kernel.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260624064625.1743650-5-yukuai@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3d447e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=XZ0ZM7yUeT00AVPrNx0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX9obpi0thXf/n
 l5RXqnlqAPVLtTW631RYp1wKwrp4BXtlHUjQ4f2nMOLCC7G3jvF4Vnigo7FKG1Qcpm0H68pgJf2
 W/N1JB7xBCiRhibu+WHGQBMFzRNZ9szdIXL9o3Av9Rq+P6Zwq+leOHOPtVE7fEYeHiKHPNopyKJ
 6qnnpuK9lj36XZCxt+H5CZd5nb/qvvDJEiu/vv7XP136Pdt4ddRJhfDHR0g62LMo+YHxTYO0kf/
 oU3hdy+E0PljYSy/ejNyP2+s/b7wHX2szsLJYB6c3EQQOfdKYFe5jWWCrHcyDfCR4KMXWVEY9/s
 5NU9rBGwmxMYfsmrVEZO4uIY9sCuCQUNlFAjRXKXWbrEoelt4r2SL+0ZgwYVYEdNs4XldBx6U39
 kpiVAppPhoyipmzmkOEzGFhrw+7HPRzhHRPU4EKw9PG5/Fgb0SkAbSu3J2bLfAG9iUR54eczURz
 1z7cMI1BxGzrPm+eqDw==
X-Proofpoint-GUID: Bb5PLS6_Sy-36q3tTUJdgRsPbaZVAORx
X-Proofpoint-ORIG-GUID: Bb5PLS6_Sy-36q3tTUJdgRsPbaZVAORx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX+TAs/2V9rle9
 DRA2XBMqQZaBrr+pVRSh3rTVD6+9lCxJkPUSSEJ937dbKskQ37VlhA8p/AXXvZY5UByO/aX4tRX
 ACH/bLleAqxda4kp8aGjYwndigemBq0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250127
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17293-lists,cgroups=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid,linux.ibm.com:from_mime,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS(0.00)[m:yukuai@kernel.org,m:tj@kernel.org,m:josef@toxicpanda.com,m:axboe@kernel.dk,m:zhengqixing@huawei.com,m:hch@lst.de,m:yizhou.tang@shopee.com,m:ming.lei@redhat.com,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[nilay@linux.ibm.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 627A36C6F89

On 6/24/26 12:16 PM, Yu Kuai wrote:
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 7baccfb690fe..f7e788a7fe95 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1563,10 +1563,12 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
>   	if (WARN_ON_ONCE(!pol->pd_alloc_fn || !pol->pd_free_fn))
>   		return -EINVAL;
>   
>   	if (queue_is_mq(q))
>   		memflags = blk_mq_freeze_queue(q);
> +
> +	mutex_lock(&q->blkcg_mutex);
>   retry:
>   	spin_lock_irq(&q->queue_lock);
>   
>   	/* blkg_list is pushed at the head, reverse walk to initialize parents first */
>   	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
> @@ -1625,10 +1627,11 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
>   	__set_bit(pol->plid, q->blkcg_pols);
>   	ret = 0;
>   
>   	spin_unlock_irq(&q->queue_lock);
>   out:
> +	mutex_unlock(&q->blkcg_mutex);
>   	if (queue_is_mq(q))
>   		blk_mq_unfreeze_queue(q, memflags);
>   	if (pinned_blkg)
>   		blkg_put(pinned_blkg);
>   	if (pd_prealloc)

If the policy allocation fails, we jump to the lable enomem: and teardown pds.
But I see this path still only acquires ->queue_lock. Don't we also need
to protect it with ->blkcg_mutex?

Moreover I still see race between blkg insertion in blkg_create() which
still doesn't use ->blkcg_mutex and so list traversal in bfq_end_wr_async()
may still race with blkg_create(), isn't it? I remember you once told
this will be handled in another series but I couldn't find that yet.

Thanks,
--Nilay




