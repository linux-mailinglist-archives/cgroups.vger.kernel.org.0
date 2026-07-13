Return-Path: <cgroups+bounces-17681-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tLIsFQBUVGrQkgMAu9opvQ
	(envelope-from <cgroups+bounces-17681-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 04:57:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B38E746D17
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 04:57:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lge.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17681-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17681-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 821D530082BD
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 02:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E156D30D3EE;
	Mon, 13 Jul 2026 02:57:01 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552BE3164D8
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 02:56:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783911421; cv=none; b=Q0V3yG7VjjhWEYfbpEgHOSGzBAWRwHEQ/rwFEACw5BJlBXF0Bs2yT21x5Eh+Z/K3xfnSBk2i8h+4nQ1A6Q4PX/Hlvcs9V0jU/za6B4j4524kj/CpwJAKXT9gUQPm7ulkr+3dqQKpqvbLt7dbhaGdtwwcS+EaAcyAuzLU0SvNqTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783911421; c=relaxed/simple;
	bh=R29KjIlG/12zBkwVZseY+aWsj6CPBU16wlOGTOPUaho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i/SlkLUix59+hYsRNkuNtizT+tos9tiXp2JTw7/W0gtzlTFvaqzMYAn3Fyqz38khSzMFCL+znKCrH6e8O572kj8VPPHPG9f5Ca8ebbSUJ1fLUVgwKPOKDgxZaZ0F/S8Ys0oJk7XeAkQ9HMPI7WGRUtUPy0yRkCAIoio8idg+CTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 13 Jul 2026 11:56:55 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: Youngjun Park <youngjun.park@lge.com>
To: akpm@linux-foundation.org
Cc: chrisl@kernel.org,
	youngjun.park@lge.com,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kasong@tencent.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	shikemeng@huaweicloud.com,
	baoquan.he@linux.dev,
	baohua@kernel.org,
	yosry@kernel.org,
	joshua.hahnjy@gmail.com,
	gunho.lee@lge.com,
	taejoon.song@lge.com,
	hyungjun.cho@lge.com,
	baver.bae@lge.com,
	her0gyugyu@gmail.com
Subject: [PATCH v10 6/6] selftests/cgroup: add a swap tier routing test
Date: Mon, 13 Jul 2026 11:56:44 +0900
Message-Id: <20260713025644.170839-7-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713025644.170839-1-youngjun.park@lge.com>
References: <20260713025644.170839-1-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17681-lists,cgroups=lfdr.de];
	FORGED_SENDER(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,lge.com,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:youngjun.park@lge.com,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:yosry@kernel.org,m:joshua.hahnjy@gmail.com,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:baver.bae@lge.com,m:her0gyugyu@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lge.com:from_mime,lge.com:email,lge.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B38E746D17

This commit adds a test program for the per-cgroup swap tier control
memory.swap.tiers.max. It checks the default mask, toggling a tier,
rejection of invalid input, and that recreating a tier resets the mask.
It also checks that a cgroup's pages swap only to an allowed tier,
including across the parent and child hierarchy. The routing check uses
two zram devices placed in different tiers.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 tools/testing/selftests/cgroup/.gitignore     |   1 +
 tools/testing/selftests/cgroup/Makefile       |   2 +
 tools/testing/selftests/cgroup/config         |   2 +
 .../selftests/cgroup/test_swap_tiers.c        | 509 ++++++++++++++++++
 4 files changed, 514 insertions(+)
 create mode 100644 tools/testing/selftests/cgroup/test_swap_tiers.c

diff --git a/tools/testing/selftests/cgroup/.gitignore b/tools/testing/selftests/cgroup/.gitignore
index 952e4448bf07..77b8e6c3e592 100644
--- a/tools/testing/selftests/cgroup/.gitignore
+++ b/tools/testing/selftests/cgroup/.gitignore
@@ -8,5 +8,6 @@ test_kill
 test_kmem
 test_memcontrol
 test_pids
+test_swap_tiers
 test_zswap
 wait_inotify
diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
index e01584c2189a..a98e3c414cd5 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -16,6 +16,7 @@ TEST_GEN_PROGS += test_kill
 TEST_GEN_PROGS += test_kmem
 TEST_GEN_PROGS += test_memcontrol
 TEST_GEN_PROGS += test_pids
+TEST_GEN_PROGS += test_swap_tiers
 TEST_GEN_PROGS += test_zswap
 
 LOCAL_HDRS += $(selfdir)/clone3/clone3_selftests.h $(selfdir)/pidfd/pidfd.h
@@ -32,4 +33,5 @@ $(OUTPUT)/test_kill: $(LIBCGROUP_O)
 $(OUTPUT)/test_kmem: $(LIBCGROUP_O)
 $(OUTPUT)/test_memcontrol: $(LIBCGROUP_O)
 $(OUTPUT)/test_pids: $(LIBCGROUP_O)
+$(OUTPUT)/test_swap_tiers: $(LIBCGROUP_O)
 $(OUTPUT)/test_zswap: $(LIBCGROUP_O)
diff --git a/tools/testing/selftests/cgroup/config b/tools/testing/selftests/cgroup/config
index 39f979690dd3..6086bb5bba97 100644
--- a/tools/testing/selftests/cgroup/config
+++ b/tools/testing/selftests/cgroup/config
@@ -4,3 +4,5 @@ CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_MEMCG=y
 CONFIG_PAGE_COUNTER=y
+CONFIG_SWAP=y
+CONFIG_ZRAM=y
diff --git a/tools/testing/selftests/cgroup/test_swap_tiers.c b/tools/testing/selftests/cgroup/test_swap_tiers.c
new file mode 100644
index 000000000000..9b4484409ed4
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_swap_tiers.c
@@ -0,0 +1,509 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/limits.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/swap.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "kselftest.h"
+#include "cgroup_util.h"
+
+#ifndef MADV_PAGEOUT
+#define MADV_PAGEOUT 21
+#endif
+
+#define TIERS_PATH "/sys/kernel/mm/swap/tiers"
+#define TIERS_MAX "memory.swap.tiers.max"
+
+static int tiers_write(const char *cmd)
+{
+	int fd, ret = 0;
+
+	fd = open(TIERS_PATH, O_WRONLY);
+	if (fd < 0)
+		return -errno;
+	if (write(fd, cmd, strlen(cmd)) < 0)
+		ret = -errno;
+	close(fd);
+	return ret;
+}
+
+static int tier_count(void)
+{
+	char buf[4096], *line, *save;
+	int fd, count = 0;
+	ssize_t n;
+
+	fd = open(TIERS_PATH, O_RDONLY);
+	if (fd < 0)
+		return -1;
+	n = read(fd, buf, sizeof(buf) - 1);
+	close(fd);
+	if (n < 0)
+		return -1;
+	buf[n] = '\0';
+
+	for (line = strtok_r(buf, "\n", &save); line;
+	     line = strtok_r(NULL, "\n", &save)) {
+		char name[64];
+		int idx, s, e;
+
+		if (sscanf(line, "%63s %d %d %d", name, &idx, &s, &e) == 4)
+			count++;
+	}
+	return count;
+}
+
+static long swap_used_kb(const char *dev)
+{
+	char line[256];
+	long used = -1;
+	FILE *f;
+
+	f = fopen("/proc/swaps", "r");
+	if (!f)
+		return -1;
+	while (fgets(line, sizeof(line), f)) {
+		char name[128], type[64];
+		long size, u, prio;
+
+		if (sscanf(line, "%127s %63s %ld %ld %ld",
+			   name, type, &size, &u, &prio) >= 4 &&
+		    !strcmp(name, dev)) {
+			used = u;
+			break;
+		}
+	}
+	fclose(f);
+	return used;
+}
+
+static int swap_active_count(void)
+{
+	char line[256];
+	int n = 0;
+	FILE *f;
+
+	f = fopen("/proc/swaps", "r");
+	if (!f)
+		return -1;
+	if (fgets(line, sizeof(line), f))
+		while (fgets(line, sizeof(line), f))
+			n++;
+	fclose(f);
+	return n;
+}
+
+static void zram_remove(int idx);
+static int zram_add(long size)
+{
+	char path[128], val[64];
+	ssize_t n;
+	int idx, fd;
+
+	fd = open("/sys/class/zram-control/hot_add", O_RDONLY);
+	if (fd < 0)
+		return -1;
+	n = read(fd, val, sizeof(val) - 1);
+	close(fd);
+	if (n <= 0)
+		return -1;
+	val[n] = '\0';
+	idx = atoi(val);
+
+	snprintf(path, sizeof(path), "/sys/block/zram%d/disksize", idx);
+	fd = open(path, O_WRONLY);
+	if (fd < 0) {
+		zram_remove(idx);
+		return -1;
+	}
+
+	snprintf(val, sizeof(val), "%ld", size);
+	n = write(fd, val, strlen(val));
+	close(fd);
+
+	if (n != strlen(val)) {
+		zram_remove(idx);
+		return -1;
+	}
+
+	return idx;
+}
+
+static void zram_remove(int idx)
+{
+	char val[16];
+	int fd;
+
+	fd = open("/sys/class/zram-control/hot_remove", O_WRONLY);
+	if (fd < 0)
+		return;
+	snprintf(val, sizeof(val), "%d", idx);
+	write(fd, val, strlen(val)); /* ignore: best-effort cleanup */
+	close(fd);
+}
+
+static int swap_setup(const char *dev, int prio)
+{
+	char cmd[128];
+
+	snprintf(cmd, sizeof(cmd), "mkswap %s >/dev/null 2>&1", dev);
+	if (system(cmd))
+		return -1;
+	return swapon(dev, SWAP_FLAG_PREFER | (prio & SWAP_FLAG_PRIO_MASK));
+}
+
+static int test_default(const char *root)
+{
+	char *cg = cg_name(root, "swaptier_default");
+	int ret = KSFT_FAIL;
+
+	if (!cg || cg_create(cg))
+		goto out;
+	if (!cg_read_strstr(cg, TIERS_MAX, "fast max") &&
+	    !cg_read_strstr(cg, TIERS_MAX, "slow max"))
+		ret = KSFT_PASS;
+out:
+	if (cg) {
+		cg_destroy(cg);
+		free(cg);
+	}
+	return ret;
+}
+
+static int test_toggle(const char *root)
+{
+	char *cg = cg_name(root, "swaptier_toggle");
+	int ret = KSFT_FAIL;
+
+	if (!cg || cg_create(cg))
+		goto out;
+	if (cg_write(cg, TIERS_MAX, "fast 0"))
+		goto out;
+	if (cg_read_strstr(cg, TIERS_MAX, "fast 0"))
+		goto out;
+	if (cg_write(cg, TIERS_MAX, "fast max"))
+		goto out;
+	if (cg_read_strstr(cg, TIERS_MAX, "fast max"))
+		goto out;
+	ret = KSFT_PASS;
+out:
+	if (cg) {
+		cg_destroy(cg);
+		free(cg);
+	}
+	return ret;
+}
+
+static int test_invalid(const char *root)
+{
+	char *cg = cg_name(root, "swaptier_invalid");
+	int ret = KSFT_FAIL;
+
+	if (!cg || cg_create(cg))
+		goto out;
+	if (!cg_write(cg, TIERS_MAX, "nosuchtier 0"))
+		goto out;
+	if (!cg_write(cg, TIERS_MAX, "fast bogus"))
+		goto out;
+	ret = KSFT_PASS;
+out:
+	if (cg) {
+		cg_destroy(cg);
+		free(cg);
+	}
+	return ret;
+}
+
+static int test_recreate(const char *root)
+{
+	char *cg = cg_name(root, "swaptier_recreate");
+	int ret = KSFT_FAIL;
+
+	if (!cg || cg_create(cg))
+		goto out;
+	if (cg_write(cg, TIERS_MAX, "fast 0"))
+		goto out;
+	if (cg_read_strstr(cg, TIERS_MAX, "fast 0"))
+		goto out;
+	if (tiers_write("-fast") || tiers_write("+fast:10"))
+		goto out;
+	if (cg_read_strstr(cg, TIERS_MAX, "fast max"))
+		goto out;
+	ret = KSFT_PASS;
+out:
+	if (cg) {
+		cg_destroy(cg);
+		free(cg);
+	}
+	return ret;
+}
+
+static int swapout_child(const char *cgroup, void *arg)
+{
+	size_t size = (size_t)arg;
+	char *mem;
+	size_t i;
+	int page_size;
+
+	mem = mmap(NULL, size, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (mem == MAP_FAILED)
+		return -1;
+
+	page_size = sysconf(_SC_PAGE_SIZE);
+	for (i = 0; i < size; i += page_size)
+		mem[i] = 'x';
+	if (madvise(mem, size, MADV_PAGEOUT))
+		return -1;
+	/* Hold the swap entries while the parent inspects /proc/swaps. */
+	pause();
+	return 0;
+}
+
+static int wait_for_dev(const char *dev, const char *dev2)
+{
+	int i;
+
+	for (i = 0; i < 50; i++) {
+		if (access(dev, F_OK) == 0 && access(dev2, F_OK) == 0)
+			return 0;
+
+		usleep(100000);
+	}
+
+	return -1;
+}
+
+static int run_routing_case(const char *cg)
+{
+	char fast_dev[32], slow_dev[32];
+	int zfast = -1, zslow = -1;
+	long used_fast, used_slow;
+	int ret = KSFT_SKIP;
+	pid_t pid = -1;
+	int i;
+
+	/* Only our devices must be present, so usage is unambiguous. */
+	if (swap_active_count() != 0)
+		return KSFT_SKIP;
+
+	zfast = zram_add(MB(128));
+	if (zfast < 0)
+		goto out;
+	snprintf(fast_dev, sizeof(fast_dev), "/dev/zram%d", zfast);
+
+	zslow = zram_add(MB(128));
+	if (zslow < 0)
+		goto out;
+	snprintf(slow_dev, sizeof(slow_dev), "/dev/zram%d", zslow);
+
+	if (wait_for_dev(fast_dev, slow_dev))
+		goto out;
+
+	/* prio 10 -> 'fast' tier [10, MAX]; prio 0 -> 'slow' tier [-1, 9]. */
+	if (swap_setup(fast_dev, 10) || swap_setup(slow_dev, 0))
+		goto out;
+
+	ret = KSFT_FAIL;
+
+	pid = cg_run_nowait(cg, swapout_child, (void *)MB(64));
+	if (pid < 0)
+		goto out;
+
+	for (i = 0; i < 300; i++) {		/* up to ~30s for pageout */
+		if (swap_used_kb(slow_dev) > 0)
+			break;
+		usleep(100000);
+	}
+
+	used_fast = swap_used_kb(fast_dev);
+	used_slow = swap_used_kb(slow_dev);
+	if (used_slow > 0 && used_fast == 0)
+		ret = KSFT_PASS;
+	else
+		ksft_print_msg("routing[%s]: fast=%ldKB slow=%ldKB (want fast=0, slow>0)\n",
+			       cg, used_fast, used_slow);
+out:
+	if (pid > 0) {
+		kill(pid, SIGKILL);
+		waitpid(pid, NULL, 0);
+	}
+	if (zfast >= 0) {
+		swapoff(fast_dev);
+		zram_remove(zfast);
+	}
+	if (zslow >= 0) {
+		swapoff(slow_dev);
+		zram_remove(zslow);
+	}
+	return ret;
+}
+
+static int test_routing(const char *root)
+{
+	char *cg = cg_name(root, "swaptier_routing");
+	int ret = KSFT_FAIL;
+
+	if (!cg || cg_create(cg))
+		goto out;
+	if (cg_write(cg, TIERS_MAX, "fast 0"))
+		goto out;
+	ret = run_routing_case(cg);
+out:
+	if (cg) {
+		cg_destroy(cg);
+		free(cg);
+	}
+	return ret;
+}
+
+static char *make_parent(const char *root, const char *name)
+{
+	char *cg = cg_name(root, name);
+
+	if (cg && !cg_create(cg) &&
+	    !cg_write(cg, "cgroup.subtree_control", "+memory"))
+		return cg;
+
+	if (cg) {
+		cg_destroy(cg);
+		free(cg);
+	}
+	return NULL;
+}
+
+static int test_routing_parent_wins(const char *root)
+{
+	char *parent = make_parent(root, "swaptier_pwins");
+	char *child = NULL;
+	int ret = KSFT_FAIL;
+
+	if (!parent)
+		goto out;
+	if (cg_write(parent, TIERS_MAX, "fast 0"))
+		goto out;
+
+	child = cg_name(parent, "child");
+	if (!child || cg_create(child))
+		goto out;
+	if (cg_write(child, TIERS_MAX, "fast max"))	/* child tries to re-enable */
+		goto out;
+
+	ret = run_routing_case(child);
+out:
+	if (child) {
+		cg_destroy(child);
+		free(child);
+	}
+	if (parent) {
+		cg_destroy(parent);
+		free(parent);
+	}
+	return ret;
+}
+
+static int test_routing_child_restricts(const char *root)
+{
+	char *parent = make_parent(root, "swaptier_crestr");
+	char *child = NULL;
+	int ret = KSFT_FAIL;
+
+	if (!parent)
+		goto out;
+
+	child = cg_name(parent, "child");
+	if (!child || cg_create(child))
+		goto out;
+	if (cg_write(child, TIERS_MAX, "fast 0"))
+		goto out;
+
+	ret = run_routing_case(child);
+out:
+	if (child) {
+		cg_destroy(child);
+		free(child);
+	}
+	if (parent) {
+		cg_destroy(parent);
+		free(parent);
+	}
+	return ret;
+}
+
+static void tiers_clear(void)
+{
+	char buf[4096], *line, *save;
+	int fd;
+	ssize_t n;
+
+	fd = open(TIERS_PATH, O_RDONLY);
+	if (fd < 0)
+		return;
+	n = read(fd, buf, sizeof(buf) - 1);
+	close(fd);
+	if (n < 0)
+		return;
+	buf[n] = '\0';
+
+	for (line = strtok_r(buf, "\n", &save); line;
+	     line = strtok_r(NULL, "\n", &save)) {
+		char name[64], cmd[80];
+		int idx, s, e;
+
+		if (sscanf(line, "%63s %d %d %d", name, &idx, &s, &e) != 4)
+			continue;
+		snprintf(cmd, sizeof(cmd), "-%s", name);
+		tiers_write(cmd);
+	}
+}
+
+int main(void)
+{
+	char root[PATH_MAX];
+
+	ksft_print_header();
+	ksft_set_plan(7);
+
+	if (geteuid() != 0)
+		ksft_exit_skip("test requires root\n");
+	if (cg_find_unified_root(root, sizeof(root), NULL))
+		ksft_exit_skip("cgroup v2 isn't mounted\n");
+	if (cg_read_strstr(root, "cgroup.controllers", "memory"))
+		ksft_exit_skip("memory controller isn't available\n");
+	if (cg_read_strstr(root, "cgroup.subtree_control", "memory"))
+		if (cg_write(root, "cgroup.subtree_control", "+memory"))
+			ksft_exit_skip("failed to enable memory controller\n");
+	if (access(TIERS_PATH, F_OK))
+		ksft_exit_skip("swap tiers interface not present\n");
+	if (tier_count() != 0)
+		ksft_exit_skip("swap tiers already configured; run on a clean system\n");
+
+	/* Two tiers: fast = [10, MAX], slow = [-1, 9]. */
+	if (tiers_write("+slow:-1 +fast:10"))
+		ksft_exit_skip("failed to configure swap tiers\n");
+
+	ksft_test_result(test_default(root) == KSFT_PASS, "default mask is max\n");
+	ksft_test_result(test_toggle(root) == KSFT_PASS, "enable/disable tier\n");
+	ksft_test_result(test_invalid(root) == KSFT_PASS, "invalid input rejected\n");
+	ksft_test_result(test_recreate(root) == KSFT_PASS,
+			 "recreated tier resets cgroup mask\n");
+
+	ksft_test_result_code(test_routing(root),
+			      "swapout honors tier mask", NULL);
+	ksft_test_result_code(test_routing_parent_wins(root),
+			      "child cannot re-enable a parent-disabled tier", NULL);
+	ksft_test_result_code(test_routing_child_restricts(root),
+			      "child can restrict tiers below its parent", NULL);
+
+	tiers_clear();
+
+	ksft_finished();
+}
-- 
2.34.1


