Return-Path: <cgroups+bounces-11221-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3031C12074
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 00:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A074050DA
	for <lists+cgroups@lfdr.de>; Mon, 27 Oct 2025 23:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6171334C36;
	Mon, 27 Oct 2025 23:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RqKmQfBZ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413CA3346B6;
	Mon, 27 Oct 2025 23:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607375; cv=none; b=Vm9u/ng3JR6SVHmGCb5dYdeSx52c4XrThPARtx4O0Q0f8QpBacdLngIEZ9vpfCZFzitan7DKfVXT8ALIDFux6D6QuHwyyFuJ2CdWv9+k6MX+nG0bm1uHf4u/xpjksoUa60enitA9N22DbZbSOSAblCgv7LQfg1jAt6tLg0t5rmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607375; c=relaxed/simple;
	bh=DUuHJPgRzBDVLl6SdITE8OJPAHmUxctftJ+aVY5lvKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njP1pKO73CNXwHoVQwIZoxMWEvM9sjuEUPJlYxXFeglvdq3jb0DAFseT8LRn9zXRhyIWiVyZmbLJHadddEkNA5X7ibej+WOv5x910dW8jYWpdCagXSlewO3++bubcTnEDcUQxvF/lOOenJoNDkOPv3m99/BqqdwSY80Y45xlmXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RqKmQfBZ; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761607371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DZ0f+kz7SjYR0994KQXx6s1K86PlfExovkcbk43EfBE=;
	b=RqKmQfBZBdZFvjHHa2i1c9LuHkG9bPcN+BuPZKMDcm4i/kbV24DwlpFnFvXjg+1T9AVP7B
	j9IQ8U51XYUpf4RO/1o69mHO7zYEqNgXsygZQaUzVg5yAswdy8bWjh2eYiFQNdHXeMaP6G
	R4OGd/e5r3E6JQsPyQj2O5oIjCEanqk=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 18/23] bpf: selftests: BPF OOM handler test
Date: Mon, 27 Oct 2025 16:22:01 -0700
Message-ID: <20251027232206.473085-8-roman.gushchin@linux.dev>
In-Reply-To: <20251027232206.473085-1-roman.gushchin@linux.dev>
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Implement a kselftest for the OOM handling functionality.

The OOM handling policy which is implemented in BPF is to
kill all tasks belonging to the biggest leaf cgroup, which
doesn't contain unkillable tasks (tasks with oom_score_adj
set to -1000). Pagecache size is excluded from the accounting.

The test creates a hierarchy of memory cgroups, causes an
OOM at the top level, checks that the expected process will be
killed and checks memcg's oom statistics.

Please, note that the same BPF OOM policy is attached to a memory
cgroup and system-wide. In the first case the program does nothing
and returns false, so it's executed the second time, when it properly
handles the OOM.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 .../selftests/bpf/prog_tests/test_oom.c       | 249 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_oom.c  | 118 +++++++++
 2 files changed, 367 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_oom.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_oom.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_oom.c b/tools/testing/selftests/bpf/prog_tests/test_oom.c
