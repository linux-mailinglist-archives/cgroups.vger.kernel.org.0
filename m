Return-Path: <cgroups+bounces-2224-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 543EB88FA2A
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 09:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57FF1F28CFF
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 08:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FA754792;
	Thu, 28 Mar 2024 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vl56bq/y"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8BC5C03D;
	Thu, 28 Mar 2024 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615327; cv=none; b=Pe0Jsm81NB3HawloL0WxroVdtgz999YW3R2xo+wRbj2yeMaBBmul5UOBFLxZv/g/DOsYGoYW1+Zva1cYixFipsaSpknxnUpSyLc7bnqXwdM/mHBMV6nY/Obd9L/cspqn74t0xzs6E+I0srahRqei1t1zwxIUBbUX2kcdm2HHDH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615327; c=relaxed/simple;
	bh=8M3GxQPUyLUxjAwwXndanux8udwFeG8JZHWVg430Apw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hwVqy6LL5XO578R7m8kaL2JdMnMX273MhUw23LozbicsdoRV6oYPuknBXnn7XlQ0r3P7LI970qsbWTxQa9kJ6lgJ0r3cTJC+xlfRK1RHjjmJf4HXj7BING3XV+fiHpH64awM40Tl39Uggwv9djdlbth41TF6TaoiRnK6CTGhWx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vl56bq/y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fXHISAOEqyN5FdmfkiPDC8bWd7+CVdd3fymmC0CdPSM=; b=vl56bq/yRL7KQFs/q+ygEbCPzS
	yAkxUV1dovc+R0o+SIwwAzeXp/W2cZGOAlkfTMhLD+nMJdApw8tG0pQeO5nCdTuRbsgEXxuUffIZS
	DqMZQjuQfFBMCdTugu1JC69vtjD327Qfhi8CK+H4gL9v3THvHnqE4ZSntr/ISM6ZUg4bjl2HqSbhS
	uWN2RHTs0vH4GSMqVWMU/iEw/52UvRiHg8a0lHYjpHy+TaZHn8aHPEwRySr9ckW2pQEfEjsyQpO8F
	up1VxJMJPJG/WKSGCU6mbyiDTYWjJLW8eER/zGdO+fClVw881/tqOGmO20bh/18z3PWnizJpAJhP/
	ARB7t8YA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplKl-0000000D7bF-1anp;
	Thu, 28 Mar 2024 08:42:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Matthew Sakai <msakai@redhat.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	dm-devel@lists.linux.dev,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs use bio_list_merge_init
Date: Thu, 28 Mar 2024 09:41:47 +0100
Message-Id: <20240328084147.2954434-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328084147.2954434-1-hch@lst.de>
References: <20240328084147.2954434-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Use bio_list_merge_init instead of open coding bio_list_merge and
bio_list_init.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 6f4a9cfeea44a3..831fac45e70f7d 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -331,12 +331,11 @@ static void steal_rbio(struct btrfs_raid_bio *src, struct btrfs_raid_bio *dest)
 static void merge_rbio(struct btrfs_raid_bio *dest,
 		       struct btrfs_raid_bio *victim)
 {
-	bio_list_merge(&dest->bio_list, &victim->bio_list);
+	bio_list_merge_init(&dest->bio_list, &victim->bio_list);
 	dest->bio_list_bytes += victim->bio_list_bytes;
 	/* Also inherit the bitmaps from @victim. */
 	bitmap_or(&dest->dbitmap, &victim->dbitmap, &dest->dbitmap,
 		  dest->stripe_nsectors);
-	bio_list_init(&victim->bio_list);
 }
 
 /*
-- 
2.39.2


