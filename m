Return-Path: <cgroups+bounces-2762-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4345F8BA899
	for <lists+cgroups@lfdr.de>; Fri,  3 May 2024 10:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00722281739
	for <lists+cgroups@lfdr.de>; Fri,  3 May 2024 08:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F56B148848;
	Fri,  3 May 2024 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kcghk5aV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54C5148313;
	Fri,  3 May 2024 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714724423; cv=none; b=tp5Eb+XRjmQZNjk6tfq+SPdtMzNWmlGIvDbWKNro2Tba3bGZf/R3+nVSCV/dmJhaH5iCnfU2OO6sfRppYG8kvxBJZe31nCTrm8c5iBYV8TVSbR2uCD2G3vQSv+mv6fWI0YNKhkFKbbOUGIy21bAKaFK6dop0YQ1PW+gYfWEH4ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714724423; c=relaxed/simple;
	bh=MNIFnx2qTxrjZunIYAyHq5H9qZ0uBcjf4J51U8fNhhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUYDFnyjdsE5FFthjcIFjA0UwTEkc2yD5O/lpIqtkGE0JTDnvwppO5QybEcCJM313TO3bhsEYSn0JUclB7LoPh8OmD/MoPaZBmz13726YTzvwCIp9w+Q2X/Ui880kfKEdDwZEURZlyAISOUPkZf1meNLdSWupkZxBatR5b8n6Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kcghk5aV; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5aa2bd6f651so5963236eaf.0;
        Fri, 03 May 2024 01:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714724421; x=1715329221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3hH1YXLlyA1Xepv5zeFpL8G//5XUCXH9AjpKXyKmtRc=;
        b=Kcghk5aVMyBY1/vaFpDT3trMyEoFIiG2BulFKLaVKsP5FwNn40HTfEWWpK5DDNVTgF
         QOUWBCwLeV4JcnPbSPpQRr0UlvB60DNVHhXHx8X+DR465UtvA8x4FYtTggC7fb6knK+9
         mKLocIAZT3+VS+9fS8WCoqD1KeJN2dfUhqzeZ4II+keRIrsSm9tqNTUmppGJQCbwb7gC
         z/wt8FQq0QdVEA8LueqyEw5TPWdkR5oJo4WQOJwmHpV2C5ImV6DBQywIPGHXEn+RoPPo
         QnRkGG2UM3/UPUHgKJJvl0IQwhKxlEvwAt6BThFssga22yBzYzCzKswzQHJTjrPvPsLC
         aCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714724421; x=1715329221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hH1YXLlyA1Xepv5zeFpL8G//5XUCXH9AjpKXyKmtRc=;
        b=XnvFMubc1BxFZ5Xiga7eCANTA8OdRMWejQXxwcAKEWlOfvX4HpunToPPQ5RXwNrIAB
         yILqLUfd0g3y2ZEQdkjz6xchtWpSFC0aFTKEO8shfhwIEhbmXGnBkhq/cABPbH59tkF3
         CFlY7yGQKm/xJlWTN402s1v4A4Eg0DdgsmfwnvlFwYbvNDD+u2e3aNEVOvBnCZqEFYFj
         3EMm7e3NTK0sFv5m9HXxX4r0ntk74EXYDqwM8EwIXaef+360iUOE8F5vmRe06KjiUxRd
         1bMdnqyMRw58gbNaoIuE1cujuueXI2qyov2fRV8vfJ8mxF1PP+HArWZ1Wnymx6dayiTw
         Yomw==
X-Forwarded-Encrypted: i=1; AJvYcCUmEsR+iyQsb9LrCWA2+nPxK22DdzixRHSTBPtDlodKVtYJgACfUnH+JrBqksULpqjn6bIUJt70dJVzcQLmAhxRxi5M1WWfXx6YrObfUSS8LfU1H2XmOTqTq3wjyC1mWwFdOylpQ8zvAEHDs+DbAw2AZcthQlSsUnvIfnuGZcsOgw==
X-Gm-Message-State: AOJu0Ywq2Krjtr+zSEIZIXUnQ2NPXOD8M5vmc4elMA2dffNsYj9m2eIX
	b4IUTIeTs3EdjF0VUccSoyrN2ZNBrTG/SbX/IKnWaLJ/CH4frHFr
X-Google-Smtp-Source: AGHT+IGX/ND1xY8XwJ5CXNf6LkUuVIkOsSBWoWuk/E0wuSsHPBhj9ByTB65T3ot42p7umDDjfusQnw==
X-Received: by 2002:a05:6358:5912:b0:18d:7755:8219 with SMTP id g18-20020a056358591200b0018d77558219mr1767900rwf.32.1714724420825;
        Fri, 03 May 2024 01:20:20 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id bz20-20020a056a02061400b005f7fed76e59sm2283395pgb.78.2024.05.03.01.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 01:20:20 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 86C7218462B27; Fri, 03 May 2024 15:20:17 +0700 (WIB)
Date: Fri, 3 May 2024 15:20:17 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Usama Arif <usamaarif642@gmail.com>, hannes@cmpxchg.org, tj@kernel.org,
	lizefan.x@bytedance.com, nphamcs@gmail.com, corbet@lwn.net
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 1/1] cgroup: Add documentation for missing zswap
 memory.stat
Message-ID: <ZjSeQaPR90gV61xp@archie.me>
References: <20240502185307.3942173-1-usamaarif642@gmail.com>
 <20240502185307.3942173-2-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="crh03WeP2jR7Qlt/"
Content-Disposition: inline
In-Reply-To: <20240502185307.3942173-2-usamaarif642@gmail.com>


--crh03WeP2jR7Qlt/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2024 at 07:50:24PM +0100, Usama Arif wrote:
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 17e6e9565156..eaf9e66e472a 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1572,6 +1572,15 @@ PAGE_SIZE multiple when read back.
>  	  pglazyfreed (npn)
>  		Amount of reclaimed lazyfree pages
> =20
> +	  zswpin
> +		Number of pages moved in to memory from zswap.
> +
> +	  zswpout
> +		Number of pages moved out of memory to zswap.
> +
> +	  zswpwb
> +		Number of pages written from zswap to swap.
> +
>  	  thp_fault_alloc (npn)
>  		Number of transparent hugepages which were allocated to satisfy
>  		a page fault. This counter is not present when CONFIG_TRANSPARENT_HUGE=
PAGE

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--crh03WeP2jR7Qlt/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZjSePQAKCRD2uYlJVVFO
o66XAQCCDUlqsMuoqiEoVUacN+LWFuXAOwveu8ll93ptMzCLuAD+PmqqrXvbV07D
GbRC9OsCb8v87evI9zIURxytHAfibw4=
=No1B
-----END PGP SIGNATURE-----

--crh03WeP2jR7Qlt/--

