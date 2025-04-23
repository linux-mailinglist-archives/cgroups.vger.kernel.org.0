Return-Path: <cgroups+bounces-7742-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE493A97E27
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 07:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41D0189D4A1
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 05:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC32266B45;
	Wed, 23 Apr 2025 05:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ozq8rPrJ"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2EA2CCC1;
	Wed, 23 Apr 2025 05:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745386702; cv=none; b=oYgtIWj4BsUksjCtxhpDjiHeJFyh2qWvBb7w05DjQsUUhdcuOUm7RzEKlAhbRlzrHva2B8sPqez5i4mzo3RxFN7VDb92uTeOJdpHBc3iC9on229r4TbCaoqOsJJeeSBqqiUah6xj3chAIfU5hFLN3Bpo6m/hdsGrdL8s/u0iWAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745386702; c=relaxed/simple;
	bh=AzheXuJBXxxudUO5065ex5Pt1V6JnY028W7xqCA0flw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUipGqDrtKDc+UA2PjuuQ7zvxXOlbuDHixrQWdQ0dVKF5z+p1yAVE9EXup7z/AgYelpO7ojJy3FDE72HOZZqW/ThjS1H/lsBMAhSINBcUGkLe4kepveAZuqmQrrOd7GP1e0lwgkuaIRNmZzXVGEOBngu26XaBTs/+35DrZQ8pX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ozq8rPrJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BUFr9qLSTTGKwaOj07n+NPV/OA24/rHJe+kg0XMFt2Y=; b=ozq8rPrJsdmM++/CdhEVnjzt+J
	q97IMm9VAGl5DUh8ApyyspgQGLX4j3VBy2ajiZtkiERyqYNq5iIKEKBjSDXE0OPW3VSnNMO7JJhpE
	uj2I1TLRSOgrcPuu0Wa8JfowyC8R/9KIYow5a4+cWo1V2ZysNwWsrNM99misjPg5IeVKJcUm8Ckxn
	ZDbFnWRZzM7eMwrLGZ/pBrGdAywwMZLv5MVuq0JwkL7xzbljL5+OQZglR+CBsckhH6YVD8EQI7Z8s
	HezTp+gCu5sbR+2TEMZDhiri3YEt/DXEqSx4o0bCccaNTocP+7SsBZViApoYCM1xWqfka92ivIyzT
	pRnaUyHg==;
Received: from 2a02-8389-2341-5b80-c0c9-6b8d-e783-b2cd.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:c0c9:6b8d:e783:b2cd] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7SoN-00000009Fld-2v2l;
	Wed, 23 Apr 2025 05:38:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <christian@brauner.io>,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [PATCH 2/4] block: remove the backing_inode variable in bdev_statx
Date: Wed, 23 Apr 2025 07:37:40 +0200
Message-ID: <20250423053810.1683309-3-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250423053810.1683309-1-hch@lst.de>
References: <20250423053810.1683309-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

backing_inode is only used once, so remove it and update the comment
describing the bdev lookup to be a bit more clear.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bdev.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 6a34179192c9..1af9ed054f45 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1274,18 +1274,15 @@ void sync_bdevs(bool wait)
  */
 void bdev_statx(const struct path *path, struct kstat *stat, u32 request_mask)
 {
-	struct inode *backing_inode;
 	struct block_device *bdev;
 
-	backing_inode = d_backing_inode(path->dentry);
-
 	/*
-	 * Note that backing_inode is the inode of a block device node file,
-	 * not the block device's internal inode.  Therefore it is *not* valid
-	 * to use I_BDEV() here; the block device has to be looked up by i_rdev
+	 * Note that d_backing_inode() returns the block device node inode, not
+	 * the block device's internal inode.  Therefore it is *not* valid to
+	 * use I_BDEV() here; the block device has to be looked up by i_rdev
 	 * instead.
 	 */
-	bdev = blkdev_get_no_open(backing_inode->i_rdev);
+	bdev = blkdev_get_no_open(d_backing_inode(path->dentry)->i_rdev);
 	if (!bdev)
 		return;
 
-- 
2.47.2


