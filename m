Return-Path: <cgroups+bounces-866-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1F1806F40
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 12:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D272E1F21587
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 11:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3748E3588C;
	Wed,  6 Dec 2023 11:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmSKk7RH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94041BD7;
	Wed,  6 Dec 2023 03:53:39 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-35d57e88c1dso19129375ab.2;
        Wed, 06 Dec 2023 03:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701863619; x=1702468419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xIMBRdh82imgCh973bdcamdD/YLqs+vICvueMisFQc=;
        b=VmSKk7RHxfAGfx0Yz/gvKA9tjufJMGJhEIftHn2WP3FXTmqzwEb66swj5VPirsLZlb
         +j+VhUeupyHi7zf2CKPIQUSuODvN23dsst/1Oye36VWr6MA1mcYOxNbcCGhUrPJZhjCM
         j52X6+0Y5pehWjmZzM0Xh6vJvIvxbQKD9pYPfm38pATQ1KoQ+5CwHdYnLEua0YtYNPUJ
         fcC7ygogMiPLiObt9x4pNMkkZ7urpI2b2fzrUCAAU4TzkyRyWNBeIlslWFe6kvZ/Whvf
         ld9LH+FOAiOeYI+0Zdq8xVGK8h+pGXzHBS1352JclLHXdK1cmJGPW6qAfuLw48ZQQoMT
         ZimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701863619; x=1702468419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xIMBRdh82imgCh973bdcamdD/YLqs+vICvueMisFQc=;
        b=jvD7z5Rh4eFpIi0KjWZ1w9k4wuDUTfyzCpdHOOl70SgwXccXYWDaSewQDfcwp9MK2v
         s0MBTcXmkHgXhRiM2lg95G5h4qb/ohKCER0jP3JclRWrUg9Ru2vL9QBF6GadCcX17bf4
         qDTk26fShCckK6swTjXSMFtgZqaPA8yAHpahpMdC/GQiar0s2j9E9QLV4Z/vUAMZ+s2y
         nzloy6ghSPgR7RFYnp7l1tDah2zYsh6sp/ZzvA5B1C7XUTihdp5XCBcOawv8R/fIyE/i
         BXxZK7qchBXBfD/FKLHspRbhVdJIMiL9U40kbTjPRNewWOSXf5R8sLnEI6OhtLgbm/Mh
         rPTQ==
X-Gm-Message-State: AOJu0Yy9LnS8DXTK+lBV5E56LiVl/LrVYC11SzmfKcjtXgzHzUI0BMso
	41ELSfWhSyZ19q46Re2dDws=
X-Google-Smtp-Source: AGHT+IFmyUtIFQyTLGY/estMEYNpl0cpZDFzVOq9R39UkG1aP5kdgy5VEaxsAaX//S/i35tj75ak7A==
X-Received: by 2002:a92:d8c1:0:b0:35c:cc4c:e01f with SMTP id l1-20020a92d8c1000000b0035ccc4ce01fmr786066ilo.6.1701863619221;
        Wed, 06 Dec 2023 03:53:39 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id n15-20020a638f0f000000b005c6801efa0fsm5484665pgd.28.2023.12.06.03.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 03:53:38 -0800 (PST)
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
	tj@kernel.org
Cc: bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 2/3] selftests/bpf: Add a new cgroup helper open_classid()
Date: Wed,  6 Dec 2023 11:53:25 +0000
Message-Id: <20231206115326.4295-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231206115326.4295-1-laoar.shao@gmail.com>
References: <20231206115326.4295-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This new helper allows us to obtain the fd of a net_cls cgroup, which will
be utilized in the subsequent patch.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 16 ++++++++++++++++
 tools/testing/selftests/bpf/cgroup_helpers.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 5aa133b..19be9c6 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -689,3 +689,19 @@ int get_cgroup1_hierarchy_id(const char *subsys_name)
 	fclose(file);
 	return found ? id : -1;
 }
+
+/**
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
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing/selftests/bpf/cgroup_helpers.h
index ee05364..5028451 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -33,6 +33,7 @@ int write_cgroup_file_parent(const char *relative_path, const char *file,
 int set_classid(void);
 int join_classid(void);
 unsigned long long get_classid_cgroup_id(void);
+int open_classid(void);
 
 int setup_classid_environment(void);
 void cleanup_classid_environment(void);
-- 
1.8.3.1


