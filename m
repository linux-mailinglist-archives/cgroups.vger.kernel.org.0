Return-Path: <cgroups+bounces-4307-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A65953A43
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 20:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C201F24F2D
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 18:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBF758AC4;
	Thu, 15 Aug 2024 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b="a+ZEVfbf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF2752F9B
	for <cgroups@vger.kernel.org>; Thu, 15 Aug 2024 18:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723747197; cv=none; b=hwQAFJCrNR7VbEI1ZLraRZfOVLqmJ0KaHXWHlmJvzOc6hPZm0lR191ZGYDkRHw9VvCBQvKDHSE51lY0ENS68vd7DNiVOsFGF7vvVf+UhAjZd1TpZDr433E3txSJDfcz/aDUzANODA7HlhFsIpqBl02OS5lzphib6WE76nC1tA4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723747197; c=relaxed/simple;
	bh=TXVokfi93YiRN3veBRcTD+goJTT6xRZmvgpkXC+pWfg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bmixjFKrUr1NWWe2Rp2ipFDPHw+ENftfOUYDTNV//dgj5IxZM356oqpzDI48i2H6jSijEK6Rg5qJAGtbrvFH7klYfjJF/6jV9s9WunZMFov/WkD4yoFo0KlAum6bV4fc8Pg/UTcPj3EdCy3hlLBUNmSLS2OCwljKMdumYICRenQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com; spf=pass smtp.mailfrom=yhndnzj.com; dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b=a+ZEVfbf; arc=none smtp.client-ip=185.70.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yhndnzj.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yhndnzj.com;
	s=protonmail; t=1723747192; x=1724006392;
	bh=TXVokfi93YiRN3veBRcTD+goJTT6xRZmvgpkXC+pWfg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=a+ZEVfbfXmbntLJmkdWufCXeppz8HofpkntvTCp4O9GqXbT9YmGC+k72lXE0iP0aS
	 M2mv3Fqq3hJMahjCWN5Vxz7kG7w+grUAhK5+fYlFPLj2Zjqf2fEk6U+N5nnsG0zfa9
	 QC6v/J/iVXqHiEPpnfRblJBFxcY+s+jaIE2DX52KQjk23dnlr7QO1gwxBOm9d7OKKm
	 awLKLenmLmu8XcUo4MaAWL0TgIBMoFMmGTIkfVB40bIxDDYJMTeW6loC6eB6lsXNKM
	 WR5UXfDrfVElAxmUjgn4vYKhc6TSRP7b3BCoeOSnlfLP1TRk2GYeMk+ug6E/eFUGb7
	 HYy1WDxeAkoyA==
Date: Thu, 15 Aug 2024 18:39:47 +0000
To: Nhat Pham <nphamcs@gmail.com>
From: Mike Yuan <me@yhndnzj.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH] mm/memcontrol: respect zswap.writeback setting from parent cg too
Message-ID: <5a671a9fca4534e499976bbc2b0a380ec496b4c4.camel@yhndnzj.com>
In-Reply-To: <CAKEwX=Nbp40S2o_3gy9K84eWG4bnOxGm9AuAL4aEey22dpibLQ@mail.gmail.com>
References: <20240814171800.23558-1-me@yhndnzj.com> <CAKEwX=NrOBg0rKJnXGaiK9-PWeUDS+c3cFmaFFV0RrE8GkNZZA@mail.gmail.com> <CAKEwX=Nbp40S2o_3gy9K84eWG4bnOxGm9AuAL4aEey22dpibLQ@mail.gmail.com>
Feedback-ID: 102487535:user:proton
X-Pm-Message-ID: ddfed846ca0e506f5b76e3b727c4d784b4daf184
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2024-08-14 at 12:53 -0700, Nhat Pham wrote:
> On Wed, Aug 14, 2024 at 12:52=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wr=
ote:
> >=20
> > On Wed, Aug 14, 2024 at 10:20=E2=80=AFAM Mike Yuan <me@yhndnzj.com> wro=
te:
> >=20
> > May I ask you to add/clarify this new expected behavior in
> > Documentation/admin-guide/cgroup-v2.rst?
>=20
> (and a selftest too, if it's not too much to ask :))

Hmm, I tried to, but the test_zswap_writeback_enabled and
test_zswap_writeback_disabled tests in the current tree already
fail for me... Should I still add new test cases under this
circumstance?


