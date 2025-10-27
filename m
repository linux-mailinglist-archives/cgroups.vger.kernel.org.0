Return-Path: <cgroups+bounces-11226-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DDDC120A1
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 00:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB451584551
	for <lists+cgroups@lfdr.de>; Mon, 27 Oct 2025 23:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBB13314A9;
	Mon, 27 Oct 2025 23:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E7E4LM8d"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08235330D43;
	Mon, 27 Oct 2025 23:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607398; cv=none; b=C5dY3tf3PTfSDAXtcXBGH5pVE+NSo/NAvzf5RSfGOmqtYowLEEWX9mFiuHjwMXVdza7PCokU90wtblf3QQNXkZ2TbtPE3k8cBVxjuQI5F9QWUHPpA3mDTUEnFT+uuKvLBBsKuXvlepMO7QWI4co21vqP8YGg2iHPwl1IQuBrzdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607398; c=relaxed/simple;
	bh=VQVKdTMAyi6QHS87Ca/J1BY2fX1H1tye+2yFXSneJ1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzHwBeA+1NvAGBiHIetmrMbex/jCvK6c5jL2QRErgYf6uv+e2bANZYLpPLcJleRrrBNhNFTC86GqDLAgmCnzJGYageaHzM4JfqaehaTDesIGTsj5BpuJ09WsAYJfMfgsAh7zKlHhoV6d2ikTlm0cCF6nvYcmBsFE9ASiu+g+Mjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E7E4LM8d; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761607395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zUole0fevJNTWH/QrfuoUDEj281F+dD7fcGUfbGb1V8=;
	b=E7E4LM8dJ/rehFz/AdqoNoWUiisJMzEZYiPcspGMTpSMJc+isYT5KpRiWBUtC5bvTBEnNk
	13DwqOcebTOKCNjdutYBUn2zf223HSkRZ5HqzVB273/Zs6Rdy+/02MadYY8X6GmkTqxUzb
	SEzFrJjrfveD/JJz9dwULbYzl65J9uY=
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
Subject: [PATCH v2 23/23] bpf: selftests: PSI struct ops test
Date: Mon, 27 Oct 2025 16:22:06 -0700
Message-ID: <20251027232206.473085-13-roman.gushchin@linux.dev>
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

Add a PSI struct ops test.

The test creates a cgroup with two child sub-cgroups, sets up
memory.high for one of those and puts there a memory hungry
process (initially frozen).

Then it creates 2 PSI triggers from within a init() BPF callback and
attaches them to these cgroups.  Then it deletes the first cgroup,
creates another one and runs the memory hungry task. From the cgroup
creation callback the test is creating another trigger.

The memory hungry task is creating a high memory pressure in one
memory cgroup, which triggers a PSI event. The PSI BPF handler
declares a memcg oom in the corresponding cgroup. Finally the checks
that both handle_cgroup_free() and handle_psi_event() handlers were
executed, the correct process was killed and oom counters were
updated.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 .../selftests/bpf/prog_tests/test_psi.c       | 238 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_psi.c  |  82 ++++++
 2 files changed, 320 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_psi.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_psi.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_psi.c b/tools/testing/selftests/bpf/prog_tests/test_psi.c
