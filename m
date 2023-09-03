Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716E9790C71
	for <lists+cgroups@lfdr.de>; Sun,  3 Sep 2023 16:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238073AbjICO2T (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 3 Sep 2023 10:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238634AbjICO2T (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 3 Sep 2023 10:28:19 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA11697;
        Sun,  3 Sep 2023 07:28:15 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68c3b9f85b7so206487b3a.2;
        Sun, 03 Sep 2023 07:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693751295; x=1694356095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXV1VH0aENFBhlgyeq6hQvsVgH339T3EWStJqjKjW+o=;
        b=iry41PyrpkV7Ny57Cr/afcfK2/SS8eUHsGTbKNY/Em4PSPLQkoufrHTR8RHtHkMNyK
         GIWr3j1nnjSquvklGMlkBdZv9BjuUiglmYUAlB8imGpwus5VZZMky1QclI5sMcPtfOON
         r0BldredxqtXiKss1b1oKadfQP22tGo/+lfNVuJJI+ZEW3Kmr+/B2qCSwe31X45fLRM/
         R4H6rNwkASw7AluoQZiiNMxoxqaYysU5hwrww9WuUm3HRaxq/SqMujV4y7/22F9NZkYy
         iZJ0iLUcj1HV6VIhR+NzB8SaiB07fJGie3z3Naj9eeGIahFWcyt6tQFPVn8rUqXGmQTu
         /LMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693751295; x=1694356095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXV1VH0aENFBhlgyeq6hQvsVgH339T3EWStJqjKjW+o=;
        b=TzlknI79jo77jsDa0FC4L1qDRE/VeWpILVigMl5xuF2G1MQXwDqDpZbyzC/GJEDYWn
         XJBanESnK2MoM3ChRoXqAB1d7SxcGUa0I73jP6LLCQhNZDSQ4WXs82WNz7YB33Z1qTv7
         2VSiqwnOYyMDk3/aVmiYTh0H8v7+QbfqoZ7ObIwsNT8+3DLZbjY/FLRxocV3LHVnzCfn
         2P/AXwALAguil1iAx4NPZbsTMOqkUOeGgdJNFTNSocdjlw5PXd8n5DA9vwNBfmLs4CV1
         ArIR1kilBLXHXkN4Sv7ijGefXQVQMxj4IeM8sR06xhAO/+haP+spP7KJjkSbNxOF2T/V
         1Rxg==
X-Gm-Message-State: AOJu0YwayB2pZfQt9OvZ3cQqdDGREaVuyRGkch31EadI6WKmKJll59Di
        lWbMUpvUI16GOmR4XpuwMV4=
X-Google-Smtp-Source: AGHT+IFdvq/JFf626BfUvtNVCJRF9B3u4aRY6TYZl2FFVejJvFTTxCfr34+oEMSX0gsBmAmrtMW9Ng==
X-Received: by 2002:a05:6a00:1893:b0:68c:42:d3dd with SMTP id x19-20020a056a00189300b0068c0042d3ddmr8198912pfh.27.1693751295248;
        Sun, 03 Sep 2023 07:28:15 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:185:5400:4ff:fe8f:9150])
        by smtp.gmail.com with ESMTPSA id b23-20020aa78117000000b0065a1b05193asm5809977pfi.185.2023.09.03.07.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 07:28:14 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 5/5] selftests/bpf: Add selftests for current_under_cgroupv1v2
Date:   Sun,  3 Sep 2023 14:28:00 +0000
Message-Id: <20230903142800.3870-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230903142800.3870-1-laoar.shao@gmail.com>
References: <20230903142800.3870-1-laoar.shao@gmail.com>
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

Add selftests for bpf_current_task_under_cgroup() on both cgroup1 and
cgroup2. The result as follows,

  $ tools/testing/selftests/bpf/test_progs --name=current_under_cgroupv1v2
  #62/1    current_under_cgroupv1v2/test_current_under_cgroup2:OK
  #62/2    current_under_cgroupv1v2/test_current_under_cgroup1:OK
  #62      current_under_cgroupv1v2:OK
  Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../bpf/prog_tests/current_under_cgroupv1v2.c      | 76 ++++++++++++++++++++++
 .../bpf/progs/test_current_under_cgroupv1v2.c      | 31 +++++++++
 2 files changed, 107 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/current_under_cgroupv1v2.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_current_under_cgroupv1v2.c

