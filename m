Return-Path: <cgroups+bounces-110-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDCE7DAB1C
	for <lists+cgroups@lfdr.de>; Sun, 29 Oct 2023 07:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE982817CD
	for <lists+cgroups@lfdr.de>; Sun, 29 Oct 2023 06:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFEF5665;
	Sun, 29 Oct 2023 06:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQxW/IEB"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EB78C19;
	Sun, 29 Oct 2023 06:14:59 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EE6CC;
	Sat, 28 Oct 2023 23:14:58 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3b2e22a4004so2437898b6e.3;
        Sat, 28 Oct 2023 23:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698560098; x=1699164898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBmbTwV/SCzHF6Ex+v7R9Tm3nCh0Ha6QemKh6sWeBKo=;
        b=bQxW/IEBLqyfhnEamEK0dIJ7KO3ZdkJREX09hT6NoQviYobRqBUhUMcx82f/AXoD2V
         N9kq5VTM54QSkhFZah9mLSdFe/DfvfNkK1jN0ig8fHy1TWNjGhO95/0Xmvtl9fZTbdzn
         d1vA5tU4hTEbcs8Mw8E7AzKjGczfjIM0Iv3w4sMSW8We3B3qy8N6jZOLWQIrUJsORo1L
         jcfPnl8f/6X+sDt7NC6D35num+ujjNQwb+qvQS4j5bOzZ8L5wf1gRW31HU4ojrpTxH5V
         ipJb2m68Jh5dOJ1X5yPy1Ka0UX6r57jPLSOh0BfM8vYxyYgwTmiKFPKumlujCyJpogWe
         2BJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698560098; x=1699164898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBmbTwV/SCzHF6Ex+v7R9Tm3nCh0Ha6QemKh6sWeBKo=;
        b=mVvoosrDN8ThE77rkwV7xRzIlu9RgC584wNfXzyZq8iWVyGzkHi3RBI1fNpqb3D4ex
         NxHgNLlqXs6ZCzE4PycyiSSG0cuuzdYHiw1n4qljVtRgL6bSHDqvPCIGPJwO+AnRx/0a
         gwobb9ZWcTzVgGJ2fk9xIiBebN1LnchiBE+qtXhyoGSQPVY9RQ0tXe0Bv2SqRHdrQDef
         PoemZCZ4AABEw0z3L0V+nyN3cBr+HmeuyYOhSkxqCwEl7G3kMShqQi+doNaY0v9Wc3Ir
         +wBQOOXab5OeI3GDYfnCWRtD9detB/EdH1rR0/A+GqaU0rwHIAgiQV/IJcyJqI61CdvS
         rPKQ==
X-Gm-Message-State: AOJu0Yye9CdRd93U0nHWp+eEXCB4lMKa8t+61ljeqvxBMLZK8grOROZF
	rSa/rXpT1YQL9BHIbN5sCXk=
X-Google-Smtp-Source: AGHT+IGVnXoQqAnMqSaErKSKkEc/768WtOCUQNP5tNBS9BwmfnBafvZocKuIYi5V/5RnQFedOzqp6g==
X-Received: by 2002:aca:1909:0:b0:3b2:df82:812e with SMTP id l9-20020aca1909000000b003b2df82812emr7689811oii.32.1698560097914;
        Sat, 28 Oct 2023 23:14:57 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:2b5:5400:4ff:fea0:d066])
        by smtp.gmail.com with ESMTPSA id m2-20020aa79002000000b006b225011ee5sm3775106pfo.6.2023.10.28.23.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 23:14:57 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 07/11] selftests/bpf: Fix issues in setup_classid_environment()
Date: Sun, 29 Oct 2023 06:14:34 +0000
Message-Id: <20231029061438.4215-8-laoar.shao@gmail.com>
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
index 5b1da2a..10b5f42 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -523,10 +523,20 @@ int setup_classid_environment(void)
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
1.8.3.1


