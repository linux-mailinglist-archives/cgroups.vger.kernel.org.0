Return-Path: <cgroups+bounces-8562-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96C0ADCD89
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 15:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BCC516DB22
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 13:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DA92DF3C7;
	Tue, 17 Jun 2025 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UxVxbjKr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285C82E264A
	for <cgroups@vger.kernel.org>; Tue, 17 Jun 2025 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750167438; cv=none; b=uoIE/7pOy8lGoXUKGxbalN0rnUsiV/j06X/zDDMx4Ks1nKAIVShSzDEPTrgS0+dzi5r+a/YHWUCrceCLRZkNep1d2/hL0DvaTymi5NS9vdirQdQdGa8H1NSH8pGsj9Gugg9fBnSHOGsDviC/F+wnQT9BEhr737FvQptdl0OEJds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750167438; c=relaxed/simple;
	bh=HQNlByHSUvC0ZjiG4WYHMWePhB23AV2AemjXyLk+kJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+jYHEZdWS4kQGAFS4GldKUw2bjUGM8n1qbQ1pcui1JZHCV8GMlrn/5rKXo8vs+SO2jxkHWQ0MIAymWIxqahnjkF3uEUkNee/ouK9n/3PcbZbUttQxI4ozo2z05YESC3oFebbvdPTYC0KdVR8eJVEbBfL5x1lIhQZybhRrTZ3OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UxVxbjKr; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-453426170b6so17705735e9.1
        for <cgroups@vger.kernel.org>; Tue, 17 Jun 2025 06:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750167434; x=1750772234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgiT6f/x0Fb0H0o2vrOcdtmLUewssNoc2afzunKPIvM=;
        b=UxVxbjKr9xU0Wp9FRJGuk8fo0GWoKenj2xGcxHgudAF64jKrJHpZIEQzaBdHITuHzv
         KqccH3sU+gDL2TGYLhPVuRGCsmEQpsBu0iHM2CDLGjbbsSmPHYuzV9jxBuYlonWsRkSJ
         eqLwTFHNtq4AqXpPxZpDNqj5DyXUVEqhfehvDEd+DcdMmS/ZOo8cGaAQId0TBRRzdrNU
         CyB2cdu3+kT4FFRBmCCW2upcRNiE81bWAMnNLD0i+Kh4lZGmfBASnS1wBXwbDyF/4BLl
         ZSUjJsVMgfMlzLzM9VTCCgPztFLSb5iVNe216ir++vw+IRedn1LdwHhWEV3eF9ZXEg0G
         kTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750167434; x=1750772234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgiT6f/x0Fb0H0o2vrOcdtmLUewssNoc2afzunKPIvM=;
        b=uUyl/upS+BcwBfcn43/moAFxlYNchs3wEGK4rF6Md3805OruCRMwq6VJeibbhpQQCh
         8A7vS1f/f5gx9Snc/pObx9U9tKOZhbUtARo0q/Pfb7rjeKukrIYqJFOjupSnKKy+lX4i
         KFftTMJii7mWwDiBBZ6639/pDBsBN/3OkV4z8lQQhK8o/teEoaGv3v4ZBybIssHhaxSS
         v2iuOhEvbwXimNqqjb/C3q9PKMcMsqWJHklUcx2rHim0hFnGr4xXmfAnye/COUzZFQES
         jP+uyzQPJWPjXdxixRRc9mr0pC9VCpCmmkafumW6V4fcZFF71C2kyl/vyoYhSBYF02VV
         PlvA==
X-Gm-Message-State: AOJu0YzXRaXD/wjmeN+QSM2NbhY5AzP6T9rSK3s2kc3sE1M+uqT4hZf8
	PdRtGc6ajHuWdF5eBDXE6ggcjNZv2317IX3ysf6PXYhPANob2bxcJ4g3Ree6On/ftnifu+jrOun
	ZVQ+ePTI=
X-Gm-Gg: ASbGnctXmMx+/nvPJfKMNW1RhEC7Ga1c7WNhXBSNciA7tdv3lv0DwU58jpnvL+DwN5c
	FK6ag/i1Z+CJwtjEryRel1GsTj6JMVMOosTGSsDFTcJbqgslEeWrGav/MtdOJxAdXP8yx+Bo/ct
	xuZVoA9blFSgJFXQzWOP5z2wjtkxByUVtNVyHnsXovAkokADhgW60sNIf5oI+RJy0Ab4KENC1/m
	U2V2RiDHNNimBDV6NS8ncpTVOJuaXLedqk2H12Dc0SA5WiIC4+P8RbM341i8C1EZ+ctSzjZZDml
	L/n/iPzFTRVpOgCvkwHUoEvg+Z1/9sOf6wD+vv2++b/qVDBvgWpF1Bi+XRvwEyKl
