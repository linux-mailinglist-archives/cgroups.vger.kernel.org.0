Return-Path: <cgroups+bounces-10772-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86932BDE066
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 12:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6862B5013FA
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 10:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CF931D731;
	Wed, 15 Oct 2025 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpz6GAWR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2573C31D72B
	for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524460; cv=none; b=ArBEusttNgAZ0JfknL1D3fE2hlA/F6NUYAwnWGzw4qyEdj2aVUsEJHIewYpWdKCQC2Mdoq3qrK8q8jsFzf1qUWvXAJfmdY0z+k91GxCwiy//RSOXrxFUrflBmBiRZ/QTE68eXxPscaXe+EbGQfBM6O1LG8SN6x4HU26ts8XLfo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524460; c=relaxed/simple;
	bh=EUFoPTW/DnyMRW3KhXVS4K4eBfJJwJVAf9k14HM7jts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pha8N5bYy5boAxXFPGJ1rtuYCKr3sAO0fdU55KbKYlXT6R0lqvfn/or9MJFDEDLWANCFLDoUKKBAkpgGDUsrWSWCrwzf2Oc8qkxu3VZiVnaqVWGqqVDjjn0fXBidrByrL89Wfbv1V61xJoAv/sFh4nV3Lgus057hS8tNTjwgrK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpz6GAWR; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ece1102998so4267339f8f.2
        for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 03:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760524456; x=1761129256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qm+destyoR78coxcW7iW2CbmE8lVrWj61EUgJzLDi3k=;
        b=cpz6GAWRqiCZu+GPUmdOQOhmfTW16tc4P9MGBMDKscVPa8hvhMswv597axUH4Ouf0S
         jc7Pabrl28wacnLY4xC9OkdHuegoyqh3/exaAMNXrmTz93lsm9ckADCk+fuOISAtBUyN
         nY+1BFZ3UjZ1gI601E+sbsbjV6fnKveedbanudEIzDPps+qmsxCuuMkYgdEB/DA6hYIM
         NV2wIj/mz/oRZGEmCqAFzTLGs8NG5zQlt3dHGS3HDsWPlg9MDr8QwILk+FN6fpqzrVWF
         VohLMDbPxrryzINGaezzxgUwrlVbqw/1R1RtyAqb551aCyoSWIve4XGwF3tapCFKfzuQ
         f08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760524456; x=1761129256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qm+destyoR78coxcW7iW2CbmE8lVrWj61EUgJzLDi3k=;
        b=Kt73ryelNlfvmU9pIGrQDsuqpm86q7IJ/XWboC6OrEzu6qzBK2KIlUZZYKih4NyLMz
         ae1oo8Hud/IZbTOXYB50IGbwgRUHXvj86ffgQCGfJKpvKlk/9oJOXlNgRR98X2FxD4o5
         At0bimhjJRe9+wfeskURS4HezZ9ejyvQ072LqWR768Sxa4KVKGxOEtSH67AqE8lL2WHt
         qxuzdhVNe8uEIUeezQsQftEPXQhCBAJzg5+fLuJ1UkaSRbtn+QD0XS1Rh7mq0v4YgoHK
         yJbikdBGiNPYQC4lN/r3cRm0npmyA2YyB+G/ByxjhT7+412Vgx+dzPLnetBNdQFs6fsn
         BHcw==
X-Gm-Message-State: AOJu0Yw7hDwdckbkwy5P0ouC5tCjw1zjnBQQpHk0WxQ2h7/jiLVsDIUm
	ptibh8gjD5wofngZRxPvpGmVQ26rEkPpqBLii3Utep7b/vRP3YOxJM6QOoyhlQ==
X-Gm-Gg: ASbGncvbpBY4WrcMhTQ/dRvTYpqa/v/FVMDZxL+qkFkJfuyLoyajIBVIud2VlgExNu3
	ltFbVhFaqyfRw1qXPxwgcM3dLRw+QEe9UGgRThADAqVKxtJiJD4O3BmCpo99ijEAecbZLMmfw3m
	Q7yMqR/CTikKi3b+GO2awEcX3kZCKk7XeSsjevumQ4cng7mk9IJwAYUj67bGVn3Y8ZH3ePz+/G3
	eHHv9QtpV+J5j+LHBVjG0dHEDzgTaldvYkTW1FN36uBjSxlyxig/s54nSlhovfc+NYWI/Y1N6Ab
	X3mNunXBGZ20PCe56d6ycWHLUoO9HGh2wpXdxdal8wysgRopbX7OelkZO0cempFyGYzTu5X13sC
	SgG3folvmqMSl9abtjT8cylp+BilWZnnJRtKW2gi6tk7IchXSJUoOtYdyfPiwWOlbXxNozkUt8Y
	8ttp2+EC9wYbcPpcnbY1/3h8Rngg==
X-Google-Smtp-Source: AGHT+IF1dU9Wx+MHWzVaoxh0GJU6+C3PJpaaT4kovt36RmF6ZuPyYQJT96csHxXCHM+bb5I+Rtgd1w==
X-Received: by 2002:a5d:64e7:0:b0:3ee:b126:6bd with SMTP id ffacd0b85a97d-4266e8db354mr17659967f8f.50.1760524456102;
        Wed, 15 Oct 2025 03:34:16 -0700 (PDT)
Received: from localhost.suse.cz (apn-78-30-82-56.dynamic.gprs.plus.pl. [78.30.82.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47101be4876sm26032825e9.4.2025.10.15.03.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 03:34:15 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: cgroups@vger.kernel.org
Cc: mkoutny@suse.com,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH v3 2/2] selftests: cgroup: Use values_close_report in test_cpu
Date: Wed, 15 Oct 2025 12:33:57 +0200
Message-ID: <20251015103358.1708-3-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015103358.1708-1-sebastian.chlad@suse.com>
References: <20251015080022.14883-1-sebastian.chlad@suse.com>
 <20251015103358.1708-1-sebastian.chlad@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert test_cpu to use the newly added values_close_report() helper
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


