Return-Path: <cgroups+bounces-112-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ED67DAB21
	for <lists+cgroups@lfdr.de>; Sun, 29 Oct 2023 07:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4EEEB215D7
	for <lists+cgroups@lfdr.de>; Sun, 29 Oct 2023 06:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C92A6126;
	Sun, 29 Oct 2023 06:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJkWcyjN"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8C3610D;
	Sun, 29 Oct 2023 06:15:03 +0000 (UTC)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46495CC;
	Sat, 28 Oct 2023 23:15:02 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7a6907e9aa8so117736139f.1;
        Sat, 28 Oct 2023 23:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698560101; x=1699164901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ke1D6m74mgBawz9JZev+dTdh8Sh2Lm5iPjGvjgkU9M=;
        b=eJkWcyjNP49fR4m87rktCvvNFThRJDjAEHzrgNS2Qc7fy83P08/Szdk0AzJ3Eykn/y
         V0IesyqIbfZIbHjiUqjFDcmhhL97XNakoieQzZDKgFnGR5KP5c6q+mvYSTQ/jd7ECNgU
         cN/v6sO4h/+xQdGH5WqhiQhMnOVvCicbirZQVlWD5/R7n4KxwbbTLt6LjoimfU5ZzHsY
         2ZXfKlupdnbVA98NOHYR8ERjtfPju2MjYTinRSkYI/sk+s54Q0iM6rRFG6yQ4XQCcXPe
         2t5f8pm9/t7i/ExmbNQfu9+jEC6UOaIIYfcKVfx1n28NGwuJQjTYEKt8T1BptLkU3UlP
         OcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698560101; x=1699164901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ke1D6m74mgBawz9JZev+dTdh8Sh2Lm5iPjGvjgkU9M=;
        b=HiZ53oik+btiPif5ojebj1z02n++fPXOmOwm9HMvVIqK1MhHNdE8a+rsdMjxP1ZajG
         mi/l5TyiFIrURAEo0hxCawfrdBBSL5IwmhKjkMN/qV8s0qt9SjXJXEw0qEqxzBD2SNdf
         WbounFY9A9fiOECYx2sjZsrkzre4f65MtxA3y4YtIzfqTH1oLPa10E0xaJVs0Z0JuVox
         vOiogMBpMWVlGxhxUEJ69D7MrMUg0pFEcVl+wDloNBC5JqNDh0FYe7HO9rIb6aQsj3Gf
         EQpe1K90gDjILbl638O6nz0LkSyvt/r1jJOY/uxfmj+yzk/nmA1O1rQRd53eaBL41Qdd
         lhqg==
X-Gm-Message-State: AOJu0YxtFtNDnFu+b1TANkJfSJfVXi/seAJk8/BVwjK+nYV46VcnmzmX
	kMajiAyNtzgdiW+eyTkFnpE=
X-Google-Smtp-Source: AGHT+IH8707bd7hPq7eNfJWhCFO60YW5a3Ui0CaWpUnW1BC5KC3rKfrzpXppmvH7ZqdiqXow3HAf2w==
X-Received: by 2002:a05:6602:154a:b0:79f:e707:8813 with SMTP id h10-20020a056602154a00b0079fe7078813mr10669797iow.4.1698560101327;
        Sat, 28 Oct 2023 23:15:01 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:2b5:5400:4ff:fea0:d066])
        by smtp.gmail.com with ESMTPSA id m2-20020aa79002000000b006b225011ee5sm3775106pfo.6.2023.10.28.23.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 23:15:00 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 09/11] selftests/bpf: Add a new cgroup helper get_classid_cgroup_id()
Date: Sun, 29 Oct 2023 06:14:36 +0000
Message-Id: <20231029061438.4215-10-laoar.shao@gmail.com>
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

Introduce a new helper function to retrieve the cgroup ID from a net_cls
cgroup directory.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 28 ++++++++++++++++++++++------
 tools/testing/selftests/bpf/cgroup_helpers.h |  1 +
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index f18649a..63bfa72 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -422,26 +422,23 @@ int create_and_get_cgroup(const char *relative_path)
 }
 
 /**
- * get_cgroup_id() - Get cgroup id for a particular cgroup path
- * @relative_path: The cgroup path, relative to the workdir, to join
+ * get_cgroup_id_from_path - Get cgroup id for a particular cgroup path
+ * @cgroup_workdir: The absolute cgroup path
  *
  * On success, it returns the cgroup id. On failure it returns 0,
  * which is an invalid cgroup id.
  * If there is a failure, it prints the error to stderr.
  */
-unsigned long long get_cgroup_id(const char *relative_path)
+unsigned long long get_cgroup_id_from_path(const char *cgroup_workdir)
 {
 	int dirfd, err, flags, mount_id, fhsize;
 	union {
 		unsigned long long cgid;
 		unsigned char raw_bytes[8];
 	} id;
-	char cgroup_workdir[PATH_MAX + 1];
 	struct file_handle *fhp, *fhp2;
 	unsigned long long ret = 0;
 
-	format_cgroup_path(cgroup_workdir, relative_path);
-
 	dirfd = AT_FDCWD;
 	flags = 0;
 	fhsize = sizeof(*fhp);
@@ -477,6 +474,14 @@ unsigned long long get_cgroup_id(const char *relative_path)
 	return ret;
 }
 
+unsigned long long get_cgroup_id(const char *relative_path)
+{
+	char cgroup_workdir[PATH_MAX + 1];
+
+	format_cgroup_path(cgroup_workdir, relative_path);
+	return get_cgroup_id_from_path(cgroup_workdir);
+}
+
 int cgroup_setup_and_join(const char *path) {
 	int cg_fd;
 
@@ -621,3 +626,14 @@ void cleanup_classid_environment(void)
 	join_cgroup_from_top(NETCLS_MOUNT_PATH);
 	nftw(cgroup_workdir, nftwfunc, WALK_FD_LIMIT, FTW_DEPTH | FTW_MOUNT);
 }
+
+/**
+ * get_classid_cgroup_id - Get the cgroup id of a net_cls cgroup
+ */
+unsigned long long get_classid_cgroup_id(void)
+{
+	char cgroup_workdir[PATH_MAX + 1];
+
+	format_classid_path(cgroup_workdir);
+	return get_cgroup_id_from_path(cgroup_workdir);
+}
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing/selftests/bpf/cgroup_helpers.h
index 92fc41d..e71da4e 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -31,6 +31,7 @@ int write_cgroup_file_parent(const char *relative_path, const char *file,
 /* cgroupv1 related */
 int set_classid(void);
 int join_classid(void);
+unsigned long long get_classid_cgroup_id(void);
 
 int setup_classid_environment(void);
 void cleanup_classid_environment(void);
-- 
1.8.3.1


