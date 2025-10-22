Return-Path: <cgroups+bounces-10982-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F73BFA4C9
	for <lists+cgroups@lfdr.de>; Wed, 22 Oct 2025 08:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867FB3B61A7
	for <lists+cgroups@lfdr.de>; Wed, 22 Oct 2025 06:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241062F25FA;
	Wed, 22 Oct 2025 06:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVjCAa3o"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B640C38FA3
	for <cgroups@vger.kernel.org>; Wed, 22 Oct 2025 06:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115600; cv=none; b=pj+L67sZ+2xcU88pmb8AKG5gcMyXPgvw7WUugFwqAP0HIMqdyLBlAbY66lUb6B/sDnU3GLpoVy9T1k6Hc4yq5QZ+/g0tnX0Ve4PoeYB5zjmVKHzhVn7sYsbwIQw+AeMOjrV3UK0igFc0uO0NxzgtSzHbDzYe5NElOrgXfRqH71A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115600; c=relaxed/simple;
	bh=dicC0NWkHzLlwt/5mNQDnPGG/cq4/W7oaNhyfBVGTJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2xLTqvoToJ2OEdbBskFWDW6Wd6BfSUXWa3mHcnpnrTHHljAp8517i6UZI8op4yvO1KDkaeBdmp0ebUawWRruLQ51ZPf9T3fvnk5vC2kzzdhelC6xOJv6qE8UOn+K0qch9yYJvIvACyE4tdkN2T2L6DhBK6twkEUa+m0U3tzhvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVjCAa3o; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4711f3c386eso32689385e9.0
        for <cgroups@vger.kernel.org>; Tue, 21 Oct 2025 23:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761115597; x=1761720397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+X+dtF6qnjhqjzOmEw4HuqkbSKUC3KKz5ld8iJNzfyw=;
        b=lVjCAa3opRA/3hfMgmFljymE8KujcwmkT2Gv1KVR6gbDIxqbFc8lMC3XR8y1/zBXGr
         35R2CT/yg1gxCRn2dI8E8yVLc76UMTBg4cl0jIg1Upb5aFbUlipG/2c+i1WXmnXbMCDO
         g7OdsP9iaDTWCEtqtxEusxCkY5pEVj1eyS9qjMavcRKy8qStKhZfyTToXR2N+K4jwt+7
         adq/cLOrYNXD+YT0xbD4TyBxU2BOh7lwRbI+BwVogKQ59HZxpb2HcRxmnoEc5TXOTQIm
         6pOQrlL3P043WIATAwvfPxtV3HTnHZcfYpLIvjm2jIKTzCPUV2E9VdIDchbyaDCIYpLW
         wJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761115597; x=1761720397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+X+dtF6qnjhqjzOmEw4HuqkbSKUC3KKz5ld8iJNzfyw=;
        b=aqnVkdjp7MtsfsyNDwOdBX3WoDip1agm1x16RRWeEXcza+z7VWXKwjyDwaSuuXJRTZ
         YqS2zUnNtKC3cwqVlS7/LWNJVdvzT0GQYN4fQXkHHd6MoKlqSDsUhBKTOdqEQZEcFNWx
         j6XSLqJQAuWLSYgkEiFfyfMCjzBmbTjsTQYnC16g/CB+/cApW04EoTfrw4cXAWtTPXpH
         Zw2pGTYipL7aQPGt1TptSVM1YREGAKCW2zCsGP1dWcoE9vwlsWGcPMx65MTdibneU3OA
         XNNUJ2MnJkoDFRh/Xuqt3oapmII5MpnWVjOPRjrKSa+avHqHq/TZg0D90hhBkmWe/Uea
         M/BA==
X-Gm-Message-State: AOJu0YxtwX6P3ullXT/r4Etx27Eg5rt8ojh87Wn+Cgvj6v9Uxdi2C4WM
	SZTcvWsV56XnwxRZTMfecIXUMXnuYFnungJiWklYdwL/4tjg2baY5+dNimWiWQ==