diff --git a/tools/testing/selftests/bpf/prog_tests/current_under_cgroupv1v2.c b/tools/testing/selftests/bpf/prog_tests/current_under_cgroupv1v2.c
new file mode 100644
index 0000000..62efca3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/current_under_cgroupv1v2.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "cgroup_helpers.h"
+#include "test_current_under_cgroupv1v2.skel.h"
+
+#define CGROUP2_DIR "/current_under_cgroup2"
+
+static void attach_progs(int cgrp_fd)
+{
+	struct test_current_under_cgroupv1v2 *skel;
+	int cgrp_map_fd, ret, idx = 0;
+
+	skel = test_current_under_cgroupv1v2__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_current_under_cgroupv1v2__open"))
+		return;
+
+	cgrp_map_fd = bpf_map__fd(skel->maps.cgrp_map);
+	ret = bpf_map_update_elem(cgrp_map_fd, &idx, &cgrp_fd, BPF_ANY);
+	if (!ASSERT_OK(ret, "update_cgrp_map"))
+		goto cleanup;
+
+	/* Attach LSM prog first */
+	skel->links.lsm_run = bpf_program__attach_lsm(skel->progs.lsm_run);
+	if (!ASSERT_OK_PTR(skel->links.lsm_run, "lsm_attach"))
+		goto cleanup;
+
+	/* LSM prog will be triggered when attaching fentry */
+	skel->links.fentry_run = bpf_program__attach_trace(skel->progs.fentry_run);
+	ASSERT_NULL(skel->links.fentry_run, "fentry_attach");
+
+cleanup:
+	test_current_under_cgroupv1v2__destroy(skel);
+}
+
+static void current_under_cgroup1(void)
+{
+	int cgrp_fd, ret;
+
+	/* Setup cgroup1 hierarchy */
+	ret = setup_classid_environment();
+	if (!ASSERT_OK(ret, "setup_classid_environment"))
+		return;
+
+	ret = join_classid();
+	if (!ASSERT_OK(ret, "join_cgroup1"))
+		goto cleanup;
+
+	cgrp_fd = open_classid();
+	attach_progs(cgrp_fd);
+	close(cgrp_fd);
+
+cleanup:
+	/* Cleanup cgroup1 hierarchy */
+	cleanup_classid_environment();
+}
+
+static void current_under_cgroup2(void)
+{
+	int cgrp_fd;
+
+	cgrp_fd = test__join_cgroup(CGROUP2_DIR);
+	if (!ASSERT_GE(cgrp_fd, 0, "cgroup_join_cgroup2"))
+		return;
+
+	attach_progs(cgrp_fd);
+	close(cgrp_fd);
+}
+
+void test_current_under_cgroupv1v2(void)
+{
+	if (test__start_subtest("test_current_under_cgroup2"))
+		current_under_cgroup2();
+	if (test__start_subtest("test_current_under_cgroup1"))
+		current_under_cgroup1();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_current_under_cgroupv1v2.c b/tools/testing/selftests/bpf/progs/test_current_under_cgroupv1v2.c
new file mode 100644
index 0000000..9f0af0b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_current_under_cgroupv1v2.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_CGROUP_ARRAY);
+	__uint(key_size, sizeof(u32));
+	__uint(value_size, sizeof(u32));
+	__uint(max_entries, 1);
+} cgrp_map SEC(".maps");
+
+SEC("lsm/bpf")
+int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size)
+{
+	if (cmd != BPF_LINK_CREATE)
+		return 0;
+
+	if (bpf_current_task_under_cgroup(&cgrp_map, 0 /* map index */))
+		return -1;
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(fentry_run)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
1.8.3.1

