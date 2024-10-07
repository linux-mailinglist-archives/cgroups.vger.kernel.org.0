Return-Path: <cgroups+bounces-5048-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03641993126
	for <lists+cgroups@lfdr.de>; Mon,  7 Oct 2024 17:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DCB51F23887
	for <lists+cgroups@lfdr.de>; Mon,  7 Oct 2024 15:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B99D1DA2EB;
	Mon,  7 Oct 2024 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h27J5lBF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2211DA0F1;
	Mon,  7 Oct 2024 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314936; cv=none; b=qEu/+Sv2wGpMYv3XKtfPFN3I4itfIuClbM6SQZNy5NBChn6NWjwNE8ahI9X71camaK1dfh+3Qbg99mS/k8r2sqiEC4Lk4btahti4keRku10xuKRvFsbZDJOTlQ7EUBuC8XljwF4Atdlc/OF2wfRaDmozJjJLLRby3KEgKFn8FPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314936; c=relaxed/simple;
	bh=56mTJe+siYhvNNQ3zivndYFHjNda7FgDUh+1vF7qwmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=umL2BEFIwpGZ5HtWNY+BrcdOVsasmDncrqzBw+Ejh/9NSdhzBiDc1DOtKjUoCu0TV/uFvrQGiYZRH0Fngx3FS+fROzMqwxK0b3VVL9tRYqPYtGUDNsXS7aip6/3uy+LzDGcS+PDKOLCelfM4p68rGWJILC9Unkl+I3bxBa/Tw8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h27J5lBF; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a27599274eso11781435ab.0;
        Mon, 07 Oct 2024 08:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728314934; x=1728919734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfeDMwa0mGsEZvqgK4VshjmFCBwUkEJGgi7ASvgAtCo=;
        b=h27J5lBFAD150rhqurqk75I+ii38YEgsHd2Nq6nT2KAiTtLjQPndeGEMI5dX052Lu8
         x1IcINE3ffDVBbtFZ2lI+y15YWYCezR1bkg2/y5i4o50ImF/lyNqrX76C4tkifNvgmwq
         yaMkwSymkPOsHhfLEe/6WZXA/ddAqmowWDMrTKEAfy+i4CeACJPMYU46wv2QadPK/YaY
         c3KEDrdNn7+rJj3Rd2e6TafwOZ5ijuDZ+JT7XPYUiun+o7tihnV9fpADsPGFkGQwkLa8
         83wnGMvkgFh+1fvSBSWNjyOcArWAytGmMKclegB9vj0DmJHfZQohQoFOMpV/wj3muaIy
         AozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728314934; x=1728919734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfeDMwa0mGsEZvqgK4VshjmFCBwUkEJGgi7ASvgAtCo=;
        b=IAx2L1FaOQ4CwjhympZRTf5wWva6ZJRw1S3ZWq7kXOqaNkVkupl0syOOoRu0zl+Xnc
         QOYS5g1Pz+jfDxszZfsk0kMEZxQ5oDW6xkK4f8s971wh/9SS8tTTD4DA4uxV/kNX5oJl
         b0xyY6BH4jV669KYJZTFKJArSKhptdVRodnYnJEgHV7R3fzJQR5NYa9xwzgfoD5AOQiB
         43kM0W2HvvF5aMxS51i0hgJ3O+/Ghd0VJs335uDBObbT7o0mHn28eBoJK1B0h4m/57Hl
         G08nYSVSI/hGrY5Cb76PIhqSYyh+6algQ5l3OUsdtrGEkehCjfjp7CKY1coY1NAd1fQq
         C07Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfcqbJau0v5tMM3bQ4djmg0eewIWbrGTg1hvOaDTz6blx3G4r8K5F+wjIUxeWhPeslJsjcpC5x@vger.kernel.org, AJvYcCUh8GJEOwV8Dh/FWjgcFAsz24+nYHEE6BznkFIVUom7spgr7zwFt5vEVCoG3MZ9Sr7U+2QRIS+ViJo8nbK/@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeu7NgyCVSO+ZpOPOsUcmuRufcsoqFqNXktwVakEFlwkPEvSmu
	Qc70p1lGqXF1Nwhd+HOJj60ZZjhJKIxnFO/GvIyNuUzmNIDev9J9
X-Google-Smtp-Source: AGHT+IGwFQ5Mj6pyuFxLgLgdveH2IKrWbSgcvPNfIHFse5w32d4E01+pki6CGjW6TeuhbjXz6yJ/JQ==
X-Received: by 2002:a05:6e02:184c:b0:3a0:378a:884b with SMTP id e9e14a558f8ab-3a37597a23dmr104389405ab.3.1728314934238;
        Mon, 07 Oct 2024 08:28:54 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c4adeasm4360337a12.84.2024.10.07.08.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:28:53 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: xavier_qy@163.com,
	longman@redhat.com,
	lizefan.x@bytedance.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	akpm@linux-foundation.org
