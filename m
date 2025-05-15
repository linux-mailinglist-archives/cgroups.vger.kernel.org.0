Return-Path: <cgroups+bounces-8203-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D72D3AB7A7D
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 02:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E625F8C0B80
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 00:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686D079C4;
	Thu, 15 May 2025 00:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgUzp4q3"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85D4F9D6
	for <cgroups@vger.kernel.org>; Thu, 15 May 2025 00:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747268397; cv=none; b=iRNBWT4p3zDFRASnnQy1U/jmrpO3hSCN8EESdQEnvGNSRACSNys15tdzheLswxInsJLBqF0UEZIyM0m+YLdesJsuI3rBga8UuL8vNPTe87t0qeFomLhYpplJBNOgcAesusKfT80YZVPIDR94dm2QV5moZh33Sq/nDkqQSTczaGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747268397; c=relaxed/simple;
	bh=U6xLvmJ6r5nDM3KhgMC2D/hkpdj+XJ2sUGArjm4ysCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFHMX4LYDZbbd+UUBwaHqQz0bgOafcdbl8l06iFFz/bK7IDSFXsG6JEwc+farnBaTGuboS0g5yKSvCT/5yXed8EUtEPvMYITrVFEOn+B5QqtRU75KkfwdG408TmOieY699ymrx2Y1mbcaiMjs89UELxXgcIY6Iikqun1r+hzcqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgUzp4q3; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b268e4bfd0dso258933a12.2
        for <cgroups@vger.kernel.org>; Wed, 14 May 2025 17:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747268395; x=1747873195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsXeddh27qUtiPyjuWiU2GcX+XXeR+Y15TR04mKI6bw=;
        b=QgUzp4q3hmbTyq7Eo6gqxcL1GBHClZKX/jHoCZOxnK6fnC9Hi/J299+prGObC1kzuf
         4EcWq1o13bikOjnfHpgm9I2oZl1I8oFVVbfd7w5tosUBaTOHCV7dGoxXc7BFAahrAAi/
         gS55cx5SILPTAZ27K6g3K9VCuZBYddLs7SHCJiwKzWx3lT+NDQFwCcEywZYf7BG8uDZc
         JZhpfjhbcjDejpCAsW9uPIESe+40nbvYWzN9hIPt9zGWoqUk/MnK666mj41611tFQHKT
         M/WwYF1KkPettszNo/L0eJNGFxQDv3tzTpH0uBSlfeoktfNTVdI4iuX9uwzyMpcK6GIS
         bdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747268395; x=1747873195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QsXeddh27qUtiPyjuWiU2GcX+XXeR+Y15TR04mKI6bw=;
        b=hUwdOBZdaPGMBDBTsolTnuEIE9ArcAXXmZTSs6Qy5okl2g5UvvGc8vqkoU9cHbcupJ
         CGu80G1ntMm7yj73SPq0u53NW+Kq42IOHwPzlkMFBDp6aITzo1IprQbJxKBtXIqQas9d
         by1tgkeXtApwzQuEWaZXyNXsUwRJK/O25cXbZ1oQLddWZsQNSWllKYLK9JBx9dOdHQbg
         QJ6sDJ8B0q7jppieRjzDR/jrvELwTvv+V3ngHdKqjAqBUVT2reDvDP1DNGSP1dzhPseU
         S0ZXelJDcd8yCmFQMkesyr9RP8u9EmvDDUXnpr4alACi5OWfIi8l8U/ozBIaXiEYk93W
         oNAg==
X-Forwarded-Encrypted: i=1; AJvYcCUqJzqQv6BpcSYoPv/FGZbMqL3T5YyvC0ulQGoGm73lFsBQT5LZcAlkojhKKkUqd/vLFWanIDmX@vger.kernel.org
X-Gm-Message-State: AOJu0YxBcj4dpcVuqGsBKL+m5Y9qN2JhBwTkCBLf0WJbiH/ngeVmpcIf
	qKMqZ8q8kAzdqXUMSW3wNw2rUa/8kDhzVHj+6X2EAPX1leGuhWeM
