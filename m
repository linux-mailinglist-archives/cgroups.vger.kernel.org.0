Return-Path: <cgroups+bounces-8565-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F49ADCD97
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 15:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAFF018826ED
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 13:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70F92E3B1D;
	Tue, 17 Jun 2025 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fXJ+lSyV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED3B2E3AE1
	for <cgroups@vger.kernel.org>; Tue, 17 Jun 2025 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750167442; cv=none; b=Yy5ResS9u5RL/0WVuBNRWxZ25ZDkyA2KqAq3ExLo5RqcN8R5oCXqRP94chxVBHOx8eW7Kp4lV+3S7ddCAmyFSey59FPE3lK/kzjyZwhi0N317EuxxSKjZQf3IhSoS6RCKzliaM4qD3V8j1eNML8T5zaMnwCaW6UTUSeRn/7JbYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750167442; c=relaxed/simple;
	bh=yGgw6Mn0umYKmzsCB8BL/2ViW2Q7/PLM5b9EyoXAOVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UqFGsGHibXJA4e/fmhab6Cm+/uw2qKJgfBgXjoTIpdcxabIE5Y6GhKBCac76T47OYC9kZHPul8Klxi9eYWa481JHRuZdb2s8KyObxY02maxns+sO9j5i1WHliJIN4jAQPqDKzc4Pos9GeF9o7jjO8pbnTJcd1YqOhTxwBr1XWRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fXJ+lSyV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-450ccda1a6eso51522205e9.2
        for <cgroups@vger.kernel.org>; Tue, 17 Jun 2025 06:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750167437; x=1750772237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gY+ZL5/CdCDr9pYfYWcTDJPdb5lvMHKJxSeQMsCXxr0=;
        b=fXJ+lSyVZJNNYSoLKL/AmosATC7dzs5LYipU95edOrjBLXU1C+5UFwm16Itc5ZXIRC
         28ltA5vTHtb6YRwPYPqAZtk9B1si5nNvbJAM4SD46pzn5ZILkY5SSpve+k/0cllhZOJ5
         x1cA+r3uQAL4Rx0nv8gIw0QC0BJzlAQzKl7rutr8Wz3mk0mUrqmKefaF088mFezHMgtS
         VylCj4G6KLXys/xIVcZz8LzNNQkoAs/UDftEJ0ZaVp5eZVhDBYxDxp3u27FgjEGgTPPA
         xB3agn//DcXZmfGrEk789FgJ3ivb4GeUCZdaH9Ov04IEZnn84Hq0tPYknYH6pkgMxzsg
         Fv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750167437; x=1750772237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gY+ZL5/CdCDr9pYfYWcTDJPdb5lvMHKJxSeQMsCXxr0=;
        b=I8E1BGzCmCa2JYyNWOtJDo/tKWdXjRxVh3Yn5q6UrJ19+F6IHNpC1slE9025OINaLu
         rAT1Z0uS9KkhEYjrf05Cc7ABDRgqEnViwbW5wG+tjAFyUsZ9JBV8qEONPG90lm7zHOHq
         DlTRgq3rDCiKBu5rwDqiznQvlo47Oww/9s/DdKgC2ySqrtA9ePUqv2747KskxQoOBHcV
         yosiW8I/S8ClS3QbW8KJni1QmOjYOQfF/qRuLO/8lWihHA2oY8uNO/J20FQ8TdySjkNo
         drQcJe5FDmx6dFbp/WG/ZAG0dpq3JRREExL1QkgVFKFRFuTvvz7BE/IKNYpAa6aWpbam
         +0Gg==
X-Gm-Message-State: AOJu0YxKoCuCJsTjmLCZTY/R1BDMP4Wz1Db00Jw2RRapGIROc/IPwOqL
	B8RWxCG7PgIeTUh85Qafyu7SZa+OysuIZjAS0EyDrYwYMP0LJD27+JADAlJEhPYBpiW+y2Poz0D
	stOuQ2Ao=
