Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E72790C6F
	for <lists+cgroups@lfdr.de>; Sun,  3 Sep 2023 16:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238512AbjICO2S (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 3 Sep 2023 10:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238363AbjICO2S (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 3 Sep 2023 10:28:18 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FCFFE;
        Sun,  3 Sep 2023 07:28:14 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-56c2e882416so233679a12.3;
        Sun, 03 Sep 2023 07:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693751294; x=1694356094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5k29RdSdgFGrpvgVrSsKwz4bkGSk589c/WSq1cJmNg=;
        b=UeRpMoL3RZo/I6HJpcYqS1LGiile/X+MgCuNlDOKMNRtUE6jqnjPceQQttncvAEK2+
         aYcJ8+J7L+V6f2gFhH+unfJ90KOwHhJRqPjeWjpyF5OVbadZkibzHnC1VzgZ4EOx5DGd
         m4EMWLXBON//VOBc3USZEo623Bt5+Qzf97HwkchdwJDhAQQ5lutidD1qGLm019WVnfU2
         hs38f59fE1QvY0MHvfFsn9vtiVoPC1B0IbLF9/O0Ll0u2bZceeAzR0pMF7iYsSyljDI7
         i/0ZPzjS7dz8G5d9ySjiPXB52qZiJ3PIqKqt1mii7arGXDPhTZm7V1rDrcF3W/SlwgIU
         MkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693751294; x=1694356094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5k29RdSdgFGrpvgVrSsKwz4bkGSk589c/WSq1cJmNg=;
        b=Kg8p7sMm0gRXM/2lGNUIpufIm6pLgvKsaGpFWXG0EVFmyMb3inY42+m1Dl/3SrmA73
         +GD9Q74vJdQXXCg/0XM+v2q1hGTDvhG2+B2Qnu/J0pSKG/Nqdt2FSiwPI4taUhStaDHT
         iOtjl54NOKjNZ1Ng94vuKdAUZZJWzEh6r5sCGZt+eZCYxFedcO4eHK38oZQQ3gKO9ZYm
         LjkuJJpTL8bqx68rXDRljYVZmHoem7/qiR3C067AtyDKoNE9mNz9Seh/8MgVPkuCTxOm
         QxjEJ0tNn8C0X7YJR11vpMoPwlp4kGDgI77gyokJAiYUBQvBH2gdMnOaKcZTvM3RcOYU
         93fg==
X-Gm-Message-State: AOJu0Yx2PHmBL6raMZF6k/jBcNssRe/qdF5zOUOdfUVRBq0WXRyngaUy
        ei11davpK3Izs8hY6HHQjw9XfmM/i3cVJejpO5M=
X-Google-Smtp-Source: AGHT+IEhqDvfZebErKX2mJ2WwUkV4KdTuuuwOqND+auGlH5Y9pn2RAyagPR8DzO2OiSjJEqrBrK08w==
X-Received: by 2002:a05:6a20:974f:b0:14c:f4e1:d9e9 with SMTP id hs15-20020a056a20974f00b0014cf4e1d9e9mr6207216pzc.45.1693751293727;
        Sun, 03 Sep 2023 07:28:13 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:185:5400:4ff:fe8f:9150])
        by smtp.gmail.com with ESMTPSA id b23-20020aa78117000000b0065a1b05193asm5809977pfi.185.2023.09.03.07.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 07:28:13 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 4/5] selftests/bpf: Add new cgroup helper open_classid()
Date:   Sun,  3 Sep 2023 14:27:59 +0000
Message-Id: <20230903142800.3870-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230903142800.3870-1-laoar.shao@gmail.com>
References: <20230903142800.3870-1-laoar.shao@gmail.com>
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

Add a new cgroup helper open_classid() to get the net_cls cgroup fd.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 16 ++++++++++++++++
 tools/testing/selftests/bpf/cgroup_helpers.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index f68fbc6..2631efe 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -578,6 +578,22 @@ int join_classid(void)
 }
 
 /**
+ * open_classid() - Open a cgroupv1 net_cls classid
+ *
+ * This function expects the cgroup work dir to be already created, as we
+ * open it here.
+ *
+ * On success, it returns the file descriptor. On failure it returns -1.
+ */
+int open_classid(void)
+{
+	char cgroup_workdir[PATH_MAX + 1];
+
+	format_classid_path(cgroup_workdir);
+	return open(cgroup_workdir, O_RDONLY);
+}
+
+/**
  * cleanup_classid_environment() - Cleanup the cgroupv1 net_cls environment
  *
  * At call time, it moves the calling process to the root cgroup, and then
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing/selftests/bpf/cgroup_helpers.h
index 5c2cb9c..ebc0513 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -31,6 +31,7 @@ int write_cgroup_file_parent(const char *relative_path, const char *file,
 /* cgroupv1 related */
 int set_classid(unsigned int id);
 int join_classid(void);
+int open_classid(void);
 
 int setup_classid_environment(void);
 void cleanup_classid_environment(void);
-- 
1.8.3.1

