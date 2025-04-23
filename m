Return-Path: <cgroups+bounces-7743-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68640A97E28
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 07:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9932517DDCC
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 05:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EB526657C;
	Wed, 23 Apr 2025 05:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZT/6Myg9"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FC02580CB;
	Wed, 23 Apr 2025 05:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745386706; cv=none; b=JH2eIH2UaCWL4L/RxPwVgCl6MRG6WJr/csu18nYFJlx2MsuIRhhaIofz01a5Q4hB7qrI+dEBeYAfYkFexX6kFZQHiuD42buUYVkeK5C1FzHwuKpjdG7LQwF5vxGSf9JE6kCjVlCyBoJr5cOm/XeGrGjNTYzEiBFsPExNv9c9lAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745386706; c=relaxed/simple;
	bh=bQXt9tTTfn0lTBs4i/XmI7UGePw4Mz+jxJeaNJEodtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kbqbw5ujAYiEfqB90P/pWeYSv6BOUyopX+hZbFl+46NkkCxcRLyrM7oH78ZO9nsMo8laDR3i4hvl4s1qCOVMI+oZ/f+4E5ObO0y+U093wY993iS+DpvWU2FgBJ9Ki1iRxFgPWiJF73Kl7zq4LayzE2UHX+6P6swiUvg1S5oy7Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZT/6Myg9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=QOA+YnWZjtHQG64yWNDkLGcaU2terFnG+8odepHXDTA=; b=ZT/6Myg9rM5gzJ+fUXdu1mVaWB
	usjtXjg2P4yBgVraZJyC7CyvbAb8CDuWDvVwDuf+10SPkRWaRSNtv4g9UA4qNjjEunUNxIc6oPRPY
	ItH8iWi5D3kGWc6xf0KcTz+kMrbrwvVMjHDruMLMic6VoUN4L2vi6i+UqOZCs5MoHf34gSBRhOXtR
	/cDGBCdHWyrlBQ9PjjBjLe8YRc4jbV1FbZY/kuUQI3eYk3svuYEY9n4LAJFQlRzUSd5UsDV4PS3jt
	JZohO9SG/ex3293MKKSOHg/1vCLCME0FW+YqlNe3tKTFC5QyO6xrA5s4hcUCWVlogBZYW21yTyr/U
	5cYlJz5A==;
Received: from 2a02-8389-2341-5b80-c0c9-6b8d-e783-b2cd.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:c0c9:6b8d:e783:b2cd] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7SoR-00000009Fln-1b4T;
	Wed, 23 Apr 2025 05:38:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <christian@brauner.io>,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [PATCH 3/4] block: don't autoload drivers on stat
Date: Wed, 23 Apr 2025 07:37:41 +0200
Message-ID: <20250423053810.1683309-4-hch@lst.de>
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

blkdev_get_no_open can trigger the legacy autoload of block drivers.  A
simple stat of a block device has not historically done that, so disable
this behavior again.

Fixes: 9abcfbd235f5 ("block: Add atomic write support for statx")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bdev.c       | 8 ++++----
 block/blk-cgroup.c | 2 +-
 block/blk.h        | 2 +-
 block/fops.c       | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 1af9ed054f45..3ebad8e953e1 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -777,13 +777,13 @@ static void blkdev_put_part(struct block_device *part)
 	blkdev_put_whole(whole);
 }
 
-struct block_device *blkdev_get_no_open(dev_t dev)
+struct block_device *blkdev_get_no_open(dev_t dev, bool autoload)
 {
 	struct block_device *bdev;
 	struct inode *inode;
 
 	inode = ilookup(blockdev_superblock, dev);
-	if (!inode && IS_ENABLED(CONFIG_BLOCK_LEGACY_AUTOLOAD)) {
+	if (!inode && autoload && IS_ENABLED(CONFIG_BLOCK_LEGACY_AUTOLOAD)) {
 		blk_request_module(dev);
 		inode = ilookup(blockdev_superblock, dev);
 		if (inode)
@@ -1005,7 +1005,7 @@ struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 	if (ret)
 		return ERR_PTR(ret);
 
-	bdev = blkdev_get_no_open(dev);
+	bdev = blkdev_get_no_open(dev, true);
 	if (!bdev)
 		return ERR_PTR(-ENXIO);
 
@@ -1282,7 +1282,7 @@ void bdev_statx(const struct path *path, struct kstat *stat, u32 request_mask)
 	 * use I_BDEV() here; the block device has to be looked up by i_rdev
 	 * instead.
 	 */
-	bdev = blkdev_get_no_open(d_backing_inode(path->dentry)->i_rdev);
+	bdev = blkdev_get_no_open(d_backing_inode(path->dentry)->i_rdev, false);
 	if (!bdev)
 		return;
 
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 5905f277057b..e172aeda4183 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -797,7 +797,7 @@ int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
 		return -EINVAL;
 	input = skip_spaces(input);
 
-	bdev = blkdev_get_no_open(MKDEV(major, minor));
+	bdev = blkdev_get_no_open(MKDEV(major, minor), true);
 	if (!bdev)
 		return -ENODEV;
 	if (bdev_is_partition(bdev)) {
diff --git a/block/blk.h b/block/blk.h
index 939e5e1aec9c..328075787814 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -94,7 +94,7 @@ static inline void blk_wait_io(struct completion *done)
 		wait_for_completion_io(done);
 }
 
-struct block_device *blkdev_get_no_open(dev_t dev);
+struct block_device *blkdev_get_no_open(dev_t dev, bool autoload);
 void blkdev_put_no_open(struct block_device *bdev);
 
 #define BIO_INLINE_VECS 4
diff --git a/block/fops.c b/block/fops.c
index be9f1dbea9ce..d23ddb2dc113 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -642,7 +642,7 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	if (ret)
 		return ret;
 
-	bdev = blkdev_get_no_open(inode->i_rdev);
+	bdev = blkdev_get_no_open(inode->i_rdev, true);
 	if (!bdev)
 		return -ENXIO;
 
-- 
2.47.2


