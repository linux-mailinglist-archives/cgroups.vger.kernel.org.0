Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3110D259E7C
	for <lists+cgroups@lfdr.de>; Tue,  1 Sep 2020 20:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbgIASyA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Sep 2020 14:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731761AbgIASxz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Sep 2020 14:53:55 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BCDC061244;
        Tue,  1 Sep 2020 11:53:54 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id d20so1999253qka.5;
        Tue, 01 Sep 2020 11:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W9a83GnSUegRN3aq2WoXDxZCM3FbBGqeK5GH+ZHyQQM=;
        b=Sn5CXW/oEMdzc5Gt1HU6u77M+wBIEpc5T8Nn2jWGaqsyzKTDbW9A0gR4v0fQ9A2SLF
         SiKpYQI0fJ/3cFymDBLZZKY8wtkhlTzY5FC/tGXq+mMSO6sAvHHyUP2Cpe0WCRRh5S51
         MYoKmye0Kq8w0tJCoUkaopTaNumWCduYyOeTAlBlbNFqyxUyi12A5lWAQr0LRuNJhYY/
         MRuPn6o+8MDCUmNK2gWYQkIxH3ASgcbDK8bs1dWX9xIyy6xWgl0fIHtm+ntd762jE5HC
         R4fSLhdyaH/5/YeKFXOcsc7uWdHy38d4f1QFu4lpjBQXLUJ0Vc99/k/bTCO4Zo+TvC7v
         gKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=W9a83GnSUegRN3aq2WoXDxZCM3FbBGqeK5GH+ZHyQQM=;
        b=YZNvoE6yXZT33ntRVuNJe6isMSbrYvAWuVCJkX6OVF+pq9ySG7pd15u9f0t2eAozQ8
         RH6LeVHZvk0IKLb0JS1aGK2GQ0jNBu18YMHzgTB919YKPZ/KKTt8s4SYwrPbWNIop4L8
         CPnMnxbWzqJcJObSaOhuW9yaYu2+hDnogmKxF5ee33meLS5lNBhFnwNmhk+luebN1msP
         6JhSvc1hxb+enaU3kv904Rc+5eZJtXykkrl1WehI1gujLoMKkMvLJywtdKDEsvIoaGEO
         aXnnbzakQiWzmeH3EVoJhbvN5PhKf52mEvbzHt5H8FiFid3xp8P+PCRicp+5MRG3ucQu
         udow==
X-Gm-Message-State: AOAM533or11nAuLKnn1zQp+OeP/kw76jt6rOgeIKuXJwip+gYW4X/W5K
        vPyTQ8I7KoQNZZ+ZVNItB7o=
X-Google-Smtp-Source: ABdhPJz2+2WxUDYy56VgqwLHTsVTQxppZsujilAbTKebn7Jwf2RduFUvodDK1dtgDwmEfpLn0usYeQ==
X-Received: by 2002:a37:e509:: with SMTP id e9mr3124998qkg.469.1598986433172;
        Tue, 01 Sep 2020 11:53:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a198])
        by smtp.gmail.com with ESMTPSA id g4sm2339857qth.30.2020.09.01.11.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 11:53:52 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, newella@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 16/27] blk-iocost: decouple vrate adjustment from surplus transfers
Date:   Tue,  1 Sep 2020 14:52:46 -0400
Message-Id: <20200901185257.645114-17-tj@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901185257.645114-1-tj@kernel.org>
References: <20200901185257.645114-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Budget donations are inaccurate and could take multiple periods to converge.
To prevent triggering vrate adjustments while surplus transfers were
catching up, vrate adjustment was suppressed if donations were increasing,
which was indicated by non-zero nr_surpluses.

This entangling won't be necessary with the scheduled rewrite of donation
mechanism which will make it precise and immediate. Let's decouple the two
in preparation.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c            | 19 +++++++------------
 include/trace/events/iocost.h | 13 ++++---------
 2 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index c1cd66cfa2a8..a3889a8b0a33 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1508,7 +1508,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 	struct ioc_gq *iocg, *tiocg;
 	struct ioc_now now;
 	LIST_HEAD(surpluses);
-	int nr_surpluses = 0, nr_shortages = 0, nr_lagging = 0;
+	int nr_shortages = 0, nr_lagging = 0;
 	u32 ppm_rthr = MILLION - ioc->params.qos[QOS_RPPM];
 	u32 ppm_wthr = MILLION - ioc->params.qos[QOS_WPPM];
 	u32 missed_ppm[2], rq_wait_pct;
@@ -1640,10 +1640,8 @@ static void ioc_timer_fn(struct timer_list *timer)
 			atomic64_add(delta, &iocg->vtime);
 			atomic64_add(delta, &iocg->done_vtime);
 			/* if usage is sufficiently low, maybe it can donate */
