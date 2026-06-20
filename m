Return-Path: <cgroups+bounces-17096-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3K8hF6nZNmpHFgcAu9opvQ
	(envelope-from <cgroups+bounces-17096-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 20 Jun 2026 20:19:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA926A976D
	for <lists+cgroups@lfdr.de>; Sat, 20 Jun 2026 20:19:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XivMFJ7S;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17096-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17096-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4EC73041A3D
	for <lists+cgroups@lfdr.de>; Sat, 20 Jun 2026 18:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7E0237180;
	Sat, 20 Jun 2026 18:17:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67163438A6
	for <cgroups@vger.kernel.org>; Sat, 20 Jun 2026 18:17:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781979443; cv=none; b=ExM3OLZBcNlq1AZOsMzIh25JSvXk1yFBRpIfds1SV8BaXDAQu/DzA644FibUu2t+VMzRpY82sUzdGtXXMu9qsAuc3mpwMhG24WvuPEAmwwO7N004UNfkKiwBzzTkKItkc2o35ivY7pZokzAK0I725K9Mgn8DgUL9ixMIzsxAP+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781979443; c=relaxed/simple;
	bh=qBJUy0V7WEPdRQARhiTv8C7JgaiMP82scW2vnf9sc74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GesF5aYNHO8z+HGDNJvMDK/0L+yEioeAmh0lV7NQTUfFSrxh/7eonfT9gisHg+rJxO6U6hKSMce/jCw69Hl2rpbkFof19WwIOZJ9BL2SkNcr6Lp5H8GWczUQFgMAKzLw6qmVYWyuTgOPi7+b+YrBWyKFJ5Mdo3pCoCRhHwWi38Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XivMFJ7S; arc=none smtp.client-ip=209.85.215.181
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c89370405aaso1390803a12.0
        for <cgroups@vger.kernel.org>; Sat, 20 Jun 2026 11:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781979441; x=1782584241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tG1goLxilAMOHGDfAUrbCLR/sxZCH1YlTcgqW/QVggE=;
        b=XivMFJ7SOE708BUOU4w6L1ZUzqSrbOrIKtoX/Lc7b4v0ALv0RunpiYWf7FbWmC++Au
         ZaZgBd/vJ8ibrSfMFmvJXsyQqXIQTiZ2xEEvBZzHSQY4oq1+h/5TnB9TF87SuK05eNpR
         VuPiUfC3sGhgcwJ7DdD1acyAs8UnMzlBhW6wCbMSjnBbTOohDwxOh4tE+7fqX8skI7Dj
         yA6GVQBRqWI+ChoeY0DnqmADd45R+E2UUnu7EMmIEkOgKSXS7a8ZHzzVSwo4AglrTQ4N
         EbhKx1wHHsdlPiUY3mBjrXybH0MR1bW7MJwQez4hOYWhWUPWu/fHKb4kqjzJQQiSXByA
         eWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781979441; x=1782584241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tG1goLxilAMOHGDfAUrbCLR/sxZCH1YlTcgqW/QVggE=;
        b=fnYSxe4ichEOx5fmGegJj1/DSulo5MV++y1GCB/1V29rcmwvGZLLMmHDAUSH6zwDZf
         fkbSIQw9b1gSbX/hQ7KeqSm/pyn7cARHrKwr2D8Z0Xe4gM0MrqgYpkQyyEbuGSG0HsMi
         rmuZxl2e0mqQszzVroPc/GHw+cYbmuqvWcBKqFzs8qSKjJIdZvM28Zwfabj6oyewl69/
         hzTE19zLsoZnmGDRtT4mlYFsjQMQmTLZS+tyJl3LAkQqBdx/HYOCwY7tL1fyIxZpmVMh
         71MrcLlgP5TaePolY67fjc20yJRVaMBoPzLCeUVAwSsmpG5bHdTyZpo/V3bEtGwvGVS8
         M14A==
X-Forwarded-Encrypted: i=1; AHgh+Rrk6q96QlgeGIy69vCrjwVUBM7MjpnxLGC2NWWc0tMlBQU1TE57JA2y6MzETLvgQD/E5sRfINtG@vger.kernel.org
X-Gm-Message-State: AOJu0YxzFZMkUheXMhlrlZOmK9RNujVejCO10uY+b+v1+Y0PLI7tXyNw
	NjfOvEbx5saPqohkCZcMTwvSKaoIIBTvnArBXs6gM7oEz7BFkFMR+NTL
X-Gm-Gg: AfdE7cl+3n16LkplTBqngWBuXZGfa7/K1+KPMSuEt1p5k22+hji2teBmtyixXoOTTdZ
	j5bZ5IjZnyiDiTSTQ10N6i9IHtRkJAZ00ufpCEZRmZVAt6EauRs9NruU7Dxt24fpslCVOoX5uWl
	oVkrtSjSTccs0DgqIBtYhvRXZmotL8BMKA9+8hGbU654CG6bTsDxvuYNPMP4EE62ASuqOlMbhf/
	pqHbeaIzFhWYWyxeXsosm+b6mDaPBqh1908//zipdUd58SzT8PqYamzYHDhBe320GGZajHI21XK
	qsXtx2q2ncB7seM9+S/6hTuM9vkxbFPFc9plPoASo4u9njtZShJuX9MxBDzAkHDcrPEwsRsoVJO
	7PNs7B7htDifqINh4CxuCeeMwEkxxn7oy0Ox3BmfwKBtCXVvcQrFLTTmcsoJsx3Zd2+Zo5qqvh9
	isSo52c5yeqifDbJqkbNrsTpTFLGCH8juky5Q9+TEDyRrxAg5XKxto7SumfvV5ChUm8yJgamESa
	GXbsgMKjvIw
X-Received: by 2002:a17:902:e805:b0:2b2:4b4e:e4d2 with SMTP id d9443c01a7336-2c725b96249mr73239185ad.15.1781979440730;
        Sat, 20 Jun 2026 11:17:20 -0700 (PDT)
Received: from localhost.localdomain ([220.85.166.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436af6d9sm30339465ad.4.2026.06.20.11.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 11:17:20 -0700 (PDT)
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
Subject: [PATCH v9 6/6] selftests/cgroup: add a swap tier routing test
Date: Sun, 21 Jun 2026 03:16:31 +0900
Message-ID: <20260620181635.299364-7-youngjun.park@lge.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:youngjun.park@lge.com,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:yosry@kernel.org,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:mkoutny@suse.com,m:baver.bae@lge.com,m:matia.kim@lge.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17096-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lge.com:mid,lge.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AAA926A976D

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
 .../selftests/cgroup/test_swap_tiers.c        | 500 ++++++++++++++++++
 4 files changed, 505 insertions(+)
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
index 000000000000..24420c1ef398
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_swap_tiers.c
@@ -0,0 +1,500 @@
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
+	if (fgets(line, sizeof(line), f))		/* header */
+		while (fgets(line, sizeof(line), f))
+			n++;
+	fclose(f);
+	return n;
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
+/* A new cgroup may use every tier ("max"). */
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
+/* A tier can be disabled and re-enabled, and the change reads back. */
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
+/* An unknown tier name or a bad value must be rejected. */
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
+/* A tier recreated by the same name is allowed again, even if disabled before. */
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
+/* Map anon memory, fault it in, push it to swap, then wait to be killed. */
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
+	zslow = zram_add(MB(128));
+	if (zfast < 0 || zslow < 0)
+		goto out;
+	snprintf(fast_dev, sizeof(fast_dev), "/dev/zram%d", zfast);
+	snprintf(slow_dev, sizeof(slow_dev), "/dev/zram%d", zslow);
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
+	for (i = 0; i < 50; i++) {		/* up to ~5s for pageout */
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
+/*
+ * A cgroup that disabled the high-priority 'fast' tier must swap only to the
+ * 'slow' tier's device; the fast device must stay untouched.
+ */
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
+/* Create @name under @root and delegate the memory controller to its children. */
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
+/*
+ * The effective mask is the parent's intersected with the child's, so a tier
+ * the parent disabled stays disabled for the child even if the child re-enables
+ * it.  Parent disables 'fast', child sets 'fast max' -> child still swaps slow.
+ */
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
+/*
+ * A child can restrict below its parent: the parent leaves all tiers enabled,
+ * the child disables 'fast' on its own -> the child swaps only to slow.
+ */
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
2.48.1


