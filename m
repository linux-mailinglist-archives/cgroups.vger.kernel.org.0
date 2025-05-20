Return-Path: <cgroups+bounces-8266-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E27ABCDB4
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 05:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B82184A0FF5
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 03:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E34D25522B;
	Tue, 20 May 2025 03:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aPFeaO8S"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564A4BE5E
	for <cgroups@vger.kernel.org>; Tue, 20 May 2025 03:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747710967; cv=none; b=mK9HSGrwPLHWGtguu2pYdnxi3se2IJIc0N9icp6XNTHvW5NIsWXryeKZvgv1WT49UfdoDRriGzrC9YSvvCacz6eHrKc0oUoX7BUA4VyCMvbxiJbuSuAOIHXyeMY+DhFFkd0vtPnWWzbKS9apAYOeKwMK/2vi6dUFOGOJdVoogGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747710967; c=relaxed/simple;
	bh=nRhpHv6oHTyiSD62FahxTEpoWjh1OEnhwGSW3orWgR8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PxRkT2EGolQByea2y9NpYuBXSmxHJUPR6SxwHgOIRsyC/gUBWjSYlrt1s4jxcOU7OO7pyoyMmAPVLygl+tg/J8BpWJMTGuYYCqvP2GMckF19j3VV38dQ77Svk0YFQQfm8mKzd0pDGsN2oOqr2e+SigssM/BQYoU7CNM+Bk+/758=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aPFeaO8S; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-74019695377so3996505b3a.3
        for <cgroups@vger.kernel.org>; Mon, 19 May 2025 20:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1747710963; x=1748315763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aaQyNwcaivEahcWZfzCLbvdpavVF88y+CIxVNvLkwSQ=;
        b=aPFeaO8SLM+ATSaHhJCTiaVEGg1GQbJCQJQHqX0TrnIrTQR1J7RCYAPbNgZSSXDbgw
         /3FmoILQl1cKYFL46cmmd+Dmy7jmU4OCI3hiVZjUlDTvoaUJe3z3naBx+psxJNKvnWiX
         ItWBUqOMKRkuf2VlYlZG9sWFDjswb5g70aRyM2kuh0wSQ3qxYbLIBMB+uHHc5+503xQ9
         Aw3JGvSMDs62X22vJqyncB+KOFy0m2oyhBF0kCeYWk+B7RqG0e4XM2Tl2TAR3WmC7sy5
         bpEmnEN/kK3UfhJLqc6WfNIlriiRbc+ClNwxivsSCtfBh5xJjYbSRx1xtIXlYo6quPN4
         35Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747710963; x=1748315763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaQyNwcaivEahcWZfzCLbvdpavVF88y+CIxVNvLkwSQ=;
        b=gwCZNs3dfCV8XqHSxIOJLUVUOqBCfv+oJGn1IqSx9tPkQcxdo3ZJOE1ZExgt/oPPa6
         Y9ggl6ZTtHDiuJ9JsKp7oNDhfsVrzgHxuicP2ZXXDsATOyHqCVDRJImiA/fs6SkQpxNc
         mKWVIR/GtAXOxC+vsHJ0AGFkCgT7dd8t4GuiX8+SR9WIZqiCyTvvB3/SJtrcXHWkGKL0
         eR48Eurc3Pj3+1yAlE9fc+k98VvAQM/nO9enwx3/Aa9ga61weDo2DTTzISm3AJMDJFVb
         5a2zEs7Mne2++upzVgGZrBGYum8gsFd7oKqF0zN3dC/w7fjmc3CZo15i2cIO7UA/9O8M
         wZxw==
X-Gm-Message-State: AOJu0YzHELQRha/MobSmv8cItVKpapAA/CG5pup267JYV8Co22oNj4PB
	SQ8VfCBp0rVSsS80frAnzOeRQoLpp2iGTQOxNz59+Q4TnCwCDPXszLtGul7+QP5Oufk=
