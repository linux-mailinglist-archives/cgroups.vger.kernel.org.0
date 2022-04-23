Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B7450CC0D
	for <lists+cgroups@lfdr.de>; Sat, 23 Apr 2022 17:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbiDWQAN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Apr 2022 12:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbiDWQAM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 23 Apr 2022 12:00:12 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A4D2626;
        Sat, 23 Apr 2022 08:57:14 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id b68so7960491qkc.4;
        Sat, 23 Apr 2022 08:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gmXNl4tIfL5wRbTrjuvKfaCU9MK0lOXp83omTUSrSMo=;
        b=RqYcKbwdqymvvBUcZsqs2449ogL1+J5xlvDJt3JhwCZln//N/ASrDT/R/AsaDi4r5W
         cIyOVCbsVpPi/SMbtnKam77lZMmMXxm9wLpnJBdJi/HllZEC2KQiJYrGcW17reB32E54
         ku+/2abwX9sE/cQp5p7y95LwjCInYWf/PuEm1+9jJa8GmEgcnvTCIx7C246S0wt0brbM
         IJgdz59Ydq00nA13w6Mblr78h/uNX+FOOUhhm3rqqL+/dIC/t5+7RfKdrIdBRQy6/lWA
         8jl+qDzgEVcBy2wNfZ9eccDkleiFjXgCCdLv9JKEJntYEOhy5LTMNg+nvHMOpmhSXgD5
         x2tw==
X-Gm-Message-State: AOAM530fcqYnQojJzgxWl3pQ39U0MPI9ieIcXsNi8GwxbBLydcYne6SW
        W7onRlfVvmLEvZOoX0OFoic=
X-Google-Smtp-Source: ABdhPJxrka55ASWkCj+31Zq8g/DCOT2vSRE9a3/Q38M+L6ijF+65YD0/feALRFzYTD/HSx0KMyH5Rg==
X-Received: by 2002:a05:620a:2588:b0:680:f657:fbd6 with SMTP id x8-20020a05620a258800b00680f657fbd6mr5649398qko.287.1650729433397;
        Sat, 23 Apr 2022 08:57:13 -0700 (PDT)
Received: from localhost (fwdproxy-ash-119.fbsv.net. [2a03:2880:20ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id w4-20020a05620a0e8400b0067b1bcd081csm2321762qkm.66.2022.04.23.08.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 08:57:13 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     akpm@linux-foundation.org
Cc:     tj@kernel.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com, void@manifault.com
Subject: [PATCH v2 5/5] cgroup: Fix racy check in alloc_pagecache_max_30M() helper function
Date:   Sat, 23 Apr 2022 08:56:22 -0700
Message-Id: <20220423155619.3669555-6-void@manifault.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220423155619.3669555-1-void@manifault.com>
References: <20220423155619.3669555-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 38d2054eefe6..3bac06999354 100644
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

