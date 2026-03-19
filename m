Return-Path: <cgroups+bounces-14919-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MxKBJo1vGl3uwIAu9opvQ
	(envelope-from <cgroups+bounces-14919-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 18:42:50 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 778A32D02E3
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 18:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13545306BE0E
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 17:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C1B3E0C54;
	Thu, 19 Mar 2026 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTFY0yJc"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601D63DEFE0
	for <cgroups@vger.kernel.org>; Thu, 19 Mar 2026 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941958; cv=none; b=MyjhGavteht1L3cibPCBvyWvnS6oAzfbNz1WCZ4ffAS8WM7eyoBsH6OOYDAUJaReN3NdwSOk2rTqDxKmnXskWERlZvhhBN/BYmaA2ual65TmXCflVzU9w73KR1EVJ58x919WCTZP6qiEPmLWNi7I6j1ZOQd05a3TkBPWVcAfXi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941958; c=relaxed/simple;
	bh=1YF3Po/hWcN908df/JjlPnlSCsp5XMq/OPhqEQrLq8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YaR6GwMz3n2V3hkNNnlp0JM1h0h3IOJKdFqZ9v4Kh4vWTDTCewMkK87w6r0yP2nUXa4iX3m9esCLteTh7rtlrurrOwXYWv/QCVB+l3ecxeOlQuvoG/p++dgc2NCJfX41FzlpyTO4uN2AVtztTA3BFbNqb9qJQ0n46U1U7H6XDyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BTFY0yJc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773941951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dNJ6Lq8/T1XPjKqwxrWp5F2Bbd2jRHO9QNryMAsqUQU=;
	b=BTFY0yJcTVNb7qCVvr8B5wtw4c0H2No3xheW3Sm6qI8r8yJt1nh/8Hq4cvpXmlFa3uI/Gw
	YMwgGiH4d8SMwpY08iSiiI6VOcAclWtWQi9rkW60+D3Wl33FAVoj85rZu2vH7OBdS/lRqW
	+eCMHBWmrdrHHUIjsnKR11Yt7t02b2Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-31Ev_X7TNdGagwe5I4LhcA-1; Thu,
 19 Mar 2026 13:39:05 -0400
X-MC-Unique: 31Ev_X7TNdGagwe5I4LhcA-1
X-Mimecast-MFC-AGG-ID: 31Ev_X7TNdGagwe5I4LhcA_1773941942
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A0481944F05;
	Thu, 19 Mar 2026 17:39:02 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.194])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7068D30001A1;
	Thu, 19 Mar 2026 17:38:59 +0000 (UTC)
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
Subject: [PATCH 4/7] selftests: memcg: Increase error tolerance in accordance with page size
Date: Thu, 19 Mar 2026 13:37:49 -0400
Message-ID: <20260319173752.1472864-5-longman@redhat.com>
In-Reply-To: <20260319173752.1472864-1-longman@redhat.com>
References: <20260319173752.1472864-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
	TAGGED_FROM(0.00)[bounces-14919-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.959];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 778A32D02E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It was found that some of the tests in test_memcontrol can fail more
readily if system page size is larger than 4k. It is because the actual
memory.current value deviates more from the expected value with larger
page size.  To avoid this failure, the error tolerance is now increased
in accordance to the current system page size value. The page size
scale factor is set to 2 for 64k page and 1 for 16k page.

Changes are made in alloc_pagecache_max_30M(), test_memcg_protection()
and alloc_anon_50M_check_swap() to increase the error tolerance for
memory.current for larger page size. The current set of values are
chosen to ensure that the relevant test_memcontrol tests no longer
have any test failure in a 100 repeated run of test_memcontrol with a
4k/16k/64k page size kernels on an arm64 system.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 .../cgroup/lib/include/cgroup_util.h          |  1 +
 .../selftests/cgroup/test_memcontrol.c        | 23 ++++++++++++++-----
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
index 77f386dab5e8..c25228a78b8b 100644
--- a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
@@ -6,6 +6,7 @@
 #define PAGE_SIZE 4096
 #endif
 
+#define KB(x) (x << 10)
 #define MB(x) (x << 20)
 
 #define USEC_PER_SEC	1000000L
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 3cc8a432be91..2c3a838536ae 100644
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
@@ -1681,6 +1684,14 @@ int main(int argc, char **argv)
 	int i, proc_status;
 
 	page_size = sysconf(_SC_PAGE_SIZE);
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


