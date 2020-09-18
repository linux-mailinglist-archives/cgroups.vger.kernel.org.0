Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B5926EA17
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 02:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgIRApM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Sep 2020 20:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgIRApL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Sep 2020 20:45:11 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1460C06178A;
        Thu, 17 Sep 2020 17:45:10 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g72so4354107qke.8;
        Thu, 17 Sep 2020 17:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mKtA7cFsHNh8hYHY7vxbi2vKeig9nNldo1RjIq6TDkU=;
        b=qEUz8l3TjyhsGosmXReNkCXnNOUMnbuhorgcWpRVoMfslfF8hO0Z5BXLsGJ1eOA/YQ
         B/FJJyDVE+YoC/n5s19IhlY5KOzaDWsulPXgRRPl7m/2HV8UYEPh+Y7deLQjqLMoogD5
         q/I2xRsP1X1d9aMY0QgP2C+Eohq109DY5E4dtT6MZWUc5vLE8gF0gOB8xokWY68MiENL
         OOTeZVRCNo4yFZ9ZZ6jSDJGKf73eKQpEV8U+D6gLO532hS38I1AwwrnGxI6LK75Lei+F
         SFYqsZ1NDgmJtBFZbeMnCGOKsef3Pc4dcwqjay5YgwrIERh9W80ioJxhA7i4yoyUAClm
         WeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mKtA7cFsHNh8hYHY7vxbi2vKeig9nNldo1RjIq6TDkU=;
        b=GLaeVKx7ux0eM8L7Fsy1LGwcSdi/gYa7awloTdfZQ2+XUVrXkfbwI13yLbPk4J7Jns
         m1jqtcdZrbhueHKro/rGM3MxH/X29k9U3pihOMCbS3jLFj6ZIvcX2A475E4ggkmSB5JI
         6rt4/3Jfs0+fQmhQZpQxHEouVz7+B38hGsMwAPmb39RpILjLMzriPIVAHTvy2WCsxiCw
         8g9skdptRAIZw8LnMGASc3aC/MuqVFJJiQA0Lr3pPY3lHn1ExYuCDXIqtgOymIrvRN9c
         KWM+qJHyAeqve3i09WM3Zsc2t55RbL7tB64PeGRDyOsFd9lxGzt3IVo6g+Zr7WLsGM1o
         kWOg==
X-Gm-Message-State: AOAM533gqtViGjUhMgTbdKdVPO9j5tDSxsqMf1xM6zOn9f5gzOVhci3O
        UZ9dW5k68jZSU6rOtzihycU=
X-Google-Smtp-Source: ABdhPJyz9fH33yXfplmTghMymIBJ67u130kv7OxYBvln1bqjnQ2+xHKNecNuQseRlxGekhe8CIveVA==
X-Received: by 2002:a37:2715:: with SMTP id n21mr31314550qkn.401.1600389910170;
        Thu, 17 Sep 2020 17:45:10 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:6893])
        by smtp.gmail.com with ESMTPSA id a24sm1024239qko.82.2020.09.17.17.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 17:45:09 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/5] iocost: add iocg_forgive_debt tracepoint
Date:   Thu, 17 Sep 2020 20:44:56 -0400
Message-Id: <20200918004456.593983-6-tj@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200918004456.593983-1-tj@kernel.org>
References: <20200918004456.593983-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c            | 12 ++++++++++
 include/trace/events/iocost.h | 41 +++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 9b1f94499432..328ae805e85f 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2046,12 +2046,24 @@ static void ioc_forgive_debts(struct ioc *ioc, u64 usage_us_sum, int nr_debtors,
 	ioc->dfgv_period_rem = do_div(nr_cycles, DFGV_PERIOD);
 
 	list_for_each_entry(iocg, &ioc->active_iocgs, active_list) {
+		u64 __maybe_unused old_debt, __maybe_unused old_delay;
+
 		if (!iocg->abs_vdebt)
 			continue;
+
 		spin_lock(&iocg->waitq.lock);
+
+		old_debt = iocg->abs_vdebt;
+		old_delay = iocg->delay;
+
 		iocg->abs_vdebt >>= nr_cycles;
 		iocg->delay = 0; /* kick_waitq will recalc */
 		iocg_kick_waitq(iocg, true, now);
+
+		TRACE_IOCG_PATH(iocg_forgive_debt, iocg, now, usage_pct,
+				old_debt, iocg->abs_vdebt,
+				old_delay, iocg->delay);
+
 		spin_unlock(&iocg->waitq.lock);
 	}
 }
diff --git a/include/trace/events/iocost.h b/include/trace/events/iocost.h
index b350860d2e71..0b6869980ba2 100644
--- a/include/trace/events/iocost.h
+++ b/include/trace/events/iocost.h
@@ -164,6 +164,47 @@ TRACE_EVENT(iocost_ioc_vrate_adj,
 	)
 );
 
+TRACE_EVENT(iocost_iocg_forgive_debt,
+
+	TP_PROTO(struct ioc_gq *iocg, const char *path, struct ioc_now *now,
+		u32 usage_pct, u64 old_debt, u64 new_debt,
+		u64 old_delay, u64 new_delay),
+
+	TP_ARGS(iocg, path, now, usage_pct,
+		old_debt, new_debt, old_delay, new_delay),
+
+	TP_STRUCT__entry (
+		__string(devname, ioc_name(iocg->ioc))
+		__string(cgroup, path)
+		__field(u64, now)
+		__field(u64, vnow)
+		__field(u32, usage_pct)
+		__field(u64, old_debt)
+		__field(u64, new_debt)
+		__field(u64, old_delay)
+		__field(u64, new_delay)
+	),
+
+	TP_fast_assign(
+		__assign_str(devname, ioc_name(iocg->ioc));
+		__assign_str(cgroup, path);
+		__entry->now = now->now;
+		__entry->vnow = now->vnow;
+		__entry->usage_pct = usage_pct;
+		__entry->old_debt = old_debt;
+		__entry->new_debt = new_debt;
+		__entry->old_delay = old_delay;
+		__entry->new_delay = new_delay;
+	),
+
+	TP_printk("[%s:%s] now=%llu:%llu usage=%u debt=%llu->%llu delay=%llu->%llu",
+		__get_str(devname), __get_str(cgroup),
+		__entry->now, __entry->vnow, __entry->usage_pct,
+		__entry->old_debt, __entry->new_debt,
+		__entry->old_delay, __entry->new_delay
+	)
+);
+
 #endif /* _TRACE_BLK_IOCOST_H */
 
 /* This part must be outside protection */
-- 
2.26.2

