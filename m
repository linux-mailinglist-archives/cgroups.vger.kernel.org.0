Return-Path: <cgroups+bounces-4329-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16774954CA7
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2024 16:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F3A91C20E09
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2024 14:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4321BC088;
	Fri, 16 Aug 2024 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b="OfGzmRg7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A69E1E505
	for <cgroups@vger.kernel.org>; Fri, 16 Aug 2024 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819459; cv=none; b=LElIXZ0eKHvi37yUMFIcvghsQXWHlnJhw2ch2U+dRhvcBx/8hzNeAtXqTN/OfRJ51mOHH4PmSwZeminJuvWHZJ5J2n3cZFYlIAEFwHSovHgBF2Dm62bPrfyzQ5EEfucgBXtolsDwTPAE2X5AGZ/FsMymAC1sWywrw7B0xYXzlpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819459; c=relaxed/simple;
	bh=L+O4RdAU/s91Wl7LewhGqsQMpDeaYc6Qxwjw4FFL/60=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Cj/6LwECn30LAT2kt4I67Tci4m9V0RrEJaZn/Y0KYybRN7kR0e/YdHQvrtMDmESSeUsXkSQrs3s5X+OfnxOR4oVxbmI6iSvyYdwwKiuTx6d4fTF55Pb5/XPDMHljTWDsm9uuxOaDh91JADN/wwcHpj63GjMSul2v8SZpt7/0F4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com; spf=pass smtp.mailfrom=yhndnzj.com; dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b=OfGzmRg7; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yhndnzj.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yhndnzj.com;
	s=protonmail; t=1723819453; x=1724078653;
	bh=d31/1askkQWIiO9ejP6OOS7hCzAz8Xh2PnZ0tdJxyps=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=OfGzmRg7R/S8KDBfXeTlcbpe4PtSI81sM7m/uKiFEtMVxactPM2OJef+iv67P6lc8
	 wEniqvP9+c87GFkscBq9ulGOTF6VSWrNsasSSjSMavwtYSL+ZAzSMQg/jq9ffq+uXg
	 ah+by0+3p4FiJy0DGifvCQvEPl7PiOvJUb5KBs6JKrZCpMt0dB0j8678TZz/2UUEcO
	 K5bGhm6/Wukq6Yxwdmde8/1xwdIMrNnz/sZgttxFvdsQZGtNdQbkRGI9r6nHUrPwbo
	 btmllxS1++tGNgFRracVBorrrz+Huk4KM7yr7UAuXMOwR4GaQrbkxCwj4biYsTFzKR
	 GMNLQVVNo3rqQ==
Date: Fri, 16 Aug 2024 14:44:07 +0000
To: linux-kernel@vger.kernel.org
From: Mike Yuan <me@yhndnzj.com>
Cc: Mike Yuan <me@yhndnzj.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>
Subject: [PATCH v2 1/2] mm/memcontrol: respect zswap.writeback setting from parent cg too
Message-ID: <20240816144344.18135-1-me@yhndnzj.com>
Feedback-ID: 102487535:user:proton
X-Pm-Message-ID: 9c7b4dfd44ee35e2926420d9f191edee1ce7950e
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

Changes in v2:
- Actually base on latest tree (is_zswap_enabled() -> zswap_is_enabled())
- Updated Documentation/admin-guide/cgroup-v2.rst to reflect the change

Link to v1: https://lore.kernel.org/linux-kernel/20240814171800.23558-1-me@=
yhndnzj.com/

Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>

Signed-off-by: Mike Yuan <me@yhndnzj.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 5 ++++-
 mm/memcontrol.c                         | 9 ++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-=
guide/cgroup-v2.rst
index 86311c2907cd..80906cea4264 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1719,7 +1719,10 @@ The following nested keys are defined.
   memory.zswap.writeback
 =09A read-write single value file. The default value is "1". The
 =09initial value of the root cgroup is 1, and when a new cgroup is
-=09created, it inherits the current value of its parent.
+=09created, it inherits the current value of its parent. Note that
+=09this setting is hierarchical, i.e. the writeback would be
+=09implicitly disabled for child cgroups if the upper hierarchy
+=09does so.
=20
 =09When this is set to 0, all swapping attempts to swapping devices
 =09are disabled. This included both zswap writebacks, and swapping due
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f29157288b7d..327b2b030639 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5320,7 +5320,14 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *ob=
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

base-commit: d07b43284ab356daf7ec5ae1858a16c1c7b6adab
--=20
2.46.0