X-Google-Smtp-Source: AGHT+IExevrLdNBxON43pa2jl4pvKa6yc0PjeTqzL/jm9rlEgPnVZnIv7wJ2pCS+hEez9KMDG8M4sg==
X-Received: by 2002:a05:600c:5251:b0:453:92e:a459 with SMTP id 5b1f17b1804b1-4533b28a97emr130794415e9.16.1750167434484;
        Tue, 17 Jun 2025 06:37:14 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224888sm179494365e9.1.2025.06.17.06.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 06:37:14 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH 1/4] selftests: cgroup_util: Add helpers for testing named v1 hierarchies
Date: Tue, 17 Jun 2025 15:36:53 +0200
Message-ID: <20250617133701.400095-2-mkoutny@suse.com>
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

Non-functional change, the control variable will be wired in a separate
commit.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 tools/testing/selftests/cgroup/lib/cgroup_util.c         | 4 +++-
 tools/testing/selftests/cgroup/lib/include/cgroup_util.h | 5 +++++
 tools/testing/selftests/cgroup/test_core.c               | 6 +++---
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/cgroup/lib/cgroup_util.c b/tools/testing/selftests/cgroup/lib/cgroup_util.c
index 8832f3d1cb614..0e89fcff4d05d 100644
--- a/tools/testing/selftests/cgroup/lib/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/lib/cgroup_util.c
@@ -19,6 +19,8 @@
 #include "cgroup_util.h"
 #include "../../clone3/clone3_selftests.h"
 
+bool cg_test_v1_named;
+
 /* Returns read len on success, or -errno on failure. */
 ssize_t read_text(const char *path, char *buf, size_t max_len)
 {
@@ -361,7 +363,7 @@ int cg_enter_current(const char *cgroup)
 
 int cg_enter_current_thread(const char *cgroup)
 {
-	return cg_write(cgroup, "cgroup.threads", "0");
+	return cg_write(cgroup, CG_THREADS_FILE, "0");
 }
 
 int cg_run(const char *cgroup,
diff --git a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
index adb2bc1931839..c69cab66254b4 100644
--- a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
@@ -13,6 +13,10 @@
 
 #define TEST_UID	65534 /* usually nobody, any !root is fine */
 
+#define CG_THREADS_FILE (!cg_test_v1_named ? "cgroup.threads" : "tasks")
+#define CG_NAMED_NAME "selftest"
+#define CG_PATH_FORMAT (!cg_test_v1_named ? "0::%s" : (":name=" CG_NAMED_NAME ":%s"))
+
 /*
  * Checks if two given values differ by less than err% of their sum.
  */
@@ -65,3 +69,4 @@ extern int dirfd_open_opath(const char *dir);
 extern int cg_prepare_for_wait(const char *cgroup);
 extern int memcg_prepare_for_wait(const char *cgroup);
 extern int cg_wait_for(int fd);
+extern bool cg_test_v1_named;
diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
index a5672a91d273c..0c4cc4e5fc8c2 100644
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -573,7 +573,7 @@ static int test_cgcore_proc_migration(const char *root)
 	}
 
 	cg_enter_current(dst);
-	if (cg_read_lc(dst, "cgroup.threads") != n_threads + 1)
+	if (cg_read_lc(dst, CG_THREADS_FILE) != n_threads + 1)
 		goto cleanup;
 
 	ret = KSFT_PASS;
@@ -605,7 +605,7 @@ static void *migrating_thread_fn(void *arg)
 	char lines[3][PATH_MAX];
 
 	for (g = 1; g < 3; ++g)
-		snprintf(lines[g], sizeof(lines[g]), "0::%s", grps[g] + strlen(grps[0]));
+		snprintf(lines[g], sizeof(lines[g]), CG_PATH_FORMAT, grps[g] + strlen(grps[0]));
 
 	for (i = 0; i < n_iterations; ++i) {
 		cg_enter_current_thread(grps[(i % 2) + 1]);
@@ -659,7 +659,7 @@ static int test_cgcore_thread_migration(const char *root)
 	if (retval)
 		goto cleanup;
 
-	snprintf(line, sizeof(line), "0::%s", grps[1] + strlen(grps[0]));
+	snprintf(line, sizeof(line), CG_PATH_FORMAT, grps[1] + strlen(grps[0]));
 	if (proc_read_strstr(0, 1, "cgroup", line))
 		goto cleanup;
 
-- 
2.49.0


