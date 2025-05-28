Return-Path: <cgroups+bounces-8375-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FD3AC6EBC
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 19:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E8753AD860
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 17:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335F128DF34;
	Wed, 28 May 2025 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HtFP108E"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B1B28E568
	for <cgroups@vger.kernel.org>; Wed, 28 May 2025 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748451916; cv=none; b=RXTR1qx9aDkBV1ZAkGWcw2Bclyc1OzcCtp2cyy8p9M7MFQz0C9Bkcz5G/CBB3rckkS3ksZiZydfI4yQ0y3F/N+lpKML6OhHPbYkuJd0t/yinb7LSiEqPJmzFvxSBqpkvm1r9ud0SCv7fRwGJppghmqQldpkw5jjKYuIF1BmVk9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748451916; c=relaxed/simple;
	bh=6QPXsF522lgAxGDMLzu85PkLdcBq5bWzb2eRzcztNo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bt1tTup9uKvY65XyqhDP5Y8BRkUsexxWIxQmqv30+uq0MSLbrXrcueXfbZb/WCXx/IDo39LqiGWRFmLcSl/dWt/W0JrGlQmztMJhISGq1vxOjWBHQuh8L2Tmwe8mWp1SGR9LpkoehDtnIj8qfwF2rdUeh/aju8MKlxhbhfx074A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HtFP108E; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-450cf2291bbso2005e9.0
        for <cgroups@vger.kernel.org>; Wed, 28 May 2025 10:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748451909; x=1749056709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6QPXsF522lgAxGDMLzu85PkLdcBq5bWzb2eRzcztNo4=;
        b=HtFP108Eku7ykVISiHo24iy4v79x1Nmkzdi5HTD9J07Yxk4OqphVkCZF1FChWPP4SC
         U4rGBOURSgKfSf3wDTY1oBptVuLttbkF45XP9XNBqjV2k6js4fmvVN1so4QWk6shIZdq
         1onVisdMD1qU4YanSqlgs8MgW6nHQAwmh3hVhElInr6Eunt5VmzwOoYY1cziQjCS7ewZ
         hkm4pdwpIEl1iLd8DbXnvepK88bVSuHRzM6l6b05i/UcdNnNNkoybOVJUImLHYfZEq1E
         YYTU6c0bkNoI3MCRxcphmYoU752jJ9I+yEBdUip86YCYiK23a5FG/bpqCoROXpFh/AMq
         n0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748451909; x=1749056709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QPXsF522lgAxGDMLzu85PkLdcBq5bWzb2eRzcztNo4=;
        b=kU6Oqpgezk96c3rxXZQh1q3voWmMcL/Ndcu7SjYH46DXx7x8l7mwviK8waEdCSpvA9
         91+cQ6b+NpuNGtJ2qle5PpOPbfq2RYSejKrWdQf3Nt1x5NyNHsphBgXaWWXCY5zZ9a8K
         dn+PRGcVauNGVwxqWCQALAA++5hxYXfnrV9nugdg0jFTHI517iwdn0FxMUZMmF+8qv6n
         PcvocTWPT6YBwPaQs5X7/xb+9yHiFmJKHzS1stZd7ONbUwuUdt9YCElChupFS5EEEyRw
         cWgC9t8dBflAOIx/xjChw9NJ1eHq94/PlrEBzSZWlTFV6/GRLKCgW+/MYA7hDFF3oVkM
         uBsA==
X-Forwarded-Encrypted: i=1; AJvYcCUzj6b9ahsf2K5JYWyx7dVAPIrYcl8jkZ2YYqUY+FFm35Qt2sBluZHGykrWhix9LOi7tXEsA/86@vger.kernel.org
X-Gm-Message-State: AOJu0YxzKZRpSTlk7ijA8YFYMwE8CHP+xAi/2A3j/7lM/SSZbMh0uVhf
	51KlWRrUXz/K1EnilZLUgka3KHV3QdDCvnouh10pnyF6Zt4PpJVAQkuYrRyPimyF3H0=
X-Gm-Gg: ASbGncu7UJUydYC2evSsOLpRQE10iheFWuHEZrncj7SFyMqeIRNoORSvinKPViLrVF8
	Ud/Nr6s2VtkC5a/haUflbdniyqJQ23bjDLieJHHGEj/q7ugjusG2kTgxHPDeLpfAB+8ito5ri2c
	CfyKEvB0s9hHjykB/dBpDZbJRE5lelmUd9MDG250zVFUV5y2/TfmE/QHM1ilblTvEF8JIXfyeQX
	AhUx347vmZDXTPUMPrNCn/nZ9J6n35EHsDnjWhQK4Sy9WjI78Sd48hq2WY8u1Pvo9oaYK8rE09I
	xyp2ARqhl1mqGnDOkkxzKgoPmndo/JF90B6cjT4ueH32WFOdlUHxTg==
X-Google-Smtp-Source: AGHT+IGTf3pKK/IgQTggD4z8Aqvs1zWP1VXkcJHKOx61SlzPEwmvUNnUqlL2LM+xk+/b5ozR0cqjyQ==
X-Received: by 2002:a05:600c:64c6:b0:442:ffa6:d07e with SMTP id 5b1f17b1804b1-44c9141d996mr138953735e9.1.1748451909006;
        Wed, 28 May 2025 10:05:09 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4509a0452f4sm22875565e9.28.2025.05.28.10.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 10:05:08 -0700 (PDT)
Date: Wed, 28 May 2025 19:05:06 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: cgroup: clarify controller enabling
 semantics
Message-ID: <bdstku24kbgj2oalpbzw62uohq7centgaz7fbeatnuymjr2qct@gp2vah7mumk3>
References: <20250527085335.256045-2-vishalc@linux.ibm.com>
 <vzdrzqphpjnvrfynx7ajdrgfraavebig4edipde3kulxp2euqh@7p32zx7ql6k6>
 <aDcNLTA2JfoLXdIM@linux.ibm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="34l27iq75neltcmg"
Content-Disposition: inline
In-Reply-To: <aDcNLTA2JfoLXdIM@linux.ibm.com>


--34l27iq75neltcmg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Documentation: cgroup: clarify controller enabling
 semantics
MIME-Version: 1.0

On Wed, May 28, 2025 at 06:48:37PM +0530, Vishal Chourasia <vishalc@linux.i=
bm.com> wrote:
> The part that was confused me, was the meaning behind controller being
> available vs. enabled in a cgroup.
>=20
> Though, the documentation does mention what it means for a controller to
> be enabled in a cgroup later in the text. But at the point of the
> change it is unclear.

There's a picture [1] that may be more descriptive than the docs (on
which it is based).

HTH,
Michal

[1] https://paste.opensuse.org/pastes/987b665209bb

--34l27iq75neltcmg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaDdCQAAKCRAt3Wney77B
SYoAAQDnwGxoiky6TLy1ry5zramOQWjqDHvRW6KNvKnoq64TugEAoDpAv+172mcu
qb6EoX3kd+ZHuNpYgTAgOV5HOv1WbA4=
=NwFj
-----END PGP SIGNATURE-----

--34l27iq75neltcmg--

