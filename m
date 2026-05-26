Return-Path: <cgroups+bounces-16311-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEZ3GLCIFWqFWQcAu9opvQ
	(envelope-from <cgroups+bounces-16311-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 13:49:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 909DA5D524A
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 13:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 32B3A3017CE0
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 11:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15233E8C47;
	Tue, 26 May 2026 11:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/JxFRE2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DA23EDE78
	for <cgroups@vger.kernel.org>; Tue, 26 May 2026 11:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779796021; cv=none; b=nKJbYsKL6tfxb8PYKtHJVIdmqcrUDWHN2iTQfCqBh3iHfMyoIpEv3/IRkeDfeX8iDWC0UkOWZLVbUfyxtvA4KV/4i6iJGrl+K7IQ4jliKaT9MLU0ZjCT62g4jas9nGG6ipo3jH8b9CI4A4m9lk0TCS9Qvroqo8a7C8coHFcdGyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779796021; c=relaxed/simple;
	bh=KAua5ug0ikJ+vEnPoRL10cFv6cThk1xddjc36M+Xnfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jTqmcgGEhHSHCjXl/YShNxVeuYo3SpR79nb+ePSGmmUZI5b+H+LNPuegRX7tIkMpkdHyh2f1d+zI6Hpeh+0pHqLt/Y4HpgEwdz8jhzD7TKQF0vGf16VWZxNsoUy/rJjY0jRZ4V1/OMgdcLMEupF1NMmX5NBBrkEqlLc2au4jAIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s/JxFRE2; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c7980c060cfso4283636a12.2
        for <cgroups@vger.kernel.org>; Tue, 26 May 2026 04:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779796011; x=1780400811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgSgho/uSma27Dv6R9PjYX30l7Y2Ab+qd5YVtfXCHFQ=;
        b=s/JxFRE2VGoOLDvsRjaRx0888PrcfgdyfstLjkMCZTcxbMy/7ur2WiK8kCPx0iaM+3
         jaYNI5hPMYLq0qBSHr1gAN3PqhoWANjd2slvCbv9QyJCswSogAXbBfiPu24IeeLhcdxI
         AGE3EPE7p6QMo9xw1DB0KnRl0HKy0TO9yDPhTDw1wH2pqE4U/L01xGSMlY50LXg6PoCy
         wREuEF8iG95b3v4lXXlEssD8sts/862IYDVKP9GQw7vBwfY+nVUKkK4IFBwZXIw1zjE8
         knO+wF4X8fL7lxbigdbrXD+CFH8qsUn/8qr8UyKeVfbTeQXwUrBye9ik4bUph920kGpd
         4vFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779796011; x=1780400811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lgSgho/uSma27Dv6R9PjYX30l7Y2Ab+qd5YVtfXCHFQ=;
        b=UsIvHqfb+yl8SUxz/1HBLBLll03DkSJxpiD+iaq1UaTYp5lnHhnHUJjjEjtye54CFB
         f6qgKiR6sIoNb7iU3ltYyZ8InhgPE7e8ItucTVFp76HnBSMDjFyYpKJtKMGJ0+z/v0XD
         BROide9Rc9n3u6yklS+LFxU5eQKjxDBwavbD/BQcBxuvsCCOcFgy9LmYWGqV/lMHu99p
         KGyNzHVRqUS/wT50l9xr1P2vx9AMvRjSng0pWu/jtz46+wAd1vaDihQhGmZ3m79zon9u
         BX0E9i6XNzmzCfKmQ8VP/voBYMFQUooANyy1+GydbGUavbbvH+vqn8L6/P1xBkL6C2xr
         4fwQ==
X-Gm-Message-State: AOJu0Yx4p3f6e1iY6xI3ZVzKoHdxnfhJtU8yHFmCygI9UXxHJGgH7VAS
	iJ78XmyNgNmRiRklM0Al4foYXKTQ6BEU5sgeMHHBan4U6Jcrevumf1LZ
X-Gm-Gg: Acq92OG83ahiT6B47CtJEMHBuQG554fcqk8CrO6YduMrcRUpThMz+xN99QRXimy1zdc
	vMielH540nFA7xbrnJLzoj/z81bzw2wD5fH0VEXSeegZwDAqQnzFX57+CPul+t+S+fDOlT9c/3h
	hQFMWNgCnG94pp9UGbkn8OdLma5YunQ/eMZh09WLuHCXLdj1Yr6n1qLxKTNsKiTBvqaArPfDM34
	ueNmA3NRDt96akiDpj8Vsxu4MjKbwggrVLWDtTikfROOYlIEuSBAaHXpklRR+4L5sjUOibO/DnJ
	SwWb342HAzuQDT3OVsiloRGGsfGHpj9gGzV+PlTg2qB1Kgbg2Aj84Fygo7k13N7HGex1hPGlRfm
	zl2kIgbeVs8psxn1ZCFQBv+TDWa7coUBD3/3GEYhAaQRBBBgjCscQye4QCm70v2j762NfWLw8OP
	l5vCK1HRzLdUNFKNvEu6DtO4kiEYZD+rRcchfBFTDckmM9xjIjpjw=
X-Received: by 2002:a05:6a20:7491:b0:39b:8dcb:f36d with SMTP id adf61e73a8af0-3b328f65039mr18535592637.35.1779796010995;
        Tue, 26 May 2026 04:46:50 -0700 (PDT)
Received: from localhost.localdomain ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c852028fe99sm10304341a12.4.2026.05.26.04.46.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 04:46:50 -0700 (PDT)
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
Subject: [PATCH v3 4/4] selftests/cgroup: Add tests for zswap proactive writeback
Date: Tue, 26 May 2026 19:46:01 +0800
Message-Id: <20260526114601.67041-5-jiahao.kernel@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260526114601.67041-1-jiahao.kernel@gmail.com>
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16311-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 909DA5D524A
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
 tools/testing/selftests/cgroup/test_zswap.c | 155 +++++++++++++++++++-
 1 file changed, 154 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index 49b36ee79160..6ab9394a37cc 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -60,7 +60,12 @@ static int get_zswap_stored_pages(size_t *value)
 
 static long get_cg_wb_count(const char *cg)
 {
-	return cg_read_key_long(cg, "memory.stat", "zswpwb");
+	return cg_read_key_long(cg, "memory.stat", "zswpwb ");
+}
+
+static long get_cg_pwb_count(const char *cg)
+{
+	return cg_read_key_long(cg, "memory.stat", "zswpwb_proactive ");
 }
 
 static long get_zswpout(const char *cgroup)
@@ -355,6 +360,7 @@ static int attempt_writeback(const char *cgroup, void *arg)
 static int test_zswap_writeback_one(const char *cgroup, bool wb)
 {
 	long zswpwb_before, zswpwb_after;
+	long pwb_cnt;
 
 	zswpwb_before = get_cg_wb_count(cgroup);
 	if (zswpwb_before != 0) {
@@ -362,6 +368,12 @@ static int test_zswap_writeback_one(const char *cgroup, bool wb)
 		return -1;
 	}
 
+	pwb_cnt = get_cg_pwb_count(cgroup);
+	if (pwb_cnt != 0) {
+		ksft_print_msg("zswpwb_proactive_before = %ld instead of 0\n", pwb_cnt);
+		return -1;
+	}
+
 	if (cg_run(cgroup, attempt_writeback, (void *) &wb))
 		return -1;
 
@@ -379,6 +391,17 @@ static int test_zswap_writeback_one(const char *cgroup, bool wb)
 		return -1;
 	}
 
+	/*
+	 * attempt_writeback() does not use the proactive writeback path, so
+	 * zswpwb_proactive must stay at zero regardless of whether writeback
+	 * was enabled.
+	 */
+	pwb_cnt = get_cg_pwb_count(cgroup);
+	if (pwb_cnt != 0) {
+		ksft_print_msg("zswpwb_proactive_after is %ld, expected 0\n", pwb_cnt);
+		return -1;
+	}
+
 	return 0;
 }
 
