Return-Path: <cgroups+bounces-9724-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 573CCB44EFB
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 09:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 950627BA027
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 07:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4256B2DA77E;
	Fri,  5 Sep 2025 07:15:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84E91EBA07;
	Fri,  5 Sep 2025 07:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056558; cv=none; b=K6d+71GkxL/BB3kW2z8ZvHdIJ/m6CDpZKWCKq2sX0cTpBvj4GoXn+d8ZpuEouSJegKTS2auWVl63ltjTbaN+I8bp1g89wuUagQd0LAusZo6oKdJuXnlGRuKpHZNzGLWCDSnQ6NEoy0tJa/4yrCkBOEBUPnnXW957xflAzA038Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056558; c=relaxed/simple;
	bh=WAxCcoOqy52xVm64gVkWaFuMIFjb1nW2kq3XFWbZxGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=edJEE3GMj2wy014/fXNEGSd8kAKn7xi1QsEVwhWvfdrw8K1YyzroX3H2VaoYrRqehy9WNxm7rIlrZ4BIegtu4UsQzsRx+Y/xCHFavVF7UOgRfqbBdZxEaAg0VRFwxDW7+nO0Kj4TR8YjUrUIeOOHYHvgahqfmqYGH62d8pJbKeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cJ7150pQdzKHLxn;
	Fri,  5 Sep 2025 15:15:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 11C301A0DC1;
	Fri,  5 Sep 2025 15:15:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIwkjrpowYbQBQ--.23573S6;
	Fri, 05 Sep 2025 15:15:52 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@infradead.org,
	colyli@kernel.org,
	hare@suse.de,
	dlemoal@kernel.org,
	tieren@fnnas.com,
	bvanassche@acm.org,
	axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com,
	song@kernel.org,
	yukuai3@huawei.com,
	satyat@google.com,
	ebiggers@google.com,
	kmo@daterainc.com,
	akpm@linux-foundation.org,
	neil@brown.name
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH for-6.18/block 02/16] block: initialize bio issue time in blk_mq_submit_bio()
Date: Fri,  5 Sep 2025 15:06:29 +0800
Message-Id: <20250905070643.2533483-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncIwkjrpowYbQBQ--.23573S6
X-Coremail-Antispam: 1UD129KBjvJXoWxXr1xuF1UGr1rJF4xAr1DZFb_yoW5Cw48pr
	WaqFsxGryagFZrWFsrt3W2qr1fKa1kKry5G3yrC3yakr47Crn2qF1kZr4vyryF9FWfCrW5
	Zr48KryYkr4jk37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0I3
	85UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

bio->issue_time_ns is only used by blk-iolatency, which can only be
enabled for rq-based disk, hence it's not necessary to initialize
the time for bio-based disk.

Meanwhile, if bio is split by blk_crypto_fallback_split_bio_if_needed(),
the issue time is not initialized for new split bio, this can be fixed
as well.

Noted the next patch will optimize better that bio issue time will
only be used when blk-iolatency is really enabled by the disk.

Fixes: 488f6682c832 ("block: blk-crypto-fallback for Inline Encryption")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.h | 6 ------
 block/blk-core.c   | 1 -
 block/blk-merge.c  | 1 -
 block/blk-mq.c     | 1 +
 4 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index d73204d27d72..5330cce51060 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -370,11 +370,6 @@ static inline void blkg_put(struct blkcg_gq *blkg)
 		if (((d_blkg) = blkg_lookup(css_to_blkcg(pos_css),	\
 					    (p_blkg)->q)))
 
-static inline void blkcg_bio_issue_init(struct bio *bio)
-{
-	bio->issue_time_ns = blk_time_get_ns();
-}
-
 static inline void blkcg_use_delay(struct blkcg_gq *blkg)
 {
 	if (WARN_ON_ONCE(atomic_read(&blkg->use_delay) < 0))
@@ -491,7 +486,6 @@ static inline struct blkg_policy_data *blkg_to_pd(struct blkcg_gq *blkg,
 static inline struct blkcg_gq *pd_to_blkg(struct blkg_policy_data *pd) { return NULL; }
 static inline void blkg_get(struct blkcg_gq *blkg) { }
 static inline void blkg_put(struct blkcg_gq *blkg) { }
-static inline void blkcg_bio_issue_init(struct bio *bio) { }
 static inline void blk_cgroup_bio_start(struct bio *bio) { }
 static inline bool blk_cgroup_mergeable(struct request *rq, struct bio *bio) { return true; }
 
diff --git a/block/blk-core.c b/block/blk-core.c
index 4201504158a1..83c262a3dfd9 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -728,7 +728,6 @@ static void __submit_bio_noacct_mq(struct bio *bio)
 void submit_bio_noacct_nocheck(struct bio *bio)
 {
 	blk_cgroup_bio_start(bio);
-	blkcg_bio_issue_init(bio);
 
 	if (!bio_flagged(bio, BIO_TRACE_COMPLETION)) {
 		trace_block_bio_queue(bio);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 70d704615be5..5538356770a4 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -119,7 +119,6 @@ static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
 			goto error;
 		}
 		split->bi_opf |= REQ_NOMERGE;
-		blkcg_bio_issue_init(split);
 		bio_chain(split, bio);
 		trace_block_split(split, bio->bi_iter.bi_sector);
 		WARN_ON_ONCE(bio_zone_write_plugging(bio));
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ba3a4b77f578..d2538683c83d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3168,6 +3168,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (!bio_integrity_prep(bio))
 		goto queue_exit;
 
+	bio->issue_time_ns = blk_time_get_ns();
 	if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
 		goto queue_exit;
 
-- 
2.39.2


