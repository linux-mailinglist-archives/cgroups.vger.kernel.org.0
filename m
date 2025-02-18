Return-Path: <cgroups+bounces-6584-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AF0A39135
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 04:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ACF3172B4C
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 03:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F5D1779B8;
	Tue, 18 Feb 2025 03:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGfx+607"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5702E187FE4
	for <cgroups@vger.kernel.org>; Tue, 18 Feb 2025 03:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739848519; cv=none; b=N8GEeYG0EJpEvHaWjlOH6GxObwQkrqNGCUHdygLaxGGwa6fqlGyCZg7eoRaOC4V92haGRBmuH4n1PV1LBjfksYwIggyPXgvqqscq8Puv+b9T1IIEy0CzDcv40qfuX24AYWDThB7F1lcmEiQ3EhpjQxHVuyts0KuP1kyWbirRTWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739848519; c=relaxed/simple;
	bh=ED55v7/axAKRCfRRkeUUmsBCrCERtwLzINKWQlDXKL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMhoF5Z1Qt8rP9Cbl7NNDMtKpe6PZjKW+7OlAZKMZhEqJC//VHFZE1ojoPEoDff3c4lBK7nt1iopmsL8JO0eIUlQA+UxANd/vjNRJbzkHeoJG3c3kmaiJTJCcAg9+s1NlXxjS4POwZaSmJPqSV8wRCsWyMUh0k9fAwFbYFHtv9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGfx+607; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220ecbdb4c2so96433305ad.3
        for <cgroups@vger.kernel.org>; Mon, 17 Feb 2025 19:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739848517; x=1740453317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vg+1tuAH5Cml38p4hzH7HNleCRescAO8xBmjt4Ynbfc=;
        b=BGfx+607wFTO7YfMsaIe/+18LONF5TQomUBrfLOAIfSG/S9JG4+n37/keY84WMLJLU
         6h2Kx04t5JvMT2OgE4H4rinwtTJ8DOp1HudxyshhgVesALp4VWmSA8SZuCa75eRYDKnQ
         XQzs3BZggcok8GaWdlLt/oTScI8i2/eo9ZmKOoeU8IgpTXXFvP91btA92o4jlu9vCX18
         3hioCWbnl+n0gz8X7f55UE4L079ahR0keSv2P6Akdhf4AJ7lnWhMZa0DPwhGUAeXZ6oy
         uin/PnA0R9W8dW7c+es6ds1urIwj4dBf8xQSGTm0Z1hHJ4rT+e5fepvtlDTSGEXRMmDR
         FWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739848517; x=1740453317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vg+1tuAH5Cml38p4hzH7HNleCRescAO8xBmjt4Ynbfc=;
        b=fWq1o/RMpthE2mHicFDuECSk83fwaa4aOK/gKJ6xMDvXPTlVAZ5C+JvzkC7OP6eleG
         nwRrnkKEzaKtUr++qLruPV2aXR89TICt7e/+ym79VB774VioCkgM7K1LvpuYVzuBqdhR
         Yu2Vo8qXx2p/f9rY+3OzAdgZPSbb00bS4u0haaa9js58Myp4vM6RVPIAB8pD+cGPCvOn
         RjbjZIPtjvPYQ57BUNITfw7JuKRH+J93jVgSWvqk1vVvOVQqTEKGCzLEbzRbKlKcAYRg
         ZwRKWiMhWPHu4UGQVkUwjQFYhwFKCBcd9Xl1PHrbW83CHAwUvTejr0BMiRDBwnr+lsPs
         h2YA==
X-Forwarded-Encrypted: i=1; AJvYcCWBQnbVUPgpdjax4pS1kR0zZTDs+t4OnL1VQlRbxpTNX5Hp9vHPQuZkljYrVDbu0nKbIbmYD2zr@vger.kernel.org
X-Gm-Message-State: AOJu0YyEBQOYFYgYveEJvanX/+0uBuJBW8+F1lVw06aI4w/c0PNuUkHu
	E2/LZfwY8MssF+NcRsy5r6MHCzFOyCxH0ZFsGygnTkO9uDHDUzxS
X-Gm-Gg: ASbGncuKtHl3Y/bcSomB8ZSMbkckD6NSzn6ZUK1xV3AMYWrhitfpt78LempNNnpYL/+
	T43iEzVGdOEDOvSNJR+M/e6zYVTJrjcuRL65Pymb+jGJO9X+OvmgNKkQunxeXbobi7jSaPRTjyN
	seuxltu/n9n/p+kLP+ghijW/sE59xLnlqo3XcNGZ8jM5e0zaxFgHoPInZrQ9xcexbQJs0y96ne/
	jE4TvV/GL9kBS0SBKXYTn/FOZhdaT/H3tXNwmQycarOWNvszdbVC5BGcxcZ+bj7UCFabti2uN26
	UeMEwlC9A2f/6fXr3U53F9ewOL8L6bBFB72WGnwXdDeRM60RK/J7
X-Google-Smtp-Source: AGHT+IGi97sy9lc8oEV2Lvmu4nX/Oz5UjlOTjclhhjOUsPwyOtWg+KBN0Ea6IXWS4MZ0ObmmEo85Dg==
X-Received: by 2002:a05:6a20:244a:b0:1ed:a6d8:3439 with SMTP id adf61e73a8af0-1ee8cb7dfd1mr22632952637.22.1739848517528;
        Mon, 17 Feb 2025 19:15:17 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732425466besm8763451b3a.9.2025.02.17.19.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 19:15:17 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	tj@kernel.org,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 10/11] cgroup: separate rstat locks for subsystems
