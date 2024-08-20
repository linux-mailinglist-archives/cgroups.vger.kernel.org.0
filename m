Return-Path: <cgroups+bounces-4370-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A13749582DC
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 11:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FE38B254C9
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 09:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2DE18C02E;
	Tue, 20 Aug 2024 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b="qcW3ZZOe"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A3E18A952;
	Tue, 20 Aug 2024 09:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146714; cv=none; b=pcgJv/oBzM1gm1cXmra+5SA+phm59YXSDlFBhU+qmFkdYC7Et+YUHdshk3muOzP9QiIryGOotupluSp23prxbeoPDG29HVb3vR55M6E5c85/TLGjO0JKp6fvbfmFwaiGewTDpO8sJOb6h5N1lxDc+XfzRS+e/TvQqkDfXqdofu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146714; c=relaxed/simple;
	bh=aG8Is3bPBXGEjPmskOUz3pigaZCNCWXw8yXDoLVbfRI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fhKxY1kvsX2UeCgbWT+jrRifVpAFz01heR4XeeBqNBJboIojRe8SomTc9e5e3v+/rkqP0H9ycc2XMoReh4KwzmHKTzt6P3Et52+yHP/hRPsZZEwco4wUJcLGmorG6ryIs8JzNJNKSvoToYqlWrfuMTFVwjH3KnvdnVuYZR8remE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com; spf=pass smtp.mailfrom=yhndnzj.com; dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b=qcW3ZZOe; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yhndnzj.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yhndnzj.com;
	s=protonmail; t=1724146702; x=1724405902;
	bh=aG8Is3bPBXGEjPmskOUz3pigaZCNCWXw8yXDoLVbfRI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=qcW3ZZOeCYyr6Kighv5Ee2LVSQuu1oCHSNvPljlIRGCPACT70maY8uA+TgLntLey8
	 ay5Dv3rREFmTdK1NATFjSlQxxvEdN+2tGkDkCBHVmoZlWwgtlneaDB3FD5w7h9RX37
	 QivLLJ7HLEdCaq0FldgnAONUgFIN8LWCsOp/slvTDTNftSBejXhDEnEm+uhfMcBui/
	 auKj4S8i1NZRYDdMzNmY2yxP3xB3wK6SLOa4aVFJ4i6r6U9eBuvanZ18ese/OS/AXL
	 bvuaL9MVXtqWrgT9UGsSxM9Cko5aXnqhSzs2bjjhWxQ9QdZyb7hk0v4H+TMoMGfoSM
	 BDWD8EZvzByMw==
