Return-Path: <cgroups+bounces-10981-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B5396BFA4B1
	for <lists+cgroups@lfdr.de>; Wed, 22 Oct 2025 08:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F1042352F49
	for <lists+cgroups@lfdr.de>; Wed, 22 Oct 2025 06:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815712F1FFC;
	Wed, 22 Oct 2025 06:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSQhZIgm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E447248F77
	for <cgroups@vger.kernel.org>; Wed, 22 Oct 2025 06:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115599; cv=none; b=T0D0t6XG4UUWJHLybcW9ll2sovFPQiBtrOVTnjeOeYzIpbbU4MRvpW+pncl/RaMegKYvgB0qgfgyNSZ8ggTZQ6ALFA5DNxUFEwWgTPnl2p911morCQVkPyjT5oXwTdanYWwTT0jBQLXqUFiIn/IvxH3eZ3ijBOx+YfIWPS0BKD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115599; c=relaxed/simple;
	bh=XzKbB+mGRT6gkaN84SaEwZW484lLeG1tuFmX92PEL5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWRH8bJ1h1hgjU7yXpcnjll35w4iRQJOxP0HCOb1eiaZXOk+ezTMnjve8RWRCDHmSBnCT9y4ARhGaNk6cRB8mlrYCJuxNXhyyw+U1hX8UcT66ULPK0nKxamr28den+YnYnubWSuPWtK+HSkq8uUYgM+ooJ69G9M5V9AqyCHPmLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSQhZIgm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47495477241so14515745e9.3
        for <cgroups@vger.kernel.org>; Tue, 21 Oct 2025 23:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761115595; x=1761720395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYPDs0qZ3gamg9rOKiLO8J5gc0Br24fO7YovJCgAXSw=;
        b=aSQhZIgmi2wYz2lqR3cHWbbC5sVwc5R2QSaE7arKC1Mw/Pev8sIk8NRofx/0FbwzG+
         Dd8QPdcIOT2OhiTJbNrSIJS7RXuDB3VIKAM3Sqjyl2R8pcTkW2y60E5ccC58wRsSAnx0
         /R7cRIWecVO7NzmGb34K5V4RJmc02YdyxuYQkVmLhbUHCmG/Q0iKlGajWr4tLGioOFWl
         yT7zzzeWkqif4UPe5RI5J8dTstd30fdsDIS8KgAftz0h3RFG6///YiXfub9BhkWdbpdr
         nkUop9h1LYL3OkQmtLG4fOfIuSMaqh1yQ4St3TsgXNl/QJZDpPeVDc6v2czeusxXHEc4
         OQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761115595; x=1761720395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pYPDs0qZ3gamg9rOKiLO8J5gc0Br24fO7YovJCgAXSw=;
        b=xSLmA9BkTqf4t7yWT133kosBoMX75Mr87FnFGW6pVMR5a0SLNqdJj/qtELwLI1SaqN
         b/g6TNExHmVjVqDRfils5u/P+RR5oA1HaYH/tDB0y2SXlNfp+J0lEpQpKqJxb+0LUKAi
         PcOX2LvYy7gxkSTNhRuD5afDBAcYk1WGzxV5XfEfInGqe1M1AnOxjz0W8ZFPbqW4mrVF
         h5RjUYA/rpAE+uL3sn2DDmmrMgCIccKsVxg4SFTkVCxUEd9Z9xCD0R+zK6VazC+XZB8P
         WNWnpAtGwj/4GNAbnxmelm+SStWnte3cITLq9odFusyBSfPXlqn+hRh0ToTwdCjijlKi
         e7Qw==
X-Gm-Message-State: AOJu0YxCAUW4AQZNLn/SbzuuGoiwpdeqEwvxsxyxOK8DExavStiCvJw1
	XGVe+3VHXW//upbBDAraHv4vgtNJmc8nM/m1AgqSCP7l1JsUMr4tY2fEztsddA==
X-Gm-Gg: ASbGnctyCF/5OL4awHp0Bjez6teEEODQu9k62BGPQLIZTd2SUGQ4weGGDCAXaF9ItiS
	QXaCRhfnXfu5gUw185UU8ZZfcqd7IThBYXOzxgS8NxC8hAtMjiziN9ykETAViujq8vv6Zyby8qV
	nEf1vMwUg6TiGQhsHbEerrcIQKSHkcBMZpd6b2c45bDj9rz1owrpBOwxR3Eq7jRQPlLRea7nxUi
	iuqQtSSdimnwW8r4s7tW2COXZBzE3pU4iDdlJWbKk40J7JOau2oyOLo+OL2CiGizkFNdvkRCWc0
	pU1bHO0/X9QLbYElM0CAwTjhzI1GI1STicPG29UsR1LKNWdlHA1+O34G5llFEjHfz4VNfUUkTf3
	xr+IYSq5TvHb6tk5kFM3VPSmdArk2QPmXGg0bve1MFbajUbRtmwL8jelbofJx8MMX4tsHwDTC4M
	wanug2sOKBEl1Eg25vbH9iAvCwNJyes1BdFZOVbmALUMxDerqEoiyQmSMpPdCJ
