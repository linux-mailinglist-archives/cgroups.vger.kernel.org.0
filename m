Return-Path: <cgroups+bounces-7455-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B83BA84558
	for <lists+cgroups@lfdr.de>; Thu, 10 Apr 2025 15:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A024A55C8
	for <lists+cgroups@lfdr.de>; Thu, 10 Apr 2025 13:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335FD28A3FB;
	Thu, 10 Apr 2025 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mk9oC8Ci"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2771519A1
	for <cgroups@vger.kernel.org>; Thu, 10 Apr 2025 13:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744292833; cv=none; b=WOFuOBcZWaMk/PwJdq9ZklJZvTXCaW+aeKB8oUbJSz3WqzwTPuwWRDEWVYzGaezvGFDiLd+w4LyATQe+JJrxmQ13vtIWBTQFEM/0hwJuG1UYlsPSsqtwPDQgQBpXYbFNeEF12UHIv+YMY6w85Okngbv5zDXuaPxrzI/gKxD3jtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744292833; c=relaxed/simple;
	bh=4b9272PBm8zs6TURGhpg1ANgpmpR6PaBZxZkWeDeEHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYYpVVgLKTVRH54RuJT8t3nI20SkTvZ4Kd/ANmsSuv2IzS83efcAlNa4GtYvR7EGB0EDZHy/cmrT5uqFnfplBgRzcfstbosbeEjveoiQjzmPfntAZPOvteIyaLMIo3yLurSBOa12zod0TBSAUUfmS1XnUKGn/NWQuzDbAMGEAIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mk9oC8Ci; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43edb40f357so7444825e9.0
        for <cgroups@vger.kernel.org>; Thu, 10 Apr 2025 06:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744292829; x=1744897629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+9TWPr4cIFFLNnl4cBBmSOXCekcTbC/DxVvbdg+OgM=;
        b=Mk9oC8Ciseix0Lc9kzOm7O/CrVcBc8ogo8t3nGu2efGsUpin5FPC/2BkM1D4lVl7gq
         sbwpnxZTMlFNLdhnVwadktRsdl3q/mJkxZxr1OBBM2i6tlU4v0ppICZrrODtzKUg6kwr
         y/PmrXN6Fip2HnGhrYMTxkuOu07dGHLyayrXn8jYLUMAFINTbZYSgNYVFfA8CWhtqe4O
         tqwDtAIjtX0WLOoGP8aIwDCN66oTszueE6qNelX61SQTpWLsaiyqcoQYwx9QkDfuxgjz
         yCsHSK4kZeU2HSI5yo7pZ8W+YqZGvufXIJHxix8nGUBSxdSVf3WgraVDTfcrCRG1/5RK
         0iIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744292829; x=1744897629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+9TWPr4cIFFLNnl4cBBmSOXCekcTbC/DxVvbdg+OgM=;
        b=Cqj0+BRlwXI+os1qvqYI8HwOwuuuEegN2acPQ3d9s67BNzwmOhvjtIjM1PRatZ1krk
         9sDZn6AT/ytmz3mRXteZ/s6olZXcOYYbeROzkKFobPzOxOcycun9bBIvyk+y6JfFIo+V
         h2Vf+bqqg7gXIQQXQ2YaibEweJO0y7vR95YtBwOxHRI9dBcZLOhswaIkLZ1+lGgH8hd5
         eaP/Srt3LAtHCv3vF/pcGojPCt0+cWqeb/bK4qoYyo1MpTsMT1VhIAfk6tByefKDj2D9
         F88fnjdx0exTlYv5bk/cIt7R6xSWakgD7hBEYtFWj6paqdpoynqlLTp36VXwG+Ttu0VY
         fJ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUifHxvlw5a2E/9P4dSohELJt0ZUToUFxOl5PkUxCbTfxcHXLzwkssuFYcsPZcCpZq6Aojdgxeg@vger.kernel.org
X-Gm-Message-State: AOJu0YxwBGaLNIcFIB8rW3WFbywPWaxIMjg4fqC0xoARrgSXS2MnjNYt
	LOQ8beRt9+XEzXTbJclHBLqdM6Ea0dH5ufoc+VN5qBnAS35eAJ2co0GTMLvao0I=
X-Gm-Gg: ASbGncvRAFjiSDlMkt02twjl+WR0e96rBJim/sG54+34TBl0UAvA0/EWqQsfkelz7tW
	T7gO2T/NSmQzDdI+rC5aNq8HCHO7jn1ipOhbyBZcyPzQy14H74BUHFIH82hN1n8Wu+pVBpk9U+j
	TMe9v/TgIhcngOgBUdS7MUm2L9yYz3HiI62EsOxmfr+HatvwCFtZqsQZXaOza2kgU/FptZoVX0f
	10ytgqWbjTWM7fSTzQtNzAT9q1EDAkOVD+s2/O4BXjjr6my8unnazqcshpA5mvUAXCgUjGquzbC
	meJOn0MeKl3s23y71LSBhFMccaD0KHF6nJQFHfbnFLk=
X-Google-Smtp-Source: AGHT+IGJpePNvVyjgvmav5Kd5AqQY4lDiNg+UquOUe0N4IN23Wm6xkWaUOUyn4V50aiJmmCXeU8IOg==
X-Received: by 2002:a05:600c:5248:b0:43d:79:ae1b with SMTP id 5b1f17b1804b1-43f2d7bc45bmr27374935e9.14.1744292829089;
        Thu, 10 Apr 2025 06:47:09 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d004sm57414615e9.18.2025.04.10.06.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 06:47:08 -0700 (PDT)
Date: Thu, 10 Apr 2025 15:47:06 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, corbet@lwn.net, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc,cgroup-v2: memory.max is reported in multiples of
 page size
Message-ID: <la6q2koug4ohzcfc5eqguod7x6fdwhndqkhzfrttsfnjo5fbb3@xzxodtpjl6ww>
References: <20250410133439.4028817-2-vishalc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cbkayfgiworvjsdj"
Content-Disposition: inline
In-Reply-To: <20250410133439.4028817-2-vishalc@linux.ibm.com>


--cbkayfgiworvjsdj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] doc,cgroup-v2: memory.max is reported in multiples of
 page size
MIME-Version: 1.0

Hello.

On Thu, Apr 10, 2025 at 07:04:40PM +0530, Vishal Chourasia <vishalc@linux.i=
bm.com> wrote:
> Update documentation for memory.max to clarify that the reported value
> is in multiples of the system page_size. The following example
> demonstrates this behavior:

This applies to any of page_counter-based attribute, not only
memory.max.

> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1316,6 +1316,9 @@ PAGE_SIZE multiple when read back.
>  	Caller could retry them differently, return into userspace
>  	as -ENOMEM or silently ignore in cases like disk readahead.
> =20
> +        Note that the value set for memory.max is reported in units
> +        corresponding to the system's page size.
> +

There seems to be mismatch in whitespace to surrounding text.

Also the wording would be more precise if it referred to 'multiples',
not 'units' (units are simply bytes).

Michal

--cbkayfgiworvjsdj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ/fL2AAKCRAt3Wney77B
SRSNAP0bnJApWLajoXwxzl1ghVWKw5zQVjK3WrLIJrECXtDDewEAugoDnnl7QTvl
4H/JYvFk91gyh5my4GuIExOBCwcMQQs=
=2s8B
-----END PGP SIGNATURE-----

--cbkayfgiworvjsdj--

