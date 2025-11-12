Return-Path: <cgroups+bounces-11874-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B01C53A0E
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 18:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11503426D45
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 16:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B0D33F8A4;
	Wed, 12 Nov 2025 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A/pWN8sq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F333133B6E1
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966004; cv=none; b=VgY8SiEKP1ecVLv7/p8OPUL5KFgIs4JRjpBWLsxcAld2V3AgnEbRavY4NknuqDfrs81blWoZBEtXf/fzJH2N2MmW29m16IHGEmg9nBwe2sUSX2PRd7H8P7ciapVRDFqdODijAlmnVykrqDewYDMaGnxyVxF3qB0oVgyh8XKu9Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966004; c=relaxed/simple;
	bh=mY8cKYvSvEzUclPyCJ8I6In6gVuK7rpqQ1KLaqxeHEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sw2zECkoqDiQ5CiNbuBb7mimB3MoJnJX0t+OHl5pei9S79FT/rbrQjhWA3KYjooo9gddu7ZPO1W5p4eOIwHlc5KY2AaQfSLLZ5G6+d00+l2//ulSmKOKLbI1v9GjW5FCVpaGfGb2tKwbgVZSG9NcMjZtorUp418WVTKOhTK2wiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A/pWN8sq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47728f914a4so6997525e9.1
        for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 08:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762965999; x=1763570799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pq8F2WamogcwOL7vszbG79DSQGNJxI4qCYOWd1i2eyQ=;
        b=A/pWN8sqIRAWHDAlYMFYVDFsboOOye+fENqs5q3izfRsF1naHEk7aR/ClEFVG/DsRO
         oGLehFz3O1dCXLGgWWytxT23pcTq1qgyfjxwlAXWMIHLydHKDw/0QnhbHvtw6ybFTnM6
         PX6bCPPAJgZ4bOs6jpGuFwJxod+ae8FmIkh2qchso/l3SL+bJ4Yr9DKa90fABqOBHg/e
         wCYnyMFSM4G0mlGxx5BBehdzTFkKYfOTU3jDBQ22dhA8DVV1EwlaEBxR/mQH40LH9Ne/
         jRANXFbXgxkZ1f7xTnBFwQs/yWxm5C6xKNWjay/PmpGA+w7D6tp8/SAQ2F6CLS/Y4wMq
         1PsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762965999; x=1763570799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pq8F2WamogcwOL7vszbG79DSQGNJxI4qCYOWd1i2eyQ=;
        b=jliVEiTc3jEfbvYGF/XQd05L/tI+lZgayN1d06UGstBDEckjIsPEjpvrCv5NdMCkon
         zQvBiN+QpHYlye4yVS/tUQyAwLzxt/WZkT2lX57Jp+mEvoIF391y13ZBBfzGHBXdVUjf
         O5dmKqVkJLGXltKJn7JtVbIddL/2VepQTCabn0JAxVeBTCP8fsQVM9GEs8iVDTXwhH/X
         oAL7bkqxfojhyiTR2dvL420b//a2kwUEty3W7EA/6L35GLftgZb2dre3L9LvGQjJ40fh
         Jbp2SeH/x5jVHFV3dXWbQEh7tebwW9Oy2NV+RjVV6NldGzPuSE27RQScFKfAF7xpf0sv
         nQtA==
X-Gm-Message-State: AOJu0YzPxpAm/qfZVgRibb6loc0Ogg6L6NWjCTjzw2rJG311O5nT+H2K
	GRt+l9ThSwQ+kQo0Mss8Dun0oXBAF5h9bXVwSArvfkRu4UHenslM06LX/3Hu36eOrqc3QEj3aOV
	9+BFL
X-Gm-Gg: ASbGncvPyhBr5qElxNWCctRLeBn1RRU+e9SSoz//GieqNbDA+TqVbOeSEMrSXlb5ZZ8
	+cerIc9T2LKdAG/5B/lkk/m9KZIgbw5w+EBy3hCoA2CLqMD4u3zUAVqBw+OQlya+lGQ9twrpeom
	VeACTXciA6lT7t27re/vZe1xH3UBF4qCfrD5sLIFqTHrdn5IcBI5Wji2TyHSiGf8lW6KErBvyM2
	wAHIgkj9xcUeoyJMYBgSqi9+8H1zWRvjJO3BSYoOinN86qa3YBVHBOOC/slJ4T0OnYyGY+2raLr
	nJC2zHgJPx0bCqPNLpF7SpsRyTPhkdNC338ev9LRpMzE/+wD1UgipJsIkxUU0xpj0z2/rANBWqJ
	jEQukvBhT9AWgUqyT3VaZuyspPjwCPoK1jb31eJHi2WKIK3EpE+bE220TXWPW4Alnp95bEkhg/N
	DhYHIqXc2/phfQsYZv4h1f
X-Google-Smtp-Source: AGHT+IG+XGouv8Vt9plADosIn8V0ns+Dnzd9RBW6+goqkfYQA0UwqchDgTDuQ++UBOZoL4xQyrTzKA==
X-Received: by 2002:a05:600c:4a11:b0:477:8a2a:1235 with SMTP id 5b1f17b1804b1-4778a98013cmr10906405e9.41.1762965999305;
        Wed, 12 Nov 2025 08:46:39 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e58bf8sm44852055e9.11.2025.11.12.08.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 08:46:38 -0800 (PST)
Date: Wed, 12 Nov 2025 17:46:37 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Cc: cgroups@vger.kernel.org, Sebastian Chlad <sebastian.chlad@suse.com>
Subject: Re: [PATCH 4/5] selftests/cgroup: rename values_close_report() to
 report_metrics()
Message-ID: <ezkxlfg4iiijokbwuxvlacc46h4mqm4eyl4nbekj3clcuna7gd@qrm3n2xh34xw>
References: <20251022064601.15945-1-sebastian.chlad@suse.com>
 <20251022064601.15945-5-sebastian.chlad@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ycusi767v4iag3be"
Content-Disposition: inline
In-Reply-To: <20251022064601.15945-5-sebastian.chlad@suse.com>


--ycusi767v4iag3be
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/5] selftests/cgroup: rename values_close_report() to
 report_metrics()
MIME-Version: 1.0

On Wed, Oct 22, 2025 at 08:46:00AM +0200, Sebastian Chlad <sebastianchlad@g=
mail.com> wrote:
> --- a/tools/testing/selftests/cgroup/lib/cgroup_util.c
> +++ b/tools/testing/selftests/cgroup/lib/cgroup_util.c
> @@ -22,13 +22,13 @@
> =20
>  bool cg_test_v1_named;
> =20
> -static bool metric_mode =3D false;
> +static bool metrics_mode =3D false;

This rename could likely be folded into the introducing patch.

--ycusi767v4iag3be
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRS56xsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjCYwEAyJu7IpE0kQSI52zTY2YD
cLIjotdy8nbgfV49eLhGHCQA/2qisjdp3q1lO4mkzhz4Z23sieTmw53801PAOfHG
WHYC
=bb4b
-----END PGP SIGNATURE-----

--ycusi767v4iag3be--

