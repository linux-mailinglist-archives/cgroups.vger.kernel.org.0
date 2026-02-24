Return-Path: <cgroups+bounces-14216-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIr0DcShnWlrQwQAu9opvQ
	(envelope-from <cgroups+bounces-14216-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 14:04:04 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 817171875CB
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 14:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 932BA3072445
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 13:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557C839B4B7;
	Tue, 24 Feb 2026 13:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ugj7mKW0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E2339B4A2
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 13:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938227; cv=none; b=DL3dTpkG12rAY398fU9Wkuxr8e2PjsLPZZOZkH20DQi1WgsrCdz+boj72v9rXWsu7PZPiOSnRdK5gI5gm8fEcsbft53eHsAvIT6WXHJpWvUVk8nVIqgNTzp7A44twEYVZiBDZeUAftMawHgk7F9F2e8zejLaZG5jqnprIdfaK08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938227; c=relaxed/simple;
	bh=Ty47PIQ4aRUblWLMfbWi7TMnbfp1UzJKREhyvYa8VOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+9b+mVM3Zg9AGCNSwo0w6D6oasgcue7VJdlp13OBcjJko9kCej2qQ4+RsTYezfWYsu5Vm6JNTNZ+sOYRZCez8SB/20UkIuhmi6esQ9vx1UOqka2aiCO/pAWR6/Niy4HqUPrJwFF1WtvRdbq8dEJXKVUE56B3+xevgyx0AA5D8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ugj7mKW0; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-48370174e18so29845505e9.2
        for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 05:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771938224; x=1772543024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XVa1OFxTSaJW4X8laFBBlk1UyUQhfdcKP0GEhlOI/Ow=;
        b=Ugj7mKW0wdKum5CO96RRqa5rmGK97hJPqOfbf7jZlkZouXEUgMcTtgHJ9BEeGP7TQ7
         cnUadf+KepBH+0CaKSSu/dtPooLcl6BDKuoRYGuUIZDmz81BMeu0gh8d7khxQejQhG0a
         TKaGntcAf8HB5N3tyKjxAQlmJR6g/OZdg/FTYqmKzmhtRof3WgULstUZ5s/kbtgR2GU1
         BaoFZKBPj+3OGPf5OfpuwdI4IYrVnJdM1B61zJE4d2b0my6M6tbAGCpbR6wUOsUXG+m0
         VU0BSfrfHtI216GTUZczW/F7NaHk56jMkZOYatVh4EhOp0bFzTawCp7oifc2dJiJ76tp
         en0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771938224; x=1772543024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVa1OFxTSaJW4X8laFBBlk1UyUQhfdcKP0GEhlOI/Ow=;
        b=Dz1TCMNfGyTP1MO6kIuAbXF//q7jdRK2qUhcJ7GbUjSrGjVZHxmP9gm6BLMVPlcPEK
         7oLJHnIRBix2v13i1UzyjpNuCCO0N9gpGtfdsW7yIW/GEVzpYtSnZgF8btWzJ8EIH2wr
         TAQhmmKpps9e7kPpRFxGvjwzA6+QhyVepuS3veFkMaHFe8ZayDXyjOgD7u0Xnh1rzmeu
         /EwgtZNBMCLuBF05S1ACBj5Afkr6RlmuaPrLEwaLXWSU8QzZyogJ7mlz6K1plH0h40Nh
         nVV62Wn+gpx4u3uSijUGtRYW2aKwqsR9ifAGfbYlWOxQFEHoWgfQsbHSnI3MrddsFoHX
         4C8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSq64v1RgX137NvLxe81AM8prY5GbtTkYxSNgMQ9aEqu7PSiwS78/AhPQghO5dnvHUpi0Lkr0G@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl03qSN4Ph9ZJDeGteKgfDt4TtZ4H994Mpj2MISAbaTpmZ99O9
	wrKXjsCMsEJq6Sm3AM91nXHTsngcz+lYsZFPs9zrWxwj5I3/FrJdW9PUklCYDpfLOQk=
X-Gm-Gg: AZuq6aK9hdMK71xCHa8siZJKK9m3YcFd99RFH8NACcroIVtXtfX0DSaZ/Lkz+Wwa/w1
	6bS+if2YjOngtvjcGDNxMDSD1PCg0aEfa5UF8nGwQeLLv0eAUfzIgQ2Ke+9FxmszpftsVLjIucy
	RJ6z4zVbFDntKEs6pDGW4ChQTkfIb+l/iS8bgy5o4CW3A7i31hVV0NClT6+T1AdBv+1tPmycRjN
	Y6jyPpPC0XQh2riZFh/hwwj1gThrBtq/CYBSLPGPn3sTSzdmDrYAa05bHIIiFmMMchWD1VVzo/1
	loZtU2aXtOvoeLWdDjEXh1JY0wvR8KujGAGYXcZx0fhZGOnmghCNQpqKoJrQVn78+vs7Flba0/H
	HCh29nlYjInRn57ROM8tMznYltHQYXT9aqlSpH7HJvp5Unb5muDmDwRWYEtWBxKDaub+/bljD4b
	LQoF6ZNXmgsdBTmeD7m8agEIxa3uTDZ+S/48LrZdIQAijM67RWoIQxPA==
X-Received: by 2002:a05:600c:3b08:b0:480:1c69:9d36 with SMTP id 5b1f17b1804b1-483a95eacf7mr185404655e9.17.1771938223980;
        Tue, 24 Feb 2026 05:03:43 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9b75e51sm269734055e9.5.2026.02.24.05.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 05:03:43 -0800 (PST)
Date: Tue, 24 Feb 2026 14:03:41 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: zhaoqingye <zhaoqingye@honor.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cgroup: remove redundant NULL assignments in migration
 finish
Message-ID: <qdws4gdrziqtygwwjaw5eujnvd5edz7mklasea64vueijfbbv4@2qq5isumvkyl>
References: <994c084e31414d4188c8e2973d9f6e6b@honor.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mx4i2sqdagsgdt3q"
Content-Disposition: inline
In-Reply-To: <994c084e31414d4188c8e2973d9f6e6b@honor.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14216-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:dkim,honor.com:email]
X-Rspamd-Queue-Id: 817171875CB
X-Rspamd-Action: no action


