Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB75259EC9
	for <lists+cgroups@lfdr.de>; Tue,  1 Sep 2020 20:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731315AbgIASxV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Sep 2020 14:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731366AbgIASxR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Sep 2020 14:53:17 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E52BC061245;
        Tue,  1 Sep 2020 11:53:16 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b14so1999428qkn.4;
        Tue, 01 Sep 2020 11:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Abijl0OmP6VYSflgQEhNpTgXbVq6GxdxWWrhkCH99jc=;
        b=BYrK0zSLvPdaANXkzCXqODMBDKe5h7ipVdn2xiRVWxu7y4qoGlbLsat7aKgGV2NzAX
         uA9xTg2W43pbV3T1KFcjp4McIbz8C7Z9y+4lVi0pNw5/4LtQdhb95BWCEs+uWaml2W9j
         QvwuHJONksBt2KE09l+I1qkK15+vvKFyOd6venv28WwjFQaNa1WW0wUIiCKkvCB1qLG7
         MIWBSC3WrHgH3Wa2mh62XUb7i74iR0JuJMWm91KrNQIIlLW7d/CPJhKqVvICdX41A4eB
         UjHfd1CFFydEXixQ5tAReP0xL5GurO/+lMrr530F1YkcYn1cpAO3ght+hgZFzYk4wj5x
         xFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Abijl0OmP6VYSflgQEhNpTgXbVq6GxdxWWrhkCH99jc=;
        b=LEAWWam4DJRaLQDfj+KeAmzDBzEb3g0wtqDmIuTZLCam26ei5a7mrFORjU4Z8KcVqA
         U+8+LbF8f+koQIYyFFZ1rOrPdgjmp76iDmHk6OW8jSNeidwFxigCdxVssSxzaDtNkivF
         J7udIkFEdgzsQyclInZYcYeevuNu1hHh/lD3D7ALyxmHb+Ji29o45J/fFLeXbYwgaKRn
         /U3RSfO6fkWkacY2Cx18UD9dzUPxw0XCbwFD0D+0UcptQBSUEiOQyEM4lI5n+Brxlnze
         3/7Z/CCYhjM4NB+PC551uTNM+xtp6glykFzUtuWNWr6EE4pbiScr0Nk/Rx3sRsloBNND
         39eQ==
X-Gm-Message-State: AOAM533kUB5osBHtYdwTWt4Z1nZ0uttLrKQon9+zFCIjN42I9uJdwsX+
        H8EjjD8vyatAQcSX2rwuRTFUjcz/UK84CQ==
X-Google-Smtp-Source: ABdhPJzlYRM4F4sUXjrbVokCMMwmBNVn4u2vGXfHZMYyyB+m9IRWMAArmA9lx0GWSsYbD7bh8ienXQ==
X-Received: by 2002:a37:9a13:: with SMTP id c19mr3185912qke.48.1598986395712;
        Tue, 01 Sep 2020 11:53:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a198])
        by smtp.gmail.com with ESMTPSA id k6sm1864377qti.23.2020.09.01.11.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 11:53:14 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, newella@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/27] blk-iocost: rename propagate_active_weights() to propagate_weights()
Date:   Tue,  1 Sep 2020 14:52:34 -0400
Message-Id: <20200901185257.645114-5-tj@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901185257.645114-1-tj@kernel.org>
References: <20200901185257.645114-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It already propagates two weights - active and inuse - and there will be
another soon. Let's drop the confusing misnomers. Rename
[__]propagate_active_weights() to [__]propagate_weights() and
commit_active_weights() to commit_weights().