X-Gm-Gg: ASbGnctPulKpJ0mYGyuWxyWOtUCUaLXNy3GFaEG4VkSLFbXnuQ1I1oDI/Y8+IrcqxzQ
	xlTOHk9eNuCgLYkHfh1iFvY+re1ixoDU132Skr+dbMSjUF/ug7VE45iIzazA0iEQrI5eQLYERmB
	f3mzKRmsVsuFbhQ7bRJZZBskiU8yBPi7pjyNxC2iKAMWXi8pvn+6tsjTps6XtO5TUzzmX51sEzP
	/aCPh4VIxZGpx+m9Hwp6nfRLTy4O4JwpX94739gTuZLfoRz52mP+DXT750k+ja+2+FTIg4DEaKd
	TZmMMFQhxa++DXUOJvdlhhv3MSi4CrXs+XhD/4owIaLaCC8Oe5WoHhvKp2on71zIJdKlFDO7vp3
	7yEbXexw2aqhsWY6dc4KxezRo3qRME6SqXIDAgZjFzg0xbIiQkHCGJjUgC5wqH6lMaJ4F6p8s6W
	/na+peRpPZ7xQb5zRnORNLuPC+5FFDXXtr19anvZqSsb2kNKkcq5QE6SsEF4fR
X-Google-Smtp-Source: AGHT+IHdAIIKe3pgWU/rve9NQZvyXQyA406zChkIFiW8Wmu8xswMNG6z3qeC3uaoH1Ht+hHmlyI+jA==
X-Received: by 2002:a05:600c:3b0c:b0:471:669:ec1f with SMTP id 5b1f17b1804b1-471178785e1mr146235755e9.8.1761115596598;
        Tue, 21 Oct 2025 23:46:36 -0700 (PDT)
Received: from localhost.suse.cz (apn-78-30-82-56.dynamic.gprs.plus.pl. [78.30.82.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4369b5esm29931785e9.15.2025.10.21.23.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:46:36 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: cgroups@vger.kernel.org
Cc: mkoutny@suse.com,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH 4/5] selftests/cgroup: rename values_close_report() to report_metrics()
Date: Wed, 22 Oct 2025 08:46:00 +0200
Message-ID: <20251022064601.15945-5-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022064601.15945-1-sebastian.chlad@suse.com>
References: <20251022064601.15945-1-sebastian.chlad@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function values_close_report() is being renamed for the sake of
clarity and consistency with its purpose - reporting detailed usage
metrics during cgroup tests. Since this is a reporting function which
is controlled by the metrics_mode env variable there is no more print
of the metrics in case the test fails and this env var isn't set.
All references in the cpu tests use use the new function name.

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---
 .../selftests/cgroup/lib/cgroup_util.c        | 15 ++++----
 .../cgroup/lib/include/cgroup_util.h          |  2 +-
 tools/testing/selftests/cgroup/test_cpu.c     | 38 +++++++++++++------
 3 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/cgroup/lib/cgroup_util.c b/tools/testing/selftests/cgroup/lib/cgroup_util.c
index 9735df26b163..9414d522613d 100644
--- a/tools/testing/selftests/cgroup/lib/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/lib/cgroup_util.c
@@ -22,13 +22,13 @@
 
 bool cg_test_v1_named;
 
-static bool metric_mode = false;
+static bool metrics_mode = false;
 
 __attribute__((constructor))
 static void init_metric_mode(void)
 {
     char *env = getenv("CGROUP_TEST_METRICS");
-    metric_mode = (env && atoi(env));
+    metrics_mode = (env && atoi(env));
 }
 
 /*
@@ -40,21 +40,20 @@ int check_tolerance(long a, long b, int err)
 }
 
 /*
- * Checks if two given values differ by less than err% of their sum and assert
- * with detailed debug info if not.
+ * Report detailed metrics if metrics_mode is enabled.
  */
-int values_close_report(long a, long b, int err)
+int report_metrics(long a, long b, int err, const char *test_name)
 {
 	long diff  = labs(a - b);
 	long limit = (a + b) / 100 * err;
 	double actual_err = (a + b) ? (100.0 * diff / (a + b)) : 0.0;
 	int close = diff <= limit;
 
-	if (metric_mode || !close)
+	if (metrics_mode)
 		fprintf(stderr,
-			"[METRICS] actual=%ld expected=%ld | diff=%ld | limit=%ld | "
+			"[METRICS: %s] actual=%ld expected=%ld | diff=%ld | limit=%ld | "
 			"tolerance=%d%% | actual_error=%.2f%%\n",
-			a, b, diff, limit, err, actual_err);
+			test_name, a, b, diff, limit, err, actual_err);
 
 	return close;
 }
