Return-Path: <cgroups+bounces-15375-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEYXKGtq5mnBvwEAu9opvQ
	(envelope-from <cgroups+bounces-15375-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 20:03:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 230834326DC
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 20:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00A42328A97C
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 16:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600E234B190;
	Mon, 20 Apr 2026 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HvvgIr9S"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE07C34A3D6
	for <cgroups@vger.kernel.org>; Mon, 20 Apr 2026 16:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776702023; cv=none; b=SdNyKwvyBV3RK+6xL+9+F/TCWBosnuTInZEo0yBhVVYQs49uQih68Y+OORdLzkDtaA4s895jFOMrfQ0rWnARyqj5mqdznh2DOvGAmL6GyS4qWONu8XwtDzCiRuSO2nAUGdq7jrx77jC4gjJSoeYaDQG2CpbhqHgZZeOgqFbP0RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776702023; c=relaxed/simple;
	bh=OdYPpUkMeCBk1OjhiaGOqWLSXmyMXptKmdQdv1p8ctw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmOLm7hscuWUaBnyWygJuKvHcScMGhyy4hx8HC606oapFRwt80Xej7W6EqvQLF83CznrIYvz7GlE2uu/8Z0q2fSmAYxglHQ3VqIy/JmDbwE+sMhFsZXsdGN6t2YY+mbYXz0I8VD9COj5u11Ghbk7r/4wRpmmEUsSMdTBDnjOumU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HvvgIr9S; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so41971835e9.0
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2026 09:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776702020; x=1777306820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OdYPpUkMeCBk1OjhiaGOqWLSXmyMXptKmdQdv1p8ctw=;
        b=HvvgIr9SW56BLcFRmwEv7d/23sSGifKIoUxKRWc8gy4xh3DOKkDo94JVX15UvVyLit
         dJPSME1Sy25p1h/lirdTB9P9WlJh2Rhxu0xrCoU7zPqvBMd5fIT9DBLfvbAp3Mg2dyOw
         T0tCCr9TOqt7LDjNw3jULzU+ywHqxjM3R2kueTy+XVM9NfU7g1rhJ24aaNiJlWDbbtCl
         xU+n/ebvSjmDAef4DXOCKU9ZgZfRkIO8hjmyVVnbCz3uh5BSAOyYFLN4UMw21PO2G81W
         TrxbsBPJ1gxj/H4x3jVN3nNCOGtSh9JRa4O6Lyxm7hRLwrx7BIW+l04h5oHV9R1NqrwL
         RseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776702020; x=1777306820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdYPpUkMeCBk1OjhiaGOqWLSXmyMXptKmdQdv1p8ctw=;
        b=Cw9BJtEcADMJybyofHpipeufuZap/3Pp9fV/qv/LV1KVxIgGsCt4hZM9Jc0EkiOhbV
         S2E7en/dvoMFOnMyh51HlvSXUdoSdzmpAHLcuXG3Tt+N1NxtwuOl7YTw+gBsxeFUxYu7
         MIMnNywwiHTQ1YAcUqqBVBcZRJ0lLkg0Ju2sao4ZZ261Yk1F8/KY/GaUrfXMDi8FfZQZ
         I+dR31MuYgZzdFoh3vLTNVcfEb6bTV/sADBYFoaLRVe0ac30XdKDQIONBnvzhC3/Dzsa
         wmvOvCeGBuu9T4DURydi2YhfCc8NLY/Ryjs2Bl5+h/JoZwMs/671Xtx6nPw7Vecr9+eD
         qtQA==
X-Forwarded-Encrypted: i=1; AFNElJ+/Pmr1rBvdxRo1nUFB4VivZG+EP3HhrppszpWwPVlzOIDo8xFo2ztaXA75N7Yt9g8PvP8+ScLE@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/DIija5/nLAX5FgjfMAXl/ihWNumkKDePmeIWhFduNGsZvgqW
	nQAYYagb2iKu/Z57aCVBFzXCGpBS/mbEE/e5QnzQQZQdUug3diBgqSB0Akl3Rf7Nz00=
X-Gm-Gg: AeBDiesH4/ax51sHr9aALcliQ4H+8J4wHe5VJcCIimKrjFHrQ7BuKJhbTpxpwCtc8sR
	yXBgd2ri7pbIfAXXo6RzgN+kIJwCg5fEW4FLZXH+Pv1NCfwpDFPSxdTO5nAVYRO5FEI9SXK1BEV
	j70LiSGLtvFUJ2yj9MyL4Xh88dkhs8kro8Gqz0RovSQOmm8JRmSQh0CTDvCVg3n6duyzuc0b2GV
	1zyBAo0/+HlwAybCVmxIk8ypflFApcum98W6sR7ScqGZS6BapOcZ5LIf+gIH9A3qXuSU+sKJS/u
	yyAIOEC+9KeEvr4Bze984bEO9nTBSo+OcIUmyNSzISFgDMgx/eK7HvcAoJ81I7GbpvCzjdamPAx
	EnCbd45JE0FdpS9Kw1+xHPxqQBd0aRyh1mnuNrB73+2EFnnOCyM30Fs16aB3BcqawRPltCXQ2HU
	cpA4RmWqW7jkJNRAjv1fvHdnMaxQc3j/EQzm6PCqdDhbTJKKhnwcCObQ==
X-Received: by 2002:a05:600c:a108:b0:488:a82f:bbb4 with SMTP id 5b1f17b1804b1-488fb78a0famr170297225e9.26.1776702020135;
        Mon, 20 Apr 2026 09:20:20 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4c221cdsm30182533f8f.0.2026.04.20.09.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 09:20:19 -0700 (PDT)
Date: Mon, 20 Apr 2026 18:20:17 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Maarten Lankhorst <dev@lankhorst.se>, Tejun Heo <tj@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>, 
	Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH v2 0/3] cgroup/dmem: allow atomic irrestrictive writes to
 dmem.max
