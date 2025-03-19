Return-Path: <cgroups+bounces-7186-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF622A69BF5
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 23:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F6F8A3F32
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 22:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A3921C17B;
	Wed, 19 Mar 2025 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wwvg2MUx"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCE421B9F8
	for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742422921; cv=none; b=jjwPQDiHt/P0fGW1HUBcfvuSzdNCHMUjrJhjq2kKqUbdihUA/lrk/TM07TCmx3iI4sdoaKDDdAfcfESAVzo4GSNjcX6GQuCOcJ1gLdlvjG4rHoVcCithQl68R2k/RNDevZq7FYeNPX00smj01e78A8Oi7mew2KBBewMnXgHJ5Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742422921; c=relaxed/simple;
	bh=c42ZwK2kFExIrHvJVlhy4T4qaaLzRsSU4wa7m+2FwNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCq/O7lGZBGNB2mkR0WNvPLTbDS5BTAOJg7O4Becm6LXfjAAF7OgEvWIdjb9Ka8JYpVYLV5nbnMvSuCN2aownEn5eW5DEgMUrLKVNGiGWsCcTsrIolKqAZSeqsnfQ8U6rOoF5krYjWQdDqm7/bXJ9QSc46LOkMHboSopgvk6XNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wwvg2MUx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2241053582dso1503095ad.1
        for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 15:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742422919; x=1743027719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+XAb5qZM9EJun3uRHZFaBgl2slfeKVEfwXubaUvgvQ=;
        b=Wwvg2MUxK24Gg6uMOXJCEG4u6DeM1gJe3xc4YOIqiyleolBqNz75u+x+GW/iASJFtW
         0GPfvDluH2tR62WHep9tvONRdefOmhfzHs5BoOJWzPch2Pgwth+Hw7m9HA6z2Hx35oul
         4tN31kGgs+Wm6tyFixMn3N9cnOX4XYqgGU9U7LIUI8JuWdLaoXkt4W0/2fZtM5Fu2t5L
         RX5sW6jk52cW8gJfBpqiozpiG1ieVvTiNco4ob4DN15vt5GJWUbQ9eo38LEM4fqZcoLB
         Gx8bD90vQs8DdTwtF63bcWHt/SemhlD79oWxKnfrnm63yuo+wQCQsiz/+qisqgSUIvl3
         TDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742422919; x=1743027719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+XAb5qZM9EJun3uRHZFaBgl2slfeKVEfwXubaUvgvQ=;
        b=bXGm2+KiaIe4JqxRtAdk+tqQDzs2gGQhbhskr40ec1IGRDsJzPxZPR0y7chkhCNi0U
         f7APQ7btId84d2q/yo1jS5i62J+WwNHYmtFPkK75/5I6Lte4j9o/Pm8qsFXK52V9hX+N
         OnYIY93sHZbHHCkcgFov6QAU9Xx9SfZTMdVU5+d2CocAmQ010Hmge27ALTa8EfJ6ICWy
         Df2CaJn52eoEEk13kKPMrkod6pDfOT8VWwKbLtsfoQikuXUDuWHSJ1uEGL4fkzpHyOvo
         pyOg/wMcO90+cetTGjB1l181BU+zVHWwZOI8zE8zExawJfNO52jDrKc7FfC2znicgEdH
         CVXw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ1ZNtq9rrsreIcusagL/Wnh7WPQsHyRNe08bKAUFoiflKk0hPTtJ14YyJW3oIBye0MTvPtuTs@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7CR8Ov9lTXe0R4meOo17k48aLndQ/TPMKGQEIGIfvIrU+jEv7
	AUC5F82I3aroUQz/Qt8LDb1E0muXGstRlLvt7QoHbL55898qMY3I
X-Gm-Gg: ASbGncvUZzA238Y6d1u9bYBtycnrtmm6Pa2VnfVBRqxOnQylxUOGMjEJ8NlLfzZj7wZ
	nOaUWF6K1BO0xFXFwwfLWcsS/87E/cfBK4M8QMZ5GDt9XtpbpjzQP90cgzUGeni8qO9So8hmeMt
	X3CXiZ0G6R7uvz+3+Sbbi5Hf8AsDWQWIPRnLV8he7HA0h6XPHl/IQBBLycerq0huSEnxo3uL5Gv
	7p6iatdXSHfv+Q67bC462CxzLHkom5nI6GSz0FogY76QI4fBLECKS031Gpa1jKFosytvCsYURxs
	nGSiVgbQqJlo3QQkKmBZeOsmF3xxHlCqyV9jNHYhJD23qvvTgIShWjl/hHNF9QyZaJbGLmMpPun
	qUAgj40c=
X-Google-Smtp-Source: AGHT+IHhffs21ubNbKbw8DD38vzkz2j2B8+UW1CCrWUaooj1n92Fo34tlPZHLmMVyTLWDrjn+85oJw==
X-Received: by 2002:a05:6a20:7346:b0:1f5:9330:29fe with SMTP id adf61e73a8af0-1fbeba8fdf1mr6705493637.17.1742422919143;
        Wed, 19 Mar 2025 15:21:59 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::4:39d5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9dd388sm11467484a12.20.2025.03.19.15.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 15:21:58 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: tj@kernel.org,
	shakeel.butt@linux.dev,
	yosryahmed@google.com,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 1/4 v3] cgroup: use separate rstat api for bpf programs