diff --git a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
index 7b6c51f91937..3f5002810729 100644
--- a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
@@ -18,7 +18,7 @@
 #define CG_PATH_FORMAT (!cg_test_v1_named ? "0::%s" : (":name=" CG_NAMED_NAME ":%s"))
 
 int check_tolerance(long a, long b, int err);
-int values_close_report(long a, long b, int err);
+int report_metrics(long a, long b, int err, const char *test_name);
 
 extern ssize_t read_text(const char *path, char *buf, size_t max_len);
 extern ssize_t write_text(const char *path, char *buf, ssize_t len);
diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
index d54e2317efff..ff76eda99acd 100644
--- a/tools/testing/selftests/cgroup/test_cpu.c
+++ b/tools/testing/selftests/cgroup/test_cpu.c
@@ -187,6 +187,7 @@ static int test_cpucg_stats(const char *root)
 	int ret = KSFT_FAIL;
 	long usage_usec, user_usec, system_usec;
 	long usage_seconds = 2;
+	int error_margin = 1;
 	long expected_usage_usec = usage_seconds * USEC_PER_SEC;
 	char *cpucg;
 
@@ -219,7 +220,8 @@ static int test_cpucg_stats(const char *root)
 	if (user_usec <= 0)
 		goto cleanup;
 
-	if (!values_close_report(usage_usec, expected_usage_usec, 1))
+	report_metrics(usage_usec, expected_usage_usec, error_margin, __func__);
+	if (!check_tolerance(usage_usec, expected_usage_usec, error_margin))
 		goto cleanup;
 
 	ret = KSFT_PASS;
@@ -241,6 +243,7 @@ static int test_cpucg_nice(const char *root)
 	int status;
 	long user_usec, nice_usec;
 	long usage_seconds = 2;
+	int error_margin = 1;
 	long expected_nice_usec = usage_seconds * USEC_PER_SEC;
 	char *cpucg;
 	pid_t pid;
@@ -291,7 +294,8 @@ static int test_cpucg_nice(const char *root)
 
 		user_usec = cg_read_key_long(cpucg, "cpu.stat", "user_usec");
 		nice_usec = cg_read_key_long(cpucg, "cpu.stat", "nice_usec");
-		if (!values_close_report(nice_usec, expected_nice_usec, 1))
+		report_metrics(nice_usec, expected_nice_usec, error_margin, __func__);
+		if (!check_tolerance(nice_usec, expected_nice_usec, error_margin))
 			goto cleanup;
 
 		ret = KSFT_PASS;
