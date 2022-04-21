Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1100850AC39
	for <lists+cgroups@lfdr.de>; Fri, 22 Apr 2022 01:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442712AbiDUXrm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Apr 2022 19:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442731AbiDUXrj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Apr 2022 19:47:39 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9070047AE5
        for <cgroups@vger.kernel.org>; Thu, 21 Apr 2022 16:44:47 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id n10-20020a056a00212a00b0050aba994ee7so3876853pfj.3
        for <cgroups@vger.kernel.org>; Thu, 21 Apr 2022 16:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zrjgrKYnU6OpMbvPqxH4AMaOafcQPI/dEJCu4TPzq/A=;
        b=R5EgEEFiJLJPylJr1GpRvnGVqN1ompyECMnvFf7eJcNcIBFBfprXXAft0A/RmwaXeD
         sbaE02S2hM0MhJlnoYl4BZ6GwzLLyFeyoaeyfYlebGdZNk2FJqWy0CBTgUDnhS3IZByt
         vQWqicHWsomUI7gHz2Tvt1gFymu5ka/dsdDO3KlmWLi1mH5fKV33sBgHm0V9J9vTRadg
         6MpPFs5NAnuJf5761TBNcYgccwJrkDqvgaOAsSc4lC0uYWWC70kYneQqFgmKZ/IoeuvU
         TVc1vZldKVcLP7xe8H7/pcshpA4uONKuKc7K/n5XrtPuudMkt4mzmX1nR+nSRuafWS5v
         ptTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zrjgrKYnU6OpMbvPqxH4AMaOafcQPI/dEJCu4TPzq/A=;
        b=GRcDE17H85eAypD8gFzQyZXR2sPryzV4JqDgMlMglzHRdTvnvHZppn9YrAi2yj5675
         B6gnDOXcZX6V2wzLHT4lr+BgyA8mZ9Xq4SZNr6nLl9tFdpBt2xL9wPm2P+tSJl7to/3+
         6SvR6ff8tfJM6YxVGWFi3cvsJ+svPDKIp3mKSRvaJja5H/Zg9Fi1htkuGzKE1klntiO1
         znK55o3QHBw+iReq4DtU55Kjm53GTQDtmnAE9skCUCH5auBLLdqyvaA+vdxIf/ehhDEg
         xdhFYtpsX7Pjo3/xEKLTrbrjXbXELt5J17Q7GqGJP7hg9hx8liWfqtdIfUZpG7m7GjCI
         tZ6Q==
X-Gm-Message-State: AOAM533OsuAVU1LIVDho5u8fGKvEqPKqTi/jl5IcE+YA9sy0T7WtEPvR
        QvclDVIHqa5NgmN5BQlA4qW4gFenhCJrh+dX
X-Google-Smtp-Source: ABdhPJxkyS9552eyRbp5WO6d5madi5NDuaVaOduz7euoUqf8KeXnSqt/NpxhsWB/Uh+lm1g3ddmKZu3hnmlshvfN
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:f391:b0:158:f1e6:7233 with SMTP
 id f17-20020a170902f39100b00158f1e67233mr1863993ple.133.1650584687052; Thu,
 21 Apr 2022 16:44:47 -0700 (PDT)
Date:   Thu, 21 Apr 2022 23:44:25 +0000
In-Reply-To: <20220421234426.3494842-1-yosryahmed@google.com>
Message-Id: <20220421234426.3494842-4-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220421234426.3494842-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v4 3/4] selftests: cgroup: fix alloc_anon_noexit() instantly
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
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
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

Currently, alloc_anon_noexit() calls alloc_anon() which instantly frees
the allocated memory. alloc_anon_noexit() is usually used with
cg_run_nowait() to run a process in the background that allocates
memory. It makes sense for the background process to keep the memory
allocated and not instantly free it (otherwise there is no point of
running it in the background).

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 36ccf2322e21..f2ffb3a30194 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -211,13 +211,17 @@ static int alloc_pagecache_50M_noexit(const char *cgroup, void *arg)
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
 
+	free(buf);
 	return 0;
 }
 
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

