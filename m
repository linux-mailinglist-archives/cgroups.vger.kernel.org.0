Return-Path: <cgroups+bounces-9573-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC95B3E75D
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 16:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16111623B3
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 14:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D525A33A025;
	Mon,  1 Sep 2025 14:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gfIWM0WK"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C2A1A08DB;
	Mon,  1 Sep 2025 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737490; cv=none; b=QD0gYE9wJaYjF0lc4jP0EU6Qu1qnKMwsq6ZwkvOPQO0/6leZxkye0kEc/rPa5bwoeq1tnjGZQ1OCjrC65CWf2LE90qlfunGo8FKqh5SpnrNydM/E0jAUodaV+Ti3qX95+PoUpQYkaHnNLLUNWDawjXiQ8l3ZVkhg9ut6toa2BcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737490; c=relaxed/simple;
	bh=WQNkr5EKb/5FuHLMhuxLTbLlrHHNbuV0X7itYDSvCTo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u+0Bz1zQHy4+J33Kxcai7rq4JfSCjo+wq8rGK3kLoF7GZBWaWJ55msQLlQzJZwRh72FGU3AA3H+RkWoXHGURaFIpVGuWoFmR+NEFXNcFJYjENf9finawFOZ9rvfr6cDQVD1T77JtGSUCK4PKw6zjzf6yZoZPvEF8MeXlhc0JNas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gfIWM0WK; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756737489; x=1788273489;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=WQNkr5EKb/5FuHLMhuxLTbLlrHHNbuV0X7itYDSvCTo=;
  b=gfIWM0WKGBtFugoxH1NTQBgp5oI51wkl130/ge4hmCD++bmXe2EkEs8A
   n40ofuPm7eZR+zJTHoeKML1PGEVr6D26TL8MFikJQUYJSjsA4NUo+jhI9
   Ywd5+gdmMY/XUfAqS6mfvDOt1zPOWiyzjTxDDAcIu6zwRlOkdI4TOkcqj
   6VLfXP2PmAdz6Snl/ntXQbVA7pDKmhs74zEJ1dUqo+HGWr756HK0cBoDp
   aQ51YvXX2dvXVb+R8LjwdhUKiZeLZm/4y08jv23DXjFX2HZtE1DO4MhS9
   EW0imoj4FGXB+oocqs/SZVsU0nnoRDtF03bwHqd2htI7mC2zTG+SXH9co
   A==;
X-CSE-ConnectionGUID: LnnCJH8SRdiay1c9pSE/Nw==
X-CSE-MsgGUID: EP95BETnQ2mrq29MveuMGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="76595896"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="76595896"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 07:38:04 -0700
X-CSE-ConnectionGUID: FKyLHvmdRWK5frmJXgJzRQ==
X-CSE-MsgGUID: TmZPTmE/S+a9W82GyBX+0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="170590896"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO [10.245.244.171]) ([10.245.244.171])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 07:37:56 -0700
Message-ID: <3713e6d83421fcf64978927a1cb40fae1e3c7a57.camel@linux.intel.com>
Subject: Re: [RFC 0/3] cgroups: Add support for pinned device memory
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Natalie Vock <natalie.vock@gmx.de>, Maarten Lankhorst
 <dev@lankhorst.se>,  Lucas De Marchi <lucas.demarchi@intel.com>, Rodrigo
 Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,  Simona
 Vetter <simona@ffwll.ch>, Maxime Ripard <mripard@kernel.org>, Tejun Heo
 <tj@kernel.org>, Johannes Weiner	 <hannes@cmpxchg.org>, 'Michal
 =?ISO-8859-1?Q?Koutn=FD=27?= <mkoutny@suse.com>,  Michal Hocko
 <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Shakeel
 Butt	 <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, Andrew
 Morton	 <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "'Liam R . Howlett'"
 <Liam.Howlett@oracle.com>,  Vlastimil Babka	 <vbabka@suse.cz>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan	 <surenb@google.com>, Thomas
 Zimmermann <tzimmermann@suse.de>
