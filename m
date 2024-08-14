Return-Path: <cgroups+bounces-4261-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C789E952360
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 22:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A67B1F24915
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 20:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5DF1C5788;
	Wed, 14 Aug 2024 20:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vvo2dAml"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E431C4615
	for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 20:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723667328; cv=none; b=m+SODbF5NujPMqLx/Fu0mOro+SKXHDSlLP7Cn3SPnLgq34jddV5LOs/VB35H5Zw6rgGj78GVQdWs9rH0n6eSl9jLjNECVDGErGnDwsy2KeZCSTFwi5C8WdXT31OtTiPh1H3CJeKH9VZ1NCHpgWQztILKlfbZnno9qLBG1I8y5Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723667328; c=relaxed/simple;
	bh=uHdcF3T3rwDBJ90jLhPxGnFyBYsn6F3Ngqso8pIXwt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jX2SxlN5hPyp2BQW2G2UU+EwVLWcz0yrsC2Iv4aC37AYkzZzhDMXM7WNK/C19kVLwTjBJObQm05PPu4ojvp3Q9b6foU8YoLK7Ijzmc5gqfEo+wsLIwen1Y5gsHPUIBLkk30A7MjE77Bmhv92iQJ7qkYh2zCKHepCww6/f9MmR0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vvo2dAml; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723667324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YuTcvSW9Di06EfL0eDnFgAZS8RJd4NfEvtxJHSVe1sg=;
	b=vvo2dAmlpYSQYHhGtKfIuWJfO+kJhk5WnvGdclU5CU9cDOmn/jsaasYKEFAhDLlCloevd3
	+dExAtypgTNUQ+nNTXmJ/j/EFS1cHLkgaYnmoDiouffshNOgBHAapG+utAWl+Lu5osG6c9
	CWLZZGuJQ1RMm71iqpLzwNABbwK/bLU=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	cgroups@vger.kernel.org
Subject: [PATCH 1/4] memcg: initiate deprecation of v1 tcp accounting
Date: Wed, 14 Aug 2024 13:28:22 -0700
Message-ID: <20240814202825.2694077-2-shakeel.butt@linux.dev>
In-Reply-To: <20240814202825.2694077-1-shakeel.butt@linux.dev>
References: <20240814202825.2694077-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Memcg v1 provides opt-in TCP memory accounting feature. However it is
mostly unused due to its performance impact on the network traffic. In
v2, the TCP memory is accounted in the regular memory usage and is
transparent to the users but they can observe the TCP memory usage
through memcg stats.

Let's initiate the deprecation process of memcg v1's tcp accounting
functionality and add warnings to gather if there are any users and if
there are, collect how they are using it and plan to provide them better
alternative in v2.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 Documentation/admin-guide/cgroup-v1/memory.rst | 8 ++++++++
 mm/memcontrol-v1.c                             | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 9cde26d33843..fb6d3e2a6395 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -105,10 +105,18 @@ Brief summary of control files.
  memory.kmem.max_usage_in_bytes      show max kernel memory usage recorded
 
  memory.kmem.tcp.limit_in_bytes      set/show hard limit for tcp buf memory
+                                     This knob is deprecated and shouldn't be
+                                     used.
  memory.kmem.tcp.usage_in_bytes      show current tcp buf memory allocation
+                                     This knob is deprecated and shouldn't be
+                                     used.
  memory.kmem.tcp.failcnt             show the number of tcp buf memory usage
+                                     This knob is deprecated and shouldn't be
+                                     used.
 				     hits limits
  memory.kmem.tcp.max_usage_in_bytes  show max tcp buf memory usage recorded
+                                     This knob is deprecated and shouldn't be
+                                     used.
 ==================================== ==========================================
 
 1. History
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 9725c731fb21..b8e2ee454eaa 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -2447,6 +2447,9 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
 			ret = 0;
 			break;
 		case _TCP:
+			pr_warn_once("kmem.tcp.limit_in_bytes is deprecated and will be removed. "
+				     "Please report your usecase to linux-mm@kvack.org if you "
+				     "depend on this functionality.\n");
 			ret = memcg_update_tcp_max(memcg, nr_pages);
 			break;
 		}
-- 
2.43.5


