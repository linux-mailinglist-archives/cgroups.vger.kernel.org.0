Return-Path: <cgroups+bounces-15588-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Pv2KIFb+GlStQIAu9opvQ
	(envelope-from <cgroups+bounces-15588-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 04 May 2026 10:40:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C3F4BA5F5
	for <lists+cgroups@lfdr.de>; Mon, 04 May 2026 10:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF90D30205D1
	for <lists+cgroups@lfdr.de>; Mon,  4 May 2026 08:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FFC342CB6;
	Mon,  4 May 2026 08:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pn1dJ8s/"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F5C341AB6
	for <cgroups@vger.kernel.org>; Mon,  4 May 2026 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883983; cv=none; b=RpGfXvenviqNbZtwNHjfztzSpufNX1/AtfBuEj4ipHEvFqEq/2T8Zr7jqlmbbuQDsVSkqRIJvPxjZv5nDwwQDrsxf3EfAItAJUq2QHAhgCAZ63drbKOZMacEn150R9aRvaH8gfHoG1EGCmw3ZLX00oY7F+XUnk56dqoSqyceb3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883983; c=relaxed/simple;
	bh=6uWaCheGmLgukNolf3HipU9NOA5Fe1HK6CjH1nEq/eQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MIeZJpVSNs2IxBNNPxNnQp4BNivO1eMgDGZ5CCbiGD2PiYf0jz0KVesYlxKs41UncKqfRZkgiIs3r+spSxPOL0ZzudrcF/j7RXDffscCVvBSF1rqnVQ5bAkvB4pFxhrNFO2dM62ZnZKRnIInB1N4x+4/kEy82+7bS/aeDHg1aNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pn1dJ8s/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777883981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p9LU2kvm8WmZLGE0Hzo3NSZzBLUUNYvesoYfRDXEHVk=;
	b=Pn1dJ8s/P/5X79TgHYftLVNZaBRwD4HnK4WuOox6HFRSSwjtlhy2Kmu6CzYyns9u3lILoF
	vO2L4kjG4Q94nuDwq8sDIMEpjou25iyTlB5/UadHw4SUDiT9yUAzc/R4Q8bPjS8lQoJn4K
	miEEB0xUvegwFKipwI3bfrIpA9B1u/4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-nuSdj70DPYWGFrYSQlcKsg-1; Mon,
 04 May 2026 04:39:37 -0400
X-MC-Unique: nuSdj70DPYWGFrYSQlcKsg-1
X-Mimecast-MFC-AGG-ID: nuSdj70DPYWGFrYSQlcKsg_1777883976
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5BD86180034A;
	Mon,  4 May 2026 08:39:36 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A25D180045E;
	Mon,  4 May 2026 08:39:34 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 04 May 2026 10:39:24 +0200
Subject: [PATCH v3 2/4] selftests: cgroup: Add dmem selftest coverage
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-kunit_cgroups-v3-2-4eac90b76f91@redhat.com>
References: <20260504-kunit_cgroups-v3-0-4eac90b76f91@redhat.com>
In-Reply-To: <20260504-kunit_cgroups-v3-0-4eac90b76f91@redhat.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Albert Esteve <aesteve@redhat.com>, 
 mripard@redhat.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777883968; l=15431;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=6uWaCheGmLgukNolf3HipU9NOA5Fe1HK6CjH1nEq/eQ=;
 b=USjH69OI+OILEI/qtezkVXTKIWpz6i8+ouT72wMtbY/llQVbTC/d0JVzIwqyqxMUth6rOqCs1
 u13ionUip2DBFmctbmVaz6nPxLu/7VX10fgFFBl399zSz3ORH4PlMVU
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 57C3F4BA5F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15588-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Currently, tools/testing/selftests/cgroup/ does not include
a dmem-specific test binary. This leaves dmem charge and
limit behavior largely unvalidated in kselftest coverage.

Add test_dmem and wire it into the cgroup selftests Makefile.
The new test exercises dmem controller behavior through the
dmem_selftest debugfs interface for the dmem_selftest region.

The test adds three complementary checks:
- test_dmem_max creates a nested hierarchy with per-leaf
  dmem.max values and verifies that over-limit charges
  fail while in-limit charges succeed with bounded rounding
  in dmem.current.
- test_dmem_min and test_dmem_low verify that charging
  from a cgroup with the corresponding protection knob
  set updates dmem.current as expected.
- test_dmem_charge_byte_granularity validates accounting
  bounds for non-page-aligned charge sizes and
  uncharge-to-zero behavior.

This provides deterministic userspace coverage for dmem
accounting and hard-limit enforcement using a test helper
module, without requiring subsystem-specific production
drivers.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 tools/testing/selftests/cgroup/.gitignore  |   1 +
 tools/testing/selftests/cgroup/Makefile    |   2 +
 tools/testing/selftests/cgroup/config      |   2 +
 tools/testing/selftests/cgroup/test_dmem.c | 492 +++++++++++++++++++++++++++++
 4 files changed, 497 insertions(+)

diff --git a/tools/testing/selftests/cgroup/.gitignore b/tools/testing/selftests/cgroup/.gitignore
index 952e4448bf070..ea2322598217d 100644
--- a/tools/testing/selftests/cgroup/.gitignore
+++ b/tools/testing/selftests/cgroup/.gitignore
@@ -2,6 +2,7 @@
 test_core
 test_cpu
 test_cpuset
+test_dmem
 test_freezer
 test_hugetlb_memcg
 test_kill
diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
index e01584c2189ac..e1a5e9316620e 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -10,6 +10,7 @@ TEST_GEN_FILES := wait_inotify
 TEST_GEN_PROGS  = test_core
 TEST_GEN_PROGS += test_cpu
 TEST_GEN_PROGS += test_cpuset
+TEST_GEN_PROGS += test_dmem
 TEST_GEN_PROGS += test_freezer
 TEST_GEN_PROGS += test_hugetlb_memcg
 TEST_GEN_PROGS += test_kill
@@ -26,6 +27,7 @@ include lib/libcgroup.mk
 $(OUTPUT)/test_core: $(LIBCGROUP_O)
 $(OUTPUT)/test_cpu: $(LIBCGROUP_O)
 $(OUTPUT)/test_cpuset: $(LIBCGROUP_O)
+$(OUTPUT)/test_dmem: $(LIBCGROUP_O)
 $(OUTPUT)/test_freezer: $(LIBCGROUP_O)
 $(OUTPUT)/test_hugetlb_memcg: $(LIBCGROUP_O)
 $(OUTPUT)/test_kill: $(LIBCGROUP_O)
diff --git a/tools/testing/selftests/cgroup/config b/tools/testing/selftests/cgroup/config
index 39f979690dd3b..5728278310a31 100644
--- a/tools/testing/selftests/cgroup/config
+++ b/tools/testing/selftests/cgroup/config
@@ -1,6 +1,8 @@
 CONFIG_CGROUPS=y
 CONFIG_CGROUP_CPUACCT=y
+CONFIG_CGROUP_DMEM=y
 CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_SCHED=y
+CONFIG_DMEM_SELFTEST=m
 CONFIG_MEMCG=y
 CONFIG_PAGE_COUNTER=y
diff --git a/tools/testing/selftests/cgroup/test_dmem.c b/tools/testing/selftests/cgroup/test_dmem.c
new file mode 100644
index 0000000000000..0a1b9561a1b9e
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_dmem.c
@@ -0,0 +1,492 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test the dmem (device memory) cgroup controller.
+ *
+ * Depends on dmem_selftest kernel module.
+ */
+
+#define _GNU_SOURCE
+
+#include <linux/limits.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include "kselftest.h"
+#include "cgroup_util.h"
+
+/* kernel/cgroup/dmem_selftest.c */
+#define DM_SELFTEST_REGION	"dmem_selftest"
+#define DM_SELFTEST_CHARGE	"/sys/kernel/debug/dmem_selftest/charge"
+#define DM_SELFTEST_UNCHARGE	"/sys/kernel/debug/dmem_selftest/uncharge"
+
+/*
+ * Parse the first line of dmem.capacity (root):
+ *   "<name> <size_in_bytes>"
+ * Returns 1 if a region was found, 0 if capacity is empty, -1 on read error.
+ */
+static int parse_first_region(const char *root, char *name, size_t name_len,
+			      unsigned long long *size_out)
+{
+	char buf[4096];
+	char nm[256];
+	unsigned long long sz;
+
+	if (cg_read(root, "dmem.capacity", buf, sizeof(buf)) < 0)
+		return -1;
+
+	if (sscanf(buf, "%255s %llu", nm, &sz) < 2)
+		return 0;
+
+	if (name_len <= strlen(nm))
+		return -1;
+
+	strcpy(name, nm);
+	*size_out = sz;
+	return 1;
+}
+
+/*
+ * Read the numeric limit for @region_name from a multiline
+ * dmem.{min,low,max} file. Returns bytes,
+ * or -1 if the line is "<name> max", or -2 if missing/err.
+ */
+static long long dmem_read_limit_for_region(const char *cgroup, const char *ctrl,
+					    const char *region_name)
+{
+	char buf[4096];
+	char *line, *saveptr = NULL;
+	char fname[256];
+	char fval[64];
+
+	if (cg_read(cgroup, ctrl, buf, sizeof(buf)) < 0)
+		return -2;
+
+	for (line = strtok_r(buf, "\n", &saveptr); line;
+	     line = strtok_r(NULL, "\n", &saveptr)) {
+		if (!line[0])
+			continue;
+		if (sscanf(line, "%255s %63s", fname, fval) != 2)
+			continue;
+		if (strcmp(fname, region_name))
+			continue;
+		if (!strcmp(fval, "max"))
+			return -1;
+		return strtoll(fval, NULL, 0);
+	}
+	return -2;
+}
+
+static long long dmem_read_limit(const char *cgroup, const char *ctrl)
+{
+	return dmem_read_limit_for_region(cgroup, ctrl, DM_SELFTEST_REGION);
+}
+
+static int dmem_write_limit(const char *cgroup, const char *ctrl,
+			    const char *val)
+{
+	char wr[512];
+
+	snprintf(wr, sizeof(wr), "%s %s", DM_SELFTEST_REGION, val);
+	return cg_write(cgroup, ctrl, wr);
+}
+
+static int dmem_selftest_charge_bytes(unsigned long long bytes)
+{
+	char wr[32];
+
+	snprintf(wr, sizeof(wr), "%llu", bytes);
+	return write_text(DM_SELFTEST_CHARGE, wr, strlen(wr));
+}
+
+static int dmem_selftest_uncharge(void)
+{
+	return write_text(DM_SELFTEST_UNCHARGE, "\n", 1);
+}
+
+/*
+ * First, this test creates the following hierarchy:
+ * A
+ * A/B     dmem.max=1M
+ * A/B/C   dmem.max=75K
+ * A/B/D   dmem.max=25K
+ * A/B/E   dmem.max=8K
+ * A/B/F   dmem.max=0
+ *
+ * Then for each leaf cgroup it tries to charge above dmem.max
+ * and expects the charge request to fail and dmem.current to
+ * remain unchanged.
+ *
+ * For leaves with non-zero dmem.max, it additionally charges a
+ * smaller amount and verifies accounting grows within one PAGE_SIZE
+ * rounding bound, then uncharges and verifies dmem.current returns
+ * to the previous value.
+ *
+ */
+static int test_dmem_max(const char *root)
+{
+	static const char * const leaf_max[] = { "75K", "25K", "8K", "0" };
+	static const unsigned long long fail_sz[] = {
+		(75ULL * 1024ULL) + 1ULL,
+		(25ULL * 1024ULL) + 1ULL,
+		(8ULL * 1024ULL) + 1ULL,
+		1ULL
+	};
+	static const unsigned long long pass_sz[] = {
+		4096ULL, 4096ULL, 4096ULL, 0ULL
+	};
+	char *parent[2] = {NULL};
+	char *children[4] = {NULL};
+	unsigned long long cap;
+	char region[256];
+	long long page_size;
+	long long cur_before, cur_after;
+	int ret = KSFT_FAIL;
+	int charged = 0;
+	int in_child = 0;
+	long long v;
+	int i;
+
+	if (access(DM_SELFTEST_CHARGE, W_OK) != 0)
+		return KSFT_SKIP;
+
+	if (parse_first_region(root, region, sizeof(region), &cap) != 1)
+		return KSFT_SKIP;
+	if (strcmp(region, DM_SELFTEST_REGION) != 0)
+		return KSFT_SKIP;
+
+	page_size = sysconf(_SC_PAGESIZE);
+	if (page_size <= 0)
+		goto cleanup;
+
+	parent[0] = cg_name(root, "dmem_prot_0");
+	if (!parent[0])
+		goto cleanup;
+
+	parent[1] = cg_name(parent[0], "dmem_prot_1");
+	if (!parent[1])
+		goto cleanup;
+
+	if (cg_create(parent[0]))
+		goto cleanup;
+
+	if (cg_write(parent[0], "cgroup.subtree_control", "+dmem"))
+		goto cleanup;
+
+	if (cg_create(parent[1]))
+		goto cleanup;
+
+	if (cg_write(parent[1], "cgroup.subtree_control", "+dmem"))
+		goto cleanup;
+
+	for (i = 0; i < 4; i++) {
+		children[i] = cg_name_indexed(parent[1], "dmem_child", i);
+		if (!children[i])
+			goto cleanup;
+		if (cg_create(children[i]))
+			goto cleanup;
+	}
+
+	if (dmem_write_limit(parent[1], "dmem.max", "1M"))
+		goto cleanup;
+	for (i = 0; i < 4; i++)
+		if (dmem_write_limit(children[i], "dmem.max", leaf_max[i]))
+			goto cleanup;
+
+	v = dmem_read_limit(parent[1], "dmem.max");
+	if (!values_close(v, 1024LL * 1024LL, 3))
+		goto cleanup;
+	v = dmem_read_limit(children[0], "dmem.max");
+	if (!values_close(v, 75LL * 1024LL, 3))
+		goto cleanup;
+	v = dmem_read_limit(children[1], "dmem.max");
+	if (!values_close(v, 25LL * 1024LL, 3))
+		goto cleanup;
+	v = dmem_read_limit(children[2], "dmem.max");
+	if (!values_close(v, 8LL * 1024LL, 3))
+		goto cleanup;
+	v = dmem_read_limit(children[3], "dmem.max");
+	if (v != 0)
+		goto cleanup;
+
+	for (i = 0; i < 4; i++) {
+		if (cg_enter_current(children[i]))
+			goto cleanup;
+		in_child = 1;
+
+		cur_before = dmem_read_limit(children[i], "dmem.current");
+		if (cur_before < 0)
+			goto cleanup;
+
+		if (dmem_selftest_charge_bytes(fail_sz[i]) >= 0) {
+			charged = 1;
+			goto cleanup;
+		}
+
+		cur_after = dmem_read_limit(children[i], "dmem.current");
+		if (cur_after != cur_before)
+			goto cleanup;
+
+		if (pass_sz[i] > 0) {
+			if (dmem_selftest_charge_bytes(pass_sz[i]) < 0)
+				goto cleanup;
+			charged = 1;
+
+			cur_after = dmem_read_limit(children[i], "dmem.current");
+			if (cur_after < cur_before + (long long)pass_sz[i])
+				goto cleanup;
+			if (cur_after > cur_before + (long long)pass_sz[i] + page_size)
+				goto cleanup;
+
+			if (dmem_selftest_uncharge() < 0)
+				goto cleanup;
+			charged = 0;
+
+			cur_after = dmem_read_limit(children[i], "dmem.current");
+			if (cur_after != cur_before)
+				goto cleanup;
+		}
+
+		if (cg_enter_current(root))
+			goto cleanup;
+		in_child = 0;
+	}
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (charged)
+		dmem_selftest_uncharge();
+	if (in_child)
+		cg_enter_current(root);
+	for (i = 3; i >= 0; i--) {
+		if (!children[i])
+			continue;
+		cg_destroy(children[i]);
+		free(children[i]);
+	}
+	for (i = 1; i >= 0; i--) {
+		if (!parent[i])
+			continue;
+		cg_destroy(parent[i]);
+		free(parent[i]);
+	}
+	return ret;
+}
+
+/*
+ * This test sets dmem.min and dmem.low on a child cgroup, then charge
+ * from that context and verify dmem.current tracks the charged bytes
+ * (within one page rounding).
+ */
+static int test_dmem_charge_with_attr(const char *root, bool min)
+{
+	char region[256];
+	unsigned long long cap;
+	const unsigned long long charge_sz = 12345ULL;
+	const char *attribute = min ? "dmem.min" : "dmem.low";
+	int ret = KSFT_FAIL;
+	char *cg = NULL;
+	long long cur;
+	long long page_size;
+	int charged = 0;
+	int in_child = 0;
+
+	if (access(DM_SELFTEST_CHARGE, W_OK) != 0)
+		return KSFT_SKIP;
+
+	if (parse_first_region(root, region, sizeof(region), &cap) != 1)
+		return KSFT_SKIP;
+	if (strcmp(region, DM_SELFTEST_REGION) != 0)
+		return KSFT_SKIP;
+
+	page_size = sysconf(_SC_PAGESIZE);
+	if (page_size <= 0)
+		goto cleanup;
+
+	cg = cg_name(root, "test_dmem_attr");
+	if (!cg)
+		goto cleanup;
+
+	if (cg_create(cg))
+		goto cleanup;
+
+	if (cg_enter_current(cg))
+		goto cleanup;
+	in_child = 1;
+
+	if (dmem_write_limit(cg, attribute, "16K"))
+		goto cleanup;
+
+	if (dmem_selftest_charge_bytes(charge_sz) < 0)
+		goto cleanup;
+	charged = 1;
+
+	cur = dmem_read_limit(cg, "dmem.current");
+	if (cur < (long long)charge_sz)
+		goto cleanup;
+	if (cur > (long long)charge_sz + page_size)
+		goto cleanup;
+
+	if (dmem_selftest_uncharge() < 0)
+		goto cleanup;
+	charged = 0;
+
+	cur = dmem_read_limit(cg, "dmem.current");
+	if (cur != 0)
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (charged)
+		dmem_selftest_uncharge();
+	if (in_child)
+		cg_enter_current(root);
+	cg_destroy(cg);
+	free(cg);
+	return ret;
+}
+
+static int test_dmem_min(const char *root)
+{
+	return test_dmem_charge_with_attr(root, true);
+}
+
+static int test_dmem_low(const char *root)
+{
+	return test_dmem_charge_with_attr(root, false);
+}
+
+/*
+ * This test charges non-page-aligned byte sizes and verify dmem.current
+ * stays consistent: it must account at least the requested bytes and
+ * never exceed one kernel page of rounding overhead. Then uncharge must
+ * return usage to 0.
+ */
+static int test_dmem_charge_byte_granularity(const char *root)
+{
+	static const unsigned long long sizes[] = { 1ULL, 4095ULL, 4097ULL, 12345ULL };
+	char *cg = NULL;
+	unsigned long long cap;
+	char region[256];
+	long long cur;
+	long long page_size;
+	int ret = KSFT_FAIL;
+	int charged = 0;
+	int in_child = 0;
+	size_t i;
+
+	if (access(DM_SELFTEST_CHARGE, W_OK) != 0)
+		return KSFT_SKIP;
+
+	if (parse_first_region(root, region, sizeof(region), &cap) != 1)
+		return KSFT_SKIP;
+	if (strcmp(region, DM_SELFTEST_REGION) != 0)
+		return KSFT_SKIP;
+
+	page_size = sysconf(_SC_PAGESIZE);
+	if (page_size <= 0)
+		goto cleanup;
+
+	cg = cg_name(root, "dmem_dbg_byte_gran");
+	if (!cg)
+		goto cleanup;
+
+	if (cg_create(cg))
+		goto cleanup;
+
+	if (dmem_write_limit(cg, "dmem.max", "8M"))
+		goto cleanup;
+
+	if (cg_enter_current(cg))
+		goto cleanup;
+	in_child = 1;
+
+	for (i = 0; i < ARRAY_SIZE(sizes); i++) {
+		if (dmem_selftest_charge_bytes(sizes[i]) < 0)
+			goto cleanup;
+		charged = 1;
+
+		cur = dmem_read_limit(cg, "dmem.current");
+		if (cur < (long long)sizes[i])
+			goto cleanup;
+		if (cur > (long long)sizes[i] + page_size)
+			goto cleanup;
+
+		if (dmem_selftest_uncharge() < 0)
+			goto cleanup;
+		charged = 0;
+
+		cur = dmem_read_limit(cg, "dmem.current");
+		if (cur != 0)
+			goto cleanup;
+	}
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (charged)
+		dmem_selftest_uncharge();
+	if (in_child)
+		cg_enter_current(root);
+	if (cg) {
+		cg_destroy(cg);
+		free(cg);
+	}
+	return ret;
+}
+
+#define T(x) { x, #x }
+struct dmem_test {
+	int (*fn)(const char *root);
+	const char *name;
+} tests[] = {
+	T(test_dmem_max),
+	T(test_dmem_min),
+	T(test_dmem_low),
+	T(test_dmem_charge_byte_granularity),
+};
+#undef T
+
+int main(int argc, char **argv)
+{
+	char root[PATH_MAX];
+	int i;
+
+	ksft_print_header();
+	ksft_set_plan(ARRAY_SIZE(tests));
+
+	if (cg_find_unified_root(root, sizeof(root), NULL))
+		ksft_exit_skip("cgroup v2 isn't mounted\n");
+
+	if (cg_read_strstr(root, "cgroup.controllers", "dmem"))
+		ksft_exit_skip("dmem controller isn't available (CONFIG_CGROUP_DMEM?)\n");
+
+	if (cg_read_strstr(root, "cgroup.subtree_control", "dmem"))
+		if (cg_write(root, "cgroup.subtree_control", "+dmem"))
+			ksft_exit_skip("Failed to enable dmem controller\n");
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		switch (tests[i].fn(root)) {
+		case KSFT_PASS:
+			ksft_test_result_pass("%s\n", tests[i].name);
+			break;
+		case KSFT_SKIP:
+			ksft_test_result_skip(
+				"%s (need CONFIG_DMEM_SELFTEST, modprobe dmem_selftest)\n",
+				tests[i].name);
+			break;
+		default:
+			ksft_test_result_fail("%s\n", tests[i].name);
+			break;
+		}
+	}
+
+	ksft_finished();
+}

-- 
2.53.0


