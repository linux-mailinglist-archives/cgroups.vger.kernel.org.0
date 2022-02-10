Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C314B07EE
	for <lists+cgroups@lfdr.de>; Thu, 10 Feb 2022 09:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbiBJIPX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Feb 2022 03:15:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237192AbiBJIPV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Feb 2022 03:15:21 -0500
Received: from mail-ot1-x349.google.com (mail-ot1-x349.google.com [IPv6:2607:f8b0:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B354910A5
        for <cgroups@vger.kernel.org>; Thu, 10 Feb 2022 00:15:22 -0800 (PST)
Received: by mail-ot1-x349.google.com with SMTP id r16-20020a9d7510000000b0059ea94f86eeso3049245otk.8
        for <cgroups@vger.kernel.org>; Thu, 10 Feb 2022 00:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=v2dUdvpYQ/iwdEjD1AnhdevDWivIB7TWdosyZFRBsLI=;
        b=g+dh5aG43qHs8s9I0Dm5PPC7gF4a4H5V+2N+AaiObReNyWND1Yc0Yljd/vLAqbeRpf
         DCo24Pnebx9fwvyzkzozL3PKlIM891ONrzEsvorNiN2nlwQ3Lr2iWbOuzZfT4tSz5pjt
         z3+VbLfopaHo77vMy0mnVbvK86zpSjcYkEXToNV2O17dBHUO6YeXlUvf3nYcH1uQE27W
         y5DXZb8qKsZcfdXnbT0FHR3p/oDSvD2321eDHiHDrUIJtW0h+1OSXnrTvwQgQniLw/bI
         YUXScMWV9Cc9mPEZHpUYVZsnLLyodPFa21Wgikiv6sNcv8GOJi94G2lwDVFM+Gu0GTTs
         lvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v2dUdvpYQ/iwdEjD1AnhdevDWivIB7TWdosyZFRBsLI=;
        b=o6NabQxnl7HGlzkIg65EzMHwKbxEMVmU9vspHYEcjQGQeGX8J1pM6XfuuFN6N0LA8Y
         hS7mKYloKGAv210Ew8AlAVlnvsQ7Sq3jDk8RGWq7m6KxQd+vELPEw7gCYBuvqD0DYAs5
         aS43L+yOa/165o5ptCfdt/3ZSqCmSts4ZJt1VwihdmkbHVP1U/UVjntemw4r75QQ9BxQ
         oAjps5J7ilH2jgtk/b+KjHntQGq+KMNhrO6ffgy/KqNVNki5khOFQ/hswzo2TZ2x5JUs
         eb4kSDVbkzi0JdXQo3Y+qCwZhOsBnYvd8FRSvxQVFIPjWBeo3Qa9hfliqwXrhkUw0h2/
         4emw==
X-Gm-Message-State: AOAM531o1R9YNSBZy3qgXZkQxbUHtmnzgDyTE35wrbcuHeW9SupROmdQ
        0FS5aO50/KY45PtW12Kes2FNWwap1+Ov2g==
X-Google-Smtp-Source: ABdhPJyLGNrEeAMMZ2oJxj8hocb+ozPNlazDugyANf5tJ8pUYPRT8f3ppFHvqK/lbid6C+ztKAoSho8ci8v9Hw==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:6801:6774:cb90:c600])
 (user=shakeelb job=sendgmr) by 2002:a05:6808:bd3:: with SMTP id
 o19mr540049oik.331.1644480922034; Thu, 10 Feb 2022 00:15:22 -0800 (PST)
Date:   Thu, 10 Feb 2022 00:14:36 -0800
In-Reply-To: <20220210081437.1884008-1-shakeelb@google.com>
Message-Id: <20220210081437.1884008-4-shakeelb@google.com>
Mime-Version: 1.0
References: <20220210081437.1884008-1-shakeelb@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 3/4] selftests: memcg: test high limit for single entry allocation
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

Test the enforcement of memory.high limit for large amount of memory
allocation within a single kernel entry. There are valid use-cases
where the application can trigger large amount of memory allocation
within a single syscall e.g. mlock() or mmap(MAP_POPULATE). Make sure
memory.high limit enforcement works for such use-cases.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 tools/testing/selftests/cgroup/cgroup_util.c  | 15 +++-
 tools/testing/selftests/cgroup/cgroup_util.h  |  1 +
 .../selftests/cgroup/test_memcontrol.c        | 78 +++++++++++++++++++
 3 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 0cf7e90c0052..dbaa7aabbb4a 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -583,7 +583,7 @@ int clone_into_cgroup_run_wait(const char *cgroup)
 	return 0;
 }
 
