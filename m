Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D14C50CC11
	for <lists+cgroups@lfdr.de>; Sat, 23 Apr 2022 17:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbiDWQAN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Apr 2022 12:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbiDWQAJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 23 Apr 2022 12:00:09 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8050921A4;
        Sat, 23 Apr 2022 08:57:11 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id kk26so456435qvb.6;
        Sat, 23 Apr 2022 08:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pdJh19mhSXyLFACX22MoCTE0boFuYhA324nOqBiKz+c=;
        b=TNApHOUFp29vFX7xQvUjZvtiR8cuXrP5PFwpwJE8Qy/uKuNh1RfOylEF2KJekdY7SE
         +7uMgmyGjTCeTZTdijTN+BviJs7NMCsJV83LaZ60hrX9CDw/oOtQxzJW7ZUI/fPVy+Ld
         TrTPIHw4OeCn0QW8sLa+wfKScuNyvpLFEXfs/8PW/s9oGVznPODaYyCv9+irGmLF+s88
         UvhPnI49TBJZgmEcCoeJJRW2U75I850kzdhosGwLqLbx0/DacUE+koIMeqb9yu2oRmNQ
         w5simRdiOPW7fsxs7eczfVWHqVn9EJyz3U0+kL8mJGa4qOwIcinfz2J6PMGZ8x/1i/ca
         9jig==
X-Gm-Message-State: AOAM530r0yU0RYPkiyTH6tPdHsHlYuTFkTPjrvHukmsiKH/TkY8wujxj
        qnIZqG+52yayVxVi+xvIWuk=
X-Google-Smtp-Source: ABdhPJzbIDyOnNIorYlI1wtlV5sgI0Le0m3m9xvp1ptF9YqnSRqNAZwZr0/K9T9eNh/Y3MXhnku5Rg==
X-Received: by 2002:a05:6214:3001:b0:443:bb87:7f9a with SMTP id ke1-20020a056214300100b00443bb877f9amr7134623qvb.13.1650729430518;
        Sat, 23 Apr 2022 08:57:10 -0700 (PDT)
Received: from localhost (fwdproxy-ash-022.fbsv.net. [2a03:2880:20ff:16::face:b00c])
        by smtp.gmail.com with ESMTPSA id z15-20020a05622a060f00b002e2070bf899sm3048888qta.90.2022.04.23.08.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 08:57:10 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     akpm@linux-foundation.org
Cc:     tj@kernel.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com, void@manifault.com
Subject: [PATCH v2 2/5] cgroup: Account for memory_recursiveprot in test_memcg_low()
Date:   Sat, 23 Apr 2022 08:56:19 -0700
Message-Id: <20220423155619.3669555-3-void@manifault.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220423155619.3669555-1-void@manifault.com>
References: <20220423155619.3669555-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
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
index 284d912e7d3e..d37e8dfb1248 100644
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

