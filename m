Return-Path: <cgroups+bounces-17750-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FA+iJ0SPVWpWqAAAu9opvQ
	(envelope-from <cgroups+bounces-17750-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 03:22:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABA17500E4
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 03:22:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fygo-io.20200929.dkim.larksuite.com header.s=s1 header.b=CsJkfioZ;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17750-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17750-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=fygo.io (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8692C301435F
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 01:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BF135F182;
	Tue, 14 Jul 2026 01:22:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from va-2-51.ptr.blmpb.com (va-2-51.ptr.blmpb.com [209.127.231.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727151D5174
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 01:22:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783992130; cv=none; b=kcv0Hhe+Ws0zWvUrMXqSA0rWa3ky5JEZMLiJlgs1uNYPvZA+okD0/SxN0u/rw6dpEE0kUY6rWia8ameNmNBzP68NO9rr6ydjWcVJjO6eLDLCJ0yZSw1BTaHzlCqhOCUY+uBgQgokfSuA7wfWoRzua6kCUzF8CM+ZverRhq/TjjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783992130; c=relaxed/simple;
	bh=ZeCuUN1Fp9W4TMQKtRmZ1tTkmF93aBEFuPtz6IeYxUs=;
	h=From:Message-Id:In-Reply-To:Content-Type:Cc:Mime-Version:Subject:
	 To:Date:References; b=TkkybJywSlKEbK5FQIzI0GwLkG9IRAoSDyzMFZgy20WAOMoUR0TLYlt/SQgBL1W5bSWFgzFjv8hWOc6Us3C954mFGOvCGhS0SHQINT0Z7d64WfWu4Skrl+/NjvgjoJFcA7NbldYdw0WQ5zlEuZ+CgUKrSnRsgpNYTGyZ49tHJPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=CsJkfioZ; arc=none smtp.client-ip=209.127.231.51
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1783992117;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=MXAT3+5slbifSjkkzpCjT7TTJaAwUZJ8MfqgEo/pHc0=;
 b=CsJkfioZOfCKThBtkoFIqreHboAirqKwBEj69z/tsxUahDElsQl9i8Qq2wZGtQFC4vonXn
 tWWCqZI9aFONnkCoGrW2IOvX/kMubR9mLGaTQS6Ch8sHTYNkGIUER6Xc1hvHZKlL1h/bPi
 iCiVONZE8SU1oFJrvn2j8Q4tJ6GJWInKG5nevT4RT9C+qPjypZLMNH6QWrOBLl4Yd7v/dB
 qmwlFLyVkvVI23fjTTo9NA96ob3JK/6cLszMo86b1HtQmYoQ3i0QSSvc4zOGoov7h4mafa
 bQZb0LM89e/+gOH4L+Sn2WhWWnrMUKge8gH2IZWi0advUSoDqkZc6cg0BX8khw==
From: "yu kuai" <yukuai@fygo.io>
Message-Id: <e0ba356e-c5ef-4100-b774-b599cae65968@fygo.io>
In-Reply-To: <20260713121244.GA20084@lst.de>
Content-Type: text/plain; charset=UTF-8
Reply-To: yukuai@fygo.io
Cc: "Jens Axboe" <axboe@kernel.dk>, "Tejun Heo" <tj@kernel.org>, 
	"Keith Busch" <kbusch@kernel.org>, "Sagi Grimberg" <sagi@grimberg.me>, 
	"Alasdair Kergon" <agk@redhat.com>, 
	"Benjamin Marzinski" <bmarzins@redhat.com>, 
	"Mike Snitzer" <snitzer@kernel.org>, 
	"Mikulas Patocka" <mpatocka@redhat.com>, 
	"Dongsheng Yang" <dongsheng.yang@linux.dev>, 
	"Zheng Gu" <cengku@gmail.com>, "Coly Li" <colyli@fygo.io>, 
	"Kent Overstreet" <kent.overstreet@linux.dev>, 
	"Josef Bacik" <josef@toxicpanda.com>, 
	"Nilay Shroff" <nilay@linux.ibm.com>, <linux-block@vger.kernel.org>, 
	<cgroups@vger.kernel.org>, <linux-nvme@lists.infradead.org>, 
	<dm-devel@lists.linux.dev>, <linux-bcache@vger.kernel.org>, 
	"yu kuai" <yukuai@fygo.io>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [RFC PATCH v1 01/17] nvme-multipath: retarget failedover bios from requeue work
Received: from [192.168.1.104] ([39.182.0.157]) by smtp.larksuite.com with ESMTPS; Tue, 14 Jul 2026 01:21:56 +0000
User-Agent: Mozilla Thunderbird
X-Original-From: yu kuai <yukuai@fygo.io>
To: "Christoph Hellwig" <hch@lst.de>, "Hannes Reinecke" <hare@suse.de>
Date: Tue, 14 Jul 2026 09:21:50 +0800
References: <20260704195124.1375075-1-yukuai@kernel.org> <20260704195124.1375075-2-yukuai@kernel.org> <0ded62a6-b3da-4790-adf0-566ded30ee43@suse.de> <20260713121244.GA20084@lst.de>
X-Lms-Return-Path: <lba+26a558f34+c186fd+vger.kernel.org+yukuai@fygo.io>
Content-Transfer-Encoding: quoted-printable
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17750-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[yukuai@fygo.io,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:tj@kernel.org,m:kbusch@kernel.org,m:sagi@grimberg.me,m:agk@redhat.com,m:bmarzins@redhat.com,m:snitzer@kernel.org,m:mpatocka@redhat.com,m:dongsheng.yang@linux.dev,m:cengku@gmail.com,m:colyli@fygo.io,m:kent.overstreet@linux.dev,m:josef@toxicpanda.com,m:nilay@linux.ibm.com,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:dm-devel@lists.linux.dev,m:linux-bcache@vger.kernel.org,m:yukuai@fygo.io,m:hch@lst.de,m:hare@suse.de,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,grimberg.me,redhat.com,linux.dev,gmail.com,fygo.io,toxicpanda.com,linux.ibm.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2ABA17500E4

Hi=EF=BC=8C

=E5=9C=A8 2026/7/13 20:12, Christoph Hellwig =E5=86=99=E9=81=93:
> On Mon, Jul 13, 2026 at 11:29:35AM +0200, Hannes Reinecke wrote:
>> On 7/4/26 9:51 PM, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai@fygo.io>
>>>
>>> bio_set_dev() is about to become explicitly sleepable because it can
>>> associate the bio with a blkg for the destination queue.  NVMe failover
>>> can run from request completion context, and nvme_failover_req() also h=
olds
>>> head->requeue_lock with interrupts disabled while it steals bios from t=
he
>>> failed request.  Calling bio_set_dev() there is not safe once the helpe=
r is
>>> allowed to sleep.
>>>
>>> The requeue lock only protects head->requeue_list.  Keep the list
>>> manipulation under that lock, but defer retargeting to nvme_requeue_wor=
k(),
>>> which already drains the list from process context before resubmitting =
each
>>> bio.  The bios remain private to the requeue list until the worker pops
>>> them, so moving the device switch there preserves the existing retry fl=
ow
>>> while avoiding a sleepable helper in completion context.
>>>
>>> Signed-off-by: Yu Kuai <yukuai@fygo.io>
>>> ---
>>>    drivers/nvme/host/multipath.c | 4 +---
>>>    1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipat=
h.c
>>> index 9b9a657fa330..76baa180ae1c 100644
>>> --- a/drivers/nvme/host/multipath.c
>>> +++ b/drivers/nvme/host/multipath.c
>>> @@ -149,7 +149,6 @@ void nvme_failover_req(struct request *req)
>>>    	struct nvme_ns *ns =3D req->q->queuedata;
>>>    	u16 status =3D nvme_req(req)->status & NVME_SCT_SC_MASK;
>>>    	unsigned long flags;
>>> -	struct bio *bio;
>>>      	nvme_mpath_clear_current_path(ns);
>>>    	atomic_long_inc(&ns->failover);
>>> @@ -165,8 +164,6 @@ void nvme_failover_req(struct request *req)
>>>    	}
>>>      	spin_lock_irqsave(&ns->head->requeue_lock, flags);
>>> -	for (bio =3D req->bio; bio; bio =3D bio->bi_next)
>>> -		bio_set_dev(bio, ns->head->disk->part0);
>> If you remove this the original device remains being referenced by
>> the bio, so there might be a chance of some accidentally referencing
>> the (now invalid) bdev.
>> I think it might be better if you were set it to NULL here, to
>> signal that this bio currently has no bdev associated.
> What should reference it?  This moves setting bi_bdev from the only
> place adding to the list to the only place removing from the list.

I'll follow your advice to move blkg association to bio submit. And this pa=
tch
will not be needed anymore.

>
--=20
Thanks,
Kuai

