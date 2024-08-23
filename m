Return-Path: <cgroups+bounces-4428-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6A195D34A
	for <lists+cgroups@lfdr.de>; Fri, 23 Aug 2024 18:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C561B2159E
	for <lists+cgroups@lfdr.de>; Fri, 23 Aug 2024 16:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D580C18BB92;
	Fri, 23 Aug 2024 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b="PMK7RTWW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C03118A6DE;
	Fri, 23 Aug 2024 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430440; cv=none; b=H394GRerdnWHcR5eDJl4BD3jcQCDvnn3JahoVY9kBiCZki1y1seFTKtAnA9KIoXN0Me4we1OED3ot4Y1wuL9I+fDS68nsym/iWDiVxQBTnpfiAs1r/pRdP7+fnOMc+x1eLsZitvONn9VJFoHWUNOoatzpDa8TCN1zgpCV8tXnvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430440; c=relaxed/simple;
	bh=ffKM+8huncSUY8KqXLjU/DT6jLHtBI7/F4U3axGJqJI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=CQTF4TP/I7fgn5KKShZd9cc8FGJTkLRQNbQkuq+PmGvYOY4yTsaH0RHI7JuZzbAd70FKKgrTLrVAIG/vZop7FYCl5HxRLT3u87ZkIO9w+0Jn3QHPAIJPUGzyfxskPpv19LKar5vkiOWBXGUIXWlxjFB2NBGk3d1Z6dX4K2xqIyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com; spf=pass smtp.mailfrom=yhndnzj.com; dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b=PMK7RTWW; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yhndnzj.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yhndnzj.com;
	s=protonmail; t=1724430429; x=1724689629;
	bh=7LV5wuij5UHvq2TzSAXYR/Fp+ylFof5gSswrfbA2tBU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=PMK7RTWWQ6HcUw0ixQgF0emg4ra1NhSx9KpxtrQMlLZYDWnFBZy0RQO1CwCmjCMQM
	 OnmXPC9rN66VxdZYrhN3DKTzN4R+aIATv5/e9Y+eA3XhN7o/7n/WUm99K54f0Zro2+
	 n+VEfPQ4vl2CnM4RCh6qFXzfZSJkwrkHfFM46H01QfwvgAPY7GPMn+BMRyzfQR1anh
	 QJtwfmfojLVv+CQ0DKU0Xkf+3/CTbaqJLJP6pygG6H+efzD49m6AfgSu0UjpdvuT+I
	 VwiD9tCmdJVex+RBKf02uM5qASyWyHPvBP38SXprzDIo0iNEc3K29ltQOZ23schN7d
	 zN915e3f1w1Zw==
Date: Fri, 23 Aug 2024 16:27:06 +0000
To: linux-kernel@vger.kernel.org
From: Mike Yuan <me@yhndnzj.com>
Cc: Mike Yuan <me@yhndnzj.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>, =?utf-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, stable@vger.kernel.org
Subject: [PATCH v3 1/3] mm/memcontrol: respect zswap.writeback setting from parent cg too
Message-ID: <20240823162506.12117-1-me@yhndnzj.com>
Feedback-ID: 102487535:user:proton
X-Pm-Message-ID: 1aeab9fed9e0166d41ca57d11d544d5490bc3859
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Currently, the behavior of zswap.writeback wrt.
the cgroup hierarchy seems a bit odd. Unlike zswap.max,
it doesn't honor the value from parent cgroups. This
surfaced when people tried to globally disable zswap writeback,
i.e. reserve physical swap space only for hibernation [1] -
disabling zswap.writeback only for the root cgroup results
in subcgroups with zswap.writeback=3D1 still performing writeback.

The inconsistency became more noticeable after I introduced
the MemoryZSwapWriteback=3D systemd unit setting [2] for
controlling the knob. The patch assumed that the kernel would
enforce the value of parent cgroups. It could probably be
workarounded from systemd's side, by going up the slice unit
tree and inheriting the value. Yet I think it's more sensible
to make it behave consistently with zswap.max and friends.

[1] https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate=
#Disable_zswap_writeback_to_use_the_swap_space_only_for_hibernation
[2] https://github.com/systemd/systemd/pull/31734

Changes in v3:
- Additionally drop inheritance of zswap.writeback setting
  on cgroup creation, which is no longer needed
Link to v2: https://lore.kernel.org/linux-kernel/20240816144344.18135-1-me@=
yhndnzj.com/

Changes in v2:
- Actually base on latest tree (is_zswap_enabled() -> zswap_is_enabled())
- Update Documentation/admin-guide/cgroup-v2.rst to reflect the change
Link to v1: https://lore.kernel.org/linux-kernel/20240814171800.23558-1-me@=
yhndnzj.com/

Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Koutn=C3=BD <mkoutny@suse.com>

Fixes: 501a06fe8e4c ("zswap: memcontrol: implement zswap writeback disablin=
g")
Cc: <stable@vger.kernel.org>

Signed-off-by: Mike Yuan <me@yhndnzj.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  7 ++++---
 mm/memcontrol.c                         | 12 +++++++++---
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-=
guide/cgroup-v2.rst
index 86311c2907cd..95c18bc17083 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1717,9 +1717,10 @@ The following nested keys are defined.
 =09entries fault back in or are written out to disk.
=20
   memory.zswap.writeback
-=09A read-write single value file. The default value is "1". The
-=09initial value of the root cgroup is 1, and when a new cgroup is
-=09created, it inherits the current value of its parent.
+=09A read-write single value file. The default value is "1".
+=09Note that this setting is hierarchical, i.e. the writeback would be
+=09implicitly disabled for child cgroups if the upper hierarchy
+=09does so.
=20
 =09When this is set to 0, all swapping attempts to swapping devices
 =09are disabled. This included both zswap writebacks, and swapping due
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f29157288b7d..d563fb515766 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3613,8 +3613,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *pare=
nt_css)
 =09memcg1_soft_limit_reset(memcg);
 #ifdef CONFIG_ZSWAP
 =09memcg->zswap_max =3D PAGE_COUNTER_MAX;
-=09WRITE_ONCE(memcg->zswap_writeback,
-=09=09!parent || READ_ONCE(parent->zswap_writeback));
+=09WRITE_ONCE(memcg->zswap_writeback, true);
 #endif
 =09page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
 =09if (parent) {
@@ -5320,7 +5319,14 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *ob=
jcg, size_t size)
 bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
 {
 =09/* if zswap is disabled, do not block pages going to the swapping devic=
e */
-=09return !zswap_is_enabled() || !memcg || READ_ONCE(memcg->zswap_writebac=
k);
+=09if (!zswap_is_enabled())
+=09=09return true;
+
+=09for (; memcg; memcg =3D parent_mem_cgroup(memcg))
+=09=09if (!READ_ONCE(memcg->zswap_writeback))
+=09=09=09return false;
+
+=09return true;
 }
=20
 static u64 zswap_current_read(struct cgroup_subsys_state *css,

base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
--=20
2.46.0