@@ -770,6 +793,135 @@ static int test_zswap_incompressible(const char *root)
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
+	size_t memsize = page_size * 1024;
+	char reclaim_cmd[64];
+	char buf[page_size];
+	long zswap_usage;
+	int ret = -1;
+	char *mem;
+
+	mem = (char *)malloc(memsize);
+	if (!mem)
+		return ret;
+
+	for (int i = 0; i < page_size; i++)
+		buf[i] = i < page_size / 2 ? (char)i : 0;
+	for (int i = 0; i < memsize; i += page_size)
+		memcpy(&mem[i], buf, page_size);
+
+	/* Evict allocated memory into zswap. */
+	if (cg_write_numeric(cgroup, "memory.reclaim", memsize)) {
+		ksft_print_msg("Failed to push pages into zswap\n");
+		goto out;
+	}
+
+	zswap_usage = cg_read_long(cgroup, "memory.zswap.current");
+	if (zswap_usage <= 0) {
+		ksft_print_msg("no zswap pool to write back\n");
+		goto out;
+	}
+
+	/* Trigger proactive zswap writeback. */
+	snprintf(reclaim_cmd, sizeof(reclaim_cmd), "%zu zswap_writeback_only", memsize);
+	int rc = cg_write(cgroup, "memory.reclaim", reclaim_cmd);
+	if (rc && rc != -EAGAIN) {
+		ksft_print_msg("proactive zswap writeback failed: %d\n", rc);
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
@@ -783,6 +935,7 @@ struct zswap_test {
 	T(test_no_kmem_bypass),
 	T(test_no_invasive_cgroup_shrink),
 	T(test_zswap_incompressible),
+	T(test_zswap_proactive_writeback),
 };
 #undef T
 
-- 
2.34.1


