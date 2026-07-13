Return-Path: <cgroups+bounces-17687-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uyboBQBYVGqEkwMAu9opvQ
	(envelope-from <cgroups+bounces-17687-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 05:14:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E656746DFD
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 05:14:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lge.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17687-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17687-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05B4F303ADE5
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 03:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9A932861F;
	Mon, 13 Jul 2026 03:12:01 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAA73783C1
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 03:11:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783912321; cv=none; b=qqSDZOObMjSaShX2zLHjitPIutvpWy+lRByDTaIFzkfBQ8IBHBxaNwPDmeU22hTuHco/ImfkUQs9YnusCZx5KWarNp6Pn5V19XHrmwAptZfyTI93OHdzpyI4BH55cTpMm+uwQV0vva5hloI6T2Q7xOY+9xPvK3cRBUwysYP35Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783912321; c=relaxed/simple;
	bh=bukIn4M5GcFVgBkxOM9fvlzuU2owjZnHyKpTIjqPKtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KR7yOB5pKj+s3hs49ebXRU4HuemYQIdLi1MfjB54vBKVu33SyzB0ZwA/aMIH7faJaYITZIliIgL/Qd7hrdIisLoEpdRHsCI+znvTV0HBCD+Ey8qAtJJLGo6BRiRIT5BodgoSbcfxnPLmzN15D5Iv2PizR6vKWBZBGBAdZ9i9r1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 13 Jul 2026 11:56:54 +0900
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
Subject: [PATCH v10 5/6] selftests/mm: add a swap tier configuration test
Date: Mon, 13 Jul 2026 11:56:43 +0900
Message-Id: <20260713025644.170839-6-youngjun.park@lge.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17687-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lge.com:from_mime,lge.com:email,lge.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E656746DFD

This commit adds a test program for the global swap tier interface at
/sys/kernel/mm/swap/tiers. It checks the add, split and remove
operations and the documented error and batch atomicity rules. It also
checks that a tier with an active swap device cannot be removed until
the device is swapped off. That device is a zram device, and the check
is skipped when zram is not available.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 tools/testing/selftests/mm/.gitignore     |   1 +
 tools/testing/selftests/mm/Makefile       |   1 +
 tools/testing/selftests/mm/config         |   2 +
 tools/testing/selftests/mm/run_vmtests.sh |   5 +
 tools/testing/selftests/mm/swap_tier.c    | 337 ++++++++++++++++++++++
 5 files changed, 346 insertions(+)
 create mode 100644 tools/testing/selftests/mm/swap_tier.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 227476d8ff1f..94ee61a9914d 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -44,6 +44,7 @@ hmm-tests
 memfd_secret
 soft-dirty
 split_huge_page_test
+swap_tier
 ksm_tests
 local_config.h
 local_config.mk
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index ee8def9b4c31..4e47191e06ff 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -104,6 +104,7 @@ TEST_GEN_FILES += guard-regions
 TEST_GEN_FILES += merge
 TEST_GEN_FILES += rmap
 TEST_GEN_FILES += folio_split_race_test
+TEST_GEN_FILES += swap_tier
 
 ifneq ($(ARCH),arm64)
 TEST_GEN_FILES += soft-dirty
diff --git a/tools/testing/selftests/mm/config b/tools/testing/selftests/mm/config
index 06f78bd232e2..de3752e1bbd2 100644
--- a/tools/testing/selftests/mm/config
+++ b/tools/testing/selftests/mm/config
@@ -14,3 +14,5 @@ CONFIG_UPROBES=y
 CONFIG_MEMORY_FAILURE=y
 CONFIG_HWPOISON_INJECT=m
 CONFIG_PROC_MEM_ALWAYS_FORCE=y
+CONFIG_SWAP=y
+CONFIG_ZRAM=y
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index a60b9f9f16e7..06d53fad82ba 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -71,6 +71,8 @@ separated by spaces:
 	tests for VM_PFNMAP handling
 - process_madv
 	test for process_madv
+- swap_tier
+	test the /sys/kernel/mm/swap/tiers configuration interface
 - cow
 	test copy-on-write semantics
 - thp
@@ -352,6 +354,9 @@ CATEGORY="process_madv" run_test ./process_madv
 
 CATEGORY="vma_merge" run_test ./merge
 
+# swap tier configuration interface (/sys/kernel/mm/swap/tiers)
+CATEGORY="swap_tier" run_test ./swap_tier
+
 if [ -x ./memfd_secret ]
 then
 if [ -f /proc/sys/kernel/yama/ptrace_scope ]; then
diff --git a/tools/testing/selftests/mm/swap_tier.c b/tools/testing/selftests/mm/swap_tier.c
new file mode 100644
index 000000000000..bc77b59a7270
--- /dev/null
+++ b/tools/testing/selftests/mm/swap_tier.c
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/swap.h>
+#include <unistd.h>
+
+#include "kselftest.h"
+
+#define TIERS_PATH "/sys/kernel/mm/swap/tiers"
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
+static int tier_range(const char *name, int *start, int *end)
+{
+	char buf[4096], *line, *save;
+	int fd;
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
+		char tname[64];
+		int idx, s, e;
+
+		if (sscanf(line, "%63s %d %d %d", tname, &idx, &s, &e) != 4)
+			continue;
+		if (!strcmp(tname, name)) {
+			*start = s;
+			*end = e;
+			return 0;
+		}
+	}
+	return -1;
+}
+
+static bool tier_exists(const char *name)
+{
+	int s, e;
+
+	return tier_range(name, &s, &e) == 0;
+}
+
+static bool range_is(const char *name, int start, int end)
+{
+	int s, e;
+
+	if (tier_range(name, &s, &e))
+		return false;
+	return s == start && e == end;
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
+		char tname[64];
+		int idx, s, e;
+
+		if (sscanf(line, "%63s %d %d %d", tname, &idx, &s, &e) == 4)
+			count++;
+	}
+	return count;
+}
+
+static int test_coverage(void)
+{
+	if (tiers_write("+orphan:100") != -EINVAL)
+		return KSFT_FAIL;
+	if (tier_exists("orphan"))
+		return KSFT_FAIL;
+	return KSFT_PASS;
+}
+
+static int test_add(void)
+{
+	if (tiers_write("+lo:-1 +hi:50"))
+		return KSFT_FAIL;
+	if (!range_is("hi", 50, SHRT_MAX) || !range_is("lo", -1, 49))
+		return KSFT_FAIL;
+	return KSFT_PASS;
+}
+
+static int test_split(void)
+{
+	if (tiers_write("+mid:100"))
+		return KSFT_FAIL;
+	if (!range_is("mid", 100, SHRT_MAX) ||
+	    !range_is("hi", 50, 99) ||
+	    !range_is("lo", -1, 49))
+		return KSFT_FAIL;
+	return KSFT_PASS;
+}
+
+static int test_remove(void)
+{
+	/* Remove the top tier: 'hi' re-expands upward to SHRT_MAX. */
+	if (tiers_write("-mid"))
+		return KSFT_FAIL;
+	if (tier_exists("mid") || !range_is("hi", 50, SHRT_MAX))
+		return KSFT_FAIL;
+
+	/* Remove the lowest tier: 'hi' shifts its start down to -1. */
+	if (tiers_write("-lo"))
+		return KSFT_FAIL;
+	if (tier_exists("lo") || !range_is("hi", -1, SHRT_MAX))
+		return KSFT_FAIL;
+
+	return KSFT_PASS;
+}
+
+static int test_errors(void)
+{
+	if (tiers_write("+hi:100") != -EEXIST)		/* duplicate name */
+		return KSFT_FAIL;
+	if (tiers_write("+bad.name:100") != -EINVAL)	/* illegal name */
+		return KSFT_FAIL;
+	if (tiers_write("+dup:-1") != -EBUSY)		/* priority in use */
+		return KSFT_FAIL;
+	if (tiers_write("+low:-2") != -EINVAL)		/* prio < DEF_SWAP_PRIO */
+		return KSFT_FAIL;
+	return KSFT_PASS;
+}
+
+/*
+ * A write carrying several operations is atomic: if any operation fails, the
+ * whole batch is rolled back.
+ */
+static int test_atomic(void)
+{
+	if (tiers_write("+a:50 +a:60") != -EEXIST)
+		return KSFT_FAIL;
+	if (tier_exists("a") || !range_is("hi", -1, SHRT_MAX))
+		return KSFT_FAIL;
+	return KSFT_PASS;
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
+	write(fd, val, strlen(val)); /* ignore error. best-effort cleanup */
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
+static int wait_for_dev(const char *dev)
+{
+	int i;
+
+	for (i = 0; i < 50; i++) {
+		if (access(dev, F_OK) == 0)
+			return 0;
+
+		usleep(100000);
+	}
+
+	return -1;
+}
+
+static int test_device_pins_tier(void)
+{
+	char dev[32];
+	int zidx, ret = KSFT_FAIL;
+
+	if (tiers_write("+top:50"))
+		return KSFT_FAIL;
+
+	zidx = zram_add(64 << 20);
+	if (zidx < 0) {
+		ret = KSFT_SKIP;
+		goto out_tier;
+	}
+	snprintf(dev, sizeof(dev), "/dev/zram%d", zidx);
+
+	if (wait_for_dev(dev)) {
+		ret = KSFT_SKIP;
+		goto out_zram;
+	}
+
+	if (swap_setup(dev, 50)) {
+		ret = KSFT_SKIP;
+		goto out_zram;
+	}
+
+	if (tiers_write("-top") == -EBUSY) {		/* blocked while active */
+		swapoff(dev);
+		if (!tiers_write("-top"))		/* removable after swapoff */
+			ret = KSFT_PASS;
+	} else {
+		swapoff(dev);
+	}
+out_zram:
+	zram_remove(zidx);
+out_tier:
+	tiers_write("-top");
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
+	ksft_print_header();
+	ksft_set_plan(7);
+
+	if (geteuid() != 0)
+		ksft_exit_skip("test requires root\n");
+	if (access(TIERS_PATH, F_OK))
+		ksft_exit_skip("%s not present (CONFIG_SWAP/tiers)\n", TIERS_PATH);
+	if (tier_count() != 0)
+		ksft_exit_skip("swap tiers already configured; run on a clean system\n");
+
+	ksft_test_result(test_coverage() == KSFT_PASS, "coverage rule\n");
+	ksft_test_result(test_add() == KSFT_PASS, "add tiers\n");
+	ksft_test_result(test_split() == KSFT_PASS, "split tier\n");
+	ksft_test_result(test_remove() == KSFT_PASS, "remove and merge\n");
+	ksft_test_result(test_errors() == KSFT_PASS, "invalid operations\n");
+	ksft_test_result(test_atomic() == KSFT_PASS, "batch atomicity\n");
+
+	ksft_test_result_code(test_device_pins_tier(), "device pins its tier", NULL);
+
+	tiers_clear();
+
+	ksft_finished();
+}
-- 
2.34.1


