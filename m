Return-Path: <cgroups+bounces-15638-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YF13OcA4+2nUXwMAu9opvQ
	(envelope-from <cgroups+bounces-15638-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 14:49:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B354DA7E2
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 14:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C542302F27F
	for <lists+cgroups@lfdr.de>; Wed,  6 May 2026 12:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A2D449EC3;
	Wed,  6 May 2026 12:43:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3770640DFAB
	for <cgroups@vger.kernel.org>; Wed,  6 May 2026 12:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071417; cv=none; b=sOfnHgKzlH2ME1XUFGzlDK+2ia9fp3SX0AbGPxZJYNjsQ3GgNTgrpR/13FsmMz/Hfbii/uHA/bB5tfHUh45Oj1yUyxWsypzrCralG9peupJeSfYZPSy87B1WuxHF7eHKml+zjS0PJUcJRlBzm+UwSHrnonvB/mK3nx2oR34jerM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071417; c=relaxed/simple;
	bh=d3kQIx97IU2qFJJjqd9ig5uAGibvoEzD1Ds6Yu4+EYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h12PjzKCTm2j/i2Gd+mYb+7Xh7qS5OMFF4IdbVeBvGGz3qowHjTxkSgBwYx+b1/GQCYME44Kd2pbaNInXrCwXv/CFCdUdEv6v52PeC5nlAUV8nCAV/UQwHXqiDLFHbB8d2dfK42PXSqHM28mNDBN2z5Xi7plqfnWjsVW5eFs3As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2b4272fe494911f1aa26b74ffac11d73-20260506
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_AS_FROM, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:3b8f0c5f-c917-4181-b263-48f2ec552130,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:30
X-CID-INFO: VERSION:1.3.12,REQID:3b8f0c5f-c917-4181-b263-48f2ec552130,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:e7bac3a,CLOUDID:5a92cb955eba10c011ffc41a2aa74ac1,BulkI
	D:260506204324NDC0K6R6,BulkQuantity:0,Recheck:0,SF:17|19|66|78|81|82|102|1
	27|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2b4272fe494911f1aa26b74ffac11d73-20260506
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1692364794; Wed, 06 May 2026 20:43:23 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: cuitao@kylinos.cn
Cc: cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	tj@kernel.org
Subject: [PATCH v2] selftests: cgroup: Add basic tests for rdma controller
Date: Wed,  6 May 2026 20:43:07 +0800
Message-ID: <20260506124307.15729-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f374cebb-f8c1-4d7e-8771-aac018cbd9fd@kylinos.cn>
References: <f374cebb-f8c1-4d7e-8771-aac018cbd9fd@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 35B354DA7E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15638-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:mid,kylinos.cn:email]

This patch adds (and wires in) new test program for verifying rdma
controller behavior -- checking that rdma.current correctly tracks
resource allocation/deallocation and that rdma.max limits are enforced.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>

---
Changes in v2:
- Replace rdma.max interface-only tests with tests that verify actual
  rdma.current behavior and limit enforcement
- Use libibverbs (conditionally compiled) to allocate real IB resources
- Skip gracefully when no RDMA device is present
---
 tools/testing/selftests/cgroup/Makefile    |   9 +
 tools/testing/selftests/cgroup/test_rdma.c | 327 +++++++++++++++++++++
 2 files changed, 336 insertions(+)
 create mode 100644 tools/testing/selftests/cgroup/test_rdma.c

diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
index e01584c2189a..df6abf633bab 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -16,6 +16,7 @@ TEST_GEN_PROGS += test_kill
 TEST_GEN_PROGS += test_kmem
 TEST_GEN_PROGS += test_memcontrol
 TEST_GEN_PROGS += test_pids
+TEST_GEN_PROGS += test_rdma
 TEST_GEN_PROGS += test_zswap
 
 LOCAL_HDRS += $(selfdir)/clone3/clone3_selftests.h $(selfdir)/pidfd/pidfd.h
@@ -32,4 +33,12 @@ $(OUTPUT)/test_kill: $(LIBCGROUP_O)
 $(OUTPUT)/test_kmem: $(LIBCGROUP_O)
 $(OUTPUT)/test_memcontrol: $(LIBCGROUP_O)
 $(OUTPUT)/test_pids: $(LIBCGROUP_O)
+$(OUTPUT)/test_rdma: $(LIBCGROUP_O)
 $(OUTPUT)/test_zswap: $(LIBCGROUP_O)