Cc: Michal Hocko <mhocko@suse.com>, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Date: Mon, 01 Sep 2025 16:37:51 +0200
In-Reply-To: <25b42c8e-7233-4121-b253-e044e022b327@gmx.de>
References: <20250819114932.597600-5-dev@lankhorst.se>
	 <25b42c8e-7233-4121-b253-e044e022b327@gmx.de>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Mon, 2025-09-01 at 14:45 +0200, Natalie Vock wrote:
> Hi,
>=20
> On 8/19/25 13:49, Maarten Lankhorst wrote:
> > When exporting dma-bufs to other devices, even when it is allowed
> > to use
> > move_notify in some drivers, performance will degrade severely when
> > eviction happens.
> >=20
> > A perticular example where this can happen is in a multi-card
> > setup,
> > where PCI-E peer-to-peer is used to prevent using access to system
> > memory.
> >=20
> > If the buffer is evicted to system memory, not only the evicting
> > GPU wher
> > the buffer resided is affected, but it will also stall the GPU that
> > is
> > waiting on the buffer.
> >=20
> > It also makes sense for long running jobs not to be preempted by
> > having
> > its buffers evicted, so it will make sense to have the ability to
> > pin
> > from system memory too.
> >=20
> > This is dependant on patches by Dave Airlie, so it's not part of
> > this
> > series yet. But I'm planning on extending pinning to the memory
> > cgroup
> > controller in the future to handle this case.
> >=20
> > Implementation details:
> >=20
> > For each cgroup up until the root cgroup, the 'min' limit is
> > checked
> > against currently effectively pinned value. If the value will go
> > above
> > 'min', the pinning attempt is rejected.
>=20
> Why do you want to reject pins in this case? What happens in desktop=20
> usecases (e.g. PRIME buffer sharing)? AFAIU, you kind of need to be
> able=20
> to pin buffers and export them to other devices for that whole thing
> to=20
> work, right? If the user doesn't explicitly set a min value, wouldn't
> the value being zero mean any pins will be rejected (and thus PRIME=20
> would break)?

That's really the point. If an unprivileged malicious process is
allowed to pin arbitrary amounts of memory, thats a DOS vector.

However drivers that allow unlimited pinning today need to take care
when implementing restrictions to avoid regressions. Like perhaps
adding this behind a config option.

That said, IMO dma-buf clients should implement move_notify() whenever
possible to provide an option to avoid pinning unless necessary.

/Thomas



>=20
> If your objective is to prevent pinned buffers from being evicted,=20
> perhaps you could instead make TTM try to avoid evicting pinned
> buffers=20
> and prefer unpinned buffers as long as there are unpinned buffers to=20
> evict? As long as the total amount of pinned memory stays below min,
> no=20
> pinned buffers should get evicted with that either.


>=20
> Best,
> Natalie
>=20
> >=20
> > Pinned memory is handled slightly different and affects calculating
> > effective min/low values. Pinned memory is subtracted from both,
> > and needs to be added afterwards when calculating.
> >=20
> > This is because increasing the amount of pinned memory, the amount
> > of
> > free min/low memory decreases for all cgroups that are part of the
> > hierarchy.
> >=20
> > Maarten Lankhorst (3):
> > =C2=A0=C2=A0 page_counter: Allow for pinning some amount of memory
> > =C2=A0=C2=A0 cgroup/dmem: Implement pinning device memory
> > =C2=A0=C2=A0 drm/xe: Add DRM_XE_GEM_CREATE_FLAG_PINNED flag and
> > implementation
> >=20
> > =C2=A0 drivers/gpu/drm/xe/xe_bo.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 66 ++=
+++++++++++++++++++-
> > =C2=A0 drivers/gpu/drm/xe/xe_dma_buf.c | 10 +++-
> > =C2=A0 include/linux/cgroup_dmem.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +
> > =C2=A0 include/linux/page_counter.h=C2=A0=C2=A0=C2=A0 |=C2=A0 8 +++
> > =C2=A0 include/uapi/drm/xe_drm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
10 +++-
> > =C2=A0 kernel/cgroup/dmem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 57 ++++++++++++++++++-
> > =C2=A0 mm/page_counter.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 98
> > ++++++++++++++++++++++++++++++---
> > =C2=A0 7 files changed, 237 insertions(+), 14 deletions(-)
> >=20
>=20


