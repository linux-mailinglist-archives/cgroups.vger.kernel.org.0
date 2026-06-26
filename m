Return-Path: <cgroups+bounces-17303-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CLNSAMXbPWra7AgAu9opvQ
	(envelope-from <cgroups+bounces-17303-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 03:54:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8AC6C99C0
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 03:54:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fygo-io.20200929.dkim.larksuite.com header.s=s1 header.b=LGujZFHT;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17303-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17303-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=fygo.io (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D821B303CB7F
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 01:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D834B279DB6;
	Fri, 26 Jun 2026 01:54:10 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from sg-3-44.ptr.tlmpb.com (sg-3-44.ptr.tlmpb.com [101.45.255.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DB748CFC
	for <cgroups@vger.kernel.org>; Fri, 26 Jun 2026 01:54:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782438850; cv=none; b=kxDdnZ+arAMrigm+PHEHOxaSK9VCB/kiuEMgAz9XFnJItQayKViU4A5dSWWK2n06Tzy3G2lIbctGrQto2CaFkKD6E+zzQV7r5TBKzCrq2puP67CuLkUdw+EhC8OlY6F3i4uqHYOOt48y5ubuZIunkecRR+PWSptZSY0eFVVFYYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782438850; c=relaxed/simple;
	bh=+/WAlLUYrz7tyLTHNwaqj0AveS0acL2JC+wZkxWT9zo=;
	h=Mime-Version:In-Reply-To:To:From:Subject:Message-Id:Content-Type:
	 References:Cc:Date; b=HH6AZhbjsgfYHIAFho97UabXKmN2q+0dk27FZQ5gcTJMYyY3+os3DUKuI4ZM3fdPAAWK6g1Y2vVYwfJdM/d7hN344nIgdy20B5e1tIMriFE6WOzrnuSojhpkcghwFM3plljTOaFJVo0AAgc42IkKbW5aYZBRDjyv/wZuTcHHdCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=LGujZFHT; arc=none smtp.client-ip=101.45.255.44
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1782438759;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=uJQCt90HbiUJ/J7L6Qv7Yed3QW//1eI/IRidisxAhrY=;
 b=LGujZFHTrsulr+5de9KUlBVbwZuOL3E2gRm/TebEHNZyBB8LoKM0KI6wtsdX0pc9LO+jZi
 WtQ6SrLzkmawsnn3jnnlW5MQOtZJaUnUmi94IvZP4LOU7th8AVqw+8e5P6ZiZIANwDjRoG
 FKbFIMqbRu4QiqVkvePZvSopCFP9CcKQjPswNLt6gqIsI7K62KBXT3Js40dgcfkocUYka+
 a/bOT7CKKTvJPCYsqWHPlmm1UZzQu4MiQvBoNME+EKHQDVfLrvZ0kQIys4wL2I30KyG+2q
 RStwemVeVw7X+vX5SWpgT7QByx1pbY3Ydgp6hCLpmmVtwIPFYhkgRMTamHVYWA==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
X-Original-From: yu kuai <yukuai@fygo.io>
In-Reply-To: <7ebbf312-7c1b-4024-a35d-89a95d82b4f4@fygo.io>
Content-Transfer-Encoding: quoted-printable
To: "Nilay Shroff" <nilay@linux.ibm.com>, "Tejun Heo" <tj@kernel.org>, 
	"Josef Bacik" <josef@toxicpanda.com>, "Jens Axboe" <axboe@kernel.dk>
From: "yu kuai" <yukuai@fygo.io>
Subject: Re: [PATCH v2 2/4] blk-cgroup: fix race between policy activation and blkg destruction
Reply-To: yukuai@fygo.io
X-Lms-Return-Path: <lba+26a3ddb66+a7157d+vger.kernel.org+yukuai@fygo.io>
Received: from [192.168.1.104] ([39.182.0.144]) by smtp.larksuite.com with ESMTPS; Fri, 26 Jun 2026 01:52:37 +0000
Message-Id: <749d17be-ff9f-4f70-a948-0133f02eec93@fygo.io>
Content-Type: text/plain; charset=UTF-8
References: <20260624064625.1743650-1-yukuai@kernel.org> <20260624064625.1743650-5-yukuai@kernel.org> <6580506d-3baa-4ceb-bf2e-5f6c974f3d10@linux.ibm.com> <7ebbf312-7c1b-4024-a35d-89a95d82b4f4@fygo.io>
Cc: "Zheng Qixing" <zhengqixing@huawei.com>, 
	"Christoph Hellwig" <hch@lst.de>, "Tang Yizhou" <yizhou.tang@shopee.com>, 
	"Ming Lei" <ming.lei@redhat.com>, <cgroups@vger.kernel.org>, 
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<yukuai@fygo.io>
Date: Fri, 26 Jun 2026 09:52:34 +0800
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[fygo.io : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[fygo-io.20200929.dkim.larksuite.com:s=s1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[yukuai@fygo.io,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nilay@linux.ibm.com,m:tj@kernel.org,m:josef@toxicpanda.com,m:axboe@kernel.dk,m:zhengqixing@huawei.com,m:hch@lst.de,m:yizhou.tang@shopee.com,m:ming.lei@redhat.com,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yukuai@fygo.io,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17303-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[fygo-io.20200929.dkim.larksuite.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fygo.io,cgroups@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[yukuai@fygo.io];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,fygo-io.20200929.dkim.larksuite.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D8AC6C99C0

Hi,

=E5=9C=A8 2026/6/26 9:50, yu kuai =E5=86=99=E9=81=93:
> Hi,
>
> =E5=9C=A8 2026/6/25 23:08, Nilay Shroff =E5=86=99=E9=81=93:
>> On 6/24/26 12:16 PM, Yu Kuai wrote:
>>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>>> index 7baccfb690fe..f7e788a7fe95 100644
>>> --- a/block/blk-cgroup.c
>>> +++ b/block/blk-cgroup.c
>>> @@ -1563,10 +1563,12 @@ int blkcg_activate_policy(struct gendisk
>>> *disk, const struct blkcg_policy *pol)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (WARN_ON_ONCE(!pol->pd_alloc_fn || !=
pol->pd_free_fn))
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (queue_is_mq(q))
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memflags =3D bl=
k_mq_freeze_queue(q);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 mutex_lock(&q->blkcg_mutex);
>>>  =C2=A0 retry:
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_irq(&q->queue_lock);
>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* blkg_list is pushed at the he=
ad, reverse walk to
>>> initialize parents first */
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_for_each_entry_reverse(blkg, &q->b=
lkg_list, q_node) {
>>> @@ -1625,10 +1627,11 @@ int blkcg_activate_policy(struct gendisk
>>> *disk, const struct blkcg_policy *pol)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(pol->plid, q->blkcg_pols);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 0;
>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock_irq(&q->queue_lock);
>>>  =C2=A0 out:
>>> +=C2=A0=C2=A0=C2=A0 mutex_unlock(&q->blkcg_mutex);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (queue_is_mq(q))
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_mq_unfreeze=
_queue(q, memflags);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pinned_blkg)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blkg_put(pinned=
_blkg);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pd_prealloc)
>> If the policy allocation fails, we jump to the lable enomem: and
>> teardown pds.
>> But I see this path still only acquires ->queue_lock. Don't we also need
>> to protect it with ->blkcg_mutex?
> Yes, I agree we should protect it as well.

Just take a closer look at the code, the enomem is already protected by
blkcg_mutex :)

>
>> Moreover I still see race between blkg insertion in blkg_create() which
>> still doesn't use ->blkcg_mutex and so list traversal in
>> bfq_end_wr_async()
>> may still race with blkg_create(), isn't it? I remember you once told
>> this will be handled in another series but I couldn't find that yet.
> This is the set:
>
> [PATCH 0/8] blk-cgroup: remove queue_lock nesting from blkcg paths - Yu
> Kuai <https://lore.kernel.org/all/cover.1780621988.git.yukuai@fygo.io/>
>
> Noted that set just make sure queue_lock is not nested under other atomic
> context, and that set do not acquire blkcg_mutex for blkg_create() yet. H=
owerver,
> with that set it'll be easy to convert all queue_lock to blkcg_mtuex for =
blkg
> protection, and together with lots of blk-cgroup code cleanups.
>
>
>> Thanks,
>> --Nilay
>>
>>
>>
>>
--=20
Thanks,
Kuai

