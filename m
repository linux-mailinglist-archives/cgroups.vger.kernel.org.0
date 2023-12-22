Return-Path: <cgroups+bounces-1002-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E588881C92A
	for <lists+cgroups@lfdr.de>; Fri, 22 Dec 2023 12:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15CF71C22034
	for <lists+cgroups@lfdr.de>; Fri, 22 Dec 2023 11:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B000818026;
	Fri, 22 Dec 2023 11:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ni+csEIm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7D11799C;
	Fri, 22 Dec 2023 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d4006b2566so12237475ad.0;
        Fri, 22 Dec 2023 03:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703244689; x=1703849489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8ReL94+1J2Km8fxOMN39ro4uY5rbcX49qP5BtDfN9o=;
        b=ni+csEImDN7lbTsC+BfaV20GUZJj7aLaRQ1QcdyseBz5AIAPySVEQeVIOgq2EuX91v
         xEBaqj42uxdI3aY/qWliG0VrNcqvW+XqdQ7TnyCfgHCwUDc7AEoY4NEKpHgZzS8DqqDf
         uAlfvXxwd15bCPoEP6TBpOzKMUyCvPTb9NCmiDb4Zyj9N43spMsmXifDMbIV/RCGJnrF
         u/SYMcLpSXzZHbs4ntPipsNGPtincllU1lR2vpHLW+RRv++ezI0BDW/vt11Qr7jnn8j1
         P50ZaxwSMi5OhsmsXkDlzUCCQIxqQpm/MpgizjmQhDhXK3vj+pGz39qORFNXsJ52LWMa
         BGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703244689; x=1703849489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8ReL94+1J2Km8fxOMN39ro4uY5rbcX49qP5BtDfN9o=;
        b=KtPGUhNW/3zkvbjCWgW6TXMegVJaVlUCakVWmIh535J97Ff1Fa9j9JElGnsnRyfovz
         xC8JS1dNcMpLmGFtc+vmICrEHwGo9ZeCfSgPidVq1E7OYj/Jpf9eNF6gYQoij2IzAPwj
         u9/q8B2H+2VHz0lYFRRbDvN5RV4RqPQdz0cZ4BjhCLgKY7H/jaNH+dkji8I6v42qWfsd
         Tr0mM1pQpIL9uUAiodIcj5+x7oq9YNNFQxIshNat8dfhvpr5kVnb/sm5WDOj2+5NcYbB
         eXSjvcGo37Svd3VtZq9pnTlsL/q62RDTcHSQB/9yGSirdbbaismQtyt2AP7/R9dJO00p
         wKdw==
X-Gm-Message-State: AOJu0YyUwij3YEuBSIVDPawiZlRwpBfW2BUYoLBgnLg6waFbljAjlWMR
	Tesw1X4pxEG3XuqzESBX+SAxZR2MfC2f7PTu
X-Google-Smtp-Source: AGHT+IEYipyMRvrOfg+KaZXwmbkV5rS1Wir67z+xaTlnD7FXh6zNgVXpdkyEmtdvdgcO/Cf0oV9zQQ==
X-Received: by 2002:a17:903:2442:b0:1d4:11a8:a2a8 with SMTP id l2-20020a170903244200b001d411a8a2a8mr947393pls.57.1703244689575;
        Fri, 22 Dec 2023 03:31:29 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id l2-20020a170903244200b001d0cd9e4248sm3232881pls.196.2023.12.22.03.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 03:31:29 -0800 (PST)
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
	hannes@cmpxchg.org
Cc: bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 3/4] bpf: Add new kfunc bpf_cpumask_set_from_pid
Date: Fri, 22 Dec 2023 11:31:01 +0000
Message-Id: <20231222113102.4148-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231222113102.4148-1-laoar.shao@gmail.com>
References: <20231222113102.4148-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introducing a new kfunc: bpf_cpumask_set_from_pid. This function serves the
purpose of retrieving the cpumask associated with a specific PID. Its
utility is particularly evident within container environments. For
instance, it allows for extracting the cpuset of a container using the
init task within it.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/cpumask.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 4ae07a4..5755bb6 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -467,6 +467,22 @@ __bpf_kfunc void bpf_iter_cpumask_destroy(struct bpf_iter_cpumask *it)
 	bpf_mem_free(&bpf_global_ma, kit->cpu);
 }
 
+__bpf_kfunc bool bpf_cpumask_set_from_pid(struct cpumask *cpumask, u32 pid)
+{
+	struct task_struct *task;
+
+	if (!cpumask)
+		return false;
+
+	task = get_pid_task(find_vpid(pid), PIDTYPE_PID);
+	if (!task)
+		return false;
+
+	cpumask_copy(cpumask, task->cpus_ptr);
+	put_task_struct(task);
+	return true;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_SET8_START(cpumask_kfunc_btf_ids)
@@ -498,6 +514,7 @@ __bpf_kfunc void bpf_iter_cpumask_destroy(struct bpf_iter_cpumask *it)
 BTF_ID_FLAGS(func, bpf_iter_cpumask_new, KF_ITER_NEW | KF_RCU)
 BTF_ID_FLAGS(func, bpf_iter_cpumask_next, KF_ITER_NEXT | KF_RET_NULL | KF_RCU)
 BTF_ID_FLAGS(func, bpf_iter_cpumask_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_cpumask_set_from_pid, KF_RCU)
 BTF_SET8_END(cpumask_kfunc_btf_ids)
 
 static const struct btf_kfunc_id_set cpumask_kfunc_set = {
-- 
1.8.3.1


