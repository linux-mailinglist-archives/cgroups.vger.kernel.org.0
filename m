Return-Path: <cgroups+bounces-17302-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2qgDJwbbPWrH7AgAu9opvQ
	(envelope-from <cgroups+bounces-17302-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 03:51:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E166C9996
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 03:51:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fygo-io.20200929.dkim.larksuite.com header.s=s1 header.b=L8a27Jzw;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17302-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17302-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=fygo.io (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88779304C13F
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 01:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E512DCF45;
	Fri, 26 Jun 2026 01:50:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from va-2-42.ptr.blmpb.com (va-2-42.ptr.blmpb.com [209.127.231.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C399C48CFC
	for <cgroups@vger.kernel.org>; Fri, 26 Jun 2026 01:50:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782438641; cv=none; b=kdo7GfV6nb7sQpwBtr5I5kU0i7NX7McD4cIdw8z2XTnKc7k4no16tCVbqiGACghK6G8k6An4WWiliv63ldleKOuWeJICUYlpvIj0TqoDv0MzJ688fPqTzOfmsjIOgjRBWXFu2MMoEKjIb3Oyw46ypJlhONoXceOyDVn39HpNkrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782438641; c=relaxed/simple;
	bh=PSe3MGyngtCqf2sfhKTxnfcWFHe2eCIy16NVXiQY/tA=;
	h=References:Cc:From:Subject:Message-Id:Mime-Version:To:Date:
	 Content-Type:In-Reply-To; b=QLzoUr/qrwHlTsZaGmFu8CMZV0cbGPQrr65ncfPz/Ds5V6VvQ8tnykHeX5TQ5aSHdwoLYOKqUIMgkgFwKyQ47Kw+uYMzBfp1E/qPycQw6FVWDuR8YQW7nWeHHvWKjfJ0l/HOwn/iTUFrCazEgBp4crDLk44TD2151n97ydo//nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=L8a27Jzw; arc=none smtp.client-ip=209.127.231.42
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1782438625;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=PSe3MGyngtCqf2sfhKTxnfcWFHe2eCIy16NVXiQY/tA=;
 b=L8a27JzwTd23Zcwjxcw4h9J3Or1Svr4NYpMHeXDb0QLt76tlBw2nbpImyjE1ojO0g5SFJA
 Tj8AOgmZMz3GVnTa0D7qk0sbrQYgenhmNIgDvkeMQzYgIOhrVMAKjtrmn3wDt2TtuqTV3/
 FK08E/K+iAabxWFxs+Yel7Tzb3/2nhprOANtxc5/e+yO8y6/nLW2r2+SQgIl/i8q5K5zcI
 WXqme3+8FiGgjV44wBzELBBS9SgBUu8hcbGZgUjP7nFi+ojxt2QHHv5onaQSpWvjQ08I8S
 6ughyAe/P1VCtdQpjwP6gUXOY4XcJvPkLf8cba9YC/zy9iw1oqd6OeoekdGFjA==
Content-Transfer-Encoding: quoted-printable
References: <20260624064625.1743650-1-yukuai@kernel.org> <20260624064625.1743650-5-yukuai@kernel.org> <6580506d-3baa-4ceb-bf2e-5f6c974f3d10@linux.ibm.com>
Cc: "Zheng Qixing" <zhengqixing@huawei.com>, 
	"Christoph Hellwig" <hch@lst.de>, "Tang Yizhou" <yizhou.tang@shopee.com>, 
	"Ming Lei" <ming.lei@redhat.com>, <cgroups@vger.kernel.org>, 
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<yukuai@fygo.io>
From: "yu kuai" <yukuai@fygo.io>
Subject: Re: [PATCH v2 2/4] blk-cgroup: fix race between policy activation and blkg destruction
Message-Id: <7ebbf312-7c1b-4024-a35d-89a95d82b4f4@fygo.io>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Reply-To: yukuai@fygo.io
To: "Nilay Shroff" <nilay@linux.ibm.com>, "Tejun Heo" <tj@kernel.org>, 
	"Josef Bacik" <josef@toxicpanda.com>, "Jens Axboe" <axboe@kernel.dk>
X-Lms-Return-Path: <lba+26a3ddae0+38e86d+vger.kernel.org+yukuai@fygo.io>
Date: Fri, 26 Jun 2026 09:50:20 +0800
Content-Type: text/plain; charset=UTF-8
Received: from [192.168.1.104] ([39.182.0.144]) by smtp.larksuite.com with ESMTPS; Fri, 26 Jun 2026 01:50:23 +0000
X-Original-From: yu kuai <yukuai@fygo.io>
In-Reply-To: <6580506d-3baa-4ceb-bf2e-5f6c974f3d10@linux.ibm.com>
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
	FORGED_RECIPIENTS(0.00)[m:zhengqixing@huawei.com,m:hch@lst.de,m:yizhou.tang@shopee.com,m:ming.lei@redhat.com,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yukuai@fygo.io,m:nilay@linux.ibm.com,m:tj@kernel.org,m:josef@toxicpanda.com,m:axboe@kernel.dk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17302-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fygo-io.20200929.dkim.larksuite.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7E166C9996

Hi,

=E5=9C=A8 2026/6/25 23:08, Nilay Shroff =E5=86=99=E9=81=93:
> On 6/24/26 12:16 PM, Yu Kuai wrote:
>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>> index 7baccfb690fe..f7e788a7fe95 100644
>> --- a/block/blk-cgroup.c
>> +++ b/block/blk-cgroup.c
>> @@ -1563,10 +1563,12 @@ int blkcg_activate_policy(struct gendisk=20
>> *disk, const struct blkcg_policy *pol)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (WARN_ON_ONCE(!pol->pd_alloc_fn || !po=
l->pd_free_fn))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (queue_is_mq(q))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memflags =3D blk_=
mq_freeze_queue(q);
>> +
>> +=C2=A0=C2=A0=C2=A0 mutex_lock(&q->blkcg_mutex);
>> =C2=A0 retry:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_irq(&q->queue_lock);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* blkg_list is pushed at the head=
, reverse walk to=20
>> initialize parents first */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_for_each_entry_reverse(blkg, &q->blk=
g_list, q_node) {
>> @@ -1625,10 +1627,11 @@ int blkcg_activate_policy(struct gendisk=20
>> *disk, const struct blkcg_policy *pol)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(pol->plid, q->blkcg_pols);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 0;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock_irq(&q->queue_lock);
>> =C2=A0 out:
>> +=C2=A0=C2=A0=C2=A0 mutex_unlock(&q->blkcg_mutex);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (queue_is_mq(q))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_mq_unfreeze_q=
ueue(q, memflags);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pinned_blkg)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blkg_put(pinned_b=
lkg);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pd_prealloc)
>
> If the policy allocation fails, we jump to the lable enomem: and=20
> teardown pds.
> But I see this path still only acquires ->queue_lock. Don't we also need
> to protect it with ->blkcg_mutex?

Yes, I agree we should protect it as well.

>
> Moreover I still see race between blkg insertion in blkg_create() which
> still doesn't use ->blkcg_mutex and so list traversal in=20
> bfq_end_wr_async()
> may still race with blkg_create(), isn't it? I remember you once told
> this will be handled in another series but I couldn't find that yet.

This is the set:

[PATCH 0/8] blk-cgroup: remove queue_lock nesting from blkcg paths - Yu=20
Kuai <https://lore.kernel.org/all/cover.1780621988.git.yukuai@fygo.io/>

Noted that set just make sure queue_lock is not nested under other atomic
context, and that set do not acquire blkcg_mutex for blkg_create() yet. How=
erver,
with that set it'll be easy to convert all queue_lock to blkcg_mtuex for bl=
kg
protection, and together with lots of blk-cgroup code cleanups.


>
> Thanks,
> --Nilay
>
>
>
>
--=20
Thanks,
Kuai

