Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D149150BC54
	for <lists+cgroups@lfdr.de>; Fri, 22 Apr 2022 17:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449627AbiDVQAs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Apr 2022 12:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387797AbiDVQAq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Apr 2022 12:00:46 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394AF5DA7E;
        Fri, 22 Apr 2022 08:57:52 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id ay11so5792186qtb.4;
        Fri, 22 Apr 2022 08:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ybM2/MebbmHh9Uk+Civ8p2eG1e4lJfObLB1b9VYbOt0=;
        b=RMnclBJpofBE2r8P2miIAfi/VDQE7JgeJUsa+zGbk2fMfn1c+T3FkSjluxfia5EX0i
         w/Aexa9TzXzNliEV2dt36Jgo3gohyQ/ttWjSvh8NZBGmLxPn/ZQj7yBqGVkiFbrR1nQZ
         NMuJiqiPUy/6f/lxBOUyj/4f5BHs44z3qAab0xRXzj4qtJzIDghJS7lRkFPPpgzy3l5n
         PlXtN9XxI2WtGnltoewmvr8yyct7rHDYZtQpNSQOh1oY+OVy3ihPQprBMwPr5PRh2/qU
         PZI7C1NdYbkY81lIYe0VJVTGmvpXNX+gb7sFxQsoRf452msJYSEAISDmJ5CLl36Jv7UM
         3ZlQ==
X-Gm-Message-State: AOAM531CBKz+5UwLaxCkXzd32kTDefRtawAmb2514NPziJHQ9/dCOd4Z
        tj58qfYw3HTNmYn8ag+SRVQ=
X-Google-Smtp-Source: ABdhPJyMRR8Jr7rZxhR2OLWQ5M5A2n4MOa9OS2dQPPKnynJcD2a5ME2ySPAE1TYdGztolYD7YY14HQ==
X-Received: by 2002:a05:622a:151:b0:2f1:fe9f:9177 with SMTP id v17-20020a05622a015100b002f1fe9f9177mr3762575qtw.628.1650643071259;
        Fri, 22 Apr 2022 08:57:51 -0700 (PDT)
Received: from localhost (fwdproxy-ash-019.fbsv.net. [2a03:2880:20ff:13::face:b00c])
        by smtp.gmail.com with ESMTPSA id c17-20020a05622a025100b002f34db6a3a2sm1543874qtx.4.2022.04.22.08.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 08:57:51 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     akpm@linux-foundation.org
Cc:     tj@kernel.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com, void@manifault.com
Subject: [PATCH 5/5] cgroup: Fix racy check in alloc_pagecache_max_30M() helper function
Date:   Fri, 22 Apr 2022 08:57:29 -0700
Message-Id: <20220422155728.3055914-6-void@manifault.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220422155728.3055914-1-void@manifault.com>
References: <20220422155728.3055914-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

alloc_pagecache_max_30M() in the cgroup memcg tests performs a 50MB
pagecache allocation, which it expects to be capped at 30MB due to the
calling process having a memory.high setting of 30MB. After the allocation,
the function contains a check that verifies that MB(29) < memory.current <=
MB(30). This check can actually fail non-deterministically.

The testcases that use this function are test_memcg_high() and
test_memcg_max(), which set memory.min and memory.max to 30MB respectively
for the cgroup under test. The allocation can slightly exceed this number
in both cases, and for memory.max, the process performing the allocation
will not have the OOM killer invoked as it's performing a pagecache
allocation.  This patchset therefore updates the above check to instead use
the verify_close() helper function.

Signed-off-by: David Vernet <void@manifault.com>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index c4735fa36a3d..088850f01ae7 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -564,9 +564,14 @@ static int alloc_pagecache_max_30M(const char *cgroup, void *arg)
 {
 	size_t size = MB(50);
 	int ret = -1;
-	long current;
+	long current, high, max;
 	int fd;
 
+	high = cg_read_long(cgroup, "memory.high");
+	max = cg_read_long(cgroup, "memory.max");
+	if (high != MB(30) && max != MB(30))
+		goto cleanup;
+
 	fd = get_temp_fd();
 	if (fd < 0)
 		return -1;
@@ -575,7 +580,7 @@ static int alloc_pagecache_max_30M(const char *cgroup, void *arg)
 		goto cleanup;
 
 	current = cg_read_long(cgroup, "memory.current");
-	if (current <= MB(29) || current > MB(30))
+	if (!values_close(current, MB(30), 5))
 		goto cleanup;
 
 	ret = 0;
-- 
2.30.2

