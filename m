Return-Path: <cgroups+bounces-15490-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDW9Lu3r6mnCFgAAu9opvQ
	(envelope-from <cgroups+bounces-15490-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 06:05:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40092459A17
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 06:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AECB33016294
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 04:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99CD32695F;
	Fri, 24 Apr 2026 04:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u2UUUdOL"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC45431E107
	for <cgroups@vger.kernel.org>; Fri, 24 Apr 2026 04:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777003381; cv=none; b=TOcw4JFsQTnBg2bcIzivHFtIqFFDa0zgZGsJeaDCG7eZOUdhsqlzyNQRHSkFgkK0tBEFX/bSC3eaN80SZeluBC9O3JWYE+vCKQrUq9ssNkHU9kDbHLueSdtYyr27emQROmeOhFs+LyK6OIB9KawqBz/HgCsXw3vO1k/a3kPbk3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777003381; c=relaxed/simple;
	bh=CMNT5sN5+7AQKjMXzhi6cwxcBwvcrLjWcEFHTXWjp/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sKI9WAXz6Sf95+A5m8Q0PL8t9eNzcthplAv6Dexvugi5V+MFeMtV3nG+pKp0+QjofKrIt3Pk+33HZFGXpn643ybbP+tbF0OGuMOm0e3ZA2F7pCuxVpej+O9LjakqH8ayZNQ5O4B2m+776Q7Phd9vpDu6H9ujRtB/KSWl7L+3mE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u2UUUdOL; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777003378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VcJ71eB0Ct26LCodBxWEDWyUKWisA2ZlGgHlF6yt2M8=;
	b=u2UUUdOLq/sTdbKir0hjZ104Y8LIJpS74cn7qDT1LzGQvC8x59z4JKTAYYFv+Mi2wy77jP
	0erlRvbTWrp6xVDva3XA8Q9mWdOuWMDPKHx9XMzdrSkIVihGcR7+omGvoVjKtNcjcQJGTn
	HOhQ3z3hpFynAlwnZwurAZ3K3oZ/krY=
From: Li Wang <li.wang@linux.dev>
To: akpm@linux-foundation.org,
	tj@kernel.org,
	longman@redhat.com,
	roman.gushchin@linux.dev,
	hannes@cmpxchg.org,
	yosry@kernel.org,
	jiayuan.chen@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	mkoutny@suse.com,
	shuah@kernel.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH v7 8/8] selftests/cgroup: test_zswap: wait for asynchronous writeback
Date: Fri, 24 Apr 2026 12:00:59 +0800
Message-ID: <20260424040059.12940-9-li.wang@linux.dev>
In-Reply-To: <20260424040059.12940-1-li.wang@linux.dev>
References: <20260424040059.12940-1-li.wang@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 40092459A17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15490-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,redhat.com,linux.dev,cmpxchg.org,gmail.com,suse.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[li.wang@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,linux.dev:email,linux.dev:dkim,linux.dev:mid,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

zswap writeback is asynchronous, but test_zswap.c checks writeback
counters immediately after reclaim/trigger paths. On some platforms
(e.g. ppc64le), this can race with background writeback and cause
spurious failures even when behavior is correct.

Add wait_for_writeback() to poll get_cg_wb_count() with a bounded
timeout, and use it in:

  test_zswap_writeback_one() when writeback is expected
  test_no_invasive_cgroup_shrink() for the wb_group check

This keeps the original before/after assertion style while making the
tests robust against writeback completion latency.

No test behavior change, selftest stability improvement only.

Signed-off-by: Li Wang <li.wang@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Michal Koutný <mkoutny@suse.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Nhat Pham <nphamcs@gmail.com>
---
 tools/testing/selftests/cgroup/test_zswap.c | 28 +++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index 5fe0cffb557..49b36ee7916 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -120,6 +120,27 @@ static char *setup_test_group_1M(const char *root, const char *name)
 	return NULL;
 }
 
+/*
+ * Writeback is asynchronous; poll until at least one writeback has
+ * been recorded for @cg, or until @timeout_ms has elapsed.
+ */
+static long wait_for_writeback(const char *cg, int timeout_ms)
+{
+	long elapsed, count;
+	for (elapsed = 0; elapsed < timeout_ms; elapsed += 100) {
+		count = get_cg_wb_count(cg);
+
+		if (count < 0)
+			return -1;
+		if (count > 0)
+			return count;
+
+		usleep(100000);
+	}
+
+	return 0;
+}
+
 /*
  * Sanity test to check that pages are written into zswap.
  */
@@ -345,7 +366,10 @@ static int test_zswap_writeback_one(const char *cgroup, bool wb)
 		return -1;
 
 	/* Verify that zswap writeback occurred only if writeback was enabled */
-	zswpwb_after = get_cg_wb_count(cgroup);
+	if (wb)
+		zswpwb_after = wait_for_writeback(cgroup, 5000);
+	else
+		zswpwb_after = get_cg_wb_count(cgroup);
 	if (zswpwb_after < 0)
 		return -1;
 
@@ -476,7 +500,7 @@ static int test_no_invasive_cgroup_shrink(const char *root)
 	}
 
 	/* Verify that only zswapped memory from gwb_group has been written back */
-	if (get_cg_wb_count(wb_group) > 0 && get_cg_wb_count(zw_group) == 0)
+	if (wait_for_writeback(wb_group, 5000) > 0 && get_cg_wb_count(zw_group) == 0)
 		ret = KSFT_PASS;
 out:
 	cg_enter_current(root);
-- 
2.53.0


