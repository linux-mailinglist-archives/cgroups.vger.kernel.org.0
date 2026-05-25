Return-Path: <cgroups+bounces-16248-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kF3PONI/FGoXLQcAu9opvQ
	(envelope-from <cgroups+bounces-16248-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 14:25:54 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 592E05CA721
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 14:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6D6030247D0
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 12:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB0037FF79;
	Mon, 25 May 2026 12:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjqsmwDD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67553381AFB
	for <cgroups@vger.kernel.org>; Mon, 25 May 2026 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711808; cv=none; b=l2TEyIvi0fbU0v42E7tcC+dEN25LmIoXUFOY4lUHJx2tdp3I4WZMzenGaXDXaRla+n+QNcXm2GeBKlC3+yo7e9Ohisl5CmY7qYP1R20SRNr1K6UBBPLLc0VSQTLFS3lWLQgu+1tcQppt9wy7hQy5SSvB2Pi2Cx86QRfzDuTteY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711808; c=relaxed/simple;
	bh=oVfz0NI3eMBWkf2nwjQsUdGr3PbUSqFjsVO3o+rWEtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j1WFbHsy2sLAJgoe3pFL8f9jx3qTT03f5LyqFTT0XhUeSlYpgVGXLCeEXYhFeyiR7idx8oqhT4HhPK6oYg4CrQOjo3kunHAj8MhwG2H6XrKLHcA7MYCdmoLHCpg8UiEXRTQwuZf6oviwk3APhbi0DMExQsJAYNKEC84ecU11Oxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjqsmwDD; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36ab8816a35so709263a91.1
        for <cgroups@vger.kernel.org>; Mon, 25 May 2026 05:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779711806; x=1780316606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDMvc5EPEd1kHb+nfQyiXVYziOBu/xsFB5tWsJV33wo=;
        b=MjqsmwDDWChYrYwj+5SFuKVwHk5Yc31AC7D0YvyIWzFc3XJosKB6BOR1YdlJ0bxZ/y
         GtCs5RcdU2lXWcaUbZJka8+YrgmL0a6QqKoSP0bHE5L/u0scKnJKgEf6egKm756LX3Xv
         bwSiUI6mX7ubfRYmJWJVnH5yMYsHSo5aDmICQz3b4e6aalfc+9eq3CLgyQbTSx+yyXq7
         XBXmC/ydNZRP4Z2ptBMJcZLeJprHc8T83PkLuvwoY3C+rSfT/0cz3cY9wV84jCjq1jfB
         P29cHcHIEhWt+yAyQVJdOO5nUuQOq9PaeFUosCw6ow8CErfuxIDHYx2I6S+lZ3YbrP7w
         YrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779711806; x=1780316606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tDMvc5EPEd1kHb+nfQyiXVYziOBu/xsFB5tWsJV33wo=;
        b=JehW5bfuBQXg6hhtNAVrv6x3o0IAEFX5NhDHTpsS+REC3e7yx8D2+0d9w4XHzCAwir
         ISpspmA6kql4+hrqKOtl2DgYkXc+pi3DzsiDlfem5iRrP99v6Xf3aeYTONtgROlhwLYO
         Iv1BaKBDJVtnjHgE+5eMA6FGBivYCU0+KgO8sqyeAjDh/oGGOHAXf9KKh36uc9JUhgp+
         LrelieQID/2YbvqUCk62AyNsNwu8eKQ6wSVSWc2RLgA0D5XT0NH+VTjLJGEzAfFErOBi
         x7MB3zJ7ujXQ4PkgI/4HQZP+wsPfzYgjxSbj2I86LIvN+nwd4PC7HaSsSlfYOUDqFk0K
         17xQ==
X-Gm-Message-State: AOJu0Yx7zFmYzdE/HxNQrN3CeGmy1TnXAlb4k5ZdYIiSHFEdIa5YA27T
	I2FBvZKzsRAiWG0ugwY8foyS1OWs+ZFWNUo6K0t1fLOT85GVXmTqX5vx
X-Gm-Gg: Acq92OHaMZqxW5YEbM0cZGL1m8ZPaLCR7uyOWTMkgigVYtaDdv+QbzeJvXKckiPFVpf
	m60wjtRhHzzpk1ChCq5Lk7knCIHzKQfY+rHAoYorhZEiJYEjyL1rCTs1+mHEqcUmkeqUVycpr6q
	6VgdqAquKnzOyDNYtzNaDiICKrmPDY1wTggmkIrETjNsZylRljtKbfCFVmdwf4xVUX5yjO+b1HS
	E5Fpq3KSFR+Ou0Q1GIujFTHw62b0UT+tAZWJFBcMr8bXM0FtNK+aAZFs2zh2na2NwuRSGPgeJ6u
	1ht8/6J/SOkoA+G1hYJzIsobyQPw1aDWHeuKdPbsUD3IFYNb8N4Pa85G1ZTgniKBAYOK2WrmGSG
	xZNCmWPHZJPrMEh+4cGGuxsTBkoozeqVMVT774FYQoZxnHta1x/uTdEc2E6+Z6M8BFqfST287jM
	fgcE7hYWH5VncyJ/5oa0DE+HdTMAAICJku8wydhBubEpTfioGFNo8=
X-Received: by 2002:a17:90b:2cc4:b0:36a:35df:769c with SMTP id 98e67ed59e1d1-36a67505a3fmr14458568a91.15.1779711805868;
        Mon, 25 May 2026 05:23:25 -0700 (PDT)
Received: from localhost.localdomain ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a72c913a1sm8999131a91.15.2026.05.25.05.23.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 May 2026 05:23:25 -0700 (PDT)
From: Hao Jia <jiahao.kernel@gmail.com>
To: akpm@linux-foundation.org,
	tj@kernel.org,
	hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	mhocko@kernel.org,
	yosry@kernel.org,
	mkoutny@suse.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Hao Jia <jiahao1@lixiang.com>
Subject: [PATCH v2 4/4] selftests/cgroup: Add tests for zswap proactive writeback
Date: Mon, 25 May 2026 20:22:42 +0800
Message-Id: <20260525122242.36127-5-jiahao.kernel@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260525122242.36127-1-jiahao.kernel@gmail.com>
References: <20260525122242.36127-1-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16248-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lixiang.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 592E05CA721
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Hao Jia <jiahao1@lixiang.com>

Add test_zswap_proactive_writeback() to cover the new memory.reclaim
"zswap_writeback_only" key. The test populates a memory cgroup zswap
pool, triggers proactive writeback, and verifies the behavior by
observing the change in zswpwb_proactive. Invalid input combinations
are also covered.

Extend test_zswap_writeback_one() to assert that the existing
non-proactive writeback path leaves zswpwb_proactive at zero.

Signed-off-by: Hao Jia <jiahao1@lixiang.com>
---
 tools/testing/selftests/cgroup/test_zswap.c | 161 +++++++++++++++++++-
 1 file changed, 153 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index a7bdcdd09d62..b80ed13bc5e2 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -57,6 +57,11 @@ static long get_cg_wb_count(const char *cg)
 	return cg_read_key_long(cg, "memory.stat", "zswpwb");
 }
 
