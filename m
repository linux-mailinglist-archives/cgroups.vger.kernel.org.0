Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD8B330CF2
	for <lists+cgroups@lfdr.de>; Mon,  8 Mar 2021 13:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhCHMAm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 Mar 2021 07:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbhCHMAf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 8 Mar 2021 07:00:35 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A547AC06175F;
        Mon,  8 Mar 2021 04:00:35 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso2986789pjb.3;
        Mon, 08 Mar 2021 04:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=+kTmKHq9zv3XGMbtsWeY32mKkijl5gEMIKMC+s/P+Co=;
        b=DAA7KXeIH95cxgwsQLL5AnnEDn/kBgAQ+5tuUAikWQsPAFy7TklwND3fH5aW5yhbea
         /op2WHfyZ55X8d5bFjKIed2hk+fjfJDUwD3DQzFSs75mmwSUoSY3WEVq1siy5XaT39RH
         gz3K6pIOmcCfftym8RWn9eLHtmKhJDiUtUskevuNA340Fjdb52ceRxWBroZCa/aze5oe
         MTdrD5JXKsVGYKyCcl7ZwPTw+ATAfLC3jxgLF5a+of7I5YfdY9Sq7yw2W/yLycwAkz+/
         qxEbdkfmyc2e1DsH1/EgZEuPGcocmFxjr3cur+FH/miRxBa5WEj2fvpSBQa4ghGO29mS
         fBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=+kTmKHq9zv3XGMbtsWeY32mKkijl5gEMIKMC+s/P+Co=;
        b=sY6E3DhTFJYHLTefD3TTE2Pc5yhmoIYi1eDqFctWC9X8553E4eTIMKQwhCOKGBLycP
         b8wEz+FpwJxZ5D87wbfzzQ3lSVCsDdwapQGnyteiHIy2EzmHdspQGFyAxY2BwHQLx5UM
         ISgsFwwS0LL2mF/HLqsn9D7XGUXo866Js2AZQTY4RHZouECUl3ChbJf+AldVaPatEXBh
         AcuVMgGaW5wh7UPv2CdBIRJdZHU8ECNORNgpvdEE+5hKBrLvjTbeIK8rHK80YziHfmM5
         gqBkczgUnU3xJXw7TsynnECLzNNKrGC5hVBccc2Ls844h1Yog5ScosPz1P6qal6ZmwiV
         9esg==
X-Gm-Message-State: AOAM532qKLhbkAK0qvGNyQlE121cXAejc52zAqjIwMjB+F5hK4mV2LtP
        VBcnxRrkDk1sW/XfBcrtd58=
X-Google-Smtp-Source: ABdhPJwVE1kPLdyQilajTGaqh5C094kYziVCmPwnBjpOwD1mPGva0OdDLYHltV7luoPuAwIjyWDWBQ==
X-Received: by 2002:a17:902:8641:b029:e4:7e05:c916 with SMTP id y1-20020a1709028641b02900e47e05c916mr19879207plt.57.1615204835304;
        Mon, 08 Mar 2021 04:00:35 -0800 (PST)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id mp19sm22570855pjb.2.2021.03.08.04.00.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Mar 2021 04:00:35 -0800 (PST)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 7/8] bfq: remove unnecessary initialization logic
Date:   Mon,  8 Mar 2021 20:00:20 +0800
Message-Id: <baf6d16ce98ef609c57a324166219003ab77e30c.1615203034.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1615203034.git.brookxu@tencent.com>
References: <cover.1615203034.git.brookxu@tencent.com>
In-Reply-To: <cover.1615203034.git.brookxu@tencent.com>
References: <cover.1615203034.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

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
index ab4bc410e635..05054e1b5d97 100644
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
2.30.0

