Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE1D7AB0A6
	for <lists+cgroups@lfdr.de>; Fri, 22 Sep 2023 13:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjIVL3W (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Sep 2023 07:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbjIVL3V (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Sep 2023 07:29:21 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5190D197;
        Fri, 22 Sep 2023 04:29:15 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-690d8fb3b7eso1852192b3a.1;
        Fri, 22 Sep 2023 04:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695382155; x=1695986955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxmghcOcb4Lv1mKG5g6exWWWkajf/SPl1xKizlQXNEE=;
        b=C1yvSKtcf8b8zMSnHslJ+/+kgpI+4RtJkLSPcVu3s31pgu2yciBb853YLfg8Lfb6rU
         MkWmrhENjSgJgfisqGTO73tewSBuTZTAfI8gtZ54IHXUuo7lhUoIykDbzUleUjAJ5Xd7
         yMbPu2xXEF11kqSVobl1JcmVSd3dt+ubrbCSlCKL066r8hPFEA+fz4MpW8kFSYxs3jVV
         ZJZOlccuxf1zBb1t5E03PzjrwfMUE/j26fJr1Xt05lEVd1Mk25A18rjs5eraYQBQRIZN
         YDUujeAcVrW8NpsMp2uCnTfRKy+XTnQudb+96jgTI6b8ScJVklO5zbE4UBMj2b/dQRHM
         CQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695382155; x=1695986955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxmghcOcb4Lv1mKG5g6exWWWkajf/SPl1xKizlQXNEE=;
        b=BcObpHEL0IRoPN4qNbm4V0JUj9BrQsPpBPN56gQNsVs2haYu61VVvq4PWgHWUFpZCX
         wodMEFT+Hzio1halxIsEdJ8QfXu/5Rbpfm4Iuo9hzk3UIXuyfxb2tfFctBO/62FDZkl9
         h0jlOVJsOLjuNRtUcSpvam0wVo9HFxRGjSga126TYrCj1LDXRRmqheZycHKzbKMqAZY8
         ZRzU/DqA/sQSD7zyK8O7kA3vn0lf4MlawO6fvqRhpgBTll+c4MQM5xqJZB0lKEc+eYtR
         A8NFrcAWb4zuwa0eaHntmAENOlk/uUiuuIALvtFEHL8LUWnkus7i26YtSkhoJ3qycBeM
         xv5Q==
X-Gm-Message-State: AOJu0Yznj6NWuqHCdtsPatY8g4fxUKSnAyJv3y4Mj3MKwUpexU3L/qc5
        JxZJ8EkDjW3cSLyZrIuOOfo=
X-Google-Smtp-Source: AGHT+IHukcKWZ5HdAMd6ckgrDTLtw6m6pdu5olT6UOSJLosEq36YENbyW3y6Pav9V5xIX06Om7jmRA==
X-Received: by 2002:a05:6a20:3ca3:b0:154:a9bc:12d0 with SMTP id b35-20020a056a203ca300b00154a9bc12d0mr9562321pzj.13.1695382154720;
        Fri, 22 Sep 2023 04:29:14 -0700 (PDT)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id v16-20020aa78090000000b00690beda6987sm2973493pff.77.2023.09.22.04.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 04:29:13 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        mkoutny@suse.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 5/8] selftests/bpf: Fix issues in setup_classid_environment()
Date:   Fri, 22 Sep 2023 11:28:43 +0000
Message-Id: <20230922112846.4265-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230922112846.4265-1-laoar.shao@gmail.com>
References: <20230922112846.4265-1-laoar.shao@gmail.com>
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

If the net_cls subsystem is already mounted, attempting to mount it again
in setup_classid_environment() will result in a failure with the error code
EBUSY. Despite this, tmpfs will have been successfully mounted at
/sys/fs/cgroup/net_cls. Consequently, the /sys/fs/cgroup/net_cls directory
will be empty, causing subsequent setup operations to fail.

Here's an error log excerpt illustrating the issue when net_cls has already
been mounted at /sys/fs/cgroup/net_cls prior to running
setup_classid_environment():

- Before that change

  $ tools/testing/selftests/bpf/test_progs --name=cgroup_v1v2
  test_cgroup_v1v2:PASS:server_fd 0 nsec
  test_cgroup_v1v2:PASS:client_fd 0 nsec
  test_cgroup_v1v2:PASS:cgroup_fd 0 nsec
  test_cgroup_v1v2:PASS:server_fd 0 nsec
  run_test:PASS:skel_open 0 nsec
  run_test:PASS:prog_attach 0 nsec
  test_cgroup_v1v2:PASS:cgroup-v2-only 0 nsec
  (cgroup_helpers.c:248: errno: No such file or directory) Opening Cgroup Procs: /sys/fs/cgroup/net_cls/cgroup.procs
  (cgroup_helpers.c:540: errno: No such file or directory) Opening cgroup classid: /sys/fs/cgroup/net_cls/cgroup-test-work-dir/net_cls.classid
  run_test:PASS:skel_open 0 nsec
  run_test:PASS:prog_attach 0 nsec
  (cgroup_helpers.c:248: errno: No such file or directory) Opening Cgroup Procs: /sys/fs/cgroup/net_cls/cgroup-test-work-dir/cgroup.procs
  run_test:FAIL:join_classid unexpected error: 1 (errno 2)
  test_cgroup_v1v2:FAIL:cgroup-v1v2 unexpected error: -1 (errno 2)
  (cgroup_helpers.c:248: errno: No such file or directory) Opening Cgroup Procs: /sys/fs/cgroup/net_cls/cgroup.procs
  #44      cgroup_v1v2:FAIL
  Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED

- After that change
  $ tools/testing/selftests/bpf/test_progs --name=cgroup_v1v2
  #44      cgroup_v1v2:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 24ba56d42f2d..9c36d1db9f94 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -518,10 +518,20 @@ int setup_classid_environment(void)
 		return 1;
 	}
 
-	if (mount("net_cls", NETCLS_MOUNT_PATH, "cgroup", 0, "net_cls") &&
-	    errno != EBUSY) {
-		log_err("mount cgroup net_cls");
-		return 1;
+	if (mount("net_cls", NETCLS_MOUNT_PATH, "cgroup", 0, "net_cls")) {
+		if (errno != EBUSY) {
+			log_err("mount cgroup net_cls");
+			return 1;
+		}
+
+		if (rmdir(NETCLS_MOUNT_PATH)) {
+			log_err("rmdir cgroup net_cls");
+			return 1;
+		}
+		if (umount(CGROUP_MOUNT_DFLT)) {
+			log_err("umount cgroup base");
+			return 1;
+		}
 	}
 
 	cleanup_classid_environment();
-- 
2.30.1 (Apple Git-130)

