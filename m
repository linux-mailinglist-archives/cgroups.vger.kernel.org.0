Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5441A338B2C
	for <lists+cgroups@lfdr.de>; Fri, 12 Mar 2021 12:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbhCLLJY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Mar 2021 06:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbhCLLJL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Mar 2021 06:09:11 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844FBC061574;
        Fri, 12 Mar 2021 03:09:11 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id t29so1603985pfg.11;
        Fri, 12 Mar 2021 03:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=T9l6k5OqXtfEirisuPLMZitzFU3x0IHKvGRBmuRDlLQ=;
        b=Gt865lGSosE/T4BW16U1yPG0jYVc3NdxxtP9Pd66qyhtwSv8Q5grSCA5RTm/buM6aL
         9QbLbKH1f8qHAak2n67AjGhs1iL4kBnc1SZmJBzrA8mgMSDEnKJ3FwMC9l0lTFbe90a0
         iY6n13l7NyU5i6HJ5zH75q20VJCRQtXXuM2lD9cx3cZM0k4FBde1K0JS6uJ5IjbAM07J
         mAE/X6bOQkORjeAZ3xiXZBrAGZ4C6ueGaPjCAfhKj+Pc3SjUkf2Fxq0QUJgpEqByJerw
         LCb7b6eTB2PcZ1NG+OlTXFgSXjcQ29I0ulqlfsjC2A/ZaJ2a3UrMIAf8Ty5L+Kembe8r
         g5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=T9l6k5OqXtfEirisuPLMZitzFU3x0IHKvGRBmuRDlLQ=;
        b=CYJgypqOiRCLVNZuyaxaiOjjoZ9cDzdkM6bGkz26hmQKq0Wb3qKqc0zRPAJxxbyA9i
         2vlLNwYreGJNh2ndH9hwa9IYwiYbB8UxPLsgMmtZOi241iBg/cuhvOXyJ76DgKLaCGK5
         /Us4h5TLdpuivaU4Je8XHVJbV/DI8FQfdj6CauwCBq4I1LSC0RKw1fk9pU55E6Bx0vHd
         W5vIEZMMqzCfgTA+Fuk17WZcFeMHhDD4OyyOkUYtJej2yfuDfdlDFnpbX1uGybHeO9TW
         uT9JLo/yiOMEoj7+oioDoR0aVewy5ZAzt7Y6/4BmaXLof8J9yWYg9UWqFGsFsWm4hSd/
         1A6A==
X-Gm-Message-State: AOAM530uPLD7bl6gM6jIL0W2WWqByGpXidUvxJiP93+uWp8jkyYQIMOO
        cRRAeRG7wkgIfMsM4Vlq0L0=
X-Google-Smtp-Source: ABdhPJy9G5gJnnGBZ9t7gdQqp0bXaQtCLsYb+yxvxnAUoO/hz6slcE7o1So1Cqw7WSA+4qZDTeBhuw==
X-Received: by 2002:a05:6a00:2292:b029:1ff:bcb8:91f9 with SMTP id f18-20020a056a002292b02901ffbcb891f9mr6512877pfe.63.1615547351188;
        Fri, 12 Mar 2021 03:09:11 -0800 (PST)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id t5sm4942181pgl.89.2021.03.12.03.09.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Mar 2021 03:09:10 -0800 (PST)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 10/11] bfq: remove unnecessary initialization logic
Date:   Fri, 12 Mar 2021 19:08:44 +0800
Message-Id: <dae42cd3c1c9f798a3c390e0a14ef77d02e94ce0.1615527324.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1615517202.git.brookxu@tencent.com>
References: <cover.1615517202.git.brookxu@tencent.com>
In-Reply-To: <cover.1615527324.git.brookxu@tencent.com>
References: <cover.1615527324.git.brookxu@tencent.com>
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