X-Gm-Gg: ASbGnctvah+Ox0F9y1eFHTR2Ghli3dcl00cRYJQ+D7ea0tgAASb9ef/ZFoCkLwH9jaV
	f8PNOgs6GmUUc4jwSMeXRNL4A4EvnRHPcsp/KM+beBWrXJ7nRaUJCVTj9DLPrvNszKUux/9ZmS5
	P5L0hm/zebTAG5YwFKEP8y8/JxbDI6hlKuRz0oJVk0ry2XPdhZLPxvdhFcu/WJ1DpbV/n4dxA4q
	blZLWhJgtb2Iykz3IhyJV/eT7/upJYhllIzRS0RrtVaBgCX8vZ8Q1LkvegpIffNaPgTrNbxiYl9
	uHWq2nwCNKhMp3JSshop8nFLmNJSURO+Bg5amCVHB883DHah8U5W6j0sXVVoNiVoIybdPof2HNN
	FKka2/ksbF1th7JsTp/OA9R7ZCBFJQPS8j67c9Ss=
X-Google-Smtp-Source: AGHT+IHMcc8S2VPw0vzeqOlM9yadW+kn0gwzI0AfHi3/d+ZF1Q3laR0g2ViY2qe7tqs4zQRqTNyn8A==
X-Received: by 2002:a17:902:da8b:b0:224:2717:7993 with SMTP id d9443c01a7336-231981c916emr74952665ad.45.1747268394873;
        Wed, 14 May 2025 17:19:54 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.lan (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc754785bsm105939545ad.20.2025.05.14.17.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 17:19:54 -0700 (PDT)
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
Subject: [PATCH v6 5/6] cgroup: helper for checking rstat participation of css
Date: Wed, 14 May 2025 17:19:36 -0700
Message-ID: <20250515001937.219505-6-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515001937.219505-1-inwardvessel@gmail.com>
References: <20250515001937.219505-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a few places where a conditional check is performed to validate a
given css on its rstat participation. This new helper tries to make the
code more readable where this check is performed.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/cgroup/rstat.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 0bb609e73bde..7dd396ae3c68 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -14,6 +14,17 @@ static DEFINE_PER_CPU(raw_spinlock_t, rstat_base_cpu_lock);
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
 
+/*
+ * Determines whether a given css can participate in rstat.
+ * css's that are cgroup::self use rstat for base stats.
+ * Other css's associated with a subsystem use rstat only when
+ * they define the ss->css_rstat_flush callback.
+ */
+static inline bool css_uses_rstat(struct cgroup_subsys_state *css)
+{
+	return css_is_self(css) || css->ss->css_rstat_flush != NULL;
+}
+
 static struct css_rstat_cpu *css_rstat_cpu(
 		struct cgroup_subsys_state *css, int cpu)
 {
@@ -119,7 +130,7 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 	 * Since bpf programs can call this function, prevent access to
 	 * uninitialized rstat pointers.
 	 */
-	if (!css_is_self(css) && css->ss->css_rstat_flush == NULL)
+	if (!css_uses_rstat(css))
 		return;
 
 	/*
@@ -390,7 +401,7 @@ __bpf_kfunc void css_rstat_flush(struct cgroup_subsys_state *css)
 	 * Since bpf programs can call this function, prevent access to
 	 * uninitialized rstat pointers.
 	 */
-	if (!is_self && css->ss->css_rstat_flush == NULL)
+	if (!css_uses_rstat(css))
 		return;
 
 	might_sleep();
@@ -462,7 +473,7 @@ void css_rstat_exit(struct cgroup_subsys_state *css)
 {
 	int cpu;
 
-	if (!css_is_self(css) && css->ss->css_rstat_flush == NULL)
+	if (!css_uses_rstat(css))
 		return;
 
 	css_rstat_flush(css);
-- 
2.47.1


