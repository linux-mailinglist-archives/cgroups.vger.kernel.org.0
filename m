Return-Path: <cgroups+bounces-4957-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F41C29878EE
	for <lists+cgroups@lfdr.de>; Thu, 26 Sep 2024 20:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 306311C21D22
	for <lists+cgroups@lfdr.de>; Thu, 26 Sep 2024 18:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C327C165EE6;
	Thu, 26 Sep 2024 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZsGu4eHF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BF416088F
	for <cgroups@vger.kernel.org>; Thu, 26 Sep 2024 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727374240; cv=none; b=lrWhTLEUQmuGzoejDtCxYs02umvdghCwL2g/2Pn79z8hg4+pnOXhrlfEZ1x1jp/boJZTXQbrdtTWLB2EQ7abF/JEqVbCLz23JGnifN/fd4CHcdJITuuOEXq7hv634ObiIdUZoLFEme4Thww0+oteWUrc/86VNYBBfxux75v6TJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727374240; c=relaxed/simple;
	bh=tEGhy1y3hxikKXA90z5wp7UYXddJC1lR3CMHAlfnVRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E06kSRXLUmK/otilby5vyduqKIDuQcy1lKJUJskB4snxDoi6hhrIyZh5wWI+4Kk5MoKE4CKrpkkj6rYnKmYXdea987fXWtIiBHA+OfiA0WVgAbGxNvKRoaXAJOYcDR5W1Qy8hf+T4Zp7C3FBUjgBVGL3OGvNxYcRbLXKTpBBARE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZsGu4eHF; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d3cde1103so171992266b.2
        for <cgroups@vger.kernel.org>; Thu, 26 Sep 2024 11:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727374237; x=1727979037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tEGhy1y3hxikKXA90z5wp7UYXddJC1lR3CMHAlfnVRw=;
        b=ZsGu4eHF11SqHfY8HcLgxBKM3+C+663yLaLGbHzilNFyNtnZ+jR6YHIs8g6qDslqDc
         n4vS3dVWn8LZf/k0HN4R9YTdzF6IYxGezD97u5/uOxxTxhG0PY3QEy7cSxNRkT0jIdr4
         s11Rd1sWrp30VcRc5rNcIQlSgV967ruir3h7pgeSbKJAGGLswocqFvkGqPZY0RjU8Cqi
         ZRmEfhksqfh0PciowAhVeNnnlhCxl/E0qz8tirlL512sGrgqHIrzVGz6mLiYzZmQ587h
         9Ny2LUpeWMMtYBbl/WCqlJ2nhyO5tGSrlJDwp/nIfw26XgYTJpH3PuljGtEG2AJrnJS5
         NsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727374237; x=1727979037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEGhy1y3hxikKXA90z5wp7UYXddJC1lR3CMHAlfnVRw=;
        b=uzgEbiuoSqYOx1NZG6MRnDqdTCzSUOcY99u+dxyTCvQXDgxutwUHmwtivyij4eA4ot
         YbAZwDylY2hF6hUfU9uIazWGkAkTcB5KCVrPvmSZ9kkKBFiO2lWnXeGm7ziAjBYuTzcE
         e6/MZRuoNB6Cm8bOayi5J1vwJFE81V6K3pJczYchMmvXoQPuhACJDzfErexvt/SqA2VP
         MhOnc/9yd1qHlpkIDK0UIG9HgGJMh3dr/j02KrEVPgEM0MP4bWKkFPIEYXG1BxtNnF8m
         eCgVQ9kloj+o6IVoT0qWpAx4uQc/lpHEvQCoz1I4mg/xbZUjoWJHQldGCKvX+7qw9N3t
         WGMA==
X-Forwarded-Encrypted: i=1; AJvYcCUxee9KNA1VSXqZoCHGK05zW7mHMfLrXieGwMyizSje6cHGAjNmgBn6JFmY7mZS6zsJmd5lb41B@vger.kernel.org
X-Gm-Message-State: AOJu0YxMd1/NR9XJFbEqZ9Vjt/M6mBFEHLuDQmSpWJpvM/zPP0Xdu2nX
	jPEZvaSvriK7xItquPbrNoy2PIkv2ySfQYnEhEUoxaIemVvZIHMiXI0nWDFTwQ0=
X-Google-Smtp-Source: AGHT+IEfe8BpSSgYBcwUqahCkfmDSBMc3otDpIdlgBIMUSWhz79v6I4cHVtltnbs2o3FtkBUNGafGg==
X-Received: by 2002:a17:907:6d1a:b0:a86:a41c:29b with SMTP id a640c23a62f3a-a93c48e80bdmr36738166b.8.1727374236956;
        Thu, 26 Sep 2024 11:10:36 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c299861bsm23451366b.192.2024.09.26.11.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 11:10:36 -0700 (PDT)
Date: Thu, 26 Sep 2024 20:10:35 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: tj@kernel.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, lizefan.x@bytedance.com, 
	shuah@kernel.org
Subject: Re: [PATCH v3 0/2] Exposing nice CPU usage to userspace
Message-ID: <qjbbaywlodoojlb5n3vavgck2jrffofnlzpf7pc5h7fsyu5y7o@oqh5vbuns7ve>
References: <20240923142006.3592304-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o4xm45ommiv6myew"
Content-Disposition: inline
In-Reply-To: <20240923142006.3592304-1-joshua.hahnjy@gmail.com>


--o4xm45ommiv6myew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 07:20:04AM GMT, Joshua Hahn <joshua.hahnjy@gmail.co=
m> wrote:
> From: Joshua Hahn <joshua.hahn6@gmail.com>
>=20
> v2 -> v3: Signed-off-by & renamed subject for clarity.
> v1 -> v2: Edited commit messages for clarity.

Thanks for the version changelog, appreciated!

=2E..
> Exposing this metric will allow users to accurately probe the niced CPU
> metric for each workload, and make more informed decisions when
> directing higher priority tasks.

Possibly an example of how this value (combined with some other?) is
used for decisions could shed some light on this and justify adding this
attribute.

Thanks,
Michal

(I'll respond here to Tejun's message from v2 thread.)

On Tue, Sep 10, 2024 at 11:01:07AM GMT, Tejun Heo <tj@kernel.org> wrote:
> I think it's as useful as system-wide nice metric is.

Exactly -- and I don't understand how that system-wide value (without
any cgroups) is useful.
If I don't know how many there are niced and non-niced tasks and what
their runnable patterns are, the aggregated nice time can have ambiguous
interpretations.

> I think there are benefits to mirroring system wide metrics, at least
> ones as widely spread as nice.

I agree with benefits of mirroring of some system wide metrics when they
are useful <del>but not all of them because it's difficult/impossible to ta=
ke
them away once they're exposed</del>. Actually, readers _should_ handle
missing keys gracefuly, so this may be just fine.

(Is this nice time widely spread? (I remember the field from `top`, still
not sure how to use it.) Are other proc_stat(5) fields different?

I see how this can be the global analog on leaf cgroups but
interpretting middle cgroups with children of different cpu.weights?)

--o4xm45ommiv6myew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZvWjmQAKCRAt3Wney77B
SQ8WAQCp29FbziRN/KbfWQPcfAVt7SDahK/4JWtmK3cAW9Ev6AD/fINR453pWEMR
b2Nxw2R0JPWdmbAjsReOZPift5TgNg0=
=bl5O
-----END PGP SIGNATURE-----

--o4xm45ommiv6myew--