+
+# Conditionally enable rdma.current/limit tests when libibverbs is available
+IBVERBS_AVAILABLE := $(shell pkg-config --exists libibverbs 2>/dev/null && echo y)
+ifeq ($(IBVERBS_AVAILABLE),y)
+$(OUTPUT)/test_rdma: CFLAGS += -DHAVE_LIBIBVERBS
+$(OUTPUT)/test_rdma: LDLIBS += -libverbs
+endif
diff --git a/tools/testing/selftests/cgroup/test_rdma.c b/tools/testing/selftests/cgroup/test_rdma.c
new file mode 100644
index 000000000000..5c2719ed7e62
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_rdma.c
@@ -0,0 +1,327 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <linux/limits.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include "kselftest.h"
+#include "cgroup_util.h"
+
+#ifdef HAVE_LIBIBVERBS
+#include <infiniband/verbs.h>
+
+static char *rdmacg_get_first_device(const char *cgroup)
+{
+	char buf[PAGE_SIZE];
+	char *space;
+
+	if (cg_read(cgroup, "rdma.max", buf, sizeof(buf)))
+		return NULL;
+
+	if (buf[0] == '\0')
+		return NULL;
+
+	space = strchr(buf, ' ');
+	if (!space)
+		return NULL;
+
+	return strndup(buf, space - buf);
+}
+
+static long rdmacg_get_current_value(const char *cgroup, const char *device,
+				     const char *resource)
+{
+	char buf[PAGE_SIZE];
+	char pattern[256];
+	char *p;
+
+	if (cg_read(cgroup, "rdma.current", buf, sizeof(buf)))
+		return -1;
+
+	snprintf(pattern, sizeof(pattern), "%s ", device);
+	p = strstr(buf, pattern);
+	if (!p)
+		return -1;
+
+	snprintf(pattern, sizeof(pattern), "%s=", resource);
+	p = strstr(p, pattern);
+	if (!p)
+		return -1;
+	p += strlen(pattern);
+
+	return strtol(p, NULL, 10);
+}
+
+static struct ibv_context *rdmacg_open_device(const char *device_name)
+{
+	struct ibv_device **dev_list;
+	struct ibv_context *ctx = NULL;
+	int i;
+
+	dev_list = ibv_get_device_list(NULL);
+	if (!dev_list)
+		return NULL;
+
+	for (i = 0; dev_list[i]; i++) {
+		if (!strcmp(ibv_get_device_name(dev_list[i]), device_name)) {
+			ctx = ibv_open_device(dev_list[i]);
+			break;
+		}
+	}
+	ibv_free_device_list(dev_list);
+	return ctx;
+}
+
+static int rdmacg_current_fn(const char *cgroup, void *arg)
+{
+	const char *device_name = (const char *)arg;
+	struct ibv_context *ctx = NULL;
+	struct ibv_pd *pd = NULL;
+	long val;
+	int ret = EXIT_FAILURE;
+
+	ctx = rdmacg_open_device(device_name);
+	if (!ctx)
+		return EXIT_FAILURE;
+
+	val = rdmacg_get_current_value(cgroup, device_name, "hca_handle");
+	if (val != 1) {
+		ksft_print_msg("hca_handle should be 1 after open, got %ld\n", val);
+		goto cleanup;
+	}
+	val = rdmacg_get_current_value(cgroup, device_name, "hca_object");
+	if (val != 0) {
+		ksft_print_msg("hca_object should be 0 before alloc, got %ld\n", val);
+		goto cleanup;
+	}
+
+	pd = ibv_alloc_pd(ctx);
+	if (!pd) {
+		ksft_print_msg("ibv_alloc_pd failed: %s\n", strerror(errno));
+		goto cleanup;
+	}
+	val = rdmacg_get_current_value(cgroup, device_name, "hca_object");
+	if (val != 1) {
+		ksft_print_msg("hca_object should be 1 after alloc_pd, got %ld\n", val);
+		goto cleanup;
+	}
+
+	/* After ibv_dealloc_pd: hca_object should be 0 */
+	ibv_dealloc_pd(pd);
+	pd = NULL;
+	val = rdmacg_get_current_value(cgroup, device_name, "hca_object");
+	if (val != 0) {
+		ksft_print_msg("hca_object should be 0 after dealloc_pd, got %ld\n", val);
+		goto cleanup;
+	}
+
+	/* After ibv_close_device: hca_handle should be 0 */
+	ibv_close_device(ctx);
+	ctx = NULL;
+	val = rdmacg_get_current_value(cgroup, device_name, "hca_handle");
+	if (val != 0) {
+		ksft_print_msg("hca_handle should be 0 after close, got %ld\n", val);
+		goto cleanup;
+	}
+
+	ret = EXIT_SUCCESS;
+
+cleanup:
+	if (pd)
+		ibv_dealloc_pd(pd);
+	if (ctx)
+		ibv_close_device(ctx);
+	return ret;
+}
+
+/*
+ * Test: rdma.current responds to actual IB resource allocation and deallocation.
+ */
+static int test_rdmacg_current_response(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *cg;
+	char *device = NULL;
+
+	cg = cg_name(root, "rdmacg_test_1");
+	if (!cg)
+		return KSFT_FAIL;
+
+	if (cg_create(cg))
+		goto cleanup;
+
+	device = rdmacg_get_first_device(cg);
+	if (!device) {
+		ret = KSFT_SKIP;
+		goto cleanup;
+	}
+
+	if (!cg_run(cg, rdmacg_current_fn, device))
+		ret = KSFT_PASS;
+
+cleanup:
+	free(device);
+	cg_destroy(cg);
+	free(cg);
+	return ret;
+}
+
+static int rdmacg_limit_fn(const char *cgroup, void *arg)
+{
+	const char *device_name = (const char *)arg;
+	struct ibv_context *ctx = NULL;
+	struct ibv_pd *pd1 = NULL, *pd2 = NULL;
+	int ret = EXIT_FAILURE;
+
+	ctx = rdmacg_open_device(device_name);
+	if (!ctx)
+		return EXIT_FAILURE;
+
+	/* First PD allocation should succeed (within hca_object=1 limit) */
+	pd1 = ibv_alloc_pd(ctx);
+	if (!pd1) {
+		ksft_print_msg("first ibv_alloc_pd failed: %s\n", strerror(errno));
+		goto cleanup;
+	}
+
+	/* Second PD allocation should fail (exceeds hca_object=1 limit) */
+	pd2 = ibv_alloc_pd(ctx);
+	if (pd2) {
+		ksft_print_msg("second ibv_alloc_pd should have failed\n");
+		goto cleanup;
+	}
+
+	/* Free first PD, then try again -- should succeed */
+	ibv_dealloc_pd(pd1);
+	pd1 = NULL;
+
+	pd1 = ibv_alloc_pd(ctx);
+	if (!pd1) {
+		ksft_print_msg("ibv_alloc_pd after free failed: %s\n", strerror(errno));
+		goto cleanup;
+	}
+
+	ret = EXIT_SUCCESS;
+
+cleanup:
+	if (pd1)
+		ibv_dealloc_pd(pd1);
+	if (pd2)
+		ibv_dealloc_pd(pd2);
+	if (ctx)
+		ibv_close_device(ctx);
+	return ret;
+}
+
+/*
+ * Test: rdma.max limits are enforced -- exceeding hca_object limit causes
+ * allocation failure.
+ */
+static int test_rdmacg_limit_enforcement(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *cg;
+	char *device = NULL;
+	char buf[256];
+
+	cg = cg_name(root, "rdmacg_test_2");
+	if (!cg)
+		return KSFT_FAIL;
+
+	if (cg_create(cg))
+		goto cleanup;
+
+	device = rdmacg_get_first_device(cg);
+	if (!device) {
+		ret = KSFT_SKIP;
+		goto cleanup;
+	}
+
+	snprintf(buf, sizeof(buf), "%s hca_handle=max hca_object=1", device);
+	if (cg_write(cg, "rdma.max", buf)) {
+		ksft_print_msg("failed to set hca_object=1 limit\n");
+		goto cleanup;
+	}
+
+	if (!cg_run(cg, rdmacg_limit_fn, device))
+		ret = KSFT_PASS;
+
+cleanup:
+	free(device);
+	cg_destroy(cg);
+	free(cg);
+	return ret;
+}
+
+#define T(x) { x, #x }
+struct rdmacg_test {
+	int (*fn)(const char *root);
+	const char *name;
+} tests[] = {
+	T(test_rdmacg_current_response),
+	T(test_rdmacg_limit_enforcement),
+};
+#undef T
+
+int main(int argc, char **argv)
+{
+	char root[PATH_MAX];
+	char orig_subtree[PAGE_SIZE] = {0};
+	bool rdma_was_enabled = false;
+
+	ksft_print_header();
+	ksft_set_plan(ARRAY_SIZE(tests));
+
+	if (cg_find_unified_root(root, sizeof(root), NULL))
+		ksft_exit_skip("cgroup v2 isn't mounted\n");
+
+	if (cg_read_strstr(root, "cgroup.controllers", "rdma"))
+		ksft_exit_skip("rdma controller isn't available\n");
+
+	/* Save original subtree_control so we can restore it later */
+	if (cg_read(root, "cgroup.subtree_control", orig_subtree,
+		    sizeof(orig_subtree)))
+		orig_subtree[0] = '\0';
+
+	rdma_was_enabled = (strstr(orig_subtree, "rdma") != NULL);
+
+	/* Enable rdma controller if not already enabled */
+	if (!rdma_was_enabled) {
+		if (cg_write(root, "cgroup.subtree_control", "+rdma"))
+			ksft_exit_skip("Failed to enable rdma controller\n");
+	}
+
+	for (int i = 0; i < ARRAY_SIZE(tests); i++) {
+		switch (tests[i].fn(root)) {
+		case KSFT_PASS:
+			ksft_test_result_pass("%s\n", tests[i].name);
+			break;
+		case KSFT_SKIP:
+			ksft_test_result_skip("%s\n", tests[i].name);
+			break;
+		default:
+			ksft_test_result_fail("%s\n", tests[i].name);
+			break;
+		}
+	}
+
+	/* Restore original subtree_control state */
+	if (!rdma_was_enabled)
+		cg_write(root, "cgroup.subtree_control", "-rdma");
+
+	ksft_finished();
+}
+
+#else /* !HAVE_LIBIBVERBS */
+
+int main(int argc, char **argv)
+{
+	ksft_print_header();
+	ksft_exit_skip("test requires libibverbs\n");
+}
+
+#endif /* HAVE_LIBIBVERBS */
-- 
2.43.0


