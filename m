Return-Path: <cgroups+bounces-2846-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1F18C1A6E
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2024 02:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1E131C2248D
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2024 00:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42AA4643B;
	Fri, 10 May 2024 00:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4YHOHhb7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FFC4596F
	for <cgroups@vger.kernel.org>; Fri, 10 May 2024 00:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299773; cv=none; b=JIJS/V3PP7oJGgc9pYolVYs8pc+tG/dIEplk9nSNAItOGYZl5o5o+hEDxXF8iYQj4Hb1ly0iO/FbDDbfdmG6eMZSX8fD7Cwg90zZ3AH9akOZewkZLpl+pdu63jBUGVwiRwPPcy3LrlvpbkqT/yOMgxN0H/YbaHnqga/97kK2nh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299773; c=relaxed/simple;
	bh=TsIsQdr7UVoy4bxCdw4tMhojSKrH6NIh2l4zBu3z9q0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K/2Nf5pgFBcYTaCOIqwMlSF5TjPxr2TKW0nqLVLc2FZHVUIxKhIS1f0Y8jm7wnJWaPElWJrDLoejPXdGehkU37zYbG2xxagnG4tG2lffWoaEcRL59ZJt1M6nvS/ZFzG2bPLhRQs7nvPzf8D/QjeMGCrHo5zfnRa3Jy7fCZZAU+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4YHOHhb7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be25000a4so24997667b3.2
        for <cgroups@vger.kernel.org>; Thu, 09 May 2024 17:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299771; x=1715904571; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ryQJTviHp0IGCXbDhH7pUWkG12d3AaS6WDLra+PaznQ=;
        b=4YHOHhb7NWjFIfOFofCOKXQKqVCkkO2IC4krTiX40xRfniUA5svPgvUDrt+npRv7Y+
         kkpTcGOUhPwAGmCCq+sxwCXb7H6cbs9TV2Y2Lhry5TZpJrJZ1XpF77hyIyoHX0XRKdDc
         oNv+7WYV7EQgdQXx8P/+ABG39f9T5m7KffRK4V2rNb2QKSaFTYYJB9A1evW9Z9Ecj5FC
         ngJr72wsBfPm6Qo7NTlzLBkCBE/+B1ndukTS5O2jMJtRAv/BsL9vHhL84xDTNve4daMk
         Zm5Eh0ryOtPjRzK1RKOc3w6vGUYlhMUQTr5ZVhxBE6t8CiJDg9FD91MhQarnzSE9KX+Z
         4p2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299771; x=1715904571;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ryQJTviHp0IGCXbDhH7pUWkG12d3AaS6WDLra+PaznQ=;
        b=WSGMbL+6Tb66yxeLzaYY2w/H8FNJYu0vA+y72mJfuW2QJKX90g7EugTqSiZIpAGAMy
         AflRXSrkF2erLLEYwtNNoZPRlwaRrBn4b4B4Lo2qtjWHap7XoM5oQ8k3VIyvsI4K5Ei1
         cdVpWkQi47I+q+nZ5cp+tQgzbc50SX6D+AK0UPg3150HQOFAy6977osNm0C9Pizizn32
         g6ogs56AO1NoU/kbvZ1bSmN598UtNEbW+JCoug7DwfXckcejBmAVeJog6MptKyxA2FaC
         RQxiwqe5aa5Im2qHBQhy+txfIZ6kRa2kx+xoYvy363i2ZujQDBRbCK8VyFYnSNn5tTiL
         KiRg==
X-Forwarded-Encrypted: i=1; AJvYcCV+LgaM1mQVsplawkXJNxnT72eiIrY9KVp28lF972vRbJiof95P6vfJoxLK1pfHCk0nPW7uazJUzFGrDZ0wU3iBrU8S1InKfQ==
X-Gm-Message-State: AOJu0Yz2V0KySOaEsWasK2K+hdVpfLXsp7+MgbSFcn8hN+UWW3uvbiP2
	aAuUQuqao9fVfbUKIkZzY6Kf+eDK5OOiCPIzA60SbnUbTiSV993goSXoVEse8NZhK+98ny59TBR
	eVQ==
X-Google-Smtp-Source: AGHT+IF91iKdotUjwmFTJdv3hHy+ZWcgNpEXa3QGcsFOHdNTuSebKSYhR/TL6dX2vV5PjHVT+dvJb7v+gsc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:6c87:b0:61b:e15c:2b84 with SMTP id
 00721157ae682-622afff942fmr3115277b3.6.1715299771144; Thu, 09 May 2024
 17:09:31 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:25 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-9-edliaw@google.com>
Subject: [PATCH v4 08/66] selftests/cgroup: Drop define _GNU_SOURCE
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
2.45.0.118.g7fe29c98d7-goog


