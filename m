Return-Path: <cgroups+bounces-5844-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A32219EDD06
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 02:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96469283197
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 01:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9C4537FF;
	Thu, 12 Dec 2024 01:22:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88E01C32;
	Thu, 12 Dec 2024 01:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733966527; cv=none; b=Wjh8S64pt9byiylImN/Q9gw5traI4Z2dEWYFbB3DmvFzaD7qgRLUrEUk2D9YmdL1MKUox2GFYSb/exeY1XLe2wr9k6MPTzTUQfIHrG86thGqVNmAFNiZtXi8AfQQeaNu8CUwFeA4fXg9vK3mQatgeETRIMwH7UOMb4WUkWPQJ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733966527; c=relaxed/simple;
	bh=3pKrhCeOg9qDsfy04RPZL9X/rwaJyhlT/wlJPRJcS0E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r1CNgMu96iBGfSlnV8iLp8NcmJmuA9gMgFq3Xf2OeTNReieZJ+f/lEwAoQHimmD3S6w99+GlvXVcRW7RVr62BBEqYWua1uiNwz5qb0R8U0BJsiCo/7omKYEOplx5N0DowNPAQsQmoLD7ad1ya+Wu3ad/Yw2UqCLpclK5Ml4EX6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tLXt7-000000006RP-1ScK;
	Wed, 11 Dec 2024 20:21:09 -0500
Message-ID: <1764e2fc8cff5b07aa9df1ae90a13986a3949250.camel@surriel.com>
Subject: Re: [PATCH] memcg: allow exiting tasks to write back data to swap
From: Rik van Riel <riel@surriel.com>
To: Balbir Singh <balbirs@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>, Roman Gushchin
 <roman.gushchin@linux.dev>,  Shakeel Butt <shakeel.butt@linux.dev>, Muchun
 Song <muchun.song@linux.dev>, Andrew Morton	 <akpm@linux-foundation.org>,
 cgroups@vger.kernel.org, linux-mm@kvack.org, 	linux-kernel@vger.kernel.org,
 kernel-team@meta.com, Nhat Pham <nphamcs@gmail.com>,  Yosry Ahmed
 <yosryahmed@google.com>
Date: Wed, 11 Dec 2024 20:21:08 -0500
In-Reply-To: <766a28a1-c82b-46fd-b3b0-fe3b6024f462@nvidia.com>
References: <20241211105336.380cb545@fangorn>
	 <766a28a1-c82b-46fd-b3b0-fe3b6024f462@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Thu, 2024-12-12 at 10:15 +1100, Balbir Singh wrote:
> On 12/12/24 02:53, Rik van Riel wrote:
> >=20
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 7b3503d12aaf..03d77e93087e 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5371,6 +5371,15 @@ bool
> > mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
> > =C2=A0	if (!zswap_is_enabled())
> > =C2=A0		return true;
> > =C2=A0
> > +	/*
> > +	 * Always allow exiting tasks to push data to swap. A
> > process in
> > +	 * the middle of exit cannot get OOM killed, but may need
> > to push
> > +	 * uncompressible data to swap in order to get the cgroup
> > memory
> > +	 * use below the limit, and make progress with the exit.
> > +	 */
> > +	if ((current->flags & PF_EXITING) && memcg =3D=3D
> > mem_cgroup_from_task(current))
> > +		return true;
> > +
> > =C2=A0	for (; memcg; memcg =3D parent_mem_cgroup(memcg))
> > =C2=A0		if (!READ_ONCE(memcg->zswap_writeback))
> > =C2=A0			return false;
>=20
> Rik,
>=20
> I am unable to understand the motivation here, so we want=20
> mem_cgroup_zswap_writeback_enabled() to return true, it only
> returns false if a memcg in the hierarchy has zswap_writeback
> set to 0 (false). In my git-grep I can't seem to find how/why
> that may be the case. I can see memcg starts of with the value
> set to true, if CONFIG_ZSWAP is enabled.
>=20
> Your changelog above makes sense, but I am unable to map it to
> the code changes.
>=20

Wait, are you asking about the code that I'm
adding, or about the code that was already
there?

I want to add the code that allows zswap
writeback if the reclaiming task is exiting,
and in the same cgroup as the to be written
back memory.

--=20
All Rights Reversed.

