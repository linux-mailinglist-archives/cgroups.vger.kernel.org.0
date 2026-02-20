Return-Path: <cgroups+bounces-14045-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBseKZatl2nO5QIAu9opvQ
	(envelope-from <cgroups+bounces-14045-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 01:40:54 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 348CC163E64
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 01:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77A39307672A
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 00:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D439E20D4FF;
	Fri, 20 Feb 2026 00:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gL+2sGWj"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9418B1F4180;
	Fri, 20 Feb 2026 00:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771547934; cv=none; b=gta2CEIjNkrzxDNcP0C30ZV31oU9xFSlUZ1awoifL4DhzO6Yhn/DOfmiJ8fAGC2QS18MZROxzNeAg9OqOgAtfLs8aG1ZuohA8H5A50BHJFwOpYr3YMBQe7bwQImBd1paTBZb9d27ZYT822H9Ww+2FWy6pksZ2f4sT9wcj5XvIQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771547934; c=relaxed/simple;
	bh=mQc8EiFwm60GFoFhfzxR1JRaHCQHgCBHuPjqBgX857M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qp4e7wM0dKsVUipypVL/THmxI40T48V3vKCBH8SKgpTbamNTjQBu+e9bXirSwD3pD0SgVj6z8lXgbFnwj2PeZ78e7dZbC7sei5R8PGRyZ+bY990tJCEvi4+xF4IhmsunkxACKXLizOLQVyYDFlhV2H9VDbvMyEyOmTGAveWNm/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gL+2sGWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064D9C4CEF7;
	Fri, 20 Feb 2026 00:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771547934;
	bh=mQc8EiFwm60GFoFhfzxR1JRaHCQHgCBHuPjqBgX857M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gL+2sGWjZCvJ7vGGBvagZx90u2ZhzAePGvsfep9cOMK7bMd9vSHYwn7OonqenSeKC
	 67zhpe+gnmZKBfV92Sc4IxCLHJVl4+/ZzAIsQ7+y1R/NxmeoID1btlrHQyFhguou23
	 AifF4yXZHf/sD9CvjfI0YrM/AkMWPb4Eb9z7h7G6MwNohJxrR5KmMpL4hgwJQmX1jK
	 5pne5Oz/Z3WXfstYJJtiTW3FhwCms22kk4q/aU5peIw97Gxuz4ysiLMLn09ULj6ojz
	 m8cRXszic3//7ay9h8Pcn/UyP0+edzED/Hu35mYs6lmiS+sfkaxvzI/s0PgVzlCbdR
	 dW5aVtZ9pWvLQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 20 Feb 2026 01:38:32 +0100
Subject: [PATCH 4/4] selftests/bpf: add cgroup attach selftests
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260220-work-bpf-namespace-v1-4-866207db7b83@kernel.org>
References: <20260220-work-bpf-namespace-v1-0-866207db7b83@kernel.org>
In-Reply-To: <20260220-work-bpf-namespace-v1-0-866207db7b83@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Tejun Heo <tj@kernel.org>
Cc: KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 Lennart Poettering <lennart@poettering.net>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=13245; i=brauner@kernel.org;
 h=from:subject:message-id; bh=mQc8EiFwm60GFoFhfzxR1JRaHCQHgCBHuPjqBgX857M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROXyvAt7/kxAmdY6zyehaLr1VKcP/TvHm2y36nqxbbG
 veO60eFO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZSzc/IcOjdr5B0H9FZSy4z
 z633Cl6sxxO5Ru3lxJsfVwvPrHnpH8HIMD9X7/T+xcW3OpIObzLhuKORwNcp9s5wM1NHiFI1x/F
 bjAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14045-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 348CC163E64
X-Rspamd-Action: no action

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/bpf/prog_tests/cgroup_attach.c       | 362 +++++++++++++++++++++
 .../selftests/bpf/progs/test_cgroup_attach.c       |  85 +++++
 2 files changed, 447 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach.c b/tools/testing/selftests/bpf/prog_tests/cgroup_attach.c
new file mode 100644
index 000000000000..05addf93af46
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach.c
@@ -0,0 +1,362 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Christian Brauner <brauner@kernel.org> */
+
+/*
+ * Test the bpf_lsm_cgroup_attach hook.
+ *
+ * Verifies that a BPF LSM program can supervise cgroup migration
+ * through both the cgroup.procs write path and the clone3 +
+ * CLONE_INTO_CGROUP path.
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include <test_progs.h>
+#include "cgroup_helpers.h"
+#include "test_cgroup_attach.skel.h"
+
+/* Must match the definition in progs/test_cgroup_attach.c */
+struct attach_event {
+	__u32 task_pid;
+	__u64 src_cgrp_id;
+	__u64 dst_cgrp_id;
+	__u8  threadgroup;
+	__u32 hook_count;
+};
+
+#ifndef CLONE_INTO_CGROUP
+#define CLONE_INTO_CGROUP 0x200000000ULL
+#endif
+
+#ifndef __NR_clone3
+#define __NR_clone3 435
+#endif
+
+struct __clone_args {
+	__aligned_u64 flags;
+	__aligned_u64 pidfd;
+	__aligned_u64 child_tid;
+	__aligned_u64 parent_tid;
+	__aligned_u64 exit_signal;
+	__aligned_u64 stack;
+	__aligned_u64 stack_size;
+	__aligned_u64 tls;
+	__aligned_u64 set_tid;
+	__aligned_u64 set_tid_size;
+	__aligned_u64 cgroup;
+};
+
+static pid_t do_clone3(int cgroup_fd)
+{
+	struct __clone_args args = {
+		.flags = CLONE_INTO_CGROUP,
+		.exit_signal = SIGCHLD,
+		.cgroup = cgroup_fd,
+	};
+
+	return syscall(__NR_clone3, &args, sizeof(args));
+}
+
+/*
+ * Subtest: deny_migration
+ *
+ * Verify that the BPF hook can deny cgroup migration through cgroup.procs
+ * and that detaching the BPF program removes enforcement.
+ */
+static void test_deny_migration(void)
+{
+	struct test_cgroup_attach *skel = NULL;
+	int allowed_fd = -1, denied_fd = -1;
+	unsigned long long denied_cgid;
+	int err, status;
+	__u64 key;
+	__u8 val = 1;
+	pid_t child;
+
+	if (!ASSERT_OK(setup_cgroup_environment(), "setup_cgroup_env"))
+		return;
+
+	allowed_fd = create_and_get_cgroup("/allowed");
+	if (!ASSERT_GE(allowed_fd, 0, "create /allowed"))
+		goto cleanup;
+
+	denied_fd = create_and_get_cgroup("/denied");
+	if (!ASSERT_GE(denied_fd, 0, "create /denied"))
+		goto cleanup;
+
+	skel = test_cgroup_attach__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel open_and_load"))
+		goto cleanup;
+
+	err = test_cgroup_attach__attach(skel);
+	if (!ASSERT_OK(err, "skel attach"))
+		goto cleanup;
+
+	skel->bss->monitored_pid = getpid();
+
+	denied_cgid = get_cgroup_id("/denied");
+	if (!ASSERT_NEQ(denied_cgid, 0ULL, "get denied cgroup id"))
+		goto cleanup;
+
+	key = denied_cgid;
+	err = bpf_map__update_elem(skel->maps.denied_cgroups,
+				   &key, sizeof(key), &val, sizeof(val), 0);
+	if (!ASSERT_OK(err, "add denied cgroup"))
+		goto cleanup;
+
+	/*
+	 * Forked children must use join_parent_cgroup() because the
+	 * cgroup workdir was created under the parent's PID and
+	 * join_cgroup() constructs paths using getpid().
+	 */
+
+	/* Child migrating to /allowed should succeed */
+	child = fork();
+	if (!ASSERT_GE(child, 0, "fork child allowed"))
+		goto cleanup;
+	if (child == 0) {
+		if (join_parent_cgroup("/allowed"))
+			_exit(1);
+		_exit(0);
+	}
+	err = waitpid(child, &status, 0);
+	ASSERT_GT(err, 0, "waitpid allowed");
+	ASSERT_TRUE(WIFEXITED(status), "allowed child exited");
+	ASSERT_EQ(WEXITSTATUS(status), 0, "allowed migration succeeds");
+
+	/* Child migrating to /denied should fail */
+	child = fork();
+	if (!ASSERT_GE(child, 0, "fork child denied"))
+		goto cleanup;
+	if (child == 0) {
+		if (join_parent_cgroup("/denied") == 0)
+			_exit(1); /* Should have failed */
+		if (errno != EPERM)
+			_exit(2); /* Wrong errno */
+		_exit(0);
+	}
+	err = waitpid(child, &status, 0);
+	ASSERT_GT(err, 0, "waitpid denied");
+	ASSERT_TRUE(WIFEXITED(status), "denied child exited");
+	ASSERT_EQ(WEXITSTATUS(status), 0, "denied migration blocked");
+
+	/* Detach BPF — /denied should now be accessible */
+	test_cgroup_attach__detach(skel);
+
+	child = fork();
+	if (!ASSERT_GE(child, 0, "fork child post-detach"))
+		goto cleanup;
+	if (child == 0) {
+		if (join_parent_cgroup("/denied"))
+			_exit(1);
+		_exit(0);
+	}
+	err = waitpid(child, &status, 0);
+	ASSERT_GT(err, 0, "waitpid post-detach");
+	ASSERT_TRUE(WIFEXITED(status), "post-detach child exited");
+	ASSERT_EQ(WEXITSTATUS(status), 0, "post-detach migration free");
+
+cleanup:
+	if (skel)
+		test_cgroup_attach__destroy(skel);
+	if (allowed_fd >= 0)
+		close(allowed_fd);
+	if (denied_fd >= 0)
+		close(denied_fd);
+	cleanup_cgroup_environment();
+}
+
+/*
+ * Subtest: verify_hook_args
+ *
+ * Verify that the hook receives correct src_cgrp, dst_cgrp, task pid,
+ * and threadgroup values.
+ */
+static void test_verify_hook_args(void)
+{
+	struct test_cgroup_attach *skel = NULL;
+	struct attach_event evt = {};
+	unsigned long long src_cgid, dst_cgid;
+	int src_fd = -1, dst_fd = -1;
+	__u32 map_key = 0;
+	char pid_str[32];
+	int err;
+
+	if (!ASSERT_OK(setup_cgroup_environment(), "setup_cgroup_env"))
+		return;
+
+	src_fd = create_and_get_cgroup("/src");
+	if (!ASSERT_GE(src_fd, 0, "create /src"))
+		goto cleanup;
+
+	dst_fd = create_and_get_cgroup("/dst");
+	if (!ASSERT_GE(dst_fd, 0, "create /dst"))
+		goto cleanup;
+
+	/* Move ourselves to /src first */
+	if (!ASSERT_OK(join_cgroup("/src"), "join /src"))
+		goto cleanup;
+
+	skel = test_cgroup_attach__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel open_and_load"))
+		goto cleanup;
+
+	err = test_cgroup_attach__attach(skel);
+	if (!ASSERT_OK(err, "skel attach"))
+		goto cleanup;
+
+	skel->bss->monitored_pid = getpid();
+
+	src_cgid = get_cgroup_id("/src");
+	dst_cgid = get_cgroup_id("/dst");
+	if (!ASSERT_NEQ(src_cgid, 0ULL, "get src cgroup id"))
+		goto cleanup;
+	if (!ASSERT_NEQ(dst_cgid, 0ULL, "get dst cgroup id"))
+		goto cleanup;
+
+	/* Migrate self to /dst via cgroup.procs (threadgroup=true) */
+	snprintf(pid_str, sizeof(pid_str), "%d", getpid());
+	if (!ASSERT_OK(write_cgroup_file("/dst", "cgroup.procs", pid_str),
+		       "migrate to /dst"))
+		goto cleanup;
+
+	/* Read the recorded event */
+	err = bpf_map__lookup_elem(skel->maps.last_event,
+				   &map_key, sizeof(map_key),
+				   &evt, sizeof(evt), 0);
+	if (!ASSERT_OK(err, "read last_event"))
+		goto cleanup;
+
+	ASSERT_EQ(evt.src_cgrp_id, src_cgid, "src_cgrp_id matches");
+	ASSERT_EQ(evt.dst_cgrp_id, dst_cgid, "dst_cgrp_id matches");
+	ASSERT_EQ(evt.task_pid, (__u32)getpid(), "task_pid matches");
+	ASSERT_EQ(evt.threadgroup, 1, "threadgroup is true for cgroup.procs");
+	ASSERT_GE(evt.hook_count, (__u32)1, "hook fired at least once");
+
+cleanup:
+	if (skel)
+		test_cgroup_attach__destroy(skel);
+	if (src_fd >= 0)
+		close(src_fd);
+	if (dst_fd >= 0)
+		close(dst_fd);
+	cleanup_cgroup_environment();
+}
+
+/*
+ * Subtest: clone_into_cgroup
+ *
+ * Verify the hook fires on the clone3(CLONE_INTO_CGROUP) path and can
+ * deny spawning a child directly into a cgroup.
+ */
+static void test_clone_into_cgroup(void)
+{
+	struct test_cgroup_attach *skel = NULL;
+	int allowed_fd = -1, denied_fd = -1;
+	unsigned long long denied_cgid, allowed_cgid;
+	struct attach_event evt = {};
+	__u32 map_key = 0;
+	__u64 key;
+	__u8 val = 1;
+	int err, status;
+	pid_t child;
+
+	if (!ASSERT_OK(setup_cgroup_environment(), "setup_cgroup_env"))
+		return;
+
+	allowed_fd = create_and_get_cgroup("/clone_allowed");
+	if (!ASSERT_GE(allowed_fd, 0, "create /clone_allowed"))
+		goto cleanup;
+
+	denied_fd = create_and_get_cgroup("/clone_denied");
+	if (!ASSERT_GE(denied_fd, 0, "create /clone_denied"))
+		goto cleanup;
+
+	skel = test_cgroup_attach__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel open_and_load"))
+		goto cleanup;
+
+	err = test_cgroup_attach__attach(skel);
+	if (!ASSERT_OK(err, "skel attach"))
+		goto cleanup;
+
+	skel->bss->monitored_pid = getpid();
+
+	denied_cgid = get_cgroup_id("/clone_denied");
+	allowed_cgid = get_cgroup_id("/clone_allowed");
+	if (!ASSERT_NEQ(denied_cgid, 0ULL, "get denied cgroup id"))
+		goto cleanup;
+	if (!ASSERT_NEQ(allowed_cgid, 0ULL, "get allowed cgroup id"))
+		goto cleanup;
+
+	key = denied_cgid;
+	err = bpf_map__update_elem(skel->maps.denied_cgroups,
+				   &key, sizeof(key), &val, sizeof(val), 0);
+	if (!ASSERT_OK(err, "add denied cgroup"))
+		goto cleanup;
+
+	/* clone3 into denied cgroup should fail */
+	child = do_clone3(denied_fd);
+	if (child >= 0) {
+		waitpid(child, NULL, 0);
+		ASSERT_LT(child, 0, "clone3 into denied should fail");
+		goto cleanup;
+	}
+	if (errno == ENOSYS || errno == E2BIG) {
+		test__skip();
+		goto cleanup;
+	}
+	ASSERT_EQ(errno, EPERM, "clone3 denied errno");
+
+	/* clone3 into allowed cgroup should succeed */
+	child = do_clone3(allowed_fd);
+	if (!ASSERT_GE(child, 0, "clone3 into allowed"))
+		goto cleanup;
+	if (child == 0)
+		_exit(0);
+
+	err = waitpid(child, &status, 0);
+	ASSERT_GT(err, 0, "waitpid clone3 allowed");
+	ASSERT_TRUE(WIFEXITED(status), "clone3 child exited");
+	ASSERT_EQ(WEXITSTATUS(status), 0, "clone3 child ok");
+
+	/* Verify the hook recorded the allowed clone */
+	err = bpf_map__lookup_elem(skel->maps.last_event,
+				   &map_key, sizeof(map_key),
+				   &evt, sizeof(evt), 0);
+	if (!ASSERT_OK(err, "read last_event"))
+		goto cleanup;
+
+	ASSERT_EQ(evt.dst_cgrp_id, allowed_cgid, "clone3 dst_cgrp_id");
+
+cleanup:
+	if (skel)
+		test_cgroup_attach__destroy(skel);
+	if (allowed_fd >= 0)
+		close(allowed_fd);
+	if (denied_fd >= 0)
+		close(denied_fd);
+	cleanup_cgroup_environment();
+}
+
+void test_cgroup_attach(void)
+{
+	if (test__start_subtest("deny_migration"))
+		test_deny_migration();
+	if (test__start_subtest("verify_hook_args"))
+		test_verify_hook_args();
+	if (test__start_subtest("clone_into_cgroup"))
+		test_clone_into_cgroup();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_cgroup_attach.c b/tools/testing/selftests/bpf/progs/test_cgroup_attach.c
new file mode 100644
index 000000000000..90915d1d7d64
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_cgroup_attach.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Christian Brauner <brauner@kernel.org> */
+
+/*
+ * BPF LSM cgroup attach policy: supervise cgroup migration.
+ *
+ * A designated process populates a denied_cgroups map with cgroup IDs
+ * that should reject migration.  The cgroup_attach hook checks every
+ * migration and returns -EPERM when the destination cgroup is denied.
+ * It also records the last hook invocation into last_event for the
+ * userspace test to verify arguments.
+ */
+
+#include "vmlinux.h"
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+struct attach_event {
+	__u32 task_pid;
+	__u64 src_cgrp_id;
+	__u64 dst_cgrp_id;
+	__u8  threadgroup;
+	__u32 hook_count;
+};
+
+/*
+ * Cgroups that should reject migration.
+ * Key:   cgroup kn->id (u64).
+ * Value: unused marker.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 16);
+	__type(key, __u64);
+	__type(value, __u8);
+} denied_cgroups SEC(".maps");
+
+/*
+ * Record the last hook invocation for argument verification.
+ * Key:   0.
+ * Value: struct attach_event.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct attach_event);
+} last_event SEC(".maps");
+
+__u32 monitored_pid;
+
+char _license[] SEC("license") = "GPL";
+
+SEC("lsm.s/cgroup_attach")
+int BPF_PROG(cgroup_attach, struct task_struct *task,
+	     struct cgroup *src_cgrp, struct cgroup *dst_cgrp,
+	     struct super_block *sb, bool threadgroup,
+	     struct cgroup_namespace *ns)
+{
+	struct task_struct *current = bpf_get_current_task_btf();
+	struct attach_event *evt;
+	__u64 dst_id;
+	__u32 key = 0;
+
+	dst_id = BPF_CORE_READ(dst_cgrp, kn, id);
+
+	if (bpf_map_lookup_elem(&denied_cgroups, &dst_id))
+		return -EPERM;
+
+	if (!monitored_pid || current->tgid != monitored_pid)
+		return 0;
+
+	evt = bpf_map_lookup_elem(&last_event, &key);
+	if (evt) {
+		evt->task_pid = task->pid;
+		evt->src_cgrp_id = BPF_CORE_READ(src_cgrp, kn, id);
+		evt->dst_cgrp_id = dst_id;
+		evt->threadgroup = threadgroup ? 1 : 0;
+		evt->hook_count++;
+	}
+
+	return 0;
+}

-- 
2.47.3