new file mode 100644
index 000000000000..6126d961aba3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_oom.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include <bpf/bpf.h>
+
+#include "cgroup_helpers.h"
+#include "test_oom.skel.h"
+
+struct cgroup_desc {
+	const char *path;
+	int fd;
+	unsigned long long id;
+	int pid;
+	size_t target;
+	size_t max;
+	int oom_score_adj;
+	bool victim;
+};
+
+#define MB (1024 * 1024)
+#define OOM_SCORE_ADJ_MIN	(-1000)
+#define OOM_SCORE_ADJ_MAX	1000
+
+static struct cgroup_desc cgroups[] = {
+	{ .path = "/oom_test", .max = 80 * MB},
+	{ .path = "/oom_test/cg1", .target = 10 * MB,
+	  .oom_score_adj = OOM_SCORE_ADJ_MAX },
+	{ .path = "/oom_test/cg2", .target = 40 * MB,
+	  .oom_score_adj = OOM_SCORE_ADJ_MIN },
+	{ .path = "/oom_test/cg3" },
+	{ .path = "/oom_test/cg3/cg4", .target = 30 * MB,
+	  .victim = true },
+	{ .path = "/oom_test/cg3/cg5", .target = 20 * MB },
+};
+
+static int spawn_task(struct cgroup_desc *desc)
+{
+	char *ptr;
+	int pid;
+
+	pid = fork();
+	if (pid < 0)
+		return pid;
+
+	if (pid > 0) {
+		/* parent */
+		desc->pid = pid;
+		return 0;
+	}
+
+	/* child */
+	if (desc->oom_score_adj) {
+		char buf[64];
+		int fd = open("/proc/self/oom_score_adj", O_WRONLY);
+
+		if (fd < 0)
+			return -1;
+
+		snprintf(buf, sizeof(buf), "%d", desc->oom_score_adj);
+		write(fd, buf, sizeof(buf));
+		close(fd);
+	}
+
+	ptr = (char *)malloc(desc->target);
+	if (!ptr)
+		return -ENOMEM;
+
+	memset(ptr, 'a', desc->target);
+
+	while (1)
+		sleep(1000);
+
+	return 0;
+}
+
+static void setup_environment(void)
+{
+	int i, err;
+
+	err = setup_cgroup_environment();
+	if (!ASSERT_OK(err, "setup_cgroup_environment"))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(cgroups); i++) {
+		cgroups[i].fd = create_and_get_cgroup(cgroups[i].path);
+		if (!ASSERT_GE(cgroups[i].fd, 0, "create_and_get_cgroup"))
+			goto cleanup;
+
+		cgroups[i].id = get_cgroup_id(cgroups[i].path);
+		if (!ASSERT_GT(cgroups[i].id, 0, "get_cgroup_id"))
+			goto cleanup;
+
+		/* Freeze the top-level cgroup */
+		if (i == 0) {
+			/* Freeze the top-level cgroup */
+			err = write_cgroup_file(cgroups[i].path, "cgroup.freeze", "1");
+			if (!ASSERT_OK(err, "freeze cgroup"))
+				goto cleanup;
+		}
+
+		/* Recursively enable the memory controller */
+		if (!cgroups[i].target) {
+
+			err = write_cgroup_file(cgroups[i].path, "cgroup.subtree_control",
+						"+memory");
+			if (!ASSERT_OK(err, "enable memory controller"))
+				goto cleanup;
+		}
+
+		/* Set memory.max */
+		if (cgroups[i].max) {
+			char buf[256];
+
+			snprintf(buf, sizeof(buf), "%lu", cgroups[i].max);
+			err = write_cgroup_file(cgroups[i].path, "memory.max", buf);
+			if (!ASSERT_OK(err, "set memory.max"))
+				goto cleanup;
+
+			snprintf(buf, sizeof(buf), "0");
+			write_cgroup_file(cgroups[i].path, "memory.swap.max", buf);
+
+		}
+
+		/* Spawn tasks creating memory pressure */
+		if (cgroups[i].target) {
+			char buf[256];
+
+			err = spawn_task(&cgroups[i]);
+			if (!ASSERT_OK(err, "spawn task"))
+				goto cleanup;
+
+			snprintf(buf, sizeof(buf), "%d", cgroups[i].pid);
+			err = write_cgroup_file(cgroups[i].path, "cgroup.procs", buf);
+			if (!ASSERT_OK(err, "put child into a cgroup"))
+				goto cleanup;
+		}
+	}
+
+	return;
+
+cleanup:
+	cleanup_cgroup_environment();
+}
+
+static int run_and_wait_for_oom(void)
+{
+	int ret = -1;
+	bool first = true;
+	char buf[4096] = {};
+	size_t size;
+
+	/* Unfreeze the top-level cgroup */
+	ret = write_cgroup_file(cgroups[0].path, "cgroup.freeze", "0");
+	if (!ASSERT_OK(ret, "freeze cgroup"))
+		return -1;
+
+	for (;;) {
+		int i, status;
+		pid_t pid = wait(&status);
+
+		if (pid == -1) {
+			if (errno == EINTR)
+				continue;
+			/* ECHILD */
+			break;
+		}
+
+		if (!first)
+			continue;
+
+		first = false;
+
+		/* Check which process was terminated first */
+		for (i = 0; i < ARRAY_SIZE(cgroups); i++) {
+			if (!ASSERT_OK(cgroups[i].victim !=
+				       (pid == cgroups[i].pid),
+				       "correct process was killed")) {
+				ret = -1;
+				break;
+			}
+
+			if (!cgroups[i].victim)
+				continue;
+
+			/* Check the memcg oom counter */
+			size = read_cgroup_file(cgroups[i].path,
+						"memory.events",
+						buf, sizeof(buf));
+			if (!ASSERT_OK(size <= 0, "read memory.events")) {
+				ret = -1;
+				break;
+			}
+
+			if (!ASSERT_OK(strstr(buf, "oom_kill 1") == NULL,
+				       "oom_kill count check")) {
+				ret = -1;
+				break;
+			}
+		}
+
+		/* Kill all remaining tasks */
+		for (i = 0; i < ARRAY_SIZE(cgroups); i++)
+			if (cgroups[i].pid && cgroups[i].pid != pid)
+				kill(cgroups[i].pid, SIGKILL);
+	}
+
+	return ret;
+}
+
+void test_oom(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_struct_ops_opts, opts);
+	struct test_oom *skel;
+	struct bpf_link *link1, *link2;
+	int err = 0;
+
+	setup_environment();
+
+	skel = test_oom__open_and_load();
+	if (!skel) {
+		err = -errno;
+		CHECK_FAIL(err);
+		goto cleanup;
+	}
+
+	opts.relative_fd = cgroups[0].fd;
+	link1 = bpf_map__attach_struct_ops_opts(skel->maps.test_bpf_oom, &opts);
+	if (!link1) {
+		err = -errno;
+		CHECK_FAIL(err);
+		goto cleanup;
+	}
+
+	opts.relative_fd = 0; /* attach system-wide */
+	link2 = bpf_map__attach_struct_ops_opts(skel->maps.test_bpf_oom, &opts);
+	if (!link2) {
+		err = -errno;
+		CHECK_FAIL(err);
+		goto cleanup;
+	}
+
+	/* Unfreeze all child tasks and create the memory pressure */
+	err = run_and_wait_for_oom();
+	CHECK_FAIL(err);
+
+cleanup:
+	cleanup_cgroup_environment();
+	test_oom__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_oom.c b/tools/testing/selftests/bpf/progs/test_oom.c
new file mode 100644
index 000000000000..ded5c0375df7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_oom.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define OOM_SCORE_ADJ_MIN	(-1000)
+
+static bool mem_cgroup_killable(struct mem_cgroup *memcg)
+{
+	struct task_struct *task;
+	bool ret = true;
+
+	bpf_for_each(css_task, task, &memcg->css, CSS_TASK_ITER_PROCS)
+		if (task->signal->oom_score_adj == OOM_SCORE_ADJ_MIN)
+			return false;
+
+	return ret;
+}
+
+/*
+ * Find the largest leaf cgroup (ignoring page cache) without unkillable tasks
+ * and kill all belonging tasks.
+ */
+SEC("struct_ops.s/handle_out_of_memory")
+int BPF_PROG(test_out_of_memory, struct bpf_oom_ctx *exec_ctx, struct oom_control *oc)
+{
+	struct task_struct *task;
+	struct mem_cgroup *root_memcg = oc->memcg;
+	struct mem_cgroup *memcg, *victim = NULL;
+	struct cgroup_subsys_state *css_pos;
+	unsigned long usage, max_usage = 0;
+	unsigned long pagecache = 0;
+	int ret = 0;
+
+	/* Pass to the system-level bpf_oom ops */
+	if (exec_ctx->cgroup_id)
+		return 0;
+
+	if (root_memcg)
+		root_memcg = bpf_get_mem_cgroup(&root_memcg->css);
+	else
+		root_memcg = bpf_get_root_mem_cgroup();
+
+	if (!root_memcg)
+		return 0;
+
+	bpf_rcu_read_lock();
+	bpf_for_each(css, css_pos, &root_memcg->css, BPF_CGROUP_ITER_DESCENDANTS_POST) {
+		if (css_pos->cgroup->nr_descendants + css_pos->cgroup->nr_dying_descendants)
+			continue;
+
+		memcg = bpf_get_mem_cgroup(css_pos);
+		if (!memcg)
+			continue;
+
+		usage = bpf_mem_cgroup_usage(memcg);
+		pagecache = bpf_mem_cgroup_page_state(memcg, NR_FILE_PAGES);
+
+		if (usage > pagecache)
+			usage -= pagecache;
+		else
+			usage = 0;
+
+		if ((usage > max_usage) && mem_cgroup_killable(memcg)) {
+			max_usage = usage;
+			if (victim)
+				bpf_put_mem_cgroup(victim);
+			victim = bpf_get_mem_cgroup(&memcg->css);
+		}
+
+		bpf_put_mem_cgroup(memcg);
+	}
+	bpf_rcu_read_unlock();
+
+	if (!victim)
+		goto exit;
+
+	bpf_for_each(css_task, task, &victim->css, CSS_TASK_ITER_PROCS) {
+		struct task_struct *t = bpf_task_acquire(task);
+
+		if (t) {
+			/*
+			 * If the task is already an OOM victim, it will
+			 * quit soon and release some memory.
+			 */
+			if (bpf_task_is_oom_victim(task)) {
+				bpf_task_release(t);
+				ret = 1;
+				break;
+			}
+
+			bpf_oom_kill_process(oc, task, "bpf oom test");
+			bpf_task_release(t);
+			ret = 1;
+		}
+	}
+
+	bpf_put_mem_cgroup(victim);
+exit:
+	bpf_put_mem_cgroup(root_memcg);
+
+	return ret;
+}
+
+SEC("struct_ops.s/handle_cgroup_offline")
+int BPF_PROG(test_cgroup_offline, struct bpf_oom_ctx *exec_ctx, u64 cgroup_id)
+{
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_oom_ops test_bpf_oom = {
+	.name = "bpf_test_policy",
+	.handle_out_of_memory = (void *)test_out_of_memory,
+	.handle_cgroup_offline = (void *)test_cgroup_offline,
+};
-- 
2.51.0


