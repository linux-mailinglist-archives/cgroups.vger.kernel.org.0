Return-Path: <cgroups+bounces-1001-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECDF81C929
	for <lists+cgroups@lfdr.de>; Fri, 22 Dec 2023 12:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD570B228D5
	for <lists+cgroups@lfdr.de>; Fri, 22 Dec 2023 11:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0E01799F;
	Fri, 22 Dec 2023 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aY3Vxn7p"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA1F168BC;
	Fri, 22 Dec 2023 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso814475a12.1;
        Fri, 22 Dec 2023 03:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703244688; x=1703849488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FILKqWyqIiavqH8ypkh2gf0s6Zxy37+BTc5NQsH74I8=;
        b=aY3Vxn7pT8OnE1OAZ1bkMhWsnCvkMMmL3zrou77ndXcIDNyJ7QbZXfx+ataPxIb7DD
         lhqtiokJiGsngii+c0NssXpAl6wijKeFc+dDtde2dMDJFDXw8Si955F8fkVRL2LWWxaq
         JybCUwKY69PilDsgYXo0zuuzEjEOhfKKIHmNrj40ZoMD2zXRNnry1STV1ZECgjF57tmn
         /aBR4zfzr2zs3cTrDSRqfrrMfTcTsA0KjCuyGEtfrtX2xDzA/IIuJwW+yq54y/A9eBUi
         dthugInptENBriMs0NNXbS/vJBNXS+7+WYAW+PXnoc5QYWz9wXuSXbrjBpVu5Yds09Fr
         ivLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703244688; x=1703849488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FILKqWyqIiavqH8ypkh2gf0s6Zxy37+BTc5NQsH74I8=;
        b=q/F596ZnC0kphNPA/kqh2Y72etkLMM6S06x0qUk9T/KRqfKwJAXQxs4HwUQMd2bIpt
         De9rfBfLd4COfIXTG+Oykb9xqe0Im7NngP9TgdIHBLVsQjzTndr0iFw8yV1wiQXA0PNx
         R/w1hwqPC12kSyIT+hwxzKHoyWFOMjDY3TfUa97sTV7uVX4OeDemWn70+qv+r0WPyuAy
         J/+fPNXkhbpcIK8VdhyrF2lhsu1Z8hVfKpDiyblBcbkewspW0eH2nWjCoxJqv+yIU0Gq
         bpmb6J8CgvGkHc4bzbWeGSZwKk2MsL2Oy5iWAM1KT6SIYB6YrpCSv2uqzjPLKOXOGssg
         nElQ==
X-Gm-Message-State: AOJu0YwwvbIbrGWCPbE5DehYSwYm/ss3eUKReT9G/qNYX517PjNWmlGm
	+9mJBqiZfuc43Mzx3N86oPw=
X-Google-Smtp-Source: AGHT+IFL4hvIY9KoPwp0JaVTXEqgl6vFXXxYdBiD0wSyKmUSnK2VpTwOZ426A6fuz1mvnI1TWXasOQ==
X-Received: by 2002:a17:902:b58b:b0:1d0:8303:216 with SMTP id a11-20020a170902b58b00b001d083030216mr844479pls.95.1703244688214;
        Fri, 22 Dec 2023 03:31:28 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id l2-20020a170903244200b001d0cd9e4248sm3232881pls.196.2023.12.22.03.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 03:31:27 -0800 (PST)
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
Subject: [PATCH bpf-next 2/4] bpf: Add bpf_iter_cpumask kfuncs
Date: Fri, 22 Dec 2023 11:31:00 +0000
Message-Id: <20231222113102.4148-3-laoar.shao@gmail.com>
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

Add three new kfuncs for bpf_iter_cpumask.
- bpf_iter_cpumask_new
- bpf_iter_cpumask_next
- bpf_iter_cpumask_destroy

These new kfuncs facilitate the iteration of percpu data, such as
runqueues, psi_cgroup_cpu, and more.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/cpumask.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 2e73533..4ae07a4 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -422,6 +422,51 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cpumask *cpumask)
 	return cpumask_weight(cpumask);
 }
 
+struct bpf_iter_cpumask {
+	__u64 __opaque[2];
+} __aligned(8);
+
+struct bpf_iter_cpumask_kern {
+	struct cpumask *mask;
+	int *cpu;
+} __aligned(8);
+
+__bpf_kfunc u32 bpf_iter_cpumask_new(struct bpf_iter_cpumask *it, struct cpumask *mask)
+{
+	struct bpf_iter_cpumask_kern *kit = (void *)it;
+
+	kit->cpu = bpf_mem_alloc(&bpf_global_ma, sizeof(*kit->cpu));
+	if (!kit->cpu)
+		return -ENOMEM;
+
+	kit->mask = mask;
+	*kit->cpu = -1;
+	return 0;
+}
+
+__bpf_kfunc int *bpf_iter_cpumask_next(struct bpf_iter_cpumask *it)
+{
+	struct bpf_iter_cpumask_kern *kit = (void *)it;
+	struct cpumask *mask = kit->mask;
+	int cpu;
+
+	cpu = cpumask_next(*kit->cpu, mask);
+	if (cpu >= nr_cpu_ids)
+		return NULL;
+
+	*kit->cpu = cpu;
+	return kit->cpu;
+}
+
+__bpf_kfunc void bpf_iter_cpumask_destroy(struct bpf_iter_cpumask *it)
+{
+	struct bpf_iter_cpumask_kern *kit = (void *)it;
+
+	if (!kit->cpu)
+		return;
+	bpf_mem_free(&bpf_global_ma, kit->cpu);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_SET8_START(cpumask_kfunc_btf_ids)
@@ -450,6 +495,9 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cpumask *cpumask)
 BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_weight, KF_RCU)
+BTF_ID_FLAGS(func, bpf_iter_cpumask_new, KF_ITER_NEW | KF_RCU)
+BTF_ID_FLAGS(func, bpf_iter_cpumask_next, KF_ITER_NEXT | KF_RET_NULL | KF_RCU)
+BTF_ID_FLAGS(func, bpf_iter_cpumask_destroy, KF_ITER_DESTROY)
 BTF_SET8_END(cpumask_kfunc_btf_ids)
 
 static const struct btf_kfunc_id_set cpumask_kfunc_set = {
-- 
1.8.3.1


