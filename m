Return-Path: <cgroups+bounces-10765-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F63BDD46B
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 10:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A053C6BA2
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 08:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89592C2365;
	Wed, 15 Oct 2025 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m90jAOYe"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D322D0275
	for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515262; cv=none; b=gFHcOt338jI6Q/JCZ2YXwwBd5+sknE9rzGI4rKH18NdmnXIMjWJTLtyccgsq5KY9750LBxaLf9smO4glOEB725g0tozLtwwzktvuoNpj5o3NqaJImvIRBX/LOElIvoryGQhP+1FkXsohGSnGn0OyvjbgYg2yFu/cb7+FfmjuFas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515262; c=relaxed/simple;
	bh=MJ9hze2yT4ahH+tTDcdJMKvdVhVZbuQs9ESa30sLEJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xbdj2UkoVuSRJq8zjlGAvP68HrGEaB9acuAdMPpVRewnkYyvhYgqWI9xpycIZpTrLYrlLhDHqRdBqd8QHvdbGdXttJKc00pNkUlPbFYhZkHp3Ckyn1vi6n9V8eQDhGpOyoE1GkClTZPWaM5u528nR4f1kEekFl+uuL6BNvumZYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m90jAOYe; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e6c8bc46eso41399035e9.3
        for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 01:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760515258; x=1761120058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PytmB5BuvX8RtIynUIqEqCr1gpI55IJ4in+i47gkw7k=;
        b=m90jAOYevYGqQ3dtFG6/7pB27pbbAtx7TFtPSAL7GbEeso4eR2p0Nt36zfpxmopFxT
         0Lm0Hiyn8OZMSRIGSGuQqnjkZi/l2ysGQMZ01CiuFT2hf20yYU3F1H/aYEt5AT3xpqI9
         l/dbMzoemu0lsXlmBZz3kmOTVqQbWvyJj9aCG8QMKbpbrVJana+ybygiGfbJ8UmSk7x0
         c2Icnp4KxPK6Gwoq+cFDhsQ2dvrr5lExKZjSqi/A77BgMFfJCET9rnT4rXELJw7uBzSp
         iiby/sEYoNwyOpRVHf0P3YxUSvdsgARgu1Stlj2vj4VWoj4khlQej/MRhLEtRpxtQ/H8
         XBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760515258; x=1761120058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PytmB5BuvX8RtIynUIqEqCr1gpI55IJ4in+i47gkw7k=;
        b=ANxm76Skt9k5W6oBhM26YC6bdzk2G3qswzQym8IQgAr6p3zbZSQ0VwUqeHKj2q4Hsx
         kmaX6n+Os2igezZBKOOzFnUVQGXxNxKZfgmLS0yYDGPE1FY+UBzXHm/KYLe8uLdD7f9O
         W80TSjZ9Q9QGe2hjBmCsIaXeF920GSH2TLUP39KOaQVWCu126C1ze1crBPBgs5aAsc13
         EaKLo6JszwIskhcMvDG9TQMY03SkS3jtVyM428SFcofZeg+6aj1wC3OVU9p1hWdNG5s1
         RMTFNJfj4sXshm9RMuhTcmn+LgLoKHrueIiEdXKyX4W7qz20hETMZXAr5h6EoovfdpWh
         Dhbg==
X-Gm-Message-State: AOJu0Yye56E9tuN9+kyWaSBcu4B3X13bN9jAUZ2imuohwVbDsCZLolAi
	rp4NYxiO7r/w9lUtsYHuWawHQt7voNX02KubKVfQ8xkhpR3AB26HD0j5SmSpbQ==
X-Gm-Gg: ASbGncs1aaO+TNqrc8vhJS+jZnv4FdDbf5bGHUZOWkXRI7EW6HggMPQjO4QN6qPVRx8
	nGMmvlhXK0LxmeEYyuvSuVwzbpKzvc93ZtJvEkatBl/6Ol4R//rP5F6c40e22G8nZv2HQ6AB9bJ
	jBLT4leXXBuxySNAXI9SFgZW1s1OzkqZHcxfLrlKjT+FkrvkhcTkSvyrrfX9lvuEHpvAlNq1K3P
	EzUlgQp1u3hhP/lrxwTLgD0ZtkqYvM4rqfD2CdqHJ7Mi238IokRPxumD0MnCkC/pIPlp0AcpWU4
	KlKp6DVRA57bQFixexGmwYOrAUdiHgyz7dalqStX7gpV6YdO3z/ZLis3YtchFICwkvicq7vECbu
	5T8HmCeZSLdAkij0v+m2k2wizIEAlU03PePteak3viOfR5P5w97logKaA69xwRYam5pdXNJD6LT
	qSx5zWOvlkLSd2R744/fxR4dEn+Q==
