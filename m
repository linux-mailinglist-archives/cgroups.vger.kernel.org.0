Return-Path: <cgroups+bounces-7271-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E4EA77028
	for <lists+cgroups@lfdr.de>; Mon, 31 Mar 2025 23:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C1A3ABEFB
	for <lists+cgroups@lfdr.de>; Mon, 31 Mar 2025 21:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972A31C84CD;
	Mon, 31 Mar 2025 21:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gRSr1fci"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E268C21C188
	for <cgroups@vger.kernel.org>; Mon, 31 Mar 2025 21:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743456637; cv=none; b=tzaooIdk96XbCgT+MvjFWMxSu828biBZbTwLyocIXMEig4SX62Z5Xrdnjs48KLx1MBiHhOlBwNhv4GTWyUdq1hJs+O7IVMBQ9HN0hSyfQOtHQ+fAscDLixaS3cXv2SYflvSjaAzBjODeUT9ND1onLmKESx9Mci7wW9n3jGRHbkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743456637; c=relaxed/simple;
	bh=mjpU6MDhgU6cTqhOoVD4es2HPtgPtqp4bKNwM9P9cG4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P+OuLjgHSVIoKvuJSnFCMQZU/pEgrwfTnTtw/ItfIoO7Q2mB7+csKjoBp7UQWURhiOdki0quWS1ECKqA2WZOVUuEg7oRLgtu6McNLcZ8YiV9T1ZRW+pyyh77T4k6QO8Y3xvQ/FAxLewCy5wBMiV183AUby0q+U8lluozDyPwvYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gRSr1fci; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7c0b0cf53f3so751397385a.2
        for <cgroups@vger.kernel.org>; Mon, 31 Mar 2025 14:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743456634; x=1744061434; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ekwv7KGdyZFU+jTcpCSyOgzKWCtQSrak75BLH4Eza8c=;
        b=gRSr1fcia8FO0KiWIRW5/jXB+lPLbtzVnnzakUDQSZGeZgwKOokWVmjlDBNMT+5jbL
         YQk0HYHStuQbBwFL9GTXieIkidmlDtgZvAFnnFk+5joECfrKkdRZW/Wy7zrNU2OLh9eA
         PF+//oB9nzvNCw3xJNaUFXTrWRgJ5Mm95wwe8btk1F1WhOPYEKBg1GJeVluP+eQODMoo
         24dkQCWoyCfg65vfMkBpgaxs+Hpqa8IZYn+vXPgYu9ICdnMfSKdO4fIpOFNsD2ShKyBm
         hIqhsfOX+GQauQB3++jI26PBsmCGTH9xqjW8QojZUaWbz9ChUmQmdmfKWO8xSHRbzuSK
         YRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743456634; x=1744061434;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ekwv7KGdyZFU+jTcpCSyOgzKWCtQSrak75BLH4Eza8c=;
        b=Hr5pWQnnDSKaGC3Ma4Ul7TUWjPmX3oAnPY+SWqmij6xGSr9jtzYui7DxnM30a7DNHV
         H9Skp59Pn7HG4JL80Cw3ctOAMv7v/v9K295V3hGFAVaeJdZsDrJHarG+slx09iAT79Nl
         0ED+q81ScnLC1Aey5EiPehGhSGJdEofxLZ0suvv6YpCeaEVNYVokG6JTYS2C8sDIMqyk
         XboXV3IGT7GDmd/p+W+SaovMsi1gPSIGM68QXZI73ng1FFA7qybsRUDkMRoK5pvDcn0h
         Kx8JllKMgeQYSk5rvKX6949t17VeTqFS9a5hfF3f0T4CqkQ3LWFaBU+u4xjxYTbX0wnT
         i5oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSyiT3IG/YKjnm8uW5uDaaYsKyc5J8Loz9K8LaMKx4dM+wMg0Oq/Tg/P2QfpmxlfiiyYLRe9NS@vger.kernel.org
X-Gm-Message-State: AOJu0YztzzrQJluoXb52XzshKoSPvC0KbpkLAVdag3DNHOmYJMMYsJ4+
	eU6+Z3Wo3BM3V1S0muopR/IZWfX6oSsG8euY7rY47tzAYVmZymoNoHDTG60Pqn9biPt1QUFCof9
	stRkiPZHcjJvxoBpBTQ==
X-Google-Smtp-Source: AGHT+IFAnmoz1fj2tWiXC7ZF3nNAKY9wbok9MzxIrTwJ7bxeF0N65ecJB0+NIisgqGxEkKRMPYj00++Iyp0hSJd5
X-Received: from qkjx24.prod.google.com ([2002:a05:620a:14b8:b0:7c5:e0ba:1600])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:bca:b0:7c5:3c69:2bce with SMTP id af79cd13be357-7c6862ebd1cmr1569629685a.7.1743456633860;
 Mon, 31 Mar 2025 14:30:33 -0700 (PDT)
