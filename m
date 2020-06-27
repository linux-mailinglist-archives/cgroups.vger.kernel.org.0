Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CE020BFA2
	for <lists+cgroups@lfdr.de>; Sat, 27 Jun 2020 09:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgF0HdO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 Jun 2020 03:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgF0HdN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 Jun 2020 03:33:13 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE510C03E979;
        Sat, 27 Jun 2020 00:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TotXMoDr4SMB2qAUQWeT1iUDwtwRZjQn0sDaTbNw3KE=; b=lBBFTQqtqPDmKcz4C2xD/zM/hu
        Lrzy51/shbHq+GN4MpENNU+6yV67bBHqSSioPVy0RchQm5VxOyJgLQP6umNIPnNZ2sR945Vfxjpd/
        /hue1Aei3ALd+WQ2tq3K3FcM4HyMRuyCPeIuUQ7cwJigY8EEgTF8r0aD2/qwQt91Vywh+ZIu0toG+
        +PkK+1vEPRG9l1s0mKPgGsfxyDttV9haep1R+Uwaj/JQWy5QRXi8xPwioRwTEP/ScYyGwmFxbkJ/c
        hXdX1GFMy79Vf4ofCFXTs3Pd+ijSmZ0PHxDPNtultydJoEPMMuE9W7sagWDR6VRHNNYHh5ENAddnC
        YrPOgNRg==;
Received: from [2001:4bb8:184:76e3:595:ba65:ae56:65a6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jp5KO-0006oz-Bj; Sat, 27 Jun 2020 07:32:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 12/14] blk-cgroup: move rcu locking from blkcg_bio_issue_check to blk_throtl_bio
Date:   Sat, 27 Jun 2020 09:31:57 +0200
Message-Id: <20200627073159.2447325-13-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200627073159.2447325-1-hch@lst.de>
References: <20200627073159.2447325-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The only thing in blkcg_bio_issue_check that needs to be under
rcu_read_lock is blk_throtl_bio, so move the locking there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-throttle.c       | 3 ++-
 include/linux/blk-cgroup.h | 2 --
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 209fdd8939fba6..ac008345050010 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2168,7 +2168,7 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	bool throttled = false;
 	struct throtl_data *td = tg->td;
 
-	WARN_ON_ONCE(!rcu_read_lock_held());
+	rcu_read_lock();
 
 	/* see throtl_charge_bio() */
 	if (bio_flagged(bio, BIO_THROTTLED))
@@ -2273,6 +2273,7 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	if (throttled || !td->track_bio_latency)
 		bio->bi_issue.value |= BIO_ISSUE_THROTL_SKIP_LATENCY;
 #endif
+	rcu_read_unlock();
 	return throttled;
 }
 
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 8e86b598316c10..8ab043c911f233 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -546,7 +546,6 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 	struct blkcg_gq *blkg = bio->bi_blkg;
 	bool throtl = false;
 
-	rcu_read_lock();
 	throtl = blk_throtl_bio(q, blkg, bio);
 	if (!throtl) {
 		struct blkg_iostat_set *bis;
@@ -582,7 +581,6 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 
 	blkcg_bio_issue_init(bio);
 
-	rcu_read_unlock();
 	return !throtl;
 }
 
-- 
2.26.2

