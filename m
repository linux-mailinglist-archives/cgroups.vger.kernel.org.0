Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E748E259EAB
	for <lists+cgroups@lfdr.de>; Tue,  1 Sep 2020 20:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731841AbgIASyB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Sep 2020 14:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730517AbgIASxv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Sep 2020 14:53:51 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FC2C061246;
        Tue,  1 Sep 2020 11:53:50 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id v69so1993265qkb.7;
        Tue, 01 Sep 2020 11:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0YDXgIA1K+ZfhGe/lwGuhu8ktkywG9yY1AryQl3mCGI=;
        b=IJmpZv9OQ33NuZ5oIRloUIYTVC+/7+sFOK4ttwgkljaMn7IlEN3iV9lyqBOcQqR0uC
         fwmhnl4FPImWoZiBbyHRJG7BhYHTcuwWeuA54PjTv94oC59xUbUSRaXZm0d1u0i0AgYu
         VFG9TRDpU+0m6LQncYEC0A5mt8TlqhsdiugpoKm41gZCnPKxSRU3IDDOcBMB1NblhHPK
         GVJnObVjUVwmT6IA68FmGkXSCc2OePwnWp3hj3w6ZBwRNA9cojz8L8AQrQabiMOi6+0q
         RA6z5tL8/qJ+Ijd6WL/WCnnAezrfV1dSNNTMG500KIQ8kqcLYJREcXLI1md16F1TUv9i
         gSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0YDXgIA1K+ZfhGe/lwGuhu8ktkywG9yY1AryQl3mCGI=;
        b=IOUBCSTvOoSM/RS9iXykNd6zhPqRjHF7ywUQayi882gw3RlM/uzHT9C1EGUoKLsWqd
         amCwHrO32bmZx55d6Sqpoci46vvwRO6gGLp3Rl7cYVt5PJfPWVfJTiBhnX6yFYDhGLR2
         9DUun0PurkJfQEm6Aivq0j4WOOYXjzaqGgQW6JwoB3DGp6ExV0o9BXBDHdYhR6i3TLAi
         Fcs9XLhwnPvevTjqhNmIn09DHzVPR8WNkx3ufdzKmq9O9Azj9Hpbti692ERHcOtZtpCb
         hmhteiTGC3c7rfvG6Gk9mmySn5+GaJe/pGdslMHtKanPQdNF5GJIWWiaR7mcubOmsPyE
         mwLA==
X-Gm-Message-State: AOAM533jNXohMaNCbrRFiEY6988j1bEaS6U+2axc9QfQjtqmKLYGrolx
        F66c+DJhyYbenHTSDGLbrWI=
X-Google-Smtp-Source: ABdhPJzIFXVWPu8lmo/nlLSwxDxGZUx+3Z4piSJAkukXlm2lwWiqEZmkUb/HShPISMCG8nUq8qb7kw==
X-Received: by 2002:a37:5042:: with SMTP id e63mr3170231qkb.453.1598986429966;
        Tue, 01 Sep 2020 11:53:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a198])
        by smtp.gmail.com with ESMTPSA id k6sm1865857qti.23.2020.09.01.11.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 11:53:49 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, newella@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 15/27] blk-iocost: replace iocg->has_surplus with ->surplus_list
Date:   Tue,  1 Sep 2020 14:52:45 -0400
Message-Id: <20200901185257.645114-16-tj@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901185257.645114-1-tj@kernel.org>
References: <20200901185257.645114-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Instead of marking iocgs with surplus with a flag and filtering for them
while walking all active iocgs, build a surpluses list. This doesn't make
much difference now but will help implementing improved donation logic which
will iterate iocgs with surplus multiple times.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 2496674bbbf4..c1cd66cfa2a8 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -494,9 +494,9 @@ struct ioc_gq {
 	int				hweight_gen;
 	u32				hweight_active;
 	u32				hweight_inuse;
-	bool				has_surplus;
 
 	struct list_head		walk_list;
+	struct list_head		surplus_list;
 
 	struct wait_queue_head		waitq;
 	struct hrtimer			waitq_timer;
@@ -1507,6 +1507,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 	struct ioc *ioc = container_of(timer, struct ioc, timer);
 	struct ioc_gq *iocg, *tiocg;
 	struct ioc_now now;
+	LIST_HEAD(surpluses);
 	int nr_surpluses = 0, nr_shortages = 0, nr_lagging = 0;
 	u32 ppm_rthr = MILLION - ioc->params.qos[QOS_RPPM];
 	u32 ppm_wthr = MILLION - ioc->params.qos[QOS_WPPM];
@@ -1630,8 +1631,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 		/* see whether there's surplus vtime */
 		vmin = now.vnow - ioc->margins.max;
 
-		iocg->has_surplus = false;
-
+		WARN_ON_ONCE(!list_empty(&iocg->surplus_list));
 		if (!waitqueue_active(&iocg->waitq) &&
 		    time_before64(vtime, vmin)) {
 			u64 delta = vmin - vtime;
@@ -1641,7 +1641,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 			atomic64_add(delta, &iocg->done_vtime);
 			/* if usage is sufficiently low, maybe it can donate */
 			if (surplus_adjusted_hweight_inuse(usage, hw_inuse)) {
-				iocg->has_surplus = true;
+				list_add(&iocg->surplus_list, &surpluses);
 				nr_surpluses++;
 			}
 		} else if (hw_inuse < hw_active) {
@@ -1677,13 +1677,10 @@ static void ioc_timer_fn(struct timer_list *timer)
 		goto skip_surplus_transfers;
 
 	/* there are both shortages and surpluses, transfer surpluses */
-	list_for_each_entry(iocg, &ioc->active_iocgs, active_list) {
+	list_for_each_entry(iocg, &surpluses, surplus_list) {
 		u32 usage, hw_active, hw_inuse, new_hwi, new_inuse;
 		int nr_valid = 0;
 
-		if (!iocg->has_surplus)
-			continue;
-
 		/* base the decision on max historical usage */
 		for (i = 0, usage = 0; i < NR_USAGE_SLOTS; i++) {
 			if (iocg->usages[i]) {
@@ -1711,6 +1708,10 @@ static void ioc_timer_fn(struct timer_list *timer)
 skip_surplus_transfers:
 	commit_weights(ioc);
 
+	/* surplus list should be dissolved after use */
+	list_for_each_entry_safe(iocg, tiocg, &surpluses, surplus_list)
+		list_del_init(&iocg->surplus_list);
+
 	/*
 	 * If q is getting clogged or we're missing too much, we're issuing
 	 * too much IO and should lower vtime rate.  If we're not missing
@@ -2284,6 +2285,7 @@ static void ioc_pd_init(struct blkg_policy_data *pd)
 	atomic64_set(&iocg->active_period, atomic64_read(&ioc->cur_period));
 	INIT_LIST_HEAD(&iocg->active_list);
 	INIT_LIST_HEAD(&iocg->walk_list);
+	INIT_LIST_HEAD(&iocg->surplus_list);
 	iocg->hweight_active = WEIGHT_ONE;
 	iocg->hweight_inuse = WEIGHT_ONE;
 
@@ -2320,6 +2322,7 @@ static void ioc_pd_free(struct blkg_policy_data *pd)
 		}
 
 		WARN_ON_ONCE(!list_empty(&iocg->walk_list));
+		WARN_ON_ONCE(!list_empty(&iocg->surplus_list));
 
 		spin_unlock_irqrestore(&ioc->lock, flags);
 
-- 
2.26.2

