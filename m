Return-Path: <cgroups+bounces-15561-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MM2KLHsX82llxAEAu9opvQ
	(envelope-from <cgroups+bounces-15561-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2026 10:48:59 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CF549F68A
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2026 10:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB0D63014C0C
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2026 08:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BB43FE648;
	Thu, 30 Apr 2026 08:43:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C69C2F90E0
	for <cgroups@vger.kernel.org>; Thu, 30 Apr 2026 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777538634; cv=none; b=qgRSRIYOkAWVc6mP+pXuDvu3L2e7ETfsjfblF00cOjCKsuI1l7raXRO7MW3+gQcNMbVEpnicxonvu27swfkXzvO2GBCH8gS2H/NHxKxlwSyUaN8ppuD0AY7LNdI6mk77lvgyenJS3pvFV2JpDefzjZjvVcHFo332AoKAlR9wPmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777538634; c=relaxed/simple;
	bh=/XUzfbxKWvuz/3XMlXiHF+dvaJrniukA/B8YVL6qtz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ph8FUM+JAl2fpS5pKDMqoqDYV0cz5wjyPxnoJHQ9+BVVe/0hkDpSu/aDVaJrD7QNHNRD/f7tjrygCdXp8L0hA2shBmYZFONw4GA8RFMZYQUrRo7un28/7kj3EB1CJtik3MrwwtAnr1MFKMP3iS2YEQIL6cRifrMsnFHZi2jZz/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: af91fdaa447011f1aa26b74ffac11d73-20260430
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:b19a00ba-4e94-4374-8b4a-81566a07d8e5,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:b19a00ba-4e94-4374-8b4a-81566a07d8e5,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:0b0b7a5368f53fe17d0db0e17b28683b,BulkI
	D:260430164341F5N1Q85N,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: af91fdaa447011f1aa26b74ffac11d73-20260430
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 535261404; Thu, 30 Apr 2026 16:43:39 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org
Cc: Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH] selftests: cgroup: Add basic tests for rdma controller
Date: Thu, 30 Apr 2026 16:43:10 +0800
Message-ID: <20260430084310.80662-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 11CF549F68A
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
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-15561-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,cgroups@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.551];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This commit adds (and wires in) new test program for checking basic rdma
controller functionality -- rdma.max file interface, writing invalid
values, device specific limits, and parent-child hierarchy.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 tools/testing/selftests/cgroup/Makefile    |   2 +
 tools/testing/selftests/cgroup/test_rdma.c | 371 +++++++++++++++++++++
 2 files changed, 373 insertions(+)
 create mode 100644 tools/testing/selftests/cgroup/test_rdma.c

diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
index e01584c2189a..b8ef370eaa9d 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -16,6 +16,7 @@ TEST_GEN_PROGS += test_kill
 TEST_GEN_PROGS += test_kmem
 TEST_GEN_PROGS += test_memcontrol
 TEST_GEN_PROGS += test_pids
+TEST_GEN_PROGS += test_rdma
 TEST_GEN_PROGS += test_zswap
 
 LOCAL_HDRS += $(selfdir)/clone3/clone3_selftests.h $(selfdir)/pidfd/pidfd.h
@@ -32,4 +33,5 @@ $(OUTPUT)/test_kill: $(LIBCGROUP_O)
 $(OUTPUT)/test_kmem: $(LIBCGROUP_O)
 $(OUTPUT)/test_memcontrol: $(LIBCGROUP_O)
 $(OUTPUT)/test_pids: $(LIBCGROUP_O)
+$(OUTPUT)/test_rdma: $(LIBCGROUP_O)
 $(OUTPUT)/test_zswap: $(LIBCGROUP_O)
