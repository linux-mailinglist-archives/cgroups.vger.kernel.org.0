Return-Path: <cgroups+bounces-8243-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EBFABA2F4
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 20:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E95A275DD
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 18:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1CE280305;
	Fri, 16 May 2025 18:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TfLjLWj/"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B40280017
	for <cgroups@vger.kernel.org>; Fri, 16 May 2025 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420371; cv=none; b=V9MQ3LqxiX8VSiMCEFsdfAM2oD71UuDOjlt2qUM8snq5AKmnnsZqYtewdBtWGvcmB2dX2evijhrdF0av2t9p04TnaMkBy3v/0+JfmyNN2XrTb0bINnvaZDrAv0ZBtZSnb7WlysTJGGKGbnXOjWr4ej1OhNbgl+C33fvLtnRy1qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420371; c=relaxed/simple;
	bh=YIcodLdvBBeOnbc5f6aqLHIuwN4mjNqQy193de/5g/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OdXCor6EXBAWJ6ZdbwYilcUpTezFbcLT6i4dDXO04SDGRr8EDedXZY4qZWnNgwa2I3cyeWnlNmfNtX4gfWfmZhUcjkeybOF33zciA9hEK5jUqB1qrGceBinCdJmnoR3ZbxStyMgfVdq1N6LDiR46VWy81w4Oh/XxUxfxf9dfIIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TfLjLWj/; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747420357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3itOgcDfGvCSNJojD1kWLSfTvY0H0Nn9ZZT8m3VXc9E=;
	b=TfLjLWj/hIgCbCVByfp3HZ5c7rlJh1zgJsyfd5tpGiuovYQE+y6a1JLonBjp1468v03wKg
	zRjX7O3l+pI3sx55HwtMFPOp+rsTgTYb+8Cl3fxfOH/apewbzg13tt7+eGptOpe+PJe3ks
	5CWBtbGlYiq0TaNF2+nSrXtjPWU527c=
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
	Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v3 0/5] memcg: nmi-safe kmem charging
Date: Fri, 16 May 2025 11:32:26 -0700
Message-ID: <20250516183231.1615590-1-shakeel.butt@linux.dev>
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

Changes since v2:
- Rearrange in_nmi() check as suggested by Vlastimil
- Fix commit messag of patch 5 as suggested by Vlastimil

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


