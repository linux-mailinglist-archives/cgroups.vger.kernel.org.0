Return-Path: <cgroups+bounces-8379-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99716AC74AE
	for <lists+cgroups@lfdr.de>; Thu, 29 May 2025 01:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD073B1806
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 23:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B933F268C7F;
	Wed, 28 May 2025 23:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XD9OVMum"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0857A21FF5C
	for <cgroups@vger.kernel.org>; Wed, 28 May 2025 23:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748476312; cv=none; b=CvVvnr160hFgmFOFR5gOP1lLYXYdHtTPG9DMuyC0Sef0v4OuVmGVEm+79/gQCxtkA/h/fVJmuf3fD1y4h5eBczd3bHivhNbA0LXb7hWQwKBXkTrpuPDNDllWuEWC9+U17jzkuHfJ48ZIyKQRs5LN0KqiRZW0SkW9k4eZR60SlLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748476312; c=relaxed/simple;
	bh=PACKAWUlmC0P7LlhjGDnH7LTUmQ4tbYFj06FLngzglU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I+3tVmRjn1sIhGbURuTzKtKFTBS4RD9LmhD6ShT4MiV4eLXq7sk+zxBzcjhk1mUswzfHW+aMC4Rr5n5xmmp7Pegp36Kb44o7bjMZJrdkEgF7GwWzxSDAT1LC/mEFOAPUt2vBUCXddi2YBnmYenuVaKqqIqEQ2z+5EIkKueQrPxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XD9OVMum; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-234b9dfb842so3722805ad.1
        for <cgroups@vger.kernel.org>; Wed, 28 May 2025 16:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748476310; x=1749081110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4niJxmS0ootKGUzahhuAdAALMSmC3wB470M1RCrkQjM=;
        b=XD9OVMum/j3Yl1qgEJgCntm60MfFEketieY2Bo6RN5yZ2OfL4TzMr8ASw7Vz/0hmmN
         vaknuGnkgpaU5jvgO0clW4qGt1UR60avSi1u8ug46mqMSVmCNxvfaTjL4ikQ6Jk7/GOp
         UKRhWaT/wcZcom27JlXJUu57migunrjr70TCKV9cJdzvQLZp78KOznitpwtv1b2R0GBi
         BClxNualRRRImZE5QTSdbpbwPal4ehX6OGaVtjeGLDRioWJWZa1rFX7B4an3m89CKOVV
         D2FzBk5V4QGZ/i/Yo4SCGnoTpUeQhVz1qe6gZ1Z0hVD9hxsh0YOU4LKcfgaEq9jSfEdc
         GOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748476310; x=1749081110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4niJxmS0ootKGUzahhuAdAALMSmC3wB470M1RCrkQjM=;
        b=PSoY3hbaJpxRrpuK9LqC3mBggkAG2upI5bLRR5aRNMuOYdLEFp2ywLPqhxhDX74u77
         ObVCIvYCcglywoeUiOd/Bf7tfdndtWnbrDiwWegW7N8d5iTnIugXxbjqa7ATi1wqdtP/
         4oH3QHeMgbh7RcF0i30RC3k/HzESfceUbD4cFEHidXjNWBpICsFBgDldbsV7lV1an0/9
         UsWNA9H7BL6myQ9yZrW2TmnaiKl9iQfa4bwif0/PoGZKV9oMs83XPm0DxdkwNCa6JYgW
         r5hO85Va775ZNa9qhlQ0w/NFuuD+SYBIRCiWSg3euP1mpiYTlfj1iUovxR0qBOTo4FJH
         7ryA==
X-Gm-Message-State: AOJu0YzbKrPK4QGf+ORSaXMTZVdf3Y/nW6nvdeZm2uFg9yHAlXbdSrV7
	t6/lNBNYO+/FzVRdpdNZgRwJHdi/n0cvXYgIXT3TCJDxlOcmV5HeC01L
