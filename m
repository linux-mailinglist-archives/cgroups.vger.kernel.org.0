Return-Path: <cgroups+bounces-4919-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1197F97DA80
	for <lists+cgroups@lfdr.de>; Sat, 21 Sep 2024 00:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AA34B2120E
	for <lists+cgroups@lfdr.de>; Fri, 20 Sep 2024 22:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83711607AA;
	Fri, 20 Sep 2024 22:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b="TICJm0lO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0431EA6F
	for <cgroups@vger.kernel.org>; Fri, 20 Sep 2024 22:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726870368; cv=none; b=cacbcR4XSiwTd89jOZbxEIzASSqd9S84HmAPcmadhHwFdB95G67s82UKzL3l3MnKy2ETLvIrDIZtuzKCrGHC2tegCHsdhJJ+I4Fkp+244Ui4h04AkhsKVXxXXbmB+ad4nDyAdw/pnltjIrq61iqADrdwmXxRvmvYxMk9Ta4Ta3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726870368; c=relaxed/simple;
	bh=Kf5X2apj6Toeg3NPz2kzfgmgMdmBdosKVE6T1WhVnZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rneElzvKZf5q48ZyZl9u3M42I+oa1cXeYUxDia79fEyxBHV07OnEYUuZGr0pR2B0G+K9dRldRlmUsKpJs/ePnyYOD8/knOBI4wVRL5oUQci32reNtOgtSA4lUP1ZEOYpcL/h+sWw8pnMYtYWFh9GKVgOaWuqmjXBXeBIwdwiZ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu; spf=pass smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b=TICJm0lO; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a9ad8a7c63so242588585a.3
        for <cgroups@vger.kernel.org>; Fri, 20 Sep 2024 15:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1726870363; x=1727475163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wASTDKPq3o/45wVwQ7skaMGamRiZDMSqqNyMxwwDl/w=;
        b=TICJm0lOpPzCqSiABaABoE8SVgaFrgBL3B22dzkDtkgcFUkW6EhXa4ptDM6wdihE7x
         cunbAYCwiu/5U7sX90AT79lkqq8kYirtH/t4BtUG8Zi7rKEIHGxUBmrOIWZFJanX7LpS
         MGJO6SSJArvYohVp+BQBudiu02wH2y8ChmQbZNR5/nGsV6KoQbkIy/LW6hCL99V+EFQb
         //UNwz0jE9Sp+7oTth33ZBAxLlv7B7XlAVyUeWYpTYIWhye+7SJ9kXejD1A6uTW/SbzN
         Pv2DOthwlQacfx0zo/qqiYfAk1PKuRBu1u9BsMGE6VsVx5eURD0W0xzMXofkbiwk1zke
         E9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726870363; x=1727475163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wASTDKPq3o/45wVwQ7skaMGamRiZDMSqqNyMxwwDl/w=;
        b=YTW5P1P9erwpnDn6Yrd86RX4m1MTLAe6w5C1ytM2LG8WpJ24TUgtQFirccFpZFwb5G
         m/EOzlTAX4wS0qAy7nqNPG4wFy+q8cLDwyxOVuBYhG7ixkiwo1rClKPn3sst/4DpqKOU
         2RARNg0Ifgz4WvijAdZ6hP2PthdB/XxP04z2UY3ba6gKNtxtiglzQLyUNjgRvQ+vKB2p
         55wAz0In3O/GgzTLImzwZk5FmxQIfXPLhxJYte1TLDpiIsXBzk2lqxPrbf8YjadKpLBm
         G8lFuzsBSALAwCXb4DwCmbRBmDr2S5WLqhnVRR70JMnKVPQYRl4FcAJJkQZrxgbvKI0Y
         6xKw==
X-Forwarded-Encrypted: i=1; AJvYcCXqPjtA7MRmi/udI98wxoc5bEkYiKXTbgFtlbTsfObwKzFv6SSvc1TCQIicio5oXUo3bvXdtW/q@vger.kernel.org
X-Gm-Message-State: AOJu0YziHnxVBCsLoky1bfbZ/op6vks1m4QuPvD97uDZiMshuEmNC4Dx
	GnqaXbjuC21E5JV+Zs82LyKlpQFI8Ei18nMasJSTBjEmPD14iEyqiTC/Zgf8kQ==
X-Google-Smtp-Source: AGHT+IFfVO9Gx8kqg/dKinUO4HrZnCrrwzWH5gKkJkJSZqA/KdjnfmoyQgicHWO1RnCR9kAf8lutNQ==
X-Received: by 2002:a05:620a:24d4:b0:7a9:ba9d:d257 with SMTP id af79cd13be357-7acb809d80bmr694624385a.9.1726870363113;
        Fri, 20 Sep 2024 15:12:43 -0700 (PDT)
Received: from localhost (pool-74-98-231-160.pitbpa.fios.verizon.net. [74.98.231.160])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7acb0829f1dsm234142085a.60.2024.09.20.15.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 15:12:42 -0700 (PDT)
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
Subject: [RFC PATCH 0/4] memory tiering fairness by per-cgroup control of promotion and demotion
Date: Fri, 20 Sep 2024 22:11:47 +0000
Message-ID: <20240920221202.1734227-1-kaiyang2@cs.cmu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Kaiyang Zhao <kaiyang2@cs.cmu.edu>

Currently in Linux, there is no concept of fairness in memory tiering. Depending
on the memory usage and access patterns of other colocated applications, an
application cannot be sure of how much memory in which tier it will get, and how
much its performance will suffer or benefit.

Fairness is, however, important in a multi-tenant system. For example, an
application may need to meet a certain tail latency requirement, which can be
difficult to satisfy without x amount of frequently accessed pages in top-tier
memory. Similarly, an application may want to declare a minimum throughput when
running on a system for capacity planning purposes, but without fairness
controls in memory tiering its throughput can fluctuate wildly as other
applications come and go on the system.

In this proposal, we amend the memory.low control in memcg to protect a cgroup’s
memory usage in top-tier memory. A low protection for top-tier memory is scaled
proportionally to the ratio of top-tier memory and total memory on the system.
The protection is then applied to reclaim for top-tier memory. Promotion by NUMA
balancing is also throttled through reduced scanning window when top-tier memory
is contended and the cgroup is over its protection.

Experiments we did with microbenchmarks exhibiting a range of memory access
patterns and memory size confirmed that when top-tier memory is contended, the
system moves towards a stable memory distribution where each cgroup’s memory
usage in local DRAM converges to the protected amounts.

One notable missing part in the patches is determining which NUMA nodes have
top-tier memory; currently they use hardcoded node 0 for top-tier memory and
node 1 for a CPU-less node backed by CXL memory. We’re working on removing
this artifact and correctly applying to top-tier nodes in the system.

Your feedback is greatly appreciated!

Kaiyang Zhao (4):
  Add get_cgroup_local_usage for estimating the top-tier memory usage
  calculate memory.low for the local node and track its usage
  use memory.low local node protection for local node reclaim
  reduce NUMA balancing scan size of cgroups over their local memory.low

 include/linux/memcontrol.h   | 25 ++++++++-----
 include/linux/page_counter.h | 16 ++++++---
 kernel/sched/fair.c          | 54 +++++++++++++++++++++++++---
 mm/hugetlb_cgroup.c          |  4 +--
 mm/memcontrol.c              | 68 ++++++++++++++++++++++++++++++------
 mm/page_counter.c            | 52 +++++++++++++++++++++------
 mm/vmscan.c                  | 19 +++++++---
 7 files changed, 192 insertions(+), 46 deletions(-)

-- 
2.43.0


