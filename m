Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1CE4F8B23
	for <lists+cgroups@lfdr.de>; Fri,  8 Apr 2022 02:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbiDGWpT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Apr 2022 18:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiDGWpP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Apr 2022 18:45:15 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72362154729
        for <cgroups@vger.kernel.org>; Thu,  7 Apr 2022 15:43:14 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id z132-20020a63338a000000b003844e317066so3739357pgz.19
        for <cgroups@vger.kernel.org>; Thu, 07 Apr 2022 15:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Jvjn52nSnpi6AIEmLCqBtZ2YPBYOJR0f93U1cJFGil4=;
        b=BlJpoAori7PwrN2hsipxJJDSi4wgn/as3nxmzLr88juJGOy2S6rEG7V00aGQgCSTHY
         ZNeLpQ7dvj8Hd8f2uKY3PM4t8YzG4U7hjFvVUweBLVzRLDlBEhe8BsgIzBcall+ZQJjb
         RPmHI1AgA0xcAWsHBU6nUBXP4j/Qs5Rx/E8Wr0LgywADaOrox9cPikVY7Zk5LHs9aJsI
         uYO5+DRm85pOBgmDgSagFEONAmNKfXh6jeWKiyIC0PTeAqnmLYDiGdO0cUmn3uUb8FMn
         RB6QH+QGMmuZ8QdxXV2+7mFdNZ7MiJOGD77KzHGBxmCz+qSG7OpNtheats4G2DMt9zSR
         UG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Jvjn52nSnpi6AIEmLCqBtZ2YPBYOJR0f93U1cJFGil4=;
        b=LiK391PuJTowXdZYSHx43m/YO5cs5MbegwM9VUIVm7zNz7eHZDQR/yP66CWo5qHHkp
         n7Y6f/E/hIgJDmAayrvukawjSwL51+JH55160KyNNE6wq7Z1lKVuNlN7oRNwaouvlNJF
         zA/q0bjDlO2F8hMWq7eQAhd1iqq4p3vDywVFV291FQtYldQ7/bo5YJ7ZqQpdWpl80o//
         vCAJikEhAJCHW3WgK5COmks8o+0C2MzW8jmheX22Xig+43JjYkUlXcfq+AUzipVBjdfa
         nIn41DAkt+FpoNtUkIk7oFni6Rya+Gn1cXKT/3FmXr+7QbI5ZvNvsF3jXqQxqcHLO8rS
         0WEw==
X-Gm-Message-State: AOAM533K2/a1fW9iY3vSVv5EIzn2sJyOsKb1RuJb8CKv/luWWYnXiQqq
        iYuBHh+/8Fg8k6q2fhuK24cqwiUI83MdjCHv
X-Google-Smtp-Source: ABdhPJxq3x91eslfBly031zKmT65Bar91Cou176VtwrbXWL0BEPkbqFWiipTf++fpGD5xI4wRGD+8HhGkx8dHxFP
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90b:3d0:b0:1cb:1659:c910 with SMTP
 id go16-20020a17090b03d000b001cb1659c910mr5182457pjb.71.1649371393981; Thu,
 07 Apr 2022 15:43:13 -0700 (PDT)
Date:   Thu,  7 Apr 2022 22:42:43 +0000
In-Reply-To: <20220407224244.1374102-1-yosryahmed@google.com>
Message-Id: <20220407224244.1374102-4-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220407224244.1374102-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH v2 3/4] selftests: cgroup: fix alloc_anon_noexit() instantly
 freeing memory
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     David Rientjes <rientjes@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>, Huang@google.com,
        Ying <ying.huang@intel.com>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently, alloc_anon_noexit() calls alloc_anon() which instantly frees
the allocated memory. alloc_anon_noexit() is usually used with
cg_run_nowait() to run a process in the background that allocates
memory. It makes sense for the background process to keep the memory
allocated and not instantly free it (otherwise there is no point of
running it in the background).

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 36ccf2322e21..c1ec71d83af7 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -211,13 +211,18 @@ static int alloc_pagecache_50M_noexit(const char *cgroup, void *arg)
 static int alloc_anon_noexit(const char *cgroup, void *arg)
 {
 	int ppid = getppid();
+	size_t size = (unsigned long)arg;
+	char *buf, *ptr;
 
-	if (alloc_anon(cgroup, arg))
-		return -1;
+	buf = malloc(size);
+	for (ptr = buf; ptr < buf + size; ptr += PAGE_SIZE)
+		*ptr = 0;
 
 	while (getppid() == ppid)
 		sleep(1);
 
+	printf("Freeing buffer");
+	free(buf);
 	return 0;
 }
 
-- 
2.35.1.1178.g4f1659d476-goog

