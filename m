Return-Path: <cgroups+bounces-4920-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BB397DA81
	for <lists+cgroups@lfdr.de>; Sat, 21 Sep 2024 00:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05692837D7
	for <lists+cgroups@lfdr.de>; Fri, 20 Sep 2024 22:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF328185B72;
	Fri, 20 Sep 2024 22:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b="E+tQzJ+d"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2446E2AE
	for <cgroups@vger.kernel.org>; Fri, 20 Sep 2024 22:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726870370; cv=none; b=jmHHcRTCaItKMd0yh7qTJ31y9oy8q2Ipt81zgtWPuZ4VWawWV1RNUwE18TykZnycmbEH0PPiaCC7Y1p4Yf3M662UHl9ixwsoQ22wIQB3uFuQjxkaTm431u+rFzpDwseIMkkzZd+RypmWYLndJL7V1UY1SiaIiFrznWZjyf4pgrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726870370; c=relaxed/simple;
	bh=1mY5Rs5/LQLrxBA8tArkjax8/pz+jUQ8VgqShXxqhCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nun96xtFI8cVc89UnCGKo4OZm1GJgfYHgQw3OkZfha6Fw9YgtwzLSpwgiEx+M4D8JYxHoKZV5fZ2n3HltgHNeBhDsBpVKL6A8EamQw38+ENjNYA4E4sYnSSyNDrD0J31GrYjpDQ74niUdfTYwl1GOBuYvH5iqZhpX7p3rHOKPsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu; spf=pass smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b=E+tQzJ+d; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6c351809a80so17909756d6.1
        for <cgroups@vger.kernel.org>; Fri, 20 Sep 2024 15:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1726870366; x=1727475166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjQIYISgv8bXMzl4SQq6QWJhA5lMgQlc/Hdxb7kdcNw=;
        b=E+tQzJ+dXZTitMA0amLgKUELH+EN5HeygR+50SaxBJmFO/r4Jvhl4CN+4ms4DSFA6Z
         pIGFMpY3ahY00rRAjuNHrKYJlz7zJh3lmWHAMS5uHZ7wp79fxo3NF16nHTsmMH4ZITr1
         CSgrqDy3hMHil1WkWNHUgNGpCFygjOReSTBLdzBRTuTIHYxnmAxWNioFzyOB0PZzsyEg
         4yoiTqZryIRvejaX7rJHEX6+JRIoOphheYlq6gZhhMrLJL0ZhhBz5Ro947ZKXtDj48nh
         FjE69EomM2eFxK82KQbHEAkIyMGIW4dfdBQKSdmjwfqBVNzlBjkph5z8ZZTIjyYoNAB9
         MpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726870366; x=1727475166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjQIYISgv8bXMzl4SQq6QWJhA5lMgQlc/Hdxb7kdcNw=;
        b=TuDCS27wWMYZjevFBDmv95V8uJL2+ez9bJQ8qPnqBe9fG6NhwVcxNi69aH8uFV+b+T
         o+D7lU03elVmqfgsHncDNmjdlfvYt53v1CHIqmpORJgpLzeZcLDNMMYMOQThiQ6sZ2E/
         pyxuQxw1SCr/HIx58HRE3j/zo0hKd6axMT41G6ZaptxLuaI+F5CFDlsMvZvfMOj447+B
         uynDH0lCLCkNnX7thCdAU9jt6E6VOCJoIUCDJ4BQy/WeCVR5gKDseGa8AdnJRnxQY+Hc
         z4vUxSGxa0/dVW2lP7RVsIa1Ey7UwoILz+gaqK459GKq8ngvJQXdnFS9b0971rDa+tPY
         gy3A==
X-Forwarded-Encrypted: i=1; AJvYcCX1Oc/yTp5GfftAk3DidQJLWQbW6Gm6QmVps+UhTKAVsJ/Rn4D6TbgPJWnmXBTLLKVKEL1l48la@vger.kernel.org
X-Gm-Message-State: AOJu0Yxipk5ItGJeVoeub2xX4ecH6WtsqOnnNwh1Ta9GKIRJaoEOT3KM
	gXztjoaO/CJ9G6suHDKCW/TLOCnVrjvr5H6VP2WkMmRk1zfGRfNpT2ChJTfWIQ==
X-Google-Smtp-Source: AGHT+IES2HVe0X98tZeGiUhTQNrbSdJWRIaPaFJBiEj5ef4ucxT4/xboRx0SNgqoj2W0gV0qAMe+fw==
X-Received: by 2002:a0c:fac3:0:b0:6c7:c658:5f40 with SMTP id 6a1803df08f44-6c7c658610bmr26601826d6.14.1726870365846;
        Fri, 20 Sep 2024 15:12:45 -0700 (PDT)
Received: from localhost (pool-74-98-231-160.pitbpa.fios.verizon.net. [74.98.231.160])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6c75e557c01sm22904026d6.101.2024.09.20.15.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 15:12:45 -0700 (PDT)
From: kaiyang2@cs.cmu.edu
To: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Cc: roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	nehagholkar@meta.com,
	abhishekd@meta.com,
	hannes@cmpxchg.org,
	weixugc@google.com,
	rientjes@google.com,
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>
Subject: [RFC PATCH 1/4] Add get_cgroup_local_usage for estimating the top-tier memory usage
Date: Fri, 20 Sep 2024 22:11:48 +0000
Message-ID: <20240920221202.1734227-2-kaiyang2@cs.cmu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920221202.1734227-1-kaiyang2@cs.cmu.edu>
References: <20240920221202.1734227-1-kaiyang2@cs.cmu.edu>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Kaiyang Zhao <kaiyang2@cs.cmu.edu>

Approximate the usage of top-tier memory of a cgroup by its anon,
file, shmem and slab sizes in the top-tier.

Signed-off-by: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
---
 include/linux/memcontrol.h |  2 ++
 mm/memcontrol.c            | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 34d2da05f2f1..94aba4498fca 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -648,6 +648,8 @@ static inline bool mem_cgroup_unprotected(struct mem_cgroup *target,
 		memcg == target;
 }
 
+unsigned long get_cgroup_local_usage(struct mem_cgroup *memcg, bool flush);
+
 static inline bool mem_cgroup_below_low(struct mem_cgroup *target,
 					struct mem_cgroup *memcg)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f19a58c252f0..20b715441332 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -855,6 +855,30 @@ unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
 	return READ_ONCE(memcg->vmstats->events_local[i]);
 }
 
+/* Usage is in pages. */
+unsigned long get_cgroup_local_usage(struct mem_cgroup *memcg, bool flush)
+{
+	struct lruvec *lruvec;
+	const int local_nid = 0;
+
+	if (!memcg)
+		return 0;
+
+	if (flush)
+		mem_cgroup_flush_stats_ratelimited(memcg);
+
+	lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(local_nid));
+	unsigned long anon = lruvec_page_state(lruvec, NR_ANON_MAPPED);
+	unsigned long file = lruvec_page_state(lruvec, NR_FILE_PAGES);
+	unsigned long shmem = lruvec_page_state(lruvec, NR_SHMEM);
+	/* Slab size are in bytes */
+	unsigned long slab =
+		lruvec_page_state(lruvec, NR_SLAB_RECLAIMABLE_B) / PAGE_SIZE
+		+ lruvec_page_state(lruvec, NR_SLAB_UNRECLAIMABLE_B) / PAGE_SIZE;
+
+	return anon + file + shmem + slab;
+}
+
 struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p)
 {
 	/*
-- 
2.43.0


