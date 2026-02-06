Return-Path: <cgroups+bounces-13735-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFBYK4CXhWk7DwQAu9opvQ
	(envelope-from <cgroups+bounces-13735-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 08:25:52 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C2DFAF24
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 08:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7129830420B3
	for <lists+cgroups@lfdr.de>; Fri,  6 Feb 2026 07:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1A230B524;
	Fri,  6 Feb 2026 07:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K+C4Ejc5"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E9730AD1D;
	Fri,  6 Feb 2026 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770362568; cv=none; b=Kh3kHbQ15qHJXwck4bMvW0w0fRmxZZdEsjxiKzXQH/BRTOhWqpZRRoGe6W+HjXuRL6rWFs/4qrPh27dpRVtgEA9AMAPZ718BZcxOmyAInD/q/dMLyYDhGPeix23f9PTn7FfKAwVoPIKxGNf4E19KH5WrIfYOFJ1Qs7HBunp/3u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770362568; c=relaxed/simple;
	bh=W7Pj5IOXmHNCfVzPNifKS2LnKgE5X8L1spcNsvgNAyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMlB3JILTc7ZWVrFak+8g0pP0q0t1vF/NAqWvhJwfJc3rYE/Lcx4fG/N78DRBomg+dcTl4BOafJrhJ/2ml6wK4r+HYA1o+DoEJXuQB/wPX3G9Q728rGvLnFWVX1L1lhTUzKMi/y+x4j7wFtzUmX1lDryePlgLNj5TK0WGQdDv04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K+C4Ejc5; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770362566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QVhNoOKTqhs5FIM84PwOapldZJ1EjdC0zJo6ufYFyUo=;
	b=K+C4Ejc5kYVa1AMupNC5l8ot9jFScgXyb+D+zIw9ZBvY3NiXL0rK4kEbWmFA7i7a1LUKEa
	8/aC154zcQVvLVXsflxO27dIvGWhoyBQ8v3NYygtLhMZecbpziRI9uYqN2sJFcY5KWYXcX
	97o64Jq7iwPbBEtR111+cZx2n28j/rk=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-mm@kvack.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/2] selftests/cgroup: add test for zswap incompressible pages
Date: Fri,  6 Feb 2026 15:22:16 +0800
Message-ID: <20260206072220.144008-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260206072220.144008-1-jiayuan.chen@linux.dev>
References: <20260206072220.144008-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[shopee.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linux.dev,linux-foundation.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13735-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shopee.com:email]
X-Rspamd-Queue-Id: 45C2DFAF24
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

Add test_zswap_incompressible() to verify that the zswap_incomp memcg
stat correctly tracks incompressible pages.

The test allocates memory filled with random data from /dev/urandom,
which cannot be effectively compressed by zswap. When this data is
swapped out to zswap, it should be stored as-is and tracked by the
zswap_incomp counter.

The test verifies that:
1. Pages are swapped out to zswap (zswpout increases)
2. Incompressible pages are tracked (zswap_incomp increases)

test:
dd if=/dev/zero of=/swapfile bs=1M count=2048
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo Y > /sys/module/zswap/parameters/enabled

./test_zswap
 TAP version 13
 1..8
 ok 1 test_zswap_usage
 ok 2 test_swapin_nozswap
 ok 3 test_zswapin
 ok 4 test_zswap_writeback_enabled
 ok 5 test_zswap_writeback_disabled
 ok 6 test_no_kmem_bypass
 ok 7 test_no_invasive_cgroup_shrink
 ok 8 test_zswap_incompressible
 Totals: pass:8 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 tools/testing/selftests/cgroup/test_zswap.c | 96 +++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index 64ebc3f3f203..8cb8a131357d 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -5,6 +5,7 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <signal.h>
+#include <fcntl.h>
 #include <sys/sysinfo.h>
 #include <string.h>
 #include <sys/wait.h>
@@ -574,6 +575,100 @@ static int test_no_kmem_bypass(const char *root)
 	return ret;
 }
 
+static int allocate_random_and_wait(const char *cgroup, void *arg)
+{
+	size_t size = (size_t)arg;
+	char *mem;
+	int fd;
+	ssize_t n;
+
+	mem = malloc(size);
+	if (!mem)
+		return -1;
+
+	/* Fill with random data from /dev/urandom - incompressible */
+	fd = open("/dev/urandom", O_RDONLY);
+	if (fd < 0) {
+		free(mem);
+		return -1;
+	}
+
+	for (size_t i = 0; i < size; ) {
+		n = read(fd, mem + i, size - i);
+		if (n <= 0)
+			break;
+		i += n;
+	}
+	close(fd);
+
+	/* Touch all pages to ensure they're faulted in */
+	for (size_t i = 0; i < size; i += 4096)
+		mem[i] = mem[i];
+
+	/* Keep memory alive for parent to reclaim and check stats */
+	pause();
+	free(mem);
+	return 0;
+}
+
+static long get_zswap_incomp(const char *cgroup)
+{
+	return cg_read_key_long(cgroup, "memory.stat", "zswap_incomp ");
+}
+
+/*
+ * Test that incompressible pages (random data) are tracked by zswap_incomp.
+ *
+ * Since incompressible pages stored in zswap are charged at full PAGE_SIZE
+ * (no memory savings), we cannot rely on memory.max pressure to push them
+ * into zswap. Instead, we allocate random data within memory.max, then use
+ * memory.reclaim to proactively push pages into zswap while checking the stat
+ * before the child exits (zswap_incomp is a gauge that decreases on free).
+ */
+static int test_zswap_incompressible(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *test_group;
+	long zswap_incomp;
+	pid_t child_pid;
+	int child_status;
+
+	test_group = cg_name(root, "zswap_incompressible_test");
+	if (!test_group)
+		goto out;
+	if (cg_create(test_group))
+		goto out;
+	if (cg_write(test_group, "memory.max", "32M"))
+		goto out;
+
+	child_pid = cg_run_nowait(test_group, allocate_random_and_wait,
+				  (void *)MB(4));
+	if (child_pid < 0)
+		goto out;
+
+	/* Wait for child to finish allocating */
+	usleep(500000);
+
+	/* Proactively reclaim to push random pages into zswap */
+	cg_write_numeric(test_group, "memory.reclaim", MB(4));
+
+	zswap_incomp = get_zswap_incomp(test_group);
+	if (zswap_incomp <= 0) {
+		ksft_print_msg("zswap_incomp not increased: %ld\n", zswap_incomp);
+		goto out_kill;
+	}
+
+	ret = KSFT_PASS;
+
+out_kill:
+	kill(child_pid, SIGTERM);
+	waitpid(child_pid, &child_status, 0);
+out:
+	cg_destroy(test_group);
+	free(test_group);
+	return ret;
+}
+
 #define T(x) { x, #x }
 struct zswap_test {
 	int (*fn)(const char *root);
@@ -586,6 +681,7 @@ struct zswap_test {
 	T(test_zswap_writeback_disabled),
 	T(test_no_kmem_bypass),
 	T(test_no_invasive_cgroup_shrink),
+	T(test_zswap_incompressible),
 };
 #undef T
 
-- 
2.43.0


