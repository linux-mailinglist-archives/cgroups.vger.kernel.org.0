Return-Path: <cgroups+bounces-17540-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QmTdLX3bS2odbgEAu9opvQ
	(envelope-from <cgroups+bounces-17540-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 18:44:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E297271373B
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 18:44:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="IiEjoMl/";
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17540-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17540-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7BF131DCB92
	for <lists+cgroups@lfdr.de>; Mon,  6 Jul 2026 14:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E613379EE1;
	Mon,  6 Jul 2026 14:28:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF032329E7E
	for <cgroups@vger.kernel.org>; Mon,  6 Jul 2026 14:28:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348110; cv=none; b=m6DC5VgSYiyZICPiF0WS1VyIQ+puaipKlhGMH9GsShMpJjG/Pe81QwadRqy+Jat1sLoFGxsYNahd8uuD5BDt1lIfwxjSnxze+ooEvz0NiLex+yCfwY9uQqBAv1x/N/YSKhHeeyg5MZ6KVUMJn0FI8Vx+iKG2RN14bQYNX36156k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348110; c=relaxed/simple;
	bh=vZWrmCgooqGaeLMQA0CJMhP9+N3djHYev7afW/QNC5s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R17vJ72Btiwi7NNuq6lIjreX2KigHFOCvRhNc2t1dpaa5fN7sr9jGg8ViLdeV23zY9si4RSmy7YqF2EN1wgW6qKdPB71L30uo2i/ZiB/MnJL8mX1/uC5D4W/2Wvk6P0CU0l1r3ysTerMKKHXXgBwAPK9e6lLgd+DQBAUOOEJWQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IiEjoMl/; arc=none smtp.client-ip=198.175.65.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783348108; x=1814884108;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=vZWrmCgooqGaeLMQA0CJMhP9+N3djHYev7afW/QNC5s=;
  b=IiEjoMl/bwXTQUJUe12HovqzwD7Kxq63mWfl11hE1B2QAauQzJqJnpOq
   44ariqOKeKujwN2iRu5cjt192KfaQO9tBH+Z7E2nw/F66c3EGSjlHF7zE
   MRBSlgnJY9G7vD7aOhJSQH0rROQdJclrsDHHFT1QTPAGUK329lDHU/cL/
   G6HXmB4IRy3wgVN+/oIkxozFVp2GzNAu4kRpoQKFownASxKzu2424SPf7
   3dWRodUOZhyJrEyArUGRfCeBM2uKPCwE4UhU0kT5yxBzeJXQOWNfoQhhz
   01Iot8mWfF8Jkv/pFymmfWTnXYrE0GGYjwSFTqoZQhIbsseSeCM0mgtGG
   w==;
X-CSE-ConnectionGUID: gDmc13RqS0+RH8qJRvnRqg==
X-CSE-MsgGUID: 1hltQxgWTiSI9KQB+fzgVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="87662092"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="87662092"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 07:28:27 -0700
X-CSE-ConnectionGUID: Zf/XojuVTFmI51ZpegllVg==
X-CSE-MsgGUID: 7fDr0dcwSFqbvx5P0d3NwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="251049438"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO [10.245.244.132]) ([10.245.244.132])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 07:28:24 -0700
Message-ID: <c5f38603809c5385d2eb8937762b92c4f56c18f9.camel@linux.intel.com>
Subject: Re: drm/ttm/memcg/lru: enable memcg tracking for ttm, xe and amdgpu
 driver (part 2) (v2).
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, 
	tj@kernel.org, christian.koenig@amd.com, Johannes Weiner
 <hannes@cmpxchg.org>,  Michal Hocko <mhocko@kernel.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, Shakeel Butt	 <shakeel.butt@linux.dev>, Muchun
 Song <muchun.song@linux.dev>
Cc: cgroups@vger.kernel.org, Waiman Long <longman@redhat.com>,
 simona@ffwll.ch, 	intel-xe@lists.freedesktop.org
