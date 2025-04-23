Return-Path: <cgroups+bounces-7741-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C97AA97E25
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 07:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6265189D08D
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 05:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BC7266591;
	Wed, 23 Apr 2025 05:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0pbXzcbr"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD6B2CCC1;
	Wed, 23 Apr 2025 05:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745386698; cv=none; b=Lj8Mo370jsSBjW3WgPRWfPrVK3QWGDzwoQzq2IcZLOyQ7wo40LUl7x7o8o+MEircQQ1sdYW37VgnT7jVeIsQFgkPaQq6HTQRVymJiY8AM8aPy14pIYnuSOjDMMYCERtkCllQmrWiOQdvaqQtQ8WEyXZJV5jUwslyQDYr48e/gaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745386698; c=relaxed/simple;
	bh=G4vZdNjlhcJrLUX7CmAD6WKCm0i0DDiW3QNDZgBqww8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHw+/KeCdVhVKm/VfTiLEF6r3233oDPMr6sMxyLOuNfhMoIAXZuGDaV+4Af3YaOwGv1SVAkpo2hAW6ytGL+kpHhZBeXMlzhgQS41T9+ZMWa/CFsvo3HkEiNyDWokCyp9dmJzWczJT8RS5deaqJ6f2uecAg8qvHYAKPI6vwXLWx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0pbXzcbr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=AuRLph8T6k0btqaHAYdpoYmSXccJgaPw3ebgqqT3wLk=; b=0pbXzcbrZ0SKzkNJuHivf9R70l
	h0jNy9N6BfOkr2yE+W56JICJS6XwHQrEiFcw2uOQ9LUzdJyagOBalAgsrxBlcoMKIkOVSG18zGhWJ
	OPkHbB1oL9cBhtNu/AZNBYkW8w240Yqe4Q0hqm2evIGO+pR/Ks3D6EO7d9iq4pyqo1E2Q1lNgdjsb
	4hS1+7e4Z25WhBB1IdiDFUhUhKADwmr2+Pge1icQHJnPr50FhjbCo1uecwTCE0B21D7dxlc2Xm2fd
	A2rK59cSMNVDe5I9OVo0r3QuliZhEwiI+FppTlo4iUsLk5YMaGwvX74fjf9MUw5YzqjhYbPn3MWXn
	CRW7OX5g==;
Received: from 2a02-8389-2341-5b80-c0c9-6b8d-e783-b2cd.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:c0c9:6b8d:e783:b2cd] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7SoJ-00000009FlR-3VM1;
	Wed, 23 Apr 2025 05:38:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <christian@brauner.io>,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [PATCH 1/4] block: move blkdev_{get,put} _no_open prototypes out of blkdev.h
Date: Wed, 23 Apr 2025 07:37:39 +0200
Message-ID: <20250423053810.1683309-2-hch@lst.de>
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

These are only to be used by block internal code.  Remove the comment
as we grew more users due to reworking block device node opening.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h            | 3 +++
 include/linux/blkdev.h | 4 ----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 006e3be433d2..939e5e1aec9c 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -94,6 +94,9 @@ static inline void blk_wait_io(struct completion *done)
 		wait_for_completion_io(done);
 }
 
+struct block_device *blkdev_get_no_open(dev_t dev);
+void blkdev_put_no_open(struct block_device *bdev);
+
 #define BIO_INLINE_VECS 4
 struct bio_vec *bvec_alloc(mempool_t *pool, unsigned short *nr_vecs,
 		gfp_t gfp_mask);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2b8875a82ff8..557f10ad9b46 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1693,10 +1693,6 @@ int bd_prepare_to_claim(struct block_device *bdev, void *holder,
 		const struct blk_holder_ops *hops);
 void bd_abort_claiming(struct block_device *bdev, void *holder);
 
-/* just for blk-cgroup, don't use elsewhere */
-struct block_device *blkdev_get_no_open(dev_t dev);
-void blkdev_put_no_open(struct block_device *bdev);
-
 struct block_device *I_BDEV(struct inode *inode);
 struct block_device *file_bdev(struct file *bdev_file);
 bool disk_live(struct gendisk *disk);
-- 
2.47.2


