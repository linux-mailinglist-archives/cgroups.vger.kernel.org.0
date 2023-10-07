Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C947BC83C
	for <lists+cgroups@lfdr.de>; Sat,  7 Oct 2023 16:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343994AbjJGOD1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Oct 2023 10:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344008AbjJGOD1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Oct 2023 10:03:27 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D40CF;
        Sat,  7 Oct 2023 07:03:25 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c5ff5f858dso23182505ad.2;
        Sat, 07 Oct 2023 07:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696687405; x=1697292205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fo3tjZPZMMIDp299nbsdxVbUIehDi8P0BDIlhn8r2cE=;
        b=TfAZfiWWKHBmQY6e6w8KLDIVEZHt8uYIsJN9P4scNiV8mFWYdSWSG3BYlt5qJo+1/h
         m7SIW3VNnICg4cfWUdgLco/ivXOhdA+o4XOXNLQElZSfID1STqhi0WFlN29SawCKaOE9
         clTtHdk+FqrOdi2oEaeEWzQiezc428Qj53n+xge81jvYjkhX0cfj+HC0MTI+tRWokw7v
         sCHgKTzjAlEag6j1d+xXeaEfNxBC/qY/fHZoj0qfctpBzt5n7KuIsiif5sApXturvYzN
         MTlG6/aDadWAOsKSZf/fdGFxMIRYhc4O7t37kgKhQwFAHILOtV926tOi1VhSn3UZtW8P
         Bkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696687405; x=1697292205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fo3tjZPZMMIDp299nbsdxVbUIehDi8P0BDIlhn8r2cE=;
        b=faKa/msagCEcrGmskGAZ8GD1IGpr4HBIbvYP2yMSBGrHXSTL+Grh7XHHZSmD7wBik8
         37tV9wbQ5KDBeCg5ac+B1WCUbvwN+BqNwsfsV5cSKk3BU9i8eaA4LJG4BUyIqdsIownE
         AaVwxoGLE886bZOryoElmzEupM0OnsQGsv1Bddz/aPqdJQuvcdaaUWrxwlTRe1qNwQH4
         AJYLF+CEe6AOt5j/zC+K99QKmXit3VIRhlAIwaQ3IafHHUY7hUMCWmiU/HCD7wf2MYDr
         7HHVgPDSgAcdafJvBJHGwVUzdZ+/qqUmmaMfpT51eCznMtaHmSy/P647ZKn5TGyzamwx
         3h3Q==
X-Gm-Message-State: AOJu0YxaEAnW1krS2zpnbSoMjakYkZ2UWgyhISshfmZaAfT/jda2Us5K
        2ooccLYS5Pssgul2Cje/o1U=
X-Google-Smtp-Source: AGHT+IF8+lxyYtEXmACREetEG767x7KHyYq5G7BDTGM2JGM4lrA2gisSMki2ek3tbEFsDs1D4r3ERw==
X-Received: by 2002:a17:903:32cb:b0:1c5:ea60:85c5 with SMTP id i11-20020a17090332cb00b001c5ea6085c5mr12000997plr.2.1696687405076;
        Sat, 07 Oct 2023 07:03:25 -0700 (PDT)
Received: from vultr.guest ([45.77.191.53])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902f68d00b001c0a414695dsm5897550plg.62.2023.10.07.07.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 07:03:24 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        mkoutny@suse.com, sinquersw@gmail.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 6/8] selftests/bpf: Add a new cgroup helper get_classid_cgroup_id()
Date:   Sat,  7 Oct 2023 14:03:02 +0000
Message-Id: <20231007140304.4390-7-laoar.shao@gmail.com>
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

