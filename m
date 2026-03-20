Return-Path: <cgroups+bounces-14971-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Or0BbaxvWlBAgMAu9opvQ
	(envelope-from <cgroups+bounces-14971-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 21:44:38 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7BF2E0F6F
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 21:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB3C130364EC
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A89C3603EC;
	Fri, 20 Mar 2026 20:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5jNLna5"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E7536074F
	for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 20:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774039400; cv=none; b=NzWsegyJzQakqvKr2JkWDjPvzsF0CCpfM6n56isVimlZudrH7/PNuUSzK3HLLWFJGRe5gkqMaj5Tnk6qVUV89A/RnLI62U8CM6VdoilslfcLbUxMc3Bf6sDQ7f7cFLTqf/xfb2xKUbVPblel0rBUte3VLq6NZ1hDw9ORBk/F2ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774039400; c=relaxed/simple;
	bh=Gld23NsLrMXSYSW3eDcmAxxvCImEOQO1cTBsrXwKgjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8EwmKjvWrbRd67BWtsrYKiXjDSKb6CP1Gnx8g6FwJotgUsFdDiMuOIUmcDehZbpN//8Dm5NELew4FxjJunNMfgwO+H82rDyD9eKTg8KkV9S8EP4yFhZMWEmI/79sBRr2+JfiQFP0CUVaHAnFlOP3/0FAFVaRrvrf1jjgMryQR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b5jNLna5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774039398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sWc/eXILLPmBL1iupIXOD8iHNU0S9z1ohodxLQi1ngI=;
	b=b5jNLna5M1ToexpT0L0Xe4dO+EVeGaeSPD1Al0A75zAJwu2/ukFFas/CtBkiVpWPs9l2vH
	TIOFFUoXcVVVxPhHvrWukzl3ru7UHreB8XbK+5unstItnjav3uL6p6rjMouvN5mqZnHILW
	txJA9AoyOklG84KLUcDN6Mr+5PI2HXY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-hpJT8OQ1PLCcw0oAZgxppw-1; Fri,
 20 Mar 2026 16:43:14 -0400
X-MC-Unique: hpJT8OQ1PLCcw0oAZgxppw-1
X-Mimecast-MFC-AGG-ID: hpJT8OQ1PLCcw0oAZgxppw_1774039391
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32B621956055;
	Fri, 20 Mar 2026 20:43:11 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.139])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F2F95180075B;
	Fri, 20 Mar 2026 20:43:07 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	James Houghton <jthoughton@google.com>,
	Sebastian Chlad <sebastianchlad@gmail.com>,
	Guopeng Zhang <zhangguopeng@kylinos.cn>,
	Li Wang <liwan@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2 4/7] selftests: memcg: Increase error tolerance in accordance with page size
Date: Fri, 20 Mar 2026 16:42:38 -0400
Message-ID: <20260320204241.1613861-5-longman@redhat.com>
In-Reply-To: <20260320204241.1613861-1-longman@redhat.com>
References: <20260320204241.1613861-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14971-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA7BF2E0F6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It was found that some of the tests in test_memcontrol can fail more
readily if system page size is larger than 4k. It is because the
actual memory.current value deviates more from the expected value with
larger page size. This is likely due to the fact there may be up to
MEMCG_CHARGE_BATCH pages of charge hidden in each one of the percpu
memcg_stock.

To avoid this failure, the error tolerance is now increased in accordance
to the current system page size value. The page size scale factor is
set to 2 for 64k page and 1 for 16k page.

Changes are made in alloc_pagecache_max_30M(), test_memcg_protection()
and alloc_anon_50M_check_swap() to increase the error tolerance for
memory.current for larger page size. The current set of values are
chosen to ensure that the relevant test_memcontrol tests no longer
have any test failure in a 100 repeated run of test_memcontrol with a
4k/16k/64k page size kernels on an arm64 system.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 .../cgroup/lib/include/cgroup_util.h          |  3 ++-
 .../selftests/cgroup/test_memcontrol.c        | 23 ++++++++++++++-----
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
index 77f386dab5e8..2293e770e9b4 100644
--- a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
@@ -6,7 +6,8 @@
 #define PAGE_SIZE 4096
 #endif
 
-#define MB(x) (x << 20)
+#define KB(x) ((x) << 10)
+#define MB(x) ((x) << 20)
 
 #define USEC_PER_SEC	1000000L
 #define NSEC_PER_SEC	1000000000L
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index babbfad10aaf..c078fc458def 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -26,6 +26,7 @@
 static bool has_localevents;
 static bool has_recursiveprot;
 static int page_size;
+static int pscale_factor;	/* Page size scale factor */
 
 int get_temp_fd(void)
 {
@@ -571,16 +572,17 @@ static int test_memcg_protection(const char *root, bool min)
 	if (cg_run(parent[2], alloc_anon, (void *)MB(148)))
 		goto cleanup;
 
-	if (!values_close(cg_read_long(parent[1], "memory.current"), MB(50), 3))
+	if (!values_close(cg_read_long(parent[1], "memory.current"), MB(50),
+				       3 + (min ? 0 : 4) * pscale_factor))
 		goto cleanup;
 
 	for (i = 0; i < ARRAY_SIZE(children); i++)
 		c[i] = cg_read_long(children[i], "memory.current");
 
-	if (!values_close(c[0], MB(29), 15))
+	if (!values_close(c[0], MB(29), 15 + 3 * pscale_factor))
 		goto cleanup;
 
-	if (!values_close(c[1], MB(21), 20))
+	if (!values_close(c[1], MB(21), 20 + pscale_factor))
 		goto cleanup;
 
 	if (c[3] != 0)
@@ -596,7 +598,8 @@ static int test_memcg_protection(const char *root, bool min)
 	}
 
 	current = min ? MB(50) : MB(30);
-	if (!values_close(cg_read_long(parent[1], "memory.current"), current, 3))
+	if (!values_close(cg_read_long(parent[1], "memory.current"), current,
+				       9 + (min ? 0 : 6) * pscale_factor))
 		goto cleanup;
 
 	if (!reclaim_until(children[0], MB(10)))
@@ -684,7 +687,7 @@ static int alloc_pagecache_max_30M(const char *cgroup, void *arg)
 		goto cleanup;
 
 	current = cg_read_long(cgroup, "memory.current");
-	if (!values_close(current, MB(30), 5))
+	if (!values_close(current, MB(30), 5 + (pscale_factor ? 2 : 0)))
 		goto cleanup;
 
 	ret = 0;
@@ -1004,7 +1007,7 @@ static int alloc_anon_50M_check_swap(const char *cgroup, void *arg)
 		*ptr = 0;
 
 	mem_current = cg_read_long(cgroup, "memory.current");
-	if (!mem_current || !values_close(mem_current, mem_max, 3))
+	if (!mem_current || !values_close(mem_current, mem_max, 6 + pscale_factor))
 		goto cleanup;
 
 	swap_current = cg_read_long(cgroup, "memory.swap.current");
@@ -1684,6 +1687,14 @@ int main(int argc, char **argv)
 	if (page_size <= 0)
 		page_size = PAGE_SIZE;
 
+	/*
+	 * It is found that the actual memory.current value can deviate more
+	 * from the expected value with larger page size. So error tolerance
+	 * will have to be increased a bit more for larger page size.
+	 */
+	if (page_size > KB(4))
+		pscale_factor = (page_size >= KB(64)) ? 2 : 1;
+
 	ksft_print_header();
 	ksft_set_plan(ARRAY_SIZE(tests));
 	if (cg_find_unified_root(root, sizeof(root), NULL))
-- 
2.53.0


