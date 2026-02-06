Return-Path: <cgroups+bounces-13722-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UcFPHi9MhWlw/gMAu9opvQ
	(envelope-from <cgroups+bounces-13722-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 03:04:31 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A8BF91CB
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 03:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9230F300DDD2
	for <lists+cgroups@lfdr.de>; Fri,  6 Feb 2026 02:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F891E9B1A;
	Fri,  6 Feb 2026 02:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NNFkOUfS"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926F62BAF7
	for <cgroups@vger.kernel.org>; Fri,  6 Feb 2026 02:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770343465; cv=none; b=cb07qZFPkAsdYtWOsCv2nYG1fnJQpuNFDvVp7AUkQyGTrTvYbVbxUdnwZg77KdC8yTZwr7hFUnnl1ahDLQc62QLMc3zor6srIgUfiqaF3P7jmYRJYRBWxcCtKsWffwB5rqd0sTybchcCQAdkcTqLvazqGU6+MFUdM5DysA4n67s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770343465; c=relaxed/simple;
	bh=N5f/JJXQeV/JKEH2r9goubdllnd8Ai7KxS7/BidLxAc=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=APwPioArcTQ7K9QO1pbecQ/b0gXMMsF1fINtnJ1xNQien0tUCvNNU8icsFZlqUwT8KEVxdyD3dAJOqP0pOdE+CfoLdIlQMFVc90EPrD+VuUoW/gZ8LiJGOa4Jb/hd4BN1udRvf8nnor5DiIKVgVCCFoFjXxrBi5d62taDv8l+nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NNFkOUfS; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770343462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tQFK9n1X/6XJOHaia/NkQdjYqZ2VqcclwuM3/PMBkl8=;
	b=NNFkOUfS6OjPT6fWDsTe8LgVnn2qNou7cPBmDkWDv7x//qYHO6stl5mJ5r0B4GeKs70HAL
	wzY5Yjx85rWtUN60++ZAzx29NyH3RDJ/3/4Hv3I5GefX+rOYOYVTGk2S7FvteQ5OvypsTi
	kQ+ozs/7Y8wzKp1gzgw9uVuMZ/0S7BE=
Date: Fri, 06 Feb 2026 02:04:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <bc96ed3734ef03d4defc9c3940893eba8beaf0d9@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v1] mm: zswap: add per-memcg stat for incompressible
 pages
To: "Nhat Pham" <nphamcs@gmail.com>
Cc: linux-mm@kvack.org, "Jiayuan Chen" <jiayuan.chen@shopee.com>, "Johannes
 Weiner" <hannes@cmpxchg.org>, "Michal Hocko" <mhocko@kernel.org>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, "Shakeel Butt"
 <shakeel.butt@linux.dev>, "Muchun Song" <muchun.song@linux.dev>, "Yosry
 Ahmed" <yosry.ahmed@linux.dev>, "Chengming Zhou"
 <chengming.zhou@linux.dev>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Nick Terrell" <terrelln@fb.com>, "David Sterba" <dsterba@suse.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, "Chris Li"
 <chrisl@kernel.org>
In-Reply-To: <CAKEwX=PBsuO27n_Vw112Ss2ZCTFqGem8f134cGKbHUQVL0aQ9g@mail.gmail.com>
References: <20260205053013.25134-1-jiayuan.chen@linux.dev>
 <CAKEwX=PMQ1aYWr36XKG7oup3diBXb5vjV=fGZeTmYcx+ebmMtQ@mail.gmail.com>
 <CAKEwX=PBsuO27n_Vw112Ss2ZCTFqGem8f134cGKbHUQVL0aQ9g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13722-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shopee.com:email]
X-Rspamd-Queue-Id: C3A8BF91CB
X-Rspamd-Action: no action

February 6, 2026 at 01:45, "Nhat Pham" <nphamcs@gmail.com mailto:nphamcs@=
gmail.com?to=3D%22Nhat%20Pham%22%20%3Cnphamcs%40gmail.com%3E > wrote:


>=20
>=20On Thu, Feb 5, 2026 at 9:31 AM Nhat Pham <nphamcs@gmail.com> wrote:
>=20
>=20>=20
>=20> On Wed, Feb 4, 2026 at 9:31 PM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
> >=20
>=20>  From: Jiayuan Chen <jiayuan.chen@shopee.com>
> >=20
>=20>  The global zswap_stored_incompressible_pages counter was added in =
commit
> >  dca4437a5861 ("mm/zswap: store <PAGE_SIZE compression failed page as=
-is")
> >  to track how many pages are stored in raw (uncompressed) form in zsw=
ap.
> >  However, in containerized environments, knowing which cgroup is
> >  contributing incompressible pages is essential for effective resourc=
e
> >  management.
> >=20
>=20>  Add a new memcg stat 'zswpraw' to track incompressible pages per c=
group.
> >  This helps administrators and orchestrators to:
> >=20
>=20>  1. Identify workloads that produce incompressible data (e.g., encr=
ypted
> >  data, already-compressed media, random data) and may not benefit fro=
m
> >  zswap.
> >=20
>=20>  2. Make informed decisions about workload placement - moving
> >  incompressible workloads to nodes with larger swap backing devices
> >  rather than relying on zswap.
> >=20
>=20>  3. Debug zswap efficiency issues at the cgroup level without needi=
ng to
> >  correlate global stats with individual cgroups.
> >=20
>=20>  While the compression ratio can be estimated from existing stats
> >  (zswap / zswapped * PAGE_SIZE), this doesn't distinguish between
> >  "uniformly poor compression" and "a few completely incompressible pa=
ges
> >  mixed with highly compressible ones". The zswpraw stat provides dire=
ct
> >  visibility into the latter case.
> >=20
>=20Actually I forgot - can you also update the Documentation:
>=20
>=20Documentation/admin-guide/cgroup-v2.rst
>=20
>=20to include a short description of the new counter? Thanks!
>

Thanks Nhat for the review and Acked-by!

I'll update the documentation and add Chris Li's link to
changelog in v2. Will consider the selftest as a follow-up.

