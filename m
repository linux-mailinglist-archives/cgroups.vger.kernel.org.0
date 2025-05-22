Return-Path: <cgroups+bounces-8301-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6F2AC01B8
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 03:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09ED94A81C7
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 01:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC8B1758B;
	Thu, 22 May 2025 01:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHsTVRbF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C394328F1
	for <cgroups@vger.kernel.org>; Thu, 22 May 2025 01:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747877532; cv=none; b=NIvn6JOkcdYMG3nHaOLUPDkxjSIor8bBczVmzYU3Ack7mzzxh2NdgNO1fVhil5ObtLEdbIEbawFiOXCQ4Ld9ng6Q0q/n52K3lUjLcoG5C2koocw3T7tLgH4iq3O2gZFdUJuTovBmiHw2QTRjut5Ht6dPHKlcyjV/3ak7V+aa8NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747877532; c=relaxed/simple;
	bh=MJg6i8ym1+LNojbU3FKVxG3NTEsUpq9GybjE0GZnMHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kygfhF2YfZyMgHBawhBGyrc9k/GsTmM6Wynx5T43OlefgsI/DVxeFrwGKAZoAcRoir7Z5Wj/J1Qj/t1YxZdJ4a2UVQ7wacox0sdBnnT1fZ7AIdN8W9YuCwA4WueMRD/lEI3WokaPes/1WSHNtychJE6LHUrg5y9toGb1ysRtBbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHsTVRbF; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso7242413b3a.2
        for <cgroups@vger.kernel.org>; Wed, 21 May 2025 18:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747877530; x=1748482330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3k8n2WKrIH/cUIa1eGMWikO+qTQpaoon0a5hPuvI7iQ=;
        b=WHsTVRbFNdNte1ohjbLa/VMb4UiZoZvFILUsr9CuxTfzX3/jYU5r1UaCj9rYWKm3SZ
         NoDhNmgnGf0nUL02it8B2TGhALsyS7+h5fCycOUYu+P7jr9lboD1EFyLu5PRkLRhcu1m
         gtOQfG2ir99qmbuLmzM1krZWHCD1fnOKBKU4zTRrmDxgcmvC0lZ+aMoBjre0MSqpZcKs
         2gW2ywQz4Fb2/1w6PuHBt1vHtnx3GtyKXocOTsfEJ5+qyPD7vUT2Mri4GBI6Jj7DB6hK
         dShBeipeQD2dXG5gMVpbDrbu7emxCGm6x9Pmfuf03sXS2sHF5VOpq4i0Fn0Lyc+zqaqp
         i7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747877530; x=1748482330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3k8n2WKrIH/cUIa1eGMWikO+qTQpaoon0a5hPuvI7iQ=;
        b=SEHvox0psidiwalIzw3isVKEtm58HRAUl+RFJVvg0PO19OohYKxseSPWOwmljiu+LF
         wCAQFS5o6jAXts3cBnWLNj8Ru0GZN4ztL5B+c3al2wRnoAoqumGw7RuoyocFJNgoLOIK
         NWq0Cvn3L43+xMetsyfDqahBcM8exzK4Ci/GonGPRi80Km4USM9no4RJFTolgtX0UOXt
         j41wvR+95Y5reLZLCCkZhbAnOqUuV5sf/fXRORa9yrCgsktbYnnP54LsB1yDpK/wIj8Q
         GUxMr8GKSBnHxGQV7bvWtSBpqvNhDh3vLmx5cjTyxGNpw0wOoizNX8SUo/91rRDLaDbH
         7j5g==
X-Forwarded-Encrypted: i=1; AJvYcCW5ixFYfWmXi8QEWH3Lxn7/EWOx3k54pWYai7SD6AipWPnjv0xMNOV4Pnkt1YwXHBZe9ocmhlbE@vger.kernel.org
X-Gm-Message-State: AOJu0YzQuMQR5RZkwq2AEIWguVeKqPLRjKheEMo+nPIuBrzGSjPT8OI3
	jpeUBM9Lxm97ErOCIYyRmqt5JsiZtmXY9x+k0QGUZkO0doNDkWuCdB17
X-Gm-Gg: ASbGncvxAIn077sIXKuYER7pkov0vsSGXFwh+qRvWuA1CAM8lpNypAK493oRAdgKtce
	udODoGfCGPAhDXqUqTg7j+h3F+5jByo+0YWY8HPG0/r+2d5If9BAmzfYrrG6e0ZIx/oK27ywiu4
	T79TKPp5+anw7EKWL2dL6Xe20mMFFnFmjFfd6aufDBAB0+THEi6rU4VdLYfbIXoiex6pESvKYIR
	oiUSGvfkiUCC1Q9PwV+JYbSpkZmVhxevMD6+JfcOKynsPP/Y22Cx8J48OnSkfei6Vdl+FY5mIl/
	Ru/DAVOvAtsX/sJLsezf28zZwR+vVvp/mkWwFqaOeXDPPSRCspxsZZKxw5vCVU3YTksG1cJVFev
	UX1zyIAOMttWywoqv3xhEAu3LRHIjDimkfMdPLQc=
X-Google-Smtp-Source: AGHT+IGTM661qss1rttcNzOQo9j6qrZqGft776dcEyD95S628ibSQad1lP1aPSwNv0WIArTTx7NL9Q==
X-Received: by 2002:a05:6300:218f:b0:204:4573:d853 with SMTP id adf61e73a8af0-2162188b7ccmr33584268637.4.1747877529858;
        Wed, 21 May 2025 18:32:09 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.lan (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b270808b57esm6965582a12.75.2025.05.21.18.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 18:32:09 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: tj@kernel.org,
	klarasmodin@gmail.com,
	shakeel.butt@linux.dev,
	yosryahmed@google.com,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH cgroup/for-6.16] cgroup: avoid per-cpu allocation of size zero rstat cpu locks
Date: Wed, 21 May 2025 18:32:02 -0700
Message-ID: <20250522013202.185523-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subsystem rstat locks are dynamically allocated per-cpu. It was discovered
that a panic can occur during this allocation when the lock size is zero.
This is the case on non-smp systems, since arch_spinlock_t is defined as an
empty struct. Prevent this allocation when !CONFIG_SMP by adding a
pre-processor conditional around the affected block.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
Reported-by: Klara Modin <klarasmodin@gmail.com>
Fixes: 748922dcfabd ("cgroup: use subsystem-specific rstat locks to avoid contention")
---
 kernel/cgroup/rstat.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 7dd396ae3c68..ce4752ab9e09 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -510,11 +510,20 @@ int __init ss_rstat_init(struct cgroup_subsys *ss)
 {
 	int cpu;
 
+#ifdef CONFIG_SMP
+	/*
+	 * On uniprocessor machines, arch_spinlock_t is defined as an empty
+	 * struct. Avoid allocating a size of zero by having this block
+	 * excluded in this case. It's acceptable to leave the subsystem locks
+	 * unitialized since the associated lock functions are no-ops in the
+	 * non-smp case.
+	 */
 	if (ss) {
 		ss->rstat_ss_cpu_lock = alloc_percpu(raw_spinlock_t);
 		if (!ss->rstat_ss_cpu_lock)
 			return -ENOMEM;
 	}
+#endif
 
 	spin_lock_init(ss_rstat_lock(ss));
 	for_each_possible_cpu(cpu)
-- 
2.47.1


