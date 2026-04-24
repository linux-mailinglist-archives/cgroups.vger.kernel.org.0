Return-Path: <cgroups+bounces-15483-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK/vHEDr6mnCFgAAu9opvQ
	(envelope-from <cgroups+bounces-15483-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 06:02:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A26459955
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 06:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0047B301C6FB
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 04:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7F232AAC6;
	Fri, 24 Apr 2026 04:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oeHyCQPN"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81D0237713;
	Fri, 24 Apr 2026 04:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777003289; cv=none; b=k/d5zdTxC1TlGxOKuNkc9x3WWvixcQJcbWhSOzNZ0JmGfmaGGlQSfP/zbisQWx480hDDlIrcQfqQUY1aiATVZYIxIIT+hsm/pU0TEnPzPgs8TY8ChjiJQGK5RtTlPRKrh3Uk8FTl9eu0FX3cQbyPL6N00caO4fnprW6tNh3deQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777003289; c=relaxed/simple;
	bh=wlAlwZ0KZImscE1SdwipDWwqojceWrUohq/ClmcbXAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eqJ7wfn6ZTx4ocvpJvNKom0YWd/DQ6dgxJL6a23aaol2vfRX9uV6UvIiydUv6NvgAZfo5KP7+DpYCY7RWeaspfCywy4vXTQRxh/mcSIZUGcNYhm1y6Yrbu12mfC804DKtlV4ksZz1dUY+Y0x1B6nHpTZl7ssfp0ztf4SX0Q/tfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oeHyCQPN; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777003286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gr8asudXbZcTLEQoBtpdGFZE+1tjsTEgxDXHfEmUBuk=;
	b=oeHyCQPN6+7SzNn3zyt6SJZNgJ5tcf7mfOBQNDb1ZmDi/X56dFl5cpn+kLCtEXxwA4x31x
	tTcK0JLkTWi8s/gOpfklOW8MpGl/JoIh6j8u8MeRtBdpu2GYmpOTVF9Ujdqzh7mSpYFkxP
	4qmDHAwU+GLrCHoCPn8itn3iGnIBjRY=
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
Subject: [PATCH v7 1/8] selftests/cgroup: skip test_zswap if zswap is globally disabled
Date: Fri, 24 Apr 2026 12:00:52 +0800
Message-ID: <20260424040059.12940-2-li.wang@linux.dev>
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
X-Rspamd-Queue-Id: 36A26459955
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15483-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,suse.com:email]

test_zswap currently only checks whether zswap is present by testing
/sys/module/zswap. This misses the runtime global state exposed in
/sys/module/zswap/parameters/enabled.

When zswap is built/loaded but globally disabled, the zswap cgroup
selftests run in an invalid environment and may fail spuriously.

Check the runtime enabled state before running the tests:
  - skip if zswap is not configured,
  - fail if the enabled knob cannot be read,
  - skip if zswap is globally disabled.

Also print a hint in the skip message on how to enable zswap.

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
Acked-by: Yosry Ahmed <yosry@kernel.org>
Acked-by: Nhat Pham <nphamcs@gmail.com>
---
 tools/testing/selftests/cgroup/test_zswap.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index a7bdcdd09d6..a94238a2e04 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -15,6 +15,9 @@
 #include "kselftest.h"
 #include "cgroup_util.h"
 
+#define PATH_ZSWAP "/sys/module/zswap"
+#define PATH_ZSWAP_ENABLED "/sys/module/zswap/parameters/enabled"
+
 static int read_int(const char *path, size_t *value)
 {
 	FILE *file;
@@ -725,9 +728,18 @@ struct zswap_test {
 };
 #undef T
 
-static bool zswap_configured(void)
+static void check_zswap_enabled(void)
 {
-	return access("/sys/module/zswap", F_OK) == 0;
+	char value[2];
+
+	if (access(PATH_ZSWAP, F_OK))
+		ksft_exit_skip("zswap isn't configured\n");
+
+	if (read_text(PATH_ZSWAP_ENABLED, value, sizeof(value)) <= 0)
+		ksft_exit_fail_msg("Failed to read " PATH_ZSWAP_ENABLED "\n");
+
+	if (value[0] == 'N')
+		ksft_exit_skip("zswap is disabled (hint: echo 1 > " PATH_ZSWAP_ENABLED ")\n");
 }
 
 int main(int argc, char **argv)
@@ -740,8 +752,7 @@ int main(int argc, char **argv)
 	if (cg_find_unified_root(root, sizeof(root), NULL))
 		ksft_exit_skip("cgroup v2 isn't mounted\n");
 
-	if (!zswap_configured())
-		ksft_exit_skip("zswap isn't configured\n");
+	check_zswap_enabled();
 
 	/*
 	 * Check that memory controller is available:
-- 
2.53.0


