Return-Path: <cgroups+bounces-8220-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1DCAB9636
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 08:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE8C1B62E4C
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 06:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5251F4621;
	Fri, 16 May 2025 06:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IS2daRuV"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC8686250
	for <cgroups@vger.kernel.org>; Fri, 16 May 2025 06:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747378179; cv=none; b=rUfUNxcT8UdGFCpJWc8W/w1R0LaOQKhdrzBytow/AkO/shGmRYLpocPb4lZVGWWMXwm8h3m9M7jTGPb0gPUKSsFgv3fKYDuZBHZN3WoG9Sw6RGAK2hvGELP04DPi+6oyDDs0WtIJZhoju0fDSKDfNY5uj20j/tohieoPtkq2Sdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747378179; c=relaxed/simple;
	bh=e8r1SG5uF0AGuIuWMo1sjUPbjjtceKfnrtYwGLiHFFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LyDFy0h2Xvp9CjWeJoBhDTxQqtJOPN4kGnHqZL6rrC4ZGzrQQ/4JdnSBceHOa3jI+o3S3YBtMD/N49XjdxlcIk5+Qc7n2ebRBz6sRFL/QBwS07pYMPRSGulitNiwhONwOmnwsGGfT1mZhroTpq/HVJ8d8E/1kfoN5TXNEF2BetM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IS2daRuV; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747378165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N8MF/1Uk3+uCWuILTHwuEMDSb4CJ6HZopL8JvlOIAxY=;
	b=IS2daRuVt6grSmCBySyYJFrYDTQq2xzVVh98f5j6v/FVRycDKx5zl9i8cYVR7XovQBgeQJ
	NR0bCPZrJHRM/QALkFwoqJpfJpG04xcz9lnChUQojZSNLATLNmKdkaZYT/rJbPHQM+W6rn
	rvC3kucOzu0LVhLIQlnmiWYOvAsKVSU=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Harry Yoo <harry.yoo@oracle.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v2 0/5] memcg: nmi-safe kmem charging
Date: Thu, 15 May 2025 23:49:07 -0700
Message-ID: <20250516064912.1515065-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Users can attached their BPF programs at arbitrary execution points in
the kernel and such BPF programs may run in nmi context. In addition,
these programs can trigger memcg charged kernel allocations in the nmi
context. However memcg charging infra for kernel memory is not equipped
to handle nmi context for all architectures.

This series removes the hurdles to enable kmem charging in the nmi
context for most of the archs. For archs without CONFIG_HAVE_NMI, this
series is a noop. For archs with NMI support and have
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS, the previous work to make memcg
stats re-entrant is sufficient for allowing kmem charging in nmi
context. For archs with NMI support but without
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS and with
ARCH_HAVE_NMI_SAFE_CMPXCHG, this series added infra to support kmem
charging in nmi context. Lastly those archs with NMI support but without
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS and ARCH_HAVE_NMI_SAFE_CMPXCHG,
kmem charging in nmi context is not supported at all.

Mostly used archs have support for CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
and this series should be almost a noop (other than making
memcg_rstat_updated nmi safe) for such archs. 

Changes since v1:
- The main change was to explicitly differentiate between archs which
  have sane NMI support from others and make the series almost a noop
  for such archs. (Suggested by Vlastimil)
- This version very explicitly describes where kmem charging in nmi
  context is supported and where it is not.

Shakeel Butt (5):
  memcg: disable kmem charging in nmi for unsupported arch
  memcg: nmi safe memcg stats for specific archs
  memcg: add nmi-safe update for MEMCG_KMEM
  memcg: nmi-safe slab stats updates
  memcg: make memcg_rstat_updated nmi safe

 include/linux/memcontrol.h |  21 ++++++
 mm/memcontrol.c            | 136 +++++++++++++++++++++++++++++++++----
 2 files changed, 145 insertions(+), 12 deletions(-)

-- 
2.47.1


