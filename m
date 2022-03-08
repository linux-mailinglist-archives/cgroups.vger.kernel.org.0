Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600204D0D72
	for <lists+cgroups@lfdr.de>; Tue,  8 Mar 2022 02:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbiCHBW7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Mar 2022 20:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238937AbiCHBWy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Mar 2022 20:22:54 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2163701C
        for <cgroups@vger.kernel.org>; Mon,  7 Mar 2022 17:21:59 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id qa43so35740638ejc.12
        for <cgroups@vger.kernel.org>; Mon, 07 Mar 2022 17:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TJpD8WbIgS+xru6bpF+N+uC+vSCiqZY6PRQI5LvMXoI=;
        b=Mr7bFXwRFUanMnGNnpUckpJUfAZz88L9eyoAngmHhhUmy7Hqswp/VuwagZ443cQndP
         oCYNfJQDtVorLVlM6sGSf1Aw7fwzcJjKa3hocgArdnUC2b8mUekANMGbZ7JYBxM1ER2N
         Bwv1pVU1nOKa3h9I+wd+bRWNJvymSim3EsfV01aqg571rb8b1vSnMwMVgQzwupbz4ds6
         FlngrH9dFe5VxrBvaH5tLHpypB4tePgIJHkW6e3MDcukco9XUnen3VuH8mD2iDs+fa92
         Uqac1l6dB+FODzmk4AEz546j7iblgAs5xOPKwCRZt77Z6pZQTSBQDhKNLnCAm66OnC50
         M9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TJpD8WbIgS+xru6bpF+N+uC+vSCiqZY6PRQI5LvMXoI=;
        b=ZecSUS8ziaeNpQZHJBe4tCG8iz7qEQ0R28wassZlW9sehgukBsdMRvajxskMVFJQe/
         npL38KVpCztmKlDM2bKh6tn1ccvvHYvMejh36cRA0wbNBDCYsc08JKJDm8BluAbzXACv
         pvr10xu2/j9XSZAnxxPAnEEGcitYBAxxFrWVCnSluEdg/Xmv6yJ+EV2z+9WTa2PXgbfq
         8lBNLC3n/Loe/dqRiXOQBMLQq1tARyH8oiRMe3ESCdJ8k1fhYOYdV0vNpsNzHCczr7Tx
         h1DWTp5o7R2l4n1H+xMNPHDb0eEe/SjSFytEKnP+BQXusXC01J6vBTlkljmrT0SPhaMU
         r4Ww==
X-Gm-Message-State: AOAM532Qb5in6jyl45+OP22g/lb95zpiUpOz0BNqrtwPmIIl1a8dwd5z
        y8R4AxSywil2w/s67HSInac=
X-Google-Smtp-Source: ABdhPJx09GW0/xl9K5HY0fZYhxSqJvtB8pApBKzQSpKrpGl5Yvn4FmsY9YM+Gg+leQdC0K4o0dpNnw==
X-Received: by 2002:a17:907:6d97:b0:6d7:49e:275e with SMTP id sb23-20020a1709076d9700b006d7049e275emr10969974ejc.410.1646702517716;
        Mon, 07 Mar 2022 17:21:57 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id x12-20020a50d9cc000000b0040f70fe78f3sm7041392edj.36.2022.03.07.17.21.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Mar 2022 17:21:57 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 2/3] mm/memcg: __mem_cgroup_remove_exceeded could handle a !on-tree mz properly
Date:   Tue,  8 Mar 2022 01:20:46 +0000
Message-Id: <20220308012047.26638-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220308012047.26638-1-richard.weiyang@gmail.com>
References: <20220308012047.26638-1-richard.weiyang@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There is no tree operation if mz is not on-tree.

Let's remove the extra check.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/memcontrol.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d70bf5cf04eb..344a7e891bc5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -545,9 +545,11 @@ static void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid)
 			unsigned long flags;
 
 			spin_lock_irqsave(&mctz->lock, flags);
-			/* if on-tree, remove it */
-			if (mz->on_tree)
-				__mem_cgroup_remove_exceeded(mz, mctz);
+			/*
+			 * remove it first
+			 * If not on-tree, no tree ops.
+			 */
+			__mem_cgroup_remove_exceeded(mz, mctz);
 			/*
 			 * Insert again. mz->usage_in_excess will be updated.
 			 * If excess is 0, no tree ops.
-- 
2.33.1

