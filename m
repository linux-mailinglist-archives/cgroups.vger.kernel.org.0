Return-Path: <cgroups+bounces-105-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A8B7DAB13
	for <lists+cgroups@lfdr.de>; Sun, 29 Oct 2023 07:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAF96B20E7B
	for <lists+cgroups@lfdr.de>; Sun, 29 Oct 2023 06:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273D66132;
	Sun, 29 Oct 2023 06:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ey0THoYh"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931275C8B;
	Sun, 29 Oct 2023 06:14:52 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C11CC;
	Sat, 28 Oct 2023 23:14:51 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b2f4a5ccebso2313940b6e.3;
        Sat, 28 Oct 2023 23:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698560091; x=1699164891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szve6xHz78YhCfEIrRy12Iw80pSpOk1k3LDcIqwnpCY=;
        b=ey0THoYhtT+vDQhv7l9oRiRTc08U3TCSMGxyyYXKQcTAV1FnjVQ5EMJgKiD+FitMvp
         b35P8Yi+SX8Yy6j7OyC3SxmGDYK4DLc0L47Lcw8Q+iHjLMkytiluz5Cgcy0B3+PdxNIN
         9F5JGjnZzmTkoqJxcSUtqU8ptugeoyXrSLzEKWA5bR76oNvTawxyC823fPtEzXhYYHXz
         2vQYM+EeIvi1tiu7hQ4UErsTuw/5pAOC9RDdTnZ31JgRTudPj1DkojmI0MeBjpFQJdYA
         ZeBmQG6IzjWkn3AJP3T4pQ4VccNSYYvRb+mONOTiEzIiZhKZr0YtTlQ6bqAdz49yTFuo
         ywYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698560091; x=1699164891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szve6xHz78YhCfEIrRy12Iw80pSpOk1k3LDcIqwnpCY=;
        b=uDnhfOFCbyWrAhiSA7xdAw2TpMWXJcmHyfpaq6huvvYmpbnl5cVxzSboG2A9X59gjq
         d7ud7yhKF+WtJMpKUP1yXpeLmALIFxfDWmOZe9v9ZRq6fAyw7Zs4N1kcLOzHBIQmNcAN
         McXr70Xrr4TPTfxQYkl7UpHAI3p7p/FhCH+PyGQGrRGXe6XWmp6lrQkZLv+h5T+TGdNy
         QrvkjL/O5ugMPCohaoucizLIzvy8U1D2CkPPxEVIXFW/IXDbSD/p/LOf9EnmOe2kzcWm
         nV8SvV7SreUC8Q2MawaWF0bYGidjMJ2h5FDm4nKzcfwkZf1jA73d6MNtUIRhgp7wPpTi
         ZFPw==
X-Gm-Message-State: AOJu0YyxtUutu/vC2ZF98BUSHhHxQgXCVCGzZgNGweQUQLqUVv/azsVF
	w9A39lfvDX+l3m48dT9JX24=
X-Google-Smtp-Source: AGHT+IEyTZFYEy7qBmUEhNNYew5E1crPltN4+TuI8/Q0arUz5hgvqRsbZESzpeqUn/E3847quGZZjA==
X-Received: by 2002:a05:6808:68a:b0:3a8:ccf0:103f with SMTP id k10-20020a056808068a00b003a8ccf0103fmr6997110oig.3.1698560090770;
        Sat, 28 Oct 2023 23:14:50 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:2b5:5400:4ff:fea0:d066])
        by smtp.gmail.com with ESMTPSA id m2-20020aa79002000000b006b225011ee5sm3775106pfo.6.2023.10.28.23.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 23:14:50 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 03/11] cgroup: Eliminate the need for cgroup_mutex in proc_cgroup_show()
Date: Sun, 29 Oct 2023 06:14:30 +0000
Message-Id: <20231029061438.4215-4-laoar.shao@gmail.com>
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

The cgroup root_list is already RCU-safe. Therefore, we can replace the
cgroup_mutex with the RCU read lock in some particular paths. This change
will be particularly beneficial for frequent operations, such as
`cat /proc/self/cgroup`, in a cgroup1-based container environment.

I did stress tests with this change, as outlined below
(with CONFIG_PROVE_RCU_LIST enabled):

- Continuously mounting and unmounting named cgroups in some tasks,
  for example:

  cgrp_name=$1
  while true
  do
      mount -t cgroup -o none,name=$cgrp_name none /$cgrp_name
      umount /$cgrp_name
  done

- Continuously triggering proc_cgroup_show() in some tasks concurrently,
  for example:
  while true; do cat /proc/self/cgroup > /dev/null; done

They can ran successfully after implementing this change, with no RCU
warnings in dmesg.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/cgroup/cgroup.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 28b8ccc..cc6a6d9 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6261,7 +6261,7 @@ int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
 	if (!buf)
 		goto out;
 
-	cgroup_lock();
+	rcu_read_lock();
 	spin_lock_irq(&css_set_lock);
 
 	for_each_root(root) {
@@ -6272,6 +6272,11 @@ int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
 		if (root == &cgrp_dfl_root && !READ_ONCE(cgrp_dfl_visible))
 			continue;
 
+		cgrp = task_cgroup_from_root(tsk, root);
+		/* The root has already been unmounted. */
+		if (!cgrp)
+			continue;
+
 		seq_printf(m, "%d:", root->hierarchy_id);
 		if (root != &cgrp_dfl_root)
 			for_each_subsys(ss, ssid)
@@ -6282,9 +6287,6 @@ int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
 			seq_printf(m, "%sname=%s", count ? "," : "",
 				   root->name);
 		seq_putc(m, ':');
-
-		cgrp = task_cgroup_from_root(tsk, root);
-
 		/*
 		 * On traditional hierarchies, all zombie tasks show up as
 		 * belonging to the root cgroup.  On the default hierarchy,
@@ -6316,7 +6318,7 @@ int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
 	retval = 0;
 out_unlock:
 	spin_unlock_irq(&css_set_lock);
-	cgroup_unlock();
+	rcu_read_unlock();
 	kfree(buf);
 out:
 	return retval;
-- 
1.8.3.1