This is pure rename.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index e2266e7692b4..78e6919153d8 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -479,7 +479,7 @@ struct ioc_gq {
 	atomic64_t			active_period;
 	struct list_head		active_list;
 
-	/* see __propagate_active_weight() and current_hweight() for details */
+	/* see __propagate_weights() and current_hweight() for details */
 	u64				child_active_sum;
 	u64				child_inuse_sum;
 	int				hweight_gen;
@@ -890,7 +890,7 @@ static void ioc_start_period(struct ioc *ioc, struct ioc_now *now)
  * Update @iocg's `active` and `inuse` to @active and @inuse, update level
  * weight sums and propagate upwards accordingly.
  */
-static void __propagate_active_weight(struct ioc_gq *iocg, u32 active, u32 inuse)
+static void __propagate_weights(struct ioc_gq *iocg, u32 active, u32 inuse)
 {
 	struct ioc *ioc = iocg->ioc;
 	int lvl;
@@ -935,7 +935,7 @@ static void __propagate_active_weight(struct ioc_gq *iocg, u32 active, u32 inuse
 	ioc->weights_updated = true;
 }
 
-static void commit_active_weights(struct ioc *ioc)
+static void commit_weights(struct ioc *ioc)
 {
 	lockdep_assert_held(&ioc->lock);
 
@@ -947,10 +947,10 @@ static void commit_active_weights(struct ioc *ioc)
 	}
 }
 
-static void propagate_active_weight(struct ioc_gq *iocg, u32 active, u32 inuse)
+static void propagate_weights(struct ioc_gq *iocg, u32 active, u32 inuse)
 {
-	__propagate_active_weight(iocg, active, inuse);
-	commit_active_weights(iocg->ioc);
+	__propagate_weights(iocg, active, inuse);
+	commit_weights(iocg->ioc);
 }
 
 static void current_hweight(struct ioc_gq *iocg, u32 *hw_activep, u32 *hw_inusep)
@@ -966,9 +966,9 @@ static void current_hweight(struct ioc_gq *iocg, u32 *hw_activep, u32 *hw_inusep
 		goto out;
 
 	/*
-	 * Paired with wmb in commit_active_weights().  If we saw the
-	 * updated hweight_gen, all the weight updates from
-	 * __propagate_active_weight() are visible too.
+	 * Paired with wmb in commit_weights(). If we saw the updated
+	 * hweight_gen, all the weight updates from __propagate_weights() are
+	 * visible too.
 	 *
 	 * We can race with weight updates during calculation and get it
 	 * wrong.  However, hweight_gen would have changed and a future
@@ -1018,7 +1018,7 @@ static void weight_updated(struct ioc_gq *iocg)
 
 	weight = iocg->cfg_weight ?: iocc->dfl_weight;
 	if (weight != iocg->weight && iocg->active)
-		propagate_active_weight(iocg, weight,
+		propagate_weights(iocg, weight,
 			DIV64_U64_ROUND_UP(iocg->inuse * weight, iocg->weight));
 	iocg->weight = weight;
 }
@@ -1090,8 +1090,8 @@ static bool iocg_activate(struct ioc_gq *iocg, struct ioc_now *now)
 	 */
 	iocg->hweight_gen = atomic_read(&ioc->hweight_gen) - 1;
 	list_add(&iocg->active_list, &ioc->active_iocgs);
-	propagate_active_weight(iocg, iocg->weight,
-				iocg->last_inuse ?: iocg->weight);
+	propagate_weights(iocg, iocg->weight,
+			  iocg->last_inuse ?: iocg->weight);
 
 	TRACE_IOCG_PATH(iocg_activate, iocg, now,
 			last_period, cur_period, vtime);
@@ -1384,13 +1384,13 @@ static void ioc_timer_fn(struct timer_list *timer)
 		} else if (iocg_is_idle(iocg)) {
 			/* no waiter and idle, deactivate */
 			iocg->last_inuse = iocg->inuse;
-			__propagate_active_weight(iocg, 0, 0);
+			__propagate_weights(iocg, 0, 0);
 			list_del_init(&iocg->active_list);
 		}
 
 		spin_unlock(&iocg->waitq.lock);
 	}
-	commit_active_weights(ioc);
+	commit_weights(ioc);
 
 	/* calc usages and see whether some weights need to be moved around */
 	list_for_each_entry(iocg, &ioc->active_iocgs, active_list) {
@@ -1483,8 +1483,8 @@ static void ioc_timer_fn(struct timer_list *timer)
 				TRACE_IOCG_PATH(inuse_takeback, iocg, &now,
 						iocg->inuse, new_inuse,
 						hw_inuse, new_hwi);
-				__propagate_active_weight(iocg, iocg->weight,
-							  new_inuse);
+				__propagate_weights(iocg, iocg->weight,
+						    new_inuse);
 			}
 		} else {
 			/* genuninely out of vtime */
@@ -1524,11 +1524,11 @@ static void ioc_timer_fn(struct timer_list *timer)
 			TRACE_IOCG_PATH(inuse_giveaway, iocg, &now,
 					iocg->inuse, new_inuse,
 					hw_inuse, new_hwi);
-			__propagate_active_weight(iocg, iocg->weight, new_inuse);
+			__propagate_weights(iocg, iocg->weight, new_inuse);
 		}
 	}
 skip_surplus_transfers:
-	commit_active_weights(ioc);
+	commit_weights(ioc);
 
 	/*
 	 * If q is getting clogged or we're missing too much, we're issuing
@@ -1753,7 +1753,7 @@ static void ioc_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
 		TRACE_IOCG_PATH(inuse_reset, iocg, &now,
 				iocg->inuse, iocg->weight, hw_inuse, hw_active);
 		spin_lock_irq(&ioc->lock);
-		propagate_active_weight(iocg, iocg->weight, iocg->weight);
+		propagate_weights(iocg, iocg->weight, iocg->weight);
 		spin_unlock_irq(&ioc->lock);
 		current_hweight(iocg, &hw_active, &hw_inuse);
 	}
@@ -2114,7 +2114,7 @@ static void ioc_pd_free(struct blkg_policy_data *pd)
 	if (ioc) {
 		spin_lock_irqsave(&ioc->lock, flags);
 		if (!list_empty(&iocg->active_list)) {
-			propagate_active_weight(iocg, 0, 0);
+			propagate_weights(iocg, 0, 0);
 			list_del_init(&iocg->active_list);
 		}
 		spin_unlock_irqrestore(&ioc->lock, flags);
-- 
2.26.2

