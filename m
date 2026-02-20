Return-Path: <cgroups+bounces-14044-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIiNLDCtl2nO5QIAu9opvQ
	(envelope-from <cgroups+bounces-14044-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 01:39:12 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B87163E1E
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 01:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0013D3010834
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 00:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DBF1E7660;
	Fri, 20 Feb 2026 00:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1moi2wX"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C481F418F;
	Fri, 20 Feb 2026 00:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771547932; cv=none; b=CsZz6uijMNyy2k1+VAEgElcGZt9ULLTxgBsra9LRIYR2NKJUF75zRoKkDbDgpu3JcFf1qvYX3GiABvnNyTJARD6rcrNzOv5TUbhxALg6A34h3ofqJmaVKXyNSddZMlMZqtd5ApT2gVJr0IPnnlCpVnoyLNhxGOtkzgPSB6PEvjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771547932; c=relaxed/simple;
	bh=2Y18MqPJiqmQVhKG7YQFspLjTM48CG/DtkSLoIi4Iow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j8dlW3Z9Qk7Bp9oGacKobMS0kWe+L/gb+VQmB2qydt6bgTxzfU6rc3wYbMiU+47xOehi1WxpxVpSXowFPuXV01IevokyV9k4Ypnrq7/16vPwKHhu9L52BLuTYbkjtc13H87wYJzHI/4+M5Pq0+RIe0qfk6TJHGDrFytyryAFqqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1moi2wX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E02EC19423;
	Fri, 20 Feb 2026 00:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771547931;
	bh=2Y18MqPJiqmQVhKG7YQFspLjTM48CG/DtkSLoIi4Iow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H1moi2wXruReO4MD5w/4SbDwD21QYAFcHx6YNZTKWco5i242sHeKzYbbrzcTd09in
	 ZP3cmgMfraUiXlNW4V7z7Hzt+EYXEQ0dW2OLD220Jwe3r7TBlVjvFOYAuQhOkjweP8
	 un7FZgRTFDEWGBy6FJ9G/LoYH1a7wl0B23LStgEg5pOaS0BWQkPzrjtLpzT3z0Km9c
	 HWLMR6QZgf3utEhs0h4Tb8kByqwsZKMDQDQUmt0RBrJvFDq3BN29psa82UAsxaaMC4
	 QdQolFOK2DP2g8EdnBQ29jxyHzPor0/UNT4k5WLo52JTAIr16eSHJh3CZSMFDzbXra
	 6O6L7WEX1wPXw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 20 Feb 2026 01:38:31 +0100
Subject: [PATCH 3/4] selftests/bpf: add ns hook selftest
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260220-work-bpf-namespace-v1-3-866207db7b83@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6123; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2Y18MqPJiqmQVhKG7YQFspLjTM48CG/DtkSLoIi4Iow=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROXyuwp1nHZ8kM0/AVap3XHvUH+22dcb9kYcaXSXuub
 b0ikxP9sKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiR3Yw/GZNWLDqcLy1hmlT
 Rvjb95pbl4csXipzWClEiivg0Zs0j15Ghq933/u+3bgqa0sbv6vL1YvZtoEz7nf+8g/SF/eLz8g
 6ygoA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14044-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9B87163E1E
X-Rspamd-Action: no action

Add a BPF LSM selftest that implements a "lock on entry" namespace
sandbox policy.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/ns_sandbox.c  | 99 ++++++++++++++++++++++
 .../testing/selftests/bpf/progs/test_ns_sandbox.c  | 91 ++++++++++++++++++++
 2 files changed, 190 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/ns_sandbox.c b/tools/testing/selftests/bpf/prog_tests/ns_sandbox.c
new file mode 100644
index 000000000000..0ac2acfb6365
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/ns_sandbox.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Christian Brauner <brauner@kernel.org> */
+
+/*
+ * Test BPF LSM namespace sandbox: once you enter, you stay.
+ *
+ * The parent creates a tracked namespace, then forks a child.
+ * The child enters the tracked namespace (allowed) and is then locked
+ * out of any further setns().
+ */
+
+#define _GNU_SOURCE
+#include <test_progs.h>
+#include <sched.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/wait.h>
+#include "test_ns_sandbox.skel.h"
+
+void test_ns_sandbox(void)
+{
+	int orig_utsns = -1, new_utsns = -1;
+	struct test_ns_sandbox *skel = NULL;
+	int err, status;
+	pid_t child;
+
+	/* Save FD to current (host) namespace */
+	orig_utsns = open("/proc/self/ns/uts", O_RDONLY);
+	if (!ASSERT_OK_FD(orig_utsns, "open orig utsns"))
+		goto close_fds;
+
+	skel = test_ns_sandbox__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel open_and_load"))
+		goto close_fds;
+
+	err = test_ns_sandbox__attach(skel);
+	if (!ASSERT_OK(err, "skel attach"))
+		goto destroy;
+
+	skel->bss->monitor_pid = getpid();
+
+	/*
+	 * Create a sandbox namespace.  The alloc hook records its
+	 * inum because this task's pid matches monitor_pid.
+	 */
+	err = unshare(CLONE_NEWUTS);
+	if (!ASSERT_OK(err, "unshare sandbox"))
+		goto destroy;
+
+	new_utsns = open("/proc/self/ns/uts", O_RDONLY);
+	if (!ASSERT_OK_FD(new_utsns, "open sandbox utsns"))
+		goto restore;
+
+	/*
+	 * Return parent to host namespace.  The host namespace is not
+	 * in the map so the install hook lets us through.
+	 */
+	err = setns(orig_utsns, CLONE_NEWUTS);
+	if (!ASSERT_OK(err, "parent setns host utsns"))
+		goto restore;
+
+	/*
+	 * Fork a child that:
+	 *  1. Enters the sandbox UTS namespace — succeeds and locks it.
+	 *  2. Tries to switch to host UTS — denied (locked).
+	 */
+	child = fork();
+	if (child == 0) {
+		/* Enter tracked namespace — allowed, we get locked */
+		if (setns(new_utsns, CLONE_NEWUTS) != 0)
+			_exit(1);
+
+		/* Locked: switching to host must fail */
+		if (setns(orig_utsns, CLONE_NEWUTS) != -1 ||
+		    errno != EPERM)
+			_exit(2);
+
+		_exit(0);
+	}
+	if (!ASSERT_GE(child, 0, "fork child"))
+		goto restore;
+
+	err = waitpid(child, &status, 0);
+	ASSERT_GT(err, 0, "waitpid child");
+	ASSERT_TRUE(WIFEXITED(status), "child exited");
+	ASSERT_EQ(WEXITSTATUS(status), 0, "child locked in");
+
+	goto destroy;
+
+restore:
+	setns(orig_utsns, CLONE_NEWUTS);
+destroy:
+	test_ns_sandbox__destroy(skel);
+close_fds:
+	if (new_utsns >= 0)
+		close(new_utsns);
+	if (orig_utsns >= 0)
+		close(orig_utsns);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_ns_sandbox.c b/tools/testing/selftests/bpf/progs/test_ns_sandbox.c
new file mode 100644
index 000000000000..75c3493932a1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_ns_sandbox.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Christian Brauner <brauner@kernel.org> */
+
+/*
+ * BPF LSM namespace sandbox: once you enter, you stay.
+ *
+ * A designated process creates namespaces (tracked via alloc).  When
+ * any other process joins one of those namespaces it gets recorded in
+ * locked_tasks.  From that point on that process cannot setns() into
+ * any other namespace — it is locked in.  Task local storage is
+ * automatically freed when the task exits.
+ */
+
+#include "vmlinux.h"
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+/*
+ * Namespaces created by the monitored process.
+ * Key:   namespace inode number.
+ * Value: namespace type (CLONE_NEW* flag).
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 64);
+	__type(key, __u32);
+	__type(value, __u32);
+} known_namespaces SEC(".maps");
+
+/* PID of the process whose namespace creations are tracked. */
+int monitor_pid;
+
+/*
+ * Task local storage: marks tasks that have entered a tracked namespace
+ * and are now locked.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, __u8);
+} locked_tasks SEC(".maps");
+
+char _license[] SEC("license") = "GPL";
+
+/* Only the monitored process's namespace creations are tracked. */
+SEC("lsm.s/namespace_alloc")
+int BPF_PROG(ns_alloc, struct ns_common *ns)
+{
+	__u32 inum, ns_type;
+
+	if ((bpf_get_current_pid_tgid() >> 32) != monitor_pid)
+		return 0;
+
+	inum = ns->inum;
+	ns_type = ns->ns_type;
+	bpf_map_update_elem(&known_namespaces, &inum, &ns_type, BPF_ANY);
+
+	return 0;
+}
+
+/*
+ * Enforce the lock-in policy for all tasks:
+ * - Already locked?  Deny any setns.
+ * - Entering a tracked namespace?  Lock the task and allow.
+ * - Everything else passes through.
+ */
+SEC("lsm.s/namespace_install")
+int BPF_PROG(ns_install, struct nsset *nsset, struct ns_common *ns)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	__u32 inum = ns->inum;
+
+	if (bpf_task_storage_get(&locked_tasks, task, 0, 0))
+		return -EPERM;
+
+	if (bpf_map_lookup_elem(&known_namespaces, &inum))
+		bpf_task_storage_get(&locked_tasks, task, 0,
+				     BPF_LOCAL_STORAGE_GET_F_CREATE);
+
+	return 0;
+}
+
+SEC("lsm/namespace_free")
+void BPF_PROG(ns_free, struct ns_common *ns)
+{
+	__u32 inum = ns->inum;
+
+	bpf_map_delete_elem(&known_namespaces, &inum);
+}

-- 
2.47.3


