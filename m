Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C48826EA15
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 02:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgIRApE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Sep 2020 20:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgIRApD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Sep 2020 20:45:03 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB33C06174A;
        Thu, 17 Sep 2020 17:45:03 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id h6so3591687qtd.6;
        Thu, 17 Sep 2020 17:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fpm0/fWCrM1vVyvEQSMysbCeUT3o5wyc4wLO+mMphzI=;
        b=EAkqxPk9U1A/FBgCCtf77AqQVFTNOOZPp+CyRxx9IQl/l8Lmbav99naCkjEybqG8Ra
         4KcUi/0Zpq+8+NM6rqcx1BqCqJjbUF80x8X6Vk5Z7NghUcAPxutVuKp1TL7E4xFsOWwy
         8jIMGhFSKalQU8ky4mSciIceYca1kGVrxHAdhAN2kNYdlxTGVrBMkIVBstZcbLRZ4ddk
         pFBnqqMN3JyR3VDod6GBpM3ELjWtb0mUs/KPcPE4i5TqQzxOdebikE0/SWX4q/4XhOSf
         VHD3Yb5sg4upVKv0QPQs+2Fr7iMSwd6Z4XfMqjGwb/3GwCCgs4XK3oKLivk+x6mGyV8V
         7Rcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=fpm0/fWCrM1vVyvEQSMysbCeUT3o5wyc4wLO+mMphzI=;
        b=UxHPX4C9TkjPxnqDqkr7MYIMMLBc31dsLYg3mWWo9gdt+QQx0IGScqbfUw+oZz39F2
         P7tkjm4MqIEmwXGzRd9TUPknSNXSfHfeKEtMRwGR3q/R7DIN565Ry/lAZOROHNYZDcwu
         /rQ4Jp1aECxZ3yhdN0SJ5zKBxiCgoJw7U5tSt+BKPP4daYtdYuGrP6YCIgwh5wzIeRM4
         7xc2j7rP5erZt/tEDG7zfREtqak7hF7I0XxMWMeJqX5xf3B6w2J1H0x1rBIUH5S8l66n
         UC9Ofbc3mA2Qp3CfSvlca8niZXykbHMdzQzGKSk12ICmovVsLfn3PLRWNI2zEvyhQw0y
         ngBw==
X-Gm-Message-State: AOAM531LwnPLvZOE79QeBNOW1Ak6h703CNtjraREyfiIq7nIbYds6p74
        5VLVUge6oqLmYs6bm9+fjN2dHLQHdIJfFA==
X-Google-Smtp-Source: ABdhPJxFr1BGHZEuXI816xZfhdR3MHSYta9ZEh10uPfzJvn1z1mOKNoOF9aIPiLwW3Hv8PiCsdzIwA==
X-Received: by 2002:ac8:4d01:: with SMTP id w1mr31942466qtv.357.1600389902084;
        Thu, 17 Sep 2020 17:45:02 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:6893])
        by smtp.gmail.com with ESMTPSA id f189sm1032980qkd.20.2020.09.17.17.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 17:45:01 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/5] iocost: factor out ioc_forgive_debts()
Date:   Thu, 17 Sep 2020 20:44:52 -0400
Message-Id: <20200918004456.593983-2-tj@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200918004456.593983-1-tj@kernel.org>
References: <20200918004456.593983-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Debt reduction logic is going to be improved and expanded. Factor it out
into ioc_forgive_debts() and generalize the comment a bit. No functional
change.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c | 66 ++++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 31 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index ef9476fca1d8..bbf30bb06c07 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1979,6 +1979,40 @@ static void transfer_surpluses(struct list_head *surpluses, struct ioc_now *now)
 		list_del_init(&iocg->walk_list);
 }
 
+/*
+ * A low weight iocg can amass a large amount of debt, for example, when
+ * anonymous memory gets reclaimed aggressively. If the system has a lot of
+ * memory paired with a slow IO device, the debt can span multiple seconds or
+ * more. If there are no other subsequent IO issuers, the in-debt iocg may end
+ * up blocked paying its debt while the IO device is idle.
+ *
+ * The following protects against such cases. If the device has been
+ * sufficiently idle for a while, the debts are halved.
+ */
+static void ioc_forgive_debts(struct ioc *ioc, u64 usage_us_sum, int nr_debtors,
+			      int nr_shortages, struct ioc_now *now)
+{
+	if (nr_shortages ||
+	    div64_u64(100 * usage_us_sum, now->now - ioc->period_at) >=
+	    DEBT_BUSY_USAGE_PCT)
+		ioc->debt_busy_at = now->now;
+
+	if (nr_debtors &&
+	    now->now - ioc->debt_busy_at >= DEBT_REDUCTION_IDLE_DUR) {
+		struct ioc_gq *iocg;
+
+		list_for_each_entry(iocg, &ioc->active_iocgs, active_list) {
+			if (iocg->abs_vdebt) {
+				spin_lock(&iocg->waitq.lock);
+				iocg->abs_vdebt /= 2;
+				iocg_kick_waitq(iocg, true, now);
+				spin_unlock(&iocg->waitq.lock);
+			}
+		}
+		ioc->debt_busy_at = now->now;
+	}
+}
+
 static void ioc_timer_fn(struct timer_list *timer)
 {
 	struct ioc *ioc = container_of(timer, struct ioc, timer);
@@ -2171,37 +2205,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 	list_for_each_entry_safe(iocg, tiocg, &surpluses, surplus_list)
 		list_del_init(&iocg->surplus_list);
 
-	/*
-	 * A low weight iocg can amass a large amount of debt, for example, when
-	 * anonymous memory gets reclaimed aggressively. If the system has a lot
-	 * of memory paired with a slow IO device, the debt can span multiple
-	 * seconds or more. If there are no other subsequent IO issuers, the
-	 * in-debt iocg may end up blocked paying its debt while the IO device
-	 * is idle.
-	 *
-	 * The following protects against such pathological cases. If the device
-	 * has been sufficiently idle for a substantial amount of time, the
-	 * debts are halved. The criteria are on the conservative side as we
-	 * want to resolve the rare extreme cases without impacting regular
-	 * operation by forgiving debts too readily.
-	 */
-	if (nr_shortages ||
-	    div64_u64(100 * usage_us_sum, now.now - ioc->period_at) >=
-	    DEBT_BUSY_USAGE_PCT)
-		ioc->debt_busy_at = now.now;
-
-	if (nr_debtors &&
-	    now.now - ioc->debt_busy_at >= DEBT_REDUCTION_IDLE_DUR) {
-		list_for_each_entry(iocg, &ioc->active_iocgs, active_list) {
-			if (iocg->abs_vdebt) {
-				spin_lock(&iocg->waitq.lock);
-				iocg->abs_vdebt /= 2;
-				iocg_kick_waitq(iocg, true, &now);
-				spin_unlock(&iocg->waitq.lock);
-			}
-		}
-		ioc->debt_busy_at = now.now;
-	}
+	ioc_forgive_debts(ioc, usage_us_sum, nr_debtors, nr_shortages, &now);
 
 	/*
 	 * If q is getting clogged or we're missing too much, we're issuing
-- 
2.26.2