X-Gm-Gg: ASbGncuLQeOzLk8mBGSsnhvuSU00Ei4L1aNJJh2pYawA9d0byX67CerJ8IvoILuZlF+
	O2+jYTXqtyQ0nU6eRP8tFyyOfCsvQZcjbYUvZ6w4OdTWd7ZBVlPw1uSgTRwqhwRlBYOPzUO/a3M
	DMeZ4dHdMPF+wIiPMehQCBO4bdNKjwX/4hwKXgC4D0LNwcdNXrfIDl2nk3RwY855U5M0RJmn6cx
	RoS9ITUSXQDYoDQwHHY4rEGrN+apGHzhGmO29TyvGpqkSgEMLkx2Exu8sjc/O9Kmjr2z9QUxtV3
	kiMURjy+cl72IDShtBdQA7A43P8xOKFWFawwD0ZRmMjlZEk8dCTHcAG+o4IdAbIr
X-Google-Smtp-Source: AGHT+IFpq9WEDmoZNu9HpxpLoTTCX7cKZVAPrAxP5TMGyBzJKcO6qgbPg4kQjxzopi6DV/N3EhJo/A==
X-Received: by 2002:a05:600c:37c9:b0:43d:3df:42d8 with SMTP id 5b1f17b1804b1-453513f2aa4mr38219795e9.6.1750167436685;
        Tue, 17 Jun 2025 06:37:16 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224888sm179494365e9.1.2025.06.17.06.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 06:37:16 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH 3/4] selftests: cgroup: Optionally set up v1 environment
Date: Tue, 17 Jun 2025 15:36:55 +0200
Message-ID: <20250617133701.400095-4-mkoutny@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617133701.400095-1-mkoutny@suse.com>
References: <20250617133701.400095-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use the missing mount of the unifier hierarchy as a hint of legacy
system and prepare our own named v1 hierarchy for tests.

The code is only in test_core.c and not cgroup_util.c because other
selftests are related to controllers which will be exposed on v2
hierarchy but named hierarchies are only v1 thing.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 tools/testing/selftests/cgroup/test_core.c | 44 +++++++++++++++++++++-
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
index 338e276aae5da..452c2abf9794e 100644
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -5,6 +5,8 @@
 #include <linux/sched.h>
 #include <sys/types.h>
 #include <sys/mman.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
 #include <sys/wait.h>
 #include <unistd.h>
 #include <fcntl.h>
@@ -863,6 +865,38 @@ static int test_cgcore_lesser_ns_open(const char *root)
 	return ret;
 }
 
+static int setup_named_v1_root(char *root, size_t len, const char *name)
+{
+	char options[PATH_MAX];
+	int r;
+
+	r = snprintf(root, len, "/mnt/cg_selftest");
+	if (r < 0)
+		return r;
+
+	r = snprintf(options, sizeof(options), "none,name=%s", name);
+	if (r < 0)
+		return r;
+
+	r = mkdir(root, 0755);
+	if (r < 0 && errno != EEXIST)
+		return r;
+
+	r = mount("none", root, "cgroup", 0, options);
+	if (r < 0)
+		return r;
+
+	return 0;
+}
+
+static void cleanup_named_v1_root(char *root)
+{
+	if (!cg_test_v1_named)
+		return;
+	umount(root);
+	rmdir(root);
+}
+
 #define T(x) { x, #x }
 struct corecg_test {
 	int (*fn)(const char *root);
@@ -888,13 +922,18 @@ int main(int argc, char *argv[])
 	char root[PATH_MAX];
 	int i, ret = EXIT_SUCCESS;
 
-	if (cg_find_unified_root(root, sizeof(root), &nsdelegate))
-		ksft_exit_skip("cgroup v2 isn't mounted\n");
+	if (cg_find_unified_root(root, sizeof(root), &nsdelegate)) {
+		if (setup_named_v1_root(root, sizeof(root), CG_NAMED_NAME))
+			ksft_exit_skip("cgroup v2 isn't mounted and could not setup named v1 hierarchy\n");
+		cg_test_v1_named = true;
+		goto post_v2_setup;
+	}
 
 	if (cg_read_strstr(root, "cgroup.subtree_control", "memory"))
 		if (cg_write(root, "cgroup.subtree_control", "+memory"))
 			ksft_exit_skip("Failed to set memory controller\n");
 
+post_v2_setup:
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
 		switch (tests[i].fn(root)) {
 		case KSFT_PASS:
@@ -910,5 +949,6 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	cleanup_named_v1_root(root);
 	return ret;
 }
-- 
2.49.0


