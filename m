Return-Path: <cgroups+bounces-1003-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D672E81C92C
	for <lists+cgroups@lfdr.de>; Fri, 22 Dec 2023 12:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D4B1C221AE
	for <lists+cgroups@lfdr.de>; Fri, 22 Dec 2023 11:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3F01803D;
	Fri, 22 Dec 2023 11:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ob8HR5dg"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D533F18038;
	Fri, 22 Dec 2023 11:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5c6ce4dffb5so814778a12.0;
        Fri, 22 Dec 2023 03:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703244691; x=1703849491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKqCzSmN1ruuozxSQ8yJOD89LpMvdEQqcrQfqTfhOwk=;
        b=Ob8HR5dgK125WsXtFSMNEFP7pRpYgplQMEK/ODGWhpkpCkvuWHtlD4Ho1t5w3ANdlS
         7Ic/HPseMyD5hjuERl7FRYcBkuFahQfR8J+4GTizs5VII4IpRKS9Re+AGhEMyXNqd2S4
         yEYVJ9181e0VI3y4JvT0ENNvH6Fsfsv2M9eiBRUmKW+MNY7qL8jgvuQUptf+5sqTrZ8K
         21W9Pfm076cS1/FgVzhR41MbU8v+biZbtIh2pKOHWqdMZlcX7qSej3ODZDihnPiVaVLZ
         sRKQsqZxtntVWtTjL/oR3i8d/Ucau9eEP6d/0vSJfHrtRQCgp+OnoNA+m41KQiG4Qzb+
         Ob7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703244691; x=1703849491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKqCzSmN1ruuozxSQ8yJOD89LpMvdEQqcrQfqTfhOwk=;
        b=Kk35riXD3BmLAM5bMkRWBaqFFPN54J5eKsunpoKUOWB0icNk7ifg+Y1W6pJOzbHfBj
         Qd1nqc/IVptdy3vLZFBArDC4ITcN+5in7cu9MgPG5XiEMXXYDixGImNMYAjz2s7pehUF
         N9FvlzFGnYDpNOv7H2l99dpTjRSKatQVnDiT+0PyBik01SzpFCxkLrQ+pK2MhfM/rxpY
         g4hW+GAn3vKGYXvuIsZ6ZPXlTWnSTK9VSNFQVxduTAzgR475eHLVSdUAM2xczV9SviOj
         04g9Y6JaYenrpaJnUG+g/KNxTfbzidzIBQqazCVDnFteAyyCWcL1FoLxMq6mnH3qwHIl
         UNGg==
X-Gm-Message-State: AOJu0YxUCzlLw5vBRgFX9gN24awn/udf6iPeGo6DEiD02E/frXhp3wC8
	u7zkh4+fMV6hlZYzQubnNiE=
X-Google-Smtp-Source: AGHT+IG/8ugmzOWxBhiPUPPF4mQ+P9sRfN+q1Z6GsAamJNznpLiAibVKlVP20lCiH8FVjFDNSuHspA==
X-Received: by 2002:a05:6a21:1a9:b0:195:47e3:edff with SMTP id le41-20020a056a2101a900b0019547e3edffmr141268pzb.49.1703244690970;
        Fri, 22 Dec 2023 03:31:30 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id l2-20020a170903244200b001d0cd9e4248sm3232881pls.196.2023.12.22.03.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 03:31:30 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org
Cc: bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 4/4] selftests/bpf: Add selftests for cpumask iter
Date: Fri, 22 Dec 2023 11:31:02 +0000
Message-Id: <20231222113102.4148-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231222113102.4148-1-laoar.shao@gmail.com>
References: <20231222113102.4148-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Within the BPF program, we leverage the cgroup iterator to iterate through
percpu runqueue data, specifically the 'nr_running' metric. Subsequently
 we expose this data to userspace by means of a sequence file.

The CPU affinity for the cpumask is determined by the PID of a task:

- PID of the init task (PID 1)
  We typically don't set CPU affinity for init task and thus we can iterate
  across all possible CPUs. However, in scenarios where you've set CPU
  affinity for the init task, you should set the cpumask of your current
  task to full-F. Then proceed to iterate through all possible CPUs using
  the current task.
