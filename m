Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAD27CC394
	for <lists+cgroups@lfdr.de>; Tue, 17 Oct 2023 14:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbjJQMqX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Oct 2023 08:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbjJQMqU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Oct 2023 08:46:20 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC1FFF;
        Tue, 17 Oct 2023 05:46:18 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b3c2607d9bso3118552b3a.1;
        Tue, 17 Oct 2023 05:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697546778; x=1698151578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ScFjSx13keQbjWIXpryCpmHFOUoMyEMo4B+madkUMA=;
        b=dcH7AbgdxwMg0+hkB1bkRpP0AdoDHRcaOLoWiqyXvyKsF44t1lYsLQ7GBVEjmS2zMd
         DPMpOweo6P8/Tcwxksk73bQQzabdMLYoyiQFEqzARY/kPrPE0bTF67YTdGd3nTqSPqfA
         axJ7SLJfuu2/w5Kb2Qx8r4JZnlS5xOcChL8uBvl4QXpxDQkwtlDpCJ9gUa0nJJXb7Mj7
         UweBYGQ/ce+LjqjdB3rewxKekINGrQQHCdUIUahgZg5wd6yrVHXKeBi+qnWDJvRTIGQG
         Yh9uisRbqZqjcyLe6t6jsxluS89IAXafKEafJ2kqjEYNo9BF2LYVpf70l8EEbJDSoxW0
         pUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697546778; x=1698151578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ScFjSx13keQbjWIXpryCpmHFOUoMyEMo4B+madkUMA=;
        b=mglpkdBBFnznTDsvGHDK52Na+UO1p+sOW/V+8Bxak7/yZdezfDX2WjSdH5lgKMYYuM
         aYcRECmKD3l7sT7I14OFPDeTbIZ5b9jYThd3vEX2/ZLLDXSGFdADlYHl5+MgioQFSNQz
         qYGj2sKMRV8UweqgW61uJQOJ3X1wh59y3XWyID9WtJBXSikPHY8tfDPQlMPdvrMl0NZq
         jpIC+Su+n5vrzrezFi8XZbvqz1ck0MJhFGargTXghtoCDAX72IehRdENfOCEZN3u/i5j
         S+oECdvsOShGXIhrTkMudVb47ouHpfJ929ZWOtsppf+SsvujpmqqLfwpKyYaSHTu0hHA
         Fw4Q==
X-Gm-Message-State: AOJu0YyECPtWnh5k7jyGi71daHJnOy1wqIOAOE+IxE2yU5qZyfH2vMiV
        JfCN6WLRH3LJRLZ1b/CYmB4=
X-Google-Smtp-Source: AGHT+IG+g9A/brY625ZLFiD9hLOcpzFfvYR0FeMmul/GTCkG4bkWbAknBGpd1JYarGEVJpQk/Rkf6Q==
X-Received: by 2002:a05:6a00:1a51:b0:6ad:535e:6ed9 with SMTP id h17-20020a056a001a5100b006ad535e6ed9mr2034837pfv.16.1697546778152;
        Tue, 17 Oct 2023 05:46:18 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:3b2:5400:4ff:fe9b:d21b])
        by smtp.gmail.com with ESMTPSA id fa36-20020a056a002d2400b006bdf4dfbe0dsm1375595pfb.12.2023.10.17.05.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:46:17 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        mkoutny@suse.com, sinquersw@gmail.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next v2 8/9] selftests/bpf: Add a new cgroup helper get_cgroup_hierarchy_id()
Date:   Tue, 17 Oct 2023 12:45:45 +0000
Message-Id: <20231017124546.24608-9-laoar.shao@gmail.com>
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

A new cgroup helper function, get_cgroup1_hierarchy_id(), has been
introduced to obtain the ID of a cgroup1 hierarchy based on the provided
cgroup name. This cgroup name can be obtained from the /proc/self/cgroup
file.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 49 ++++++++++++++++++++
 tools/testing/selftests/bpf/cgroup_helpers.h |  1 +
 2 files changed, 50 insertions(+)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 63bfa72185be..d75bb875ef03 100644
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
index e71da4ef031b..a80c41734a26 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -20,6 +20,7 @@ int get_root_cgroup(void);
 int create_and_get_cgroup(const char *relative_path);
 void remove_cgroup(const char *relative_path);
 unsigned long long get_cgroup_id(const char *relative_path);
+int get_cgroup1_hierarchy_id(const char *cgrp_name);
 
 int join_cgroup(const char *relative_path);
 int join_root_cgroup(void);
-- 
2.30.1 (Apple Git-130)

