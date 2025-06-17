Return-Path: <cgroups+bounces-8570-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 567FCADDCBD
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 21:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B2AD3B335C
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 19:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB9D2EE97B;
	Tue, 17 Jun 2025 19:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IM3o9XfU"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BB32EBBAB
	for <cgroups@vger.kernel.org>; Tue, 17 Jun 2025 19:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750190268; cv=none; b=OkTtffjvszVYBE5z6hEid9K7q/UIjIzq+2FgNr3XCOWvng45JFcyStUDjIGTvesNxmIdYXdkg65DN7FHS8qiPSn+kCmlqE2tDyJXulWkvE18ufiz5m/z8ypRu3+L/KyKWfMBzSCm5I+odGr+hj5/v2CGf6QENrNu2Eexqt+1tm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750190268; c=relaxed/simple;
	bh=C/eAwE2iKVL8/nxhtpTFgtgQt5E1SogTfxONay/0hAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SVorxx99KYAve08YE5jkunYPlpJ14qtmiq9tDTQ/BfAL2Gs1zvRtlWZv4T7dJyM+d1bkIadxEZrClrfP2I86bKajatajVT7r97VB03lLZ0q0+QJqi4JOmRt2o9S8Y8m3o+2pMUZJZL32DXCKf6RG817ulaglx19alvaKbG6lGzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IM3o9XfU; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750190254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=chThj5q3V7f3H1aWStWIZNg3tPJSNout6hvisnuDvdI=;
	b=IM3o9XfUi37VhXYjtKSxKAMuNcFi/hJ+bbR6TOn6gTzawy8KlCCPplZuF56BMgxQ5BRMLR
	orRZElM45luzIkNtlZAvuwUB7sYfadtisqkfoWY0bKHlC6k+mh/onrG5hNk1049oWZvQR/
	KjgDxBXUYnX4DOr0HRjO1bG9M/n3ixw=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v3 0/4] cgroup: nmi safe css_rstat_updated
Date: Tue, 17 Jun 2025 12:57:21 -0700
Message-ID: <20250617195725.1191132-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

BPF programs can run in nmi context and may trigger memcg charged memory
allocation in such context. Recently linux added support to nmi safe
page allocation along with memcg charging of such allocations. However
the kmalloc/slab support and corresponding memcg charging is still
lacking,

To provide nmi safe support for memcg charging for kmalloc/slab
allocations, we need nmi safe memcg stats because for kernel memory
charging and stats happen together. At the moment, memcg charging and
memcg stats are nmi safe and the only thing which is not nmi safe is
adding the cgroup to the per-cpu rstat update tree. i.e.
css_rstat_updated() which this series is doing.

This series made css_rstat_updated by using per-cpu lockless lists whose
node in embedded in individual struct cgroup_subsys_state and the
per-cpu head is placed in struct cgroup_subsys. For rstat users without
cgroup_subsys, a global per-cpu lockless list head is created. The main
challenge to use lockless in this scenario was the potential multiple
inserters from the stacked context i.e. process, softirq, hardirq & nmi,
potentially using the same per-cpu lockless node of a given
cgroup_subsys_state. The normal lockless list does not protect against
such scenario.

The multiple stacked inserters using potentially same lockless node was
resolved by making one of them succeed on reset the lockless node and
the
winner gets to insert the lockless node in the corresponding lockless
list. The losers can assume the lockless list insertion will eventually
succeed and continue their operation.

Changelog since v3:
- Rebased on for-6.17 branch of cgroup tree

Changelog since v2:
- Add more clear explanation in cover letter and in the comment as
  suggested by Andrew, Michal & Tejun.
- Use this_cpu_cmpxchg() instead of try_cmpxchg() as suggested by Tejun.
- Remove the per-cpu ss locks as they are not needed anymore.

Changelog since v1:
- Based on Yosry's suggestion always use llist on the update side and
  create the update tree on flush side

[v1]
https://lore.kernel.org/cgroups/20250429061211.1295443-1-shakeel.butt@linux.dev/

Shakeel Butt (4):
  cgroup: support to enable nmi-safe css_rstat_updated
  cgroup: make css_rstat_updated nmi safe
  cgroup: remove per-cpu per-subsystem locks
  memcg: cgroup: call css_rstat_updated irrespective of in_nmi()

 include/linux/cgroup-defs.h   |  11 +--
 include/trace/events/cgroup.h |  47 ----------
 kernel/cgroup/rstat.c         | 158 ++++++++++++++--------------------
 mm/memcontrol.c               |  10 +--
 4 files changed, 72 insertions(+), 154 deletions(-)

-- 
2.47.1