Date: Mon, 31 Mar 2025 21:30:23 +0000
In-Reply-To: <20250331213025.3602082-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250331213025.3602082-1-jthoughton@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250331213025.3602082-4-jthoughton@google.com>
Subject: [PATCH v2 3/5] cgroup: selftests: Move cgroup_util into its own library
From: James Houghton <jthoughton@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, mkoutny@suse.com, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Yu Zhao <yuzhao@google.com>, 
	James Houghton <jthoughton@google.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

KVM selftests will soon need to use some of the cgroup creation and
deletion functionality from cgroup_util.

Suggested-by: David Matlack <dmatlack@google.com>
Signed-off-by: James Houghton <jthoughton@google.com>
---
 tools/testing/selftests/cgroup/Makefile       | 21 ++++++++++---------
 .../selftests/cgroup/{ => lib}/cgroup_util.c  |  2 +-
 .../cgroup/{ => lib/include}/cgroup_util.h    |  4 ++--
 .../testing/selftests/cgroup/lib/libcgroup.mk | 14 +++++++++++++
 4 files changed, 28 insertions(+), 13 deletions(-)
 rename tools/testing/selftests/cgroup/{ => lib}/cgroup_util.c (99%)
 rename tools/testing/selftests/cgroup/{ => lib/include}/cgroup_util.h (99%)
 create mode 100644 tools/testing/selftests/cgroup/lib/libcgroup.mk

diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
index 1b897152bab6e..e01584c2189ac 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -21,14 +21,15 @@ TEST_GEN_PROGS += test_zswap
 LOCAL_HDRS += $(selfdir)/clone3/clone3_selftests.h $(selfdir)/pidfd/pidfd.h
 
 include ../lib.mk
+include lib/libcgroup.mk
 
-$(OUTPUT)/test_core: cgroup_util.c
-$(OUTPUT)/test_cpu: cgroup_util.c
-$(OUTPUT)/test_cpuset: cgroup_util.c
-$(OUTPUT)/test_freezer: cgroup_util.c
-$(OUTPUT)/test_hugetlb_memcg: cgroup_util.c
-$(OUTPUT)/test_kill: cgroup_util.c
-$(OUTPUT)/test_kmem: cgroup_util.c
-$(OUTPUT)/test_memcontrol: cgroup_util.c
-$(OUTPUT)/test_pids: cgroup_util.c
-$(OUTPUT)/test_zswap: cgroup_util.c
+$(OUTPUT)/test_core: $(LIBCGROUP_O)
+$(OUTPUT)/test_cpu: $(LIBCGROUP_O)
+$(OUTPUT)/test_cpuset: $(LIBCGROUP_O)
+$(OUTPUT)/test_freezer: $(LIBCGROUP_O)
+$(OUTPUT)/test_hugetlb_memcg: $(LIBCGROUP_O)
+$(OUTPUT)/test_kill: $(LIBCGROUP_O)
+$(OUTPUT)/test_kmem: $(LIBCGROUP_O)
+$(OUTPUT)/test_memcontrol: $(LIBCGROUP_O)
+$(OUTPUT)/test_pids: $(LIBCGROUP_O)
+$(OUTPUT)/test_zswap: $(LIBCGROUP_O)
diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/lib/cgroup_util.c
similarity index 99%
rename from tools/testing/selftests/cgroup/cgroup_util.c
rename to tools/testing/selftests/cgroup/lib/cgroup_util.c
index 1e2d46636a0ca..f047d8adaec65 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/lib/cgroup_util.c
@@ -17,7 +17,7 @@
 #include <unistd.h>
 
 #include "cgroup_util.h"
-#include "../clone3/clone3_selftests.h"
+#include "../../clone3/clone3_selftests.h"
 
 /* Returns read len on success, or -errno on failure. */
 static ssize_t read_text(const char *path, char *buf, size_t max_len)
diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
similarity index 99%
rename from tools/testing/selftests/cgroup/cgroup_util.h
rename to tools/testing/selftests/cgroup/lib/include/cgroup_util.h
index 19b131ee77072..7a0441e5eb296 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
@@ -2,9 +2,9 @@
 #include <stdbool.h>
 #include <stdlib.h>
 
-#include "../kselftest.h"
-
+#ifndef PAGE_SIZE
 #define PAGE_SIZE 4096
+#endif
 
 #define MB(x) (x << 20)
 
diff --git a/tools/testing/selftests/cgroup/lib/libcgroup.mk b/tools/testing/selftests/cgroup/lib/libcgroup.mk
new file mode 100644
index 0000000000000..12323041a5ce6
--- /dev/null
+++ b/tools/testing/selftests/cgroup/lib/libcgroup.mk
@@ -0,0 +1,14 @@
+CGROUP_DIR := $(selfdir)/cgroup
+
+LIBCGROUP_C := lib/cgroup_util.c
+
+LIBCGROUP_O := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBCGROUP_C))
+
+CFLAGS += -I$(CGROUP_DIR)/lib/include
+
+EXTRA_HDRS := $(selfdir)/clone3/clone3_selftests.h
+
+$(LIBCGROUP_O): $(OUTPUT)/%.o : $(CGROUP_DIR)/%.c $(EXTRA_HDRS)
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
+
+EXTRA_CLEAN += $(LIBCGROUP_O)
-- 
2.49.0.472.ge94155a9ec-goog


