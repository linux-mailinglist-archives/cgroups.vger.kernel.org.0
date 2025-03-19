Return-Path: <cgroups+bounces-7180-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F4FA69BE3
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 23:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DFB24800CA
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 22:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3603521B8E7;
	Wed, 19 Mar 2025 22:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHjJyIT6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CCA207A2A
	for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 22:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742422631; cv=none; b=Vz0JJzzHMDdrS0K9l6JURCRhWCxHAk4NGNGvKWIUov/2+gftk4znLf94n1yJphO/SDXneHHTnDD70mfAcbhrPN6rog7n4vLPstBpM939s0Tr1F4cKYMnheNijZrNN7BGuEqcDxfiambr48ixnDvGFvd2C3NjPBZ6xEDSciip/ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742422631; c=relaxed/simple;
	bh=c42ZwK2kFExIrHvJVlhy4T4qaaLzRsSU4wa7m+2FwNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESktBoIt7l8rf9eUfvqrdT7hkDtGyyNGopIsxubTCx2G4mlORd3jJDZ8c2at9V4Bf8p2ONFRrhmMUFl+a1FQ4UsTkjH9VZ2LGkY+l/scKGzCRXNw2TfzKeUSCf1NZVXqKhl0qOdMWf8h0791FMRNjNuvA5vyVyp9ibeK2RJXYSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHjJyIT6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22435603572so1081525ad.1
        for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 15:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742422629; x=1743027429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+XAb5qZM9EJun3uRHZFaBgl2slfeKVEfwXubaUvgvQ=;
        b=lHjJyIT6/c4dL5p3FSRphLpdH6Hdje5PhLthrK0PkTZ1Jkv07eO4yLEqlLfY1cCIGd
         kak6AMLeJBbvyWLubhDKVfjiP4m4zCvqtYv+/HyzxCEqFxxmGPWIbXCo7jVC1T2f7blm
         aral5pr2SdH3ezV/XO8+IF3Y8820iIJLwUKAr2etjWMtReLs3c/k8ONE82qUd50SugaW
         aI1dXCApk5tVn8wtxz0ZqcLWssm9JU6L3mzJPoj0RHaYi3CzDuGpHTvvSYCH92VQqkcv
         MbG62hkVYFhHOmlUvZTS5PLdX7MMipDxDOeOm8g++NFMikaGxkU7bjhOul/5jksb4jBu
         sVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742422629; x=1743027429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+XAb5qZM9EJun3uRHZFaBgl2slfeKVEfwXubaUvgvQ=;
        b=ZAfLrWmWL9JLABMaTibPVNX1nChpusajcZfcYoPDbTchPjxoqtxjxh9AjQ7ni0nxUM
         RYaAWVWFIkoPPxBzGl8WHY5ykqf1ZxoFNvHYh4snajhGa5R3jme5pkp7xeBdDD4UIARj
         todFDMOy6fg3s45Wn/qfdyioICfJWRvTSM3Zdbd+jrB2qDxdWGN4GPsFQm7wzt68SRY/
         Dfv1//HxxpCwGAU0u8DRjogZYf2kIUq+/OgNSP6QVoQK/xl0SSMYYg0NzoNXDE6LGT6J
         9wmqISmyEEIAvx76kDx82kynUhFBGcA58Eq3FxueQPiBWbkX9p05/abQBpr77BVB5/F+
         a3Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUeAOPUzJoRNFKrBhFKkD4z46HfaKdCfNkNZ2k/ZfRCqr4KOdRgB87BRFDlly0h7lzzvQA6v8IG@vger.kernel.org
X-Gm-Message-State: AOJu0YwszJsOmTGLKvFWMJmOIIRpJSHb8ah0qFqpf6Ju8ZH94G0cwz3o
	UampXKz0+B5m389LyGyxwOIPnsZWWVwAgUl7ItNMPgmemXpzgnNf
X-Gm-Gg: ASbGncuQ8KRPVocfo8Zx/VAt0aVxiP35IlJZPmU2fx3GhoaLe6Kl276qOXoYYqwkbQu
	YU6/qIDQmWL6b+T6/FVtVavpDCWCjtzogl9QME1o6zXZC69CXV1+LlBAERnR/wkF8athMFbUMfN
	qIkfa1FHBHO90yf+FweAX3lQGxWr2XwiUiER/EXdaNJYFAj8RHVx9iHfLlg8yt2JxqH0Uomxl7e
	AeQFr2zLDT53JMG0Tucmp6frCn2wk3FKVr6xubn1gLm5aOfJiGZ6flsyCjdEmpoVTr7mEF99mhY
	Yam28uChwU7h71kmLkfNrb486xvq7lIo7VrTbx/P6aqBqpP+4MLk/ieaGlnZjpJu96sfdeMjfqV
	JzZVLtl4=
X-Google-Smtp-Source: AGHT+IEKKYpDuuecD1uo8ylrhr/00YN1rGh/OPCt+W9SEcE6Jd30rlNrqU8W2oVUc0Hxahi+e0T9+w==
X-Received: by 2002:a05:6a00:3c96:b0:732:5611:cbb5 with SMTP id d2e1a72fcca58-7377a866940mr1458881b3a.11.1742422628594;
        Wed, 19 Mar 2025 15:17:08 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::4:39d5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116af372sm12253977b3a.160.2025.03.19.15.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 15:17:08 -0700 (PDT)
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
Subject: [PATCH 1/4] cgroup: use separate rstat api for bpf programs
Date: Wed, 19 Mar 2025 15:16:31 -0700
Message-ID: <20250319221634.71128-2-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319221634.71128-1-inwardvessel@gmail.com>
References: <20250319221634.71128-1-inwardvessel@gmail.com>
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


