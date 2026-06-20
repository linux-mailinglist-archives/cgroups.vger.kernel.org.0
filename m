Return-Path: <cgroups+bounces-17095-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2GUYKjPZNmo2FgcAu9opvQ
	(envelope-from <cgroups+bounces-17095-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 20 Jun 2026 20:17:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D23B6A9750
	for <lists+cgroups@lfdr.de>; Sat, 20 Jun 2026 20:17:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="AOTF/UVk";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17095-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17095-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BAF183004C98
	for <lists+cgroups@lfdr.de>; Sat, 20 Jun 2026 18:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DAA349CD9;
	Sat, 20 Jun 2026 18:17:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0F530F7F7
	for <cgroups@vger.kernel.org>; Sat, 20 Jun 2026 18:17:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781979437; cv=none; b=uEuy9s4mmQhbwq/E2Jr/l80lKuT+CrXktqRX3B4loR8WoD0FKXbfmaernmwioukJO2lR3ixp9UN1tDHafDBKgLQrTqCuMLS43LJL98QOEHE2XrQbyBKqnGRruS78581Kd2wXas0iwAQWeN10ONua7rLFhc0wXuoaIarB+67IEPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781979437; c=relaxed/simple;
	bh=S5sYyvW9QyY6clCsvttkMWXxewus1Gyh5/QzlK0Cpuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDWJl4ZHSc43ibuKSMSmGfY+i7WOihUb3WL3ZMe7TotFEYqMwzgACtJ7fNvlwck7iibXAx3Yep+dxO3esZ7H+0hu7huIwjX3L0syzsqtdp4V1DQLsRw36ZqcuGZeSW86rMMKJQvO9mJdo4XZDHVcN6XLVPJrghVU4UhUzw1OaXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOTF/UVk; arc=none smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c74383c93cso8512165ad.1
        for <cgroups@vger.kernel.org>; Sat, 20 Jun 2026 11:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781979435; x=1782584235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgH4Dj17obnxSLq/3NpwgVl7Hll2I/0OEirSKJI2pMo=;
        b=AOTF/UVkJymF10Vt4pjUsPBw/z9L/WN6j+D6VqpHpWVTLD8kWJ6e9WoR5ZP2vCbKIB
         J6/4X1BRDoC1lJg2sPHIhF+YY5UhC7fT9dbCWd9xKhySq4S3kuh4mH84kmPEGLBEQi3L
         A/vfB6cvJkb2eppyiPqqPcW9Pnw8PSQK7ic6+f0RHUnN3jB4Y7hNa2qqpP1TiteOx/JD
         xMtAqWngnHA9AdQksIgSA3sdaMNn2qmeIyCvZgAMx27BesSOT1//UqDznWBhvBvkoA7V
         ShVYYPqzoUWACOjNs3DmtsQhRRapIFedAVnd3timextaM4YDh/T6pDNFZ6oB/7uJ168Y
         znVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781979435; x=1782584235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RgH4Dj17obnxSLq/3NpwgVl7Hll2I/0OEirSKJI2pMo=;
        b=E/Ip56Jv/JxCVzfrl0QDf10HV0APP7qhczeyyp3P+hqvXN4lmfhoA4LhAu8j3JPFH+
         +MXfCHMDQVkwvjZcpIbOz2W+ElI0dfh1MsX2PqsEnFGUhX/kVFKzv3TQSsvxfOf6URXQ
         yl7HFnTj+dMhg3yQhGPuKN1JXiLZvJfGTFLBquoUWCDig3/qVLSlH8Q9RktDNvn/2AQ4
         F+kGfjmU8AdDTg9JTXH/MeoDx3KWos+0PemmrqLVXjrJaUCpBfsXdDpyPR4kSkpMim8I
         bgCL5vd1BX1zGG3QU2QSjtna8q2VyyU4m0nPGVvzb18czfzZzdanM2C+7kxf4OB1HImY
         DJlg==
X-Forwarded-Encrypted: i=1; AHgh+RrJpzPbf5feFOnoGhD+FqpnhVMuVc95AkUP4/SxvJQI2zyxPHd1GOtvgJ3mbj8As2UQXyyRCapF@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu6xRAsAzm3My4xG2Rz6AnaS9F6ZYiR0TrETlh8/qEdzq49azA
	WjnQ9U2IDn0MdIkKzI5/un4G4w+qv++IWxPemPTSR/3XZhy3ZYuAM+Uq
X-Gm-Gg: AfdE7cmBg7ZsboHtSY+GT4VvTba5ZBnvrrW6Yet+s/TkNGw5Ghvb5R2u4spvo4DCeQb
	fsmg2MYqABZfExL0ar7z4jkMgJdmmAUosFFUbuaV1UirstmNfrtFjSDVUEJbimsv6b6v1HYmwsi
	Q1m9d23Jh5re/7FAc+uJkpsrzurf++zztc7Nxef2G3DxZgT/MbUPqhxtdYZevQbJErESqX3HIcr
	JVZEvThn/4lnWgU9vSuwQjiCTUh8aQIt+Dilt7QUewqWEHJe1miHcRvkZG0apjcbUSvG+RpNE02
	InqP3wzVaZEN8UvRkZH17ssnjUhrPoD2wGDbXqkh83nb5Xale4MzUCIo1RVjfWKkxTyFdVLrjFA
	4lhZUAe8NDBFvb3QV9Z+aAPXs1P+60fjqxZPMYuq5lvdvCAOQqblwpBCuoMrP1NrJ9aCxAbGA7R
	mO5sdWk4BDVd3vFoZfmB/PhhC2Ef++Y/OXyaPIxFpV3M98I5qG6ElMavCMMJbwh5Ie7YRnKKKEG
	w==
X-Received: by 2002:a17:902:cf03:b0:2c1:f262:4962 with SMTP id d9443c01a7336-2c718f03795mr93845965ad.20.1781979435385;
        Sat, 20 Jun 2026 11:17:15 -0700 (PDT)
Received: from localhost.localdomain ([220.85.166.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436af6d9sm30339465ad.4.2026.06.20.11.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 11:17:14 -0700 (PDT)
From: Youngjun Park <her0gyugyu@gmail.com>
X-Google-Original-From: Youngjun Park <youngjun.park@lge.com>
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
	nphamcs@gmail.com,
	baoquan.he@linux.dev,
	baohua@kernel.org,
	yosry@kernel.org,
	gunho.lee@lge.com,
	taejoon.song@lge.com,
	hyungjun.cho@lge.com,
	mkoutny@suse.com,
	baver.bae@lge.com,
	matia.kim@lge.com
Subject: [PATCH v9 5/6] selftests/mm: add a swap tier configuration test
Date: Sun, 21 Jun 2026 03:16:30 +0900
Message-ID: <20260620181635.299364-6-youngjun.park@lge.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260620181635.299364-1-youngjun.park@lge.com>
References: <20260620181635.299364-1-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:youngjun.park@lge.com,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:yosry@kernel.org,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:mkoutny@suse.com,m:baver.bae@lge.com,m:matia.kim@lge.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17095-lists,cgroups=lfdr.de];
	FORGED_SENDER(0.00)[her0gyugyu@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[kernel.org,lge.com,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,suse.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[her0gyugyu@gmail.com,cgroups@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,lge.com:mid,lge.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D23B6A9750

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
 tools/testing/selftests/mm/swap_tier.c    | 323 ++++++++++++++++++++++
 5 files changed, 332 insertions(+)
 create mode 100644 tools/testing/selftests/mm/swap_tier.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 9ccd9e1447e6..a6e588c7979e 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -46,6 +46,7 @@ hmm-tests
 memfd_secret
 soft-dirty
 split_huge_page_test
+swap_tier
 ksm_tests
 local_config.h
 local_config.mk
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index e6df968f0971..1836127df092 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -105,6 +105,7 @@ TEST_GEN_FILES += guard-regions
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
index 8c296dedf047..1b0b8ec185a9 100755
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
@@ -353,6 +355,9 @@ CATEGORY="process_madv" run_test ./process_madv
 
 CATEGORY="vma_merge" run_test ./merge
 
+# swap tier configuration interface (/sys/kernel/mm/swap/tiers)
+CATEGORY="swap_tier" run_test ./swap_tier
+
 if [ -x ./memfd_secret ]
 then
 if [ -f /proc/sys/kernel/yama/ptrace_scope ]; then
diff --git a/tools/testing/selftests/mm/swap_tier.c b/tools/testing/selftests/mm/swap_tier.c
new file mode 100644
index 000000000000..b4fe21b0eb5d
--- /dev/null
+++ b/tools/testing/selftests/mm/swap_tier.c
@@ -0,0 +1,323 @@
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
+		/* The header line has no integer columns, so sscanf skips it. */
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
+/*
+ * A single add at a priority above -1, from the empty set, leaves the range
+ * below it uncovered and must be rejected. the set stays empty.
+ */
+static int test_coverage(void)
+{
+	if (tiers_write("+orphan:100") != -EINVAL)
+		return KSFT_FAIL;
+	if (tier_exists("orphan"))
+		return KSFT_FAIL;
+	return KSFT_PASS;
+}
+
+/*
+ * Add two tiers covering the full range. The end priority of a tier is the
+ * start of the next higher tier minus one.
+ */
+static int test_add(void)
+{
+	if (tiers_write("+lo:-1 +hi:50"))
+		return KSFT_FAIL;
+	if (!range_is("hi", 50, SHRT_MAX) || !range_is("lo", -1, 49))
+		return KSFT_FAIL;
+	return KSFT_PASS;
+}
+
+/* Adding a tier inside an existing range splits it. the lower part shrinks. */
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
+/* Removing a tier merges its range into the adjacent (lower) tier. */
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
+/* Each invalid operation must fail with its documented errno. State: hi[-1,MAX]. */
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
+ * whole batch is rolled back. The second '+a' duplicates the first and fails,
+ * so neither must take effect. State before/after: hi[-1,MAX].
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
+	if (fd < 0)
+		return -1;
+	snprintf(val, sizeof(val), "%ld", size);
+	n = write(fd, val, strlen(val));
+	close(fd);
+	return n < 0 ? -1 : idx;
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
+	if (write(fd, val, strlen(val)) < 0)
+		; /* ignore: best-effort cleanup */
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
+/* A tier holding an active swap device can't be removed until swapoff. */
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
+/* Remove all remaining tiers, so a mid-test failure still leaves them empty. */
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
2.48.1


