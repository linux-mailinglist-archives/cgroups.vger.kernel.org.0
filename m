Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2AD3489B4
	for <lists+cgroups@lfdr.de>; Thu, 25 Mar 2021 07:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhCYG6y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Mar 2021 02:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhCYG60 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Mar 2021 02:58:26 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98726C06174A;
        Wed, 24 Mar 2021 23:58:26 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so515369pjg.5;
        Wed, 24 Mar 2021 23:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=o1CvHWMNIVE9JRrHuZNAemnGtuIBJ5AIryKfD1r6v+8=;
        b=WhK2TyCXaTs5nWrXgXWnQsFcAVspW+OYbTmTY1PFOrUpXe7RBtPozCnn0xEc5Qy4eE
         8yfrTdCLndDjDf18f4IOpLauyPoXRE/W0828gduqXyl2vBp06UZ77uoCknocQdBk5inR
         dfNe8bQuUdeiTFpTuvsJfP2XKBgDX0Egzn4Rq0agjFHydy27vVfUhGMbaOginJwoFTPo
         Ke4/UfL/shnb3yXKJjIRHHnJNqWiPIK0Ji1Qx+yKkYUngmycm82Xrm4ew4b9SoWVJwF6
         70BDWtIclqhyQxdyAlby3e7B347wzJf2UMdFXxokiZ/6XhkiWAwcn1uf8mV5sNsb90Zg
         vE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=o1CvHWMNIVE9JRrHuZNAemnGtuIBJ5AIryKfD1r6v+8=;
        b=Gz7JODLh4KkynRE4DC1F05F563FEBvTDz+5XuAp4Vkmeiqny5BhOLjQM+C58pEq9ZJ
         ldrcR2N2eo9RweCLhVSbclj2/kNOflnAyGaqUwEYKX2Zl7drxIIyetc8My0uQn++ngLF
         otux8zkA5gXBVgWFenLe/nifohqukYK1Nwr7VyKSiOLpJsc6lYSAyPVm95L6qe/Qu8UX
         FSjAqmMyOTsKOVTbZfXsSqif9M5E5KQqx8ZvDdjYT5GJL931qVBEmud4cvCqvFkVitHv
         FbTB4IsUR+BybHXoNr/fok5kli3u64EWzoSdJzjsugI9RQUSqovlSOyNbyFUksEci3qA
         +XUg==
X-Gm-Message-State: AOAM533WOaGp2j7UCR2/Smd2wGOu5qUxKqU9V+X34Z2/UWe5C2ltAwAQ
        8mG5OI5NCoGTDnyUU0mIofw/SMDErWojFw==
X-Google-Smtp-Source: ABdhPJzUNdaogeNBEnC+EmL59MLkV0as67JwWbBW+WHXYEyRO5zUNhjpHveDJhruO3f/WQEwKYrdUw==
X-Received: by 2002:a17:90a:eac7:: with SMTP id ev7mr7501137pjb.158.1616655506236;
        Wed, 24 Mar 2021 23:58:26 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id x19sm4470202pfc.152.2021.03.24.23.58.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Mar 2021 23:58:25 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/14] bfq: optimize the calculation of bfq_weight_to_ioprio()
Date:   Thu, 25 Mar 2021 14:57:58 +0800
Message-Id: <0d36b7d249e0890298e222424f524d3f9bfedbc8.1616649216.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1616649216.git.brookxu@tencent.com>
References: <cover.1616649216.git.brookxu@tencent.com>
In-Reply-To: <cover.1616649216.git.brookxu@tencent.com>
References: <cover.1616649216.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

The value range of ioprio is [0, 7], but the result of
bfq_weight_to_ioprio() may exceed this range, so simple
optimization is required.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-wf2q.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index b477a9b..1b91c8b 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -586,8 +586,9 @@ unsigned short bfq_ioprio_to_weight(int ioprio)
  */
 static unsigned short bfq_weight_to_ioprio(int weight)
 {
-	return max_t(int, 0,
-		     IOPRIO_BE_NR * BFQ_WEIGHT_CONVERSION_COEFF - weight);
+	int ioprio = IOPRIO_BE_NR  - weight / BFQ_WEIGHT_CONVERSION_COEFF;
+
+	return ioprio < 0 ? 0 : min_t(int, ioprio, IOPRIO_BE_NR - 1);
 }
 
 static void bfq_get_entity(struct bfq_entity *entity)
-- 
1.8.3.1

