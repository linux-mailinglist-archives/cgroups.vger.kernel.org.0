Return-Path: <cgroups+bounces-2994-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A108CE6E8
	for <lists+cgroups@lfdr.de>; Fri, 24 May 2024 16:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815E01F21604
	for <lists+cgroups@lfdr.de>; Fri, 24 May 2024 14:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C200486279;
	Fri, 24 May 2024 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IhnzTzPi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hWHg9Lzb"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B6184FDA;
	Fri, 24 May 2024 14:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716560598; cv=none; b=NKSk/nqVDNTKi1faDQsiMzJlk7ZLw9uurek5pZEdAtbvPMKO/HPkEOS+Eb3YGkw9EDemc89p2Qr8eIyvjmwqxt76uNjbcrGGbRarXqf+Q+7FbFiV/TF2MkdDfte8q3fyz0UvQaMMPnETlD3k2AcLhNeXaAbGG8hKSyP4c8mGaSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716560598; c=relaxed/simple;
	bh=1WDfbdBkGCArUE4CvoXj22bW03A2MJNf6FexRsLDHO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDTJMvY4APl45EL4RKIfmdTInTVneOKEm0vLGToLiVbLTzqMX9SEMMjJr0Rt+9o/w2a3doNwLUjiuCq719hjqZSNcq8Du86qtiN72jmFSD/ej+sd59Dac2eSE1W2lILAsHqFoRqSi5FvihF8Cw4Kc0l+Zw5wo4jEoJsyhJ8Uf6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IhnzTzPi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hWHg9Lzb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ED2DF21FEB;
	Fri, 24 May 2024 14:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716560595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bsgwVRj6aToiY6R32C6MQixIH+b6B+Qw9yA6wfYfC4c=;
	b=IhnzTzPiSVywsfSWOPY8YyzhZFtI5ax9WU5DtLnmxZPQ48HhQ+CItarUfGf4GBkxXQLisf
	Zr/gtTc4qrPBY38/P9HaeODjcFAKW8upHB/orgSSyDYRqxCYR/xnpcYCIFkh+zW1HbIxL/
	cYx3xrwwT/5PM/Bt2YbcKsoHkgGEhUw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716560594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bsgwVRj6aToiY6R32C6MQixIH+b6B+Qw9yA6wfYfC4c=;
	b=hWHg9Lzb0/eVBkIsMbo4nWo/nn3QoLJs75sILsk3JykWBCja4N0E9EY1LRJ3o5c+qSOsk6
	2Tcgm/4jvGtRgNp+cDHS4lWH7WUcmJEvjCfpg/NSyYpbBe46MM5VgedFi8QxL5XQM9+n8E
	R8NGihVkniz3Tgdkw1PwVF8VdVv9PYQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E184513A6B;
	Fri, 24 May 2024 14:23:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2FncNtKiUGa+EAAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Fri, 24 May 2024 14:23:14 +0000
Date: Fri, 24 May 2024 16:23:09 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] cgroup: Fix /proc/cgroups count for v2
Message-ID: <h5xdtfh7dc4rjh74b4cwkpjszro73hfbxzdobwtivyx4hl4hyn@p5lp5h5gzjuj>
References: <20240519174650.559538-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u3go6jexu2jhya5a"
Content-Disposition: inline
In-Reply-To: <20240519174650.559538-1-tjmercier@google.com>
X-Spam-Flag: NO
X-Spam-Score: -5.36
X-Spam-Level: 
X-Spamd-Result: default: False [-5.36 / 50.00];
	BAYES_HAM(-2.46)[97.56%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]


--u3go6jexu2jhya5a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Sun, May 19, 2024 at 05:46:48PM GMT, "T.J. Mercier" <tjmercier@google.co=
m> wrote:
> The number of cgroups using a controller is an important metric since
> kernel memory is used for each cgroup, and some kernel operations scale
> with the number of cgroups for some controllers (memory, io). So users
> have an interest in minimizing/tracking the number of them.

I agree this is good for debugging or quick checks of unified hierarchy
enablement status.

> To deal with num_cgroups being reported as 1 for those utility
> controllers regardless of the number of cgroups that exist and support
> their use,

But '1' is correct number no? Those utility controllers are v1-only and
their single group only exists on (default) root.

> @@ -675,11 +699,19 @@ int proc_cgroupstats_show(struct seq_file *m, void =
*v)
>  	 * cgroup_mutex contention.
>  	 */
> =20
> -	for_each_subsys(ss, i)
> +	for_each_subsys(ss, i) {
> +		int count;
> +
> +		if (!cgroup_on_dfl(&ss->root->cgrp) || is_v2_utility_controller(i))
> +			count =3D atomic_read(&ss->root->nr_cgrps);

I think is_v2_utility_controller(ssid) implies
!cgroup_on_dfl(&ss->root->cgrp). I'd only decide based on the
cgroup_on_dfl() predicate.

> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -2047,6 +2047,8 @@ void init_cgroup_root(struct cgroup_fs_context *ctx)
> =20
>  	INIT_LIST_HEAD_RCU(&root->root_list);
>  	atomic_set(&root->nr_cgrps, 1);
> +	for (int i =3D 0; i < CGROUP_SUBSYS_COUNT; ++i)
> +		atomic_set(&root->nr_css[i], 0);

Strictly not needed, non-dfl roots are kzalloc'd and dfl root is global
variable (zeroed).

HTH,
Michal

--u3go6jexu2jhya5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZlCivgAKCRAGvrMr/1gc
jn5kAP0UpDlq3OnH0BApmPMsVi8dO/Baaa8axaOvCT6ompqJAQD/UtyesfG24KvI
alR0WPXjv2oqy9TCoF6Rt8wKARtd1AI=
=z8YD
-----END PGP SIGNATURE-----

--u3go6jexu2jhya5a--

