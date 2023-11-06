Return-Path: <cgroups+bounces-185-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D4B7E2BBA
	for <lists+cgroups@lfdr.de>; Mon,  6 Nov 2023 19:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A78AB21140
	for <lists+cgroups@lfdr.de>; Mon,  6 Nov 2023 18:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A6F2C86B;
	Mon,  6 Nov 2023 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6lvOUAo"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6042156E1
	for <cgroups@vger.kernel.org>; Mon,  6 Nov 2023 18:11:54 +0000 (UTC)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54030C6;
	Mon,  6 Nov 2023 10:11:53 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5aaebfac4b0so3153361a12.2;
        Mon, 06 Nov 2023 10:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699294313; x=1699899113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LcI5OntQB8Ozk+nrL6l6Pc64wO1UnRJQSv9QVd1F4r0=;
        b=A6lvOUAo5RoHzVBvdM2h7wpV2/pArXcYvUhmoN0pis0yU+q2tqF8nZ00LgMU10ysLe
         kR36jlYMJsLziaiznQDVZR6AvS5xCcFXkhz6EL6tDX1HCZqPJGC/5ZyS4xy/t41XXYn5
         TzflXPJtW51KGBjSqrZAswJBzydjc9RNzH+6bLZPigbgAnGmOlHwZKxOSbfv7v7qYlDo
         SfdRBTwy0p2XQB77MvHfnAzGEQnQn4817Qo/XCnow6yz1woyfUFqCxz6MZxEMvq3ghBd
         PZmw/hNE21eXQq9fV2JhpvSoj5AqMGsZubtekREvUPV0tGyRWH9foeTSHL5dXLEpCg/x
         azxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699294313; x=1699899113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LcI5OntQB8Ozk+nrL6l6Pc64wO1UnRJQSv9QVd1F4r0=;
        b=pqRHl65PY4d2kPJwgLOMzQbJsCNydKyWmYSoqNyD5+nlSftrsyWhRh0Vg7Y79efHjp
         60vkWPUbkdkd0fE7q6MQ7NjazfjiWvBe6u1Ex2j4cv5jmkD14/SbSWDhUXnvhjskD4sJ
         PppBadB/8QDDN2913vIKwfpfwpFgzZnvuKEQhoGrqIJgnk4qVo97+hhqrQY6xMawwjPE
         elxzcjZnslwhNWQsfbC9MkHwJGmggbkUHwlZSt/DpookjlJS+KI9AEWR0fcTtIw391ap
         MBaMgVuJHPsgns38Cscre80Nh5reSVJ/RcJOfpxZi0+2hAbXHOAeB2p1MaYVURhs1kQX
         9CMA==
X-Gm-Message-State: AOJu0YwaCNouRAiqzlox684J3bZJ5T/YR9q/lzUkE2g14+2w5sm7SJDb
	8Y8bCdyTe8/Y3iZbo5tgT0phnk9FwQw=
X-Google-Smtp-Source: AGHT+IHF57SPUGYIywUVjb/TOqr/IyfkWD811q9uPukp4atCiav/WgE+uU+rNZl3P0CSpXLk5AzlwQ==
X-Received: by 2002:a05:6a20:6a09:b0:138:2fb8:6c48 with SMTP id p9-20020a056a206a0900b001382fb86c48mr26852811pzk.8.1699294312677;
        Mon, 06 Nov 2023 10:11:52 -0800 (PST)
Received: from localhost.localdomain ([2405:201:6815:d829:2ad7:8520:6556:6c40])
        by smtp.gmail.com with ESMTPSA id du8-20020a056a002b4800b0069346777241sm6054637pfb.97.2023.11.06.10.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 10:11:52 -0800 (PST)
From: Atul Kumar Pant <atulpant.linux@gmail.com>
To: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	shuah@kernel.org
Cc: Atul Kumar Pant <atulpant.linux@gmail.com>,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] selftests: cgroup: Fixes code style errors
Date: Mon,  6 Nov 2023 23:41:44 +0530
Message-Id: <20231106181144.117188-1-atulpant.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes following checkpatch.pl issues:
ERROR: do not use assignment in if condition
ERROR: Macros starting with if should be enclosed by a do - while

Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
---
 tools/testing/selftests/cgroup/cgroup_util.c | 14 ++++++++------
 tools/testing/selftests/cgroup/test_core.c   |  3 ++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 0340d4ca8f51..e165c4a703a6 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -411,12 +411,14 @@ int dirfd_open_opath(const char *dir)
 	return open(dir, O_DIRECTORY | O_CLOEXEC | O_NOFOLLOW | O_PATH);
 }
 
-#define close_prot_errno(fd)                                                   \
-	if (fd >= 0) {                                                         \
-		int _e_ = errno;                                               \
-		close(fd);                                                     \
-		errno = _e_;                                                   \
-	}
+#define close_prot_errno(fd)				\
+	do {						\
+		if (fd >= 0) {                          \
+			int _e_ = errno;                \
+			close(fd);                      \
+			errno = _e_;                    \
+		}					\
+	} while (0);
 
 static int clone_into_cgroup_run_nowait(const char *cgroup,
 					int (*fn)(const char *cgroup, void *arg),
diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
index 80aa6b2373b9..ad758e510174 100644
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -817,7 +817,8 @@ static int test_cgcore_lesser_ns_open(const char *root)
 	if (cg_enter_current(cg_test_a))
 		goto cleanup;
 
-	if ((status = write(cg_test_b_procs_fd, "0", 1)) >= 0 || errno != ENOENT)
+	status = write(cg_test_b_procs_fd, "0", 1);
+	if (status >= 0 || errno != ENOENT)
 		goto cleanup;
 
 	ret = KSFT_PASS;
-- 
2.25.1


