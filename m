Return-Path: <cgroups+bounces-3146-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E777090279E
	for <lists+cgroups@lfdr.de>; Mon, 10 Jun 2024 19:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4FC1F21F7F
	for <lists+cgroups@lfdr.de>; Mon, 10 Jun 2024 17:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82D114535A;
	Mon, 10 Jun 2024 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z1M/GYrl";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IiUfXrmY"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A7077F2F;
	Mon, 10 Jun 2024 17:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718039936; cv=none; b=Q6vk5NQ52PWV4uUPEu6GAvSzWB5hDzMmLKYMzUyR2hYuOJmPvUypPQEOS6aMlw/qyJtXGtf5Jiz3uZkh36aIE5I8/rxpnTzPMg/JZ9wLLvHKEg00/AwZi/Ed2ADZCxxzK4a9TdIFAW6cwRQw/dr8/FlXm3gYR7J8JA6J5Fr5KcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718039936; c=relaxed/simple;
	bh=YPbe293cXp4wyBnBVn8gJciGNlMCnXOyG2JdGgRfpd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ1wSts56UjhKaxD9GImwAYYsstqMIAgwuOWDUt+WQQ4WnFhmbQRyqweeLN9NtORz8W/P9MRQV+zaIKDnMOKgzn7v+V+BWb5z54TtV0N9XtIENBAcPpBPdaRQ3Tc+1xdLoKlEBWko8lc0K39XEaAQUo4ZJwmNa3JqqFT5RnSufU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Z1M/GYrl; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IiUfXrmY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CAD4B21DCE;
	Mon, 10 Jun 2024 17:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718039932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kHNTBGmWI5UU4pjcTxxfF0+a8c0HPOaWXn4XHmPpvTk=;
	b=Z1M/GYrl2RndZumXJTD8bjtRrpy4rAb+dThD/e8tru4g9hPZKVRnOiNavpjzakKVnORHOv
	mJBs+ENX6Aol2QkPdRxtkVc4713Nzmgor6trMd1Eobd7iOdd2xYYHYmB7kncC6Yp9F7FPp
	bH2hnov3NeSWXMT7t0SRY5zeZLFUADs=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=IiUfXrmY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718039931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kHNTBGmWI5UU4pjcTxxfF0+a8c0HPOaWXn4XHmPpvTk=;
	b=IiUfXrmYjAzS90tV1UmbKYkM6puviM0k8GocVwsTmk4jL/ihdGyg62Hespuk3eSt7ZE2gJ
	DhvY9dLNruiv+eq6ykY4DBaRkOFt5I/YyxFA+s80cMPZBRB0pg/dTKMfc5/kN+M0DA5gAg
	bL36frFXF7kG0vC8rivfgoofdl/ro5o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC80413A51;
	Mon, 10 Jun 2024 17:18:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kOCRLXs1Z2Y/dgAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Mon, 10 Jun 2024 17:18:51 +0000
Date: Mon, 10 Jun 2024 19:18:50 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Xavier <ghostxavier@sina.com>
Cc: longman@redhat.com, lizefan.x@bytedance.com, tj@kernel.org, 
	hannes@cmpxchg.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cpuset: use Union-Find to optimize the merging of
 cpumasks
Message-ID: <wu4m2m5igc752s5vrmtsnd7ekaq6opeqdtrzegs7oxlwgypdcx@qhcnow5txxiv>
References: <20240531024837.255293-1-ghostxavier@sina.com>
 <20240603123101.590760-1-ghostxavier@sina.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fekhs4szurscavjp"
Content-Disposition: inline
In-Reply-To: <20240603123101.590760-1-ghostxavier@sina.com>
X-Spam-Flag: NO
X-Spam-Score: -3.42
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CAD4B21DCE
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.42 / 50.00];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	BAYES_HAM(-0.31)[75.36%];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[sina.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_TO(0.00)[sina.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim]


--fekhs4szurscavjp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Mon, Jun 03, 2024 at 08:31:01PM GMT, Xavier <ghostxavier@sina.com> wrote:
> The process of constructing scheduling domains involves multiple loops
> and repeated evaluations, leading to numerous redundant and ineffective
> assessments that impact code efficiency.
>=20
> Here, we use Union-Find to optimize the merging of cpumasks. By employing
> path compression and union by rank, we effectively reduce the number of
> lookups and merge comparisons.

Nice that you found such an application. (As Waiman wrote, the
efficiency is not so important here and it may not be dencreased but I
still think it makes the code more understandable by using standard data
structures.)

Have you looked whether there are other instances of U-F in the kernel?
(My quick search didn't show any.) Still, I think it'd be a good idea to
decouple this into two commits -- 1) implementation of the new U-F (into
lib/), 2) application within cpuset.

> +/*define a union find node struct*/
> +struct uf_node {
> +	int parent;

I think this would be better as `struct uf_node *`.

> +	int rank;
> +};

`unsigned int` if rank cannot be negative?

> +	/* Each node is initially its own parent */
> +	for (i =3D 0; i < csn; i++) {
> +		nodes[i].parent =3D i;
> +		nodes[i].rank =3D 0;
> +	}

With the suggestion above, nodes could start with parent =3D NULL and
self-parent be corrected during the first find_root -- thus whole array
could be simply init'd to zeroes with kzalloc.


My 0.02=E2=82=AC,
Michal

--fekhs4szurscavjp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZmc1eAAKCRAGvrMr/1gc
jvyLAQDIN3U4NIzzpH9PYRDkt6vi5r2Od5Fva82LPD+KYsJk0AD+MVtyOpfg+GiR
jomUt+u2dcuyjjPN2cfbN3PhSJVFnwk=
=y5ot
-----END PGP SIGNATURE-----

--fekhs4szurscavjp--