diff --git a/tools/testing/selftests/cgroup/test_rdma.c b/tools/testing/selftests/cgroup/test_rdma.c
new file mode 100644
index 000000000000..e204d21bb562
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_rdma.c
@@ -0,0 +1,371 @@
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
+static int rdmacg_read_max(const char *cgroup, char *buf, size_t len)
+{
+	return cg_read(cgroup, "rdma.max", buf, len);
+}
+
+static int rdmacg_write_max(const char *cgroup, const char *value)
+{
+	char *dup = strdup(value);
+	int ret;
+
+	if (!dup)
+		return -1;
+	ret = cg_write(cgroup, "rdma.max", dup);
+	free(dup);
+	return ret;
+}
+
+static char *rdmacg_get_first_device(const char *cgroup)
+{
+	char buf[PAGE_SIZE];
+	char *space;
+
+	if (rdmacg_read_max(cgroup, buf, sizeof(buf)))
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
+/*
+ * Check that a specific resource value for a device in rdma.max matches
+ * the expected string. Returns 0 on match, -1 otherwise.
+ */
+static int rdmacg_check_value(const char *cgroup, const char *device,
+			      const char *resource, const char *expected)
+{
+	char buf[PAGE_SIZE];
+	char pattern[256];
+	char *p;
+	size_t elen;
+
+	if (rdmacg_read_max(cgroup, buf, sizeof(buf)))
+		return -1;
+
+	/* Find device line */
+	snprintf(pattern, sizeof(pattern), "%s ", device);
+	p = strstr(buf, pattern);
+	if (!p)
+		return -1;
+
+	/* Find resource= within this line */
+	snprintf(pattern, sizeof(pattern), "%s=", resource);
+	p = strstr(p, pattern);
+	if (!p)
+		return -1;
+	p += strlen(pattern);
+
+	elen = strlen(expected);
+	if (strncmp(p, expected, elen))
+		return -1;
+
+	if (p[elen] != ' ' && p[elen] != '\n' && p[elen] != '\0')
+		return -1;
+
+	return 0;
+}
+
+/*
+ * Test: rdma.max file exists and is readable on child cgroup.
+ */
+static int test_rdmacg_max_read(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *cg;
+	char buf[PAGE_SIZE];
+
+	cg = cg_name(root, "rdmacg_test_1");
+	if (!cg)
+		return KSFT_FAIL;
+
+	if (cg_create(cg))
+		goto cleanup;
+
+	/* rdma.max should be readable on non-root cgroup */
+	if (rdmacg_read_max(cg, buf, sizeof(buf)))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	cg_destroy(cg);
+	free(cg);
+	return ret;
+}
+
+/*
+ * Test: Writing a non-existent device name to rdma.max should fail.
+ * The kernel returns -ENOENT when the device is not registered.
+ */
+static int test_rdmacg_max_write_nonexistent(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *cg;
+
+	cg = cg_name(root, "rdmacg_test_2");
+	if (!cg)
+		return KSFT_FAIL;
+
+	if (cg_create(cg))
+		goto cleanup;
+
+	/* Write with a device that does not exist */
+	if (rdmacg_write_max(cg, "fake_device_xyz hca_handle=10") == 0)
+		goto cleanup;
+
+	/* File should still be readable */
+	char buf[PAGE_SIZE];
+	if (rdmacg_read_max(cg, buf, sizeof(buf)))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	cg_destroy(cg);
+	free(cg);
+	return ret;
+}
+
+/*
+ * Test: Writing invalid format to rdma.max should fail.
+ */
+static int test_rdmacg_max_write_invalid(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *cg;
+
+	cg = cg_name(root, "rdmacg_test_3");
+	if (!cg)
+		return KSFT_FAIL;
+
+	if (cg_create(cg))
+		goto cleanup;
+
+	/* Bare number -- not a valid device entry */
+	if (rdmacg_write_max(cg, "42") == 0)
+		goto cleanup;
+
+	/* Missing value after '=' */
+	if (rdmacg_write_max(cg, "fake_dev hca_handle=") == 0)
+		goto cleanup;
+
+	/* Negative value */
+	if (rdmacg_write_max(cg, "fake_dev hca_handle=-1") == 0)
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	cg_destroy(cg);
+	free(cg);
+	return ret;
+}
+
+/*
+ * Test: Set and read back limits when an RDMA device is present.
+ * Skipped if no RDMA device is registered.
+ */
+static int test_rdmacg_max_device_limits(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *cg;
+	char *device = NULL;
+	char buf[256];
+
+	cg = cg_name(root, "rdmacg_test_4");
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
+	snprintf(buf, sizeof(buf), "%s hca_handle=5 hca_object=100", device);
+	if (rdmacg_write_max(cg, buf))
+		goto cleanup;
+
+	if (rdmacg_check_value(cg, device, "hca_handle", "5"))
+		goto cleanup;
+	if (rdmacg_check_value(cg, device, "hca_object", "100"))
+		goto cleanup;
+
+	snprintf(buf, sizeof(buf), "%s hca_handle=20", device);
+	if (rdmacg_write_max(cg, buf))
+		goto cleanup;
+
+	if (rdmacg_check_value(cg, device, "hca_handle", "20"))
+		goto cleanup;
+	if (rdmacg_check_value(cg, device, "hca_object", "100"))
+		goto cleanup;
+
+	snprintf(buf, sizeof(buf), "%s hca_handle=max hca_object=max", device);
+	if (rdmacg_write_max(cg, buf))
+		goto cleanup;
+
+	if (rdmacg_check_value(cg, device, "hca_handle", "max"))
+		goto cleanup;
+	if (rdmacg_check_value(cg, device, "hca_object", "max"))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	free(device);
+	cg_destroy(cg);
+	free(cg);
+	return ret;
+}
+
+/*
+ * Test: Hierarchy -- parent limits and child limits are independent.
+ * The child defaults to "max"; parent limits constrain at charge time.
+ */
+static int test_rdmacg_max_hierarchy(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *cg_parent = NULL, *cg_child = NULL;
+	char *device = NULL;
+	char buf[256];
+
+	cg_parent = cg_name(root, "rdmacg_parent");
+	cg_child = cg_name(cg_parent, "rdmacg_child");
+	if (!cg_parent || !cg_child)
+		goto cleanup;
+
+	if (cg_create(cg_parent))
+		goto cleanup;
+
+	if (cg_write(cg_parent, "cgroup.subtree_control", "+rdma"))
+		goto cleanup;
+
+	if (cg_create(cg_child))
+		goto cleanup;
+
+	device = rdmacg_get_first_device(cg_child);
+	if (!device) {
+		ret = KSFT_SKIP;
+		goto cleanup;
+	}
+
+	snprintf(buf, sizeof(buf), "%s hca_handle=10 hca_object=200", device);
+	if (rdmacg_write_max(cg_parent, buf))
+		goto cleanup;
+
+	if (rdmacg_check_value(cg_parent, device, "hca_handle", "10"))
+		goto cleanup;
+
+	if (rdmacg_check_value(cg_child, device, "hca_handle", "max"))
+		goto cleanup;
+
+	snprintf(buf, sizeof(buf), "%s hca_handle=3 hca_object=50", device);
+	if (rdmacg_write_max(cg_child, buf))
+		goto cleanup;
+
+	if (rdmacg_check_value(cg_child, device, "hca_handle", "3"))
+		goto cleanup;
+	if (rdmacg_check_value(cg_child, device, "hca_object", "50"))
+		goto cleanup;
+
+	if (rdmacg_check_value(cg_parent, device, "hca_handle", "10"))
+		goto cleanup;
+	if (rdmacg_check_value(cg_parent, device, "hca_object", "200"))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	free(device);
+	if (cg_child)
+		cg_destroy(cg_child);
+	if (cg_parent)
+		cg_destroy(cg_parent);
+	free(cg_child);
+	free(cg_parent);
+	return ret;
+}
+
+#define T(x) { x, #x }
+struct rdmacg_test {
+	int (*fn)(const char *root);
+	const char *name;
+} tests[] = {
+	T(test_rdmacg_max_read),
+	T(test_rdmacg_max_write_nonexistent),
+	T(test_rdmacg_max_write_invalid),
+	T(test_rdmacg_max_device_limits),
+	T(test_rdmacg_max_hierarchy),
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
-- 
2.43.0


