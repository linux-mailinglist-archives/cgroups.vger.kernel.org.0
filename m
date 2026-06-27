Return-Path: <cgroups+bounces-17362-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /mqPH0JOP2phRQkAu9opvQ
	(envelope-from <cgroups+bounces-17362-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 27 Jun 2026 06:14:58 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D57546D11BD
	for <lists+cgroups@lfdr.de>; Sat, 27 Jun 2026 06:14:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fygo-io.20200929.dkim.larksuite.com header.s=s1 header.b=DL72uGsb;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17362-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17362-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=fygo.io (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A128F3048934
	for <lists+cgroups@lfdr.de>; Sat, 27 Jun 2026 04:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06176388E45;
	Sat, 27 Jun 2026 04:14:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from va-2-60.ptr.blmpb.com (va-2-60.ptr.blmpb.com [209.127.231.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA497388E40
	for <cgroups@vger.kernel.org>; Sat, 27 Jun 2026 04:14:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782533650; cv=none; b=SFP7+p4JPxzIKIUbJPKR/HmxK5h5XgwxmjYCA3zHUfYnSJfP+UZSrgv518De/taLTVuNJBn6LDqKag4ZEcV2hMI1fXg0kZEc9d32vqUZDZRXbJNksHOMlo7Qc0ZWz7DiG5eIXlAY04muFP76BR5sptGt1OgNmxDlhKcegu8q2Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782533650; c=relaxed/simple;
	bh=e6ji9vzCjGH0E67FHnI7gOsvMmXXkoPcVj9vcddWOl8=;
	h=Subject:Mime-Version:Content-Type:In-Reply-To:To:Cc:References:
	 Message-Id:From:Date; b=B1FRinK6+YZzbMiqZDDMrlS7cjMvF7oHckOSRXjGFGj2fx/FVuS37h4Ceu9IRm3/ALVGZkh65Vw2ERaOokHWgtqouoDLjhk25rwtCXWw0UZjqYIp7Vzco4z9czrv21gRJPQRcZ9UQGhYJDqznzI/IGkXMEHeIwoLdy6g4xbE2Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=DL72uGsb; arc=none smtp.client-ip=209.127.231.60
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1782533637;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=e6ji9vzCjGH0E67FHnI7gOsvMmXXkoPcVj9vcddWOl8=;
 b=DL72uGsbbCefdp0hqhGYiHT/jICt6TorK6eWv3ZJvmntqGIaZKnNpCI59ej4esJSG1ttJT
 R79mXDuIRuCnn/RqMuDXmIF7KbG/IWbTKW5rQ+34KiW12aPH2DWCa6pMXVkGDehYFfFBzW
 C6X4+q1hYmSSF2swtUpQrFLKGlPCTSsvBTqGn6YJGVoDFNbGE6AhxUfkKZ2kM7CCY9FSuB
 +wUFDOWZHVl94aD3cmUVygsW6ixyLh4EA+rE27U4OCtvZFFkbikJPiM9TxN4YEIZr/n6Mj
 NLiMwOyJ6sTjXL8vBEiW0UYluEJayT20tm0vYl1M3+ImIbZImqkJSEQlHmcjiA==
Reply-To: yukuai@fygo.io
Subject: Re: [PATCH v2 2/4] blk-cgroup: fix race between policy activation and blkg destruction
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [192.168.1.104] ([39.182.0.144]) by smtp.larksuite.com with ESMTPS; Sat, 27 Jun 2026 04:13:56 +0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <866644be-3b07-49f9-9c5d-e0f94ad1c793@linux.ibm.com>
To: "Nilay Shroff" <nilay@linux.ibm.com>, "Tejun Heo" <tj@kernel.org>, 
	"Josef Bacik" <josef@toxicpanda.com>, "Jens Axboe" <axboe@kernel.dk>
Cc: "Zheng Qixing" <zhengqixing@huawei.com>, 
	"Christoph Hellwig" <hch@lst.de>, "Tang Yizhou" <yizhou.tang@shopee.com>, 
	"Ming Lei" <ming.lei@redhat.com>, <cgroups@vger.kernel.org>, 
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<yukuai@fygo.io>
References: <20260624064625.1743650-1-yukuai@kernel.org> <20260624064625.1743650-5-yukuai@kernel.org> <6580506d-3baa-4ceb-bf2e-5f6c974f3d10@linux.ibm.com> <7ebbf312-7c1b-4024-a35d-89a95d82b4f4@fygo.io> <749d17be-ff9f-4f70-a948-0133f02eec93@fygo.io> <866644be-3b07-49f9-9c5d-e0f94ad1c793@linux.ibm.com>
X-Original-From: yu kuai <yukuai@fygo.io>
Message-Id: <5f5a4729-0c90-4f6f-b97e-cab9d0289dc2@fygo.io>
X-Lms-Return-Path: <lba+26a3f4e05+9f07f3+vger.kernel.org+yukuai@fygo.io>
From: "yu kuai" <yukuai@fygo.io>
Date: Sat, 27 Jun 2026 12:13:52 +0800
User-Agent: Mozilla Thunderbird
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[fygo.io : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[fygo-io.20200929.dkim.larksuite.com:s=s1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-17362-lists,cgroups=lfdr.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fygo.io,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[fygo-io.20200929.dkim.larksuite.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[yukuai@fygo.io];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,fygo.io:replyto,fygo.io:mid,fygo.io:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D57546D11BD

Hi,

=E5=9C=A8 2026/6/26 14:12, Nilay Shroff =E5=86=99=E9=81=93:
> On 6/26/26 7:22 AM, yu kuai wrote:
>> Hi,
>>
>> =E5=9C=A8 2026/6/26 9:50, yu kuai =E5=86=99=E9=81=93:
>>> Hi,
>>>
>>> =E5=9C=A8 2026/6/25 23:08, Nilay Shroff =E5=86=99=E9=81=93:
>>>> On 6/24/26 12:16 PM, Yu Kuai wrote:
>>>>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>>>>> index 7baccfb690fe..f7e788a7fe95 100644
>>>>> --- a/block/blk-cgroup.c
>>>>> +++ b/block/blk-cgroup.c
>>>>> @@ -1563,10 +1563,12 @@ int blkcg_activate_policy(struct gendisk
>>>>> *disk, const struct blkcg_policy *pol)
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (WARN_ON_ONCE(!pol->pd_alloc=
_fn || !pol->pd_free_fn))
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return =
-EINVAL;
>>>>> =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (queue_is_mq(q))
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memflag=
s =3D blk_mq_freeze_queue(q);
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 mutex_lock(&q->blkcg_mutex);
>>>>> =C2=A0 =C2=A0 retry:
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_irq(&q->queue_lock);
>>>>> =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* blkg_list is pushed a=
t the head, reverse walk to
>>>>> initialize parents first */
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_for_each_entry_reverse(blk=
g, &q->blkg_list, q_node) {
>>>>> @@ -1625,10 +1627,11 @@ int blkcg_activate_policy(struct gendisk
>>>>> *disk, const struct blkcg_policy *pol)
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(pol->plid, q->blkcg_p=
ols);
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 0;
>>>>> =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock_irq(&q->queu=
e_lock);
>>>>> =C2=A0 =C2=A0 out:
>>>>> +=C2=A0=C2=A0=C2=A0 mutex_unlock(&q->blkcg_mutex);
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (queue_is_mq(q))
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_mq_=
unfreeze_queue(q, memflags);
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pinned_blkg)
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blkg_pu=
t(pinned_blkg);
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pd_prealloc)
>>>> If the policy allocation fails, we jump to the lable enomem: and
>>>> teardown pds.
>>>> But I see this path still only acquires ->queue_lock. Don't we also=20
>>>> need
>>>> to protect it with ->blkcg_mutex?
>>> Yes, I agree we should protect it as well.
>>
>> Just take a closer look at the code, the enomem is already protected by
>> blkcg_mutex :)
>>
>
> Oh yes, but the ->blkcg_mutex is never released if we jump to enomem.
> So that may potentially cause deadlock. We need to release ->blkcg_mutex
> once blkcg_policy_teardown_pds() returns. Or may be refactor code (or add
> comment) so that it's easy to realize or spot the ->blkcg_mutex is=20
> acquired
> and then released around blkcg_policy_teardown_pds().

the enomem will goto out at last, and blkcg_mutex do released. The code is
a bit hacky.

>
>>>
>>>> Moreover I still see race between blkg insertion in blkg_create()=20
>>>> which
>>>> still doesn't use ->blkcg_mutex and so list traversal in
>>>> bfq_end_wr_async()
>>>> may still race with blkg_create(), isn't it? I remember you once told
>>>> this will be handled in another series but I couldn't find that yet.
>>> This is the set:
>>>
>>> [PATCH 0/8] blk-cgroup: remove queue_lock nesting from blkcg paths - Yu
>>> Kuai <https://lore.kernel.org/all/cover.1780621988.git.yukuai@fygo.io/>
>>>
>>> Noted that set just make sure queue_lock is not nested under other=20
>>> atomic
>>> context, and that set do not acquire blkcg_mutex for blkg_create()=20
>>> yet. Howerver,
>>> with that set it'll be easy to convert all queue_lock to blkcg_mtuex=20
>>> for blkg
>>> protection, and together with lots of blk-cgroup code cleanups.
>>>
>
> Okay, so are you planning to send a follow-up patchset that replaces=20
> ->queue_lock
> with ->blkcg_mutex for protecting the blkg_list? If so, I'd still=20
> prefer acquiring
> ->blkcg_mutex around blkg_create() in this patchset. That would=20
> address the race
> between blkg_create() and the blkg_list traversal in=20
> bfq_end_wr_async(), while the
> subsequent series can focus on cleaning up and removing the remaining=20
> ->queue_lock
> usage for blkg protection.

Yes, there is a follow-up patchset. When this set was posted, blkg_create i=
s still
called with queue_lock held, so I can't do that. However, not that the othe=
r set
is already applied, I can hold blkcg_mutex for blkg_create() now.

>
> Thanks,
> --Nilay
>
--=20
Thanks,
Kuai

