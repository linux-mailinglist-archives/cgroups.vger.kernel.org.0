Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A0E50BC4F
	for <lists+cgroups@lfdr.de>; Fri, 22 Apr 2022 17:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388749AbiDVQAp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Apr 2022 12:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381209AbiDVQAm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Apr 2022 12:00:42 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37475DA6E;
        Fri, 22 Apr 2022 08:57:48 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id d19so6104293qko.3;
        Fri, 22 Apr 2022 08:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aDaj3HkD7Ew7tdcTEWHSkCTuHU/M0CNYAq9mxNhKvus=;
        b=ZTRR8ZyJg0/xKhY+1K/lXzFZh+gjLPLsRYyoLIfe9ix7pYCQNqLMLYIRxebWhsMI3u
         Zrsii/M940gIHnCWkY+4fQ26cJRHD89LNGC6kQ8ueZuoPeuMYmX+3Nfk84mt9Zjqaaxh
         iKr/pqLPFmgmxyaxw4Gyrjxqd3C7MOr82jeiAiZCwUkiyXR/wTLnKk16BG+zaxucmOkc
         GnXP4gOgdfm1CxzsevU5vohk5r6WNZRravNwFVyQU7uyafzHnGt3nzaKnn/jo2brpglq
         N7ZWSfpJQ8s0mHiQgiCy+rpNCgql7o+z1ZdrHdnNSfmsFM+WEzdKnbDGpCSXsiZC7EtM
         okQA==
X-Gm-Message-State: AOAM532xVYuO52+k9/hiv/qeWWKez9bqqaJpOEGBnMn+lnKYl91Z3ZIN
        icedKSeEl06jnhBbCkchR2Y=
X-Google-Smtp-Source: ABdhPJxdpQ0/gfPFcucO+d4vBu70jsUM1ghhPvnLz+9s0jqGGhgmbNt0obYZb9aYdEZfurgxOdo+OA==
X-Received: by 2002:a37:6412:0:b0:69e:68cf:d889 with SMTP id y18-20020a376412000000b0069e68cfd889mr2945289qkb.443.1650643067440;
        Fri, 22 Apr 2022 08:57:47 -0700 (PDT)
Received: from localhost (fwdproxy-ash-013.fbsv.net. [2a03:2880:20ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id o21-20020a37a515000000b0069e6c84e8basm1066994qke.117.2022.04.22.08.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 08:57:47 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     akpm@linux-foundation.org
Cc:     tj@kernel.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com, void@manifault.com
Subject: [PATCH 1/5] cgroups: Refactor children cgroups in memcg tests
Date:   Fri, 22 Apr 2022 08:57:25 -0700
Message-Id: <20220422155728.3055914-2-void@manifault.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220422155728.3055914-1-void@manifault.com>
References: <20220422155728.3055914-1-void@manifault.com>
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

In test_memcg_min() and test_memcg_low(), there is an array of four sibling
cgroups. All but one of these sibling groups does a 50MB allocation, and
the group that does no allocation is the third of four in the array.  This
is not a problem per se, but makes it a bit tricky to do some assertions in
test_memcg_low(), as we want to make assertions on the siblings based on
whether or not they performed allocations. Having a static index before
which all groups have performed an allocation makes this cleaner.

This patch therefore reorders the sibling groups so that the group that
performs no allocations is the last in the array. A follow-on patch will
leverage this to fix a bug in the test that incorrectly asserts that a
sibling group that had performed an allocation, but only had protection
from its parent, will not observe any memory.events.low events during
reclaim.

Signed-off-by: David Vernet <void@manifault.com>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 6b5259394e68..aa50eaa8b157 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -321,7 +321,7 @@ static int test_memcg_min(const char *root)
 		if (cg_create(children[i]))
 			goto cleanup;
 
-		if (i == 2)
+		if (i > 2)
 			continue;
 
 		cg_run_nowait(children[i], alloc_pagecache_50M_noexit,
@@ -336,9 +336,9 @@ static int test_memcg_min(const char *root)
 		goto cleanup;
 	if (cg_write(children[1], "memory.min", "25M"))
 		goto cleanup;
-	if (cg_write(children[2], "memory.min", "500M"))
+	if (cg_write(children[2], "memory.min", "0"))
 		goto cleanup;
-	if (cg_write(children[3], "memory.min", "0"))
+	if (cg_write(children[3], "memory.min", "500M"))
 		goto cleanup;
 
 	attempts = 0;
@@ -364,7 +364,7 @@ static int test_memcg_min(const char *root)
 	if (!values_close(c[1], MB(17), 20))
 		goto cleanup;
 
-	if (!values_close(c[2], 0, 1))
+	if (c[3] != 0)
 		goto cleanup;
 
 	if (!cg_run(parent[2], alloc_anon, (void *)MB(170)))
@@ -476,7 +476,7 @@ static int test_memcg_low(const char *root)
 		if (cg_create(children[i]))
 			goto cleanup;
 
-		if (i == 2)
+		if (i > 2)
 			continue;
 
 		if (cg_run(children[i], alloc_pagecache_50M, (void *)(long)fd))
@@ -491,9 +491,9 @@ static int test_memcg_low(const char *root)
 		goto cleanup;
 	if (cg_write(children[1], "memory.low", "25M"))
 		goto cleanup;
-	if (cg_write(children[2], "memory.low", "500M"))
+	if (cg_write(children[2], "memory.low", "0"))
 		goto cleanup;
-	if (cg_write(children[3], "memory.low", "0"))
+	if (cg_write(children[3], "memory.low", "500M"))
 		goto cleanup;
 
 	if (cg_run(parent[2], alloc_anon, (void *)MB(148)))
@@ -511,7 +511,7 @@ static int test_memcg_low(const char *root)
 	if (!values_close(c[1], MB(17), 20))
 		goto cleanup;
 
-	if (!values_close(c[2], 0, 1))
+	if (c[3] != 0)
 		goto cleanup;
 
 	if (cg_run(parent[2], alloc_anon, (void *)MB(166))) {
-- 
2.30.2

