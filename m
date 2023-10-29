Return-Path: <cgroups+bounces-109-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D067DAB1B
	for <lists+cgroups@lfdr.de>; Sun, 29 Oct 2023 07:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8357FB21409
	for <lists+cgroups@lfdr.de>; Sun, 29 Oct 2023 06:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B416F53A4;
	Sun, 29 Oct 2023 06:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgHVozCH"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E8C7494;
	Sun, 29 Oct 2023 06:14:58 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B06D3;
	Sat, 28 Oct 2023 23:14:57 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b3f6dd612cso2272249b6e.3;
        Sat, 28 Oct 2023 23:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698560096; x=1699164896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+813JukxzL+6wkyiKgmo5W2H4NKk3atr6arbVRyW+U=;
        b=IgHVozCH57atnvOPhX+3cWa66l0hLxJpu6rmjZ9JcXqS2MjUtnCVHiAvFzcFVt0Go6
         uq+kTHtZrYHDGAkXS1AtWPouYyMzqPMkO48oB9n04IAyczN+Dxk1WPPHOuMPW494xMdS
         8IozPCC0Hw3EC2jHIALcAPxe56s3LZqXZ1hkDURsGrnZe2Mxxem1GbdsawRN4HWmgRqH
         MmpUFOVq3jJj1Kwro4lFU6nUUVbIYOXz1vPU1c/MgWtH+OfzToaFgucpnkWuz6cSZtCT
         FHneKE4/iyMYIu2qHIvF8I2VChSA0wbL0Y3Hq3yj+8FTcBlIJe6arapYoCZUwFsDtaQl
         FddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698560096; x=1699164896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+813JukxzL+6wkyiKgmo5W2H4NKk3atr6arbVRyW+U=;
        b=KyHJIPs/fz372NpV1soNAw5wBqHY7PVWiP5ZwW2NaKcBoWsMjXpAoqpwtrQ2z3yynh
         eJy/rgycE9TkljKewfLfWOpNxIaJod2ToK3Ggy+M//VIpdsFy6qXjQcAFr0BX8mi+h53
         igo4iK/J1rGZyEFzGUAf5ErKiyKGQs/VsQG+zdLzizFV5fZhDOEQC4AfcEz3xlKi2B3b
         TBzDBTLnWsQyTTkPUt6vu94Bf4S/moDjgfdy6npWQ1LT/5TjFHrF5F6g5k4rDgz7LkQN
         pMl8bdhcVNqP7HlmD9ZmioIH7/zJEd3TRwdcKMd6trRToYsoqLRB8YdrGAAOtEF/Ri//
         U3kQ==
X-Gm-Message-State: AOJu0YwXgqfmxLWe5eNmRIvXIHxGyYo24TGnPFAp5sjTxKh3qbvck/3j
	Pz6xgvEokGscZTy/tvWT5bM=
X-Google-Smtp-Source: AGHT+IEqGHX/nd0eOkGIV3mum7IyRHIYm3fEGFoFZe1TEGey7bK9yTLipeCRTWQzXmmxxQymdArURA==
X-Received: by 2002:a05:6808:1a13:b0:3b2:ea7c:c402 with SMTP id bk19-20020a0568081a1300b003b2ea7cc402mr9026932oib.25.1698560096250;
        Sat, 28 Oct 2023 23:14:56 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:2b5:5400:4ff:fea0:d066])
        by smtp.gmail.com with ESMTPSA id m2-20020aa79002000000b006b225011ee5sm3775106pfo.6.2023.10.28.23.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 23:14:55 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 06/11] bpf: Add a new kfunc for cgroup1 hierarchy
Date: Sun, 29 Oct 2023 06:14:33 +0000
Message-Id: <20231029061438.4215-7-laoar.shao@gmail.com>
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

A new kfunc is added to acquire cgroup1 of a task:

- bpf_task_get_cgroup1
  Acquires the associated cgroup of a task whithin a specific cgroup1
  hierarchy. The cgroup1 hierarchy is identified by its hierarchy ID.

This new kfunc enables the tracing of tasks within a designated
container or cgroup directory in BPF programs.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/helpers.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 61f51de..f4cdeae 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2222,6 +2222,25 @@ __bpf_kfunc long bpf_task_under_cgroup(struct task_struct *task,
 	rcu_read_unlock();
 	return ret;
 }
+
+/**
+ * bpf_task_get_cgroup1 - Acquires the associated cgroup of a task within a
+ * specific cgroup1 hierarchy. The cgroup1 hierarchy is identified by its
+ * hierarchy ID.
+ * @task: The target task
+ * @hierarchy_id: The ID of a cgroup1 hierarchy
+ *
+ * On success, the cgroup is returen. On failure, NULL is returned.
+ */
+__bpf_kfunc struct cgroup *
+bpf_task_get_cgroup1(struct task_struct *task, int hierarchy_id)
+{
+	struct cgroup *cgrp = task_get_cgroup1(task, hierarchy_id);
+
+	if (IS_ERR(cgrp))
+		return NULL;
+	return cgrp;
+}
 #endif /* CONFIG_CGROUPS */
 
 /**
@@ -2528,6 +2547,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
+BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)
-- 
1.8.3.1


