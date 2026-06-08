Return-Path: <cgroups+bounces-16691-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wepACFU8JmobTwIAu9opvQ
	(envelope-from <cgroups+bounces-16691-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 05:51:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9566E652824
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 05:51:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=l79LEIS4;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16691-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16691-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EABB300F9EB
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 03:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CF134B682;
	Mon,  8 Jun 2026 03:42:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035FA2820AC;
	Mon,  8 Jun 2026 03:42:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780890177; cv=none; b=D/YvMmxzRDKqABsfJ42VB5gZlInjIMvDHClLhIRlPYxZHvzMFENhzaKSlyyYt+pMSCQ1NBj7eQyAYs0hL/0W1vIfJ5G8ytHcKVI3COFdHH8jFefOka6mf9z6W4PLgZqdLADUjIRbh/bwwlO3675xYkU0Izm5BhHAotVBzjBkORs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780890177; c=relaxed/simple;
	bh=rMpDG54GJiZEqBgIXe2Jnd/jal4BcLX2TvvSY7AtWtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X9HCpJT95GgKI7seflh5kpEyfLABt8/iyTyTrjqg0eglpbSHGJA8c78JV8cd29ES/jZZo5w7bgi6bEWVsk6YG/sczuHGz/a43gUIegsaWb+6vBSI1tvluQkOJWQsvlTDbOzVCGVj3GejWJrnB07/6jxVbGB4FlpFuwPS9Cb47zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l79LEIS4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F58A1F00893;
	Mon,  8 Jun 2026 03:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780890176;
	bh=kTfnsBWKWstk18ZI7HL6+/xILjAyO2gIFYcndqvX6qQ=;
	h=From:To:Cc:Subject:Date;
	b=l79LEIS4XhbNdoLkkK3F0lXimfDS8dnD5BMItZVYJottxcS1M8KxguF1uQxNctd+B
	 tADht0NE86tZ1vit4SMnac6zRD9AE9aamVouDK2C/0VrLC6WH+xVe0jfG5kDChoVTN
	 Iaoq9WDdCAuGAAHCtWIV0DO9ziDyz1SfVsRTH5Rn55KdhuiO3Bocijgg5KhCk/S/ap
	 ZUPLcEexYFBjSVFZvMEHtRetNnNbLAvK7ILzXYuc9czKHTVXgVYxI0Ab+kVf8n/8fe
	 Jk+oYHurZxt5mSXeh/bsihd34n3nIpuWd1x2FtDoeVw44z8nIlTMw+uyY2wV9dU6NF
	 lb0ZokElT9e9g==
From: Yu Kuai <yukuai@kernel.org>
To: nilay@linux.ibm.com,
	tom.leiming@gmail.com,
	bvanassche@acm.org,
	tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	yukuai@fygo.io
Cc: akpm@linux-foundation.org,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	youngjun.park@lge.com,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/8] blk-cgroup: remove queue_lock nesting from blkcg paths
Date: Mon,  8 Jun 2026 11:42:41 +0800
Message-ID: <cover.1780621988.git.yukuai@fygo.io>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: add header
X-Spamd-Result: default: False [9.34 / 15.00];
	URIBL_BLACK(7.50)[fygo.io:mid,fygo.io:email];
	SUSPICIOUS_RECIPS(1.50)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[yukuai@kernel.org,cgroups@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-16691-lists,cgroups=lfdr.de];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20260515];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:nilay@linux.ibm.com,m:tom.leiming@gmail.com,m:bvanassche@acm.org,m:tj@kernel.org,m:josef@toxicpanda.com,m:axboe@kernel.dk,m:yukuai@fygo.io,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:kasong@tencent.com,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:bhe@redhat.com,m:baohua@kernel.org,m:youngjun.park@lge.com,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:tomleiming@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux.ibm.com,gmail.com,acm.org,kernel.org,toxicpanda.com,kernel.dk,fygo.io];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,tencent.com,huaweicloud.com,gmail.com,redhat.com,lge.com,vger.kernel.org,kvack.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@kernel.org,cgroups@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,fygo.io:mid,fygo.io:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9566E652824
X-Spam: Yes

From: Yu Kuai <yukuai@fygo.io>

Hi,

This series is the follow-up blk-cgroup locking cleanup on top of the
earlier blkg-list protection fixes, and prepares blk-cgroup to stop using
q->queue_lock as the global blkg lifetime/iteration lock.

The current queue_lock based protection is hard to maintain because
queue_lock is used from hardirq and softirq completion paths, while some
blkcg cgroup file paths also need to iterate blkgs, print policy data, or
create blkgs from RCU-protected contexts.  This series first tightens the
blkcg-side lifetime rules:

- blkcg_print_stat() iterates blkgs under blkcg->lock with IRQs disabled.
- policy data freeing is delayed past an RCU grace period.
- blkcg_print_blkgs(), blkg lookup/create, bio association, page-IO
  association, blkg destruction, and BFQ initialization stop nesting
  queue_lock under RCU or blkcg->lock.

Using blkcg->lock and RCU for blkcg-owned lists/data keeps the lock order
local to blk-cgroup and avoids extending queue_lock into cgroup file
iteration paths.  It also makes the subsequent conversion to q->blkcg_mutex
possible without carrying forward queue_lock's interrupt-context
constraints.

Yu Kuai (8):
  blk-cgroup: protect iterating blkgs with blkcg->lock in
    blkcg_print_stat()
  blk-cgroup: delay freeing policy data after rcu grace period
  blk-cgroup: don't nest queue_lock under rcu in blkcg_print_blkgs()
  blk-cgroup: don't nest queue_lock under rcu in blkg_lookup_create()
  blk-cgroup: don't nest queue_lock under rcu in bio_associate_blkg()
  blk-cgroup: don't nest queue_lock under blkcg->lock in
    blkcg_destroy_blkgs()
  mm/page_io: don't nest queue_lock under rcu in
    bio_associate_blkg_from_page()
  block, bfq: don't grab queue_lock to initialize bfq

 block/bfq-cgroup.c        |  17 ++++-
 block/bfq-iosched.c       |   5 --
 block/blk-cgroup-rwstat.c |  15 ++--
 block/blk-cgroup.c        | 151 ++++++++++++++++++++++----------------
 block/blk-cgroup.h        |   8 +-
 block/blk-iocost.c        |  22 ++++--
 block/blk-iolatency.c     |  10 ++-
 block/blk-throttle.c      |  13 +++-
 mm/page_io.c              |   7 +-
 9 files changed, 158 insertions(+), 90 deletions(-)


base-commit: b23df513de562739af61fa61ba80ef5e8059a636
-- 
2.51.0

