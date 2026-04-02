Return-Path: <cgroups+bounces-15159-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CL26IL4QzmmnkgYAu9opvQ
	(envelope-from <cgroups+bounces-15159-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 02 Apr 2026 08:46:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 77399384A67
	for <lists+cgroups@lfdr.de>; Thu, 02 Apr 2026 08:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62C57305F96E
	for <lists+cgroups@lfdr.de>; Thu,  2 Apr 2026 06:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DDD363C66;
	Thu,  2 Apr 2026 06:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJNJ+wp8"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4193331AAAA
	for <cgroups@vger.kernel.org>; Thu,  2 Apr 2026 06:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775111908; cv=none; b=Yro1h4BNta0I4ysNPSDKEzwrEoZU1rCWxLOk/UHZAxXanfDb57coPbND/Ot8S1I0glMxxPWH+QQYFsvga2DbG13ElQJTPySGYtL2P7rPzUpVhad8aG5dD4MYNiBok2U+U1lv+i9HZdt4aoDviOdO/KLwD/hau5EK19B24OnEKPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775111908; c=relaxed/simple;
	bh=XpHm9KLm5d4is10F2JA3aMc55B5rzmcmdvlRIDJbX1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dHsRYFHp1BBmaMWarznK4z/fg8wy7KGtmHg0H/4mgUvGBnXkXnZ8E1MCnWlvPvyyl6FITv1jfTqHu1+hxT20ztJtLuUwxbatkmr7LU03WEL8mECl/aycVbczi6XKuYpkgyX752TgcDJwuxjEm9sN7BVBhp4hB/ixn0AXMhD/wus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJNJ+wp8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775111903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LSR6JP1MlIyPdrrVRarFMh7ouoNO5yIpt67p9cGm3mU=;
	b=GJNJ+wp8QCmOm2z+YxF4Yj3v6tuytAHxoMskpDfB8WxTOhS2z8oO+5PjsFKk/UOOyX7NW9
	VRUgMxCBJGxWCwiQ+CUbfyu9SVMXywt2kRprMdyluFK7TaUXOIyvD0+cEzBNkJ6heTfCwq
	L9i8Ms4NbYGWlH1URCElTYViTlaT8s0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-Hl_RMtkzOY2MBUzmdjZPgw-1; Thu,
 02 Apr 2026 02:38:18 -0400
X-MC-Unique: Hl_RMtkzOY2MBUzmdjZPgw-1
X-Mimecast-MFC-AGG-ID: Hl_RMtkzOY2MBUzmdjZPgw_1775111895
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 694FC1800365;
	Thu,  2 Apr 2026 06:38:15 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.112.158])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2A691800351;
	Thu,  2 Apr 2026 06:38:06 +0000 (UTC)
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
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: [PATCH v6 5/8] selftests/cgroup: replace hardcoded page size values in test_zswap
Date: Thu,  2 Apr 2026 14:37:11 +0800
Message-ID: <20260402063714.55124-6-liwang@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15159-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,oracle.com,suse.com,linux.dev,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liwang@redhat.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email,cmpxchg.org:email,linux.dev:email]
X-Rspamd-Queue-Id: 77399384A67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Signed-off-by: Li Wang <liwang@redhat.com>
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

Notes:
    v6:
    	- Use page_size replace the sysconf(_SC_PAGE_SIZE).
    v5:
    	- Change pagesize by the global page_size.
    v1-4:
    	- No changes.

 tools/testing/selftests/cgroup/test_zswap.c | 43 ++++++++++++---------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index 516da5d52bfd..db4889bef6d4 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -13,6 +13,8 @@
 #include "kselftest.h"
 #include "cgroup_util.h"
 
+static int page_size;
+
 #define PATH_ZSWAP "/sys/module/zswap"
 #define PATH_ZSWAP_ENABLED "/sys/module/zswap/parameters/enabled"
 
@@ -71,11 +73,11 @@ static int allocate_and_read_bytes(const char *cgroup, void *arg)
 
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
@@ -91,7 +93,7 @@ static int allocate_bytes(const char *cgroup, void *arg)
 
 	if (!mem)
 		return -1;
-	for (int i = 0; i < size; i += 4095)
+	for (int i = 0; i < size; i += page_size)
 		mem[i] = 'a';
 	free(mem);
 	return 0;
