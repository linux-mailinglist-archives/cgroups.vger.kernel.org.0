Return-Path: <cgroups+bounces-13933-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLJgMm3QjmnKFAEAu9opvQ
	(envelope-from <cgroups+bounces-13933-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 08:19:09 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 645BB13371F
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 08:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D811B30151ED
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 07:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D79B25C704;
	Fri, 13 Feb 2026 07:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lIXNPvSq"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CDC27BF7D
	for <cgroups@vger.kernel.org>; Fri, 13 Feb 2026 07:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770967144; cv=none; b=c17lzpegdusYJURH62SZcVpIDTjt7NbH59QRMvR2tMRGQim+TnlRxKeqyqJjqqEltSZxadyoHNOejLgAEX77MIrmScZBcX9SsC5BdhZ8F/0rFfimVxXC4jx44pTMZCf8BICXH84shUlFIzoYeCfQDTf/+QzGDQdN0XLWyP5Fzns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770967144; c=relaxed/simple;
	bh=3FbY3oiUDhxvvJsY+ZzL8u6BhbEXlfel5ApzMIwducM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsYCP+v6fsnWdDwRc01jXQgRNC/tnf7tPia0zzMUWLt/zQyK2c4CJNB1nlB8uNASvZzzpHsDsJZuloKEQsQNbz56qtnZoXtPJ7SEhYE6Bh4zhK2mDIklqay0TVYZaQ/gWuZkIaNxXit00vem8mFzkjdLF6h646kQk2TFypFx6W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lIXNPvSq; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770967140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fHxD0q/WzMwerrB6ZvB9y/vH4lR5GGZkuNBvcMrlqCg=;
	b=lIXNPvSqtq/mhCIHqxeszIYr/dYCcHPhuKv8BU2LzkjdLcK9P1zVhUyLfgrTBtWksG2iM/
	Cd9uWmaQOjCZeDqnMhBfEkW5CxhEcfoN0N8H3l5JRit/TmtkhvnztmxIr2KOWqN/FtKzwx
	XJKKxxEqFXLCORDZbvr0dcqUqxpn4b4=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-mm@kvack.org
Cc: jiayuan.chen@linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	SeongJae Park <sj@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH mm-new v3 2/2] selftests/cgroup: add test for zswap incompressible pages
Date: Fri, 13 Feb 2026 15:18:23 +0800
Message-ID: <20260213071827.5688-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260213071827.5688-1-jiayuan.chen@linux.dev>
References: <20260213071827.5688-1-jiayuan.chen@linux.dev>
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
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13933-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,shopee.com,gmail.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linux-foundation.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,shopee.com:email]
X-Rspamd-Queue-Id: 645BB13371F
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

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 tools/testing/selftests/cgroup/test_zswap.c | 136 ++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index 64ebc3f3f203..a7bdcdd09d62 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -5,6 +5,8 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <signal.h>
+#include <errno.h>
+#include <fcntl.h>
 #include <sys/sysinfo.h>
 #include <string.h>
 #include <sys/wait.h>
@@ -574,6 +576,139 @@ static int test_no_kmem_bypass(const char *root)
 	return ret;
 }
 
+struct incomp_child_args {
+	size_t size;
+	int pipefd[2];
+	int madvise_ret;
+	int madvise_errno;
+};
+
+static int allocate_random_and_wait(const char *cgroup, void *arg)
+{
+	struct incomp_child_args *values = arg;
+	size_t size = values->size;
+	char *mem;
+	int fd;
+	ssize_t n;
+
+	close(values->pipefd[0]);
+
+	mem = mmap(NULL, size, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (mem == MAP_FAILED)
+		return -1;
+
+	/* Fill with random data from /dev/urandom - incompressible */
+	fd = open("/dev/urandom", O_RDONLY);
+	if (fd < 0) {
+		munmap(mem, size);
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
+	for (size_t i = 0; i < size; i += PAGE_SIZE)
+		mem[i] = mem[i];
+
+	/* Use MADV_PAGEOUT to push pages into zswap */
+	values->madvise_ret = madvise(mem, size, MADV_PAGEOUT);
+	values->madvise_errno = errno;
+
+	/* Notify parent that allocation and pageout are done */
+	write(values->pipefd[1], "x", 1);
+	close(values->pipefd[1]);
+
+	/* Keep memory alive for parent to check stats */
+	pause();
+	munmap(mem, size);
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
+ * The child process allocates random data within memory.max, then uses
+ * MADV_PAGEOUT to push pages into zswap. The parent waits on a pipe for
+ * the child to finish, then checks the zswap_incomp stat before the child
+ * exits (zswap_incomp is a gauge that decreases on free).
+ */
+static int test_zswap_incompressible(const char *root)
+{
+	int ret = KSFT_FAIL;
+	struct incomp_child_args *values;
+	char *test_group;
+	long zswap_incomp;
+	pid_t child_pid;
+	int child_status;
+	char buf;
+
+	values = mmap(0, sizeof(struct incomp_child_args), PROT_READ |
+			PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	if (values == MAP_FAILED)
+		return KSFT_FAIL;
+
+	if (pipe(values->pipefd)) {
+		munmap(values, sizeof(struct incomp_child_args));
+		return KSFT_FAIL;
+	}
+
+	test_group = cg_name(root, "zswap_incompressible_test");
+	if (!test_group)
+		goto out;
+	if (cg_create(test_group))
+		goto out;
+	if (cg_write(test_group, "memory.max", "32M"))
+		goto out;
+
+	values->size = MB(4);
+	child_pid = cg_run_nowait(test_group, allocate_random_and_wait, values);
+	if (child_pid < 0)
+		goto out;
+
+	close(values->pipefd[1]);
+
+	/* Wait for child to finish allocating and pageout */
+	read(values->pipefd[0], &buf, 1);
+	close(values->pipefd[0]);
+
+	zswap_incomp = get_zswap_incomp(test_group);
+	if (zswap_incomp <= 0) {
+		long zswpout = get_zswpout(test_group);
+		long zswapped = cg_read_key_long(test_group, "memory.stat", "zswapped ");
+		long zswap_b = cg_read_key_long(test_group, "memory.stat", "zswap ");
+
+		ksft_print_msg("zswap_incomp not increased: %ld\n", zswap_incomp);
+		ksft_print_msg("debug: zswpout=%ld zswapped=%ld zswap_b=%ld\n",
+			       zswpout, zswapped, zswap_b);
+		ksft_print_msg("debug: madvise ret=%d errno=%d\n",
+			       values->madvise_ret, values->madvise_errno);
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
+	munmap(values, sizeof(struct incomp_child_args));
+	return ret;
+}
+
 #define T(x) { x, #x }
 struct zswap_test {
 	int (*fn)(const char *root);
@@ -586,6 +721,7 @@ struct zswap_test {
 	T(test_zswap_writeback_disabled),
 	T(test_no_kmem_bypass),
 	T(test_no_invasive_cgroup_shrink),
+	T(test_zswap_incompressible),
 };
 #undef T
 
-- 
2.43.0