Date: Tue, 20 Aug 2024 09:38:14 +0000
To: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>
From: Mike Yuan <me@yhndnzj.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v2 1/2] mm/memcontrol: respect zswap.writeback setting from parent cg too
Message-ID: <45e2c372f59748262b6e4390dc5548f8ebf6c41a.camel@yhndnzj.com>
In-Reply-To: <CAJD7tkajuiBDV9Hk8Z+f_-f4ZZf81o4CP3LFLVbfZbrvn4RrUA@mail.gmail.com>
References: <20240816144344.18135-1-me@yhndnzj.com> <CAJD7tkajuiBDV9Hk8Z+f_-f4ZZf81o4CP3LFLVbfZbrvn4RrUA@mail.gmail.com>
Feedback-ID: 102487535:user:proton
X-Pm-Message-ID: 40197622d762237332e9e1d1b626e89a528eff27
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2024-08-19 at 12:09 -0700, Yosry Ahmed wrote:
> On Fri, Aug 16, 2024 at 7:44=E2=80=AFAM Mike Yuan <me@yhndnzj.com> wrote:
> >=20
> > Currently, the behavior of zswap.writeback wrt.
> > the cgroup hierarchy seems a bit odd. Unlike zswap.max,
> > it doesn't honor the value from parent cgroups. This
> > surfaced when people tried to globally disable zswap writeback,
> > i.e. reserve physical swap space only for hibernation [1] -
> > disabling zswap.writeback only for the root cgroup results
> > in subcgroups with zswap.writeback=3D1 still performing writeback.
> >=20
> > The inconsistency became more noticeable after I introduced
> > the MemoryZSwapWriteback=3D systemd unit setting [2] for
> > controlling the knob. The patch assumed that the kernel would
> > enforce the value of parent cgroups. It could probably be
> > workarounded from systemd's side, by going up the slice unit
> > tree and inheriting the value. Yet I think it's more sensible
> > to make it behave consistently with zswap.max and friends.
> >=20
> > [1]
> > https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate=
#Disable_zswap_writeback_to_use_the_swap_space_only_for_hibernation
> > [2] https://github.com/systemd/systemd/pull/31734
> >=20
> > Changes in v2:
> > - Actually base on latest tree (is_zswap_enabled() ->
> > zswap_is_enabled())
> > - Updated Documentation/admin-guide/cgroup-v2.rst to reflect the
> > change
> >=20
> > Link to v1:
> > https://lore.kernel.org/linux-kernel/20240814171800.23558-1-me@yhndnzj.=
com/
> >=20
> > Cc: Nhat Pham <nphamcs@gmail.com>
> > Cc: Yosry Ahmed <yosryahmed@google.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> >=20
> > Signed-off-by: Mike Yuan <me@yhndnzj.com>
> > Reviewed-by: Nhat Pham <nphamcs@gmail.com>
>=20
> LGTM,
> Acked-by: Yosry Ahmed <yosryahmed@google.com>
>=20
> > ---
> > =C2=A0Documentation/admin-guide/cgroup-v2.rst | 5 ++++-
> > =C2=A0mm/memcontrol.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 9 ++++++++-
> > =C2=A02 files changed, 12 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst
> > b/Documentation/admin-guide/cgroup-v2.rst
> > index 86311c2907cd..80906cea4264 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1719,7 +1719,10 @@ The following nested keys are defined.
> > =C2=A0=C2=A0 memory.zswap.writeback
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A read-write single value fi=
le. The default value is "1".
> > The
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 initial value of the root cg=
roup is 1, and when a new
> > cgroup is
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 created, it inherits the current =
value of its parent.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 created, it inherits the current =
value of its parent. Note
> > that
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 this setting is hierarchical, i.e=
. the writeback would be
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 implicitly disabled for child cgr=
oups if the upper
> > hierarchy
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 does so.
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 When this is set to 0, all s=
wapping attempts to swapping
> > devices
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 are disabled. This included =
both zswap writebacks, and
> > swapping due
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index f29157288b7d..327b2b030639 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5320,7 +5320,14 @@ void obj_cgroup_uncharge_zswap(struct
> > obj_cgroup *objcg, size_t size)
> > =C2=A0bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* if zswap is disabled, do =
not block pages going to the
> > swapping device */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return !zswap_is_enabled() || !me=
mcg || READ_ONCE(memcg-
> > >zswap_writeback);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!zswap_is_enabled())
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return true;
>=20
> This is orthogonal to this patch, but I just realized that we
> completely ignore memory.zswap_writeback if zswap is disabled. This
> means that if a cgroup has disabled writeback, then zswap is globally
> disabled for some reason, we stop respecting the cgroup knob. I guess
> the rationale could be that we want to help get pages out of zswap as
> much as possible to honor zswap's disablement? Nhat, did I get that
> right?

Hmm, I think the current behavior makes more sense. If zswap is
completely
disabled, it seems intuitive that zswap-related knobs lose their
effect.

> I feel like it's a little bit odd to be honest, but I don't have a
> strong opinion on it. Maybe we should document this behavior better.

But clarify this in the documentation certainly sounds good :)

>=20
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (; memcg; memcg =3D parent_me=
m_cgroup(memcg))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (!READ_ONCE(memcg->zswap_writeback))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return f=
alse;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> > =C2=A0}
> >=20
> > =C2=A0static u64 zswap_current_read(struct cgroup_subsys_state *css,
> >=20
> > base-commit: d07b43284ab356daf7ec5ae1858a16c1c7b6adab
> > --
> > 2.46.0
> >=20
> >=20



