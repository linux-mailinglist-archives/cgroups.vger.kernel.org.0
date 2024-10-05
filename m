Return-Path: <cgroups+bounces-5040-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD69991AF8
	for <lists+cgroups@lfdr.de>; Sat,  5 Oct 2024 23:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45965B21A54
	for <lists+cgroups@lfdr.de>; Sat,  5 Oct 2024 21:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8618016D4E6;
	Sat,  5 Oct 2024 21:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIc34CAo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2891714CD;
	Sat,  5 Oct 2024 21:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728165009; cv=none; b=QfWIEJMjBDu/pBpSBG67JbG9lWqbJXCwjxz76tty3vNk8qADBp/lZRa6NQ/NXK8hHCR3XSYJyfwOstPI8LdMx1ayOjxgL+VZ2vyssSzzxkICHFpoE9Occh7sggOwMgOV2guxg3Lp1KosVMxa85U6GZLstHDJEo8H5i3TCfetpaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728165009; c=relaxed/simple;
	bh=eIduj2a7RDmKLt4ahXC9kCLPei5SOm6je5RPRjT8kM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RsscJJ71NGfrUk8VUrtIEddZscJOcb4pnXVlaNLWH4X7HMv/TpM2rd8k1PCQ7Av3bmf6dWjdNE4QaQZNDuBrZh19pg6xO5ji3A4xQL6+UGElvT0FPbS0gPaGVbORhM6sag7tnsA0aLHLd7TL7qEcMJVmKfTuTUvLsoJbsnW5WA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIc34CAo; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b78ee6298so20847115ad.2;
        Sat, 05 Oct 2024 14:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728165007; x=1728769807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcSg+3d0QR+rdWz/nC3iZVkACTYk5EHJ8llhpn/oIv4=;
        b=BIc34CAonHpcX7omqIpDvk4jZMjAENbqD5lZEgUoH8+m/hiFmO0HDtt3no6x2hpE9B
         IFZB6oWdbIKSbWmr0qAAvuJWtKtbQmP8eemazy4HoO8OaAk/Vbegl7tHMo4xAPwlSd1h
         4FXWo8akEcelAYFQz9kYDewI5RuPJJzlmMKmRL8rvc/7fO4hv6KYpj8bgM2oeLAoe1vR
         YPH7rlghj00QFJ3Oc97f4qiJtLRPQFBmnOyu81Y9Uv/OCyRPRNLDzrpw7hq0GleBwJKi
         FpwnYOjylByKj4tOxKMiRtyQVLcDHSL3JLnjuaKzfO/qTVD2ZCWLI+P1daNh3engXySP
         noHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728165007; x=1728769807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcSg+3d0QR+rdWz/nC3iZVkACTYk5EHJ8llhpn/oIv4=;
        b=RGjTaEXjuEqbYEXHkZOQX9G6IcLO35kY872fY18JsqiOLbjbia5Drr3aXl/CKTWZtR
         Ec05/8c3qAbhc82poBvCOdioTZJxy+GH2jCPxYunxJKxnYAux1GOSOlKJXZVg3pAEvn/
         jVmUYCorCUsd/uNmeyxFQbXdlOfwjRQWucIwPTKRZ6R0FEVnf3ZikdpK/nIWduK+yUNK
         +TqVGTQo2UgWJWCfaIdJavd0g3Hzm21FAL19mdmIWM224yCxPDlgYNZfHAeIG20KzxDw
         Cbeh9hoE1LYhU5OfUVIBchqHDlaCHIzk3KNUKXz0pcK38+YAUbMuidOAHwAxl9CtdQTb
         hJiw==
X-Forwarded-Encrypted: i=1; AJvYcCU3Qvn4QXt82ntFs0WtMHjE9sM5hiAsB3UlXtewNF2HaUVP9a1MMeZFpzivMr10H4PZQJZtklp3+lPycKn0@vger.kernel.org, AJvYcCXeP3mtfa5y5rVP84mfD4lpqtocnh9tb7dkTjoSKoEp8THkDe+WvCVm5W9OVQx3U6KyXLBlGbG8@vger.kernel.org
X-Gm-Message-State: AOJu0YzI4VpautJ9pjTiOLf4s25rPaIQyjDp/b+LsC7ReZ4ipmccTHnN
	+e49ONbdJcu/Wi7XROky8MyvHhU6yCLZ+fhsRDAv2ZKU46rSbQhT
X-Google-Smtp-Source: AGHT+IHvftSQJ5RfLJxXlqhYt4stFu9wgWyJ3Ff5j+BVn2RTShvzOQ1JRR1JY0RE3VOua2f1976QOw==
X-Received: by 2002:a17:902:f60e:b0:20b:a41f:6e48 with SMTP id d9443c01a7336-20bfe011becmr139397605ad.27.1728165007055;
        Sat, 05 Oct 2024 14:50:07 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13931055sm17165135ad.139.2024.10.05.14.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 14:50:06 -0700 (PDT)
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
Subject: [PATCH 3/5] lib: Add KUnit tests for Union-Find implementation
Date: Sun,  6 Oct 2024 05:49:36 +0800
Message-Id: <20241005214938.2147393-4-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241005214938.2147393-1-visitorckw@gmail.com>
References: <20241005214938.2147393-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a KUnit test suite for the Union-Find data structure. The
tests verify the functionality and correctness of the union and find
operations, including edge cases such as handling duplicate unions.
The addition of KUnit tests enhances the robustness of the Union-Find
implementation by ensuring its correctness under various scenarios.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Regarding the changes to the MAINTAINERS file, I'm also happy to help
maintain/review patches related to union find. If I am qualified
enough, may I send another patch to add myself later? :)

 MAINTAINERS            |  1 +
 lib/Kconfig.debug      | 12 +++++++
 lib/Makefile           |  1 +
 lib/union_find_kunit.c | 74 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+)
 create mode 100644 lib/union_find_kunit.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5153c995d429..3b10ac1cdf63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23799,6 +23799,7 @@ F:	Documentation/core-api/union_find.rst
 F:	Documentation/translations/zh_CN/core-api/union_find.rst
 F:	include/linux/union_find.h
 F:	lib/union_find.c
+F:	lib/union_find_kunit.c
 
 UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER
 R:	Alim Akhtar <alim.akhtar@samsung.com>
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7315f643817a..376c86d34253 100644
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
+	  This option enables the KUnit tests for the Union-Find data structure.
+	  These tests verify the functionality and correctness of the Union-Find
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