X-Google-Smtp-Source: AGHT+IFt7+LnDiNDDeD0mWX4Ee7d9UD4ZQpOBP6B85a7u9XGELBu3j+mi1cNgchwD6VugL8vORYmWg==
X-Received: by 2002:a05:600c:4e42:b0:46e:31c3:1442 with SMTP id 5b1f17b1804b1-471178afc07mr134422255e9.18.1761115595263;
        Tue, 21 Oct 2025 23:46:35 -0700 (PDT)
Received: from localhost.suse.cz (apn-78-30-82-56.dynamic.gprs.plus.pl. [78.30.82.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4369b5esm29931785e9.15.2025.10.21.23.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:46:35 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: cgroups@vger.kernel.org
Cc: mkoutny@suse.com,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH 3/5] selftests/cgroup: rename values_close() to check_tolerance()
Date: Wed, 22 Oct 2025 08:45:59 +0200
Message-ID: <20251022064601.15945-4-sebastian.chlad@suse.com>
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

Rename the helper function `values_close()` to `check_tolerance()` across
all relevant source files for improved clarity and consistency.

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---
 .../selftests/cgroup/lib/cgroup_util.c        |  2 +-
 .../cgroup/lib/include/cgroup_util.h          |  2 +-
 .../selftests/cgroup/test_hugetlb_memcg.c     |  6 ++--
 .../selftests/cgroup/test_memcontrol.c        | 28 +++++++++----------
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/cgroup/lib/cgroup_util.c b/tools/testing/selftests/cgroup/lib/cgroup_util.c
index 32ecc50e50fc..9735df26b163 100644
--- a/tools/testing/selftests/cgroup/lib/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/lib/cgroup_util.c
@@ -34,7 +34,7 @@ static void init_metric_mode(void)
 /*
  * Checks if two given values differ by less than err% of their sum.
  */
-int values_close(long a, long b, int err)
+int check_tolerance(long a, long b, int err)
 {
 	return labs(a - b) <= (a + b) / 100 * err;
 }
diff --git a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
index d0e8cfbc3a4b..7b6c51f91937 100644
--- a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
@@ -17,7 +17,7 @@
 #define CG_NAMED_NAME "selftest"
 #define CG_PATH_FORMAT (!cg_test_v1_named ? "0::%s" : (":name=" CG_NAMED_NAME ":%s"))
 
-int values_close(long a, long b, int err);
+int check_tolerance(long a, long b, int err);
 int values_close_report(long a, long b, int err);
 
 extern ssize_t read_text(const char *path, char *buf, size_t max_len);
diff --git a/tools/testing/selftests/cgroup/test_hugetlb_memcg.c b/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
index 856f9508ea56..6d636ef5f95b 100644
--- a/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
+++ b/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
@@ -126,7 +126,7 @@ static int hugetlb_test_program(const char *cgroup, void *arg)
 	check_first(addr);
 	expected_current = old_current + MB(2);
 	current = cg_read_long(test_group, "memory.current");
-	if (!values_close(expected_current, current, 5)) {
+	if (!check_tolerance(expected_current, current, 5)) {
 		ksft_print_msg("memory usage should increase by around 2MB.\n");
 		ksft_print_msg(
 			"expected memory: %ld, actual memory: %ld\n",
@@ -138,7 +138,7 @@ static int hugetlb_test_program(const char *cgroup, void *arg)
 	write_data(addr);
 	current = cg_read_long(test_group, "memory.current");
 	expected_current = old_current + MB(8);
-	if (!values_close(expected_current, current, 5)) {
+	if (!check_tolerance(expected_current, current, 5)) {
 		ksft_print_msg("memory usage should increase by around 8MB.\n");
 		ksft_print_msg(
 			"expected memory: %ld, actual memory: %ld\n",
@@ -150,7 +150,7 @@ static int hugetlb_test_program(const char *cgroup, void *arg)
 	munmap(addr, LENGTH);
 	current = cg_read_long(test_group, "memory.current");
 	expected_current = old_current;
-	if (!values_close(expected_current, current, 5)) {
+	if (!check_tolerance(expected_current, current, 5)) {
 		ksft_print_msg("memory usage should go back down.\n");
 		ksft_print_msg(
 			"expected memory: %ld, actual memory: %ld\n",
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index a680f773f2d5..648a713918e4 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -188,14 +188,14 @@ static int alloc_anon_50M_check(const char *cgroup, void *arg)
 	if (current < size)
 		goto cleanup;
 
-	if (!values_close(size, current, 3))
+	if (!check_tolerance(size, current, 3))
 		goto cleanup;
 
 	anon = cg_read_key_long(cgroup, "memory.stat", "anon ");
 	if (anon < 0)
 		goto cleanup;
 
-	if (!values_close(anon, current, 3))
+	if (!check_tolerance(anon, current, 3))
 		goto cleanup;
 
 	ret = 0;
@@ -226,7 +226,7 @@ static int alloc_pagecache_50M_check(const char *cgroup, void *arg)
 	if (file < 0)
 		goto cleanup;
 
-	if (!values_close(file, current, 10))
+	if (!check_tolerance(file, current, 10))
 		goto cleanup;
 
 	ret = 0;
@@ -558,7 +558,7 @@ static int test_memcg_protection(const char *root, bool min)
 		goto cleanup;
 
 	attempts = 0;
-	while (!values_close(cg_read_long(parent[1], "memory.current"),
+	while (!check_tolerance(cg_read_long(parent[1], "memory.current"),
 			     MB(150), 3)) {
 		if (attempts++ > 5)
 			break;
@@ -568,16 +568,16 @@ static int test_memcg_protection(const char *root, bool min)
 	if (cg_run(parent[2], alloc_anon, (void *)MB(148)))
 		goto cleanup;
 
-	if (!values_close(cg_read_long(parent[1], "memory.current"), MB(50), 3))
+	if (!check_tolerance(cg_read_long(parent[1], "memory.current"), MB(50), 3))
 		goto cleanup;
 
 	for (i = 0; i < ARRAY_SIZE(children); i++)
 		c[i] = cg_read_long(children[i], "memory.current");
 
-	if (!values_close(c[0], MB(29), 15))
+	if (!check_tolerance(c[0], MB(29), 15))
 		goto cleanup;
 
-	if (!values_close(c[1], MB(21), 20))
+	if (!check_tolerance(c[1], MB(21), 20))
 		goto cleanup;
 
 	if (c[3] != 0)
@@ -593,7 +593,7 @@ static int test_memcg_protection(const char *root, bool min)
 	}
 
 	current = min ? MB(50) : MB(30);
-	if (!values_close(cg_read_long(parent[1], "memory.current"), current, 3))
+	if (!check_tolerance(cg_read_long(parent[1], "memory.current"), current, 3))
 		goto cleanup;
 
 	if (!reclaim_until(children[0], MB(10)))
@@ -681,7 +681,7 @@ static int alloc_pagecache_max_30M(const char *cgroup, void *arg)
 		goto cleanup;
 
 	current = cg_read_long(cgroup, "memory.current");
-	if (!values_close(current, MB(30), 5))
+	if (!check_tolerance(current, MB(30), 5))
 		goto cleanup;
 
 	ret = 0;
@@ -893,7 +893,7 @@ static bool reclaim_until(const char *memcg, long goal)
 	for (retries = 5; retries > 0; retries--) {
 		current = cg_read_long(memcg, "memory.current");
 
-		if (current < goal || values_close(current, goal, 3))
+		if (current < goal || check_tolerance(current, goal, 3))
 			break;
 		/* Did memory.reclaim return 0 incorrectly? */
 		else if (reclaimed)
@@ -954,7 +954,7 @@ static int test_memcg_reclaim(const char *root)
 	 * retries).
 	 */
 	retries = 5;
-	while (!values_close(cg_read_long(memcg, "memory.current"),
+	while (!check_tolerance(cg_read_long(memcg, "memory.current"),
 			    expected_usage, 10)) {
 		if (retries--) {
 			sleep(1);
@@ -1001,12 +1001,12 @@ static int alloc_anon_50M_check_swap(const char *cgroup, void *arg)
 		*ptr = 0;
 
 	mem_current = cg_read_long(cgroup, "memory.current");
-	if (!mem_current || !values_close(mem_current, mem_max, 3))
+	if (!mem_current || !check_tolerance(mem_current, mem_max, 3))
 		goto cleanup;
 
 	swap_current = cg_read_long(cgroup, "memory.swap.current");
 	if (!swap_current ||
-	    !values_close(mem_current + swap_current, size, 3))
+	    !check_tolerance(mem_current + swap_current, size, 3))
 		goto cleanup;
 
 	ret = 0;
@@ -1358,7 +1358,7 @@ static int tcp_client(const char *cgroup, unsigned short port)
 			goto close_sk;
 
 		/* exclude the memory not related to socket connection */
-		if (values_close(current - allocated, sock, 10)) {
+		if (check_tolerance(current - allocated, sock, 10)) {
 			ret = KSFT_PASS;
 			break;
 		}
-- 
2.51.0


