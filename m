Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A43D501F60
	for <lists+cgroups@lfdr.de>; Fri, 15 Apr 2022 02:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240890AbiDOAES (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Apr 2022 20:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347815AbiDOAEP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Apr 2022 20:04:15 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EEB6350F;
        Thu, 14 Apr 2022 17:01:49 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649980907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MZnIyq/OEljf6qm4HzfEVtb31rpdSn51/YIxJ3qfZZM=;
        b=bIzP37NkG83HH+S+rk32b2S5PJLnI9dPJqbYcDHgEcjvMonvDewhyTg/y18EF7KlnsTvHe
        n+i3dkuRjygldl6S0SzyhD6r2oEbTxFu9ZgDc76aJtAWDSF3CJhxyY3SQlbyyRmwOslbb3
        OYltxaTYQIm8+HHiOOF5NIiuCUk/aJE=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Chris Down <chris@chrisdown.name>
Subject: [PATCH 1/4] kselftests: memcg: update the oom group leaf events test
Date:   Thu, 14 Apr 2022 17:01:30 -0700
Message-Id: <20220415000133.3955987-2-roman.gushchin@linux.dev>
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

Commit 9852ae3fe529 ("mm, memcg: consider subtrees in memory.events") made
memory.events recursive: all events are propagated upwards by the
tree. It was a change in semantics.

It broke the oom group leaf events test: it assumes that after
an OOM the oom_kill counter is zero on parent's level.

Let's adjust the test: it should have similar expectations
for the child and parent levels.

The test passes after this fix.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Chris Down <chris@chrisdown.name>
Cc: Johannes Weiner <hannes@cmpxchg.org>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 36ccf2322e21..00b430e7f2a2 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -1079,7 +1079,8 @@ static int test_memcg_sock(const char *root)
 /*
  * This test disables swapping and tries to allocate anonymous memory
  * up to OOM with memory.group.oom set. Then it checks that all
- * processes in the leaf (but not the parent) were killed.
+ * processes in the leaf were killed. It also checks that oom_events
+ * were propagated to the parent level.
  */
 static int test_memcg_oom_group_leaf_events(const char *root)
 {
@@ -1122,7 +1123,7 @@ static int test_memcg_oom_group_leaf_events(const char *root)
 	if (cg_read_key_long(child, "memory.events", "oom_kill ") <= 0)
 		goto cleanup;
 
-	if (cg_read_key_long(parent, "memory.events", "oom_kill ") != 0)
+	if (cg_read_key_long(parent, "memory.events", "oom_kill ") <= 0)
 		goto cleanup;
 
 	ret = KSFT_PASS;
-- 
2.35.1

