Return-Path: <cgroups+bounces-9274-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7CEB2C275
	for <lists+cgroups@lfdr.de>; Tue, 19 Aug 2025 13:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629001BC6063
	for <lists+cgroups@lfdr.de>; Tue, 19 Aug 2025 11:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD7F335BD7;
	Tue, 19 Aug 2025 11:56:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lankhorst.se (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DBA335BBC;
	Tue, 19 Aug 2025 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604602; cv=none; b=MhIyxWD75rRrXGTLT7wZ/1vgiU+DX7u1auTqbVugd7nR4HXvGQ7d+ylbipOPYNDM/WnPyPrOJzPpr8wg1gmrCt7CcOXziaiA4m5m7nkFOs/+8BKutM73r98bu+1hwD0s86dNwtmcLnLsyfd1+kATM0YWTuXXViedIa/WKsmLns0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604602; c=relaxed/simple;
	bh=GIISownnYtCgjery2+EEV+uJeLjYClQqLzwwUwlCxJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=neX40R6Ei1+dpPNH8SLSBNAN2RiVvOpdJElsdlkid1p3TOH2Tblm3D7Hc0yX8HcznCUDABbTXVCCpTJ7Tt/st2gHos02hVK1UttQcqEL2mtC0v9hGHm5G71FxAYKlNeu21nHZ6mw5Ww9W+K7wec3VeFeAE/gVKCO4my0BE2KMYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
From: Maarten Lankhorst <dev@lankhorst.se>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?=27Thomas=20Hellstr=C3=B6m=27?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <dev@lankhorst.se>,
	Maxime Ripard <mripard@kernel.org>,
	Natalie Vock <natalie.vock@gmx.de>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?=27Michal=20Koutn=C3=BD=27?= <mkoutny@suse.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"'Liam R . Howlett'" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: Michal Hocko <mhocko@suse.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC 0/3] cgroups: Add support for pinned device memory
Date: Tue, 19 Aug 2025 13:49:33 +0200
Message-ID: <20250819114932.597600-5-dev@lankhorst.se>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When exporting dma-bufs to other devices, even when it is allowed to use
move_notify in some drivers, performance will degrade severely when
eviction happens.

A perticular example where this can happen is in a multi-card setup,
where PCI-E peer-to-peer is used to prevent using access to system memory.

If the buffer is evicted to system memory, not only the evicting GPU wher
the buffer resided is affected, but it will also stall the GPU that is
waiting on the buffer.

It also makes sense for long running jobs not to be preempted by having
its buffers evicted, so it will make sense to have the ability to pin
from system memory too.

This is dependant on patches by Dave Airlie, so it's not part of this
series yet. But I'm planning on extending pinning to the memory cgroup
controller in the future to handle this case.

Implementation details:

For each cgroup up until the root cgroup, the 'min' limit is checked
against currently effectively pinned value. If the value will go above
'min', the pinning attempt is rejected.

Pinned memory is handled slightly different and affects calculating
effective min/low values. Pinned memory is subtracted from both,
and needs to be added afterwards when calculating.

This is because increasing the amount of pinned memory, the amount of
free min/low memory decreases for all cgroups that are part of the
hierarchy.

Maarten Lankhorst (3):
  page_counter: Allow for pinning some amount of memory
  cgroup/dmem: Implement pinning device memory
  drm/xe: Add DRM_XE_GEM_CREATE_FLAG_PINNED flag and implementation

 drivers/gpu/drm/xe/xe_bo.c      | 66 +++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_dma_buf.c | 10 +++-
 include/linux/cgroup_dmem.h     |  2 +
 include/linux/page_counter.h    |  8 +++
 include/uapi/drm/xe_drm.h       | 10 +++-
 kernel/cgroup/dmem.c            | 57 ++++++++++++++++++-
 mm/page_counter.c               | 98 ++++++++++++++++++++++++++++++---
 7 files changed, 237 insertions(+), 14 deletions(-)

-- 
2.50.0


