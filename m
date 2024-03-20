Return-Path: <cgroups+bounces-2075-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332CD88151F
	for <lists+cgroups@lfdr.de>; Wed, 20 Mar 2024 17:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658201C20BDC
	for <lists+cgroups@lfdr.de>; Wed, 20 Mar 2024 16:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840BB53E31;
	Wed, 20 Mar 2024 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fGBL4m1W";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fGBL4m1W"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599CB36137;
	Wed, 20 Mar 2024 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710950544; cv=none; b=Me2TtVi4bXHHwcqbMlMccmD0sShOcu9+Y6Bpx3tg9CFSV+gH+G62NGeuEedpj9wSH/9quFL9M4m8qrjiBbulKaekvLZhgP37pU3+mxgCg0kTBn43U0dN8gxVumVwJgyE33rNoyvxbCiYlm8rzCvRVm3ntR/BCCixLzQ73LDHfDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710950544; c=relaxed/simple;
	bh=H6glnNiNteyT0PFBv4r+swJ3nTIxXdqNrocRKyY4WqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uN/Q61KkNvVv8SIO91tbx77DA/GNaBQ/FLDMkw/i6surE6rCd+zMZJe5NtZ6P5TjGVxDcPRZH9U5Efgqhfo+EA/ga1oam2ACsdV19+T4Ycf5qS8u/XyP1P/HbjzMOfBRFWX6TLEZWnM6aXFlZ3fp4rk1/myKtdTbUhWVXmlo9lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fGBL4m1W; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fGBL4m1W; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from blackpad (unknown [10.100.12.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 428473476E;
	Wed, 20 Mar 2024 16:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710950540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zkFAIj4insiWgehfaGHK9ZeiQ+/idmOfPpkDEXOgMxM=;
	b=fGBL4m1WbxDBjH8NasgS4YdOf8fr3mnzpBS04ti2AwiT7tNwL9venFB8qP4kSiQJDS5RbN
	8Zkj9kYlgwPy5LZCDxI8VjP/ekk75/sWjE7iMC400EG8WEHnyW1b8mwlDGngSgcEbS0jsd
	IzY8unF2Bv/natcgNpHYikrWSBWsSro=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710950540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zkFAIj4insiWgehfaGHK9ZeiQ+/idmOfPpkDEXOgMxM=;
	b=fGBL4m1WbxDBjH8NasgS4YdOf8fr3mnzpBS04ti2AwiT7tNwL9venFB8qP4kSiQJDS5RbN
	8Zkj9kYlgwPy5LZCDxI8VjP/ekk75/sWjE7iMC400EG8WEHnyW1b8mwlDGngSgcEbS0jsd
	IzY8unF2Bv/natcgNpHYikrWSBWsSro=
Date: Wed, 20 Mar 2024 17:02:19 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "Jan Kratochvil (Azul)" <jkratochvil@azul.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v4] cgroup2: New memory.max.effective like cgroup1
 hierarchical_memory_limit
Message-ID: <cah72hewsmrrzyo3tm2eipaw4mrxnncqv4zbbzz35x7ghjxred@lhdtiobg3bjm>
References: <ZcvlhOZ4VBEX9raZ@host1.jankratochvil.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="obcvqv52hinoclhy"
Content-Disposition: inline
In-Reply-To: <ZcvlhOZ4VBEX9raZ@host1.jankratochvil.net>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -5.89
X-Spamd-Result: default: False [-5.89 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.19)[-0.935];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO


--obcvqv52hinoclhy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

I have some advise about patch desription and only nitpick about
implementation.

On Wed, Feb 14, 2024 at 05:56:20AM +0800, "Jan Kratochvil (Azul)" <jkratoch=
vil@azul.com> wrote:
> which are useful for userland to easily and performance-wise find out the
> effective cgroup limits being applied.

I think this is a weak reasoning for in-kernel implementation.
It may be faster but how often do you need to read that limit?

> Otherwise userland has to

Userland is at loss when running inside cgroupns with limited ancestors
out of the cgroupns. Thus I think this is the reason why kernel can
provide such an effective value. (And be subject line of the commit, I
think bringing up cgroup1 is misleading.)

> For cgroup1 it was implemented by:
> 	memcg: show real limit under hierarchy mode
> 	https://github.com/torvalds/linux/commit/fee7b548e6f2bd4bfd03a1a45d3afd5=
93de7d5e9
> 	Date:   Wed Jan 7 18:08:26 2009 -0800

FTR, commits are usually referenced more concisely like
	fee7b548e6f2 ("memcg: show real limit under hierarchy mode")=20
(the document Waiman linked previously has some tips how to get this
=66rom git).

> +static int memory_max_effective_show(struct seq_file *m, void *v)
> +{
> +	unsigned long memory;
> +	struct mem_cgroup *mi;
> +
> +	/* Hierarchical information */
> +	memory =3D PAGE_COUNTER_MAX;
> +	for (mi =3D mem_cgroup_from_seq(m); mi; mi =3D parent_mem_cgroup(mi))
> +		memory =3D min(memory, READ_ONCE(mi->memory.max));

root_mem_cgroup is never charged (thus limited), so you can terminate
the iteration on !mem_cgroup_is_root(mi), one level earlier

> +static int swap_max_effective_show(struct seq_file *m, void *v)
> +{
> +	unsigned long swap;
> +	struct mem_cgroup *mi;
> +
> +	/* Hierarchical information */
> +	swap =3D PAGE_COUNTER_MAX;
> +	for (mi =3D mem_cgroup_from_seq(m); mi; mi =3D parent_mem_cgroup(mi))
> +		swap =3D min(swap, READ_ONCE(mi->swap.max));

ditto

HTH,
Michal

--obcvqv52hinoclhy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZfsIiAAKCRAGvrMr/1gc
jjPaAP0UpgJnAoQuiyGpfv2ygAkpZ8Tv5wAS6zlt3p6Kti91cAEAw4Wb0RH30luT
hhBwGAntr1Pz6mUyND/ds2Ff8CoOGwY=
=Zh6c
-----END PGP SIGNATURE-----

--obcvqv52hinoclhy--

