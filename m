Return-Path: <cgroups+bounces-17619-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vV8GFPR1T2qthAIAu9opvQ
	(envelope-from <cgroups+bounces-17619-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 12:20:36 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 255E672F838
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 12:20:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=temperror ("DNS error when getting key") header.d=fygo-io.20200929.dkim.larksuite.com header.s=s1 header.b=lmEr59L6;
	dmarc=temperror reason="query timed out" header.from=fygo.io (policy=temperror);
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17619-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17619-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 46C26308D53B
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2026 10:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAA6404BF4;
	Thu,  9 Jul 2026 10:08:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from va-2-20.ptr.blmpb.com (va-2-20.ptr.blmpb.com [209.127.231.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6ED3F54C3
	for <cgroups@vger.kernel.org>; Thu,  9 Jul 2026 10:08:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591733; cv=none; b=pXrwiv9Orelyz4ugmhArivLk9p6LC4LE4SwOmwsZsiPTnVE9rcyn3VFLS9KXKJwTE8u19PkXoNtg3RsPKaWf7GXPUO8c4l7vFUfGR3mNZLI+LIToiwnisSXP564CM8gL8SFJsWkoHdXOOpd9Bx4vhpy52EohrskEFx3BH23DI4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591733; c=relaxed/simple;
	bh=8Y8a558XU+yeUr5q6e4HBxwJmZ5LZ+XgJZHBJowpPs8=;
	h=Mime-Version:Content-Type:To:Subject:Date:Message-Id:In-Reply-To:
	 From:Cc:References; b=oxfGMzwSduehlVP2VgXskbZspx4SS7kCuCsrImICm171jRIt5A6J/WiMfY6Bz0EAhLm0bnCJM715sDjNMVDj6nV1vQQpt2AlUga/k83YCi6Z2XwxLAgPmD10P5ysYkaINa+EqYjx/G2WoFtx6S4YlKM047A7gLkDHJdp/G5VAHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=lmEr59L6; arc=none smtp.client-ip=209.127.231.20
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1783591722;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=nzPK7Q3qm+3tUE8Y8KFwnXjquoOkl/kUWyXBpYXUuB8=;
 b=lmEr59L6hyNDPoexltHX9iycAL/45pk6YoF3XWWsg6Wvx0rwSLZKorXPyguGonelmtu3sE
 2SFPEcoysIMDs3YXsZXF9DIQ7mta8Ukm1vDmj0+cGVbZRE0mBZyjMYpnUpuYXmV7XjRnUC
 eONZHfJJ+Ns3mhhCK59zJJWgCu4Vyjod1zKrlUG/b4BQLAUvG7c8X0yc+qTy2Fp/FYWYh/
 3Myivt1FYf4L5l67F5beixXxczc9s07jswbBqs/CkDlav9ZhKGzZdZaeKWcKxneIdsk0Kf
 auVcM8LVokNBtyNphHUMxjAcQdvowFH8U55ZQUNtxWRmykiEhEAtk2JT4XGIeQ==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
Received: from [192.168.1.104] ([39.182.0.144]) by smtp.larksuite.com with ESMTPS; Thu, 09 Jul 2026 10:08:41 +0000
Content-Type: text/plain; charset=UTF-8
To: "Christoph Hellwig" <hch@lst.de>, "yu kuai" <yukuai@fygo.io>
Subject: Re: [RFC PATCH v1 00/17] blk-cgroup: protect blkgs with blkcg_mutex
Date: Thu, 9 Jul 2026 18:08:36 +0800
Message-Id: <75bc21b5-9cc5-4d39-8ba3-7cf69689e438@fygo.io>
In-Reply-To: <20260709060959.GA16504@lst.de>
From: "yu kuai" <yukuai@fygo.io>
X-Original-From: yu kuai <yukuai@fygo.io>
Content-Transfer-Encoding: quoted-printable
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
	<dm-devel@lists.linux.dev>, <linux-bcache@vger.kernel.org>
References: <20260704195124.1375075-1-yukuai@kernel.org> <20260709060959.GA16504@lst.de>
X-Lms-Return-Path: <lba+26a4f7329+7afd3c+vger.kernel.org+yukuai@fygo.io>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,grimberg.me,redhat.com,linux.dev,gmail.com,fygo.io,toxicpanda.com,linux.ibm.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-17619-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:query timed out,sin.lore.kernel.org:query timed out,fygo.io:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[fygo-io.20200929.dkim.larksuite.com:?];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[fygo.io:query timed out,vger.kernel.org:query timed out];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:yukuai@fygo.io,m:axboe@kernel.dk,m:tj@kernel.org,m:kbusch@kernel.org,m:sagi@grimberg.me,m:agk@redhat.com,m:bmarzins@redhat.com,m:snitzer@kernel.org,m:mpatocka@redhat.com,m:dongsheng.yang@linux.dev,m:cengku@gmail.com,m:colyli@fygo.io,m:kent.overstreet@linux.dev,m:josef@toxicpanda.com,m:nilay@linux.ibm.com,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:dm-devel@lists.linux.dev,m:linux-bcache@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[yukuai@fygo.io,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[vger.kernel.org:query timed out,fygo.io:query timed out];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[fygo.io:query timed out,vger.kernel.org:query timed out];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RSPAMD_EMAILBL_FAIL(0.00)[yukuai.fygo.io:query timed out,cgroups@vger.kernel.org:query timed out,yukuai@fygo.io:query timed out];
	PRECEDENCE_BULK(0.00)[];
	MSBL_EBL_FAIL(0.00)[cgroups@vger.kernel.org:query timed out,yukuai@fygo.io:query timed out];
	DBL_FAIL(0.00)[fygo.io:query timed out,sin.lore.kernel.org:query timed out,vger.kernel.org:query timed out];
	MAILSPIKE_FAIL(0.00)[104.64.211.4:query timed out];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fygo.io,cgroups@vger.kernel.org];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RBL_SEM_FAIL(0.00)[104.64.211.4:query timed out];
	RBL_VIRUSFREE_UNKNOWN_FAIL(0.00)[104.64.211.4:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	DMARC_DNSFAIL(0.00)[fygo.io : query timed out];
	HAS_REPLYTO(0.00)[yukuai@fygo.io];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_TEMPFAIL(0.00)[fygo-io.20200929.dkim.larksuite.com:s=s1];
	BLOCKLISTDE_FAIL(0.00)[100.90.174.1:query timed out,39.182.0.144:query timed out,209.127.231.20:query timed out,104.64.211.4:query timed out];
	SURBL_MULTI_FAIL(0.00)[sin.lore.kernel.org:query timed out,fygo.io:query timed out,vger.kernel.org:query timed out]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 255E672F838

Hi,

=E5=9C=A8 2026/7/9 14:09, Christoph Hellwig =E5=86=99=E9=81=93:
> On Sun, Jul 05, 2026 at 03:51:07AM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai@fygo.io>
>>
>> This RFC moves queue-local blkg topology synchronization from
>> q->queue_lock to q->blkcg_mutex.
>>
>> q->queue_lock is a hot block-layer spinlock used by request queue runtim=
e
>> paths,
> I don't think it is hot any more.  If it is in one of your workloads
> we have a deep problem somewhere.  That being said, futher removing
> uses of his old catch-all lock is always good, hopefully we can
> eventually remove it entirely.
>
> So this series looks great to me conceptually, but I'm unfortunately
> not a very qualified reviewer for the blk-cgroup code.

Thanks a lot for taking a look at this RFC set, it's very helpful.

It's true that blk-cgroup review is not active for a long time. I'd like to
help but I really don't have time to check every block layer patches.

>
--=20
Thanks,
Kuai

