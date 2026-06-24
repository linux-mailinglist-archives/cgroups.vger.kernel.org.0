Return-Path: <cgroups+bounces-17223-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XzxMOhyCO2r1YwgAu9opvQ
	(envelope-from <cgroups+bounces-17223-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 09:07:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C256BC036
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 09:07:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fygo-io.20200929.dkim.larksuite.com header.s=s1 header.b=ko+peYdW;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17223-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17223-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=fygo.io (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A2A3303B6D6
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 06:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976DF38BF70;
	Wed, 24 Jun 2026 06:58:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from va-2-49.ptr.blmpb.com (va-2-49.ptr.blmpb.com [209.127.231.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB84B38A726
	for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 06:58:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782284298; cv=none; b=RK2XQ938IM4W9deEEZXrAB6d78il9oO1sdJt1DiCwpCGWPaJcYIDstw0iEFw71+lS6FauNuJk4lcXhHMajbWhqbEIXmKtGUalrOyU6MwsrZW9eng/JQ6Yg758mjNutA0YRIVfJ8QDN/1GnD+2bIerlTTDBBTXQhQy2vzsvO9IsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782284298; c=relaxed/simple;
	bh=rJseISap9xBx1TIEdDPlKtfLclHaCWHTrvJEL4F1BII=;
	h=To:Cc:References:Subject:In-Reply-To:Date:Message-Id:Mime-Version:
	 From:Content-Type; b=ehOz8i8DfNX+k0t4AiTkJdGt1ELqgm63PLW/eWZVSmnceR8aEIk7Ug+TNfaVipla2N4yQcpHm1jBwu/U/G408UfAgoirbwd6gxKLloONdhuO6whY5OlyIn+t9k/isy35BcujrRByCUfqa53htv8YbvewmcN2AO5XnIPmJmfwkVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=ko+peYdW; arc=none smtp.client-ip=209.127.231.49
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1782284286;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=FMKsX1oqr9cJS0GXtzM8Ok+fkwH2kagCOdyTihBZHlM=;
 b=ko+peYdWhkBC6Z2+M+DAnl+DHsw7wlKUYcGNSanD0QdqHL8kOGNHfy5JdHfFOLwBitSHLK
 EK6pLRNFI2Ud7COX476laUs/Yn9twDwM6BzwU5ay+45/RPsZvLd2zVcfwbj3e8/Oh8o6Qh
 51b1/iIv5qImhJBjy9SAtaeR3IiSjddbeFzYvyuiv9VOVVgPqb8e0c6pncmMnr8S7IziS1
 bRaHq/Eeyn+vdDxSEw1TIBPEMAo4KrGVeqjBoeJepRYhI8QA0h9N/pIA84fxdaAnw/4KBM
 RdiUXkYUQnjnDCgCUCNCg2y4JhTuJcX8KFuo5Ck1jX6/L9Z0UVAbsh/6OJ/rQw==
To: "Yu Kuai" <yukuai@kernel.org>, <nilay@linux.ibm.com>, 
	<tom.leiming@gmail.com>, <bvanassche@acm.org>, <tj@kernel.org>, 
	<josef@toxicpanda.com>, <axboe@kernel.dk>
Cc: <akpm@linux-foundation.org>, <chrisl@kernel.org>, <kasong@tencent.com>, 
	<shikemeng@huaweicloud.com>, <nphamcs@gmail.com>, <bhe@redhat.com>, 
	<baohua@kernel.org>, <youngjun.park@lge.com>, <cgroups@vger.kernel.org>, 
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <yukuai@fygo.io>
References: <cover.1780621988.git.yukuai@fygo.io>
Content-Transfer-Encoding: quoted-printable
Reply-To: yukuai@fygo.io
Subject: Re: [PATCH 0/8] blk-cgroup: remove queue_lock nesting from blkcg paths
X-Lms-Return-Path: <lba+26a3b7ffd+6e4f90+vger.kernel.org+yukuai@fygo.io>
In-Reply-To: <cover.1780621988.git.yukuai@fygo.io>
Date: Wed, 24 Jun 2026 14:57:59 +0800
Message-Id: <1c739fcc-5132-4cb2-bf34-cec94de26509@fygo.io>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: yu kuai <yukuai@fygo.io>
From: "yu kuai" <yukuai@fygo.io>
Received: from [192.168.1.104] ([39.182.0.148]) by smtp.larksuite.com with ESMTPS; Wed, 24 Jun 2026 06:58:04 +0000
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Action: add header
X-Spamd-Result: default: False [10.84 / 15.00];
	URIBL_BLACK(7.50)[fygo.io:replyto,fygo.io:email,fygo.io:mid,fygo.io:from_mime];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_QUARANTINE(1.50)[fygo.io : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	MV_CASE(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:yukuai@kernel.org,m:nilay@linux.ibm.com,m:tom.leiming@gmail.com,m:bvanassche@acm.org,m:tj@kernel.org,m:josef@toxicpanda.com,m:axboe@kernel.dk,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:kasong@tencent.com,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:bhe@redhat.com,m:baohua@kernel.org,m:youngjun.park@lge.com,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:yukuai@fygo.io,m:tomleiming@gmail.com,s:lists@lfdr.de];
	R_DKIM_ALLOW(0.00)[fygo-io.20200929.dkim.larksuite.com:s=s1];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,linux.ibm.com,gmail.com,acm.org,toxicpanda.com,kernel.dk];
	FORGED_SENDER(0.00)[yukuai@fygo.io,cgroups@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17223-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_SOME(0.00)[];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fygo-io.20200929.dkim.larksuite.com:+];
	HAS_REPLYTO(0.00)[yukuai@fygo.io];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fygo.io,cgroups@vger.kernel.org];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,tencent.com,huaweicloud.com,gmail.com,redhat.com,lge.com,vger.kernel.org,kvack.org,fygo.io];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fygo.io:replyto,fygo.io:email,fygo.io:mid,fygo.io:from_mime,fygo-io.20200929.dkim.larksuite.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40C256BC036
X-Spam: Yes

Friendly ping ...

This set can still be applied cleanly for block-7.2 branch.

=E5=9C=A8 2026/6/8 11:42, Yu Kuai =E5=86=99=E9=81=93:
> From: Yu Kuai <yukuai@fygo.io>
>
> Hi,
>
> This series is the follow-up blk-cgroup locking cleanup on top of the
> earlier blkg-list protection fixes, and prepares blk-cgroup to stop using
> q->queue_lock as the global blkg lifetime/iteration lock.
>
> The current queue_lock based protection is hard to maintain because
> queue_lock is used from hardirq and softirq completion paths, while some
> blkcg cgroup file paths also need to iterate blkgs, print policy data, or
> create blkgs from RCU-protected contexts.  This series first tightens the
> blkcg-side lifetime rules:
>
> - blkcg_print_stat() iterates blkgs under blkcg->lock with IRQs disabled.
> - policy data freeing is delayed past an RCU grace period.
> - blkcg_print_blkgs(), blkg lookup/create, bio association, page-IO
>    association, blkg destruction, and BFQ initialization stop nesting
>    queue_lock under RCU or blkcg->lock.
>
> Using blkcg->lock and RCU for blkcg-owned lists/data keeps the lock order
> local to blk-cgroup and avoids extending queue_lock into cgroup file
> iteration paths.  It also makes the subsequent conversion to q->blkcg_mut=
ex
> possible without carrying forward queue_lock's interrupt-context
> constraints.
>
> Yu Kuai (8):
>    blk-cgroup: protect iterating blkgs with blkcg->lock in
>      blkcg_print_stat()
>    blk-cgroup: delay freeing policy data after rcu grace period
>    blk-cgroup: don't nest queue_lock under rcu in blkcg_print_blkgs()
>    blk-cgroup: don't nest queue_lock under rcu in blkg_lookup_create()
>    blk-cgroup: don't nest queue_lock under rcu in bio_associate_blkg()
>    blk-cgroup: don't nest queue_lock under blkcg->lock in
>      blkcg_destroy_blkgs()
>    mm/page_io: don't nest queue_lock under rcu in
>      bio_associate_blkg_from_page()
>    block, bfq: don't grab queue_lock to initialize bfq
>
>   block/bfq-cgroup.c        |  17 ++++-
>   block/bfq-iosched.c       |   5 --
>   block/blk-cgroup-rwstat.c |  15 ++--
>   block/blk-cgroup.c        | 151 ++++++++++++++++++++++----------------
>   block/blk-cgroup.h        |   8 +-
>   block/blk-iocost.c        |  22 ++++--
>   block/blk-iolatency.c     |  10 ++-
>   block/blk-throttle.c      |  13 +++-
>   mm/page_io.c              |   7 +-
>   9 files changed, 158 insertions(+), 90 deletions(-)
>
>
> base-commit: b23df513de562739af61fa61ba80ef5e8059a636

--=20
Thanks,
Kuai

