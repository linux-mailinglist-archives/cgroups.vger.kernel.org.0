Return-Path: <cgroups+bounces-1298-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99EF84596D
	for <lists+cgroups@lfdr.de>; Thu,  1 Feb 2024 14:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63717281EFD
	for <lists+cgroups@lfdr.de>; Thu,  1 Feb 2024 13:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2E25D460;
	Thu,  1 Feb 2024 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PQLAbFzt";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PQLAbFzt"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2FC5CDD8;
	Thu,  1 Feb 2024 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795847; cv=none; b=F0JP8u3Lf0AlhGI/chX3QyxeDIV3oX/Az84qBJW2ur3uMr5TOMZjuCoCY6bTitooOqSXMIroOzroZ4Ekm9jnvJphrXscXYVqYbY5XHhSZIOfyKVqcSfu6tD7qjQq4WBWLUUYiokCUdeA16I8TgX/K6pQGnKBnlwWdMm6yzMkKro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795847; c=relaxed/simple;
	bh=2m6rRqMt8QCSHWwoNoBeNn1DPvb5rzoixdRUuk/jPJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSrtNyV7C8CqK6gJ0ShPMPjZXfPY1MmOG3XDtgUcg8IRiWnD3ljhM2QhCc72oq/IQ2QTSQCTGFJ1jcMub1l56zA95226+eRQqLhA4cAqOqo3YXssnG45VojXQjLGQBDjmO97dJl06zXhp5s7giZHOL8vLKhJRh3CUNJSbvoyO9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PQLAbFzt; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PQLAbFzt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from blackpad (unknown [10.100.12.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A84E51FB83;
	Thu,  1 Feb 2024 13:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706795843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fst3aRufxJr0rB3Ah1VL5pp6dKU4WyR76KU19pMYREY=;
	b=PQLAbFztYbBgxaasVRpxcOj6DsBbGHYiXm5TRBjWaK9ScDigefcGsrARMWnSdx2QpPan6j
	pZaaihD1N7EDLjec5v/4GL6dVrlk/kpWnCypMcQj3jH8kpdp6b4E0y3VI3UqBfcnQpT0K6
	z++SlRgeush0Y4iV3EH4IF6zUuP7yJI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706795843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fst3aRufxJr0rB3Ah1VL5pp6dKU4WyR76KU19pMYREY=;
	b=PQLAbFztYbBgxaasVRpxcOj6DsBbGHYiXm5TRBjWaK9ScDigefcGsrARMWnSdx2QpPan6j
	pZaaihD1N7EDLjec5v/4GL6dVrlk/kpWnCypMcQj3jH8kpdp6b4E0y3VI3UqBfcnQpT0K6
	z++SlRgeush0Y4iV3EH4IF6zUuP7yJI=
Date: Thu, 1 Feb 2024 14:57:22 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Efly Young <yangyifei03@kuaishou.com>, android-mm@google.com, yuzhao@google.com, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: Use larger chunks for proactive reclaim
Message-ID: <q3m42iuxahsjrskuio3ajz2edrisiw56cwy2etx2jyht5l7jzq@ttbsrvgu4mvl>
References: <20240131162442.3487473-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lz6s2q5edho5n2za"
Content-Disposition: inline
In-Reply-To: <20240131162442.3487473-1-tjmercier@google.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.75 / 50.00];
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
	 BAYES_HAM(-0.05)[59.23%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.75


--lz6s2q5edho5n2za
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Wed, Jan 31, 2024 at 04:24:41PM +0000, "T.J. Mercier" <tjmercier@google.=
com> wrote:
>  		reclaimed =3D try_to_free_mem_cgroup_pages(memcg,
> -					min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
> +					max((nr_to_reclaim - nr_reclaimed) / 4,
> +					    (nr_to_reclaim - nr_reclaimed) % 4),

The 1/4 factor looks like magic.=20

Commit 0388536ac291 says:
| In theory, the amount of reclaimed would be in [request, 2 * request).

Doesn't this suggest 1/2 as a better option? (I didn't pursue the
theory.)

Also IMO importantly, when nr_to_reclaim - nr_reclaimed is less than 8,
the formula gives arbitrary (unrelated to delta's magnitude) values.

Regards,
Michal

--lz6s2q5edho5n2za
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZbujQAAKCRAGvrMr/1gc
jiEnAQCQGBITdwktnX+PB1XMOwtBDaDA8QEg/Imo7oFBWH8AMwEAsK96LQZSYVCP
vXmosthBsfuwtAklzkEeE5PYQsmvKgw=
=hhY/
-----END PGP SIGNATURE-----

--lz6s2q5edho5n2za--

