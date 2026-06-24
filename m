Return-Path: <cgroups+bounces-17222-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0/eqNSGCO2r5YwgAu9opvQ
	(envelope-from <cgroups+bounces-17222-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 09:07:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E22D6BC046
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 09:07:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fygo-io.20200929.dkim.larksuite.com header.s=s1 header.b=nqHx9nB6;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17222-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17222-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=fygo.io (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D926C304725F
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 06:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7535389E05;
	Wed, 24 Jun 2026 06:56:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from va-2-58.ptr.blmpb.com (va-2-58.ptr.blmpb.com [209.127.231.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633A138A73F
	for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 06:56:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782284171; cv=none; b=lJYu4B4we9QBGCSoLu0niGnriTqwe07KUYHKcHtuWUBQuR3omBzZJLnmhC1Guqx21sbtgHmpDshEnZr1OzxVYrH3C1dWZI62tQwp+l/A6d/Jws51uC/X+wnrfYbBpTRvtYq/QnCETa3/pwkvhrXRyr1Ms8z6yV2NpJXB4zV3zGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782284171; c=relaxed/simple;
	bh=XvCPrJWKdLdlYov3Sh7q1/9+eldMQc6A62fSz0sYeVI=;
	h=From:Subject:To:References:In-Reply-To:Content-Type:Cc:Date:
	 Message-Id:Mime-Version; b=LDmk7eDQdwQk+2OmQ+7tyfc700EtLNs3IIA82chR73ZEFE0H1ZDEe2MH2Rs9gnEQLErTMjgZcorJk1ppILM23okX6PFc4gy9B+QWQu4BIEtQujtR8B7bHVWmhK1Bz2pk2yfi0MMU0iF3TKw+aeWhmqJkaWkg1AkoAE7fkBSdhJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=nqHx9nB6; arc=none smtp.client-ip=209.127.231.58
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1782284165;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=2n4xYMnOuMUY1cMr3fiqxiefs2pC62hsUTAG2Mk/2QU=;
 b=nqHx9nB63nR2AZAdZxqy9gHsxFaroRQxoRGQXge6wAKC5R/QoQxQX2Ll2eXQ3XElp2W2zE
 minU8LrUPIEOCyjGVgqPLuoVz2zFSNZMyjRUBYIzp1gtp6QAuKUzfa7ihg/NanbJR7cdxt
 rmPAaxLgcRAPkGZtWDOMmI61f25hTNQzOrzo/VRQ8Y1bsi39usZ1rM3Rbw/Ckee0D03KPj
 CKTbCFcGTdzje3fNOJ13sGG8bgsbJKGmNTiMfRRC86EK/7IvW+j5cegGsje8FvUl5LRL7f
 CvwqkAT2pQMizWPdmi5QmbQWoAF7Do8vbKZEsE/Hf+dMoTiE6Xx379MDEFNtMw==
From: "yu kuai" <yukuai@fygo.io>
Subject: Re: [PATCH 1/2] md/linear: add fault-tolerant mode for unraid-like setups
User-Agent: Mozilla Thunderbird
Received: from [192.168.1.104] ([39.182.0.148]) by smtp.larksuite.com with ESMTPS; Wed, 24 Jun 2026 06:56:03 +0000
X-Lms-Return-Path: <lba+26a3b7f84+f5c9df+vger.kernel.org+yukuai@fygo.io>
To: "Yu Kuai" <yukuai@kernel.org>, "Tejun Heo" <tj@kernel.org>, 
	"Josef Bacik" <josef@toxicpanda.com>, "Jens Axboe" <axboe@kernel.dk>
References: <20260624064625.1743650-1-yukuai@kernel.org>
In-Reply-To: <20260624064625.1743650-1-yukuai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Original-From: yu kuai <yukuai@fygo.io>
Reply-To: yukuai@fygo.io
Cc: "Zheng Qixing" <zhengqixing@huawei.com>, 
	"Christoph Hellwig" <hch@lst.de>, "Tang Yizhou" <yizhou.tang@shopee.com>, 
	"Nilay Shroff" <nilay@linux.ibm.com>, "Ming Lei" <ming.lei@redhat.com>, 
	<cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <yukuai@fygo.io>
Date: Wed, 24 Jun 2026 14:55:58 +0800
Message-Id: <fdd769ae-5854-41cd-a7ff-5cfa888b9a13@fygo.io>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Rspamd-Action: add header
X-Spamd-Result: default: False [9.34 / 15.00];
	URIBL_BLACK(7.50)[fygo.io:replyto,fygo.io:mid,fygo.io:from_mime];
	DMARC_POLICY_QUARANTINE(1.50)[fygo.io : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	MV_CASE(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:yukuai@kernel.org,m:tj@kernel.org,m:josef@toxicpanda.com,m:axboe@kernel.dk,m:zhengqixing@huawei.com,m:hch@lst.de,m:yizhou.tang@shopee.com,m:nilay@linux.ibm.com,m:ming.lei@redhat.com,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yukuai@fygo.io,s:lists@lfdr.de];
	R_DKIM_ALLOW(0.00)[fygo-io.20200929.dkim.larksuite.com:s=s1];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[yukuai@fygo.io,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17222-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[fygo-io.20200929.dkim.larksuite.com:+];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fygo.io,cgroups@vger.kernel.org];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	HAS_REPLYTO(0.00)[yukuai@fygo.io];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,fygo-io.20200929.dkim.larksuite.com:dkim,fnnas.com:email,fygo.io:replyto,fygo.io:mid,fygo.io:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E22D6BC046
X-Spam: Yes

Hi,

Please ignore this patch, this patch is supposed only used downstream.
Ai somehow generate the cmd to send it together with the patchset:

blk-cgroup: fix blkg list and policy data races

Same for the other ext4 patch.

Sorry for the noise. :(

=E5=9C=A8 2026/6/24 14:46, Yu Kuai =E5=86=99=E9=81=93:
> From: Yu Kuai<yukuai@fnnas.com>
>
> Add a module parameter 'fault_tolerant' that changes how md-linear
> handles disk failures. When enabled:
>
> - Disk failures are isolated instead of failing the entire array
> - I/O to failed disks returns -EIO while healthy disks continue
> - The array remains operational with reduced capacity
> - Failed disk count is tracked and shown in /proc/mdstat
>
> This enables unraid-like functionality where individual disk failures
> don't bring down the entire array, allowing continued access to data
> on healthy disks.
>
> The fault_tolerant parameter can be set at module load time or
> dynamically via /sys/module/md_linear/parameters/fault_tolerant.
>
> Signed-off-by: Yu Kuai<yukuai@fnnas.com>
> ---
>   drivers/md/md-linear.c | 63 ++++++++++++++++++++++++++++++++++++------
>   1 file changed, 55 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c

--=20
Thanks,
Kuai

