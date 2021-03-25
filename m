Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D50E3489B1
	for <lists+cgroups@lfdr.de>; Thu, 25 Mar 2021 07:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhCYG6v (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Mar 2021 02:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhCYG6T (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Mar 2021 02:58:19 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6933BC06174A;
        Wed, 24 Mar 2021 23:58:19 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id e33so826520pgm.13;
        Wed, 24 Mar 2021 23:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=DeBrNab0KU7KzKaG5m2cKOd/Gyr3Wt1IGcfHEMz36Qo=;
        b=Gp+SaexnPkH/P50XCFy/6XBBnQQBLSdHcmjcap9YMg+BTzmyVFYSrHpOXCz5QJyXWo
         2qa2TcycVdUxzmf/yiC84yw/4NTKRbSwNmv3ef9V9Cuvv5xtlnxi4NDUdDO6pTsEVI+P
         u3f6OVZRBLLYrGQczOMyCwXQOWjurtcr12+85iVo4J3XTlfCayowMKHno4y7iY7rH1xj
         SKBxVVQ3GZ9tkGRIL3FQAJQXo0W3u42eDVZKLpHyNbnDC6lrFxN/JXeuSjPthkJlK+Bo
         UHjgHAodVbbY7BEGztcTi5CYemjF1q+6uURfEFfgkvImU7Sb3m+lPNxq+ZxZKKa0q/S0
         0A9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=DeBrNab0KU7KzKaG5m2cKOd/Gyr3Wt1IGcfHEMz36Qo=;
        b=YnQRvIvlR5/ZcNIc8M/WAbcqiSKVujUPJ/PebuUsh4NkOSDoRGwEdE0KEZoXJShfV2
         JYGeyVwcgYgSvdU1O2B9sKlhH/rjWBcF41Hm0iwcO5kDoM1mXq0neoytf+zo8O9arNuz
         P4jLVa5MEPRM7DjiMkKCis44yCE9YtakrL5BSz+j3h44e06zGeni/jLT8CyUr+y3JoyF
         17lK/GoH7x9hQrMNChZezUYt4SJsgpnKF9x3B4E5W2qI5sDYWp1OGu/RvIWpzqFJ6jab
         exZty209QmJRZD/W8SrHu9UyTIpQ/Mdne3d8aKbVVooYA8YtX+w9BtWL4FzZ0viCwLRQ
         r/3A==
X-Gm-Message-State: AOAM533fDTmQ+Q6FGH6oO1rsIUEj0jgXOVC3e61JH56maaC5t58k+e5l
        D7sz5D5Fcw2TgKbU32oTSRo=
X-Google-Smtp-Source: ABdhPJwA0LpKsYpBQ026ARMlb0muO0GRft0BxLsd+ZoBLvx3hR/f72NZevVn7tCWtxsbuRaUG+mshg==
X-Received: by 2002:aa7:808d:0:b029:1ed:993c:3922 with SMTP id v13-20020aa7808d0000b02901ed993c3922mr6384860pff.75.1616655499013;
        Wed, 24 Mar 2021 23:58:19 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id x19sm4470202pfc.152.2021.03.24.23.58.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Mar 2021 23:58:18 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/14] bfq: optimize IO injection under better_fairness
Date:   Thu, 25 Mar 2021 14:57:54 +0800
Message-Id: <d572933d913b4c38808446abe263b24bdac38098.1616649216.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1616649216.git.brookxu@tencent.com>
References: <cover.1616649216.git.brookxu@tencent.com>
In-Reply-To: <cover.1616649216.git.brookxu@tencent.com>
References: <cover.1616649216.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

In order to ensure better Qos of tasks of different groups
and different classes under better_fairness, we only allow
the queues of the same class in the same group can be
injected.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-iosched.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 51192bd..be5b1e3 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1900,6 +1900,27 @@ static void bfq_reset_inject_limit(struct bfq_data *bfqd,
 	bfqq->decrease_time_jif = jiffies;
 }
 
+static bool bfq_bfqq_may_inject(struct bfq_queue *bfqq, struct bfq_queue *new_bfqq)
+{
+	struct bfq_data *bfqd = bfqq->bfqd;
+	bool ret = true;
+
+	if (unlikely(bfqd->better_fairness)) {
+		/*
+		 * In addition to throughput, better_fairness also pays
+		 * attention to Qos. In the container scenario, in order
+		 * to ensure the Qos of each group we only allow tasks
+		 * of the same class in the same group to be injected.
+		 */
+		if (bfq_class(bfqq) != bfq_class(new_bfqq))
+			ret = false;
+
+		if (bfqq_group(bfqq) != bfqq_group(new_bfqq))
+			ret = false;
+	}
+	return ret;
+}
+
 static void bfq_update_io_intensity(struct bfq_queue *bfqq, u64 now_ns)
 {
 	u64 tot_io_time = now_ns - bfqq->io_start_time;
@@ -1985,7 +2006,8 @@ static void bfq_check_waker(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	    bfqd->last_completed_rq_bfqq == bfqq ||
 	    bfq_bfqq_has_short_ttime(bfqq) ||
 	    now_ns - bfqd->last_completion >= 4 * NSEC_PER_MSEC ||
-	    bfqd->last_completed_rq_bfqq == bfqq->waker_bfqq)
+	    bfqd->last_completed_rq_bfqq == bfqq->waker_bfqq ||
+	    !bfq_bfqq_may_inject(bfqq, bfqd->last_completed_rq_bfqq))
 		return;
 
 	if (bfqd->last_completed_rq_bfqq !=
@@ -4415,6 +4437,9 @@ static bool bfq_bfqq_must_idle(struct bfq_queue *bfqq)
 			else
 				limit = in_serv_bfqq->inject_limit;
 
+			if (!bfq_bfqq_may_inject(in_serv_bfqq, bfqq))
+				continue;
+
 			if (bfqd->rq_in_driver < limit) {
 				bfqd->rqs_injected = true;
 				return bfqq;
@@ -4590,6 +4615,7 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 		 * happen to be served only after other queues.
 		 */
 		if (async_bfqq &&
+		    !(bfqd->better_fairness && !bfq_class_idx(&bfqq->entity)) &&
 		    icq_to_bic(async_bfqq->next_rq->elv.icq) == bfqq->bic &&
 		    bfq_serv_to_charge(async_bfqq->next_rq, async_bfqq) <=
 		    bfq_bfqq_budget_left(async_bfqq))
-- 
1.8.3.1

