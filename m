Return-Path: <cgroups+bounces-12727-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BC0CDE27D
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 00:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5996F3000E80
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 23:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A773D296159;
	Thu, 25 Dec 2025 23:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T3DbFzf8"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781F7194A76
	for <cgroups@vger.kernel.org>; Thu, 25 Dec 2025 23:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766704887; cv=none; b=N7MkWxQc5/O/ju0eO7VNTUeAaHLAoNHnvkQzO33as1EWbf2GGsrrYlzjSjClJCa1gyC+JebvGO54ICJ8H3zUB0mhFp7nBLiJisjPCNwLjhKAwRW4W9Aa7bWkExoMR4HEW7YW83slxR0AyItv0ltqmJntKWx8zl51q9Mx/f9Sq6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766704887; c=relaxed/simple;
	bh=EnphqNESWtyHt33ASJSDE/h8jfRoTHe8z0CPGJZbDWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o07VSHuSpcVqHmYPMUfZ2b6KGdPauO1j4ke2qmHql58qvV/w8ymjk5N0CUTHLQfRGqRRZfeS+qPNvBJQVePy2YN4IzVsfxaYl+tZUhfNDo5EospmJ6srM2cAovMgaq0unGNco8gkJOuwpyye2TUtSazekWHG7qV+FNhHiNdCev0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T3DbFzf8; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766704882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m0+YWofsDRKAY2wjZda60s9Ihl0H8j0NHCydLBoURug=;
	b=T3DbFzf8WZWoorj9f/pU6jPkPq5wKy1MmWb4lP3AcYeNNbID9uitveOp11zE6SDET7Qp/C
	zOvbd/uWs0Q+ifzX1cOS6jExDNhaDTgv+yOFLikLHtcZS9DXehIgavanWYuwcPELPltyOq
	7aiCehycTAj+UPz9eeoocAffxRFCBKE=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	SeongJae Park <sj@kernel.org>,
	Meta kernel team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] memcg: separate private and public ID namespaces
Date: Thu, 25 Dec 2025 15:21:08 -0800
Message-ID: <20251225232116.294540-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The memory cgroup subsystem maintains a private ID infrastructure that
is decoupled from the cgroup IDs. This private ID system exists because
some kernel objects (like swap entries and shadow entries in the
workingset code) can outlive the cgroup they were associated with.
The motivation is best described in commit 73f576c04b941 ("mm:
memcontrol: fix cgroup creation failure after many small jobs").

Unfortunately, some in-kernel users (DAMON, LRU gen debugfs interface,
shrinker debugfs) started exposing these private IDs to userspace.
This is problematic because:

1. The private IDs are internal implementation details that could change
2. Userspace already has access to cgroup IDs through the cgroup
   filesystem
3. Using different ID namespaces in different interfaces is confusing

This series cleans up the memcg ID infrastructure by:

1. Explicitly marking the private ID APIs with "private" in their names
   to make it clear they are for internal use only (swap/workingset)

2. Making the public cgroup ID APIs (mem_cgroup_id/mem_cgroup_get_from_id)
   unconditionally available

3. Converting DAMON, LRU gen, and shrinker debugfs interfaces to use
   the public cgroup IDs instead of the private IDs

4. Removing the now-unused wrapper functions and renaming the public
   APIs for clarity

After this series:
- mem_cgroup_private_id() / mem_cgroup_from_private_id() are used for
  internal kernel objects that outlive their cgroup (swap, workingset)
- mem_cgroup_id() / mem_cgroup_get_from_id() return the public cgroup ID
  (from cgroup_id()) for use in userspace-facing interfaces

Note: please apply this series after the patch at
https://lore.kernel.org/20251225002904.139543-1-shakeel.butt@linux.dev/

Shakeel Butt (8):
  memcg: introduce private id API for in-kernel users
  memcg: expose mem_cgroup_ino() and mem_cgroup_get_from_ino()
    unconditionally
  memcg: mem_cgroup_get_from_ino() returns NULL on error
  memcg: use cgroup_id() instead of cgroup_ino() for memcg ID
  mm/damon: use cgroup ID instead of private memcg ID
  mm/vmscan: use cgroup ID instead of private memcg ID in lru_gen
    interface
  memcg: remove unused mem_cgroup_id() and mem_cgroup_from_id()
  memcg: rename mem_cgroup_ino() to mem_cgroup_id()

 include/linux/damon.h      |  4 +--
 include/linux/memcontrol.h | 26 +++++++----------
 mm/damon/core.c            |  7 ++---
 mm/damon/sysfs-schemes.c   |  6 ++--
 mm/list_lru.c              |  2 +-
 mm/memcontrol-v1.c         |  6 ++--
 mm/memcontrol-v1.h         |  4 +--
 mm/memcontrol.c            | 60 ++++++++++++++++++--------------------
 mm/shrinker_debug.c        | 13 +++++----
 mm/vmscan.c                | 17 ++++-------
 mm/workingset.c            |  8 ++---
 11 files changed, 68 insertions(+), 85 deletions(-)

--
2.47.3


