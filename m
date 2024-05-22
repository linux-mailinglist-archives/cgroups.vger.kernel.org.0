Return-Path: <cgroups+bounces-2978-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8143E8CB724
	for <lists+cgroups@lfdr.de>; Wed, 22 May 2024 03:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFCC71F276AF
	for <lists+cgroups@lfdr.de>; Wed, 22 May 2024 01:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B27328FD;
	Wed, 22 May 2024 01:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yyAI8ND/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB11742A89
	for <cgroups@vger.kernel.org>; Wed, 22 May 2024 01:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339602; cv=none; b=kgekd9/U1NkxUytcQmIdqvN+kphMRkiTgK8cHsGWKPpKBPkfjLA2lA0SvWCOTHnkspI4IGBrQaZUbURUwQmros+WmnTFY4l/1KUW7h0V1efMPQFI5Le+sssYjjxniOTkx1XYWoBk0j2kkXcHE5AfcQg1tQEsjaIhH2f4A1zP7hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339602; c=relaxed/simple;
	bh=ChN28EHAqFl6+8yppbpRlHGVZfo9GWkmbJN43rS0lAg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K2g8Ro/DJm3R0EJd60yXmGoAODVepsxxxdBU4ma/1EHsosxCb3em8wZ6br7+xoHJWRVeYM8ml9uMpNam2LklUE31Hd5YuOYRIriP2K3mM5P+8P9cA1NmIVZaCxVDp2k/M3B3naXp/gwcWXQqbKttki8+vNarOEu95xQz+G8dNn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yyAI8ND/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1f314d14930so7534745ad.2
        for <cgroups@vger.kernel.org>; Tue, 21 May 2024 18:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339600; x=1716944400; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fu2STs6PZpOamDjJKGMtZZrD18Ex35OZP78N3HJKaqA=;
        b=yyAI8ND/mlgq6HuOuftcycS4e/gRhmDPqS3POY6D/xq6C/1vGDMGhsWz8ubwj16uqQ
         Gy73hkoPNVweFSFJP/AggnPhXypbnERwYA/gngWKNbgCHVYYVznEnJhNttNY+zZNPqQ7
         dlY3xS01EyU3B5jK7ZNOPpwlzlpHGdOGggja8hiAG6dWeNrh/+jQ5aFTveQYNj2/26ml
         DoSwQsvAY1GNjkzT00+MQhWkqQw4E690CmByMGrCWWbbKARE95nLioaIw/3BWy+OTAGb
         tfJ8/jY7VFMYPpIWi1QDrsD+eDmzpc3SVIyl+V0Zd1EBi03Mk1toC1crPobUhOs1mcki
         VyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339600; x=1716944400;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fu2STs6PZpOamDjJKGMtZZrD18Ex35OZP78N3HJKaqA=;
        b=qx9ADVwq7WYx6fJsNL7iuntms1OgGHHqGTnYNoQQQtG5hktno61xDyghKxMsPK0qzQ
         CjK4dTRmY2lfzk8JhNN+3MvCScDay1EteQyfzQIP9U7aL5nB9g3WpXk9ZwYoUpl56c8y
         dRRmlVyJtfLpLBg4XuBlBSXt171oQUKvxlzkvsP57jtmOjTSTDD6bLCmFJeNCaHk9+Ux
         OEjJHq5Mv3HMx0Hr/jOIKXlb16Z5FWDHUFK5fudkiasj0hPXqi2PJt3NvnlRHzwCii3a
         ZIcmOTJYz0hRpWzO4MXUlmXRSDfp7uyYaA4p6AqCOmfKwMEvs4CJXqNQXG/ZmFNWmF2l
         adfg==
X-Forwarded-Encrypted: i=1; AJvYcCW6b9780QH1B2IpsLOWstV/Yxvdvk9DVdyoyukqXFKXMbNM1f++AnrCu44ASi9M3r5gMRHdZW37lS9JmnjShyHlYIxhvt22fQ==
X-Gm-Message-State: AOJu0YzTgy1W7VWDDFss9GIDncqZbLtiGmCShoJtq/NLTf9E1N16IdeG
	KvR78ckb3ue0Ha8kzLOYJOfpRXHvUW3ucykPeVryRVLj0YUFgiExXxHX92qZzJtmx1X2UrayeZe
	ttA==
X-Google-Smtp-Source: AGHT+IEFjdm+modzHl4cK4pfS9awweB7RmwScYsN5OqiRKiBdxiZrCIPpWs+/7sEWbnGOtixci5Pqw9llow=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:da87:b0:1f3:900:e7f0 with SMTP id
 d9443c01a7336-1f31c9cd3afmr111425ad.9.1716339599938; Tue, 21 May 2024
 17:59:59 -0700 (PDT)
Date: Wed, 22 May 2024 00:56:55 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-10-edliaw@google.com>
Subject: [PATCH v5 09/68] selftests/cgroup: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Muchun Song <muchun.song@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/cgroup/cgroup_util.c        | 3 ---
 tools/testing/selftests/cgroup/test_core.c          | 2 --
 tools/testing/selftests/cgroup/test_cpu.c           | 2 --
 tools/testing/selftests/cgroup/test_hugetlb_memcg.c | 2 --
 tools/testing/selftests/cgroup/test_kmem.c          | 2 --
 tools/testing/selftests/cgroup/test_memcontrol.c    | 2 --
 tools/testing/selftests/cgroup/test_zswap.c         | 2 --
 7 files changed, 15 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 432db923bced..ce16a50ecff8 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -1,7 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
-#define _GNU_SOURCE
-
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/limits.h>
diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
index a5672a91d273..de8baad46022 100644
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -1,6 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
-#define _GNU_SOURCE
 #include <linux/limits.h>
 #include <linux/sched.h>
 #include <sys/types.h>
diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
index dad2ed82f3ef..5a4a314f6af7 100644
--- a/tools/testing/selftests/cgroup/test_cpu.c
+++ b/tools/testing/selftests/cgroup/test_cpu.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <linux/limits.h>
 #include <sys/sysinfo.h>
 #include <sys/wait.h>
diff --git a/tools/testing/selftests/cgroup/test_hugetlb_memcg.c b/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
index 856f9508ea56..80d05d50a42d 100644
--- a/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
+++ b/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <linux/limits.h>
 #include <sys/mman.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
index 96693d8772be..2e453ac50c0d 100644
--- a/tools/testing/selftests/cgroup/test_kmem.c
+++ b/tools/testing/selftests/cgroup/test_kmem.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <linux/limits.h>
 #include <fcntl.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 41ae8047b889..c871630d62a3 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -1,6 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#define _GNU_SOURCE
-
 #include <linux/limits.h>
 #include <linux/oom.h>
 #include <fcntl.h>
diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index 190096017f80..cfaa94e0a175 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <linux/limits.h>
 #include <unistd.h>
 #include <stdio.h>
-- 
2.45.1.288.g0e0cd299f1-goog