@@ -395,6 +399,7 @@ static pid_t weight_hog_all_cpus(const struct cpu_hogger *child)
 static int
 overprovision_validate(const struct cpu_hogger *children, int num_children)
 {
+	int error_margin = 35;
 	int ret = KSFT_FAIL, i;
 
 	for (i = 0; i < num_children - 1; i++) {
@@ -404,7 +409,8 @@ overprovision_validate(const struct cpu_hogger *children, int num_children)
 			goto cleanup;
 
 		delta = children[i + 1].usage - children[i].usage;
-		if (!values_close_report(delta, children[0].usage, 35))
+		report_metrics(delta, children[0].usage, error_margin, __func__);
+		if (!check_tolerance(delta, children[0].usage, error_margin))
 			goto cleanup;
 	}
 
@@ -441,10 +447,12 @@ static pid_t weight_hog_one_cpu(const struct cpu_hogger *child)
 static int
 underprovision_validate(const struct cpu_hogger *children, int num_children)
 {
+	int error_margin = 15;
 	int ret = KSFT_FAIL, i;
 
 	for (i = 0; i < num_children - 1; i++) {
-		if (!values_close_report(children[i + 1].usage, children[0].usage, 15))
+		report_metrics(children[i + 1].usage, children[0].usage, error_margin, __func__);
+		if (!check_tolerance(children[i + 1].usage, children[0].usage, error_margin))
 			goto cleanup;
 	}
 
@@ -573,16 +581,20 @@ run_cpucg_nested_weight_test(const char *root, bool overprovisioned)
 
 	nested_leaf_usage = leaf[1].usage + leaf[2].usage;
 	if (overprovisioned) {
-		if (!values_close_report(leaf[0].usage, nested_leaf_usage, 15))
+		report_metrics(leaf[0].usage, nested_leaf_usage, 15, __func__);
+		if (!check_tolerance(leaf[0].usage, nested_leaf_usage, 15))
 			goto cleanup;
-	} else if (!values_close_report(leaf[0].usage * 2, nested_leaf_usage, 15))
-		goto cleanup;
-
+	} else {
+		report_metrics(leaf[0].usage * 2, nested_leaf_usage, 15, __func__);
+		if (!check_tolerance(leaf[0].usage * 2, nested_leaf_usage, 15))
+			goto cleanup;
+	}
 
 	child_usage = cg_read_key_long(child, "cpu.stat", "usage_usec");
 	if (child_usage <= 0)
 		goto cleanup;
-	if (!values_close_report(child_usage, nested_leaf_usage, 1))
+	report_metrics(child_usage, nested_leaf_usage, 1, __func__);
+	if (!check_tolerance(child_usage, nested_leaf_usage, 1))
 		goto cleanup;
 
 	ret = KSFT_PASS;
@@ -649,6 +661,7 @@ static int test_cpucg_max(const char *root)
 	long quota_usec = 1000;
 	long default_period_usec = 100000; /* cpu.max's default period */
 	long duration_seconds = 1;
+	int error_margin = 10;
 
 	long duration_usec = duration_seconds * USEC_PER_SEC;
 	long usage_usec, n_periods, remainder_usec, expected_usage_usec;
@@ -691,7 +704,8 @@ static int test_cpucg_max(const char *root)
 	expected_usage_usec
 		= n_periods * quota_usec + MIN(remainder_usec, quota_usec);
 
-	if (!values_close_report(usage_usec, expected_usage_usec, 10))
+	report_metrics(usage_usec, expected_usage_usec, error_margin, __func__);
+	if (!check_tolerance(usage_usec, expected_usage_usec, error_margin))
 		goto cleanup;
 
 	ret = KSFT_PASS;
@@ -713,6 +727,7 @@ static int test_cpucg_max_nested(const char *root)
 	long quota_usec = 1000;
 	long default_period_usec = 100000; /* cpu.max's default period */
 	long duration_seconds = 1;
+	int error_margin = 10;
 
 	long duration_usec = duration_seconds * USEC_PER_SEC;
 	long usage_usec, n_periods, remainder_usec, expected_usage_usec;
@@ -762,7 +777,8 @@ static int test_cpucg_max_nested(const char *root)
 	expected_usage_usec
 		= n_periods * quota_usec + MIN(remainder_usec, quota_usec);
 
-	if (!values_close_report(usage_usec, expected_usage_usec, 10))
+	report_metrics(usage_usec, expected_usage_usec, error_margin, __func__);
+	if (!check_tolerance(usage_usec, expected_usage_usec, error_margin))
 		goto cleanup;
 
 	ret = KSFT_PASS;
-- 
2.51.0


