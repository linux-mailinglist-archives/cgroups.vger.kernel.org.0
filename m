Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75855A927F
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2019 21:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbfIDTqG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Sep 2019 15:46:06 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32886 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730059AbfIDTqF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Sep 2019 15:46:05 -0400
Received: by mail-qt1-f196.google.com with SMTP id r5so20592187qtd.0;
        Wed, 04 Sep 2019 12:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=20hd4msrraab6jp0F0s3lMKgksvtNidxbTFc6K2dRls=;
        b=CupX71bIVnfpPA8VGUrRsLsNQaXHSnSrVgTiMAhqvTUTIhXuj/bvxSRlaVRiANA7Z7
         W6lK0f2NMmzXwkjXayxc91oQmH4j/o4uQkRffIRsRwb8+njuyWCFetp90/r9jD94bYdk
         cFSShDfZhragdYKCx7McGmf7vS/mAWvMuLK/QaWOu7qHR/VE/tB5DPouZagXNU8mbefP
         10UO9oCiSORQNsx88g6WFqmOTixTwCTygs1Ii3g5KOPq/fc26lgbTzZc06xATfiZxmbl
         BZhbP3ZOsXL4Lj8XDj7iq38DoHYra/0lw/G1bbIYVud1VBcWhHDbE4lA5tCkd3Q/N6gE
         JBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=20hd4msrraab6jp0F0s3lMKgksvtNidxbTFc6K2dRls=;
        b=l1iIFMJO5na2lrDBypFIAhxO5pNgcTLyu8Jh11MOIJTb8EtZu1yCHZSwexQyHJkUck
         yAjfYmdr48DxAKtjuvfJ/h4khqMmjsFUqgfecezYPZ8kBdvF2ouL3TR7SADk2pY4TR16
         opRLaJJImWJSvEVldH2Ao1Rrl/MPSebpZcDGfbzxYsJR7InG2mY+rYYDGXYOVrK3fnEy
         QuBofX8blgJeE1JSNLGgW+dtQaYpQI5gp7GtzMV1oPsWE0pHJUrc+Q+bbYAv1VQROAfp
         fuFn4Vj/N8z/P+eu/4fVR+n/TMm/Ziju94G2B7vEX1lutMwK2zKXDIa6u1jN9dicG45Q
         zAdw==
X-Gm-Message-State: APjAAAWmG8kXfLu7rt3qPk+myw3iGL8BTQlmMUWcfYak3X1TqQJmeW7b
        nVQjw8wJNszF6Z4xZeFr6Y9ajy5t
X-Google-Smtp-Source: APXvYqwVauzkyPShVeuhPhrQW+nWyc/CGdd+OPcgHHe6zgC0wvjj3tjQnlwmh5wMCT7WIRFbd9qP/A==
X-Received: by 2002:ac8:6919:: with SMTP id e25mr39885610qtr.317.1567626364386;
        Wed, 04 Sep 2019 12:46:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:33b1])
        by smtp.gmail.com with ESMTPSA id e17sm11343561qkn.61.2019.09.04.12.46.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 12:46:03 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@vger.kernel.org, cgroups@vger.kernel.org,
        newella@fb.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/5] blk-iocost: Don't let merges push vtime into the future
Date:   Wed,  4 Sep 2019 12:45:53 -0700
Message-Id: <20190904194556.2984857-3-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904194556.2984857-1-tj@kernel.org>
References: <20190904194556.2984857-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Merges have the same problem that forced-bios had which is fixed by
the previous patch.  The cost of a merge is calculated at the time of
issue and force-advances vtime into the future.  Until global vtime
catches up, how the cgroup's hweight changes in the meantime doesn't
matter and it often leads to situations where the cost is calculated
at one hweight and paid at a very different one.  See the previous
patch for more details.

Fix it by never advancing vtime into the future for merges.  If budget
is available, vtime is advanced.  Otherwise, the cost is charged as
debt.

This brings merge cost handling in line with issue cost handling in
ioc_rqos_throttle().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 5b0c024ee5dd..6000ce9b10bb 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1784,28 +1784,39 @@ static void ioc_rqos_merge(struct rq_qos *rqos, struct request *rq,
 			   struct bio *bio)
 {
 	struct ioc_gq *iocg = blkg_to_iocg(bio->bi_blkg);
+	struct ioc *ioc = iocg->ioc;
 	sector_t bio_end = bio_end_sector(bio);
+	struct ioc_now now;
 	u32 hw_inuse;
 	u64 abs_cost, cost;
 
-	/* add iff the existing request has cost assigned */
-	if (!rq->bio || !rq->bio->bi_iocost_cost)
+	/* bypass if disabled or for root cgroup */
+	if (!ioc->enabled || !iocg->level)
 		return;
 
 	abs_cost = calc_vtime_cost(bio, iocg, true);
 	if (!abs_cost)
 		return;
 
+	ioc_now(ioc, &now);
+	current_hweight(iocg, NULL, &hw_inuse);
+	cost = abs_cost_to_cost(abs_cost, hw_inuse);
+
 	/* update cursor if backmerging into the request at the cursor */
 	if (blk_rq_pos(rq) < bio_end &&
 	    blk_rq_pos(rq) + blk_rq_sectors(rq) == iocg->cursor)
 		iocg->cursor = bio_end;
 
-	current_hweight(iocg, NULL, &hw_inuse);
-	cost = div64_u64(abs_cost * HWEIGHT_WHOLE, hw_inuse);
-	bio->bi_iocost_cost = cost;
-
-	atomic64_add(cost, &iocg->vtime);
+	/*
+	 * Charge if there's enough vtime budget and the existing request
+	 * has cost assigned.  Otherwise, account it as debt.  See debt
+	 * handling in ioc_rqos_throttle() for details.
+	 */
+	if (rq->bio && rq->bio->bi_iocost_cost &&
+	    time_before_eq64(atomic64_read(&iocg->vtime) + cost, now.vnow))
+		iocg_commit_bio(iocg, bio, cost);
+	else
+		atomic64_add(abs_cost, &iocg->abs_vdebt);
 }
 
 static void ioc_rqos_done_bio(struct rq_qos *rqos, struct bio *bio)
-- 
2.17.1