-int cg_prepare_for_wait(const char *cgroup)
+static int __prepare_for_wait(const char *cgroup, const char *filename)
 {
 	int fd, ret = -1;
 
@@ -591,8 +591,7 @@ int cg_prepare_for_wait(const char *cgroup)
 	if (fd == -1)
 		return fd;
 
-	ret = inotify_add_watch(fd, cg_control(cgroup, "cgroup.events"),
-				IN_MODIFY);
+	ret = inotify_add_watch(fd, cg_control(cgroup, filename), IN_MODIFY);
 	if (ret == -1) {
 		close(fd);
 		fd = -1;
@@ -601,6 +600,16 @@ int cg_prepare_for_wait(const char *cgroup)
 	return fd;
 }
 
+int cg_prepare_for_wait(const char *cgroup)
+{
+	return __prepare_for_wait(cgroup, "cgroup.events");
+}
+
+int memcg_prepare_for_wait(const char *cgroup)
+{
+	return __prepare_for_wait(cgroup, "memory.events");
+}
+
 int cg_wait_for(int fd)
 {
 	int ret = -1;
diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
index 4f66d10626d2..628738532ac9 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -55,4 +55,5 @@ extern int clone_reap(pid_t pid, int options);
 extern int clone_into_cgroup_run_wait(const char *cgroup);
 extern int dirfd_open_opath(const char *dir);
 extern int cg_prepare_for_wait(const char *cgroup);
+extern int memcg_prepare_for_wait(const char *cgroup);
 extern int cg_wait_for(int fd);
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index c19a97dd02d4..36ccf2322e21 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -16,6 +16,7 @@
 #include <netinet/in.h>
 #include <netdb.h>
 #include <errno.h>
+#include <sys/mman.h>
 
 #include "../kselftest.h"
 #include "cgroup_util.h"
@@ -628,6 +629,82 @@ static int test_memcg_high(const char *root)
 	return ret;
 }
 
+static int alloc_anon_mlock(const char *cgroup, void *arg)
+{
+	size_t size = (size_t)arg;
+	void *buf;
+
+	buf = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON,
+		   0, 0);
+	if (buf == MAP_FAILED)
+		return -1;
+
+	mlock(buf, size);
+	munmap(buf, size);
+	return 0;
+}
+
+/*
+ * This test checks that memory.high is able to throttle big single shot
+ * allocation i.e. large allocation within one kernel entry.
+ */
+static int test_memcg_high_sync(const char *root)
+{
+	int ret = KSFT_FAIL, pid, fd = -1;
+	char *memcg;
+	long pre_high, pre_max;
+	long post_high, post_max;
+
+	memcg = cg_name(root, "memcg_test");
+	if (!memcg)
+		goto cleanup;
+
+	if (cg_create(memcg))
+		goto cleanup;
+
+	pre_high = cg_read_key_long(memcg, "memory.events", "high ");
+	pre_max = cg_read_key_long(memcg, "memory.events", "max ");
+	if (pre_high < 0 || pre_max < 0)
+		goto cleanup;
+
+	if (cg_write(memcg, "memory.swap.max", "0"))
+		goto cleanup;
+
+	if (cg_write(memcg, "memory.high", "30M"))
+		goto cleanup;
+
+	if (cg_write(memcg, "memory.max", "140M"))
+		goto cleanup;
+
+	fd = memcg_prepare_for_wait(memcg);
+	if (fd < 0)
+		goto cleanup;
+
+	pid = cg_run_nowait(memcg, alloc_anon_mlock, (void *)MB(200));
+	if (pid < 0)
+		goto cleanup;
+
+	cg_wait_for(fd);
+
+	post_high = cg_read_key_long(memcg, "memory.events", "high ");
+	post_max = cg_read_key_long(memcg, "memory.events", "max ");
+	if (post_high < 0 || post_max < 0)
+		goto cleanup;
+
+	if (pre_high == post_high || pre_max != post_max)
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (fd >= 0)
+		close(fd);
+	cg_destroy(memcg);
+	free(memcg);
+
+	return ret;
+}
+
 /*
  * This test checks that memory.max limits the amount of
  * memory which can be consumed by either anonymous memory
@@ -1180,6 +1257,7 @@ struct memcg_test {
 	T(test_memcg_min),
 	T(test_memcg_low),
 	T(test_memcg_high),
+	T(test_memcg_high_sync),
 	T(test_memcg_max),
 	T(test_memcg_oom_events),
 	T(test_memcg_swap_max),
-- 
2.35.1.265.g69c8d7142f-goog

