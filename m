Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D0B3489B0
	for <lists+cgroups@lfdr.de>; Thu, 25 Mar 2021 07:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhCYG6w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Mar 2021 02:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhCYG6V (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Mar 2021 02:58:21 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF1CC06174A;
        Wed, 24 Mar 2021 23:58:20 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so526909pjb.2;
        Wed, 24 Mar 2021 23:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=IC6S0GoA+Bjxyq4aIxKh/SpT8Ze+znH1bLzroU/O1D0=;
        b=SPxdsKnog7hbJTjFckkX1eoumaCRAFblwQSCB9HJ7ZRF6kknKczdyVvqZix1IzZs79
         kvOuqXawdOV4IeoHb5+OD5Nv1gW9Vxs++KWuJSwwl8RNndWoBP5kImZyEWiLz5ioDJYP
         WxoJt99R1WFWMfrLD0+hbkUWp1OP1AzbV5GuD0+Gf9Fg477xEn/sdqFpwquvwoIQ1qKy
         Xdgh1aKMEwhRt0ceYGDhPbsTNSZ5PSBxrRzfB3oFtWp6veXSdL/PCX5BxXBM0hPJV+u8
         UDoyQk2T80gCWtfEVhMgRkst2E29x+RSisP7Zj7dYWNHTnKRWn6qTXflxR0MR2NswveL
         QpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IC6S0GoA+Bjxyq4aIxKh/SpT8Ze+znH1bLzroU/O1D0=;
        b=mvwmw3bveuRN5E5nVEljZOyJDkP6B3drdVtntYDasS3s4UheUwg08kYXVCfkpFBQvh
         1IBSaUS2KGBdtYVIh/At7X8ycSyGXkVcwVElV+kYxh0Y2ifvDPE1/kNS3vgfqDSLU386
         c4D0gbtZOsvCaoOhxwSNXZIQqjOdi7UnRwCwErhO/DVmNNEqT3pqjMh7NEQI4PfK6NJ8
         rbEZn3TfuTQg017Vq3BSHr19roKG0ljqPLh/ybXBkuxthwQQhR4ND05n/Qn0teNPICig
         0sr4l6wnNWsK+SGhdDkEzcJAkl7FZbi+P3HUCXyutMabboKX5o1D9GFgHK4FEwGmERfy
         JP+A==
X-Gm-Message-State: AOAM533UDzAt4sGvibUDJ2unxqlfMk0OZDrzigWcizUc31vSGRoEoz2z
        74j593Vc8svX8xxiTsSrhhc=
X-Google-Smtp-Source: ABdhPJyVPJpMxDjQLiVfvJvJPbU0v5BFyKvyzCQoPvUbHCY1kHuxzQ3slLVdlwbU3tH+zkejDqH4+w==
X-Received: by 2002:a17:90a:66c2:: with SMTP id z2mr7792493pjl.139.1616655500625;
        Wed, 24 Mar 2021 23:58:20 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id x19sm4470202pfc.152.2021.03.24.23.58.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Mar 2021 23:58:20 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/14] bfq: disable idle for prio_expire under better_fairness
Date:   Thu, 25 Mar 2021 14:57:55 +0800
Message-Id: <39653b15a904b5658b6fa23ad1021427ab18c15a.1616649216.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1616649216.git.brookxu@tencent.com>
References: <cover.1616649216.git.brookxu@tencent.com>
In-Reply-To: <cover.1616649216.git.brookxu@tencent.com>
References: <cover.1616649216.git.brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Under better_fairness, if higher priority queue is waiting
for service，disable queue idle, so that a schedule can be
invoked in time. In addition to CLASS_IDLE, other queues
allow idle, so that we can better control buffer IO too.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-iosched.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index be5b1e3..5aa9c2c 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4307,6 +4307,14 @@ static bool bfq_better_to_idle(struct bfq_queue *bfqq)
 		return true;
 
 	/*
+	 * In better_fairness mode, we also put emphasis on Qos. The main
+	 * purpose of allowing idle here is to ensure better isolation
+	 * of Buffer IO.
+	 */
+	if (unlikely(bfqd->better_fairness))
+		return !(bfqd->bfq_slice_idle == 0 || bfq_class_idle(bfqq));
+
+	/*
 	 * Idling is performed only if slice_idle > 0. In addition, we
 	 * do not idle if
 	 * (a) bfqq is async
@@ -4318,6 +4326,9 @@ static bool bfq_better_to_idle(struct bfq_queue *bfqq)
 	   bfq_class_idle(bfqq))
 		return false;
 
+	if (bfq_may_expire_in_serv_for_prio(&bfqq->entity))
+		return false;
+
 	idling_boosts_thr_with_no_issue =
 		idling_boosts_thr_without_issues(bfqd, bfqq);
 
-- 
1.8.3.1