+static long get_cg_pwb_count(const char *cg)
+{
+	return cg_read_key_long(cg, "memory.stat", "zswpwb_proactive");
+}
+
 static long get_zswpout(const char *cgroup)
 {
 	return cg_read_key_long(cgroup, "memory.stat", "zswpout ");
@@ -323,11 +328,17 @@ static int attempt_writeback(const char *cgroup, void *arg)
 
 static int test_zswap_writeback_one(const char *cgroup, bool wb)
 {
-	long zswpwb_before, zswpwb_after;
+	long wb_cnt, pwb_cnt;
+
+	wb_cnt = get_cg_wb_count(cgroup);
+	if (wb_cnt != 0) {
+		ksft_print_msg("zswpwb_before = %ld instead of 0\n", wb_cnt);
+		return -1;
+	}
 
-	zswpwb_before = get_cg_wb_count(cgroup);
-	if (zswpwb_before != 0) {
-		ksft_print_msg("zswpwb_before = %ld instead of 0\n", zswpwb_before);
+	pwb_cnt = get_cg_pwb_count(cgroup);
+	if (pwb_cnt != 0) {
+		ksft_print_msg("zswpwb_proactive_before = %ld instead of 0\n", pwb_cnt);
 		return -1;
 	}
 
@@ -335,13 +346,24 @@ static int test_zswap_writeback_one(const char *cgroup, bool wb)
 		return -1;
 
 	/* Verify that zswap writeback occurred only if writeback was enabled */
-	zswpwb_after = get_cg_wb_count(cgroup);
-	if (zswpwb_after < 0)
+	wb_cnt = get_cg_wb_count(cgroup);
+	if (wb_cnt < 0)
 		return -1;
 
-	if (wb != !!zswpwb_after) {
+	if (wb != !!wb_cnt) {
 		ksft_print_msg("zswpwb_after is %ld while wb is %s\n",
-				zswpwb_after, wb ? "enabled" : "disabled");
+				wb_cnt, wb ? "enabled" : "disabled");
+		return -1;
+	}
+
+	/*
+	 * attempt_writeback() does not use the proactive writeback path, so
+	 * zswpwb_proactive must stay at zero regardless of whether writeback
+	 * was enabled.
+	 */
+	pwb_cnt = get_cg_pwb_count(cgroup);
+	if (pwb_cnt != 0) {
+		ksft_print_msg("zswpwb_proactive_after is %ld, expected 0\n", pwb_cnt);
 		return -1;
 	}
 
@@ -709,6 +731,128 @@ static int test_zswap_incompressible(const char *root)
 	return ret;
 }
 
+/*
+ * Trigger proactive zswap writeback with the following steps:
+ * 1. Allocate memory.
+ * 2. Push allocated memory into zswap.
+ * 3. Proactively write back zswap pages to swap
+ *    using "zswap_writeback_only".
+ */
+static int proactive_writeback_workload(const char *cgroup, void *arg)
+{
+	long pagesize = sysconf(_SC_PAGESIZE);
+	size_t memsize = MB(4);
+	char reclaim_cmd[64];
+	char buf[pagesize];
+	int ret = -1;
+	char *mem;
+
+	mem = (char *)malloc(memsize);
+	if (!mem)
+		return ret;
+
+	for (int i = 0; i < pagesize; i++)
+		buf[i] = i < pagesize / 2 ? (char)i : 0;
+	for (int i = 0; i < memsize; i += pagesize)
+		memcpy(&mem[i], buf, pagesize);
+
+	/* Evict allocated memory into zswap. */
+	if (cg_write_numeric(cgroup, "memory.reclaim", memsize)) {
+		ksft_print_msg("Failed to push pages into zswap\n");
+		goto out;
+	}
+
+	/* Trigger proactive zswap writeback for the same amount. */
+	snprintf(reclaim_cmd, sizeof(reclaim_cmd), "%zu zswap_writeback_only", memsize);
+	if (cg_write(cgroup, "memory.reclaim", reclaim_cmd)) {
+		ksft_print_msg("memory.reclaim zswap_writeback_only failed\n");
+		goto out;
+	}
+
+	ret = 0;
+out:
+	free(mem);
+	return ret;
+}
+
+static int check_writeback_invalid_inputs(const char *cgroup)
+{
+	static char * const bad_inputs[] = {
+		"zswap_writeback_only",
+		"1M zswap_writeback_only swappiness=60",
+		"1M swappiness=60 zswap_writeback_only",
+		"1M zswap_writeback_only swappiness=max",
+		"1M swappiness=max zswap_writeback_only",
+	};
+	int i, rc;
+
+	for (i = 0; i < ARRAY_SIZE(bad_inputs); i++) {
+		rc = cg_write(cgroup, "memory.reclaim", bad_inputs[i]);
+		if (rc != -EINVAL) {
+			ksft_print_msg("memory.reclaim '%s': returned %d, expected %d\n",
+				       bad_inputs[i], rc, -EINVAL);
+			return -1;
+		}
+	}
+	return 0;
+}
+
+static int test_zswap_proactive_writeback(const char *root)
+{
+	long pwb_before, wb_before, pwb_after, wb_after;
+	long pwb_delta, wb_delta;
+	int ret = KSFT_FAIL;
+	char *test_group;
+
+	if (cg_read_strcmp(root, "memory.zswap.writeback", "1"))
+		return KSFT_SKIP;
+
+	test_group = cg_name(root, "zswap_proactive_test");
+	if (!test_group)
+		return KSFT_FAIL;
+	if (cg_create(test_group))
+		goto out;
+	if (check_writeback_invalid_inputs(test_group))
+		goto out;
+
+	pwb_before = get_cg_pwb_count(test_group);
+	wb_before = get_cg_wb_count(test_group);
+	if (pwb_before < 0 || wb_before < 0)
+		goto out;
+
+	if (cg_run(test_group, proactive_writeback_workload, NULL))
+		goto out;
+
+	pwb_after = get_cg_pwb_count(test_group);
+	wb_after = get_cg_wb_count(test_group);
+	if (pwb_after < 0 || wb_after < 0)
+		goto out;
+
+	pwb_delta = pwb_after - pwb_before;
+	wb_delta = wb_after - wb_before;
+
+	if (pwb_delta <= 0) {
+		ksft_print_msg("zswpwb_proactive did not increase: delta=%ld\n",
+			       pwb_delta);
+		goto out;
+	}
+	if (wb_delta <= 0) {
+		ksft_print_msg("zswpwb did not increase: delta=%ld\n", wb_delta);
+		goto out;
+	}
+	if (pwb_delta > wb_delta) {
+		ksft_print_msg("zswpwb_proactive delta (%ld) > zswpwb delta (%ld)\n",
+			       pwb_delta, wb_delta);
+		goto out;
+	}
+
+	ret = KSFT_PASS;
+out:
+	cg_destroy(test_group);
+	free(test_group);
+	return ret;
+}
+
 #define T(x) { x, #x }
 struct zswap_test {
 	int (*fn)(const char *root);
@@ -722,6 +866,7 @@ struct zswap_test {
 	T(test_no_kmem_bypass),
 	T(test_no_invasive_cgroup_shrink),
 	T(test_zswap_incompressible),
+	T(test_zswap_proactive_writeback),
 };
 #undef T
 
-- 
2.34.1


