Return-Path: <cgroups+bounces-13656-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKFiCgnrgmnqewMAu9opvQ
	(envelope-from <cgroups+bounces-13656-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Feb 2026 07:45:29 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAB6E265C
	for <lists+cgroups@lfdr.de>; Wed, 04 Feb 2026 07:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 103973039EEB
	for <lists+cgroups@lfdr.de>; Wed,  4 Feb 2026 06:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F0838551C;
	Wed,  4 Feb 2026 06:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="WtZyk/Ia"
X-Original-To: cgroups@vger.kernel.org
Received: from sg-1-22.ptr.blmpb.com (sg-1-22.ptr.blmpb.com [118.26.132.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91953816E9
	for <cgroups@vger.kernel.org>; Wed,  4 Feb 2026 06:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770187483; cv=none; b=nPR0yovCr0O/qWGLmqbBtPZdfDccRb5n3P3S2sV8373o+jLq1ocKkOvz4dV89A5G+kSBAxCWR7T6Dxnm2mbgQCMPWlMKtkoK+9dWNfxcXsuOnwzyt5nmI+ZJptrclB+lL0PgCC5wlXziLa7Rgka3h47skmVIEWvBINUOkJusEQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770187483; c=relaxed/simple;
	bh=Z/qv8hIzfC+7bCZ6iww8n5urT94nR+ZITtVjDfdX/2M=;
	h=To:Subject:References:Mime-Version:In-Reply-To:Cc:Content-Type:
	 From:Date:Message-Id; b=VP6oSnjvUYamkIs+LcqPzQB9yxgd4G+CuhCXOCj1f1UfVlGLa3TL7wexMsgcebmOtco/YbCV6PoDko5CFrqHRYpPhNmTtakezgsnVfpf9h0KEdPczbNiaz/J0N+nGcU6QRa1AiDVjHtJVxwIz8UW0018OLxai7fMkT4P90TSVjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=WtZyk/Ia; arc=none smtp.client-ip=118.26.132.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1770187471;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=i+9AfGJMfN0HhM1ZePCGgsCVg25yjlBNrKsHci7KeXU=;
 b=WtZyk/Ia9Ih6K3JtUnKkxsNQ3Rlbm9m+IwZlUSmBe8EKgnJvHaDl9eIHjuiFgNVV31MvqD
 LhY6ee8tovGwYC09pKLcTjNW2MXPAYy5mptkxNTt219/tT0Q4XkVStafaNZS/saFb9sqyP
 inBlj0Wrk2iEHr4er/ZDY5M2kKSRWX8EHZsW82WvZt2e/t1J6UH/pqVIoWB2cq+F23c5Ms
 nQyhXpDrFqONCi+9P52knBk78aQDMpRjIMCUHyaddMcOmsmLecLCIBAFDgIQfWS8nGw5Do
 ArL40qMSjan2GRG+d3fJ5n5+jU9BzDyc0YAkFkU9XRx7jZQAgZwH5s0AjfIBKw==
To: =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Subject: Re: [PATCH v2 6/7] blk-cgroup: allocate pds before freezing queue in blkcg_activate_policy()
X-Lms-Return-Path: <lba+26982eacd+847e39+vger.kernel.org+yukuai@fnnas.com>
Received: from [192.168.1.104] ([39.182.0.137]) by smtp.feishu.cn with ESMTPS; Wed, 04 Feb 2026 14:44:28 +0800
References: <20260203080602.726505-1-yukuai@fnnas.com> <20260203080602.726505-7-yukuai@fnnas.com> <gq45vl55n2gucipjc5jk5e5kp7ups3nw672ua6nvksooycezv5@lfr62hy5br4f>
Reply-To: yukuai@fnnas.com
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <gq45vl55n2gucipjc5jk5e5kp7ups3nw672ua6nvksooycezv5@lfr62hy5br4f>
Cc: <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>, 
	<cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <zhengqixing@huawei.com>, 
	<hch@infradead.org>, <ming.lei@redhat.com>, <nilay@linux.ibm.com>, 
	<yukuai@fnnas.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
From: "Yu Kuai" <yukuai@fnnas.com>
Date: Wed, 4 Feb 2026 14:44:26 +0800
Message-Id: <fe9f7cc4-a9dc-4809-9d98-d5158c17c983@fnnas.com>
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: quoted-printable
X-Original-From: Yu Kuai <yukuai@fnnas.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[fnnas-com.20200927.dkim.feishu.cn:s=s1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13656-lists,cgroups=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[fnnas.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[fnnas-com.20200927.dkim.feishu.cn:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fnnas.com,cgroups@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.999];
	HAS_REPLYTO(0.00)[yukuai@fnnas.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fnnas.com:replyto,fnnas.com:email,fnnas.com:mid,fnnas-com.20200927.dkim.feishu.cn:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BCAB6E265C
X-Rspamd-Action: no action

Hi,

=E5=9C=A8 2026/2/3 17:06, Michal Koutn=C3=BD =E5=86=99=E9=81=93:
> On Tue, Feb 03, 2026 at 04:06:01PM +0800, Yu Kuai <yukuai@fnnas.com> wrot=
e:
>> Some policies like iocost and iolatency perform percpu allocation in
>> pd_alloc_fn(). Percpu allocation with queue frozen can cause deadlock
>> because percpu memory reclaim may issue IO.
>>
>> Now that q->blkg_list is protected by blkcg_mutex,
> With this ^^^
>
> ...
>> restructure
>> blkcg_activate_policy() to allocate all pds before freezing the queue:
>> 1. Allocate all pds with GFP_KERNEL before freezing the queue
>> 2. Freeze the queue
>> 3. Initialize and online all pds
>>
>> Note: Future work is to remove all queue freezing before
>> blkcg_activate_policy() to fix the deadlocks thoroughly.
>>
>> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
>> ---
>>   block/blk-cgroup.c | 90 +++++++++++++++++-----------------------------
>>   1 file changed, 32 insertions(+), 58 deletions(-)
>>
>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>> index 0206050f81ea..7fcb216917d0 100644
>> --- a/block/blk-cgroup.c
>> +++ b/block/blk-cgroup.c
>> @@ -1606,8 +1606,7 @@ static void blkcg_policy_teardown_pds(struct reque=
st_queue *q,
>>   int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_pol=
icy *pol)
>>   {
>>   	struct request_queue *q =3D disk->queue;
>> -	struct blkg_policy_data *pd_prealloc =3D NULL;
>> -	struct blkcg_gq *blkg, *pinned_blkg =3D NULL;
>> +	struct blkcg_gq *blkg;
>>   	unsigned int memflags;
>>   	int ret;
>>  =20
>> @@ -1622,90 +1621,65 @@ int blkcg_activate_policy(struct gendisk *disk, =
const struct blkcg_policy *pol)
> ...
>
>> +	/* Now freeze queue and initialize/online all pds */
>> +	if (queue_is_mq(q))
>> +		memflags =3D blk_mq_freeze_queue(q);
>> +
>> +	spin_lock_irq(&q->queue_lock);
>> +	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
>> +		struct blkg_policy_data *pd =3D blkg->pd[pol->plid];
>> +
>> +		/* Skip dying blkg */
>> +		if (hlist_unhashed(&blkg->blkcg_node))
>> +			continue;
>> +
>> +		spin_lock(&blkg->blkcg->lock);
>>   		if (pol->pd_init_fn)
>>   			pol->pd_init_fn(pd);
>> -
>>   		if (pol->pd_online_fn)
>>   			pol->pd_online_fn(pd);
>>   		pd->online =3D true;
>> -
>>   		spin_unlock(&blkg->blkcg->lock);
>>   	}
>>  =20
>>   	__set_bit(pol->plid, q->blkcg_pols);
>> -	ret =3D 0;
>> -
>>   	spin_unlock_irq(&q->queue_lock);
>> -out:
>> -	mutex_unlock(&q->blkcg_mutex);
>> +
>>   	if (queue_is_mq(q))
>>   		blk_mq_unfreeze_queue(q, memflags);
>> -	if (pinned_blkg)
>> -		blkg_put(pinned_blkg);
>> -	if (pd_prealloc)
>> -		pol->pd_free_fn(pd_prealloc);
>> -	return ret;
>> +	mutex_unlock(&q->blkcg_mutex);
>> +	return 0;
> Why is q->queue_lock still needed here?

I do want to remove queue_lock for accessing blkgs. However, this set just =
protect q->blkg_list
with blkg_mutex, and I'll remove the queue_lock after everything is convert=
ed to blkg_mutex.

>
> Thanks,
> Michal

--=20
Thansk,
Kuai

