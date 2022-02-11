Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2054B1EC2
	for <lists+cgroups@lfdr.de>; Fri, 11 Feb 2022 07:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346679AbiBKGtx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Feb 2022 01:49:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238669AbiBKGtw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Feb 2022 01:49:52 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA872188
        for <cgroups@vger.kernel.org>; Thu, 10 Feb 2022 22:49:52 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y4-20020a5b0f44000000b00611862e546dso17084104ybr.7
        for <cgroups@vger.kernel.org>; Thu, 10 Feb 2022 22:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wSeYGbecgd4wcC85bjYc+Wf+OozOTN6ZFdjrqmxfx+w=;
        b=kgBNOs1WBseAbsRFMyzbv5MpUWXKAyzUAXftaQWeiVTYBMreznuOjzljFOI2hrN1yk
         aHQaCo+UhNqqwVRVTPBr7NM6NjjOEyVjuGyn+/MKv8P8ZNfn9x9nZJdD56raIihE0qyl
         cW+hk+/99lgXtJF1xLanqpAjJOO5g1YltZrYCaTDb+a2pqp7OAkhVEBR4eWnfXN+2ezT
         bDpg5N6KoEKtlQPiLB0AZhqLQR2bCasbsdIbjhbtS7a5XPCObdJ8Qbf6KIpdngCRFy4O
         yT/VmCbaWYaftIYqDgJzRfXpr9DXGJdeGzjvHXl9HegA/BTq6/R6BBz32ycj+VoCOw/2
         UF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wSeYGbecgd4wcC85bjYc+Wf+OozOTN6ZFdjrqmxfx+w=;
        b=FTzpDTl/kksQGuMGuhEbfpu12/Tw8+9mhaS429YHXcFgAgGTIJwF18lLpE0nnCt5q/
         EAedXEaWiZttDmttl+VUAFHjzlH8aGgaA1fOrCBc8U9+ZkM67kzPJW188P9ZJP5BCh+D
         A2ko3QjFJ/L5nVBaMvBZdvpj2MkGE2hZRt2wxOcVM0CxIDwUVrduKHaYCn2d8h3k3390
         pzfcQW07EW57YrWkVa/ccYPKk7Qi+oPB1rm5OaYc2vCeU/49Dj8Ejh91W7WVpXOWu4xe
         j1uRrNO758uac/r6T4aWDKtrobXwNr5h+StuW8MiWEEOci3LwSglzLyaDyrgXU+zUJAD
         vxlQ==
X-Gm-Message-State: AOAM531JDIS8cgxHfBzeOTDeQTG43CAyYBGTyCkv+QIq1LztLt2Zr9Bw
        89EuLIfFu6kAhkXcUtDxp3Mkmpkd9N+ybg==
X-Google-Smtp-Source: ABdhPJwKpmkurBJZDlS/fuYlvpdKg9WPvDaf+agCb8KXEOQoRBet3SsqP1VSya2bsK2552ZipDH4CRMFgYBezw==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:9a07:ef1a:2fee:57f1])
 (user=shakeelb job=sendgmr) by 2002:a81:a304:: with SMTP id
 a4mr337510ywh.516.1644562191536; Thu, 10 Feb 2022 22:49:51 -0800 (PST)
Date:   Thu, 10 Feb 2022 22:49:16 -0800
In-Reply-To: <20220211064917.2028469-1-shakeelb@google.com>
Message-Id: <20220211064917.2028469-4-shakeelb@google.com>
Mime-Version: 1.0
References: <20220211064917.2028469-1-shakeelb@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v2 3/4] selftests: memcg: test high limit for single entry allocation
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
Changes since v1:
- None

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