--mx4i2sqdagsgdt3q
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup: remove redundant NULL assignments in migration
 finish
MIME-Version: 1.0

Hello Qingye.

On Tue, Feb 24, 2026 at 10:36:23AM +0000, zhaoqingye <zhaoqingye@honor.com>=
 wrote:
> cgroup_migrate_finish() currently sets cset->mg_src_cgrp, cset->mg_dst_cg=
rp
> and cset->mg_dst_cset to NULL when cleaning mgctx->preloaded_dst_csets.
>=20
> These assignments are redundant for the css_sets on
> mgctx->preloaded_dst_csets:
>=20
> - There are only three places that modify the mg_* members of a css_set:
>   - cgroup_migrate_add_src(), which sets src_cset->mg_src_cgrp
>   - cgroup_migrate_prepare_dst(), which clears src_cset->mg_src_cgrp when
>     src_cset and dst_cset happen to be the same
>   - cgroup_migrate_finish(), which clears mg_src_cgrp for css_sets on
>     mgctx->preloaded_src_csets and mgctx->preloaded_dst_csets
>=20
> - All three functions are invoked through the migration sequence:
>   cgroup_migrate_add_src() ->
>   cgroup_migrate_prepare_dst() ->
>   cgroup_migrate_add_task() ->
>   cgroup_migrate_execute() ->
>   cgroup_migrate_finish()
>=20
>   All migration entry points (cgroup_attach_task(),
>   cgroup_update_dfl_csses() and cgroup_transfer_tasks()) hold
>   cgroup_mutex across the whole sequence: cgroup_mutex is acquired before
>   cgroup_migrate_add_src() and only released after cgroup_migrate_finish()
>   returns. This rules out concurrent updates to the mg_* members.
>=20
> - During a single migration, a given css_set cannot be on both
>   mgctx->preloaded_src_csets and mgctx->preloaded_dst_csets at the same
>   time. For css_sets on mgctx->preloaded_dst_csets, mg_src_cgrp,
>   mg_dst_cgrp and mg_dst_cset are never assigned and therefore remain NULL
>   for the entire migration.

This is impressive exercise! However, from defensive programming PoV I'd
keep the cgroup_migrate_finish() as is. (Otherwise the text above would
need to be added to the preloaded_src_sets processing to explain the
disparity.)

> As a result, explicitly setting these fields to NULL again in
> cgroup_migrate_finish() for css_sets on mgctx->preloaded_dst_csets does n=
ot
> change any observable state. Removing the redundant assignments makes the
> migration state handling clearer without changing behavior.

Despite being redundant, they pair with some WARN_ONs around and the
runtime benefit here is negligible.

Thanks,
Michal

--mx4i2sqdagsgdt3q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaZ2hqRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjmUQEAkr7AJTbPtUiC4o1JVi9/
PwYgyfOrCfm84ozjE5aQeIYBAIhPNXPHzTVi1cxG3j/zKcn6f7OtSebuFSlNwWqK
uCcM
=yjcA
-----END PGP SIGNATURE-----

--mx4i2sqdagsgdt3q--

