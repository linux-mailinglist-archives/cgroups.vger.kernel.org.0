Return-Path: <cgroups+bounces-7238-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B06F3A7281A
	for <lists+cgroups@lfdr.de>; Thu, 27 Mar 2025 02:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBD5F7A61CC
	for <lists+cgroups@lfdr.de>; Thu, 27 Mar 2025 01:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E30D14EC62;
	Thu, 27 Mar 2025 01:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KmrUwvL1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ua1-f74.google.com (mail-ua1-f74.google.com [209.85.222.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEA37DA95
	for <cgroups@vger.kernel.org>; Thu, 27 Mar 2025 01:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743038699; cv=none; b=glGujtmQ9EKsuvTv/BDpDqHT7Y0rAQDw3HAMLFpAwa1qv5W98thtIfKPkdtDtFMZqDK0U49Tr/hks/Rfpnso96hjUcZvJyx5X7iWiW5gxWKG44/7j0ycz4VkfD98HnpiqBXmy9mrmjfgOkz4lyQ3IO8sUbRSgh19nndowyL+3jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743038699; c=relaxed/simple;
	bh=BfLa2QteAJuzJlCbZuLE5l/LTfJiKpsDE6KPN4nYm+Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dkldoebVFKrrX45Vxg6q0OPTRlwQGO9Iau8U2cIlmB8so67q1fIkZmuSad+OX0Sufmqrd/Og6M82Kb61vVAl9Ww61UgWr5RBbynhStm4TLSSsRN2qZdWcXasGDpIWubgxac1z5am2exV11oseWAl/S5EFkxvkTts44xaY/uLH+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KmrUwvL1; arc=none smtp.client-ip=209.85.222.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-ua1-f74.google.com with SMTP id a1e0cc1a2514c-86d9fc9d467so123518241.2
        for <cgroups@vger.kernel.org>; Wed, 26 Mar 2025 18:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743038696; x=1743643496; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gGqxd23a/0EjTo66Tj0AOPzp5tI+DdYta3+Brtl9zUU=;
        b=KmrUwvL1hVwacRGIfD9buNw1suFiCTEnS1DkD0ZmATQfvusHIiyhG+yhWiMVlcndr/
         DaVG43fkG5yGf5JQ4qpZV3SI5LSIgxD2DYreMBEw/mzq7/OHUs8+QFaZUeMQb+P+E15L
         1qXsAM4ARcCBO6QskIHiAeFc/TOG1XHPbzgpx0Zqa5xfWuW2i7pYY1+p1A76ETyHozW4
         UQkzVSfp662sY4Np3gZpegTZ//bCtCQKfI3KGbyftjc/x9sAShOyrrAjcYuw+uV2HFwl
         KKK2iXwwK2DRWnvfVFVn7NDLr2gi2VRUEca6VKkBJcCrJXdPHqUwOkCc0mAUB9THa+rj
         7eSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743038696; x=1743643496;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gGqxd23a/0EjTo66Tj0AOPzp5tI+DdYta3+Brtl9zUU=;
        b=g4h/ao83SjxrDMDF6V6rj567JrsSLMU33IeaRCqu7STpzC30cY4jUymV6mr3r1DhGI
         xdkrab71Q58RUJtaTeSJPgo0RJVo5gjFM2Rc22Wpf9gTd/LhJP6EdoB9B7xE1vbJvAdX
         eGimJNq/HMUq1xZKAVQKPbLJRPgD2kaqtQvXhd/klvgyyR74OEgzLLWqNAYbMEh5Mr4c
         M6SZAO2jyUK3W42C4xHmiXojzsrJZOWuh19h40YjL5MQWykT3648uQmi/kq34BLlcBso
         DLnrEqozGv2Ka5X86CNXeU5KHqBbtON/nQV99ARN5kh06EXGCrI2nGIjKuWqqMvyQilm
         LwIg==
X-Forwarded-Encrypted: i=1; AJvYcCWAAAoAQy5QRmf1gGPHnNspF1+dF7K9xR6M6Td++6NkWizZQ+YQlybeOnQ7lR7ZIaBy1gkTV1UQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ1eRxv1ieTq28oRD96oRrAK91V1fNbEPNk18ZDiAW4sUoQu4h
	c2XW3B5reDONXWPalRXVFuQEnQ6xH3dQLBQ4uswQ7TRVSgMCztDDrgRTJHXa172IzTiQiIjIWfA
	do2u2PQBqk17bHD5yuQ==
X-Google-Smtp-Source: AGHT+IHGl12nIoVpESkgRXoTlyIOOjXfd42fJqbcs3jdHsAlXFB74Da6kCtuJ1aDXxzdgLsg1P+I7e2U7pMaDK9c
X-Received: from vsbby4.prod.google.com ([2002:a05:6102:5044:b0:4c5:5592:22ae])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a67:e716:0:b0:4c1:9cb2:8389 with SMTP id ada2fe7eead31-4c586efe52dmr2559753137.2.1743038696346;
 Wed, 26 Mar 2025 18:24:56 -0700 (PDT)
Date: Thu, 27 Mar 2025 01:23:48 +0000
In-Reply-To: <20250327012350.1135621-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250327012350.1135621-1-jthoughton@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250327012350.1135621-4-jthoughton@google.com>
Subject: [PATCH 3/5] cgroup: selftests: Move cgroup_util into its own library
From: James Houghton <jthoughton@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, mkoutny@suse.com, 
	Yu Zhao <yuzhao@google.com>, James Houghton <jthoughton@google.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

KVM selftests will soon need to use some of the cgroup creation and
deletion functionality from cgroup_util.

Suggested-by: David Matlack <dmatlack@google.com>
Signed-off-by: James Houghton <jthoughton@google.com>
---
 tools/testing/selftests/cgroup/Makefile       | 21 ++++++++++---------
 .../selftests/cgroup/{ => lib}/cgroup_util.c  |  3 +--
 .../cgroup/{ => lib/include}/cgroup_util.h    |  4 ++--
 .../testing/selftests/cgroup/lib/libcgroup.mk | 12 +++++++++++
 4 files changed, 26 insertions(+), 14 deletions(-)
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
index 1e2d46636a0ca..d5649486a11df 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/lib/cgroup_util.c
@@ -16,8 +16,7 @@
 #include <sys/wait.h>
 #include <unistd.h>
 
-#include "cgroup_util.h"
-#include "../clone3/clone3_selftests.h"
+#include <cgroup_util.h>
 
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
index 0000000000000..2cbf07337c23f
--- /dev/null
+++ b/tools/testing/selftests/cgroup/lib/libcgroup.mk
@@ -0,0 +1,12 @@
+CGROUP_DIR := $(selfdir)/cgroup
+
+LIBCGROUP_C := lib/cgroup_util.c
+
+LIBCGROUP_O := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBCGROUP_C))
+
+CFLAGS += -I$(CGROUP_DIR)/lib/include
+
+$(LIBCGROUP_O): $(OUTPUT)/%.o : $(CGROUP_DIR)/%.c
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
+
+EXTRA_CLEAN += $(LIBCGROUP_O)
-- 
2.49.0.395.g12beb8f557-goog


