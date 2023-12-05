Return-Path: <cgroups+bounces-811-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB2080577A
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 15:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39FDD1F21668
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 14:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B89865ECC;
	Tue,  5 Dec 2023 14:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BB5bv2NK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208E61A5;
	Tue,  5 Dec 2023 06:37:39 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1d045097b4cso24915615ad.0;
        Tue, 05 Dec 2023 06:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701787058; x=1702391858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekSyLarJaffiQaG/xcCjvlR8oBT+CbiWi8Ns1BP2pvY=;
        b=BB5bv2NK4gxyt5AERSASSRSqsH6I17N9yq4hXmSaAp0SOg/TZf5u1aVi0TfiYYW1sa
         3VxoPa/0lWfSCm23JHJvxVltiu3pLWRyF5IX7q5R6Ggp4XnT1ch6fjNsJtuzDe0FV0QE
         bMtC0V9PRAfyU0nG8xGySGBeWfetR0pbbWQY7JP5NWLDKM3iS3HVizkBRH73orLLnyzB
         O8WHUPCn6ui0icMRvw+EBuNKy4pqQqwAMNLPf4TxirSAdkETvaDZTWNhV4b79jLVtUXD
         j9Zn/snIFXuUZHRX3BhjrE46k7SQPj5Yr23w9H/GszM8wQiGWglT8DNmZZG/TOJVWsBW
         gTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701787058; x=1702391858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekSyLarJaffiQaG/xcCjvlR8oBT+CbiWi8Ns1BP2pvY=;
        b=q2LbErbL+DXmHBnZ+DFWPuhtn6/sIs9duW2uKpZ7HorT00XNGcW9ejBIO0vnb+B13J
         HFtIrnoKHsh02qP0caVfmcvGqoLLc2/ACasW4X1x3RDSyvS/w6hvMHtE2QeaYYNOOUo6
         CeewJTp0hAAglonN2mAt2QPHk1XdOSId4anzn97SkYt6oPPKcK382aJP6N7IhiyQJlSk
         0FmwWUJZeZGE5r1fVevP9sBBmKYzCCIl61MeTSRQux+12rUsyDHkaBjml7/70c0gUrOk
         zs+h/GUKW5lNrJUtVmcgvDaNtb2VHaNNSx25a7GyMP9REARbQcWw71vjqAqOerKrH1vi
         eItw==
X-Gm-Message-State: AOJu0YxiZ3L4ifV+wXTpu6rrNPh9xBmK9FcexQrs2QtkjpvkUG91Ie9g
	z7TyYuG0bob2bmXsdDjZ7ZNsp3Z0/N8sNsRr
X-Google-Smtp-Source: AGHT+IHTKw625iUUw0solv/euxMQs+IDrrm2lQDsYYG/jze8ll5qJc8JArmLCYfmu3u3bVFXMzDmxg==
X-Received: by 2002:a17:902:d652:b0:1d0:ab0e:9157 with SMTP id y18-20020a170902d65200b001d0ab0e9157mr2260578plh.128.1701787058537;
        Tue, 05 Dec 2023 06:37:38 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id g9-20020a1709026b4900b001a9b29b6759sm10286502plt.183.2023.12.05.06.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 06:37:38 -0800 (PST)
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
Subject: [RFC PATCH bpf-next 2/3] selftests/bpf: Add a new cgroup helper open_classid()
Date: Tue,  5 Dec 2023 14:37:24 +0000
Message-Id: <20231205143725.4224-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231205143725.4224-1-laoar.shao@gmail.com>
References: <20231205143725.4224-1-laoar.shao@gmail.com>
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
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 16 ++++++++++++++++
 tools/testing/selftests/bpf/cgroup_helpers.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 5aa133bf3688..19be9c63d5e8 100644
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
index ee053641c026..502845160d88 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -33,6 +33,7 @@ void cleanup_cgroup_environment(void);
 int set_classid(void);
 int join_classid(void);
 unsigned long long get_classid_cgroup_id(void);
+int open_classid(void);
 
 int setup_classid_environment(void);
 void cleanup_classid_environment(void);
-- 
2.30.1 (Apple Git-130)


