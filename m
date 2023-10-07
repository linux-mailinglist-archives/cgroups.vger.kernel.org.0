Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5288E7BC838
	for <lists+cgroups@lfdr.de>; Sat,  7 Oct 2023 16:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343946AbjJGODZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Oct 2023 10:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343933AbjJGODY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Oct 2023 10:03:24 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33043C5;
        Sat,  7 Oct 2023 07:03:22 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c723f1c80fso22656085ad.1;
        Sat, 07 Oct 2023 07:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696687401; x=1697292201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxmghcOcb4Lv1mKG5g6exWWWkajf/SPl1xKizlQXNEE=;
        b=Sa9UsKe33dTiCY3bB2MaRtiMogiuNxho6tGFMfRq09aWsDEflo0zr/PiFGDsMJ9T1M
         0SX4DQw1fvdOkOTV+zg0tJMTGO7IjiI7mhFtCDlSswmvI374Kop3OzRwdNKi3HiRPTEJ
         CUVoW1IH/4sQbSlWs4aojpxtkbLxxPTqMRuXenj9eDXAQYdbZfnF42uJPfohFZgxeMvJ
         e8F36ghm6huXPjdGLlf+Ark3p9IOY/QzGYAqEXIAtLeX6Ml3IqiV83se8A5KqwIR3+dP
         iA/4SlHfLuHss4BKxpoZcPJDyvauo0gkwx866hv7omf+gVFEdYGt4UWiae2OyYsg4cmP
         dn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696687401; x=1697292201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxmghcOcb4Lv1mKG5g6exWWWkajf/SPl1xKizlQXNEE=;
        b=r0awJEgu5+VWmVDzBb8tjnwiFTdR0fw7a4NCd+ZAf54xnAAnnzmEgCH+btIYywEOQ3
         dundZJChF5sXP9KrwZ/FzxnKZ7jbQj6iJfYCJOPlBsBTwlqC5tYHwOiDhrkPnzZAGcIF
         uF8l1XPkUTN09wS2Ao6qtouUkXTUqoV0MP752qQhF/+8RZEyU1ZGoZD1cu7hXWpbAHsh
         uu9kfwdakBYpFOphaTeBExi4g7FNIlKgd21AbHh9tCPv/LfqW1dJ2eNfDj/PAGvnzsUC
         /WmAq6CuzQiDcZTgMSMmz6u/L6MsOqd+jTvaPNwCrrZxsQaqDhUh1o+qq6m4xW71ac2s
         ZjTg==
X-Gm-Message-State: AOJu0YzvSWT3ya94YGVRo//AlOxTUIajPppp7U7xaxsGSVVcK0M8umWv
        8HWZmf8FcXudulzhfWOeIFU=
X-Google-Smtp-Source: AGHT+IEezGGRhbK03ax3JNIzFoLUpg5F1k0ZqeF9wak/y1NjlOW2XuFsrwhecuU/W1o0P5dcQkrwLQ==
X-Received: by 2002:a17:903:1d0:b0:1c5:bea4:8537 with SMTP id e16-20020a17090301d000b001c5bea48537mr12692272plh.15.1696687401584;
        Sat, 07 Oct 2023 07:03:21 -0700 (PDT)
Received: from vultr.guest ([45.77.191.53])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902f68d00b001c0a414695dsm5897550plg.62.2023.10.07.07.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 07:03:21 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        mkoutny@suse.com, sinquersw@gmail.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 4/8] selftests/bpf: Fix issues in setup_classid_environment()
Date:   Sat,  7 Oct 2023 14:03:00 +0000
Message-Id: <20231007140304.4390-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231007140304.4390-1-laoar.shao@gmail.com>
References: <20231007140304.4390-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

