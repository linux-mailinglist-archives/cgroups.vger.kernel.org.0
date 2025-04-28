Return-Path: <cgroups+bounces-7862-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6098A9E6BE
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 05:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8210E3B59E6
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 03:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0018C20E021;
	Mon, 28 Apr 2025 03:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WoHk90vS"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9CE18DF6E
	for <cgroups@vger.kernel.org>; Mon, 28 Apr 2025 03:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745811432; cv=none; b=qhKq141INuABAmPcMHJNsAAJeppht+bjbMflZ/h0Zh2ZV6Sv+MJDEgee8B9Xp8bYhTCHAmQouZDDV0GU3UwJAuEnKQnHqgVum0MT1yP5iwE6kcePp2wXNZdWLzjBD3L5LC3wf2yQEJRRcsRc8JfVvMFNCFkSn3gv5W7WC+LahSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745811432; c=relaxed/simple;
	bh=9m6dGm3hgSNWG+2WOSHP2KyLWYLAjePv7Lo4oUqmktU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCfq4MrijBMkJ51Rv55s1k8vSyYKYToSpetBKicwIFuvNEmvug3AyifHYrUnEMC3RcR0mQIz9t7mkVJVqboTJtStaw/lJRfyZMlaJyuVflEPYRi5amtOV802o9NV4S8iTnUCs6h16KYfklwH9MdMzJPU1OFDH1uYQkdzK2E6nSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WoHk90vS; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745811429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PMD4alSuF/CQrdJat1BcZoxvyxgjdLtWthYldLJYf1E=;
	b=WoHk90vSsCT6HqUIwr7zPvav48u2HbF9Fj+LO5seyFrEcCAO/yMDiQn7IpkGImXxA5Cx3W
	jN5br5GN6WKkrp+RIO/MIO4P0oJHADYQOhd7umOi69q0P/NDHaILQKKI3xxLRvkpkvHRIX
	Rab1/AQR2q1H72iYJeg+PrWNcLnEGGE=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	David Rientjes <rientjes@google.com>,
	Josh Don <joshdon@google.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH rfc 12/12] bpf: selftests: psi handler test
Date: Mon, 28 Apr 2025 03:36:17 +0000
Message-ID: <20250428033617.3797686-13-roman.gushchin@linux.dev>
In-Reply-To: <20250428033617.3797686-1-roman.gushchin@linux.dev>
References: <20250428033617.3797686-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a psi handler test. The test creates a cgroup with two child
sub-cgroups, sets up memory.high for one of those and puts
memory hungry processes in each of them.

Then it sets up a psi trigger for one of cgroups and waits
till the process in this cgroup will be killed by the OOM killer.
To make sure there was indeed an OOM event, it checks the
corresponding memcg statistics.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/psi.c | 234 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_psi.c |  43 ++++
 2 files changed, 277 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/psi.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_psi.c

diff --git a/tools/testing/selftests/bpf/prog_tests/psi.c b/tools/testing/selftests/bpf/prog_tests/psi.c
new file mode 100644
index 000000000000..99d68bc20eee
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/psi.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <sys/stat.h>
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include <bpf/bpf.h>
+#include <errno.h>
+#include <string.h>
+
+#include "cgroup_helpers.h"
+#include "test_psi.skel.h"
+
+struct cgroup_desc {
+	const char *path;
+	int fd;
+	unsigned long long id;
+	int pid;
+	size_t target;
+	size_t high;
+	bool victim;
+	bool psi;
+};
+
+#define MB (1024 * 1024)
+
+static struct cgroup_desc cgroups[] = {
+	{ .path = "/oom_test" },
+	{ .path = "/oom_test/cg1", .target = 100 * MB },
+	{ .path = "/oom_test/cg2", .target = 500 * MB,
+	  .high = 40 * MB, .psi = true, .victim = true },
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
+static int setup_psi_alert(struct cgroup_desc *desc)
+{
+	const char *trig = "some 100000 1000000";
+	int fd;
+
+	fd = open_cgroup_file(desc->path, "memory.pressure", O_RDWR);
+	if (fd < 0) {
+		printf("memory.pressure open error: %s\n", strerror(errno));
+		return 1;
+	}
+
+	if (write(fd, trig, strlen(trig) + 1) < 0) {
+		printf("memory.pressure write error: %s\n", strerror(errno));
+		return 1;
+	}
+
+	/* keep fd open, otherwise the psi trigger will be deleted */
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
+		if (i == 0) {
+			/* Freeze the top-level cgroup */
+			err = write_cgroup_file(cgroups[i].path, "cgroup.freeze", "1");
+			if (!ASSERT_OK(err, "freeze cgroup"))
+				goto cleanup;
+		}
+
+		if (!cgroups[i].target) {
+			/* Recursively enable the memory controller */
+			err = write_cgroup_file(cgroups[i].path, "cgroup.subtree_control",
+						"+memory");
+			if (!ASSERT_OK(err, "enable memory controller"))
+				goto cleanup;
+		}
+
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
+
+		if (cgroups[i].psi) {
+			err = setup_psi_alert(&cgroups[i]);
+			if (!ASSERT_OK(err, "create psi trigger"))
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
+	int err;
+
+	skel = test_psi__open_and_load();
+	err = test_psi__attach(skel);
+	if (!ASSERT_OK(err, "test_psi__attach"))
+		goto cleanup;
+
+	setup_environment();
+
+	run_and_wait_for_oom();
+
+	cleanup_cgroup_environment();
+cleanup:
+	test_psi__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_psi.c b/tools/testing/selftests/bpf/progs/test_psi.c
new file mode 100644
index 000000000000..8cbc1e0a5b24
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_psi.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct mem_cgroup *bpf_get_mem_cgroup(struct cgroup_subsys_state *css) __ksym;
+void bpf_put_mem_cgroup(struct mem_cgroup *memcg) __ksym;
+int bpf_out_of_memory(struct mem_cgroup *memcg, int order) __ksym;
+
+SEC("fmod_ret.s/bpf_handle_psi_event")
+int BPF_PROG(test_psi_event, struct psi_trigger *t)
+{
+	struct cgroup *cgroup = NULL;
+	struct mem_cgroup *memcg;
+	u64 cgroup_id;
+
+	if (!t->of || !t->of->kn) {
+		bpf_out_of_memory(NULL, 0);
+		return 1;
+	}
+
+	cgroup_id = t->of->kn->__parent->id;
+	cgroup = bpf_cgroup_from_id(cgroup_id);
+	if (!cgroup)
+		return 0;
+
+	memcg = bpf_get_mem_cgroup(&cgroup->self);
+	if (!memcg) {
+		bpf_cgroup_release(cgroup);
+		return 0;
+	}
+
+	bpf_out_of_memory(memcg, 0);
+
+	bpf_put_mem_cgroup(memcg);
+	bpf_cgroup_release(cgroup);
+
+	return 1;
+}
-- 
2.49.0.901.g37484f566f-goog


