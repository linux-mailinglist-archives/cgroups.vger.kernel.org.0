Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BAF63150C
	for <lists+cgroups@lfdr.de>; Sun, 20 Nov 2022 16:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiKTPwA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 20 Nov 2022 10:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKTPv7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 20 Nov 2022 10:51:59 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB8B27DE4
        for <cgroups@vger.kernel.org>; Sun, 20 Nov 2022 07:51:59 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id y13so9220996pfp.7
        for <cgroups@vger.kernel.org>; Sun, 20 Nov 2022 07:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DttQDPYJqDe2lRvTfIAZ96JFKMlEltVMw+oadVUR8gw=;
        b=jvTBchvEr1cpkAFx1KWphFje2d/lHBFdAMl2ic9Wwv3/qYiIPMqd8hNFjdxVP9FbzN
         dF2yWOgzqFAeYontau/3ftgNeLXDbjC5nUwoAqUNt/Kac3hPXAXK8fgWGKaf9j7wnLLa
         VjkRM8LZ/W+fFIBF4H0FTBGsQJs1pzPxuy1pLPYse4wEMFqMBYyl5w9TImS7Uky0NF7j
         06iJOR7JYYmFAlA4TrEvplumSaDxcCuav2hg/OguaHJ7rXa0o7jes+q2qhfGqf4sTprt
         U9zx7uUHFKJ+eaDrV5maUiLIjC+jYvmzrJLpoEepYKHcf/GqKZBszq6VIipscvPNorrG
         k/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DttQDPYJqDe2lRvTfIAZ96JFKMlEltVMw+oadVUR8gw=;
        b=FjfaMTJZfzIRJzfa5dhsjEs0BzLRrszVc+ED4NgmbrN25guSJUBXGTzDyYEq/1aPrT
         NFduqE7zpN8wK9mwbR6metjRmb8va4ugqLjpO/cW9TCDL22wII2UKZFJBOTlHgoFlx/C
         hW2BP8J98BlrLVvNTC6CDapCQCijVJlLD3AaUV+tPsO57Wq8G4gQ+UC3gF9Jap4A90z2
         t48Fvh5XdeBaBUYC8fVG0kqtpE0lD+ueLbRKOSAm9FnlRz0Bzmx0y/niBLOzSRFO3dPy
         SRWfvPnW//IijD+ZrcKcOODoGKkNINe1BcsYah3Vp2hIcLB55xLiUmY8vTTszKUNm+0t
         lhag==
X-Gm-Message-State: ANoB5pnNnxJmGpIDw5yYgsWjrE5ktx2ZpwdW+haYJMrUx1cEhmYjG7aL
        R1pOAHIWCM3M8kE7QOHpEGySxdlyGL3khQ==
X-Google-Smtp-Source: AA0mqf5JIfD/BWXFNnIfKMW5HC7lQRe8TXhJ/QlV6sprCm5Qo0dwzT1fghBWiJvRUtqzaZPrmqVFdw==
X-Received: by 2002:a63:f1d:0:b0:475:a06:50ae with SMTP id e29-20020a630f1d000000b004750a0650aemr1038849pgl.67.1668959518729;
        Sun, 20 Nov 2022 07:51:58 -0800 (PST)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id p188-20020a625bc5000000b0056e32a2b88esm6730378pfb.219.2022.11.20.07.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 07:51:58 -0800 (PST)
From:   "haifeng.xu" <haifeng.xu@shopee.com>
To:     tj@kernel.org
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "haifeng.xu" <haifeng.xu@shopee.com>
Subject: [PATCH] cgroup: Fix typo in comment
Date:   Sun, 20 Nov 2022 15:51:34 +0000
Message-Id: <20221120155134.57193-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Replace iff with if.

Signed-off-by: haifeng.xu <haifeng.xu@shopee.com>
---
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index f2743a476190..93c5e50b1392 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -814,7 +814,7 @@ static bool css_set_populated(struct css_set *cset)
  * One of the css_sets associated with @cgrp is either getting its first
  * task or losing the last.  Update @cgrp->nr_populated_* accordingly.  The
  * count is propagated towards root so that a given cgroup's
- * nr_populated_children is zero iff none of its descendants contain any
+ * nr_populated_children is zero if none of its descendants contain any
  * tasks.
  *
  * @cgrp's interface file "cgroup.populated" is zero if both
-- 
2.25.1

