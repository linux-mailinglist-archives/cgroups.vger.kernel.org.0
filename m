Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505127AB0AD
	for <lists+cgroups@lfdr.de>; Fri, 22 Sep 2023 13:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbjIVL33 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Sep 2023 07:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbjIVL30 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Sep 2023 07:29:26 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945CECA;
        Fri, 22 Sep 2023 04:29:19 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3ade77970a9so1291683b6e.2;
        Fri, 22 Sep 2023 04:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695382159; x=1695986959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fo3tjZPZMMIDp299nbsdxVbUIehDi8P0BDIlhn8r2cE=;
        b=bqey7blFBsajX1oh/B3VPkSLskhlkVz2shtcVXekEe0x4z86TqTuFoeyJY1DOFYbIF
         /jXUAV/LVKOzq/fsN8yVNFzSg5oW0ci1oGAuIe5AalvDjsP2vXEKusx4CQAZdS+t8XfV
         d6QXVfuRy3f9HxYConVLRuoPlO1bkobEJENdX8WFde+8n1IOb+8LFZvFxF3J3RETq6eG
         RrjWUrjc6nIhatc0MLX2QSaK8+yPgg4bOPGSjSBZG9G8ZLiMhvq4yo9dwr/yy3OxoPYX
         aVop/U+a4Vq4gvADNZ9q0kRy/9ayRGyR5wlTHDyZyPtXDe+YV3fDFa/Ux7z4gvMSoXgf
         E+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695382159; x=1695986959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fo3tjZPZMMIDp299nbsdxVbUIehDi8P0BDIlhn8r2cE=;
        b=iQ2zYSI1G6HAhWjdLfgz6pLsenbQQdw4PPbfNouN2NpRGP1UiFJ3rjhuIauG/3UjfG
         r4b4iFS0i5SC9iRHwDS85gJwqj+dTbpnbEee7qiqckpytX7fI5o5965dPpgO3qI5sT55
         QbZr1jg31iPh6VwRV38UuuYJbJzl1cW9zgizlTw+7Rnpfgh9UD9cv5U1GqfFSpUxYDaH
         +IajOF997+gP+djEwSWP1XjwbfQ7zmqq+mQjLXdPKdv0UQjR4pyhREoIVNYx7GvZy/WG
         HccgahjccTJm+l8zUgRg4p8j/kh9hfado5gNpVvx2rcefEKweUdO96qF0RMVkWbDNq3B
         WuMA==
X-Gm-Message-State: AOJu0YwgzN9BSMlgBbunpB8Y0QUvWdq8CRAI3JUdRCDiprg5FT0qCidm
        NTyo4Y17h8IQsmUmevI0oZXFkazoGR8T298oiEg=
X-Google-Smtp-Source: AGHT+IG0Q660G5/8V7hq1GiOucPozd2atxCB8a3VEnE8GGbUbWNkWTZEC3o3BzoViU2+fA5TJepl9A==
X-Received: by 2002:a05:6808:b37:b0:3a1:e85f:33c3 with SMTP id t23-20020a0568080b3700b003a1e85f33c3mr8121749oij.50.1695382158820;
        Fri, 22 Sep 2023 04:29:18 -0700 (PDT)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id v16-20020aa78090000000b00690beda6987sm2973493pff.77.2023.09.22.04.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 04:29:18 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        mkoutny@suse.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 7/8] selftests/bpf: Add new cgroup helper get_classid_cgroup_id()
Date:   Fri, 22 Sep 2023 11:28:45 +0000
Message-Id: <20230922112846.4265-8-laoar.shao@gmail.com>
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

Introduce a new helper function to retrieve the cgroup ID from a net_cls
cgroup directory.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 28 +++++++++++++++-----
 tools/testing/selftests/bpf/cgroup_helpers.h |  1 +
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index e378fa057757..7cb2c9597b8f 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -417,26 +417,23 @@ int create_and_get_cgroup(const char *relative_path)
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
@@ -472,6 +469,14 @@ unsigned long long get_cgroup_id(const char *relative_path)
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
 
@@ -617,3 +622,14 @@ void cleanup_classid_environment(void)
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
index 92fc41daf4a4..e71da4ef031b 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -31,6 +31,7 @@ void cleanup_cgroup_environment(void);
 /* cgroupv1 related */
 int set_classid(void);
 int join_classid(void);
+unsigned long long get_classid_cgroup_id(void);
 
 int setup_classid_environment(void);
 void cleanup_classid_environment(void);
-- 
2.30.1 (Apple Git-130)