- PID of a task with defined CPU affinity
  The aim here is to iterate through a specific cpumask. This scenario
  aligns with tasks residing within a cpuset cgroup.
- Invalid PID (e.g., PID -1)
  No cpumask is available in this case.

The result as follows,
  #62/1    cpumask_iter/init_pid:OK
  #62/2    cpumask_iter/invalid_pid:OK
  #62/3    cpumask_iter/self_pid_one_cpu:OK
  #62/4    cpumask_iter/self_pid_multi_cpus:OK
  #62      cpumask_iter:OK
  Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/cpumask_iter.c        | 132 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/cpumask_common.h |   4 +
 .../selftests/bpf/progs/test_cpumask_iter.c        |  50 ++++++++
 3 files changed, 186 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cpumask_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_cpumask_iter.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask_iter.c b/tools/testing/selftests/bpf/prog_tests/cpumask_iter.c
new file mode 100644
index 0000000..40556cf
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cpumask_iter.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Yafang Shao <laoar.shao@gmail.com> */
+
+#define _GNU_SOURCE
+#include <sched.h>
+#include <stdio.h>
+#include <unistd.h>
+
+#include <test_progs.h>
+#include "cgroup_helpers.h"
+#include "test_cpumask_iter.skel.h"
+
+static void verify_percpu_data(struct bpf_link *link, int nr_cpu_exp, int nr_running_exp)
+{
+	int iter_fd, len, item, nr_running, nr_cpus;
+	static char buf[128];
+	size_t left;
+	char *p;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_GE(iter_fd, 0, "iter_fd"))
+		return;
+
+	memset(buf, 0, sizeof(buf));
+	left = ARRAY_SIZE(buf);
+	p = buf;
+	while ((len = read(iter_fd, p, left)) > 0) {
+		p += len;
+		left -= len;
+	}
+
+	item = sscanf(buf, "nr_running %u nr_cpus %u\n", &nr_running, &nr_cpus);
+	if (nr_cpu_exp == -1) {
+		ASSERT_EQ(item, -1, "seq_format");
+		goto out;
+	}
+
+	ASSERT_EQ(item, 2, "seq_format");
+	ASSERT_GE(nr_running, nr_running_exp, "nr_running");
+	ASSERT_EQ(nr_cpus, nr_cpu_exp, "nr_cpus");
+
+	/* read() after iter finishes should be ok. */
+	if (len == 0)
+		ASSERT_OK(read(iter_fd, buf, sizeof(buf)), "second_read");
+
+out:
+	close(iter_fd);
+}
+
+void test_cpumask_iter(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	int nr_possible, cgrp_fd, pid, err, cnt, i;
+	struct test_cpumask_iter *skel = NULL;
+	union bpf_iter_link_info linfo;
+	int cpu_ids[] = {1, 3, 4, 5};
+	struct bpf_link *link;
+	cpu_set_t set;
+
+	skel = test_cpumask_iter__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_for_each_cpu__open_and_load"))
+		return;
+
+	if (setup_cgroup_environment())
+		goto destroy;
+
+	/* Utilize the cgroup iter */
+	cgrp_fd = get_root_cgroup();
+	if (!ASSERT_GE(cgrp_fd, 0, "create cgrp"))
+		goto cleanup;
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.cgroup.cgroup_fd = cgrp_fd;
+	linfo.cgroup.order = BPF_CGROUP_ITER_SELF_ONLY;
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+
+	link = bpf_program__attach_iter(skel->progs.cpu_cgroup, &opts);
+	if (!ASSERT_OK_PTR(link, "attach_iter"))
+		goto close_fd;
+
+	skel->bss->target_pid = 1;
+	/* In case init task is set CPU affinity */
+	err = sched_getaffinity(1, sizeof(set), &set);
+	if (!ASSERT_OK(err, "setaffinity"))
+		goto close_fd;
+
+	cnt = CPU_COUNT(&set);
+	nr_possible = bpf_num_possible_cpus();
+	if (test__start_subtest("init_pid"))
+		/* curent task is running. */
+		verify_percpu_data(link, cnt, cnt == nr_possible ? 1 : 0);
+
+	skel->bss->target_pid = -1;
+	if (test__start_subtest("invalid_pid"))
+		verify_percpu_data(link, -1, -1);
+
+	pid = getpid();
+	skel->bss->target_pid = pid;
+	CPU_ZERO(&set);
+	CPU_SET(0, &set);
+	err = sched_setaffinity(pid, sizeof(set), &set);
+	if (!ASSERT_OK(err, "setaffinity"))
+		goto free_link;
+
+	if (test__start_subtest("self_pid_one_cpu"))
+		verify_percpu_data(link, 1, 1);
+
+	/* Assume there are at least 8 CPUs on the testbed */
+	if (nr_possible < 8)
+		goto free_link;
+
+	CPU_ZERO(&set);
+	/* Set the CPU affinitiy: 1,3-5 */
+	for (i = 0; i < ARRAY_SIZE(cpu_ids); i++)
+		CPU_SET(cpu_ids[i], &set);
+	err = sched_setaffinity(pid, sizeof(set), &set);
+	if (!ASSERT_OK(err, "setaffinity"))
+		goto free_link;
+
+	if (test__start_subtest("self_pid_multi_cpus"))
+		verify_percpu_data(link, ARRAY_SIZE(cpu_ids), 1);
+
+free_link:
+	bpf_link__destroy(link);
+close_fd:
+	close(cgrp_fd);
+cleanup:
+	cleanup_cgroup_environment();
+destroy:
+	test_cpumask_iter__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/cpumask_common.h b/tools/testing/selftests/bpf/progs/cpumask_common.h
index 0cd4aeb..5ebb136 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_common.h
+++ b/tools/testing/selftests/bpf/progs/cpumask_common.h
@@ -55,6 +55,10 @@ void bpf_cpumask_xor(struct bpf_cpumask *cpumask,
 u32 bpf_cpumask_any_distribute(const struct cpumask *src) __ksym;
 u32 bpf_cpumask_any_and_distribute(const struct cpumask *src1, const struct cpumask *src2) __ksym;
 u32 bpf_cpumask_weight(const struct cpumask *cpumask) __ksym;
+u32 bpf_iter_cpumask_new(struct bpf_iter_cpumask *it, struct cpumask *mask) __ksym;
+u32 *bpf_iter_cpumask_next(struct bpf_iter_cpumask *it) __ksym;
+void bpf_iter_cpumask_destroy(struct bpf_iter_cpumask *it) __ksym;
+bool bpf_cpumask_set_from_pid(struct cpumask *cpumask, u32 pid) __ksym;
 
 void bpf_rcu_read_lock(void) __ksym;
 void bpf_rcu_read_unlock(void) __ksym;
diff --git a/tools/testing/selftests/bpf/progs/test_cpumask_iter.c b/tools/testing/selftests/bpf/progs/test_cpumask_iter.c
new file mode 100644
index 0000000..d0cdb92
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_cpumask_iter.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2023 Yafang Shao <laoar.shao@gmail.com> */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "cpumask_common.h"
+
+extern const struct rq runqueues __ksym __weak;
+
+int target_pid;
+
+SEC("iter/cgroup")
+int BPF_PROG(cpu_cgroup, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	u32 *cpu, nr_running = 0, nr_cpus = 0;
+	struct bpf_cpumask *mask;
+	struct rq *rq;
+	int ret;
+
+	/* epilogue */
+	if (cgrp == NULL)
+		return 0;
+
+	mask = bpf_cpumask_create();
+	if (!mask)
+		return 1;
+
+	ret = bpf_cpumask_set_from_pid(&mask->cpumask, target_pid);
+	if (ret == false) {
+		bpf_cpumask_release(mask);
+		return 1;
+	}
+
+	bpf_for_each(cpumask, cpu, &mask->cpumask) {
+		rq = (struct rq *)bpf_per_cpu_ptr(&runqueues, *cpu);
+		if (!rq)
+			continue;
+
+		nr_running += rq->nr_running;
+		nr_cpus += 1;
+	}
+	BPF_SEQ_PRINTF(meta->seq, "nr_running %u nr_cpus %u\n", nr_running, nr_cpus);
+
+	bpf_cpumask_release(mask);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
1.8.3.1


