Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E046A547A
	for <lists+cgroups@lfdr.de>; Tue, 28 Feb 2023 09:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjB1IgB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Feb 2023 03:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjB1IgB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Feb 2023 03:36:01 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28219234E8
        for <cgroups@vger.kernel.org>; Tue, 28 Feb 2023 00:35:57 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id ce7so5172778pfb.9
        for <cgroups@vger.kernel.org>; Tue, 28 Feb 2023 00:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1677573356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2m9p8ihrgSqCDLIO8jAiryGx9X7hvTIbRelvVFuou64=;
        b=ACFBaQ8L7Rvd7Z7rTp6gb6TlTYlIHT8zfbAJbVa5AcagjWCt/hdH7FhHf0GD6crqoE
         l5z9Qo4ohzq6CKtz8NFnvbWScdY6X71MaG5/p8csSeWuKhQY4BGzlPfQCFhr/iuoBXTe
         KdMAxa3t8Pg1o9Rq+V/gS+Z8ztASY/N2CJd9YQyU6fyPt1fBeNsKL5D27po31Ulr26hV
         MMNcia3bHxxOLR9mLr08+5z20nDuCRI4xROWT9en3Ph2q41ETXd794o60DBDnwsMplUj
         89cgOw8VNBEQT9qPIZ8E1BwDKyIfJLJAnoo4hUQk4J1IT0VikSHe9VtfV7LFDOosZo8M
         cc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677573356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2m9p8ihrgSqCDLIO8jAiryGx9X7hvTIbRelvVFuou64=;
        b=zAhBH5+2r+KI6zJU3KkocLPbHrQDHVRTwxZVc5Aby5pAslWmrvvyTao5EaH2+17YLx
         fU3bW4FvLU/TxIkfG8VjVEo6L5T7EfSQDJtzf8czCZn+ZlinYoVEsip0rs0fqAUWrrxr
         GasmjqMopqr5auQgZt1OWDeXeOewnfgqXp26jnZFvDciOUrQysTTZnvUk4D7Ye/fwDJ/
         VUBE0CvwKiZddVxjugTqnNof9OPIhP+2K3HQE2Jf+OF5049gx+IyNt8Gf9SQ+XhBTfgP
         Vt0UgureiC2yKu8/whZO6hdixDpEEMl2EPK1F/nh1p4CtQ1993cRh9cyrDd4i8a8yXcJ
         ZfqQ==
X-Gm-Message-State: AO0yUKX/9jF8dZbTqBBmPxhmYwW0yNje1PcdO8gDmZcJaGZHexE+wF/a
        0cSaLc9aMT7+8ADJugKWUXn0Dg==
X-Google-Smtp-Source: AK7set+yFaUee4hKzhTdalVFR+do2NU6CSsr0tPR0slzongxl7jDZOFyj9n8WLELfs8JPCRnaHD2BA==
X-Received: by 2002:a62:528f:0:b0:5d9:f3a6:a925 with SMTP id g137-20020a62528f000000b005d9f3a6a925mr1784980pfb.24.1677573356533;
        Tue, 28 Feb 2023 00:35:56 -0800 (PST)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id bm17-20020a056a00321100b005aa80fe8be7sm5461768pfb.67.2023.02.28.00.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 00:35:56 -0800 (PST)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     longman@redhat.com
Cc:     lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH] cpuset: Clean up cpuset_node_allowed
Date:   Tue, 28 Feb 2023 08:35:37 +0000
Message-Id: <20230228083537.102665-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <9953284e-05da-56b0-047d-ecf18aa53892@redhat.com>
References: <9953284e-05da-56b0-047d-ecf18aa53892@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Commit 002f290627c2 ("cpuset: use static key better and convert to new API")
has used __cpuset_node_allowed() instead of cpuset_node_allowed() to check
whether we can allocate on a memory node. Now this function isn't used by
anyone, so we can do the follow things to clean up it.

1. remove unused codes
2. rename __cpuset_node_allowed() to cpuset_node_allowed()
3. update comments in mm/page_alloc.c

Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 include/linux/cpuset.h | 16 ++--------------
 kernel/cgroup/cpuset.c |  4 ++--
 mm/page_alloc.c        |  4 ++--
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index d58e0476ee8e..980b76a1237e 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -80,18 +80,11 @@ extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
 void cpuset_init_current_mems_allowed(void);
 int cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask);
 
-extern bool __cpuset_node_allowed(int node, gfp_t gfp_mask);
-
-static inline bool cpuset_node_allowed(int node, gfp_t gfp_mask)
-{
-	if (cpusets_enabled())
-		return __cpuset_node_allowed(node, gfp_mask);
-	return true;
-}
+extern bool cpuset_node_allowed(int node, gfp_t gfp_mask);
 
 static inline bool __cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
 {
-	return __cpuset_node_allowed(zone_to_nid(z), gfp_mask);
+	return cpuset_node_allowed(zone_to_nid(z), gfp_mask);
 }
 
 static inline bool cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
@@ -223,11 +216,6 @@ static inline int cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask)
 	return 1;
 }
 
-static inline bool cpuset_node_allowed(int node, gfp_t gfp_mask)
-{
-	return true;
-}
-
 static inline bool __cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
 {
 	return true;
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 636f1c682ac0..0241b07d6f21 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3831,7 +3831,7 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
 }
 
 /*
- * __cpuset_node_allowed - Can we allocate on a memory node?
+ * cpuset_node_allowed - Can we allocate on a memory node?
  * @node: is this an allowed node?
  * @gfp_mask: memory allocation flags
  *
@@ -3870,7 +3870,7 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
  *	GFP_KERNEL   - any node in enclosing hardwalled cpuset ok
  *	GFP_USER     - only nodes in current tasks mems allowed ok.
  */
-bool __cpuset_node_allowed(int node, gfp_t gfp_mask)
+bool cpuset_node_allowed(int node, gfp_t gfp_mask)
 {
 	struct cpuset *cs;		/* current cpuset ancestors */
 	bool allowed;			/* is allocation in zone z allowed? */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3bb3484563ed..0d170ae590d8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4175,7 +4175,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 retry:
 	/*
 	 * Scan zonelist, looking for a zone with enough free.
-	 * See also __cpuset_node_allowed() comment in kernel/cgroup/cpuset.c.
+	 * See also cpuset_node_allowed() comment in kernel/cgroup/cpuset.c.
 	 */
 	no_fallback = alloc_flags & ALLOC_NOFRAGMENT;
 	z = ac->preferred_zoneref;
@@ -4843,7 +4843,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
 			alloc_flags |= ALLOC_HARDER;
 		/*
 		 * Ignore cpuset mems for GFP_ATOMIC rather than fail, see the
-		 * comment for __cpuset_node_allowed().
+		 * comment for cpuset_node_allowed().
 		 */
 		alloc_flags &= ~ALLOC_CPUSET;
 	} else if (unlikely(rt_task(current)) && in_task())
-- 
2.25.1

