Return-Path: <cgroups+bounces-7584-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A94A8A524
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 19:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 033E63AA7FF
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 17:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD271A9B48;
	Tue, 15 Apr 2025 17:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dQ/Mwfe/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307841422AB
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744737375; cv=none; b=IEeP33zgpD9GvN2rmUBGV8lYf2PLfHC9bs5ifeCRYUN61axFSj1qtNBsJHf5C/GkG3G6x+BfEOSBsJ9vt3eu7j277puuiGlAP0y1KTBV0nt4cSmoU1orQPXIlvwVUiLrfee4MizmoE0bz4UvvFg1xeJHuhjLfCnG+wdEoMfY7Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744737375; c=relaxed/simple;
	bh=+uW0DaTemcCFPxVrUS69KHW245gf2A0sk0OUdAXZDcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYprO5wErm+3vN14Ds6GWVlLuSATVwrXv80xLIGSelo3Sxx7mLPiluX6XGcVf+535xiCirCPd/zAm523cpjlHT1eHiNu7INSWph4fewVoreL8ltv4BMdJZtg1uHXsDhEr9n5iwC8xFIupnoAuo8ac/JwTBybM8TCdaLXnxfHqoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dQ/Mwfe/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39c0e0bc733so5045349f8f.1
        for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 10:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744737371; x=1745342171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ERO4Wi+Quy5FrqXdSDeWuZdTf9AiJ9u8j3TuvJNqgaA=;
        b=dQ/Mwfe/aaef0/n1rvjcGK0LzVn2Jg3oUY4izv9ijikxzdATZnREeu+e5P8y8g73/b
         Y9NnweN0ote3ONCzX8UG8z4a3lWDsfwg+3FRqeP3p+29r8GdQp6xjtG/DzQnEY4TEKvN
         jCgMHgx7iyGugopXOoCtIjqBEXu6IVo+/olhvF1dhni9nPVdWt0Z3KruPLWIBdT9ud9M
         3BaCXmY2Sp8NlL8L0DRN9GokuwyDWrRdr4d4Zer/Qm4QgIRpx8R09BZ6ZNfp5vFL33Gz
         4httcxEgVUpZQbCb2+TRA4hpB2rGJEwTBt4rjsXFSNqisxjeJgGAmu1tM9XRF3/PbyBb
         TPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744737371; x=1745342171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERO4Wi+Quy5FrqXdSDeWuZdTf9AiJ9u8j3TuvJNqgaA=;
        b=AfLXPh6wKaSzSTbv2GJl8LyWT4gXH/SS1IsI3Li/Nrqu7ACMBKz9W/u5t2XEP6A3gf
         1kYStRWHl3CnGHOEAdJMoJbSpMbGfHInx8g9lYZ3y0LmrpGoiW5f0R8n1yLwR1PB4EGZ
         ktNxFkCNGxCJ1T+8LJCdyOZmhKR09fOoY04RNS0EMtWEWz/Mhw+H3sIpfrbWC6soqxqs
         i3fvatEhxGO5fSQsX7h7bg/8WBI4LbdjCx1xDwPlvk5SZAxQGn6InbjTPq/o3lvhrpnn
         /ETpFEiHO4uYDgO24bLypuCPsN6kdgjPvK0hmn3ciE5zf8+xK9e/t50WcGJu25cD/dI3
         J3EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWkpitBzASP+h3S57OMiWjYTl/d+cJnYt4R4wvTaka47w6jfHpI3od9SCKj5n8xR00npzVXo8q@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8jFAbOy8ibfwv5jE4HDoI137ShjQYTAc/GdwXyDrKuFlooaZs
	Ui1LaBD44Pa6hBvKzazYLrc7eUxbP0YqGygupIFPhM3lcRsboN3NewlL+b2iNe4=
X-Gm-Gg: ASbGncs43RXwDmM1IWL6NRTfpcXCd7l+TcJsTlNywsHCzuj+J4SE9iXJx+dhdRrFvcW
	IaWHkW4NNk0qCJsGy/1clt5bRiGxbz8+BsAZ2QaH0ThvQVLttD9R6QiEJhH7sxfO3o/YYZ+97Ae
	CjseAe14OVLAADvAvf0yW5T+9HTeuNrDbirHf1K3kA9J3GIttKviHYBCDyfA3x9HX5Y2wj9sOmr
	ECGzhsx6FUItt1YwTMZF1SaFg2WyKLGWDDgtdA5LzpS3nx4iR9KvgcLMCHPe3WeSCKBRndyvdOG
	6U7KyoNTNzI88PFWC6NEYMdgEBHW4W9LYKPfirQdD4E=
X-Google-Smtp-Source: AGHT+IHVmDcH4GAWyjy/nXxuBoumLFUjgJCymM2NC4I43zX1XBQ8xJQ7+cw4eHL0lwCyojn/qvT7IA==
X-Received: by 2002:a05:6000:4205:b0:391:298c:d673 with SMTP id ffacd0b85a97d-39ee276006fmr224100f8f.40.1744737371401;
        Tue, 15 Apr 2025 10:16:11 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43d053sm15031214f8f.68.2025.04.15.10.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 10:16:11 -0700 (PDT)
Date: Tue, 15 Apr 2025 19:16:09 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com, 
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 1/5] cgroup: move rstat base stat objects into their
 own struct
Message-ID: <rdxrlqp6vpvy2lds6o6g6czjzeypsjj35id3oadvenkocyekwq@kvlmejgazbcs>
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-2-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i5my2ttbkie4uhcf"
Content-Disposition: inline
In-Reply-To: <20250404011050.121777-2-inwardvessel@gmail.com>


--i5my2ttbkie4uhcf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 1/5] cgroup: move rstat base stat objects into their
 own struct
MIME-Version: 1.0

On Thu, Apr 03, 2025 at 06:10:46PM -0700, JP Kobryn <inwardvessel@gmail.com=
> wrote:
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
=2E..
> @@ -351,12 +357,22 @@ int cgroup_rstat_init(struct cgroup *cgrp)
>  			return -ENOMEM;
>  	}
> =20
> +	if (!cgrp->rstat_base_cpu) {
> +		cgrp->rstat_base_cpu =3D alloc_percpu(struct cgroup_rstat_base_cpu);
> +		if (!cgrp->rstat_cpu) {
> +			free_percpu(cgrp->rstat_cpu);
> +			return -ENOMEM;
> +		}
> +	}

This looks like it should check
		if (!cgrp->rstat_base_cpu) {

But nvm, it's replaced/fixed in patch 4/5.

Michal

--i5my2ttbkie4uhcf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ/6UVwAKCRAt3Wney77B
SYlGAQDN59bNOgh3eUYfSAZkYjq9pZ6kNuNOcEZ96/iQtFJg/wD7BhiEuWiiIc+l
DgGbik0SSOQr1w67+SLei+kAJNFSqAs=
=xv68
-----END PGP SIGNATURE-----

--i5my2ttbkie4uhcf--