-			if (surplus_adjusted_hweight_inuse(usage, hw_inuse)) {
+			if (surplus_adjusted_hweight_inuse(usage, hw_inuse))
 				list_add(&iocg->surplus_list, &surpluses);
-				nr_surpluses++;
-			}
 		} else if (hw_inuse < hw_active) {
 			u32 new_hwi, new_inuse;
 
@@ -1673,7 +1671,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 		}
 	}
 
-	if (!nr_shortages || !nr_surpluses)
+	if (!nr_shortages || list_empty(&surpluses))
 		goto skip_surplus_transfers;
 
 	/* there are both shortages and surpluses, transfer surpluses */
@@ -1738,11 +1736,9 @@ static void ioc_timer_fn(struct timer_list *timer)
 
 			/*
 			 * If there are IOs spanning multiple periods, wait
-			 * them out before pushing the device harder.  If
-			 * there are surpluses, let redistribution work it
-			 * out first.
+			 * them out before pushing the device harder.
 			 */
-			if (!nr_lagging && !nr_surpluses)
+			if (!nr_lagging)
 				ioc->busy_level--;
 		} else {
 			/*
@@ -1796,15 +1792,14 @@ static void ioc_timer_fn(struct timer_list *timer)
 		}
 
 		trace_iocost_ioc_vrate_adj(ioc, vrate, missed_ppm, rq_wait_pct,
-					   nr_lagging, nr_shortages,
-					   nr_surpluses);
+					   nr_lagging, nr_shortages);
 
 		atomic64_set(&ioc->vtime_rate, vrate);
 		ioc_refresh_margins(ioc);
 	} else if (ioc->busy_level != prev_busy_level || nr_lagging) {
 		trace_iocost_ioc_vrate_adj(ioc, atomic64_read(&ioc->vtime_rate),
 					   missed_ppm, rq_wait_pct, nr_lagging,
-					   nr_shortages, nr_surpluses);
+					   nr_shortages);
 	}
 
 	ioc_refresh_params(ioc, false);
diff --git a/include/trace/events/iocost.h b/include/trace/events/iocost.h
index a905ecc0342f..ee024fe8fef6 100644
--- a/include/trace/events/iocost.h
+++ b/include/trace/events/iocost.h
@@ -128,11 +128,9 @@ DEFINE_EVENT(iocg_inuse_update, iocost_inuse_reset,
 TRACE_EVENT(iocost_ioc_vrate_adj,
 
 	TP_PROTO(struct ioc *ioc, u64 new_vrate, u32 *missed_ppm,
-		u32 rq_wait_pct, int nr_lagging, int nr_shortages,
-		int nr_surpluses),
+		u32 rq_wait_pct, int nr_lagging, int nr_shortages),
 
-	TP_ARGS(ioc, new_vrate, missed_ppm, rq_wait_pct, nr_lagging, nr_shortages,
-		nr_surpluses),
+	TP_ARGS(ioc, new_vrate, missed_ppm, rq_wait_pct, nr_lagging, nr_shortages),
 
 	TP_STRUCT__entry (
 		__string(devname, ioc_name(ioc))
@@ -144,7 +142,6 @@ TRACE_EVENT(iocost_ioc_vrate_adj,
 		__field(u32, rq_wait_pct)
 		__field(int, nr_lagging)
 		__field(int, nr_shortages)
-		__field(int, nr_surpluses)
 	),
 
 	TP_fast_assign(
@@ -157,15 +154,13 @@ TRACE_EVENT(iocost_ioc_vrate_adj,
 		__entry->rq_wait_pct = rq_wait_pct;
 		__entry->nr_lagging = nr_lagging;
 		__entry->nr_shortages = nr_shortages;
-		__entry->nr_surpluses = nr_surpluses;
 	),
 
-	TP_printk("[%s] vrate=%llu->%llu busy=%d missed_ppm=%u:%u rq_wait_pct=%u lagging=%d shortages=%d surpluses=%d",
+	TP_printk("[%s] vrate=%llu->%llu busy=%d missed_ppm=%u:%u rq_wait_pct=%u lagging=%d shortages=%d",
 		__get_str(devname), __entry->old_vrate, __entry->new_vrate,
 		__entry->busy_level,
 		__entry->read_missed_ppm, __entry->write_missed_ppm,
-		__entry->rq_wait_pct, __entry->nr_lagging, __entry->nr_shortages,
-		__entry->nr_surpluses
+		__entry->rq_wait_pct, __entry->nr_lagging, __entry->nr_shortages
 	)
 );
 
-- 
2.26.2