Date: Mon, 06 Jul 2026 16:28:22 +0200
In-Reply-To: <CAPM=9txKzx6qji23YpY=d6Wrd-se-abZoOmDUW32HCx5YsL0tA@mail.gmail.com>
References: <20260706052330.1110909-1-airlied@gmail.com>
	 <CAPM=9txKzx6qji23YpY=d6Wrd-se-abZoOmDUW32HCx5YsL0tA@mail.gmail.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:airlied@gmail.com,m:dri-devel@lists.freedesktop.org,m:tj@kernel.org,m:christian.koenig@amd.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:longman@redhat.com,m:simona@ffwll.ch,m:intel-xe@lists.freedesktop.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lists.freedesktop.org,kernel.org,amd.com,cmpxchg.org,linux.dev];
	TAGGED_FROM(0.00)[bounces-17540-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER(0.00)[thomas.hellstrom@linux.intel.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,linux.intel.com:from_mime,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E297271373B

On Mon, 2026-07-06 at 17:55 +1000, Dave Airlie wrote:
> On Mon, 6 Jul 2026 at 15:23, Dave Airlie <airlied@gmail.com> wrote:
> >=20
> > This is just a repost with a number of sashiko identified problems
> > that I fixed.
> >=20
> > I committed the vmstat counters and list lru changes, and they are
> > now in tree.
> >=20
> > This is the remainder of this series. Intel have expressed interest
> > in getting
> > this landed for xe, we can drop the amdgpu changes for now if they
> > can't get
> > across the line.
>=20
> I've put the latest code at
> https://github.com/airlied/linux/tree/ttm-memcg-objcg
>=20
> I've been fixing more sashiko found issues in there before I repost
> in
> a few days.
>=20
> I've reordered things a little in the branch but mostly the same
> code.
>=20
> Dave.

I have a couple of additional patches to this series to ensure shmem
memory allocated as part of shrinking or swapout ends up accounted to
the same cgroup that allocated the TTM memory. It looks like recursive
per-cgroup shrinking is not an issue, since somebody thought about that
already.

>=20
> >=20
> > I've dropped all previous acks/reviews.
> >=20
> > This series adds the memcg counters for GPU active and GPU reclaim
> > to align
> > with the two global vmstats. It adds an accounting flag to TTM
> > alloc/populate,
> > and enables memcg tracking and shrinker support in TTM.
> >=20
> > Then it adds amdgpu and xe support.
> >=20
> > I think for this to land, Christian holds the main objection which
> > I still fail
> > to fully understand beyond it doesn't solve all the problems we
> > ever have had
> > with cgroups and drm, so we shouldn't even bother, and maybe we
> > could do it at
> > the object level, and integrated with dmem, and android cross
> > process accounting,
> > but I still feel this is a good baseline.
> >=20
> > I think this is the right layer to hook this into TTM, where we
> > allocate memory
> > and I think accounting for this memory in a proper way should be
> > done.
> >=20
> > Intel folks (Thomas/Maarten) please review and express concerns as
> > well.

The initial use-case for us is being able to pin rather substantial
amounts of system memory due to potential upcoming hardware features.
While RDMA is using RLIMIT_MEMLOCK for this, that is per process and an
attacker could easily launch a number of processes and pin all of
system memory, so the thing optionally protecting from the DoS is the
memcg limit. So regardless of whether we also account against
RLIMIT_MEMLOCK or not, we need an additional cgroups limit.

Moving forward, there also a need of limiting the amount of allocated
graphics memory only, due to the way certain apps behave when probing
for available memory. :/.

I have unfortunately missed large parts of the memcg vs dmemcg
discussion, but I asked Claude to fish out as much of the essentials as
possible from the mailing lists so I can read up.

Thanks,
Thomas


> >=20
> > Regards,
> > Dave.
> >=20

