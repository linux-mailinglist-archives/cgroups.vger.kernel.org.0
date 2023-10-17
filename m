Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82227CC396
	for <lists+cgroups@lfdr.de>; Tue, 17 Oct 2023 14:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbjJQMqX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Oct 2023 08:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbjJQMqW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Oct 2023 08:46:22 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FD7101;
        Tue, 17 Oct 2023 05:46:20 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6ba172c5f3dso2334179b3a.0;
        Tue, 17 Oct 2023 05:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697546780; x=1698151580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QANBxWeQVGeTYEVVyQ3g6025jiJVAg51gX0cGDQdMMc=;
        b=Eqcrwe5NJVxKN/ZOsj7S+xihSHvlplloqDS+CqoM7MXEI8zE1NfaFqYHVPH2ZP5fl3
         DaB8WUAA/R3kj7L69inbXbTSVVlArKtfhpZqOAxMuauyvr/+PQIb3Ce8+GwCvup61EDN
         08LQbWfocPmPdYUmCWHuik+0CVQeLHiTPY7Q/yqHDlW0/j3fjkr50n8WV9+gbHdI/Z+S
         2a99N89w8mbe0G/mL8va2cApOPoa8yIeummFpxpmK+trq/poH6SBTWK6+XTFVORIruOb
         hQ5DZivXuQqRoQqqqgPKy8DZ3+JhkfrmKLURZCeFADR78wGPANDmUcqtaXdc9u0YcS1D
         cZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697546780; x=1698151580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QANBxWeQVGeTYEVVyQ3g6025jiJVAg51gX0cGDQdMMc=;
        b=GvB6NZBZaTujD6wzM8Vimq32bZDzxh68Jm1LUf3RrgtifPR+K0iuZmjkCEQwJ1PXQd
         XVsKho+v+yG6GbmsuAmLr7YMNrb2H3vgEzrRfvmzoDnJDzS5yj6SixKTVscZUrN36utr
         7i7gCF5sGR0UN3dqShTgGhxpK3X43MmPboDwUsnoHAZ0mKpO46vkUh0U5sJSsMsB/mfO
         j7yLVKncZp6l43ff8QhGELM/Z2xo+d/NQPPVpvD7/m5+rmgVK/UPaT0YAEWPz9jzEKAm
         Lq0pLrGLrrZ8UnHkn1b/+n/wQNq4z5DsLGqZBXcHy0GGD0RZkh6ZxtgmrCFZ+pQG+LSn
         50Dg==
X-Gm-Message-State: AOJu0YwSegtovl2qNmVbGrT3C2EWMLNVIyWHUp3QquqhYascMMyPinhE
        vsLMuoYEYpNS3njxnhq73Cs=
X-Google-Smtp-Source: AGHT+IH05Xt47ES7HySXrSPD3SfQdP60JDoCnLCG+2y4ZVGWH8cEabJCBeT56dOIL1Aubj5rIHek5A==
X-Received: by 2002:a05:6a00:1494:b0:68e:41e9:10be with SMTP id v20-20020a056a00149400b0068e41e910bemr2331055pfu.20.1697546779721;
        Tue, 17 Oct 2023 05:46:19 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:3b2:5400:4ff:fe9b:d21b])
        by smtp.gmail.com with ESMTPSA id fa36-20020a056a002d2400b006bdf4dfbe0dsm1375595pfb.12.2023.10.17.05.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:46:19 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        mkoutny@suse.com, sinquersw@gmail.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next v2 9/9] selftests/bpf: Add selftests for cgroup1 hierarchy
Date:   Tue, 17 Oct 2023 12:45:46 +0000
Message-Id: <20231017124546.24608-10-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231017124546.24608-1-laoar.shao@gmail.com>
References: <20231017124546.24608-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

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

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../bpf/prog_tests/cgroup1_hierarchy.c        | 159 ++++++++++++++++++
 .../bpf/progs/test_cgroup1_hierarchy.c        |  73 ++++++++
 2 files changed, 232 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c b/tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c
new file mode 100644
index 000000000000..4aafbc921254
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
index 000000000000..ca9a631a6499
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c
@@ -0,0 +1,73 @@
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
+struct cgroup *
+bpf_task_get_cgroup1_within_hierarchy(struct task_struct *task, int hierarchy_id) __ksym;
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
+	cgrp = bpf_task_get_cgroup1_within_hierarchy(task, target_hid);
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
2.30.1 (Apple Git-130)

