Return-Path: <cgroups+bounces-15160-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLeoIOIQzmmnkgYAu9opvQ
	(envelope-from <cgroups+bounces-15160-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 02 Apr 2026 08:46:58 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA94384AA3
	for <lists+cgroups@lfdr.de>; Thu, 02 Apr 2026 08:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9258E306787F
	for <lists+cgroups@lfdr.de>; Thu,  2 Apr 2026 06:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B30C374E7D;
	Thu,  2 Apr 2026 06:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0RjGYnY"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB87333442
	for <cgroups@vger.kernel.org>; Thu,  2 Apr 2026 06:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775111915; cv=none; b=pQFvfA9WGX0YSAcJGc0iYp5ynMZ5e9isFtbe31AfQuKvt+l4AjK3oZ0bIH09uVJJkXoL/UUjAHNkUYYA/VYslcvgE9hwbA3wGo4MtzDFQSvmq+35YNIisbQHSa405hxcBn+zYjv5/VFjDyFZJl2ZZmdloCln91W+o7r4E4X0dT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775111915; c=relaxed/simple;
	bh=Lc5dBL8pYJp+rq6/inASVmhrpfGTGZtDvbKk/Z72eNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jK86s7YR92lSaGlsYbzjzjO+G/eMZAokW6jeEYQAwidogpjg/YtnrVctdny4RqgjEvjMY4Q/nnZ/e5UXtf6ZGBZJFiTUYhMag7q0D4086q9vH779o8DIH8Xojm2fOaBfswAbirXSiTPA5jI8EJmVyaSdG4IFg8o5NUKk//6GYYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I0RjGYnY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775111912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ugd9P0cI6Fe499qy5Kl/bBLKO3rB+If5FXFztZIJJ9w=;
	b=I0RjGYnYy2aGky7Pb9fsFXM2zwtnUMtNRQtDk4/0UGYw631QyqkBAJfLss26FTkuPqiisA
	WXWLcOW+L5//1/+yqTiUKzxAz6QIFuX0OPe33xt+7D+mSSMIdtxUVIYiEkRU9Hfze0HkDg
	B7gaczgwqC3NoMLQXRUTiV0H9vgv3UU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-tJ1hc58aOiWuTcCCJ9kzNQ-1; Thu,
 02 Apr 2026 02:38:28 -0400
X-MC-Unique: tJ1hc58aOiWuTcCCJ9kzNQ-1
X-Mimecast-MFC-AGG-ID: tJ1hc58aOiWuTcCCJ9kzNQ_1775111905
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 013F5195607B;
	Thu,  2 Apr 2026 06:38:25 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.112.158])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1CC781800351;
	Thu,  2 Apr 2026 06:38:15 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: akpm@linux-foundation.org,
	rppt@kernel.org,
	david@kernel.org,
	hannes@cmpxchg.org,
	yosry@kernel.org,
	ljs@kernel.org,
	Liam.Howlett@oracle.com,
	mhocko@suse.com,
	shuah@kernel.org,
	chengming.zhou@linux.dev,
	longman@redhat.com,
	nphamcs@gmail.com
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Michal Hocko <mhocko@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH v6 6/8] selftest/cgroup: fix zswap test_no_invasive_cgroup_shrink on large pagesize system
Date: Thu,  2 Apr 2026 14:37:12 +0800
Message-ID: <20260402063714.55124-7-liwang@redhat.com>
In-Reply-To: <20260402063714.55124-1-liwang@redhat.com>
References: <20260402063714.55124-1-liwang@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15160-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,oracle.com,suse.com,linux.dev,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liwang@redhat.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cmpxchg.org:email,linux.dev:email]
X-Rspamd-Queue-Id: 7FA94384AA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

test_no_invasive_cgroup_shrink sets up two cgroups: wb_group, which is
expected to trigger zswap writeback, and a control group (renamed to
zw_group), which should only have pages sitting in zswap without any
writeback.

There are two problems with the current test:

1) The data patterns are reversed. wb_group uses allocate_bytes(), which
   writes only a single byte per page — trivially compressible,
   especially by zstd — so compressed pages fit within zswap.max and
   writeback is never triggered. Meanwhile, the control group uses
   getrandom() to produce hard-to-compress data, but it is the group
   that does *not* need writeback.

2) The test uses fixed sizes (10K zswap.max, 10MB allocation) that are
   too small on systems with large PAGE_SIZE (e.g. 64K), failing to
   build enough memory pressure to trigger writeback reliably.

Fix both issues by:
  - Swapping the data patterns: fill wb_group pages with partially
    random data (getrandom for page_size/4 bytes) to resist compression
    and trigger writeback, and fill zw_group pages with simple repeated
    data to stay compressed in zswap.
  - Making all size parameters PAGE_SIZE-aware: set allocation size to
    PAGE_SIZE * 1024, memory.zswap.max to PAGE_SIZE, and memory.max to
    allocation_size / 2 for both cgroups.
  - Allocating memory inline instead of via cg_run() so the pages
    remain resident throughout the test.

