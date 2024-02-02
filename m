Return-Path: <cgroups+bounces-1311-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4274F846D86
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 11:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6202E1C24731
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 10:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6727A735;
	Fri,  2 Feb 2024 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="t5NptUfm";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KDSpFCd3"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE03604BF;
	Fri,  2 Feb 2024 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706868937; cv=none; b=YAV/dsg6IHclGLuvOGLkpkEua9EH3FYMnPhSoBoFxJl9+dpzq85NPNZIwkyq/dSpkDDdLUvMD22I5HClnuyPV2KdPuEn9KVk5dm2Pf6acOiMA3LVd1Yy4G3x6Dphq2tK93qXcc3lq7xYT1gIWN/8h5Z/jPkt7VfCPCH6xdXgfVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706868937; c=relaxed/simple;
	bh=E3WldveCa94S5WNb2X3oqe4POnlIFKkp9qpQEU3ZUV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhcgJ+/UcOk9RyifyoU9X3wRh1Mqxa9P+h/I3sbewXiDud1FvexxLxQG/o1Fxta4ujG/oTIUlHqf8PNFVC2Xo1E83Pu1bEwNxGdTr4CiNfaMqV+CIIeNsGtHBDWEJRy0KvfF9mYptbjrf1JzFXkospPLexQL2Kplo20WO3w3Oq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=t5NptUfm; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KDSpFCd3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from blackpad (unknown [10.100.12.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 58CFC1F461;
	Fri,  2 Feb 2024 10:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706868933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YG/G98bRsAnGh877wO+CNpr7OSPc876vz8JKWKpu7x8=;
	b=t5NptUfm52ay6TCDiMFIYGgKuDry0bkrabgNwhUrEeWMOj5LMcIhmbfcWOkXw09jBzFxNo
	2RE0ujQRjek0Wf25yAizUoO3EFfBg2uT17S0xdFm/LpeEVl/pBGHb5yGMcFcpl1/wGq2xT
	E+1Nki4QSrgUVEcFS3NUtrkQC1Z1n8s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706868932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YG/G98bRsAnGh877wO+CNpr7OSPc876vz8JKWKpu7x8=;
	b=KDSpFCd3kVc5wqknaVaSk2qJ3647XRbzLNQrQDlg6lV0P6KuX2x1yLYAGp7BlvgfJSVx0a
	0XrVgWj1v3Fe2yFAJHCr16adkisWRbVzkfJCT/BGHbV68XWard5frxgx1f2C7HhDO369SN
	mtCza+wH2LLg7J97GGAnRfviryBcIgU=
Date: Fri, 2 Feb 2024 11:15:31 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Efly Young <yangyifei03@kuaishou.com>
Cc: hannes@cmpxchg.org, akpm@linux-foundation.org, android-mm@google.com, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mhocko@kernel.org, muchun.song@linux.dev, roman.gushchin@linux.dev, 
	shakeelb@google.com, tjmercier@google.com, yuzhao@google.com
Subject: Re: Re: [PATCH] mm: memcg: Use larger chunks for proactive reclaim
Message-ID: <vofidz4pzybyxoozjrmuqhycm2aji6inp6lkgd3fakyv5jqsjr@pleoj7ljsxhi>
References: <20240201153428.GA307226@cmpxchg.org>
 <20240202050247.45167-1-yangyifei03@kuaishou.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i6547u4e3dsdsmiu"
Content-Disposition: inline
In-Reply-To: <20240202050247.45167-1-yangyifei03@kuaishou.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -5.90
X-Spamd-Result: default: False [-5.90 / 50.00];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 SIGNED_PGP(-2.00)[];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-0.998];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[kuaishou.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[]
X-Spam-Flag: NO


--i6547u4e3dsdsmiu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 01:02:47PM +0800, Efly Young <yangyifei03@kuaishou.=
com> wrote:
> > Looking at the code, I'm not quite sure if this can be read this
> > literally. Efly might be able to elaborate, but we do a full loop of
> > all nodes and cgroups in the tree before checking nr_to_reclaimed, and
> > rely on priority level for granularity. So request size and complexity
> > of the cgroup tree play a role. I don't know where the exact factor
> > two would come from.
>=20
> I'm sorry that this conclusion may be arbitrary. It might just only suit
> for my case. In my case, I traced it loop twice every time before checking
> nr_reclaimed, and it reclaimed less than my request size(1G) every time.
> So I think the upper bound is 2 * request. But now it seems that this is
> related to cgroup tree I constucted and my system status and my request
> size(a relatively large chunk). So there are many influencing factors,
> a specific upper bound is not accurate.

Alright, thanks for the background.

> > IMO it's more accurate to phrase it like this:
> >=20
> > Reclaim tries to balance nr_to_reclaim fidelity with fairness across
> > nodes and cgroups over which the pages are spread. As such, the bigger
> > the request, the bigger the absolute overreclaim error. Historic
> > in-kernel users of reclaim have used fixed, small request batches to
> > approach an appropriate reclaim rate over time. When we reclaim a user
> > request of arbitrary size, use decaying batches to manage error while
> > maintaining reasonable throughput.

Hm, decay...
So shouldn't the formula be
  nr_pages =3D delta <=3D SWAP_CLUSTER_MAX ? delta : (delta + 3*SWAP_CLUSTE=
R_MAX) / 4
where
  delta =3D nr_to_reclaim - nr_reclaimed
?
(So that convergence for smaller deltas is same like original- and other
reclaims while conservative factor is applied for effectivity of higher
user requests.)

Thanks,
Michal

--i6547u4e3dsdsmiu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZbzArwAKCRAGvrMr/1gc
jgzbAQCS67JzDKT6wEDM8S72f5VdiKV8t/HeB+VB6/lh57jnsQEAgbHFRm3ydZLW
+QPinqIYWeFg0bd97cxxHhyNjoAmswY=
=64ep
-----END PGP SIGNATURE-----

--i6547u4e3dsdsmiu--