new file mode 100644
index 000000000000..b294cea0a6fe
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_psi.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include <bpf/bpf.h>
+
+#include "cgroup_helpers.h"
+#include "test_psi.skel.h"
+
+enum psi_res {
+	PSI_IO,
+	PSI_MEM,
+	PSI_CPU,
+	PSI_IRQ,
+	NR_PSI_RESOURCES,
+};
+
+struct cgroup_desc {
+	const char *path;
+	unsigned long long id;
+	int pid;
+	int fd;
+	size_t target;
+	size_t high;
+	bool victim;
+};
+
+#define MB (1024 * 1024)
+
+static struct cgroup_desc cgroups[] = {
+	{ .path = "/psi_test" },
+	{ .path = "/psi_test/cg1" },
+	{ .path = "/psi_test/cg2", .target = 500 * MB,
+	  .high = 40 * MB, .victim = true },
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
+		/* Freeze the top-level cgroup and enable the memory controller */
+		if (i == 0) {
+			err = write_cgroup_file(cgroups[i].path, "cgroup.freeze", "1");
+			if (!ASSERT_OK(err, "freeze cgroup"))
+				goto cleanup;
+
+			err = write_cgroup_file(cgroups[i].path, "cgroup.subtree_control",
+						"+memory");
+			if (!ASSERT_OK(err, "enable memory controller"))
+				goto cleanup;
+		}
+
+		/* Set memory.high */
+		if (cgroups[i].high) {
+			char buf[256];
+
+			snprintf(buf, sizeof(buf), "%lu", cgroups[i].high);
+			err = write_cgroup_file(cgroups[i].path, "memory.high", buf);
+			if (!ASSERT_OK(err, "set memory.high"))
+				goto cleanup;
+
+			snprintf(buf, sizeof(buf), "0");
+			write_cgroup_file(cgroups[i].path, "memory.swap.max", buf);
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
+	if (!ASSERT_OK(ret, "unfreeze cgroup"))
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
+			size = read_cgroup_file(cgroups[i].path, "memory.events",
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
+void test_psi(void)
+{
+	struct test_psi *skel;
+	u64 deleted_cgroup_id;
+	int new_cgroup_fd;
+	u64 new_cgroup_id;
+	int err;
+
+	setup_environment();
+
+	skel = test_psi__open_and_load();
+	err = libbpf_get_error(skel);
+	if (CHECK_FAIL(err))
+		goto cleanup;
+
+	skel->bss->deleted_cgroup_id = cgroups[1].id;
+	skel->bss->high_pressure_cgroup_id = cgroups[2].id;
+
+	err = test_psi__attach(skel);
+	if (CHECK_FAIL(err))
+		goto cleanup;
+
+	/* Delete the first cgroup, it should trigger handle_cgroup_offline() */
+	remove_cgroup(cgroups[1].path);
+
+	new_cgroup_fd = create_and_get_cgroup("/psi_test_new");
+	if (!ASSERT_GE(new_cgroup_fd, 0, "create_and_get_cgroup"))
+		goto cleanup;
+
+	new_cgroup_id = get_cgroup_id("/psi_test_new");
+	if (!ASSERT_GT(new_cgroup_id, 0, "get_cgroup_id"))
+		goto cleanup;
+
+	/* Unfreeze all child tasks and create the memory pressure */
+	err = run_and_wait_for_oom();
+	CHECK_FAIL(err);
+
+	/* Check the result of the handle_cgroup_offline() handler */
+	deleted_cgroup_id = skel->bss->deleted_cgroup_id;
+	ASSERT_EQ(deleted_cgroup_id, cgroups[1].id, "deleted cgroup id");
+
+	/* Check the result of the handle_cgroup_online() handler */
+	ASSERT_EQ(skel->bss->new_cgroup_id, new_cgroup_id,
+		  "new cgroup id");
+
+cleanup:
+	cleanup_cgroup_environment();
+	test_psi__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_psi.c b/tools/testing/selftests/bpf/progs/test_psi.c
new file mode 100644
index 000000000000..4ddec7ec3eda
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_psi.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define PSI_FULL 0x80000000
+
+/* cgroup which will experience the high memory pressure */
+u64 high_pressure_cgroup_id;
+
+/* cgroup which will be deleted */
+u64 deleted_cgroup_id;
+
+/* cgroup which will be created */
+u64 new_cgroup_id;
+
+/* cgroup which was deleted */
+u64 deleted_cgroup_id;
+
+char constraint_name[] = "CONSTRAINT_BPF_PSI_MEM";
+
+SEC("struct_ops.s/init")
+int BPF_PROG(psi_init, struct bpf_psi *bpf_psi)
+{
+	int ret;
+
+	ret = bpf_psi_create_trigger(bpf_psi, high_pressure_cgroup_id,
+				     PSI_MEM | PSI_FULL, 100000, 1000000);
+	if (ret)
+		return ret;
+
+	return bpf_psi_create_trigger(bpf_psi, deleted_cgroup_id,
+				      PSI_IO, 100000, 1000000);
+}
+
+SEC("struct_ops.s/handle_psi_event")
+void BPF_PROG(handle_psi_event, struct bpf_psi *bpf_psi, struct psi_trigger *t)
+{
+	u64 cgroup_id = t->cgroup_id;
+	struct mem_cgroup *memcg;
+	struct cgroup *cgroup;
+
+	cgroup = bpf_cgroup_from_id(cgroup_id);
+	if (!cgroup)
+		return;
+
+	memcg = bpf_get_mem_cgroup(&cgroup->self);
+	if (!memcg) {
+		bpf_cgroup_release(cgroup);
+		return;
+	}
+
+	bpf_out_of_memory(memcg, 0, BPF_OOM_FLAGS_WAIT_ON_OOM_LOCK,
+			  constraint_name);
+
+	bpf_put_mem_cgroup(memcg);
+	bpf_cgroup_release(cgroup);
+}
+
+SEC("struct_ops.s/handle_cgroup_online")
+void BPF_PROG(handle_cgroup_online, struct bpf_psi *bpf_psi, u64 cgroup_id)
+{
+	new_cgroup_id = cgroup_id;
+
+	bpf_psi_create_trigger(bpf_psi, cgroup_id, PSI_IO, 100000, 1000000);
+}
+
+SEC("struct_ops.s/handle_cgroup_offline")
+void BPF_PROG(handle_cgroup_offline, struct bpf_psi *bpf_psi, u64 cgroup_id)
+{
+	deleted_cgroup_id = cgroup_id;
+}
+
+SEC(".struct_ops.link")
+struct bpf_psi_ops test_bpf_psi = {
+	.init = (void *)psi_init,
+	.handle_psi_event = (void *)handle_psi_event,
+	.handle_cgroup_online = (void *)handle_cgroup_online,
+	.handle_cgroup_offline = (void *)handle_cgroup_offline,
+};
-- 
2.51.0


