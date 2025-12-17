Return-Path: <cgroups+bounces-12442-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5BCCC9590
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 20:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C21E93009F39
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 19:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D7328312D;
	Wed, 17 Dec 2025 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Hdpj+mq7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD0526CE3F
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 19:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765998164; cv=none; b=HNkxML1zg8Mb6lF791kDcomerJYJlRZdjyKDDRiLIEDodXoNbfYoyIqmp0XFc4iwdkobiuN09GBLi7Nah/J9x5cwRwJFP26RyK/0/Jl5ssXQ4jutPQZapxgIdmLGf7CXKCVvyYVHB0eEEG7/2CItnNWj/6Ffw2CNsdWhVvMprwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765998164; c=relaxed/simple;
	bh=ioRMY7E5RbGxkWFGQhuvd5E46wuroq12yFc8qIrYi2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9FvdqTJw9m4u9zGMu6+wdr9XHdzveaGrAuUvY4RU4CH768nM/PX/xrbMJ4zSXAftK7Ze+AVpwBdSVl4vUt3ouuhapL1x5O3XUAMw/zUDpUldIEGXEL4VGTr+1ONX37iCf0aSOyJR75RNtqmfpPR9OU8TBTT3kVoNmORAGvM0Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Hdpj+mq7; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b7355f6ef12so1193733966b.3
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 11:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765998161; x=1766602961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ioRMY7E5RbGxkWFGQhuvd5E46wuroq12yFc8qIrYi2g=;
        b=Hdpj+mq7s78K5KGIl//aCOfdRhU3PmRC0y29CG1XdylPIio6Fl/dkTTYusYSKSNRcd
         t3snz+dbj0+aJxVcx45+7+VNgqeyp83HunYc8Bi9JduFDs6L8aAOa9oQ2Ymoada1GV5e
         H95xJmLdWedra7mqUIWiHeX8rlF30qRwhaKtuyqK9k1S6Zm1iOgVLKoZbN4KrGzlG6EC
         xh2Z3cs2avO/32fOMllIwip4tP0AeBdRSGvv7oqskSgHZrMROK0Hsyzu7wbofZ2EKxQ8
         35K2esWbUyRhGO/u5X7VWRvusFOElA+Pmf+pnn5LNg5bE2E7h7CEBHnnbGofPukxw0Wp
         HefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765998161; x=1766602961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioRMY7E5RbGxkWFGQhuvd5E46wuroq12yFc8qIrYi2g=;
        b=KQlEb+kacBdPssadWE4In/yRRbDVvj/hdWNl5xmn9H4/ADgFxLCkx3NJo0rAIQWV84
         fX2wkw/C+Z5Dw0Pw1gEB+6vckAm4Leo+QR1qQ5HPaDakDfTlN5Rz1Cxnms0//hDOAnnh
         xlC8w0wKtBiCAS4WjEpT/2ahcWfodMvBtDwRyzFm/d9iIF66goaHiUYrj0VqlhTlsPNv
         OOGln2CfsfFM3YuTexR64JDAlFqFDgF8ZiQK/HRQFEhBnLEdPT3pPouPekQ3QLVhXVkz
         VRjH+eCzN6f6AsEKJRfXDSwnMX1rm+K0SV9uwvBxgMBF+DBTZTv4CTFVypLXlrZEjLyw
         vptA==
X-Gm-Message-State: AOJu0Yxcayjrd12lUwfCRYyUturblVhcgFfWGRGwdm2o0ioxc6SN60KR
	/t9ERJsc4X/5aXVu/FpQ3ayK3dBZ9l2Yf53JSYlCGhzuMaPCyQM+3xRgzlf98VoQn48=
X-Gm-Gg: AY/fxX6w94pQz0hTS2pf2i5i49TVbNCD+40gunjNbwWHMPP1VsxoN3YLDZH1I45gpbb
	Lpk8GyLWsADoLINbHitXsYrn4CmUa4MmDnhumuzc9RyqyQM4UOA9QYzWq0ls+suCjOQxoYOJjLU
	NHEAWHyFZloe/stbLgCh7osYEI3C5/d+qflzzwqvY5FKBugE+87bqRyN2f2louM3RA1Mairk6vO
	DgLyL+8K7weQV45EkffeyHWURxF/KgoTyxgqeHSClEaXGd6Ba9VGROlDrgXlHKpnTHDj5aU61fg
	UBlGuy4atnABuYDJ3prgwaO1WVMzfRGAc0hiSjrS9xaoL7Y4xBcdRKP7n9xtJ0rtmwixJJI3RH+
	J1YoucJ4Oca3adA89Oh76lxpzePcc80KOVutr29xvyPhTQHAd4c5J8jN1akE2CKkfeNcn/A0/QQ
	phxg==
X-Google-Smtp-Source: AGHT+IE+H6U9g+bxlFfZOH3RW+nxi5NOuoDQRCzFkGA8h6dP85Lef0stKzOXNmQ2/6VOXFHJ05uipA==
X-Received: by 2002:a17:907:94c4:b0:b72:5e2c:9e97 with SMTP id a640c23a62f3a-b7d23c1b851mr1902966766b.36.1765998160748;
        Wed, 17 Dec 2025 11:02:40 -0800 (PST)
Received: from blackbook2 ([84.19.86.74])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8020c0d40fsm23827966b.49.2025.12.17.11.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 11:02:40 -0800 (PST)
Date: Wed, 17 Dec 2025 20:02:37 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>, Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 4/4] blk-iocost: Correct comment ioc_gq::level
Message-ID: <hqryjrdf4mfcpsfa46hptj6j7ygkjrcahb5tdsa73nxrlngffx@2l6cs5cefi45>
References: <20251217162744.352391-1-mkoutny@suse.com>
 <20251217162744.352391-5-mkoutny@suse.com>
 <aULg4f_nxLTbXvMh@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vblk75m2hqwjzgdg"
Content-Disposition: inline
In-Reply-To: <aULg4f_nxLTbXvMh@slm.duckdns.org>


--vblk75m2hqwjzgdg
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/4] blk-iocost: Correct comment ioc_gq::level
MIME-Version: 1.0

On Wed, Dec 17, 2025 at 06:57:05AM -1000, Tejun Heo <tj@kernel.org> wrote:
> On Wed, Dec 17, 2025 at 05:27:36PM +0100, Michal Koutn=FD wrote:
> > This comment is simpler than reworking level users for possible
> > ioc_gq::ancestors __counted_by annotation.
>=20
> I don't understand the change here. Can you please elaborate a bit more?

ioc_gq::ancestors includes self but ioc_gq::level doesn't count it in
(level=3D0 is root, that's like cgroup's level, from which it's copied in
ioc_pd_init()). Therefore ioc_gq::level cannot be used as size hint of
the ancestors array :-/ (The comment in the original form tempted to
simply use __counted_by(level). I see a comment for each member would be
the clearest.)

I'm open to more remarks or questions.

Michal

--vblk75m2hqwjzgdg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaUL+SxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AgW/wD8CddgVSxey23Qt5ED638i
lD/tTf0uWiVaRFTzwDwf/D0BAM7SnPN0437Gak1dppG6RH7Wlkxsu1F2lDC7R34h
JkUG
=BxIi
-----END PGP SIGNATURE-----

--vblk75m2hqwjzgdg--

