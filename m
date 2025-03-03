Return-Path: <cgroups+bounces-6761-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21974A4C4D6
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 16:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE7CF1885F65
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 15:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD6D1D516A;
	Mon,  3 Mar 2025 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SFtAhl0P"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956F98489
	for <cgroups@vger.kernel.org>; Mon,  3 Mar 2025 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015275; cv=none; b=ev/vLmLy0VMpRD765H0KiWFVFNsg96EJKDt+YPnY3ciNaOxU0Q4vceJUeN+w+VZv9YpV0+BmaA7qbA0H4lZVu2aOPLBBiANjPEluej57ra3Dms4iwEdEKO/uAihHOjRBaUZ40PDdO8VVRT1YnOE+y3yadH38mowMCENUDEGFD74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015275; c=relaxed/simple;
	bh=biHsJlet5fCfn+aQ+0yz+D7w55EW52qbWYdtbbBZhFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pI17hIAySnsqJTkW8Phf2GZlWtFtvJQH+Ac9L+lB9JXta9A9dP6I5twHF1Bk3aPAhg6Iv+mtGIRA/OCT2aEjtEaBlix16e1v1/ouQ6rqA6vk66ToRsu+x0liIT/ut/gx/JdVRiS3MWWPokUc6k/OqP/gv/ytscGAayOraBV7zL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SFtAhl0P; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so13575495e9.1
        for <cgroups@vger.kernel.org>; Mon, 03 Mar 2025 07:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741015272; x=1741620072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=biHsJlet5fCfn+aQ+0yz+D7w55EW52qbWYdtbbBZhFA=;
        b=SFtAhl0PHCm+cEJw5L5aWk/HEsnpNIfBPpVWjdeYrJLAfoAgaSfOmqwgHpkqaZe4Sw
         MaQct6pafu5iUgS395PjUj+AY+qTFYQzG84gRe6ECmGRRHZJXywh2Q51Htinj47DmiPg
         +R3gwANsckbh+02s3MjNC/5KohErELW+5k+4heaZZ6Y3EQ1Qi/xjKYsjlkFiXoNhxkCE
         H5/0A2TzDvpekNrFEv6u+G33KaofWAekq0ysmxLeIn5aJeLd4ZZ25cGA/+qzlywpgJf3
         sonzTPhsD+FHrS2dbuRdqIg9vN2ezHBPQ6ENLFOMaRXsNiZZCa5VnJtZBfQ7Kp2F8hxX
         xG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015272; x=1741620072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biHsJlet5fCfn+aQ+0yz+D7w55EW52qbWYdtbbBZhFA=;
        b=F3XrXAD0b48QPoKhtR5ueE9dpiQ8hmoGl9Du06hWi1lpA/coha+YTHcgB1MKfxmNpq
         feaDvb4N+HgvE8D9mYUke0n3itmNaalt+dyCKptezqO+uYq9MSZgCK7sL9/fHUzYOf51
         fX92IRYpwPsiVO4OmZ1pSQHyazUSDxJm5wgc3YOGFaoS8jGm07zD8eZV/equTONVFuh+
         ICMQhY9GarHxKcRrw36Lthba+qvE7acO9rOOGIVCKOQM0dXRnLXJaId19MqXQc1IusN+
         xHYwSnYlX23wATGywgKd4a15U2QvS7SmFx4LjkaZ3dDRW3nrOP7VZSvWqLeVUGBzADh8
         nipQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOZPoHKw7V3BV9tdBiv6WfU6Ny5DlSh0v5WVeRwEzomox++5Fy0SqVi/gO4UcuiMtcH5L6PzSL@vger.kernel.org
X-Gm-Message-State: AOJu0YzaJA1z/nltwbb9uIVEm/2779qxiKtcL+0J88DpshVRT9YUB3sy
	h9YMkuAxvCk2p6sqq8xvxSfAC4v7TDhzOBvxYeDJjxGmk+hw63lHrBQau3QkLVM=
X-Gm-Gg: ASbGncuER5IIChEx2r0VA/qfCFkFd5hgQBV6pl6EQYuJERHUn4ehUr9Pv/P5NYV7cMd
	KpnBw+5jUqEtmSuBm4vMXajnZX5WXRQMZjBr5a1nj7WuFz3RgblMDXmL8kXdx54T9JCO3vbdKrl
	lrrjaTPotjYx8sVS65XsgromYD7mIX26ILvRLK4SHg4vVagmZAgLS8YH+vXu6UgAaxvZ9pSgi9r
	hHO5DiPkW0DvZnZSzpQ4i6cNTrGvPKgP//x0pQRA/bC9zCFjg09L129WAQ/uQtjM+RoDm4W4Bwg
	bmd4v/0Nr/cu+PRBOhyLEC+0knKWEKPRnTyEDSTYLwRdcfA=
X-Google-Smtp-Source: AGHT+IHO1UijngzxYBV86MuYCZ4rhjDwQ28SjMC10B6w+oMVmI7gQJHRqCbzGOqKBee6uaMxIiQq/g==
X-Received: by 2002:a05:600c:3c86:b0:439:5a37:815c with SMTP id 5b1f17b1804b1-43ba675a7dbmr105168685e9.20.1741015271841;
        Mon, 03 Mar 2025 07:21:11 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc5c7f48dsm13737795e9.2.2025.03.03.07.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:21:11 -0800 (PST)
Date: Mon, 3 Mar 2025 16:21:09 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: inwardvessel <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com, 
	mhocko@kernel.org, hannes@cmpxchg.org, akpm@linux-foundation.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 2/4 v2] cgroup: rstat lock indirection
Message-ID: <dusk4fzib35rscncxsvjrnruza7vzbmohgbz22s4fkw4ql7er3@oy7owvwudszd>
References: <20250227215543.49928-1-inwardvessel@gmail.com>
 <20250227215543.49928-3-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q7bycjb7yl4xffnx"
Content-Disposition: inline
In-Reply-To: <20250227215543.49928-3-inwardvessel@gmail.com>


--q7bycjb7yl4xffnx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/4 v2] cgroup: rstat lock indirection
MIME-Version: 1.0

On Thu, Feb 27, 2025 at 01:55:41PM -0800, inwardvessel <inwardvessel@gmail.=
com> wrote:
> From: JP Kobryn <inwardvessel@gmail.com>
>=20
> Instead of accessing the target lock directly via global var, access it
> indirectly in the form of a new parameter. Also change the ordering of
> the parameters to be consistent with the related per-cpu locking
> function _cgroup_rstat_cpu_lock().

This is non-functional change serving as preparation for futher lock
split.

(commit message fixup)

--q7bycjb7yl4xffnx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ8XI4wAKCRAt3Wney77B
SfeTAP42ZkYzOoE0sWwmSEwpmmHsA3x9lVx2zwFpJO0pPJuczQEAmMcLH0BEIKTb
NZEFQkuv5jC+XD/BAdvGoRP7rtTqmQw=
=X2Ou
-----END PGP SIGNATURE-----

--q7bycjb7yl4xffnx--

