Return-Path: <cgroups+bounces-4276-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69744952522
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 00:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1372D1F22FC7
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 22:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052E8145B05;
	Wed, 14 Aug 2024 22:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k9XxL/qK"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3C513A268
	for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 22:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723672831; cv=none; b=Oen8VvG3lKFm+cV91WG+K+oOimA0wJrFchxqF0voFEK5jQ2OdFbr85VtriXVPqmgbchjSO9/HKBQgxQd/zTHyAp1IdKqKWBehuDDWNopWuNofs/YRPkT7o8Zo4Zr2WcBYxslCgKZ6gKCmahkV0EGZND3QLU+RiYcVGGl08h6RTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723672831; c=relaxed/simple;
	bh=eYlMSthMiGu/5Moa/ziHx0rMfzWpxOnwtFWkMfZn/k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWAaGhn7bu/WQ+AASHRutI0T+CBaEJ2wDVEUb5Q30xb47HDvCm6TSzSCSqLHEjDtzubJ9SuzxZwCI6ON1QC4c/AtRGjuK6dxs87rW8fbcnEjXS/or+tpIRhJX5c8N+3qvPm5RMhJ0BZ25zzz8dxQcM2897VBwkE8cwtgSbRIG+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k9XxL/qK; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723672828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sz+pgwG6Tx1uUhOGcclu4o7yKd27wktU4rb6DA6XtvQ=;
	b=k9XxL/qKt4zG1aGG3dBCyAmd5Sr42RvCEY0LaEM5mhGJOs3iQS7NWyg16PZugFZD70n2/F
	5+lrHgDm6NgICmu3CH9OMHq38yZUFvuCOSBlGCyH6GGhlHYNo2MY4XW3AS6uwM8oVsiXdU
	O58UoLfoOb4+zfQgfOUYIDw3Nw1MyXE=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	"T . J . Mercier" <tjmercier@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	cgroups@vger.kernel.org
Subject: [PATCH v2 1/4] memcg: initiate deprecation of v1 tcp accounting
Date: Wed, 14 Aug 2024 15:00:18 -0700
Message-ID: <20240814220021.3208384-2-shakeel.butt@linux.dev>
In-Reply-To: <20240814220021.3208384-1-shakeel.butt@linux.dev>
References: <20240814220021.3208384-1-shakeel.butt@linux.dev>
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
Reviewed-by: T.J. Mercier <tjmercier@google.com>
---
Changes since v1:
- Fix documentation

 Documentation/admin-guide/cgroup-v1/memory.rst | 8 ++++++++
 mm/memcontrol-v1.c                             | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 9cde26d33843..0114d758beab 100644
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
 				     hits limits
+                                     This knob is deprecated and shouldn't be
+                                     used.
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