X-Gm-Gg: ASbGncv/7gpat2N/K1fhsm5YiwrINrxbbItinDkzwt+nR11s0kSymeP4LNN0ypkAUuK
	3kS0aJa5IrzgirFjyRoMkm60oDZV81fa7p6Ne0lcSKh7+wH4VynlYiWKk4G43MBTSPR6KS0KZ8g
	BeXnFtnTlf9g/6BOcLJJZzsBvW8Tf6LrtQDsooJlDZn4OwlQ37dOfOJ34kBBuvSibm1GLsqCTVt
	fFmE3NWneVoyhTTNGpBJ/NZ0AdH8t25lY5qaMjiAPejDOVhzLJjFjyPD6ISUW1+9s0ppEMPKBFX
	x86OunxeZkIMLqHOa9knJ9eJC7eeYfDFl1nwa3mXSuoTrRqD230oeIg82vt4SBW7OFkN/i7n2QG
	kR1CMuR3rl5GsjFLWzIEYMU0nCwQoICxwWfsOCLA=
X-Google-Smtp-Source: AGHT+IGHnZ8AXxzePEBdlNszlMJ8wJzzd0MfDBfTeGCPn/NtEW8BJslhIEkhWAO4VHRQtvePBBR7cw==
X-Received: by 2002:a17:903:4b0d:b0:234:a734:4aae with SMTP id d9443c01a7336-234a7344b6amr81497735ad.7.1748476310058;
        Wed, 28 May 2025 16:51:50 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.lan (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506d14c63sm1383395ad.241.2025.05.28.16.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 16:51:49 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: tj@kernel.org,
	llong@redhat.com,
	klarasmodin@gmail.com,
	shakeel.butt@linux.dev,
	yosryahmed@google.com,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org
Cc: cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH linus/master] cgroup: adjust criteria for rstat subsystem cpu lock access
Date: Wed, 28 May 2025 16:51:30 -0700
Message-ID: <20250528235130.200966-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously it was found that on uniprocessor machines the size of
raw_spinlock_t could be zero so a pre-processor conditional was used to
avoid the allocation of ss->rstat_ss_cpu_lock. The conditional did not take
into account cases where lock debugging features were enabled. Cover these
cases along with the original non-smp case by explicitly using the size of
size of the lock type as criteria for allocation/access where applicable.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
Fixes: 748922dcfabd "cgroup: use subsystem-specific rstat locks to avoid contention"
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202505281034.7ae1668d-lkp@intel.com
---
 kernel/cgroup/rstat.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index ce4752ab9e09..cbeaa499a96a 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -47,8 +47,20 @@ static spinlock_t *ss_rstat_lock(struct cgroup_subsys *ss)
 
 static raw_spinlock_t *ss_rstat_cpu_lock(struct cgroup_subsys *ss, int cpu)
 {
-	if (ss)
+	if (ss) {
+		/*
+		 * Depending on config, the subsystem per-cpu lock type may be an
+		 * empty struct. In enviromnents where this is the case, allocation
+		 * of this field is not performed in ss_rstat_init(). Avoid a
+		 * cpu-based offset relative to NULL by returning early. When the
+		 * lock type is zero in size, the corresponding lock functions are
+		 * no-ops so passing them NULL is acceptable.
+		 */
+		if (sizeof(*ss->rstat_ss_cpu_lock) == 0)
+			return NULL;
+
 		return per_cpu_ptr(ss->rstat_ss_cpu_lock, cpu);
+	}
 
 	return per_cpu_ptr(&rstat_base_cpu_lock, cpu);
 }
@@ -510,20 +522,15 @@ int __init ss_rstat_init(struct cgroup_subsys *ss)
 {
 	int cpu;
 
-#ifdef CONFIG_SMP
 	/*
-	 * On uniprocessor machines, arch_spinlock_t is defined as an empty
-	 * struct. Avoid allocating a size of zero by having this block
-	 * excluded in this case. It's acceptable to leave the subsystem locks
-	 * unitialized since the associated lock functions are no-ops in the
-	 * non-smp case.
+	 * Depending on config, the subsystem per-cpu lock type may be an empty
+	 * struct. Avoid allocating a size of zero in this case.
 	 */
-	if (ss) {
+	if (ss && sizeof(*ss->rstat_ss_cpu_lock)) {
 		ss->rstat_ss_cpu_lock = alloc_percpu(raw_spinlock_t);
 		if (!ss->rstat_ss_cpu_lock)
 			return -ENOMEM;
 	}
-#endif
 
 	spin_lock_init(ss_rstat_lock(ss));
 	for_each_possible_cpu(cpu)
-- 
2.47.1


