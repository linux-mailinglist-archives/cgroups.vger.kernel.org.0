Return-Path: <cgroups+bounces-5247-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F049AF6AE
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 03:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932B51C217C0
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 01:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D2539AF4;
	Fri, 25 Oct 2024 01:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q3drv2SM"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD0638F97
	for <cgroups@vger.kernel.org>; Fri, 25 Oct 2024 01:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729819411; cv=none; b=Izdl0KGZLE6IDp47klb8Na7nPCNSdvc6TQRgOzsZ6GEuKdylUTwig/a7E3yA6spXExoPfSjAYARpaRK/Mi+NZ5mwlqkU+qzw9XaFRsMX5dLP/e1nneIC1tpI+sMJFyedk/xQBmJHB/ymZOk+MqdqffGrM2Q2SM6OqdqOUhbhM+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729819411; c=relaxed/simple;
	bh=IUPcFU72Wqp5Dg1E9kEYGARjEIt5X7BWuw24f9jFEeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qzF3JZBSvZqp57DjPyWfaDe04TbOojJ6AMQlSwAfnTlYfY22+K57U8g1qcu7j0gsDePpjHX7jiQsIOg5obGwMZ0gFt7pQtrq0b/Eo+0TF/cbLF0b74l9xWjOJCyGZtCZ8F1GlUQ26aIsVp74tEJH8uNycDWmW8piE9idVwdlbW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q3drv2SM; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729819405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C0UraTOk35e4AElBVGDH4f7gupo0690G0MiExShjFXI=;
	b=q3drv2SMSDDq+5iNa1kyRlCdabxBwgswqn/pkL3XoD+0ZmVo4QkCRnAtGljj8xiqdXVZ1k
	SCaryAAwPXlknWjndB6ps+rIOUc2X/xUmbhvRzvV6mAeOMqlqQzR2cejsaP7dgrdbSeYQA
	zGDaXbzCY7Ld+3S2qOGVHP1WR7ma/OY=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v1 0/6] memcg-v1: fully deprecate charge moving
Date: Thu, 24 Oct 2024 18:22:57 -0700
Message-ID: <20241025012304.2473312-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The memcg v1's charge moving feature has been deprecated for almost 2
years and the kernel warns if someone try to use it. This warning has
been backported to all stable kernel and there have not been any report
of the warning or the request to support this feature anymore. Let's
proceed to fully deprecate this feature.

Changes since RFC:
- Writing 0 to memory.move_charge_at_immigrate is allowed.
- Remove the memcg move locking in separate patches.

Shakeel Butt (6):
  memcg-v1: fully deprecate move_charge_at_immigrate
  memcg-v1: remove charge move code
  memcg-v1: no need for memcg locking for dirty tracking
  memcg-v1: no need for memcg locking for writeback tracking
  memcg-v1: no need for memcg locking for MGLRU
  memcg-v1: remove memcg move locking code

 .../admin-guide/cgroup-v1/memory.rst          |  82 +-
 fs/buffer.c                                   |   5 -
 include/linux/memcontrol.h                    |  59 --
 mm/filemap.c                                  |   1 -
 mm/memcontrol-v1.c                            | 958 +-----------------
 mm/memcontrol-v1.h                            |   6 -
 mm/memcontrol.c                               |  14 -
 mm/page-writeback.c                           |  20 +-
 mm/rmap.c                                     |   1 -
 mm/vmscan.c                                   |  11 -
 10 files changed, 8 insertions(+), 1149 deletions(-)

-- 
2.43.5


