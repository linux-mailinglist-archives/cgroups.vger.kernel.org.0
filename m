Return-Path: <cgroups+bounces-17602-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M4bQEhdvT2qQggIAu9opvQ
	(envelope-from <cgroups+bounces-17602-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 11:51:19 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B7E72F230
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 11:51:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fygo-io.20200929.dkim.larksuite.com header.s=s1 header.b=PqNfl6kf;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=fygo.io (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17602-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17602-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DD43305098C
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2026 09:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E05403AE1;
	Thu,  9 Jul 2026 09:50:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from va-2-16.ptr.blmpb.com (va-2-16.ptr.blmpb.com [209.127.231.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B0E401A02
	for <cgroups@vger.kernel.org>; Thu,  9 Jul 2026 09:50:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590612; cv=none; b=GyAA1GdxbxkzHyJt4RFR8bfB+B3j/YY4O7kxRNE0qC0AyHnHYy2HOPJAxjej7YuscuJ/FGwOdDAOxi2can5Ss2/PRq/m5hnkbZaQ8po4etf5xwrKhxQCk3js2JyVTGTNpzTV2JKNWi4tA4ciY0V8aeZAjGZj+xCQlOUe9wooEoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590612; c=relaxed/simple;
	bh=rxSgwuGzIsEmyghbrvFjO2zv/MUWNeA+OR1hBhENbho=;
	h=Subject:Message-Id:Date:References:To:Cc:Mime-Version:In-Reply-To:
	 From:Content-Type; b=QIj1wL55D87SYXOes9wSJg5YGwsdS/gznq5DHY42jnqZlZbHkULz23U7p4/+ITjN43IcKnB7ufg4FH7entM9HNTEnH89gnV9MUOKpCvHbirMffp/N7EFBcyJpCZ92eKxukHer+umGNLpajmDQI6BWF75EfKfFUcay8E7lDnL1dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=PqNfl6kf; arc=none smtp.client-ip=209.127.231.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1783590593;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=rxSgwuGzIsEmyghbrvFjO2zv/MUWNeA+OR1hBhENbho=;
 b=PqNfl6kfcb7YydGxqmviNJtpbNIlE+Ie3+/dqo8uPbB4Pt6mk2zLIOxjC0WRw/gmcqeULc
 /gv/f7DHOmRX3g9ssWUL1aOR3+reHH/J1M5KHdaicddbPsYGO4eHcXwuGorpZm89JW1gH7
 vTWEf+45x74R9YH0wYw2/h2AbDf1jK03pFXZ9Z8TxG3WJ6ZQPCFazb6ZV0NQghPKVVu6V2
 9JkJMdStsk77hRJAdU0Jk+I67Fuw3/XYgcceCVvwoYSwor1OVDmfiYFs64HZwOp2bXLSoM
 YemL4DCzmLsex12QdK40QQVemyfhb872Mh71fF7rOFjIFTaS4UFI6Jr+8CJkzA==
Subject: Re: [RFC PATCH v1 05/17] block: add bio_alloc_atomic() for atomic bio users
Message-Id: <1bf1939e-6a7b-4a8d-a316-96812cd6924e@fygo.io>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 9 Jul 2026 17:49:47 +0800
References: <20260704195124.1375075-1-yukuai@kernel.org> <20260704195124.1375075-6-yukuai@kernel.org> <20260709061207.GC16504@lst.de>
Received: from [192.168.1.104] ([39.182.0.144]) by smtp.larksuite.com with ESMTPS; Thu, 09 Jul 2026 09:49:52 +0000
X-Original-From: yu kuai <yukuai@fygo.io>
Reply-To: yukuai@fygo.io
To: "Christoph Hellwig" <hch@lst.de>, "yu kuai" <yukuai@fygo.io>
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
	<dm-devel@lists.linux.dev>, 
	"linux-bcache@vger.kernel.org Joseph Qi" <joseph.qi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260709061207.GC16504@lst.de>
From: "yu kuai" <yukuai@fygo.io>
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26a4f6ec1+0320de+vger.kernel.org+yukuai@fygo.io>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[fygo.io : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[fygo-io.20200929.dkim.larksuite.com:s=s1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17602-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[yukuai@fygo.io,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:yukuai@fygo.io,m:axboe@kernel.dk,m:tj@kernel.org,m:kbusch@kernel.org,m:sagi@grimberg.me,m:agk@redhat.com,m:bmarzins@redhat.com,m:snitzer@kernel.org,m:mpatocka@redhat.com,m:dongsheng.yang@linux.dev,m:cengku@gmail.com,m:colyli@fygo.io,m:kent.overstreet@linux.dev,m:josef@toxicpanda.com,m:nilay@linux.ibm.com,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:dm-devel@lists.linux.dev,m:joseph.qi@linux.alibaba.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,grimberg.me,redhat.com,linux.dev,gmail.com,fygo.io,toxicpanda.com,linux.ibm.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,linux.alibaba.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,fygo.io:from_mime,fygo.io:replyto,fygo.io:mid,fygo.io:email,fygo-io.20200929.dkim.larksuite.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72B7E72F230

Hi,

=E5=9C=A8 2026/7/9 14:12, Christoph Hellwig =E5=86=99=E9=81=93:
> On Sun, Jul 05, 2026 at 03:51:12AM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai@fygo.io>
>>
>> Add bio_alloc_atomic() for callers that need a GFP_ATOMIC bio from the
>> default bio set but cannot safely pass a bdev during allocation. The
>> helper returns an unattached bio, leaving callers to set bi_bdev and
>> attach blkcg state explicitly before submission.
>>
>> Use the helper for virtio-pmem flush child bios and OCFS2 heartbeat I/O.
>> Both allocate bios from atomic paths and must avoid creating missing blk=
gs
>> once blkg creation is protected by q->blkcg_mutex. virtio-pmem clones th=
e
>> parent bio's blkg association; OCFS2 binds heartbeat I/O to the root blk=
g.
> Let's kill off the concept of atomic bio allocations instead.
> Joseph already has an outstanding patch for nd_virtio that needs a little
> bit more work, and ocfs2 should be easy enough as well.

Thanks for the notice and good to hear that. This will make this set much
simpler.

>
--=20
Thanks,
Kuai

