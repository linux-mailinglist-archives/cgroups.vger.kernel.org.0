Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F34F20BF98
	for <lists+cgroups@lfdr.de>; Sat, 27 Jun 2020 09:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgF0Hc4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 Jun 2020 03:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgF0Hcx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 Jun 2020 03:32:53 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AAAC03E979;
        Sat, 27 Jun 2020 00:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=GGiSOAs9cZu8YPYPdf6bT1AGgpeRSLCWtTfRUcMw8po=; b=DUd0a08wTpSbY0adkAupOokAWp
        +Ij/hgTuW5RW75ccKxqhkrzy9fhx8QsEhlJKu3R416Iffa4LObjU5Dt9pIPT/J6Dt9Re9JjgdyQ5c
        LPBjuoM0NSylWVyDxwhs9szHi+BMAKgqpVlGWUY3IES6andSNvUGwycll6w2IEIuBKXqlCiFjjicR
        YpbE2VIphHNWEyGkkQnFmwGIheMgfuzckSiee4Nb5Y5RgYozISDJWrYobSvebkTt7YNEmmqTA2lqy
        QH9+idB2SLdYLMAEi4Rfo7HZjjf4bHV5w8hynB0ab7WZ7U/rr5ZkDf1cWePpT/dHugveyfSyOJXqA
        1YK96cEw==;
Received: from [2001:4bb8:184:76e3:595:ba65:ae56:65a6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jp5K8-0006nQ-7F; Sat, 27 Jun 2020 07:32:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 08/14] block: bypass blkg_tryget_closest for the root_blkg
Date:   Sat, 27 Jun 2020 09:31:53 +0200
Message-Id: <20200627073159.2447325-9-hch@lst.de>
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

The root_blkg is only torn down at the very end of removing a queue.
So in the I/O submission path is always has a life reference and we
can just grab another one using blkg_get instead of doing a tryget
and parent walk that won't lead anywhere.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 6aedb73ffbf473..0912820d4f8194 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1758,16 +1758,21 @@ void bio_associate_blkg_from_css(struct bio *bio,
 				 struct cgroup_subsys_state *css)
 {
 	struct request_queue *q = bio->bi_disk->queue;
-	struct blkcg_gq *blkg = q->root_blkg;
 
 	if (bio->bi_blkg)
 		blkg_put(bio->bi_blkg);
 
-	rcu_read_lock();
-	if (css && css->parent)
+	if (css && css->parent) {
+		struct blkcg_gq *blkg;
+
+		rcu_read_lock();
 		blkg = blkg_lookup_create(css_to_blkcg(css), q);
-	bio->bi_blkg = blkg_tryget_closest(blkg);
-	rcu_read_unlock();
+		bio->bi_blkg = blkg_tryget_closest(blkg);
+		rcu_read_unlock();
+	} else {
+		blkg_get(q->root_blkg);
+		bio->bi_blkg = q->root_blkg;
+	}
 }
 EXPORT_SYMBOL_GPL(bio_associate_blkg_from_css);
 
-- 
2.26.2

