Return-Path: <cgroups+bounces-3517-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA9B925706
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 11:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E00B4B21B34
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 09:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C90F13EFE3;
	Wed,  3 Jul 2024 09:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jMXaIgNP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jMXaIgNP"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A48C42A80;
	Wed,  3 Jul 2024 09:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719999658; cv=none; b=WKkeA+Mx56IM3zNi88UqY0/AKR8bzXRD8OS4uttHdstbXXZmSFJ4S234N2HleaPUL/Jg2da2XVZQY4sI8J+tWTxd4V8E/HStnkpYOLvVtuS7CzaZ2/Na7bf2+VtnZF3Btf63QKURTOvbi8QM2KZI0y4I8RNVC61sITgXwXWUZcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719999658; c=relaxed/simple;
	bh=z7aGI1TZI6lAJY4fGIlqBEsjvVvrkPIImFlTkDU1fkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwgFTQYqIzUIjWChm4phxQaKh1Tgq2zPeY/7C5kXDqgymx7Gq7lhQLXRGU/wunEhmVXgvHtu+Wg6TmGk3ggCvmtg5elkvWTtPpGDrcSI8KIowj1u9pSSzaN4Tgcn/TiDDo3a1SqJL6a75ke6sB7FFrdBftqs30ifUckse+U24R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jMXaIgNP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jMXaIgNP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 758561F747;
	Wed,  3 Jul 2024 09:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719999654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JB4BLZuZr4pVP6+uTyYcu7itMEHyZqgDTYeRn44tH2Y=;
	b=jMXaIgNPll13yIhmsMSpMvZXhp3hbsDMFd+7EMi5/tAUHHCetgjPpLRUPhnpgZ3E7MHoHG
	5iw81Vcz2g0wGFnWZhK5pBdVFajBDVcGURvy+nJPl3oM2LBd2b0sksph6BkTGfEfRjDnBA
	GautrGX/aIeEAeyYcQTKshXJA57u5AQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719999654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JB4BLZuZr4pVP6+uTyYcu7itMEHyZqgDTYeRn44tH2Y=;
	b=jMXaIgNPll13yIhmsMSpMvZXhp3hbsDMFd+7EMi5/tAUHHCetgjPpLRUPhnpgZ3E7MHoHG
	5iw81Vcz2g0wGFnWZhK5pBdVFajBDVcGURvy+nJPl3oM2LBd2b0sksph6BkTGfEfRjDnBA
	GautrGX/aIeEAeyYcQTKshXJA57u5AQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6779613974;
	Wed,  3 Jul 2024 09:40:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AV4CGaYchWb0WQAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Wed, 03 Jul 2024 09:40:54 +0000
Date: Wed, 3 Jul 2024 11:40:49 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Xavier <xavier_qy@163.com>
Cc: tj@kernel.org, longman@redhat.com, akpm@linux-foundation.org, 
	lizefan.x@bytedance.com, hannes@cmpxchg.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH-cpuset v10 2/2] cpuset: use Union-Find to optimize the
 merging of cpumasks
Message-ID: <zkkadtdssdgkndojsvfwbig3xwtqvfleyw3wbg6vewjntmklxe@xle6jq7jvkv5>
References: <ZoRThI4lcZLxBlwc@slm.duckdns.org>
 <20240703063727.258722-1-xavier_qy@163.com>
 <20240703063727.258722-3-xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ih7cnxbv33jxz32c"
Content-Disposition: inline
In-Reply-To: <20240703063727.258722-3-xavier_qy@163.com>
X-Spamd-Result: default: False [-4.44 / 50.00];
	SIGNED_PGP(-2.00)[];
	BAYES_HAM(-1.54)[91.96%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_TO(0.00)[163.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.44
X-Spam-Level: 


--ih7cnxbv33jxz32c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2024 at 02:37:27PM GMT, Xavier <xavier_qy@163.com> wrote:
> @@ -1102,31 +1101,25 @@ static int generate_sched_domains(cpumask_var_t *=
*domains,
>  	if (root_load_balance && (csn =3D=3D 1))
>  		goto single_root_domain;
> =20
> -	for (i =3D 0; i < csn; i++)
> -		csa[i]->pn =3D i;
> -	ndoms =3D csn;
> -
> -restart:
> -	/* Find the best partition (set of sched domains) */
> -	for (i =3D 0; i < csn; i++) {
> -		struct cpuset *a =3D csa[i];
> -		int apn =3D a->pn;
> -
> -		for (j =3D 0; j < csn; j++) {
> -			struct cpuset *b =3D csa[j];
> -			int bpn =3D b->pn;
> -
> -			if (apn !=3D bpn && cpusets_overlap(a, b)) {
> -				for (k =3D 0; k < csn; k++) {
> -					struct cpuset *c =3D csa[k];
> +	if (!cgrpv2) {

I'm surprised that original code wasn't branched on this on you add it
here. Why is UF used only for v1 code?

> +		for (i =3D 0; i < csn; i++)
> +			uf_node_init(&csa[i]->node);
> =20
> -					if (c->pn =3D=3D bpn)
> -						c->pn =3D apn;
> -				}
> -				ndoms--;	/* one less element */
> -				goto restart;
> +		/* Merge overlapping cpusets */
> +		for (i =3D 0; i < csn; i++) {
> +			for (j =3D i + 1; j < csn; j++) {
> +				if (cpusets_overlap(csa[i], csa[j]))
> +					uf_union(&csa[i]->node, &csa[j]->node);
>  			}
>  		}
> +
> +		/* Count the total number of domains */
> +		for (i =3D 0; i < csn; i++) {
> +			if (csa[i]->node.parent =3D=3D &csa[i]->node)
> +				ndoms++;

The naked parent access doesn't hide the UF abstraction well.
I'd consider uf_find(&csa[i]->node) =3D=3D &csa[i]->node or a specific
helper like uf_is_representant(&csa[i]->node).

Thanks,
Michal

--ih7cnxbv33jxz32c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZoUcnwAKCRAt3Wney77B
SZhEAPwKSuUSWOA1tb4NWBCwBuOWanQhYi+4QhJFfHegSDnnqAEA7jjWPoAyVZNT
J1WfV24oMlXpAy7DjR/DKQeM4G5WXw4=
=+Hy5
-----END PGP SIGNATURE-----

--ih7cnxbv33jxz32c--

