Return-Path: <cgroups+bounces-8137-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A86AB2F81
	for <lists+cgroups@lfdr.de>; Mon, 12 May 2025 08:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77F60189A69D
	for <lists+cgroups@lfdr.de>; Mon, 12 May 2025 06:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE11255251;
	Mon, 12 May 2025 06:21:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86282550C4
	for <cgroups@vger.kernel.org>; Mon, 12 May 2025 06:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747030865; cv=none; b=BDTCULYQJxTh4NJ+wGm/VuGDZ+5H9g7OK+Fgw4tiiWkZ50d0pimhCUBelvKjp8QZ7DkJ/HjSDtgHB/OorWuNQIYNyATVBcpMYetjG0lOeCnp5LrOqSSIbJaSqqY8/q8cEIPSAxkSoRmtJop/gxdkL9f3pGS+foYVvWIsM0LTqwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747030865; c=relaxed/simple;
	bh=29S2t/KimgqnemCE7Wl0zt7lxgF0ycoQyGUa6S2iKgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=asVhI/0y5fBdsHn09FRHYKjlhRgOn1f/zbLb81W/HQ6IjCFW8QMzrU6zMnRp9Xh1/uOKiFdcMVKIjQVkPJ51DPhOGiFkvxPHClNgygylmcsqEB3R/Ku6NoRcdgld5NA2VWmEKwWiQ/qEjhZgPPFQnafbBUBV4hOBpCJ6gHWxulc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-eWFOCJYqNxKQz7p6cI5-Zg-1; Mon,
 12 May 2025 02:19:42 -0400
X-MC-Unique: eWFOCJYqNxKQz7p6cI5-Zg-1
X-Mimecast-MFC-AGG-ID: eWFOCJYqNxKQz7p6cI5-Zg_1747030781
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACEBE1800446;
	Mon, 12 May 2025 06:19:40 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.64.136.70])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6EBF019560B0;
	Mon, 12 May 2025 06:19:35 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: dri-devel@lists.freedesktop.org,
	tj@kernel.org,
	christian.koenig@amd.com,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Cc: cgroups@vger.kernel.org,
	Waiman Long <longman@redhat.com>,
	simona@ffwll.ch
Subject: [PATCH 3/7] memcg: add GPU statistic
Date: Mon, 12 May 2025 16:12:09 +1000
Message-ID: <20250512061913.3522902-4-airlied@gmail.com>
In-Reply-To: <20250512061913.3522902-1-airlied@gmail.com>
References: <20250512061913.3522902-1-airlied@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _HPjpP_vL0I8KHjNVPXflMZFdfzRNVdSwwG0-qwtblE_1747030781
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true

From: Dave Airlie <airlied@redhat.com>

Discrete and Integrated GPUs can use system RAM instead of
VRAM for all or some allocations. These allocations happen
via drm/ttm subsystem and are currently not accounted for
in cgroups.

Add a gpu statistic to allow a place to visualise allocations
once they are supported.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 3 +++
 include/linux/memcontrol.h              | 1 +
 mm/memcontrol.c                         | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-=
guide/cgroup-v2.rst
index 1a16ce68a4d7..e10a1dfa6051 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1480,6 +1480,9 @@ The following nested keys are defined.
 =09  vmalloc (npn)
 =09=09Amount of memory used for vmap backed memory.
=20
+=09  gpu (npn)
+=09=09Amount of memory used for GPU device system RAM.
+
 =09  shmem
 =09=09Amount of cached filesystem data that is swap-backed,
 =09=09such as tmpfs, shm segments, shared anonymous mmap()s
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 53364526d877..4058d4bd94ed 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -36,6 +36,7 @@ enum memcg_stat_item {
 =09MEMCG_SOCK,
 =09MEMCG_PERCPU_B,
 =09MEMCG_VMALLOC,
+=09MEMCG_GPU,
 =09MEMCG_KMEM,
 =09MEMCG_ZSWAP_B,
 =09MEMCG_ZSWAPPED,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c96c1f2b9cf5..25471a0fd0be 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -326,6 +326,7 @@ static const unsigned int memcg_stat_items[] =3D {
 =09MEMCG_SOCK,
 =09MEMCG_PERCPU_B,
 =09MEMCG_VMALLOC,
+=09MEMCG_GPU,
 =09MEMCG_KMEM,
 =09MEMCG_ZSWAP_B,
 =09MEMCG_ZSWAPPED,
@@ -1358,6 +1359,7 @@ static const struct memory_stat memory_stats[] =3D {
 =09{ "percpu",=09=09=09MEMCG_PERCPU_B=09=09=09},
 =09{ "sock",=09=09=09MEMCG_SOCK=09=09=09},
 =09{ "vmalloc",=09=09=09MEMCG_VMALLOC=09=09=09},
+=09{ "gpu",=09=09=09MEMCG_GPU=09=09=09},
 =09{ "shmem",=09=09=09NR_SHMEM=09=09=09},
 #ifdef CONFIG_ZSWAP
 =09{ "zswap",=09=09=09MEMCG_ZSWAP_B=09=09=09},
--=20
2.49.0