Cc: jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 3/6] lib: Add KUnit tests for union-find implementation
Date: Mon,  7 Oct 2024 23:28:30 +0800
Message-Id: <20241007152833.2282199-4-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007152833.2282199-1-visitorckw@gmail.com>
References: <20241007152833.2282199-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a KUnit test suite for the union-find data structure. The
tests verify the functionality and correctness of the union and find
operations, including edge cases such as handling duplicate unions.
The addition of KUnit tests enhances the robustness of the union-find
implementation by ensuring its correctness under various scenarios.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 MAINTAINERS            |  1 +
 lib/Kconfig.debug      | 12 +++++++
 lib/Makefile           |  1 +
 lib/union_find_kunit.c | 74 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+)
 create mode 100644 lib/union_find_kunit.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a097afd76ded..e503802c1549 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23801,6 +23801,7 @@ F:	Documentation/core-api/union_find.rst
 F:	Documentation/translations/zh_CN/core-api/union_find.rst
 F:	include/linux/union_find.h
 F:	lib/union_find.c
+F:	lib/union_find_kunit.c
 
 UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER
 R:	Alim Akhtar <alim.akhtar@samsung.com>
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7315f643817a..f8c09dd0590b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2841,6 +2841,18 @@ config SIPHASH_KUNIT_TEST
 	  This is intended to help people writing architecture-specific
 	  optimized versions.  If unsure, say N.
 
+config UNION_FIND_KUNIT_TEST
+	tristate "KUnit Test for Union find"
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This option enables the KUnit tests for the union-find data structure.
+	  These tests verify the functionality and correctness of the union-find
+	  implementation, including union and find operations, as well as
+	  edge cases such as handling of duplicate unions.
+
+	  If unsure, say N
+
 config USERCOPY_KUNIT_TEST
 	tristate "KUnit Test for user/kernel boundary protections"
 	depends on KUNIT
diff --git a/lib/Makefile b/lib/Makefile
index 773adf88af41..03da92faf9b8 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -388,6 +388,7 @@ CFLAGS_fortify_kunit.o += $(call cc-disable-warning, stringop-truncation)
 CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
+obj-$(CONFIG_UNION_FIND_KUNIT_TEST) += union_find_kunit.o
 obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
 
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
diff --git a/lib/union_find_kunit.c b/lib/union_find_kunit.c
new file mode 100644
index 000000000000..9bdf9e0e455e
--- /dev/null
+++ b/lib/union_find_kunit.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <kunit/test.h>
+#include <linux/module.h>
+#include <linux/union_find.h>
+
+static void test_union_and_find(struct kunit *test)
+{
+	struct uf_node node1, node2, node3;
+	struct uf_node *root1, *root2, *root3;
+	bool merged;
+
+	/* Initialize the nodes */
+	uf_node_init(&node1);
+	uf_node_init(&node2);
+	uf_node_init(&node3);
+
+	/* Check the initial parent and rank */
+	KUNIT_ASSERT_PTR_EQ(test, uf_find(&node1), &node1);
+	KUNIT_ASSERT_PTR_EQ(test, uf_find(&node2), &node2);
+	KUNIT_ASSERT_PTR_EQ(test, uf_find(&node3), &node3);
+	KUNIT_ASSERT_EQ(test, node1.rank, 0);
+	KUNIT_ASSERT_EQ(test, node2.rank, 0);
+	KUNIT_ASSERT_EQ(test, node3.rank, 0);
+
+	/* Union node1 and node2 */
+	merged = uf_union(&node1, &node2);
+	KUNIT_ASSERT_TRUE(test, merged);
+
+	/* Assert that one of the nodes is now the parent of the other */
+	root1 = uf_find(&node1);
+	root2 = uf_find(&node2);
+	KUNIT_ASSERT_PTR_EQ(test, root1, root2);
+
+	/* Check rank after the first union */
+	if (root1 == &node1) {
+		KUNIT_ASSERT_EQ(test, node1.rank, 1);
+		KUNIT_ASSERT_EQ(test, node2.rank, 0);
+	} else {
+		KUNIT_ASSERT_EQ(test, node1.rank, 0);
+		KUNIT_ASSERT_EQ(test, node2.rank, 1);
+	}
+
+	/* Attempt to union node1 and node2 again and check for false return */
+	merged = uf_union(&node1, &node2);
+	KUNIT_ASSERT_FALSE(test, merged);
+
+	/* Union node3 with the result of the previous union (node1 and node2) */
+	uf_union(&node1, &node3);
+
+	/* Assert that all nodes have the same root */
+	root3 = uf_find(&node3);
+	KUNIT_ASSERT_PTR_EQ(test, root1, root3);
+
+	/* Check rank after the second union */
+	KUNIT_ASSERT_EQ(test, root1->rank, 1);
+	KUNIT_ASSERT_EQ(test, node3.rank, 0);
+}
+
+static struct kunit_case union_find_test_cases[] = {
+	KUNIT_CASE(test_union_and_find),
+	{}
+};
+
+static struct kunit_suite union_find_test_suite = {
+	.name = "union_find_test_suite",
+	.test_cases = union_find_test_cases,
+};
+
+kunit_test_suites(&union_find_test_suite);
+
+MODULE_AUTHOR("Kuan-Wei Chiu <visitorckw@gmail.com>");
+MODULE_DESCRIPTION("Union-find KUnit test suite");
+MODULE_LICENSE("GPL");
-- 
2.34.1