Message-ID: <p6cazw2amahycpvmim5364t46b7wrkw7quzo7dnsug7grlolxh@w7foqs6zs7wo>
References: <20260319-dmem_max_ebusy-v2-0-b5ce97205269@igalia.com>
 <b099d9248df084fed8d4252e3c6fc485@kernel.org>
 <88f89d75-1e1f-4457-8c1f-57e934c251cc@lankhorst.se>
 <acF6PMV-aezq3dWc@quatroqueijos.cascardo.eti.br>
 <f1edec8a-f446-4fdc-b39b-1dbb690ff57e@lankhorst.se>
 <acVPnzeUS0jiUioj@quatroqueijos.cascardo.eti.br>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="23iuyz5d2rkbqv6i"
Content-Disposition: inline
In-Reply-To: <acVPnzeUS0jiUioj@quatroqueijos.cascardo.eti.br>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lankhorst.se,kernel.org,gmx.de,cmpxchg.org,vger.kernel.org,lists.freedesktop.org,igalia.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15375-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 230834326DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--23iuyz5d2rkbqv6i
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 0/3] cgroup/dmem: allow atomic irrestrictive writes to
 dmem.max
MIME-Version: 1.0

On Thu, Mar 26, 2026 at 12:24:15PM -0300, Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> Is there any reason to keep the support for handling multiple regions in a
> single write?

+1
(I can't think of any. Additionaly, there's nothing like atomic charging
across multiple regions, so the charging side could still race against
the limit changes.)

Michal

--23iuyz5d2rkbqv6i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaeZSPRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Ai3VQD+JXDA1+znyDGKCvPc+cJ9
Jol+l1WquVsZ7KLxdCWVbFwA/27lAKMrEiht4cAqlLRcW/tsFlA2xU7fN0yVxCsb
hMEE
=3Xdt
-----END PGP SIGNATURE-----

--23iuyz5d2rkbqv6i--

