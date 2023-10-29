Return-Path: <cgroups+bounces-114-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 235697DAB24
	for <lists+cgroups@lfdr.de>; Sun, 29 Oct 2023 07:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C821F21B9B
	for <lists+cgroups@lfdr.de>; Sun, 29 Oct 2023 06:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1ED63A7;
	Sun, 29 Oct 2023 06:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bx/2qO8f"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252328F78;
	Sun, 29 Oct 2023 06:15:07 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6CED9;
	Sat, 28 Oct 2023 23:15:05 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b2e44c7941so2432874b6e.2;
        Sat, 28 Oct 2023 23:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698560105; x=1699164905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+y5IvZGTJVNsINeBbqs6/CPtfFJoedZnxRZu6VJyjA=;
        b=Bx/2qO8f0EcsZOk2rNn4bT+ZOjtODoYRAUdn12LwOjZRDiGJ4Y23FQaXqWZlQAkxnt
         WdIueM1Nk5VWo61/nkkwlnkqUPn9l0mSo5tz7ggZB1fBhJWc79RZZahNw8T5qVL+obEF
         RPGf0QOhkZXwWOlJxgzO48AUaGZxLVS/OdgcKZp5ZEq42MAFa6zZR26pAb2+Mn2vYIUW
         MGGMTmMUm4kRGIiEGgKAd8q1fuXzF061S95bjmuar7NXa1csKO+dEDyeWv8tl2BHxYrE
         /UEyThaKyQLcw2QEzrvo/je+jCQPjWuQhv9aXC+IPOD2ow6Ydc6409dv/bHJ6/FClww1
         vMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698560105; x=1699164905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+y5IvZGTJVNsINeBbqs6/CPtfFJoedZnxRZu6VJyjA=;
        b=h5xz4AGfepHLM6+a5k1w2oMsk9CycyEY3pFjpPxPGM0KZVgVqj2PzxNIpSGX/qn+nQ
         kbuoILFfjMhkkIsJ8zK0njHOhdME+Cmaz38omoEzXAZ6M2YwWZgWIFP/K3IpEimGLujA
         yyToh+SknBdgtE5a0GG7iqbpUk9xUCrNRJ7Epj7aEE3MeYNYHO7Aq99+/wjX25r3aEbc
         T8AhakwK3FnAy2mzHmgM/RIlGMwpeqZHdzxFN2xBNUPDzBakbzMvO/z3R7wrAq95R/gG
         iUeY8zQXN6O6xgu/HCFszP02ZtSZcifD0i/WXfrjx1Oeel9I6HGoAMj7m+BMuTE2JV3i
         a1sw==
X-Gm-Message-State: AOJu0Yx77CuWhD7H7t8I6yuLN/jiShFiPLxVZRJf2/uKHrFDx3KZm+vx
	Rn9lyxUDFlX9L70ZLvNNAJ8=
X-Google-Smtp-Source: AGHT+IEL/zFegIBdXR5fcscjYR4WrvXL+mrGreh3egZnEoN+g71G0TvRDGrDqJL6UgaUuHlcWdwLFw==
X-Received: by 2002:a05:6808:13d6:b0:3b2:ef9a:4339 with SMTP id d22-20020a05680813d600b003b2ef9a4339mr8876787oiw.49.1698560104727;
        Sat, 28 Oct 2023 23:15:04 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:2b5:5400:4ff:fea0:d066])
        by smtp.gmail.com with ESMTPSA id m2-20020aa79002000000b006b225011ee5sm3775106pfo.6.2023.10.28.23.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 23:15:04 -0700 (PDT)
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
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	mkoutny@suse.com,
	sinquersw@gmail.com,
	longman@redhat.com
Cc: cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	oliver.sang@intel.com,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 bpf-next 11/11] selftests/bpf: Add selftests for cgroup1 hierarchy
Date: Sun, 29 Oct 2023 06:14:38 +0000
Message-Id: <20231029061438.4215-12-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231029061438.4215-1-laoar.shao@gmail.com>
References: <20231029061438.4215-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests for cgroup1 hierarchy.
The result as follows,

  $ tools/testing/selftests/bpf/test_progs --name=cgroup1_hierarchy
  #36/1    cgroup1_hierarchy/test_cgroup1_hierarchy:OK
  #36/2    cgroup1_hierarchy/test_root_cgid:OK
  #36/3    cgroup1_hierarchy/test_invalid_level:OK
  #36/4    cgroup1_hierarchy/test_invalid_cgid:OK
  #36/5    cgroup1_hierarchy/test_invalid_hid:OK
  #36/6    cgroup1_hierarchy/test_invalid_cgrp_name:OK
  #36/7    cgroup1_hierarchy/test_invalid_cgrp_name2:OK
  #36/8    cgroup1_hierarchy/test_sleepable_prog:OK
  #36      cgroup1_hierarchy:OK
  Summary: 1/8 PASSED, 0 SKIPPED, 0 FAILED

