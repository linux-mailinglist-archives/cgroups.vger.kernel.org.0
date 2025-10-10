Return-Path: <cgroups+bounces-10635-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA65BCC482
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 11:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14CC63BDE65
	for <lists+cgroups@lfdr.de>; Fri, 10 Oct 2025 09:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB0027511E;
	Fri, 10 Oct 2025 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0tgdXSG"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7167627464F;
	Fri, 10 Oct 2025 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760087710; cv=none; b=d3YMKhY0fhEJYsZZcVhhSYoctNQANTL3m5Xnvipmw5nTEJ+VxOkKfHmrdngtfgng5MY812c8z5rFhs11rRkCfgq/dOpBFrgqYEm/aDGsxVAo39dBHvLg1prje2gy3b17Ck5zicoRsFsYcTrNLGDVnDJxcVb4o9WjjPRx5+4MbmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760087710; c=relaxed/simple;
	bh=G6Upd2yMujq+BwPFpJQX6P368aq8r2nm84L+UG2pXok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIcmtfmIQHHWgLHUrYAqP64dIGIVBVWgdZvn7ShnnygKsskzh/XdzoVBnMkat+OZyUQqvQFhTwlXjfKaGPAFehKOE1YPcAFr+qQc7C2nc/0iEujeNcfTivUqH6uZIbxthz8ZfSW73A5I5g7qrsKTutsbo0SLRARx+vSnOiDFmbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0tgdXSG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA23FC4CEF1;
	Fri, 10 Oct 2025 09:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760087708;
	bh=G6Upd2yMujq+BwPFpJQX6P368aq8r2nm84L+UG2pXok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F0tgdXSG0HTr1rpLpYrBwXvlHDcUYN8xoGkTrDQ4y533t3vSXhz9yLFFbxD2NMOAO
	 vftJxOaBSXqsXupiarE2qSpua+IeBkHXz2HZlDS5P220w5OBHX9xlz6BNjdoGfGzyG
	 SfyUCAvveQhZFekUFON2yGIYGsfmWSLbHueGNAHYYPb685XzKjRkads4XYrcdWFpOu
	 NxVDSYm8yXXpVF1GMQvbcaQFaU0nmdDDktSZ/WV3/hSypbLpSbNT0N8Dd/ZNQdr3kD
	 I/LBuOhXUq+MLxOcq04hRieJZUoeW365eUO9KevoIeFIESJZd0No29Dbf1Z6wYZV8t
	 dpd3IJFXsOavA==
From: Yu Kuai <yukuai@kernel.org>
To: axboe@kernel.dk,
	tj@kernel.org,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	nilay@linux.ibm.com,
	bvanassche@acm.org,
	ming.lei@redhat.com,
	hch@lst.de
Cc: linux-kernel@vger.kernel.org,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH v2 06/19] blk-cgroup: don't nest queue_lock under blkcg->lock in blkcg_destroy_blkgs()
Date: Fri, 10 Oct 2025 17:14:31 +0800
Message-ID: <20251010091446.3048529-7-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010091446.3048529-1-yukuai@kernel.org>
References: <20251010091446.3048529-1-yukuai@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai3@huawei.com>

The correct lock order is q->queue_lock before blkcg->lock, and in order
to prevent deadlock from blkcg_destroy_blkgs(), trylock is used for
q->queue_lock while blkcg->lock is already held, this is hacky.

Hence refactor blkcg_destroy_blkgs(), by holding blkcg->lock to get the
first blkg and release it, then hold q->queue_lock and blkcg->lock in
the correct order to destroy blkg. This is super cold path, it's fine to
grab and release locks.

Also prepare to convert protecting blkcg with blkcg_mutex instead of
queue_lock.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-cgroup.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 2234ff2b2b8b..99edf15ce525 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1284,6 +1284,21 @@ struct list_head *blkcg_get_cgwb_list(struct cgroup_subsys_state *css)
  *    This finally frees the blkcg.
  */
 
+static struct blkcg_gq *blkcg_get_first_blkg(struct blkcg *blkcg)
+{
+	struct blkcg_gq *blkg = NULL;
+
+	spin_lock_irq(&blkcg->lock);
+	if (!hlist_empty(&blkcg->blkg_list)) {
+		blkg = hlist_entry(blkcg->blkg_list.first, struct blkcg_gq,
+				   blkcg_node);
+		blkg_get(blkg);
+	}
+	spin_unlock_irq(&blkcg->lock);
+
+	return blkg;
+}
+
 /**
  * blkcg_destroy_blkgs - responsible for shooting down blkgs
  * @blkcg: blkcg of interest
@@ -1297,32 +1312,24 @@ struct list_head *blkcg_get_cgwb_list(struct cgroup_subsys_state *css)
  */
 static void blkcg_destroy_blkgs(struct blkcg *blkcg)
 {
-	might_sleep();
+	struct blkcg_gq *blkg;
 
-	spin_lock_irq(&blkcg->lock);
+	might_sleep();
 
-	while (!hlist_empty(&blkcg->blkg_list)) {
-		struct blkcg_gq *blkg = hlist_entry(blkcg->blkg_list.first,
-						struct blkcg_gq, blkcg_node);
+	while ((blkg = blkcg_get_first_blkg(blkcg))) {
 		struct request_queue *q = blkg->q;
 
-		if (need_resched() || !spin_trylock(&q->queue_lock)) {
-			/*
-			 * Given that the system can accumulate a huge number
-			 * of blkgs in pathological cases, check to see if we
-			 * need to rescheduling to avoid softlockup.
-			 */
-			spin_unlock_irq(&blkcg->lock);
-			cond_resched();
-			spin_lock_irq(&blkcg->lock);
-			continue;
-		}
+		spin_lock_irq(&q->queue_lock);
+		spin_lock(&blkcg->lock);
 
 		blkg_destroy(blkg);
-		spin_unlock(&q->queue_lock);
-	}
 
-	spin_unlock_irq(&blkcg->lock);
+		spin_unlock(&blkcg->lock);
+		spin_unlock_irq(&q->queue_lock);
+
+		blkg_put(blkg);
+		cond_resched();
+	}
 }
 
 /**
-- 
2.51.0


