Return-Path: <cgroups+bounces-8000-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2F5AA7DAF
	for <lists+cgroups@lfdr.de>; Sat,  3 May 2025 02:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126DE4C5566
	for <lists+cgroups@lfdr.de>; Sat,  3 May 2025 00:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6CC1FAA;
	Sat,  3 May 2025 00:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOa5kd1a"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B4617F7
	for <cgroups@vger.kernel.org>; Sat,  3 May 2025 00:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746231163; cv=none; b=N2LdTklyPwaaVGIx4sfYtDPnc0mc/X0fXwDxSwu2EOtSiN1UCIPLvIa9xLctsXC/zAfv96CRpOoydE/rG4jrA3odAQgg54Ga6Ou7R3KKiwO6FEzqRfgZaTdbu2oi+5FyZShwwr324/EvBzXHGbDdEOJP+5GdpTpGZPuP/0r0Kng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746231163; c=relaxed/simple;
	bh=ZnbCfv6fpPwfa8mTyTunbAQvcfn3hnSv+0jMkQyf13E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=daSSb9wChWU9dZy/2xH5EfotPHon0ZWMdb4AQ/I7K05vEcUMy91jtEeeNqdM7IWpkDdWucuTHfbNOv1DG9UZtX62oJUaYV52k0Cu5ZcCwlhwJyJGpjd8s4NPwl2D41X0GFCu+ot5vqjuYVSoLGmLAY+tTdatDJtsP9FoV7TOtwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOa5kd1a; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-af548cb1f83so2616104a12.3
        for <cgroups@vger.kernel.org>; Fri, 02 May 2025 17:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746231161; x=1746835961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpZ4BaSoWASsFEQSnMoCsr7HDlWnMYdZDLDUej72/H0=;
        b=JOa5kd1ag1nfSRJinfbLiQttP5KCCej7lBtycYJxIZOj/V8XC7FL4CiL0+4yj4WPn+
         NltBa+xUSwocGhlc9lEhWWwN9lJRJHtS3jizrGGMLpMIkpgtBmnhFZUKpjobmfXfI+L3
         FbIcwdpGKinfZcAnfCHNfb34zfmPmLK36mEOBGacVQAjo+Z3zprXxKeR+j/sRJ/SBco7
         Dn3ThPoNDMWT3RWKLAFwwynAcLZzeF46eGROqEavraEajdz/exZcrxE4DwniekMzlMCE
         TgmwjOsTHIsZ1G1tjMu46b8ZJnFXUO6xZJr4Snnu3k+vskaa8BjlnWzLQu0TOVnFlkQi
         vNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746231161; x=1746835961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpZ4BaSoWASsFEQSnMoCsr7HDlWnMYdZDLDUej72/H0=;
        b=CBNFF2NPDXZLxLCZfFGpSPK02V3+ypUO6cUXso5RsSeuKWJKqFsIFsCXjlsQPMGQeC
         qbcojUnwV5poIdbNTtRC4m85vapEd0VOxIdVPsndpdGTdqvW7n9d64G0qKcvo9oPnuy7
         zPU+gAJLYS31xPVp8i+LdkzHTo/+ra4T4vEEB2Qvr/pxaq0SN9Ap6GSKNI9XP0bajFb4
         x8q0YVVqoI56AY3ELxT8sic8mxJ2qRej1z/hyRi9ocrB0K2AFFa6A25wLsK7oEGk7Rub
         44gAnJXROnzcpRDC7grQQ4uH9MxJLO45i1wCWCnfHPXveUa8ioZxafcTvK2DJJ3xcJZW
         8EXg==
X-Forwarded-Encrypted: i=1; AJvYcCWkd4Hsz4nRJvtz1Ly1bzHyDN4dtV3p5mh394S1w2Y5y1yQXYjD6KMr678b6K1akkU9hVVbNVMi@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw+Y4qfidPATpt4NNRsRmD/xoyd+c05OFvdGyq1vJ9vTyE3hBi
	8yGq+2tBrV7FNdM9Sf+trO3QZopYbw0h4oFfaLYpV0q7aWgmj+jmVkeY+A==
X-Gm-Gg: ASbGncsGvu84RsNSq/I1eVHUovw0wPdEea280yUEkilpa7qAS37TufAd4RQkdtCH7ob
	hIYItxT4s67sPlNXy8GBCahrbgY9izryPK4AjEbv7u0rmsPPRjfvGNwn4OKD9cqyK24BOTiMkjC
	zIuI0wB1ZPJZBrrToRGzanNTqnZsEEswV/GsztkA3RB8q6PWWLMeDY2xJnJ1GolHHoGIWkRf3KA
	mDG6IIABU3MZ3xJHsnlL/rxImNWD15WRp6BneEkbuuTJb4eRDhk7C8cq5n6raYkabNk/VfM9tTM
	DZNAoE3XmV8yz5IvVYH+1pAsZ2pJNVMV5gphIXxzkfBDstZLZz2kSrqT6braGuutsmcU
X-Google-Smtp-Source: AGHT+IFt2nyPOKzv13Xrjiys+GI74FaDGbIUg8F2878W42EwIGaERqz5rwUXILn9PCV27yNkcy3n0w==
X-Received: by 2002:a17:90b:514b:b0:2ff:6f88:b04a with SMTP id 98e67ed59e1d1-30a4e5c5ec1mr7405455a91.15.1746231161061;
        Fri, 02 May 2025 17:12:41 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::5:6a01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15228f9csm13718635ad.178.2025.05.02.17.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 17:12:40 -0700 (PDT)
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
Subject: [PATCH v5 4/5] cgroup: helper for checking rstat participation of css
Date: Fri,  2 May 2025 17:12:21 -0700
Message-ID: <20250503001222.146355-5-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250503001222.146355-1-inwardvessel@gmail.com>
References: <20250503001222.146355-1-inwardvessel@gmail.com>
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
index e1e9dd7de705..15bc7ab458dc 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -14,6 +14,17 @@ static DEFINE_PER_CPU(raw_spinlock_t, rstat_base_cpu_lock);
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
 
+/*
+ * Determines whether a given css can participate in rstat.
+ * css's that are cgroup::self use rstat for base stats.
+ * Other css's associated with a subsystem use rstat when they
+ * define the ss->css_rstat_flush callback.
+ */
+static inline bool is_rstat_css(struct cgroup_subsys_state *css)
+{
+	return css_is_cgroup(css) || css->ss->css_rstat_flush != NULL;
+}
+
 static struct css_rstat_cpu *css_rstat_cpu(
 		struct cgroup_subsys_state *css, int cpu)
 {
@@ -119,7 +130,7 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 	 * Since bpf programs can call this function, prevent access to
 	 * uninitialized rstat pointers.
 	 */
-	if (!css_is_cgroup(css) && css->ss->css_rstat_flush == NULL)
+	if (!is_rstat_css(css))
 		return;
 
 	/*
@@ -390,7 +401,7 @@ __bpf_kfunc void css_rstat_flush(struct cgroup_subsys_state *css)
 	 * Since bpf programs can call this function, prevent access to
 	 * uninitialized rstat pointers.
 	 */
-	if (!is_cgroup && css->ss->css_rstat_flush == NULL)
+	if (!is_rstat_css(css))
 		return;
 
 	might_sleep();
@@ -464,7 +475,7 @@ void css_rstat_exit(struct cgroup_subsys_state *css)
 {
 	int cpu;
 
-	if (!css_is_cgroup(css) && css->ss->css_rstat_flush == NULL)
+	if (!is_rstat_css(css))
 		return;
 
 	css_rstat_flush(css);
-- 
2.47.1


