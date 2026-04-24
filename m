Return-Path: <cgroups+bounces-15487-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHr7Jqfr6mnCFgAAu9opvQ
	(envelope-from <cgroups+bounces-15487-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 06:03:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 176254599BB
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 06:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B78D3301DC0B
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 04:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B923246E8;
	Fri, 24 Apr 2026 04:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EYE+6658"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BA6237713;
	Fri, 24 Apr 2026 04:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777003336; cv=none; b=Z8xXV1s892enA9o70N6IM5pIJafULGusD0vLNNuow//elljuBtr8+YLt16rRyQh6SuP5Qa4WKqLJk8jtHyEFTR5upY1b7gl7edn68ZbhNM6QHG8PhmXyNF8WvYhmcDJBcXIUNHUZ7QxTiR9soLIUJE59bYjGQV8iDzSA/Eg9iqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777003336; c=relaxed/simple;
	bh=oxfEiWZ5fYyLTbBLQtDMgNWldzLX7PZJ/MswDyeOgq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fiksO0O4o4C17x3pU4+dBULVSqYGbT0fQYxzir/Tq+FJGAC/OBjncq+4nw9dbWUYGR9vDCYCCEbbYarkeyeYovlFJRwT/KdePQmSs5dGDxIfH9i1b7MEnd55eRqmzIzeCXSCad/11Yn7A+53lgPeb7AX8lier53Bl4G/MPTICv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EYE+6658; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777003333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LjK5yqAtFeuYG5/nOFq4FfdHS80zSO/SlqOxhS/ymI4=;
	b=EYE+6658+qzlpBjMB4PwDElgXgGp08FhPENSxTQNPqUc2aYW6jcVr8xj5pVl2S8ssOcadu
	5Y9WvQfr/ISxYT0+eZOIwq9T3Iktejxsx6zV+H0Cil3nxWlUFg+sMhZixIwGfmRbJX2DOd
	RSqabsSufhgie/GRrHt+vheFhUyEghs=
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
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: [PATCH v7 5/8] selftests/cgroup: replace hardcoded page size values in test_zswap
Date: Fri, 24 Apr 2026 12:00:56 +0800
Message-ID: <20260424040059.12940-6-li.wang@linux.dev>
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
X-Rspamd-Queue-Id: 176254599BB
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
	TAGGED_FROM(0.00)[bounces-15487-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,redhat.com,linux.dev,cmpxchg.org,gmail.com,suse.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
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

test_zswap uses hardcoded values of 4095 and 4096 throughout as page
stride and page size, which are only correct on systems with a 4K page
size. On architectures with larger pages (e.g., 64K on arm64 or ppc64),
these constants cause memory to be touched at sub-page granularity,
leading to inefficient access patterns and incorrect page count
calculations, which can cause test failures.

Replace all hardcoded 4095 and 4096 values with a global pagesize
variable initialized from sysconf(_SC_PAGESIZE) at startup, and remove
the redundant local sysconf() calls scattered across individual
functions. No functional change on 4K page size systems.

Signed-off-by: Li Wang <li.wang@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Michal Koutný <mkoutny@suse.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Yosry Ahmed <yosry@kernel.org>
---
 tools/testing/selftests/cgroup/test_zswap.c | 45 ++++++++++++---------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index 37aa83c2f1b..23ff11390a3 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -15,6 +15,8 @@
 #include "kselftest.h"
 #include "cgroup_util.h"
 
+static int page_size;
+
 #define PATH_ZSWAP "/sys/module/zswap"
 #define PATH_ZSWAP_ENABLED "/sys/module/zswap/parameters/enabled"
 
@@ -73,11 +75,11 @@ static int allocate_and_read_bytes(const char *cgroup, void *arg)
 
 	if (!mem)
 		return -1;
-	for (int i = 0; i < size; i += 4095)
+	for (int i = 0; i < size; i += page_size)
 		mem[i] = 'a';
 
 	/* Go through the allocated memory to (z)swap in and out pages */
-	for (int i = 0; i < size; i += 4095) {
+	for (int i = 0; i < size; i += page_size) {
 		if (mem[i] != 'a')
 			ret = -1;
 	}
@@ -93,7 +95,7 @@ static int allocate_bytes(const char *cgroup, void *arg)
 
 	if (!mem)
 		return -1;
-	for (int i = 0; i < size; i += 4095)
+	for (int i = 0; i < size; i += page_size)
 		mem[i] = 'a';
 	free(mem);
 	return 0;
@@ -167,7 +169,7 @@ static int test_swapin_nozswap(const char *root)
 	int ret = KSFT_FAIL;
 	char *test_group, mem_max_buf[32];
 	long swap_peak, zswpout, min_swap;
-	size_t allocation_size = sysconf(_SC_PAGESIZE) * 512;
+	size_t allocation_size = page_size * 512;
 
 	min_swap = allocation_size / 4;
 	snprintf(mem_max_buf, sizeof(mem_max_buf), "%zu", allocation_size * 3/4);
@@ -245,7 +247,7 @@ static int test_zswapin(const char *root)
 		goto out;
 	}
 
-	if (zswpin < MB(24) / sysconf(_SC_PAGESIZE)) {
+	if (zswpin < MB(24) / page_size) {
 		ksft_print_msg("at least 24MB should be brought back from zswap\n");
 		goto out;
 	}
@@ -272,9 +274,8 @@ static int test_zswapin(const char *root)
  */
 static int attempt_writeback(const char *cgroup, void *arg)
 {
-	long pagesize = sysconf(_SC_PAGESIZE);
 	size_t memsize = MB(4);
-	char buf[pagesize];
+	char buf[page_size];
 	long zswap_usage;
 	bool wb_enabled = *(bool *) arg;
 	int ret = -1;
@@ -289,11 +290,11 @@ static int attempt_writeback(const char *cgroup, void *arg)
 	 * half empty, this will result in data that is still compressible
 	 * and ends up in zswap, with material zswap usage.
 	 */
-	for (int i = 0; i < pagesize; i++)
-		buf[i] = i < pagesize/2 ? (char) i : 0;
+	for (int i = 0; i < page_size; i++)
+		buf[i] = i < page_size/2 ? (char) i : 0;
 
-	for (int i = 0; i < memsize; i += pagesize)
-		memcpy(&mem[i], buf, pagesize);
+	for (int i = 0; i < memsize; i += page_size)
+		memcpy(&mem[i], buf, page_size);
 
 	/* Try and reclaim allocated memory */
 	if (cg_write_numeric(cgroup, "memory.reclaim", memsize)) {
@@ -304,8 +305,8 @@ static int attempt_writeback(const char *cgroup, void *arg)
 	zswap_usage = cg_read_long(cgroup, "memory.zswap.current");
 
 	/* zswpin */
-	for (int i = 0; i < memsize; i += pagesize) {
-		if (memcmp(&mem[i], buf, pagesize)) {
+	for (int i = 0; i < memsize; i += page_size) {
+		if (memcmp(&mem[i], buf, page_size)) {
 			ksft_print_msg("invalid memory\n");
 			goto out;
 		}
@@ -441,7 +442,7 @@ static int test_no_invasive_cgroup_shrink(const char *root)
 	if (cg_enter_current(control_group))
 		goto out;
 	control_allocation = malloc(control_allocation_size);
-	for (int i = 0; i < control_allocation_size; i += 4095)
+	for (int i = 0; i < control_allocation_size; i += page_size)
 		control_allocation[i] = 'a';
 	if (cg_read_key_long(control_group, "memory.stat", "zswapped") < 1)
 		goto out;
@@ -481,7 +482,7 @@ static int no_kmem_bypass_child(const char *cgroup, void *arg)
 		values->child_allocated = true;
 		return -1;
 	}
-	for (long i = 0; i < values->target_alloc_bytes; i += 4095)
+	for (long i = 0; i < values->target_alloc_bytes; i += page_size)
 		((char *)allocation)[i] = 'a';
 	values->child_allocated = true;
 	pause();
@@ -529,7 +530,7 @@ static int test_no_kmem_bypass(const char *root)
 	min_free_kb_low = sys_info.totalram / 500000;
 	values->target_alloc_bytes = (sys_info.totalram - min_free_kb_high * 1000) +
 		sys_info.totalram * 5 / 100;
-	stored_pages_threshold = sys_info.totalram / 5 / 4096;
+	stored_pages_threshold = sys_info.totalram / 5 / page_size;
 	trigger_allocation_size = sys_info.totalram / 20;
 
 	/* Set up test memcg */
@@ -556,7 +557,7 @@ static int test_no_kmem_bypass(const char *root)
 
 		if (!trigger_allocation)
 			break;
-		for (int i = 0; i < trigger_allocation_size; i += 4095)
+		for (int i = 0; i < trigger_allocation_size; i += page_size)
 			trigger_allocation[i] = 'b';
 		usleep(100000);
 		free(trigger_allocation);
@@ -567,8 +568,8 @@ static int test_no_kmem_bypass(const char *root)
 		/* If memory was pushed to zswap, verify it belongs to memcg */
 		if (stored_pages > stored_pages_threshold) {
 			int zswapped = cg_read_key_long(test_group, "memory.stat", "zswapped ");
-			int delta = stored_pages * 4096 - zswapped;
-			int result_ok = delta < stored_pages * 4096 / 4;
+			int delta = stored_pages * page_size - zswapped;
+			int result_ok = delta < stored_pages * page_size / 4;
 
 			ret = result_ok ? KSFT_PASS : KSFT_FAIL;
 			break;
@@ -622,7 +623,7 @@ static int allocate_random_and_wait(const char *cgroup, void *arg)
 	close(fd);
 
 	/* Touch all pages to ensure they're faulted in */
-	for (size_t i = 0; i < size; i += PAGE_SIZE)
+	for (size_t i = 0; i < size; i += page_size)
 		mem[i] = mem[i];
 
 	/* Use MADV_PAGEOUT to push pages into zswap */
@@ -752,6 +753,10 @@ int main(int argc, char **argv)
 	char root[PATH_MAX];
 	int i;
 
+	page_size = sysconf(_SC_PAGE_SIZE);
+	if (page_size <= 0)
+		page_size = BUF_SIZE;
+
 	ksft_print_header();
 	ksft_set_plan(ARRAY_SIZE(tests));
 	if (cg_find_unified_root(root, sizeof(root), NULL))
-- 
2.53.0


