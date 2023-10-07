Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE207BC83E
	for <lists+cgroups@lfdr.de>; Sat,  7 Oct 2023 16:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344006AbjJGODa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Oct 2023 10:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344000AbjJGOD3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Oct 2023 10:03:29 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBBFCA;
        Sat,  7 Oct 2023 07:03:27 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c8a1541233so1359915ad.1;
        Sat, 07 Oct 2023 07:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696687407; x=1697292207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5sPylPqdXFTIzAaQ9WSlcqSNKIac6K+arZml60zhvo=;
        b=j93ymMmASoRSY5yq2xvcf7s4gov03A3Kt4xN3hnnkGokp4SpvXuJTrB4yilm6M+lfP
         vaTfP0txULmc7793RzbMUj3kRy3oRWoBeQoNWPi08IwpygmSqVNk2jikZnn1/aqzNKip
         fwN7awa0Kjjnsjv4Y5S9NyT3bJfmqERt38vS5NaXzpu8O/0RUklfGNaSveI7PUIfSODr
         4EoRoPQjsxusqQYEigEBkyb0tmSfMCchJUCPtU2svdjXR3VB+N3Lds15pVCehQKcr/kk
         2k245TqsluoYRpBmy/l0Hx6KFG9ecYIJN8rtMCUNnmKsL2AjkarXOE8n9GvyrGo0EVyn
         nOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696687407; x=1697292207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5sPylPqdXFTIzAaQ9WSlcqSNKIac6K+arZml60zhvo=;
        b=Rt2r7Cx4ESRNsLYw4CQrQQmN2Mqv7seAyKph/36/uJfZ6w9/x+S8fHfHZuHfpNx91d
         dJQHHL69xdoG8EGIVUVKBMl8bXGmp2e3+yi8ZHrjs5nXIWOCQq5JaDd/YCZ+cxq/RkWd
         jYfz3XV3prD/s05DszEszkoHU3aOIv7JbmQffnaWsbI9oCQD9ZDgT7LGKI2cYPyoBL6/
         1Evcuq+6dt2W4sB0FZKj7rstx0tHzyn2GRgSh6g2RjYdo/uCkfbtdFI/2YMHaxJtgYDf
         w9D47SJ2gOLfOniVfQViwGh3u3tu5gS8oP3xmjU1Wn36RbINqsjjvAEcJCmjMc1iBYXV
         nFkg==
X-Gm-Message-State: AOJu0YzfNXRkA+qb7syv0U71s0gLDXh+aWTE9aEiNZ0TUxuyUjV8GBM3
        OcpZtaSZykhNKSpnIur16rE=
X-Google-Smtp-Source: AGHT+IHeAl1Oob/Tzh52pWVkd6NU0MNoUXvXhk50P5AWi2y7lkZfZzrCUBCGLpu4cy1BiUy8Y4NBvw==
X-Received: by 2002:a17:902:6f02:b0:1b8:94e9:e7b0 with SMTP id w2-20020a1709026f0200b001b894e9e7b0mr9299064plk.9.1696687406812;
        Sat, 07 Oct 2023 07:03:26 -0700 (PDT)
Received: from vultr.guest ([45.77.191.53])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902f68d00b001c0a414695dsm5897550plg.62.2023.10.07.07.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 07:03:26 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        mkoutny@suse.com, sinquersw@gmail.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 7/8] selftests/bpf: Add a new cgroup helper get_cgroup_hierarchy_id()
Date:   Sat,  7 Oct 2023 14:03:03 +0000
Message-Id: <20231007140304.4390-8-laoar.shao@gmail.com>
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
index 7cb2c9597b8f..5cb66fb3d4fe 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -633,3 +633,52 @@ unsigned long long get_classid_cgroup_id(void)
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

