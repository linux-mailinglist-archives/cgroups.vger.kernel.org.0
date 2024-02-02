Return-Path: <cgroups+bounces-1316-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7398479E0
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 20:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D10C2884AC
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 19:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3973280608;
	Fri,  2 Feb 2024 19:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KZhG4cPm";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KZhG4cPm"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F67980600;
	Fri,  2 Feb 2024 19:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903221; cv=none; b=ESxnsynj6Sm+W+OeU9K5p78afWpO0nyoecum/KUwbJb6R9pxR6MkxZyed00+PIosArmpDeZwRuZmW3C6PzZcJzPsTCRH19ztCJzi8nDiBxzRqpz/umiBsmFbsJx4JL8MzEvsSyFX03xyRhOyeRFvycvwjC+0VJzJ93YIXoJ+IFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903221; c=relaxed/simple;
	bh=/K/q1pAHfeWX2TgaZYj9FVR8OkRJYUi+zBTaXcCAwak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMC0TaWvw72rD4t5iV7EcL520LcHDGADzGS0ZlZgUssi8fSiVdaaXM34W7lMDh0cGNwI5IAOyaHauzIwskc3dYOgiMr+Lm4c7uSlhKMZ8PpdoIxOYvWyrQRQnCXYzvBSl6N8yHLnuyUk/fxPiRIIibqZbPgoeNKQrSrTq5g2ILg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KZhG4cPm; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KZhG4cPm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from blackpad (unknown [10.100.12.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 25C80220CA;
	Fri,  2 Feb 2024 19:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706903217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/K/q1pAHfeWX2TgaZYj9FVR8OkRJYUi+zBTaXcCAwak=;
	b=KZhG4cPm+x8iqhu3SDSqCd1O8OkNf4/Y9/+dkIVjBoo62GL+dcYLip/E0uO21QVnf2GR3H
	FiGOvWS20IQuzbXbQDUA4fVAKl0S4lWQh0IXWx2WpsTKiEBJjrbKJZW16ggJjWRASKc+NC
	3R6Dp5uimqKb8VzZvtytrXR+B/OWCr0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706903217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/K/q1pAHfeWX2TgaZYj9FVR8OkRJYUi+zBTaXcCAwak=;
	b=KZhG4cPm+x8iqhu3SDSqCd1O8OkNf4/Y9/+dkIVjBoo62GL+dcYLip/E0uO21QVnf2GR3H
	FiGOvWS20IQuzbXbQDUA4fVAKl0S4lWQh0IXWx2WpsTKiEBJjrbKJZW16ggJjWRASKc+NC
	3R6Dp5uimqKb8VzZvtytrXR+B/OWCr0=
Date: Fri, 2 Feb 2024 20:46:56 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Efly Young <yangyifei03@kuaishou.com>, hannes@cmpxchg.org, 
	akpm@linux-foundation.org, android-mm@google.com, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, shakeelb@google.com, yuzhao@google.com
Subject: Re: Re: Re: [PATCH] mm: memcg: Use larger chunks for proactive
 reclaim
Message-ID: <bycpbzvo2fpd2qrrl7ipnzrsyun7hg5tjlqouafuosxxlxfml5@vpbl6kl74hx5>
References: <20240201153428.GA307226@cmpxchg.org>
 <20240202050247.45167-1-yangyifei03@kuaishou.com>
 <vofidz4pzybyxoozjrmuqhycm2aji6inp6lkgd3fakyv5jqsjr@pleoj7ljsxhi>
 <CABdmKX2KsxVExVWzysc_fQagGkYWhqRF00KxNxjpVWovHHip+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gwdtcq3kwf5cetlv"
Content-Disposition: inline
In-Reply-To: <CABdmKX2KsxVExVWzysc_fQagGkYWhqRF00KxNxjpVWovHHip+Q@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.88 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[];
	 BAYES_HAM(-0.18)[70.38%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.88


--gwdtcq3kwf5cetlv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 10:22:34AM -0800, "T.J. Mercier" <tjmercier@google.=
com> wrote:
> So all of these should be more or less equivalent:
> delta <=3D SWAP_CLUSTER_MAX ? delta : (delta + 3*SWAP_CLUSTER_MAX) / 4
> max((nr_to_reclaim - nr_reclaimed) / 4, (nr_to_reclaim - nr_reclaimed) % =
4)
> (nr_to_reclaim - nr_reclaimed) / 4 + 4
> (nr_to_reclaim - nr_reclaimed) / 4
>=20
> I was just trying to avoid putting in a 0 for the request size with the m=
od.

The third variant would be simpler then. Modulo looks weird.

Oh, and I just realized that try_to_free_mem_cgroup_pages() does
max(nr_pages, SWAP_CLUSTER_MAX). Then I'd vote for the fourth variant +
possible comment about harmless 0.
(I'm sorry if this was discussed before.)

Michal

--gwdtcq3kwf5cetlv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZb1GrgAKCRAGvrMr/1gc
jpaqAP9PQEKb5U00/7EvIWgO4mSe3xgJFzSEakWK6ZzZcedHxQD7Br+GIkc1yt7s
uBEhvGPzYvygslFDhyZVTQXlOueoaAs=
=ArmI
-----END PGP SIGNATURE-----

--gwdtcq3kwf5cetlv--