X-Gm-Gg: ASbGncuAeFFkNgTjh9nQrCJ8bEZm/RwMwx2fNnQIuDkWSjyU+T3TnRYdJLZoEYbLe/3
	RALL5ESn1JAtxDOlym0rZLt902nf1owCdacpNc0FgPHU/YwxkLBFJw3ulGXf+lRJOpa41laVtmI
	O3iwEHIB7TeWpWuZUSr6pqhNzreEJ+z9KVB6fjatd73l3eY6md/n1nyF1TuL9La2CAWbB7h13Nr
	RCURX/86N4Y4X0W2MrkkukcM9YC6jvWhAf5ABPfb2etuOdVI7fDUtJNepp36fp3miJiASRluIf5
	ZFdMHtDA0fjZucZKNThgTrXfUd37fw2VDSdqH45XHUfhHo6SQz5Ihzqnoh18B6DTPZXPZUvPtvZ
	q
X-Google-Smtp-Source: AGHT+IEz9Fexfj5ew7Cz9bhXuSo5L0CfJzqvrjRZC8GEQy+PE1jXnLcxgSxRhEfAQJINGQdY6QLnYA==
X-Received: by 2002:a05:6a00:1148:b0:740:b372:be5 with SMTP id d2e1a72fcca58-742a97ac5b4mr17637564b3a.9.1747710963323;
        Mon, 19 May 2025 20:16:03 -0700 (PDT)
Received: from n37-069-081.byted.org ([115.190.40.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829b9dsm6947216b3a.88.2025.05.19.20.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 20:16:02 -0700 (PDT)
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	longman@redhat.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [PATCH] cpuset: introduce non-blocking cpuset.mems setting option
Date: Tue, 20 May 2025 11:15:52 +0800
Message-Id: <20250520031552.1931598-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting the cpuset.mems in cgroup v2 can trigger memory
migrate in cpuset. This behavior is fine for newly created
cgroups but it can cause issues for the existing cgroups.
In our scenario, modifying the cpuset.mems setting during
peak times frequently leads to noticeable service latency
or stuttering.

It is important to have a consistent set of behavior for
both cpus and memory. But it does cause issues at times,
so we would hope to have a flexible option.

This idea is from the non-blocking limit setting option in
memory control.

https://lore.kernel.org/all/20250506232833.3109790-1-shakeel.butt@linux.dev/

Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  7 +++++++
 kernel/cgroup/cpuset.c                  | 11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 1a16ce68a4d7..d9e8e2a770af 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2408,6 +2408,13 @@ Cpuset Interface Files
 	a need to change "cpuset.mems" with active tasks, it shouldn't
 	be done frequently.
 
+	If cpuset.mems is opened with O_NONBLOCK then the migration is
+	bypassed. This is useful for admin processes that need to adjust
+	the cpuset.mems dynamically without blocking. However, there is
+	a risk that previously allocated pages are not within the new
+	cpuset.mems range, which may be altered by move_pages syscall or
+	numa_balance.
+
   cpuset.mems.effective
 	A read-only multiple values file which exists on all
 	cpuset-enabled cgroups.
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 24b70ea3e6ce..2a0867e0c6d2 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3208,7 +3208,18 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 		retval = update_exclusive_cpumask(cs, trialcs, buf);
 		break;
 	case FILE_MEMLIST:
+		bool skip_migrate_once = false;
+
+		if ((of->file->f_flags & O_NONBLOCK) &&
+			is_memory_migrate(cs) &&
+			!cpuset_update_flag(CS_MEMORY_MIGRATE, cs, 0))
+			skip_migrate_once = true;
+
 		retval = update_nodemask(cs, trialcs, buf);
+
+		/* Restore the migrate flag */
+		if (skip_migrate_once)
+			cpuset_update_flag(CS_MEMORY_MIGRATE, cs, 1);
 		break;
 	default:
 		retval = -EINVAL;
-- 
2.39.5


