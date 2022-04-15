Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA79D501F5E
	for <lists+cgroups@lfdr.de>; Fri, 15 Apr 2022 02:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347820AbiDOAET (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Apr 2022 20:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347822AbiDOAET (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Apr 2022 20:04:19 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DF16350F;
        Thu, 14 Apr 2022 17:01:52 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649980911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ka6qQQskUc/bYspKrrZopLIlbaTgRjrO9/vj2k3mAsU=;
        b=wp05x2nDGuHhLPy+P4GdOWff81+K1abp8o5tuqik6xqDvkyZ/oSb8zPKoJdbJXS0z26MwT
        P8Kj2Z2Ek+0hQqQeoTDsZjIeeOR1YxkTgZRXdeu3c4v4QGRVFLSqd6ohvg8jDYxZ+1lpKV
        dcMTGqq4kL0n/Bxm/VAcnLYnUTbCP/c=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Chris Down <chris@chrisdown.name>
Subject: [PATCH 2/4] kselftests: memcg: speed up the memory.high test
Date:   Thu, 14 Apr 2022 17:01:31 -0700
Message-Id: <20220415000133.3955987-3-roman.gushchin@linux.dev>
In-Reply-To: <20220415000133.3955987-1-roman.gushchin@linux.dev>
References: <20220415000133.3955987-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

After commit 0e4b01df8659 ("mm, memcg: throttle allocators when
failing reclaim over memory.high") allocating memory over memory.high
became very time consuming. But it's exactly what the memory.high
test from cgroup kselftests is doing: it tries to allocate 100M with
30M memory.high value. It takes forever to complete.

In order to keep it passing (or failing) in a reasonable amount of
time let's try to allocate only a little over 30M: 31M to be precise.

With this change test_memcontrol finishes in a reasonable amount of
time:
  $ time ./test_memcontrol
  ok 1 test_memcg_subtree_control
  ok 2 test_memcg_current
  ok 3 test_memcg_min
  ok 4 test_memcg_low
  ok 5 test_memcg_high
  ok 6 test_memcg_max
  ok 7 test_memcg_oom_events
  ok 8 test_memcg_swap_max
  ok 9 test_memcg_sock
  ok 10 test_memcg_oom_group_leaf_events
  ok 11 test_memcg_oom_group_parent_events
  ok 12 test_memcg_oom_group_score_events

  real	0m2.273s
  user	0m0.064s
  sys	0m0.739s

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Chris Down <chris@chrisdown.name>
Cc: Johannes Weiner <hannes@cmpxchg.org>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 00b430e7f2a2..9c1f19fe2e37 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -607,7 +607,7 @@ static int test_memcg_high(const char *root)
 	if (cg_write(memcg, "memory.high", "30M"))
 		goto cleanup;
 
-	if (cg_run(memcg, alloc_anon, (void *)MB(100)))
+	if (cg_run(memcg, alloc_anon, (void *)MB(31)))
 		goto cleanup;
 
 	if (!cg_run(memcg, alloc_pagecache_50M_check, NULL))
-- 
2.35.1

