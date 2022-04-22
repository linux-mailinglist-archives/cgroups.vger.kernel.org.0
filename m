Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340F750BC4D
	for <lists+cgroups@lfdr.de>; Fri, 22 Apr 2022 17:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449618AbiDVQAq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Apr 2022 12:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445256AbiDVQAo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Apr 2022 12:00:44 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4C75DA74;
        Fri, 22 Apr 2022 08:57:49 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id c1so6070291qkf.13;
        Fri, 22 Apr 2022 08:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PW4Cfe3gzU2X2eLDy0jiTeoCDEUPxOU6OZ0vGj0GnXM=;
        b=qQmv8Zl/8vm3BB+HY4FmWdQk9xvLjNVtehdtbAjM6pBjtBWMxjdfJX6fiDgZcCvN8s
         YTFywQkuBKDld0/Pq39pW7uJDtHMFC6eDw5x/MDY+lKonmRfCME9AumMPJzciNOthWuE
         eo3ucRUOVymhIh4ThxdDHxW7YgcRxw7rN/R4w6xydOdWkQwr2YITjhIkON3zGeWdz5Y0
         ruPO4pPsUJABIdguUauqwaqjjAOpIu5i27rBAI+FlsMdGlUSBOFPWaTe0Mb7lb+bvXjt
         VchYlWt+XY2PTIgyt9el5e1nHelipq4+IBHtCuG0Ad0DP7+EokHdZmuwRprvLysMxCMX
         x5xA==
X-Gm-Message-State: AOAM533MI6qR2ZIkVc9pz1QsJkRN/9eeMx4yDJj84K+EXDmsHjV72Uqj
        zPZlg2iAkni0+kBXSzurVSU=
X-Google-Smtp-Source: ABdhPJyEfzOz0NSA20V3QRqlGWasmD0qunKSxHvrm87XPTeHqJJF4oBixYgfEbw/V2EBnAT1jug/Bg==
X-Received: by 2002:a05:620a:460a:b0:69e:de07:29c4 with SMTP id br10-20020a05620a460a00b0069ede0729c4mr3018498qkb.277.1650643068537;
        Fri, 22 Apr 2022 08:57:48 -0700 (PDT)
Received: from localhost (fwdproxy-ash-010.fbsv.net. [2a03:2880:20ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id s136-20020a37a98e000000b0069f0c30c0d3sm1079741qke.21.2022.04.22.08.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 08:57:48 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     akpm@linux-foundation.org
Cc:     tj@kernel.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com, void@manifault.com
Subject: [PATCH 2/5] cgroup: Account for memory_recursiveprot in test_memcg_low()
Date:   Fri, 22 Apr 2022 08:57:26 -0700
Message-Id: <20220422155728.3055914-3-void@manifault.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220422155728.3055914-1-void@manifault.com>
References: <20220422155728.3055914-1-void@manifault.com>
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

The test_memcg_low() testcase in test_memcontrol.c verifies the expected
behavior of groups using the memory.low knob. Part of the testcase verifies
that a group with memory.low that experiences reclaim due to memory
pressure elsewhere in the system, observes memory.events.low events as a
result of that reclaim.

In commit 8a931f801340 ("mm: memcontrol: recursive memory.low protection"),
the memory controller was updated to propagate memory.low and memory.min
protection from a parent group to its children via a configurable
memory_recursiveprot mount option. This unfortunately broke the memcg
tests, which asserts that a sibling that experienced reclaim but had a
memory.low value of 0, would not observe any memory.low events. This patch
updates test_memcg_low() to account for the new behavior introduced by
memory_recursiveprot.

So as to make the test resilient to multiple configurations, the patch also
adds a new proc_mount_contains() helper that checks for a string in
/proc/mounts, and is used to toggle behavior based on whether the default
memory_recursiveprot was present.

Signed-off-by: David Vernet <void@manifault.com>
---
 tools/testing/selftests/cgroup/cgroup_util.c     | 12 ++++++++++++
 tools/testing/selftests/cgroup/cgroup_util.h     |  1 +
 tools/testing/selftests/cgroup/test_memcontrol.c | 16 +++++++++++++---
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index dbaa7aabbb4a..e5d8d727bdcf 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -535,6 +535,18 @@ int set_oom_adj_score(int pid, int score)
 	return 0;
 }
 
+int proc_mount_contains(const char *option)
+{
+	char buf[4 * PAGE_SIZE];
+	ssize_t read;
+
+	read = read_text("/proc/mounts", buf, sizeof(buf));
+	if (read < 0)
+		return read;
+
+	return strstr(buf, option) != NULL;
+}
+
 ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t size)
 {
 	char path[PATH_MAX];
diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
index 628738532ac9..756f76052b44 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -48,6 +48,7 @@ extern int is_swap_enabled(void);
 extern int set_oom_adj_score(int pid, int score);
 extern int cg_wait_for_proc_count(const char *cgroup, int count);
 extern int cg_killall(const char *cgroup);
+int proc_mount_contains(const char *option);
 extern ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t size);
 extern int proc_read_strstr(int pid, bool thread, const char *item, const char *needle);
 extern pid_t clone_into_cgroup(int cgroup_fd);
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index aa50eaa8b157..ea2fd27e52df 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -21,6 +21,8 @@
 #include "../kselftest.h"
 #include "cgroup_util.h"
 
+static bool has_recursiveprot;
+
 /*
  * This test creates two nested cgroups with and without enabling
  * the memory controller.
@@ -521,15 +523,18 @@ static int test_memcg_low(const char *root)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(children); i++) {
+		int no_low_events_index = has_recursiveprot ? 2 : 1;
+
 		oom = cg_read_key_long(children[i], "memory.events", "oom ");
 		low = cg_read_key_long(children[i], "memory.events", "low ");
 
 		if (oom)
 			goto cleanup;
-		if (i < 2 && low <= 0)
+		if (i <= no_low_events_index && low <= 0)
 			goto cleanup;
-		if (i >= 2 && low)
+		if (i > no_low_events_index && low)
 			goto cleanup;
+
 	}
 
 	ret = KSFT_PASS;
@@ -1272,7 +1277,7 @@ struct memcg_test {
 int main(int argc, char **argv)
 {
 	char root[PATH_MAX];
-	int i, ret = EXIT_SUCCESS;
+	int i, proc_status, ret = EXIT_SUCCESS;
 
 	if (cg_find_unified_root(root, sizeof(root)))
 		ksft_exit_skip("cgroup v2 isn't mounted\n");
@@ -1288,6 +1293,11 @@ int main(int argc, char **argv)
 		if (cg_write(root, "cgroup.subtree_control", "+memory"))
 			ksft_exit_skip("Failed to set memory controller\n");
 
+	proc_status = proc_mount_contains("memory_recursiveprot");
+	if (proc_status < 0)
+		ksft_exit_skip("Failed to query cgroup mount option\n");
+	has_recursiveprot = proc_status;
+
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
 		switch (tests[i].fn(root)) {
 		case KSFT_PASS:
-- 
2.30.2

