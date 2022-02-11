Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA5D4B1EC6
	for <lists+cgroups@lfdr.de>; Fri, 11 Feb 2022 07:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346254AbiBKGti (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Feb 2022 01:49:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239206AbiBKGth (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Feb 2022 01:49:37 -0500
Received: from mail-ot1-x34a.google.com (mail-ot1-x34a.google.com [IPv6:2607:f8b0:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EA810EA
        for <cgroups@vger.kernel.org>; Thu, 10 Feb 2022 22:49:37 -0800 (PST)
Received: by mail-ot1-x34a.google.com with SMTP id n99-20020a9d206c000000b00590dde2cca8so4841353ota.9
        for <cgroups@vger.kernel.org>; Thu, 10 Feb 2022 22:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nDUa4nh0VfMB33PiEe/+b8nW+DWgiuCX8+o5RVf1oHI=;
        b=ThzYMOIDPOykUabiB3RlRAijrJSIHNXOSUgcmlKL4c2HDkyKp7qaJwrCrOB5Cj7/Sn
         b+6g0BlcsH3JRNO1HyBb0LIliKk840gqIqgFjHZyfba+0Rzygu2PqymxQgM8gR9yQfI2
         UsYHiVjl75cre377AqUX4YDmZQbFTuUf3922omgktt3jvQUKmwr3eB7X7/Z19Ju1H4ex
         PjrES1T9lJwMXV5jyWjXRhmiR+2EhxtUnHDoQdtmgniawP0Vl+SgjVunv4BNLBp8DepV
         bZ7c1Ro3WZr7RdhwOGLkLCIGOQPDT8YXV3AJpris0GtceJxuIoOltOYgpfluZ3rotD5S
         G5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nDUa4nh0VfMB33PiEe/+b8nW+DWgiuCX8+o5RVf1oHI=;
        b=Pgnw+3VBE9oxzsrrPpmCkiX3W52KxH2BX0zSNKAMcmkTs47NPapqV99Lvwi9xsD9sR
         urAQ/wmlXGdE4/zRHONj2FlC1gc9vGS7PqqQ+7jMLggVJO92eAp4LxElG5z2TxpDMKPW
         ZSt/HwxLxP3CH8D2e3rhHbgVIopeLq5TsINf4rwjOqRs3R0c7mZ46EHmUOLOanS2YOZ3
         KKhxRU5PJPwZ7KJ/1B40pj0cTP4DQKwsoKfeVAWsEJGhCVwLpLnZetFqjkVk0o/gDee6
         XmFe1XriJ0Vt03N682zbudRXEtb7Unn+xNP75C6t7IuI4J0OhOqx/zi5VCo4b/CN5fsh
         svcw==
X-Gm-Message-State: AOAM53152JgECUcATw4aiwNcuiDPMRz8Kc0uG5JJWQ/3Rj+ha2qmISOF
        AY4JqiIZHAAoDInD/CTmFmJd6mejuw+pTQ==
X-Google-Smtp-Source: ABdhPJx5gc39Is8agdmSFvKE0SI6NhFXD2uOpMQyKeFvk0V2rSxi71LnZdIohEe32baoaxn1gC4VmeeF0Z5JzQ==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:9a07:ef1a:2fee:57f1])
 (user=shakeelb job=sendgmr) by 2002:a05:6870:6288:: with SMTP id
 s8mr53946oan.269.1644562176594; Thu, 10 Feb 2022 22:49:36 -0800 (PST)
Date:   Thu, 10 Feb 2022 22:49:14 -0800
In-Reply-To: <20220211064917.2028469-1-shakeelb@google.com>
Message-Id: <20220211064917.2028469-2-shakeelb@google.com>
Mime-Version: 1.0
References: <20220211064917.2028469-1-shakeelb@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v2 1/4] memcg: refactor mem_cgroup_oom
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>
Cc:     Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The function mem_cgroup_oom returns enum which has four possible values
but the caller does not care about such values and only cares if the
return value is OOM_SUCCESS or not. So, remove the enum altogether and
make mem_cgroup_oom returns a simple bool.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Roman Gushchin <guro@fb.com>
---
Changes since v1:
- Added comment for mem_cgroup_oom as suggested by Roman

 mm/memcontrol.c | 44 +++++++++++++++++---------------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a0e9d9f12cf5..f12e489ba9b8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1795,20 +1795,16 @@ static void memcg_oom_recover(struct mem_cgroup *memcg)
 		__wake_up(&memcg_oom_waitq, TASK_NORMAL, 0, memcg);
 }
 
-enum oom_status {
-	OOM_SUCCESS,
-	OOM_FAILED,
-	OOM_ASYNC,
-	OOM_SKIPPED
-};
-
-static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
+/*
+ * Returns true if successfully killed one or more processes. Though in some
+ * corner cases it can return true even without killing any process.
+ */
+static bool mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
 {
-	enum oom_status ret;
-	bool locked;
+	bool locked, ret;
 
 	if (order > PAGE_ALLOC_COSTLY_ORDER)
-		return OOM_SKIPPED;
+		return false;
 
 	memcg_memory_event(memcg, MEMCG_OOM);
 
@@ -1831,14 +1827,13 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
 	 * victim and then we have to bail out from the charge path.
 	 */
 	if (memcg->oom_kill_disable) {
-		if (!current->in_user_fault)
-			return OOM_SKIPPED;
-		css_get(&memcg->css);
-		current->memcg_in_oom = memcg;
-		current->memcg_oom_gfp_mask = mask;
-		current->memcg_oom_order = order;
-
-		return OOM_ASYNC;
+		if (current->in_user_fault) {
+			css_get(&memcg->css);
+			current->memcg_in_oom = memcg;
+			current->memcg_oom_gfp_mask = mask;
+			current->memcg_oom_order = order;
+		}
+		return false;
 	}
 
 	mem_cgroup_mark_under_oom(memcg);
@@ -1849,10 +1844,7 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
 		mem_cgroup_oom_notify(memcg);
 
 	mem_cgroup_unmark_under_oom(memcg);
-	if (mem_cgroup_out_of_memory(memcg, mask, order))
-		ret = OOM_SUCCESS;
-	else
-		ret = OOM_FAILED;
+	ret = mem_cgroup_out_of_memory(memcg, mask, order);
 
 	if (locked)
 		mem_cgroup_oom_unlock(memcg);
@@ -2545,7 +2537,6 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	int nr_retries = MAX_RECLAIM_RETRIES;
 	struct mem_cgroup *mem_over_limit;
 	struct page_counter *counter;
-	enum oom_status oom_status;
 	unsigned long nr_reclaimed;
 	bool passed_oom = false;
 	bool may_swap = true;
@@ -2648,9 +2639,8 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * a forward progress or bypass the charge if the oom killer
 	 * couldn't make any progress.
 	 */
-	oom_status = mem_cgroup_oom(mem_over_limit, gfp_mask,
-		       get_order(nr_pages * PAGE_SIZE));
-	if (oom_status == OOM_SUCCESS) {
+	if (mem_cgroup_oom(mem_over_limit, gfp_mask,
+			   get_order(nr_pages * PAGE_SIZE))) {
 		passed_oom = true;
 		nr_retries = MAX_RECLAIM_RETRIES;
 		goto retry;
-- 
2.35.1.265.g69c8d7142f-goog

