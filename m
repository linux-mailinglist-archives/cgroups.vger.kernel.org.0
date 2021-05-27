Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD5A392DF5
	for <lists+cgroups@lfdr.de>; Thu, 27 May 2021 14:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbhE0MbF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 May 2021 08:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbhE0MbD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 May 2021 08:31:03 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465A1C061763
        for <cgroups@vger.kernel.org>; Thu, 27 May 2021 05:29:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m18so4596783wrv.2
        for <cgroups@vger.kernel.org>; Thu, 27 May 2021 05:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m34kWJFts+JlvhgMEqzYFI86nqtKcI/eABSZJKWdva0=;
        b=kuYbHjMyYaX7A1hL/W1Dafd7/P3r7j1djEoge4gerT9ds8ebtZpggipN//3meNIYDP
         H3iQ+WtGvA4nH8D5I1Ru1+OODIKfUQJ8iIGorDWT+9LxeGMuHcBcWwKvsfVjQF4R9ZJx
         iWosXULEC6chunZkDSG3YOacsMp1SzVqRbFk7zMQyQxcuu1tRoVYXmr3I/mb8wSNETJz
         qnyItuDi/nn2FdxCKLY6pPtOkj+Z0pK5RPzIc7uGXs7mT2ztDJ4l04DcXFKVJNYiXvWm
         KBKQsmHNoWu1ED+J6aPE2EHGvS+TeN/9SHszVg51Anjv8IwJrvbn0U96EVNBH1RXoS/K
         uefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m34kWJFts+JlvhgMEqzYFI86nqtKcI/eABSZJKWdva0=;
        b=a+JHyLyBu9FeikKWpd8MptTu9icdQa+GwLrv3n/2keWAh/kqZDFoBEhHN28AhGsfC1
         97nZ//xKQcIi7/PyiWZvoo3iYG8yCE1WJNUE+JsObSJKmu13f9jkfYhf86XMUMSLnupf
         HPyqeJSsPPrDUBXOvk1gZ+xve+ApZm0GLeOzftUwOIOPdaYIj3ovWIM0YkPLNRapgquJ
         8qkmjhBK4h9zBnfkrwuFxxZvITk4luDiLkP+pLFyhcqI8qHL3SkRpbNluTlj0s6ZBzSn
         FSodeoJNQPX5x4zXll3EQ80bjHgo1NaBRNv/Li/ZE9c/y8+9mchCszLpboY78WyeBFtO
         d8/w==
X-Gm-Message-State: AOAM530iRhtweZhasG8rNyQ+zGf31WqemGgOWNFdaurNMSbifpyJ7bmy
        6EpLDJl5E7Wy3xzNnqlD0uyIUw==
X-Google-Smtp-Source: ABdhPJx062mWr3x4RL9DZFSGhNrOYmJPw2rA3JqtR1uStbo70U0iaVv8c9wmio9awzP6QGvinME+0w==
X-Received: by 2002:a05:6000:137a:: with SMTP id q26mr3097476wrz.216.1622118566791;
        Thu, 27 May 2021 05:29:26 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:3db3:bb86:bbaa:56ab])
        by smtp.gmail.com with ESMTPSA id z3sm2917721wrq.42.2021.05.27.05.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 05:29:26 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        odin@uged.al, cgroups@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/2] sched/fair: make sure to update tg contrib for blocked load
Date:   Thu, 27 May 2021 14:29:16 +0200
Message-Id: <20210527122916.27683-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210527122916.27683-1-vincent.guittot@linaro.org>
References: <20210527122916.27683-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

During the update of fair blocked load (__update_blocked_fair()), we update
the contribution of the cfs in tg->load_avg if cfs_rq's pelt has decayed.
Nevertheless, the pelt values of a cfs_rq could have been recently updated
while propagating the change of a child. In uchthis case, cfs_rq's pelt will
not decayed because it has already been updated and we don't update
tg->load_avg.

__update_blocked_fair
  ...
  for_each_leaf_cfs_rq_safe: child cfs_rq
    update cfs_rq_load_avg() for child cfs_rq
    ...
    update_load_avg(cfs_rq_of(se), se, 0)
      ...
      update cfs_rq_load_avg() for parent cfs_rq
		-propagation of child's load makes parent cfs_rq->load_sum
		 becoming null
        -UPDATE_TG is not set so it doesn't update parent
		 cfs_rq->tg_load_avg_contrib
  ..
  for_each_leaf_cfs_rq_safe: parent cfs_rq
    update cfs_rq_load_avg() for parent cfs_rq
      - nothing to do because parent cfs_rq has already been updated
		recently so cfs_rq->tg_load_avg_contrib is not updated
    ...
    parent cfs_rq is decayed
      list_del_leaf_cfs_rq parent cfs_rq
	  - but it still contibutes to tg->load_avg

we must set UPDATE_TG flags when propagting pending load to the parent

Fixes: 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balancing path")
Reported-by: Odin Ugedal <odin@uged.al>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2859545d95fb..dcb3b1a6813c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8048,7 +8048,7 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
 		/* Propagate pending load changes to the parent, if any: */
 		se = cfs_rq->tg->se[cpu];
 		if (se && !skip_blocked_update(se))
-			update_load_avg(cfs_rq_of(se), se, 0);
+			update_load_avg(cfs_rq_of(se), se, UPDATE_TG);
 
 		/*
 		 * There can be a lot of idle CPU cgroups.  Don't let fully
-- 
2.17.1