Date: Mon, 17 Feb 2025 19:14:47 -0800
Message-ID: <20250218031448.46951-11-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218031448.46951-1-inwardvessel@gmail.com>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new rstat locks for each subsystem. When handling cgroup subsystem
states, distinguish between states associated with formal subsystems
(memory, io, etc) and the base stats subsystem state (represented by
cgroup::self). This change is made to prevent contention when
updating/flushing stats.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/cgroup/rstat.c | 68 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 10 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 7d9abfd644ca..93b97bddec9c 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -15,8 +15,11 @@ struct cgroup_rstat_ops {
 	void (*flush_fn)(struct cgroup_rstat *, int);
 };
 
-static DEFINE_SPINLOCK(cgroup_rstat_lock);
-static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
+static DEFINE_SPINLOCK(cgroup_rstat_base_lock);
+static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_base_cpu_lock);
+
+static spinlock_t cgroup_rstat_subsys_lock[CGROUP_SUBSYS_COUNT];
+static raw_spinlock_t __percpu cgroup_rstat_subsys_cpu_lock[CGROUP_SUBSYS_COUNT];
 
 #ifdef CONFIG_CGROUP_BPF
 static DEFINE_SPINLOCK(cgroup_rstat_bpf_lock);
@@ -241,8 +244,14 @@ static void __cgroup_rstat_updated(struct cgroup_rstat *rstat, int cpu,
  */
 void cgroup_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 {
-	__cgroup_rstat_updated(&css->rstat, cpu, &rstat_css_ops,
-			&cgroup_rstat_cpu_lock);
+	raw_spinlock_t *cpu_lock;
+
+	if (is_base_css(css))
+		cpu_lock = &cgroup_rstat_base_cpu_lock;
+	else
+		cpu_lock = &cgroup_rstat_subsys_cpu_lock[css->ss->id];
+
+	__cgroup_rstat_updated(&css->rstat, cpu, &rstat_css_ops, cpu_lock);
 }
 
 #ifdef CONFIG_CGROUP_BPF
@@ -487,8 +496,19 @@ static void __cgroup_rstat_flush(struct cgroup_rstat *rstat,
  */
 void cgroup_rstat_flush(struct cgroup_subsys_state *css)
 {
+	spinlock_t *lock;
+	raw_spinlock_t *cpu_lock;
+
+	if (is_base_css(css)) {
+		lock = &cgroup_rstat_base_lock;
+		cpu_lock = &cgroup_rstat_base_cpu_lock;
+	} else {
+		lock = &cgroup_rstat_subsys_lock[css->ss->id];
+		cpu_lock = &cgroup_rstat_subsys_cpu_lock[css->ss->id];
+	}
+
 	__cgroup_rstat_flush(&css->rstat, &rstat_css_ops,
-			&cgroup_rstat_lock, &cgroup_rstat_cpu_lock);
+			lock, cpu_lock);
 }
 
 #ifdef CONFIG_CGROUP_BPF
@@ -523,8 +543,19 @@ static void __cgroup_rstat_flush_hold(struct cgroup_rstat *rstat,
  */
 void cgroup_rstat_flush_hold(struct cgroup_subsys_state *css)
 {
+	spinlock_t *lock;
+	raw_spinlock_t *cpu_lock;
+
+	if (is_base_css(css)) {
+		lock = &cgroup_rstat_base_lock;
+		cpu_lock = &cgroup_rstat_base_cpu_lock;
+	} else {
+		lock = &cgroup_rstat_subsys_lock[css->ss->id];
+		cpu_lock = &cgroup_rstat_subsys_cpu_lock[css->ss->id];
+	}
+
 	__cgroup_rstat_flush_hold(&css->rstat, &rstat_css_ops,
-			&cgroup_rstat_lock, &cgroup_rstat_cpu_lock);
+			lock, cpu_lock);
 }
 
 /**
@@ -547,8 +578,14 @@ static void __cgroup_rstat_flush_release(struct cgroup_rstat *rstat,
  */
 void cgroup_rstat_flush_release(struct cgroup_subsys_state *css)
 {
-	__cgroup_rstat_flush_release(&css->rstat, &rstat_css_ops,
-			&cgroup_rstat_lock);
+	spinlock_t *lock;
+
+	if (is_base_css(css))
+		lock = &cgroup_rstat_base_lock;
+	else
+		lock = &cgroup_rstat_subsys_lock[css->ss->id];
+
+	__cgroup_rstat_flush_release(&css->rstat, &rstat_css_ops, lock);
 }
 
 static void __cgroup_rstat_init(struct cgroup_rstat *rstat)
@@ -629,10 +666,21 @@ void bpf_cgroup_rstat_exit(struct cgroup_bpf *bpf)
 
 void __init cgroup_rstat_boot(void)
 {
-	int cpu;
+	struct cgroup_subsys *ss;
+	int cpu, ssid;
+
+	for_each_subsys(ss, ssid) {
+		spin_lock_init(&cgroup_rstat_subsys_lock[ssid]);
+
+		for_each_possible_cpu(cpu) {
+			raw_spinlock_t *cpu_lock =
+				per_cpu_ptr(&cgroup_rstat_subsys_cpu_lock[ssid], cpu);
+			raw_spin_lock_init(cpu_lock);
+		}
+	}
 
 	for_each_possible_cpu(cpu) {
-		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));
+		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_base_cpu_lock, cpu));
 
 #ifdef CONFIG_CGROUP_BPF
 		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_bpf_cpu_lock, cpu));
-- 
2.48.1


