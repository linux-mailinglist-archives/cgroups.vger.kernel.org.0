Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911FA3489E0
	for <lists+cgroups@lfdr.de>; Thu, 25 Mar 2021 08:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhCYG6x (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Mar 2021 02:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhCYG6Y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Mar 2021 02:58:24 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A3EC06174A;
        Wed, 24 Mar 2021 23:58:24 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id m7so846449pgj.8;
        Wed, 24 Mar 2021 23:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Qko9xgJWdOHvuiNbVOg4Moyiw5zlG2MS/A0wr9gMovI=;
        b=gPAx01xm/r3iBawJ1NuBPdBcHS3OM1cuHtXiXwjkO9IJTncPqMSyYWAyOPZovOy7+M
         HKXJZuHXPuOl/J9elmeo6iMwBmeyFrz00y071+NCTvU1nq1hj/j/84H6Oa4uwPQ9/+Ae
         IqfRId9AUwEcQaNy0eow2CeBabWIFg6tAS2jOAs3kAnJshCm9bwwS/uWGs15p/bgKvhG
         5bCKxZEFicPLPckJHicYsivZIHUpFKQeDmMOPVnwV42vWhPnBQ5dWejb4wD2klnEdx7i
         YHerNeGnF96sZM7WaDwpZ5MgykN+gp4OWExqZxgwT7LLZB30esjasWGaanZ3mwDbmoMP
         S3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Qko9xgJWdOHvuiNbVOg4Moyiw5zlG2MS/A0wr9gMovI=;
        b=TI1SeYN4vqwHxlzmXW7qkWgfPEf8mWSDTu9woPOu44hnMrdsmALj4SNIUcgp7t35b2
         FsTAAASCZEhoIe4gLg+bm/w3NM8b7unDd0lpXevntcwok0exWMrSsGDiSe+kEuj9M2ZM
         1jbpVPtVu7fe/hbaJCIiUuH3MrQCEtRNW9CoWz30l0sesYAb+EpawVLRUaMXiL8OV0a5
         4CWM2ZcCDR5F1Qnq7R0tT5bwVzNOFxxr6gOCuWgfLsogRvfshNHX4s5SdQzqQPaWFbwe
         vxEo5/4UUkukeFqCDZniA8k/JDEYDUhwtz3HmjTEIQIiIiGt0fWNffeYyppFgGlSCSdN
         GMqg==
X-Gm-Message-State: AOAM533+FQS2Hay4Lx7NaJ/xmQWNCSpLkgA87qXKej4gvi2T7DYyySf6
        Es/kWdZJ9r7MXH3rruB9HXD9E2Z4VOVStw==
X-Google-Smtp-Source: ABdhPJyvhVqGOfV5uRqb8z7mZY7SdpvMDKbWrtNxGfRzie10U+0EXk5nqLEsRcmHe2i8BUxnvddegA==
X-Received: by 2002:a63:d17:: with SMTP id c23mr6496803pgl.251.1616655504283;
        Wed, 24 Mar 2021 23:58:24 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id x19sm4470202pfc.152.2021.03.24.23.58.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Mar 2021 23:58:24 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/14] bfq: remove unnecessary initialization logic
Date:   Thu, 25 Mar 2021 14:57:57 +0800
Message-Id: <e26a3b14976a833e1350799f84f49c10a50e3705.1616649216.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1616649216.git.brookxu@tencent.com>
References: <cover.1616649216.git.brookxu@tencent.com>
In-Reply-To: <cover.1616649216.git.brookxu@tencent.com>
References: <cover.1616649216.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Since we will initialize sched_data.service_tree[] in
bfq_init_root_group(), bfq_create_group_hierarchy() can
ignore this part of the initialization, which can avoid
repeated initialization.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-cgroup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index ab4bc41..05054e1 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1514,15 +1514,11 @@ void bfqg_and_blkg_put(struct bfq_group *bfqg) {}
 struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, int node)
 {
 	struct bfq_group *bfqg;
-	int i;
 
 	bfqg = kmalloc_node(sizeof(*bfqg), GFP_KERNEL | __GFP_ZERO, node);
 	if (!bfqg)
 		return NULL;
 
-	for (i = 0; i < BFQ_IOPRIO_CLASSES; i++)
-		bfqg->sched_data.service_tree[i] = BFQ_SERVICE_TREE_INIT;
-
 	return bfqg;
 }
 #endif	/* CONFIG_BFQ_GROUP_IOSCHED */
-- 
1.8.3.1

