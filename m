Return-Path: <cgroups+bounces-113-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3C57DAB22
	for <lists+cgroups@lfdr.de>; Sun, 29 Oct 2023 07:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04336B21688
	for <lists+cgroups@lfdr.de>; Sun, 29 Oct 2023 06:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56F7944C;
	Sun, 29 Oct 2023 06:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hj42s4Df"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049DA8F60;
	Sun, 29 Oct 2023 06:15:04 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7CED3;
	Sat, 28 Oct 2023 23:15:03 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6bf03b98b9bso3207597b3a.1;
        Sat, 28 Oct 2023 23:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698560103; x=1699164903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sa07Z9Tnf6gPzoCSdY0mE9Qwjplz9eHiRUctPRFvz3A=;
        b=hj42s4DflsqbcUzB5arhulJaGqjIKybrpY6DRvZkqYtZepvTU8dn9KxNFkOgwGeMe6
         DjT5/0fFZlcUWSPmD+osFFWCHTfjnMISftRNSPhm/vPFVWmFJ8G8XjmJBGISnRL6WUVG
         ecLx6JRPNeOE9YynX/VNIkiCP6gI7r7SHv3aqz5uRm64kAbP4M5By5RnvAYgGHYGdgz+
         6NeW+uKbfkkzkVQTQeTrS8uRQC97+gC1DkT1+ukQCv2nAHwlqG/PX/goLEK13bOz9rNR
         RwZBygusFy6ECIIWExQa385d1HypvL6mJhOFkUwW53a0OWdgW7uZfiJNcqwosWsAmuKG
         /7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698560103; x=1699164903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sa07Z9Tnf6gPzoCSdY0mE9Qwjplz9eHiRUctPRFvz3A=;
        b=kcod7RPWunKvXSvykCNWcUNiKKZXiDNp7i/7+Bdiy1VCVNCOn4EEybm4nF3JwfUpOp
         ViNfh+WxJFsSCvxypSODLHbOhOQbL8yDltmwxWvuYIC53tIZVQX6FSxkDkkuvJOXXJO4
         0a/G+fQDEjbMsP215vjjpXjO+0aThGKz2vw04HTiXCi1maLeewfO4T95j2u6VIiBS5q5
         5t2VQ/b8E3im7DkVEToZYK+DPdT3PAYIPb+saVAfLpB07v7vaeKk7vzdh9WlXrK0Gs57
         RSmObU4acfKGw0e+BSzIt0ZC3Ne5ic0Td/MlB3kqn5SK9+ROrc/91r9uqLLaJTrF3P/e
         NuQg==
X-Gm-Message-State: AOJu0YxzbfgUz2P3Wlu1Z5Iq2k8qVC3wa7tkHle8XxRtpd77LwQaXS4f
	WeinKBv16VHqk08oMC/lHpk=
X-Google-Smtp-Source: AGHT+IGjaDJASCPUTLvbci15ulVbGCl/dqqbojUBn6MEr8alcSorg0sHR4dy08CSeg9Zaia2lSOzIg==
X-Received: by 2002:a05:6a21:a583:b0:161:aef5:6395 with SMTP id gd3-20020a056a21a58300b00161aef56395mr9055218pzc.24.1698560102960;
        Sat, 28 Oct 2023 23:15:02 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:2b5:5400:4ff:fea0:d066])
        by smtp.gmail.com with ESMTPSA id m2-20020aa79002000000b006b225011ee5sm3775106pfo.6.2023.10.28.23.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 23:15:02 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 10/11] selftests/bpf: Add a new cgroup helper get_cgroup_hierarchy_id()
Date: Sun, 29 Oct 2023 06:14:37 +0000
Message-Id: <20231029061438.4215-11-laoar.shao@gmail.com>
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

A new cgroup helper function, get_cgroup1_hierarchy_id(), has been
introduced to obtain the ID of a cgroup1 hierarchy based on the provided
cgroup name. This cgroup name can be obtained from the /proc/self/cgroup
file.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 49 ++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/cgroup_helpers.h |  1 +
 2 files changed, 50 insertions(+)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 63bfa72..d75bb87 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -637,3 +637,52 @@ unsigned long long get_classid_cgroup_id(void)
 	format_classid_path(cgroup_workdir);
 	return get_cgroup_id_from_path(cgroup_workdir);
 }
+
+/**
+ * get_cgroup1_hierarchy_id - Retrieves the ID of a cgroup1 hierarchy from the cgroup1 name
+ * @cgrp_name: The cgroup1 name, which can be retrieved from /proc/self/cgroup.
+ */
+int get_cgroup1_hierarchy_id(const char *cgrp_name)
+{
+	char *c, *c2, *c3, *c4;
+	bool found = false;
+	char line[1024];
+	FILE *file;
+	int i, id;
+
+	if (!cgrp_name)
+		return -1;
+
+	file = fopen("/proc/self/cgroup", "r");
+	if (!file) {
+		log_err("fopen /proc/self/cgroup");
+		return -1;
+	}
+
+	while (fgets(line, 1024, file)) {
+		i = 0;
+		for (c = strtok_r(line, ":", &c2); c && i < 2; c = strtok_r(NULL, ":", &c2)) {
+			if (i == 0) {
+				id = strtol(c, NULL, 10);
+			} else if (i == 1) {
+				if (!strcmp(c, cgrp_name)) {
+					found = true;
+					break;
+				}
+
+				/* Multiple subsystems may share one single mount point */
+				for (c3 = strtok_r(c, ",", &c4); c3;
+				     c3 = strtok_r(NULL, ",", &c4)) {
+					if (!strcmp(c, cgrp_name)) {
+						found = true;
+						break;
+					}
+				}
+			}
+			i++;
+		}
+		if (found)
+			break;
+	}
+	return found ? id : -1;
+}
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing/selftests/bpf/cgroup_helpers.h
index e71da4e..a80c417 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -20,6 +20,7 @@ int write_cgroup_file_parent(const char *relative_path, const char *file,
 int create_and_get_cgroup(const char *relative_path);
 void remove_cgroup(const char *relative_path);
 unsigned long long get_cgroup_id(const char *relative_path);
+int get_cgroup1_hierarchy_id(const char *cgrp_name);
 
 int join_cgroup(const char *relative_path);
 int join_root_cgroup(void);
-- 
1.8.3.1