Besides, I also did some stress test similar to the patch #2 in this
series, as follows (with CONFIG_PROVE_RCU_LIST enabled):

- Continuously mounting and unmounting named cgroups in some tasks,
  for example:

  cgrp_name=$1
  while true
  do
      mount -t cgroup -o none,name=$cgrp_name none /$cgrp_name
      umount /$cgrp_name
  done

- Continuously run this selftest concurrently,
  while true; do ./test_progs --name=cgroup1_hierarchy; done

They can ran successfully without any RCU warnings in dmesg.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/cgroup1_hierarchy.c   | 159 +++++++++++++++++++++
 .../selftests/bpf/progs/test_cgroup1_hierarchy.c   |  72 ++++++++++
 2 files changed, 231 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c b/tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c
new file mode 100644
index 0000000..4aafbc9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */
+
+#include <sys/types.h>
+#include <unistd.h>
+#include <test_progs.h>
+#include "cgroup_helpers.h"
+#include "test_cgroup1_hierarchy.skel.h"
+
+static void bpf_cgroup1(struct test_cgroup1_hierarchy *skel)
+{
+	int err;
+
+	/* Attach LSM prog first */
+	skel->links.lsm_run = bpf_program__attach_lsm(skel->progs.lsm_run);
+	if (!ASSERT_OK_PTR(skel->links.lsm_run, "lsm_attach"))
+		return;
+
+	/* LSM prog will be triggered when attaching fentry */
+	skel->links.fentry_run = bpf_program__attach_trace(skel->progs.fentry_run);
+	ASSERT_NULL(skel->links.fentry_run, "fentry_attach_fail");
+
+	err = bpf_link__destroy(skel->links.lsm_run);
+	ASSERT_OK(err, "destroy_lsm");
+	skel->links.lsm_run = NULL;
+}
+
+static void bpf_cgroup1_sleepable(struct test_cgroup1_hierarchy *skel)
+{
+	int err;
+
+	/* Attach LSM prog first */
+	skel->links.lsm_s_run = bpf_program__attach_lsm(skel->progs.lsm_s_run);
+	if (!ASSERT_OK_PTR(skel->links.lsm_s_run, "lsm_attach"))
+		return;
+
+	/* LSM prog will be triggered when attaching fentry */
+	skel->links.fentry_run = bpf_program__attach_trace(skel->progs.fentry_run);
+	ASSERT_NULL(skel->links.fentry_run, "fentry_attach_fail");
+
+	err = bpf_link__destroy(skel->links.lsm_s_run);
+	ASSERT_OK(err, "destroy_lsm");
+	skel->links.lsm_s_run = NULL;
+}
+
+static void bpf_cgroup1_invalid_id(struct test_cgroup1_hierarchy *skel)
+{
+	int err;
+
+	/* Attach LSM prog first */
+	skel->links.lsm_run = bpf_program__attach_lsm(skel->progs.lsm_run);
+	if (!ASSERT_OK_PTR(skel->links.lsm_run, "lsm_attach"))
+		return;
+
+	/* LSM prog will be triggered when attaching fentry */
+	skel->links.fentry_run = bpf_program__attach_trace(skel->progs.fentry_run);
+	if (!ASSERT_OK_PTR(skel->links.fentry_run, "fentry_attach_success"))
+		goto cleanup;
+
+	err = bpf_link__destroy(skel->links.lsm_run);
+	ASSERT_OK(err, "destroy_lsm");
+	skel->links.lsm_run = NULL;
+
+cleanup:
+	err = bpf_link__destroy(skel->links.fentry_run);
+	ASSERT_OK(err, "destroy_fentry");
+	skel->links.fentry_run = NULL;
+}
+
+void test_cgroup1_hierarchy(void)
+{
+	struct test_cgroup1_hierarchy *skel;
+	__u64 current_cgid;
+	int hid, err;
+
+	skel = test_cgroup1_hierarchy__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	skel->bss->target_pid = getpid();
+
+	err = bpf_program__set_attach_target(skel->progs.fentry_run, 0, "bpf_fentry_test1");
+	if (!ASSERT_OK(err, "fentry_set_target"))
+		goto destroy;
+
+	err = test_cgroup1_hierarchy__load(skel);
+	if (!ASSERT_OK(err, "load"))
+		goto destroy;
+
+	/* Setup cgroup1 hierarchy */
+	err = setup_classid_environment();
+	if (!ASSERT_OK(err, "setup_classid_environment"))
+		goto destroy;
+
+	err = join_classid();
+	if (!ASSERT_OK(err, "join_cgroup1"))
+		goto cleanup;
+
+	current_cgid = get_classid_cgroup_id();
+	if (!ASSERT_GE(current_cgid, 0, "cgroup1 id"))
+		goto cleanup;
+
+	hid = get_cgroup1_hierarchy_id("net_cls");
+	if (!ASSERT_GE(hid, 0, "cgroup1 id"))
+		goto cleanup;
+	skel->bss->target_hid = hid;
+
+	if (test__start_subtest("test_cgroup1_hierarchy")) {
+		skel->bss->target_ancestor_cgid = current_cgid;
+		bpf_cgroup1(skel);
+	}
+
+	if (test__start_subtest("test_root_cgid")) {
+		skel->bss->target_ancestor_cgid = 1;
+		skel->bss->target_ancestor_level = 0;
+		bpf_cgroup1(skel);
+	}
+
+	if (test__start_subtest("test_invalid_level")) {
+		skel->bss->target_ancestor_cgid = 1;
+		skel->bss->target_ancestor_level = 1;
+		bpf_cgroup1_invalid_id(skel);
+	}
+
+	if (test__start_subtest("test_invalid_cgid")) {
+		skel->bss->target_ancestor_cgid = 0;
+		bpf_cgroup1_invalid_id(skel);
+	}
+
+	if (test__start_subtest("test_invalid_hid")) {
+		skel->bss->target_ancestor_cgid = 1;
+		skel->bss->target_ancestor_level = 0;
+		skel->bss->target_hid = -1;
+		bpf_cgroup1_invalid_id(skel);
+	}
+
+	if (test__start_subtest("test_invalid_cgrp_name")) {
+		skel->bss->target_hid = get_cgroup1_hierarchy_id("net_cl");
+		skel->bss->target_ancestor_cgid = current_cgid;
+		bpf_cgroup1_invalid_id(skel);
+	}
+
+	if (test__start_subtest("test_invalid_cgrp_name2")) {
+		skel->bss->target_hid = get_cgroup1_hierarchy_id("net_cls,");
+		skel->bss->target_ancestor_cgid = current_cgid;
+		bpf_cgroup1_invalid_id(skel);
+	}
+
+	if (test__start_subtest("test_sleepable_prog")) {
+		skel->bss->target_hid = hid;
+		skel->bss->target_ancestor_cgid = current_cgid;
+		bpf_cgroup1_sleepable(skel);
+	}
+
+cleanup:
+	cleanup_classid_environment();
+destroy:
+	test_cgroup1_hierarchy__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c b/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c
new file mode 100644
index 0000000..979ff4e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+//#endif
+/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+__u32 target_ancestor_level;
+__u64 target_ancestor_cgid;
+int target_pid, target_hid;
+
+struct cgroup *bpf_task_get_cgroup1(struct task_struct *task, int hierarchy_id) __ksym;
+struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level) __ksym;
+void bpf_cgroup_release(struct cgroup *cgrp) __ksym;
+
+static int bpf_link_create_verify(int cmd)
+{
+	struct cgroup *cgrp, *ancestor;
+	struct task_struct *task;
+	int ret = 0;
+
+	if (cmd != BPF_LINK_CREATE)
+		return 0;
+
+	task = bpf_get_current_task_btf();
+
+	/* Then it can run in parallel with others */
+	if (task->pid != target_pid)
+		return 0;
+
+	cgrp = bpf_task_get_cgroup1(task, target_hid);
+	if (!cgrp)
+		return 0;
+
+	/* Refuse it if its cgid or its ancestor's cgid is the target cgid */
+	if (cgrp->kn->id == target_ancestor_cgid)
+		ret = -1;
+
+	ancestor = bpf_cgroup_ancestor(cgrp, target_ancestor_level);
+	if (!ancestor)
+		goto out;
+
+	if (ancestor->kn->id == target_ancestor_cgid)
+		ret = -1;
+	bpf_cgroup_release(ancestor);
+
+out:
+	bpf_cgroup_release(cgrp);
+	return ret;
+}
+
+SEC("lsm/bpf")
+int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size)
+{
+	return bpf_link_create_verify(cmd);
+}
+
+SEC("lsm.s/bpf")
+int BPF_PROG(lsm_s_run, int cmd, union bpf_attr *attr, unsigned int size)
+{
+	return bpf_link_create_verify(cmd);
+}
+
+SEC("fentry")
+int BPF_PROG(fentry_run)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
1.8.3.1