=== Error Log ===
 # getconf PAGESIZE
 65536

 # ./test_zswap
 TAP version 13
 ...
 ok 5 test_zswap_writeback_disabled
 ok 6 # SKIP test_no_kmem_bypass
 not ok 7 test_no_invasive_cgroup_shrink

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Michal Koutný <mkoutny@suse.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Yosry Ahmed <yosryahmed@google.com>
---

Notes:
    v5:
        - Swap data patterns: use getrandom() for wb_group and simple
          memset for zw_group to fix the reversed allocation logic.
        - Rename control_group to zw_group for clarity.
        - Allocate memory inline instead of via cg_run() so pages remain
          resident throughout the test.

 tools/testing/selftests/cgroup/test_zswap.c | 70 ++++++++++++++-------
 1 file changed, 49 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index db4889bef6d4..2b14683f9a77 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -9,6 +9,7 @@
 #include <string.h>
 #include <sys/wait.h>
 #include <sys/mman.h>
+#include <sys/random.h>
 
 #include "kselftest.h"
 #include "cgroup_util.h"
@@ -424,44 +425,71 @@ static int test_zswap_writeback_disabled(const char *root)
 static int test_no_invasive_cgroup_shrink(const char *root)
 {
 	int ret = KSFT_FAIL;
-	size_t control_allocation_size = MB(10);
-	char *control_allocation = NULL, *wb_group = NULL, *control_group = NULL;
+	unsigned int off;
+	size_t allocation_size = page_size * 1024;
+	unsigned int nr_pages = allocation_size / page_size;
+	char zswap_max_buf[32], mem_max_buf[32];
+	char *zw_allocation = NULL, *wb_allocation = NULL;
+	char *zw_group = NULL, *wb_group = NULL;
+
+	snprintf(zswap_max_buf, sizeof(zswap_max_buf), "%d", page_size);
+	snprintf(mem_max_buf, sizeof(mem_max_buf), "%zu", allocation_size / 2);
 
 	wb_group = setup_test_group_1M(root, "per_memcg_wb_test1");
 	if (!wb_group)
 		return KSFT_FAIL;
-	if (cg_write(wb_group, "memory.zswap.max", "10K"))
+	if (cg_write(wb_group, "memory.zswap.max", zswap_max_buf))
+		goto out;
+	if (cg_write(wb_group, "memory.max", mem_max_buf))
+		goto out;
+
+	zw_group = setup_test_group_1M(root, "per_memcg_wb_test2");
+	if (!zw_group)
 		goto out;
-	control_group = setup_test_group_1M(root, "per_memcg_wb_test2");
-	if (!control_group)
+	if (cg_write(zw_group, "memory.max", mem_max_buf))
 		goto out;
 
-	/* Push some test_group2 memory into zswap */
-	if (cg_enter_current(control_group))
+	/* Push some zw_group memory into zswap (simple data, easy to compress) */
+	if (cg_enter_current(zw_group))
 		goto out;
-	control_allocation = malloc(control_allocation_size);
-	for (int i = 0; i < control_allocation_size; i += page_size)
-		control_allocation[i] = 'a';
-	if (cg_read_key_long(control_group, "memory.stat", "zswapped") < 1)
+	zw_allocation = malloc(allocation_size);
+	for (int i = 0; i < nr_pages; i++) {
+		off = (unsigned long)i * page_size;
+		memset(&zw_allocation[off], 0, page_size);
+		memset(&zw_allocation[off], 'a', page_size/4);
+	}
+	if (cg_read_key_long(zw_group, "memory.stat", "zswapped") < 1)
 		goto out;
 
-	/* Allocate 10x memory.max to push wb_group memory into zswap and trigger wb */
-	if (cg_run(wb_group, allocate_bytes, (void *)MB(10)))
+	/* Push wb_group memory into zswap with hard-to-compress data to trigger wb */
+	if (cg_enter_current(wb_group))
+		goto out;
+	wb_allocation = malloc(allocation_size);
+	if (!wb_allocation)
 		goto out;
+	for (int i = 0; i < nr_pages; i++) {
+		off = (unsigned long)i * page_size;
+		memset(&wb_allocation[off], 0, page_size);
+		getrandom(&wb_allocation[off], page_size/4, 0);
+	}
 
 	/* Verify that only zswapped memory from gwb_group has been written back */
-	if (get_cg_wb_count(wb_group) > 0 && get_cg_wb_count(control_group) == 0)
+	if (get_cg_wb_count(wb_group) > 0 && get_cg_wb_count(zw_group) == 0)
 		ret = KSFT_PASS;
 out:
 	cg_enter_current(root);
-	if (control_group) {
-		cg_destroy(control_group);
-		free(control_group);
+	if (zw_group) {
+		cg_destroy(zw_group);
+		free(zw_group);
+	}
+	if (wb_group) {
+		cg_destroy(wb_group);
+		free(wb_group);
 	}
-	cg_destroy(wb_group);
-	free(wb_group);
-	if (control_allocation)
-		free(control_allocation);
+	if (zw_allocation)
+		free(zw_allocation);
+	if (wb_allocation)
+		free(wb_allocation);
 	return ret;
 }
 
-- 
2.53.0


