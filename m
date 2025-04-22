Return-Path: <cgroups+bounces-7709-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C372A9645C
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 11:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F48162FE8
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 09:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD30201000;
	Tue, 22 Apr 2025 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V4TTI9/S"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DAED530
	for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745314288; cv=none; b=jQggn4nT+KcElzSNAivwm39aTqRUWeRsy+E9U0FKzLwtzQ+KmHhuyFIiYo35gNF0zaxGx6Nob4GOU2z7Q2GFvZHV4zGNdjc2hx5cGRAVROsaI4l8aRZIJmwvzYjHRbtZknuoCe2D5EHsGd8d9/5YBCilhEhrl4GYILTsvUZApKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745314288; c=relaxed/simple;
	bh=V5iZrie0NfoNEv+CbNmUGa6+0H1z0sLCiVg0dRInIfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXpRMO8n/IatIAWGuRNXX3R57+3Vmsvx3zDiXVHxdr/crr62TFEN1hDWKg6uMFJFFpMC+d0pZGTop4LIhsE957Qf47ZcHHlQhRoBXRWx6zaXETEAjpLqm0mxj4QYeVccWowgda1z44tgsaYKkehvfqSgWgamdqdLFQzSvIgDChE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V4TTI9/S; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so562733366b.1
        for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 02:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745314285; x=1745919085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V5iZrie0NfoNEv+CbNmUGa6+0H1z0sLCiVg0dRInIfI=;
        b=V4TTI9/SL+GBdIKfahDSV+IppAdIg4zLJh4lCkiJ3R8knSo0uMqtT+ltpF+9zbW31F
         wHg62cDtDTaAd1ub7NP/N+g9VyEOUb/Jlg35KJT1H1AwZDeO3Q9tfGzRFma4jyauMzxo
         A2zzE5PfpsXOd8VwrKRjUkhX3d3aDdvhsbRYtATTRJBXDM5k4vWoCKdtxnRlnB3r6C3A
         Fg/PI/Kh7HR0NLMtFK/lWo7qbcpY44p93kJ0snAy3VGoAgeT9/s0nycnB+0bB2H228BE
         tUZXezmu2rcrH9mZ6Ad8tWzZx50+cU7cOHCsqflnVyOR30SbhXdH7r+aeg/N2ER4VtMb
         fqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745314285; x=1745919085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5iZrie0NfoNEv+CbNmUGa6+0H1z0sLCiVg0dRInIfI=;
        b=UPyrFbNQoiSFicpjvkWZSK8YYxCV7cbOqJyQJZwUjFy/J1kxQwAtUuSgDQYYaLB5h7
         5E3QfkE66KuuPWMSjg2Pb1v98ukwM9dEsMVh9AGMQQaP39zcEfTgebLt0tdKV6dAL5Bs
         n8iW0erhFcb+NmEstdyUwJTQ0HHEUEl7SAOV8A2eE1yyT/Zzx2lxBBreZL/5X76QR5P6
         ol0bcjZ0tObwNPbUiKF5Gxnv42ncBPJ6//3s6Aqb7hKCawlXRngxBFMzA1LzCpD8AiSf
         mdhxw5+afGHzbEWCgBnXhcmMPlSBndnjCw+tdblg/pb9gk9cidzuraTUrrgGgyt53c0B
         H+xg==
X-Forwarded-Encrypted: i=1; AJvYcCVXTyE57ztBOJ9nx8wu0xgY68JMxuf/RhkaaDys3hpRhCt0Z1M0CJRvcR+ouVZonO6v9ZIAtlYv@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0pLA/QlULbmch9XQ2EXVbwm+rVT2Zkfpw7nJIKng2XmyqIJyj
	5cPo9D0Iv0pr59aVJ5OHj8o7mUuwTnniZMVHnFKmgWX5xwe2Yz5wrc1xAwMa0vw=
X-Gm-Gg: ASbGncus/20G9YUCt6Hg9HyJ8VjGZ7M1cjFThUbxtXCb5vkFM/xwSCCwcna5SRLhimR
	7InAa3TyAdLKliNlIg2x9GVbDwAIuf0ZD07KB6I/c2+FJmMru3UmBacybYftBqLqi+RnDZaI4gD
	nFcwvtiWXY347mY+XZZznBu6SaFytEW5Y8cjtIW85Z2Dj5oJqhBk3L7IEFUBa9SL/AMyPsFROCc
	MVEtJ3AwleWvqQ+SSkVD1mZkMPM+26iDl45Ua/NC1ob28qBfAIEawhzOMOnuiuEJRmLPbgkEpJ8
	WUUESqRqogLuLUeORXn60S1NWohDa8oBfTO9RsVPYC4=
X-Google-Smtp-Source: AGHT+IEVRJF5sF7x1XS+lNM+Im1WgkH5x+/F/q2jlZU7fETD+EEwteY/YCeGUBJhZQKnxR2YU7TZDw==
X-Received: by 2002:a17:906:5d5:b0:acb:8a2c:fcdb with SMTP id a640c23a62f3a-acb8a2d110cmr880090566b.38.1745314285271;
        Tue, 22 Apr 2025 02:31:25 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6efa5c5asm627390666b.166.2025.04.22.02.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 02:31:24 -0700 (PDT)
Date: Tue, 22 Apr 2025 11:31:23 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Greg Thelen <gthelen@google.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v2] memcg: introduce non-blocking limit setting option
Message-ID: <jqlq7y3bco4r3jpth23ymf7ghrtxbvc2kthvbqjahlkzsl4mik@euvvqaygeafd>
References: <20250419183545.1982187-1-shakeel.butt@linux.dev>
 <20250422-daumen-ozonbelastung-93d90ca81dfa@brauner>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i2qhcekndg5mr4b5"
Content-Disposition: inline
In-Reply-To: <20250422-daumen-ozonbelastung-93d90ca81dfa@brauner>


--i2qhcekndg5mr4b5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] memcg: introduce non-blocking limit setting option
MIME-Version: 1.0

On Tue, Apr 22, 2025 at 11:23:17AM +0200, Christian Brauner <brauner@kernel=
=2Eorg> wrote:
> As written this isn't restricted to admin processes though, no? So any
> unprivileged container can open that file O_NONBLOCK and avoid
> synchronous reclaim?
>=20
> Which might be fine I have no idea but it's something to explicitly
> point out=20

It occurred to me as well but I think this is fine -- changing the
limits of a container is (should be) a privileged operation already
(ensured by file permissions at opening).
IOW, this doesn't allow bypassing the limits to anyone who couldn't have
been able to change them already.

Michal

--i2qhcekndg5mr4b5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaAdh2wAKCRAt3Wney77B
SV5jAQDVSm6Ja4jGC2yTv6E/hAxyTENttqmaX3cnbiAR/btTsAD+NHYf2vRtgkRC
wioHPKWvbJ4uZJ+rnc/qtRcKN2hyhgo=
=b8xl
-----END PGP SIGNATURE-----

--i2qhcekndg5mr4b5--