Date: Wed, 19 Mar 2025 15:21:47 -0700
Message-ID: <20250319222150.71813-2-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319222150.71813-1-inwardvessel@gmail.com>
References: <20250319222150.71813-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rstat updated/flush API functions are exported as kfuncs so bpf
programs can make the same calls that in-kernel code can. Split these API
functions into separate in-kernel and bpf versions. Function signatures
remain unchanged. The kfuncs are named with the prefix "bpf_". This
non-functional change allows for future commits which will modify the
signature of the in-kernel API without impacting bpf call sites. The
implementations of the kfuncs serve as adapters to the in-kernel API.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 include/linux/cgroup.h                        |  3 +++
 kernel/cgroup/rstat.c                         | 19 ++++++++++++++-----
 .../bpf/progs/cgroup_hierarchical_stats.c     |  8 ++++----
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index f8ef47f8a634..13fd82a4336d 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -692,6 +692,9 @@ void cgroup_rstat_flush(struct cgroup *cgrp);
 void cgroup_rstat_flush_hold(struct cgroup *cgrp);
 void cgroup_rstat_flush_release(struct cgroup *cgrp);
 
+void bpf_cgroup_rstat_updated(struct cgroup *cgrp, int cpu);
+void bpf_cgroup_rstat_flush(struct cgroup *cgrp);
+
 /*
  * Basic resource stats.
  */
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index aac91466279f..0d66cfc53061 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -82,7 +82,7 @@ void _cgroup_rstat_cpu_unlock(raw_spinlock_t *cpu_lock, int cpu,
  * rstat_cpu->updated_children list.  See the comment on top of
  * cgroup_rstat_cpu definition for details.
  */
-__bpf_kfunc void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
+void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 {
 	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
 	unsigned long flags;
@@ -129,6 +129,11 @@ __bpf_kfunc void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 	_cgroup_rstat_cpu_unlock(cpu_lock, cpu, cgrp, flags, true);
 }
 
+__bpf_kfunc void bpf_cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
+{
+	cgroup_rstat_updated(cgrp, cpu);
+}
+
 /**
  * cgroup_rstat_push_children - push children cgroups into the given list
  * @head: current head of the list (= subtree root)
@@ -346,7 +351,7 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
  *
  * This function may block.
  */
-__bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
+void cgroup_rstat_flush(struct cgroup *cgrp)
 {
 	might_sleep();
 
@@ -355,6 +360,11 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
 	__cgroup_rstat_unlock(cgrp, -1);
 }
 
+__bpf_kfunc void bpf_cgroup_rstat_flush(struct cgroup *cgrp)
+{
+	cgroup_rstat_flush(cgrp);
+}
+
 /**
  * cgroup_rstat_flush_hold - flush stats in @cgrp's subtree and hold
  * @cgrp: target cgroup
@@ -644,10 +654,9 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 	cgroup_force_idle_show(seq, &cgrp->bstat);
 }
 
-/* Add bpf kfuncs for cgroup_rstat_updated() and cgroup_rstat_flush() */
 BTF_KFUNCS_START(bpf_rstat_kfunc_ids)
-BTF_ID_FLAGS(func, cgroup_rstat_updated)
-BTF_ID_FLAGS(func, cgroup_rstat_flush, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_cgroup_rstat_updated)
+BTF_ID_FLAGS(func, bpf_cgroup_rstat_flush, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_rstat_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_rstat_kfunc_set = {
diff --git a/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
index c74362854948..24450dd4d3f3 100644
--- a/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
+++ b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
@@ -37,8 +37,8 @@ struct {
 	__type(value, struct attach_counter);
 } attach_counters SEC(".maps");
 
-extern void cgroup_rstat_updated(struct cgroup *cgrp, int cpu) __ksym;
-extern void cgroup_rstat_flush(struct cgroup *cgrp) __ksym;
+extern void bpf_cgroup_rstat_updated(struct cgroup *cgrp, int cpu) __ksym;
+extern void bpf_cgroup_rstat_flush(struct cgroup *cgrp) __ksym;
 
 static uint64_t cgroup_id(struct cgroup *cgrp)
 {
@@ -75,7 +75,7 @@ int BPF_PROG(counter, struct cgroup *dst_cgrp, struct task_struct *leader,
 	else if (create_percpu_attach_counter(cg_id, 1))
 		return 0;
 
-	cgroup_rstat_updated(dst_cgrp, bpf_get_smp_processor_id());
+	bpf_cgroup_rstat_updated(dst_cgrp, bpf_get_smp_processor_id());
 	return 0;
 }
 
@@ -141,7 +141,7 @@ int BPF_PROG(dumper, struct bpf_iter_meta *meta, struct cgroup *cgrp)
 		return 1;
 
 	/* Flush the stats to make sure we get the most updated numbers */
-	cgroup_rstat_flush(cgrp);
+	bpf_cgroup_rstat_flush(cgrp);
 
 	total_counter = bpf_map_lookup_elem(&attach_counters, &cg_id);
 	if (!total_counter) {
-- 
2.47.1


