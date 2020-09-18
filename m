Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F3A26EA19
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 02:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgIRApN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Sep 2020 20:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgIRApH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Sep 2020 20:45:07 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1D5C06174A;
        Thu, 17 Sep 2020 17:45:07 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q63so4376144qkf.3;
        Thu, 17 Sep 2020 17:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ESbogjuwusL6bG2HVAbKfWJT6Gw8rmatSqGwZlkX8AM=;
        b=KqiKjo8ece3zoqRHEClfRRBiJtjRdILsq3RELTwgDJTBWNqze7+GKFNAm9neqmm+OQ
         52HxffH349WPSwZiaNBwfEyEsEamhZjpUqxpN3ieLKeofn5LOBX6kxj0OKSY3m1LIbpd
         qFra6bKLan2OQC7JKa8wFCMbLb6T7x+36jvPnVfrzB6lP6q8/v9iqUYTrVZN9CQQY2Z+
         VEYXy9ugIPOGpmri/WTCKNgpvxYnK13V3F3GNtS86ZIS32JadBE4xJ1xqgMvvDpzqKbj
         b6EV/XPGPg8QCjW6+EX6jQRjJzQTTGGnngfemHP5O59D/yLoYAVvpv6g5C0C7juRoq87
         Sxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ESbogjuwusL6bG2HVAbKfWJT6Gw8rmatSqGwZlkX8AM=;
        b=JaCHKVQh7SyNWOWRgcnZr2IXlifQn3jpxAixGZywLU3S7n9PX4jXdhLqMTH+j0Bxwl
         706O0mllZ+MfLtR3eEijMk2ck+seKa4o2i0/5QNBQKnrVYBPs9hecxScSbKoSkZl8Qd9
         SnIA9zMqltZQ44E4KETP1ark/SSrvAbSmPD25XfMlTOxTvBza1s6aEJ8sWrqy88nemRU
         9dx/XvRf9ODpCk58tB8MkcYwLH0HUJFIA/cxJnXwcErPOLPd20a1cYzyvKUmrmK81bWG
         xtjOkzxVmFe5pElV30b+X9uG4TXmMbJlKZbBPMZOfLidtpUGBSNFALGHGwrIHJauHHvD
         TkSA==
X-Gm-Message-State: AOAM531WrEVWLqTVEPGo5QwryxTJw/uGlxPVACet2zq5CGxZxr+kbiOQ
        0BYyiqqWSJAgsJAf/OQUjfk=
X-Google-Smtp-Source: ABdhPJxw5JyhewjwQ+K9jESelogQrwQJJ6oATw4UQK3z550KIq+hs2nwK0XFHfm6IJhd+C+XHJusVQ==
X-Received: by 2002:a37:cc7:: with SMTP id 190mr31141841qkm.388.1600389906216;
        Thu, 17 Sep 2020 17:45:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:6893])
        by smtp.gmail.com with ESMTPSA id 2sm1041620qtg.20.2020.09.17.17.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 17:45:05 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/5] iocost: recalculate delay after debt reduction
Date:   Thu, 17 Sep 2020 20:44:54 -0400
Message-Id: <20200918004456.593983-4-tj@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200918004456.593983-1-tj@kernel.org>
References: <20200918004456.593983-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Debt sets the initial delay duration which is decayed over time. The current
debt reduction halved the debt but didn't change the delay. It prevented
future debts from increasing delay but didn't do anything to lower the
existing delay, limiting the mechanism's ability to reduce unnecessary
idling.

Reset iocg->delay to 0 after debt reduction so that iocg_kick_waitq()
recalculates new delay value based on the reduced debt amount.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index c0499c294da9..ffcb78126ab7 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1984,7 +1984,8 @@ static void transfer_surpluses(struct list_head *surpluses, struct ioc_now *now)
  * up blocked paying its debt while the IO device is idle.
  *
  * The following protects against such cases. If the device has been
- * sufficiently idle for a while, the debts are halved.
+ * sufficiently idle for a while, the debts are halved and delays are
+ * recalculated.
  */
 static void ioc_forgive_debts(struct ioc *ioc, u64 usage_us_sum, int nr_debtors,
 			      struct ioc_now *now)
@@ -2002,6 +2003,7 @@ static void ioc_forgive_debts(struct ioc *ioc, u64 usage_us_sum, int nr_debtors,
 			if (iocg->abs_vdebt) {
 				spin_lock(&iocg->waitq.lock);
 				iocg->abs_vdebt /= 2;
+				iocg->delay = 0; /* kick_waitq will recalc */
 				iocg_kick_waitq(iocg, true, now);
 				spin_unlock(&iocg->waitq.lock);
 			}
-- 
2.26.2

