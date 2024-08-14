Return-Path: <cgroups+bounces-4255-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC58D9520FA
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 19:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615861F2409D
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 17:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019211BBBE4;
	Wed, 14 Aug 2024 17:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b="rX0Hz9+x"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D510C1B9B2D;
	Wed, 14 Aug 2024 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656062; cv=none; b=Q+Yvl+9BIKW5L32TQoyW9kO8SdyXRmJgxCUiWINZvsIZnFoSvwpH/+M6WkmG+D6hbMtzygDANBi4S8six2xi1+mEjv98b4PlIytlqF4dx9UCVJvo20YHAfxTK1ALsuitrtUmwCkQAWPG8+gXC5FeBdByxp+hWTJeq8lSEVEXHe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656062; c=relaxed/simple;
	bh=IgZ7iXb0VplK9LNa2MsWb2FY183hnDcwKBS1+wCHqWU=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=nBM0cdWSyoy0/wQ+TrDgexn7na6LoAbLICUegN5KGFSJOjPKQ9fOLYQicxGVcB/po6OZY2AgUCMLQt+c3Kj27SvFutkPB+QOflCDZ/C/DW2d/XlGlAvG0jZsFutzI1l/gedTRd5RB0p2FP8bsYwBTSSmYju8kkoEygQyaPwqKHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com; spf=pass smtp.mailfrom=yhndnzj.com; dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b=rX0Hz9+x; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yhndnzj.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yhndnzj.com;
	s=protonmail; t=1723656056; x=1723915256;
	bh=IgZ7iXb0VplK9LNa2MsWb2FY183hnDcwKBS1+wCHqWU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=rX0Hz9+xpmgIMUX2RhrFnScChBoAd+veIg6XS7a0ra8P/29v+kwF5Sst8pVelnspP
	 gTV3bmKGNI+6A6DG9Q3YfgfEpmSB+FuW3jCsDxwqf927kgqteRdYmD9Lh7qGDdPqj2
	 YCzOh8qvPHJa/EKDeMu9NSSLWbw0hTkUifMSw6cdOP1amBg7eBgSybrG09xfWc8ir+
	 m75d0ZebHQivD8kuz+X/6t9bsqPUN6AgW6M6kgS+dSbN4VFxeBY7vEGYWzr9t+nhqQ
	 U/AaoQnWum2NzNyEw17V8/y2wHIS1mMd2nC9kRO5trqpVUWNnGZ8ZoEuwckMDZTKWB
	 /vf2P2I9wUunw==
Date: Wed, 14 Aug 2024 17:20:54 +0000
To: linux-kernel@vger.kernel.org
From: Mike Yuan <me@yhndnzj.com>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, Mike Yuan <me@yhndnzj.com>
Subject: [PATCH] mm/memcontrol: respect zswap.writeback setting from parent cg too
Message-ID: <20240814171800.23558-1-me@yhndnzj.com>
Feedback-ID: 102487535:user:proton
X-Pm-Message-ID: 969223f01f1ac371f277dee78cd59a00649796cc
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

The consistency became more noticeable after I introduced
the MemoryZSwapWriteback=3D systemd unit setting [2] for
controlling the knob. The patch assumed that the kernel would
enforce the value of parent cgroups. It could probably be
workarounded from systemd's side, by going up the slice unit
tree and inherit the value. Yet I think it's more sensible
to make it behave consistently with zswap.max and friends.

[1] https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate=
#Disable_zswap_writeback_to_use_the_swap_space_only_for_hibernation
[2] https://github.com/systemd/systemd/pull/31734

Signed-off-by: Mike Yuan <me@yhndnzj.com>
---
 mm/memcontrol.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8f2f1bb18c9c..2dcdaaf358ce 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -8423,7 +8423,14 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *ob=
jcg, size_t size)
 bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
 {
 =09/* if zswap is disabled, do not block pages going to the swapping devic=
e */
-=09return !is_zswap_enabled() || !memcg || READ_ONCE(memcg->zswap_writebac=
k);
+=09if (!is_zswap_enabled())
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
--=20
2.46.0