@@ -165,7 +167,7 @@ static int test_swapin_nozswap(const char *root)
 	int ret = KSFT_FAIL;
 	char *test_group, mem_max_buf[32];
 	long swap_peak, zswpout, min_swap;
-	size_t allocation_size = sysconf(_SC_PAGESIZE) * 512;
+	size_t allocation_size = page_size * 512;
 
 	min_swap = allocation_size / 4;
 	snprintf(mem_max_buf, sizeof(mem_max_buf), "%zu", allocation_size * 3/4);
@@ -243,7 +245,7 @@ static int test_zswapin(const char *root)
 		goto out;
 	}
 
-	if (zswpin < MB(24) / sysconf(_SC_PAGESIZE)) {
+	if (zswpin < MB(24) / page_size) {
 		ksft_print_msg("at least 24MB should be brought back from zswap\n");
 		goto out;
 	}
@@ -270,9 +272,8 @@ static int test_zswapin(const char *root)
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
@@ -287,11 +288,11 @@ static int attempt_writeback(const char *cgroup, void *arg)
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
@@ -302,8 +303,8 @@ static int attempt_writeback(const char *cgroup, void *arg)
 	zswap_usage = cg_read_long(cgroup, "memory.zswap.current");
 
 	/* zswpin */
-	for (int i = 0; i < memsize; i += pagesize) {
-		if (memcmp(&mem[i], buf, pagesize)) {
+	for (int i = 0; i < memsize; i += page_size) {
+		if (memcmp(&mem[i], buf, page_size)) {
 			ksft_print_msg("invalid memory\n");
 			goto out;
 		}
@@ -439,7 +440,7 @@ static int test_no_invasive_cgroup_shrink(const char *root)
 	if (cg_enter_current(control_group))
 		goto out;
 	control_allocation = malloc(control_allocation_size);
-	for (int i = 0; i < control_allocation_size; i += 4095)
+	for (int i = 0; i < control_allocation_size; i += page_size)
 		control_allocation[i] = 'a';
 	if (cg_read_key_long(control_group, "memory.stat", "zswapped") < 1)
 		goto out;
@@ -479,7 +480,7 @@ static int no_kmem_bypass_child(const char *cgroup, void *arg)
 		values->child_allocated = true;
 		return -1;
 	}
-	for (long i = 0; i < values->target_alloc_bytes; i += 4095)
+	for (long i = 0; i < values->target_alloc_bytes; i += page_size)
 		((char *)allocation)[i] = 'a';
 	values->child_allocated = true;
 	pause();
@@ -527,7 +528,7 @@ static int test_no_kmem_bypass(const char *root)
 	min_free_kb_low = sys_info.totalram / 500000;
 	values->target_alloc_bytes = (sys_info.totalram - min_free_kb_high * 1000) +
 		sys_info.totalram * 5 / 100;
-	stored_pages_threshold = sys_info.totalram / 5 / 4096;
+	stored_pages_threshold = sys_info.totalram / 5 / page_size;
 	trigger_allocation_size = sys_info.totalram / 20;
 
 	/* Set up test memcg */
@@ -554,7 +555,7 @@ static int test_no_kmem_bypass(const char *root)
 
 		if (!trigger_allocation)
 			break;
-		for (int i = 0; i < trigger_allocation_size; i += 4095)
+		for (int i = 0; i < trigger_allocation_size; i += page_size)
 			trigger_allocation[i] = 'b';
 		usleep(100000);
 		free(trigger_allocation);
@@ -565,8 +566,8 @@ static int test_no_kmem_bypass(const char *root)
 		/* If memory was pushed to zswap, verify it belongs to memcg */
 		if (stored_pages > stored_pages_threshold) {
 			int zswapped = cg_read_key_long(test_group, "memory.stat", "zswapped ");
-			int delta = stored_pages * 4096 - zswapped;
-			int result_ok = delta < stored_pages * 4096 / 4;
+			int delta = stored_pages * page_size - zswapped;
+			int result_ok = delta < stored_pages * page_size / 4;
 
 			ret = result_ok ? KSFT_PASS : KSFT_FAIL;
 			break;
@@ -616,6 +617,10 @@ int main(int argc, char **argv)
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


