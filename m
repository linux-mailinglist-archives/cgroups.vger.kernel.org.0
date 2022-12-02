Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911B063FEAC
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 04:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiLBDPl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Dec 2022 22:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiLBDPh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Dec 2022 22:15:37 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECFBD78D8
        for <cgroups@vger.kernel.org>; Thu,  1 Dec 2022 19:15:36 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id f19-20020a056a001ad300b0056dd07cebfcso3780428pfv.3
        for <cgroups@vger.kernel.org>; Thu, 01 Dec 2022 19:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bNyz6y2Y8+pcZcYRhDrKnevmtY0/xVh2JMC54suzd2M=;
        b=c5bVHWOVWFxZh/IsKMqBecLiB8RmgVwYrX1GzaIQJrvdCmfUyfs8qg0W9hhScf5hH4
         mG1HkIkP0USGP4r6R6YG/H5u+ozhVJBPbINAptVF+p7iL7Zdme2Si3JoPCUQg5PnuM8i
         9sgrk6G5d9YLX23J/vJ2Mgm92LjuGfj+UUMBTfr4WknUpFkwvTonc3miyBG+12r8p9WO
         rKEJGNGnV/+QeTnBLn5B4wArNPSCesKqvyX6p+9fULbYoMK0hz3Mmtd+Zort4W8lRQ75
         zHRyiG+ShUvq2dHWqAQo/BfIP9kKzWFVg6HrESVMYli7xM6bVzIBYa/ChJND9QG28tZc
         zf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bNyz6y2Y8+pcZcYRhDrKnevmtY0/xVh2JMC54suzd2M=;
        b=esoWjlzbqxzhnVwhijtiLbtL0mB/NlmgrUZZFkf1EMmsfjN4raWJEcGql18gt0s/gf
         q7Hcd5uwZ/xaugU0nZi5F0zVmlFsGppAxngtI8xzpESrNIYWiaY8qefIxK2jLOJBy8sW
         As5bZcBF4Xhb2T2v0/GnmzIHkX5JC0/rZURVCEVl8LzU4vP3QmrEtNZ8bh9nUSF7Jq3s
         6ZyIERt6gTteU/4kFguWzyAZEvja0Al+OfY56hh4okhmH7+jYjGHILTjGix3ewTenVkW
         ELWWUq/qur3zwqwj8lWSQB4BTRJ222lRLzpSblRFh5PWMU4DWN4KOX2Wbaq6rXEb6spN
         TZOg==
X-Gm-Message-State: ANoB5pn8FuL2MkfAI65Xn0+d+n9SO+PuzHaCaw1pq6cXhFwK5vyeTuwW
        qkg2Opmj65Q/WOdqmBoYaTk/zvgLvYHMMVhF
X-Google-Smtp-Source: AA0mqf5+TNJlExQui1Z3kcvsElvim4BKI/6fNytWOv4a9T8n9JlH01lAtNxLgUNDVBfiWHcWgrDzDV9aKBY00gko
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a62:62c4:0:b0:575:e44e:3e0 with SMTP id
 w187-20020a6262c4000000b00575e44e03e0mr10149400pfb.53.1669950936154; Thu, 01
 Dec 2022 19:15:36 -0800 (PST)
Date:   Fri,  2 Dec 2022 03:15:12 +0000
In-Reply-To: <20221202031512.1365483-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20221202031512.1365483-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221202031512.1365483-4-yosryahmed@google.com>
Subject: [PATCH v3 3/3] selftests: cgroup: make sure reclaim target memcg is unprotected
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Tejun Heo <tj@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Down <chris@chrisdown.name>,
        David Rientjes <rientjes@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Make sure that we ignore protection of a memcg that is the target of
memcg reclaim.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index a8f4700353a4..1e616a8c6a9c 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -238,6 +238,8 @@ static int cg_test_proc_killed(const char *cgroup)
 	return -1;
 }
 
+static bool reclaim_until(const char *memcg, long goal);
+
 /*
  * First, this test creates the following hierarchy:
  * A       memory.min = 0,    memory.max = 200M
@@ -266,6 +268,12 @@ static int cg_test_proc_killed(const char *cgroup)
  * unprotected memory in A available, and checks that:
  * a) memory.min protects pagecache even in this case,
  * b) memory.low allows reclaiming page cache with low events.
+ *
+ * Then we try to reclaim from A/B/C using memory.reclaim until its
+ * usage reaches 10M.
+ * This makes sure that:
+ * (a) We ignore the protection of the reclaim target memcg.
+ * (b) The previously calculated emin value (~29M) should be dismissed.
  */
 static int test_memcg_protection(const char *root, bool min)
 {
@@ -385,6 +393,9 @@ static int test_memcg_protection(const char *root, bool min)
 	if (!values_close(cg_read_long(parent[1], "memory.current"), MB(50), 3))
 		goto cleanup;
 
+	if (!reclaim_until(children[0], MB(10)))
+		goto cleanup;
+
 	if (min) {
 		ret = KSFT_PASS;
 		goto cleanup;
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

