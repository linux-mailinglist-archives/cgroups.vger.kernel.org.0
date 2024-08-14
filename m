Return-Path: <cgroups+bounces-4265-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184D495242A
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 22:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C332C28A9E2
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 20:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA6A1C68AD;
	Wed, 14 Aug 2024 20:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b="ixyFmKni"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B940A1BE87B;
	Wed, 14 Aug 2024 20:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668197; cv=none; b=F1uGXIAQM8fwNkJTjPWXJXiF0ywNykH6gUu9fnGAI7y1b2sgclT88icOixQbHF8xtgSEDJ/ihCYdtoNLZ2r7YLUlMZIQ3mhAgkIffUPLniPsW5TOIy2hM5iO9aisxAwgGNo13zDE6fR9pctVY7MDmjyfQIy/Z+JcJIiQ/Ykh/2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668197; c=relaxed/simple;
	bh=wOMrogBp49YTG/FcTV+4nAmr5uB92wczucA2j1jKDYY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WuAI/XzQyLx/DOywk/zleyYFWnAZ+JvhJLc455SmTz7P+UpsFabWjaoOmIMYG8EezK9N5na6NMVS2f4ldcP9HoTpbHmSVN96KG9CN4rjeKME+pNBpW/IFjgyLzUt3kj/9V23aOVgO5e1Dobd+LlRrzHC8CyrbkGzpBOXX2x01B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com; spf=pass smtp.mailfrom=yhndnzj.com; dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b=ixyFmKni; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yhndnzj.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yhndnzj.com;
	s=protonmail; t=1723668190; x=1723927390;
	bh=wOMrogBp49YTG/FcTV+4nAmr5uB92wczucA2j1jKDYY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ixyFmKniqxypjGAKbwzbOWnniShM5sGQqu7zYES/X/U3O8ECOJh4H7HJnbr0FjvgH
	 NlAgAug2PyWGSjcBcrH01ZU69mtDPEE4bQlgkpK3YFzlClZL3JuvFKqVXLs5wMCjw/
	 kXGq6d7gS7gjMVoyyrreWXcxF32+Pqe+R0CmO2Pqs4UifjX/kfEbvOMJXtBw7rM2CG
	 PPok2NOqFHmFXaetZazLfPKx/eD8a0bL2TsEaLTtrZyGO8dOaZk0Idy87t6oQDyrwL
	 Cjtpu7VFiVe2qdWTLSrEzxHMhsaVTWGY2r5GdKyWw3jknts+tNKfnRzapaOzHsKB0n
	 yNrTfYrnhkstw==