X-Google-Smtp-Source: AGHT+IHaABIHuAIiW9HqRfDV35Xm09By2XhdDQoHDyw4SzSoIn4nkgP3r0XC/gcZKghlsk2oCrtgmg==
X-Received: by 2002:a05:600c:4f08:b0:46e:3dcb:35b0 with SMTP id 5b1f17b1804b1-46fa9a94553mr202964815e9.2.1760515257486;
        Wed, 15 Oct 2025 01:00:57 -0700 (PDT)
Received: from localhost.suse.cz (apn-78-30-82-56.dynamic.gprs.plus.pl. [78.30.82.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e1024sm27520095f8f.42.2025.10.15.01.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 01:00:57 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: cgroups@vger.kernel.org
Cc: tejun@kernel.org,
	mkoutny@suse.com,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH v2 2/2] selftests: cgroup: Use values_close_assert in test_cpu
Date: Wed, 15 Oct 2025 10:00:22 +0200
Message-ID: <20251015080022.14883-3-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015080022.14883-1-sebastian.chlad@suse.com>
References: <20251014143151.5790-1-sebastian.chlad@suse.com>
 <20251015080022.14883-1-sebastian.chlad@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert test_cpu to use the newly added values_close_assert() helper
to print detailed diagnostics when a tolerance check fails. This
provides clearer insight into deviations while run in the CI.

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---
 tools/testing/selftests/cgroup/test_cpu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
index 2a60e6c41940..d54e2317efff 100644
--- a/tools/testing/selftests/cgroup/test_cpu.c
+++ b/tools/testing/selftests/cgroup/test_cpu.c
@@ -219,7 +219,7 @@ static int test_cpucg_stats(const char *root)
 	if (user_usec <= 0)
 		goto cleanup;
 
-	if (!values_close(usage_usec, expected_usage_usec, 1))
+	if (!values_close_report(usage_usec, expected_usage_usec, 1))
 		goto cleanup;
 
 	ret = KSFT_PASS;
@@ -291,7 +291,7 @@ static int test_cpucg_nice(const char *root)
 
 		user_usec = cg_read_key_long(cpucg, "cpu.stat", "user_usec");
 		nice_usec = cg_read_key_long(cpucg, "cpu.stat", "nice_usec");
-		if (!values_close(nice_usec, expected_nice_usec, 1))
+		if (!values_close_report(nice_usec, expected_nice_usec, 1))
 			goto cleanup;
 
 		ret = KSFT_PASS;
@@ -404,7 +404,7 @@ overprovision_validate(const struct cpu_hogger *children, int num_children)
 			goto cleanup;
 
 		delta = children[i + 1].usage - children[i].usage;
-		if (!values_close(delta, children[0].usage, 35))
+		if (!values_close_report(delta, children[0].usage, 35))
 			goto cleanup;
 	}
 
@@ -444,7 +444,7 @@ underprovision_validate(const struct cpu_hogger *children, int num_children)
 	int ret = KSFT_FAIL, i;
 
 	for (i = 0; i < num_children - 1; i++) {
-		if (!values_close(children[i + 1].usage, children[0].usage, 15))
+		if (!values_close_report(children[i + 1].usage, children[0].usage, 15))
 			goto cleanup;
 	}
 
@@ -573,16 +573,16 @@ run_cpucg_nested_weight_test(const char *root, bool overprovisioned)
 
 	nested_leaf_usage = leaf[1].usage + leaf[2].usage;
 	if (overprovisioned) {
-		if (!values_close(leaf[0].usage, nested_leaf_usage, 15))
+		if (!values_close_report(leaf[0].usage, nested_leaf_usage, 15))
 			goto cleanup;
-	} else if (!values_close(leaf[0].usage * 2, nested_leaf_usage, 15))
+	} else if (!values_close_report(leaf[0].usage * 2, nested_leaf_usage, 15))
 		goto cleanup;
 
 
 	child_usage = cg_read_key_long(child, "cpu.stat", "usage_usec");
 	if (child_usage <= 0)
 		goto cleanup;
-	if (!values_close(child_usage, nested_leaf_usage, 1))
+	if (!values_close_report(child_usage, nested_leaf_usage, 1))
 		goto cleanup;
 
 	ret = KSFT_PASS;
@@ -691,7 +691,7 @@ static int test_cpucg_max(const char *root)
 	expected_usage_usec
 		= n_periods * quota_usec + MIN(remainder_usec, quota_usec);
 
-	if (!values_close(usage_usec, expected_usage_usec, 10))
+	if (!values_close_report(usage_usec, expected_usage_usec, 10))
 		goto cleanup;
 
 	ret = KSFT_PASS;
@@ -762,7 +762,7 @@ static int test_cpucg_max_nested(const char *root)
 	expected_usage_usec
 		= n_periods * quota_usec + MIN(remainder_usec, quota_usec);
 
-	if (!values_close(usage_usec, expected_usage_usec, 10))
+	if (!values_close_report(usage_usec, expected_usage_usec, 10))
 		goto cleanup;
 
 	ret = KSFT_PASS;
-- 
2.51.0


