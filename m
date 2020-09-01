Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46EA1259E94
	for <lists+cgroups@lfdr.de>; Tue,  1 Sep 2020 20:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732012AbgIASzA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Sep 2020 14:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731783AbgIASyT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Sep 2020 14:54:19 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B19AC061244;
        Tue,  1 Sep 2020 11:54:18 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id o5so1982059qke.12;
        Tue, 01 Sep 2020 11:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H5bqavxbqk85onXAByeypQmTg/sTVdfkgjS7XfGpNMQ=;
        b=am9+85JN4GRBuF8BDWFu1kcmXapeiLESBbeO2JWuzObgkvndOBzUEW5c8Cs3bWO45B
         soo1wZFJVSJgViU3TVF/amCK2K8rK+5eU0g3FyLarODlyKoB7aB5pObEvWDHSAVfjdKn
         7A5fIa8Uep0kNYxTmTEiCxHdbm0pqDTvXTKl0rXbi/726sr87Kc19jUuKMRRz3mNmg6n
         i94zbBVxEVyd6TSJKNe8l5quOIiACN3/rQ1lG19Pw+cKwOLvUqJe02RiOWfyVHNVJ4lp
         O5fh3KrvfgaxTeRr0i2Q80Ymdy+n0Wd//ctPLB5EaYLvtUSInqMCAsJd979AnRbhMasQ
         QWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=H5bqavxbqk85onXAByeypQmTg/sTVdfkgjS7XfGpNMQ=;
        b=hk6yzeKcLE57uR081Y5UulZcno+JLxC+GlGtWu7lGmEIb0DAo2lce5Ur73tv9+acok
         q/njHVIAfFg801WFAjNVghib9iPB3m/JY7Xbas6jtMCI0Ox5jnc6qI6H+JEq0TIBwmn/
         y5AKX2uKl8ydMjaVyBMlj34bTO8JhvCKhvPZy0kfoCHmbvmHMHUu3rxCGWt7v42cyw/3
         w95m71kr3GfF394tqMo2HscvXdXAgzo1UcdJc/19Z7atVU0G1xGvrwIoyKhWO2BNRqUP
         Imdyoa6axvaRN8OhNI993MWQ0N6BJhusxd8vt3KDSDMy0o31QRHnSgyOyuzTAS+lD3aH
         i1IQ==
X-Gm-Message-State: AOAM5322TdzUfKDtlLvgamPnLXFPcdkQOwHSZ902dvrQExGxAGWvh+Ax
        jaP/mgZR2nkMJSKoV7+okIY=
X-Google-Smtp-Source: ABdhPJyO0a9oHk4MM+e9MbfpbLTA2zRCF+wakZ3DyQrCz6X3Pxd9oPmG2DZI4hGsAR4BuvSSS8jjrw==
X-Received: by 2002:a37:a281:: with SMTP id l123mr3271032qke.171.1598986457628;
        Tue, 01 Sep 2020 11:54:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a198])
        by smtp.gmail.com with ESMTPSA id r6sm2694793qkc.43.2020.09.01.11.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 11:54:17 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, newella@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 25/27] blk-iocost: restore inuse update tracepoints
Date:   Tue,  1 Sep 2020 14:52:55 -0400
Message-Id: <20200901185257.645114-26-tj@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901185257.645114-1-tj@kernel.org>
References: <20200901185257.645114-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Update and restore the inuse update tracepoints.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c            | 16 ++++++++++++++++
 include/trace/events/iocost.h |  6 +++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 0270a504e6b5..9366527d8c12 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1919,6 +1919,12 @@ static void transfer_surpluses(struct list_head *surpluses, struct ioc_now *now)
 		inuse = DIV64_U64_ROUND_UP(
 			parent->child_adjusted_sum * iocg->hweight_after_donation,
 			parent->hweight_inuse);
+
+		TRACE_IOCG_PATH(inuse_transfer, iocg, now,
+				iocg->inuse, inuse,
+				iocg->hweight_inuse,
+				iocg->hweight_after_donation);
+
 		__propagate_weights(iocg, iocg->active, inuse, true, now);
 	}
 
@@ -2076,6 +2082,10 @@ static void ioc_timer_fn(struct timer_list *timer)
 				iocg->hweight_after_donation = new_hwi;
 				list_add(&iocg->surplus_list, &surpluses);
 			} else {
+				TRACE_IOCG_PATH(inuse_shortage, iocg, &now,
+						iocg->inuse, iocg->active,
+						iocg->hweight_inuse, new_hwi);
+
 				__propagate_weights(iocg, iocg->active,
 						    iocg->active, true, &now);
 				nr_shortages++;
@@ -2248,11 +2258,13 @@ static u64 adjust_inuse_and_calc_cost(struct ioc_gq *iocg, u64 vtime,
 	struct ioc *ioc = iocg->ioc;
 	struct ioc_margins *margins = &ioc->margins;
 	u32 adj_step = DIV_ROUND_UP(iocg->active * INUSE_ADJ_STEP_PCT, 100);
+	u32 __maybe_unused old_inuse = iocg->inuse, __maybe_unused old_hwi;
 	u32 hwi;
 	s64 margin;
 	u64 cost, new_inuse;
 
 	current_hweight(iocg, NULL, &hwi);
+	old_hwi = hwi;
 	cost = abs_cost_to_cost(abs_cost, hwi);
 	margin = now->vnow - vtime - cost;
 
@@ -2287,6 +2299,10 @@ static u64 adjust_inuse_and_calc_cost(struct ioc_gq *iocg, u64 vtime,
 		 iocg->inuse != iocg->active);
 
 	spin_unlock_irq(&ioc->lock);
+
+	TRACE_IOCG_PATH(inuse_adjust, iocg, now,
+			old_inuse, iocg->inuse, old_hwi, hwi);
+
 	return cost;
 }
 
diff --git a/include/trace/events/iocost.h b/include/trace/events/iocost.h
index ee024fe8fef6..b350860d2e71 100644
--- a/include/trace/events/iocost.h
+++ b/include/trace/events/iocost.h
@@ -95,7 +95,7 @@ DECLARE_EVENT_CLASS(iocg_inuse_update,
 	)
 );
 
-DEFINE_EVENT(iocg_inuse_update, iocost_inuse_takeback,
+DEFINE_EVENT(iocg_inuse_update, iocost_inuse_shortage,
 
 	TP_PROTO(struct ioc_gq *iocg, const char *path, struct ioc_now *now,
 		u32 old_inuse, u32 new_inuse,
@@ -105,7 +105,7 @@ DEFINE_EVENT(iocg_inuse_update, iocost_inuse_takeback,
 		old_hw_inuse, new_hw_inuse)
 );
 
-DEFINE_EVENT(iocg_inuse_update, iocost_inuse_giveaway,
+DEFINE_EVENT(iocg_inuse_update, iocost_inuse_transfer,
 
 	TP_PROTO(struct ioc_gq *iocg, const char *path, struct ioc_now *now,
 		u32 old_inuse, u32 new_inuse,
@@ -115,7 +115,7 @@ DEFINE_EVENT(iocg_inuse_update, iocost_inuse_giveaway,
 		old_hw_inuse, new_hw_inuse)
 );
 
-DEFINE_EVENT(iocg_inuse_update, iocost_inuse_reset,
+DEFINE_EVENT(iocg_inuse_update, iocost_inuse_adjust,
 
 	TP_PROTO(struct ioc_gq *iocg, const char *path, struct ioc_now *now,
 		u32 old_inuse, u32 new_inuse,
-- 
2.26.2