Date: Wed, 14 Aug 2024 20:43:07 +0000
To: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>
From: Mike Yuan <me@yhndnzj.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm/memcontrol: respect zswap.writeback setting from parent cg too
Message-ID: <a2f67cbcc987cdb2d907f9c133e7fcb6a848992d.camel@yhndnzj.com>
In-Reply-To: <CAJD7tkZ_jNuYQsGMyS1NgMf335Gi4_x5Ybkts_=+g5OyjtJQDQ@mail.gmail.com>
References: <20240814171800.23558-1-me@yhndnzj.com> <CAKEwX=NrOBg0rKJnXGaiK9-PWeUDS+c3cFmaFFV0RrE8GkNZZA@mail.gmail.com> <CAJD7tkZ_jNuYQsGMyS1NgMf335Gi4_x5Ybkts_=+g5OyjtJQDQ@mail.gmail.com>
Feedback-ID: 102487535:user:proton
X-Pm-Message-ID: cedc392e816fb90eb89fe531465e56ebe2b9e7a2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2024-08-14 at 13:22 -0700, Yosry Ahmed wrote:
> On Wed, Aug 14, 2024 at 12:52=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wr=
ote:
> >=20
> > On Wed, Aug 14, 2024 at 10:20=E2=80=AFAM Mike Yuan <me@yhndnzj.com> wro=
te:
> > >=20
> > > Currently, the behavior of zswap.writeback wrt.
> > > the cgroup hierarchy seems a bit odd. Unlike zswap.max,
> > > it doesn't honor the value from parent cgroups. This
> > > surfaced when people tried to globally disable zswap writeback,
> > > i.e. reserve physical swap space only for hibernation [1] -
> > > disabling zswap.writeback only for the root cgroup results
> > > in subcgroups with zswap.writeback=3D1 still performing writeback.
> > >=20
> > > The consistency became more noticeable after I introduced
> > > the MemoryZSwapWriteback=3D systemd unit setting [2] for
> > > controlling the knob. The patch assumed that the kernel would
> > > enforce the value of parent cgroups. It could probably be
> > > workarounded from systemd's side, by going up the slice unit
> > > tree and inherit the value. Yet I think it's more sensible
> > > to make it behave consistently with zswap.max and friends.
> >=20
> > May I ask you to add/clarify this new expected behavior in
> > Documentation/admin-guide/cgroup-v2.rst?
> >=20
> > >=20
> > > [1]
> > > https://wiki.archlinux.org/title/Power_management/Suspend_and_hiberna=
te#Disable_zswap_writeback_to_use_the_swap_space_only_for_hibernation
> >=20
> > This is an interesting use case. Never envisioned this when I
> > developed this feature :)
> >=20
> > > [2] https://github.com/systemd/systemd/pull/31734
> > >=20
> > > Signed-off-by: Mike Yuan <me@yhndnzj.com>
> > > ---
> >=20
> > Personally, I don't feel too strongly about this one way or
> > another. I
> > guess you can make a case that people want to disable zswap
> > writeback
> > by default, and only selectively enable it for certain descendant
> > workloads - for convenience, they would set memory.zswap.writeback
> > =3D=3D
> > 0 at root, then enable it on selected descendants?
> >=20
> > It's not super expensive IMHO - we already perform upward traversal
> > on
> > every zswap store. This wouldn't be the end of the world.
> >=20
> > Yosry, Johannes - how do you two feel about this?
>=20
> I wasn't CC'd on this, but found it by chance :) I think there is a
> way for the zswap maintainers entry to match any patch that mentions
> "zswap", not just based on files, right?
>=20
> Anyway, both use cases make sense to me, disabling writeback
> system-wide or in an entire subtree, and disabling writeback on the
> root and then selectively enabling it. I am slightly inclined to the
> first one (what this patch does).
>=20
> Considering the hierarchical cgroup knobs work, we usually use the
> most restrictive limit among the ancestors. I guess it ultimately
> depends on how we define "most restrictive". Disabling writeback is
> restrictive in the sense that you don't have access to free some
> zswap
> space to reclaim more memory. OTOH, disabling writeback also means
> that your zswapped memory won't go to disk under memory pressure, so
> in that sense it would be restrictive to force writeback :)
>=20
> Usually, the "default" is the non-restrictive thing, and then you can
> set restrictions that apply to all children (e.g. no limits are set
> by
> default). Since writeback is enabled by default, it seems like the
> restriction would be disabling writeback. Hence, it would make sense
> to inherit zswap disabling (i.e. only writeback if all ancestors
> allow
> it, like this patch does).
>=20

Yeah, I thought about the other way around and reached the same
conclusion.
And there's permission boundary in the mix too - if root disables zswap
writeback for its cgroup, the subcgroups, which could possibly be owned
by other users, should not be able to reenable this.

> What we do today dismisses inheritance completely, so it seems to me
> like it should be changed anyway.
>=20
> I am thinking out loud here, let me know if my reasoning makes sense
> to you.
>=20
> >=20
> > Code looks solid to me - I think the upward tree traversal should
> > be
> > safe, as long as memcg is valid (since memcg holds reference to its
> > parent IIRC).
> >=20



