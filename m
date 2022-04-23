Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B87E50CC0E
	for <lists+cgroups@lfdr.de>; Sat, 23 Apr 2022 17:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbiDWQAF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Apr 2022 12:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236166AbiDWQAA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 23 Apr 2022 12:00:00 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AC21145;
        Sat, 23 Apr 2022 08:57:01 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id v2so927839qto.6;
        Sat, 23 Apr 2022 08:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mhe+ozq+IV2MAwRrDsZ/ZSWkxzhsnE8j2jwM5MH+fqc=;
        b=zZV3quggxejnjOnrsWlVA1DhXC+sVce67ifxZU/DbO+6mQf/MgGAVn4Ka61IEkV9xi
         1NfqDLQr+aFImqTW8GNpthOFR1wLYbdPRor3vnMuTzS+FFCj3oQgcbl5tL/TkLbqEIKH
         y8gniPYKZ/rljx2Yr32uwcgIHXKWaHA2gvSc7OgMedLTBDt7kYjJV8IKleSa+WU+a26Z
         mBVtaTn2PM4EAnN4BQ49V0ZD9jmO/f7b6bJMfrpED2px0ll5tzggoNtfRkdbGPjh1rys
         zFel0sJG6bD6ZkugsY8U00cg7jtpFJPU+NqDNs3VCXt3Y0QZtDYhbfEmNiklTCgcgY9p
         stVA==
X-Gm-Message-State: AOAM533wXp+pXLzU2Y16BbaQppdneN0wX9mP9XeiQPbViy6w+BSTlqgG
        Qox2jyjvMTZwuRKgAf0ynAw=
X-Google-Smtp-Source: ABdhPJytoSPlwHitp9twoxnBZ7MxFhgDBzJwzRKymTJHRnKFhp6540h96jk3b/p131t+VpieODtcCw==
X-Received: by 2002:a05:622a:342:b0:2f3:5c21:1bed with SMTP id r2-20020a05622a034200b002f35c211bedmr4829541qtw.123.1650729420904;
        Sat, 23 Apr 2022 08:57:00 -0700 (PDT)
Received: from localhost (fwdproxy-ash-119.fbsv.net. [2a03:2880:20ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id a1-20020ac844a1000000b002f364521df2sm149742qto.21.2022.04.23.08.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 08:57:00 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     akpm@linux-foundation.org
Cc:     tj@kernel.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com, void@manifault.com
Subject: [PATCH v2 1/5] cgroups: Refactor children cgroups in memcg tests
Date:   Sat, 23 Apr 2022 08:56:17 -0700
Message-Id: <20220423155619.3669555-2-void@manifault.com>
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
 .../selftests/cgroup/test_memcontrol.c        | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 6b5259394e68..284d912e7d3e 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -244,8 +244,8 @@ static int cg_test_proc_killed(const char *cgroup)
  * A/B     memory.min = 50M,  memory.current = 50M
  * A/B/C   memory.min = 75M,  memory.current = 50M
  * A/B/D   memory.min = 25M,  memory.current = 50M
- * A/B/E   memory.min = 500M, memory.current = 0
- * A/B/F   memory.min = 0,    memory.current = 50M
+ * A/B/E   memory.min = 0,    memory.current = 50M
+ * A/B/F   memory.min = 500M, memory.current = 0
  *
  * Usages are pagecache, but the test keeps a running
  * process in every leaf cgroup.
@@ -255,7 +255,7 @@ static int cg_test_proc_killed(const char *cgroup)
  * A/B    memory.current ~= 50M
  * A/B/C  memory.current ~= 33M
  * A/B/D  memory.current ~= 17M
- * A/B/E  memory.current ~= 0
+ * A/B/F  memory.current ~= 0
  *
  * After that it tries to allocate more than there is
  * unprotected memory in A available, and checks
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
@@ -401,8 +401,8 @@ static int test_memcg_min(const char *root)
  * A/B     memory.low = 50M,  memory.current = 50M
  * A/B/C   memory.low = 75M,  memory.current = 50M
  * A/B/D   memory.low = 25M,  memory.current = 50M
- * A/B/E   memory.low = 500M, memory.current = 0
- * A/B/F   memory.low = 0,    memory.current = 50M
+ * A/B/E   memory.low = 0,    memory.current = 50M
+ * A/B/F   memory.low = 500M, memory.current = 0
  *
  * Usages are pagecache.
  * Then it creates A/G an creates a significant
@@ -412,7 +412,7 @@ static int test_memcg_min(const char *root)
  * A/B    memory.current ~= 50M
  * A/B/   memory.current ~= 33M
  * A/B/D  memory.current ~= 17M
- * A/B/E  memory.current ~= 0
+ * A/B/F  memory.current ~= 0
  *
  * After that it tries to allocate more than there is
  * unprotected memory in A available,
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

