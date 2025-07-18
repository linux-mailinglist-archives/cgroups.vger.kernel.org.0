Return-Path: <cgroups+bounces-8771-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5501B0A486
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 14:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A3D1C44069
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 12:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967AD2D9EE6;
	Fri, 18 Jul 2025 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PTiAW9c+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D132D6635
	for <cgroups@vger.kernel.org>; Fri, 18 Jul 2025 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752843327; cv=none; b=Q1mvsagl9qoPwDgtB+pXaiWte2LjN7t3qh9kflpLuW3CuTqQI9hSCZeDOmolxBxTH9T4VgDSGO1ulyv8yR7dFk++TsXNDTpxjEhlN02TTNQ16fOTUWrX75xo+Ud9j/P8xi3aqF/Eo8oa94mVn6BE8Jl04dNE8GVfhkvRPzRkXvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752843327; c=relaxed/simple;
	bh=8IJKjEk55ePflG+iNS+MR2mxQCyHY4vH6f7Igu2l0dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cn23w0SicWMHW0iynPx6wZ/3jNFJrH7zfdM7NHkornOAx9AkrxE+DnvZPeGrVYeHv7NXiN9PPa1hS513Pm3f7mUXptuYJ3NPjFtj8U0d19zHLfXsXzBOV8pmJ6z7eHV05/rZaNNNZ5MBNIcvTCQFEKfZ7YWekoS4f84udlioLSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PTiAW9c+; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-607ec30df2bso4158296a12.1
        for <cgroups@vger.kernel.org>; Fri, 18 Jul 2025 05:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752843324; x=1753448124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TCxzk14FWSwkmRa/OG1KGHyK6K9KE9Zr8Gq8f2yb4aw=;
        b=PTiAW9c+Lz+8SaSM5JJKfyprCZlu7ZMHjBvL4R8k2YYvTvEwFG9/eFoCUJqBz10yH7
         JedMKZNQcbRTd7ObmbYtXvzd3Qe6Mc/GpG0wWamth/mIJozVyhYj3MdrV/VZa/8YWB9t
         1edtZ6PFRHg08X9aZPFyQzATusZ7aEOA6PVQXFrnCNb0IuoN9KRiiqddpvC6amtFuaCM
         VgsHIADQVubd8JlyFjwHHGwR9sP5tsKj9YSNcrjZlWznw0XMIH+tapX+pW2VSCyF6gBQ
         ucFHNCPtivdleAuW2Rmfxte2/eIZ8U1B053R6mGglCEQ9Fhuly8CktUewIFgF8PuZgjp
         pdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752843324; x=1753448124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCxzk14FWSwkmRa/OG1KGHyK6K9KE9Zr8Gq8f2yb4aw=;
        b=K8fz0vq+KejU4LMIMpfmTQ9MgIvJoeJZusm8qc5D9yi/y82jkpfRSp5clW2Ik29dDn
         MUL/g4xcB4FI4n65RH6tpU3aXZECPKaXimgoE1j1/05gYZL6/vaW7qoD2aXejczxla6y
         BmOZkCqBi+eVXcW4OcIDYJw+A5ZJi3l7dPTJuvs8ZcW+fNMvgDPU4HFYugFOz9NWicfg
         sELq3Jg5+//64ZesAm5YWCiSN7IIl+WqlNd9lyBk7dzhII8Xxcqe8VbXFECBczcDrZF7
         MaF0vWpoV6DGZmJnFn/GjN8Qc4+VyQm7rN3lG53atEr4oRP+NndsS1R1Yk6+Unk5lnH0
         l5zQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5xWPbbzH1mRRf1WtdPnWqNH0ONJ2DqSLABKPgnU+abqPqyjki7h/+SSAUwsxmq+MJmWkoy95o@vger.kernel.org
X-Gm-Message-State: AOJu0YzPmEhCsFKrnWt7U9LWQAlF2fh+5UiLtqKt2URVsLywDHTcwxUu
	h3r6CB0KZJ/VViqhSQ694w0OxgtXLLztUCxMGpunto/IVjiLD2HKEYvgLXa5kapWUtc=
X-Gm-Gg: ASbGncufZN5KNQbrv9p9UnsbR6ZY/gSwLVFbX2c1AJy9J1u89ussYn4uCxP3TOptSjw
	5mcJ1JTSTHOwuw1/LPEQaOm9GVm4wm9+QBzJHQXDh5gQV0+ctPgi3vnI2eyibr0/E7l7ly8vzGc
	wzj6Qlw8hKqW4nR3ahpWfvuVHmdeEM5VXo3JFkD4eMokGp2xphriCSXj84lN9V0TsMYI5LA3zxf
	kSHe20YnZRShxNFv+62OAbBDF8pAWMjfZjgQVR01hwFkj2enGE3+kFfWddMFhNkkXSWrYm5Gqfy
	23N5PBFzF0Wuis5vrJYg+nHwgliahn5q30dFsH+IyIRO4M4aSMSnQ/itgJQb9TlFcWuHcqllfj8
	BYg0ilz65s6Op+ckq3Jgc7NZS1uowruRKWHBHSIwRMg==
X-Google-Smtp-Source: AGHT+IHMdtSzyQu2KatLxBDlAQQxTotw8jfYZxlXV4WRCfZvX2AHS6thniTmI7PY59OB5DVyF71Ngw==
X-Received: by 2002:a17:907:c808:b0:ae3:a3f7:ad8e with SMTP id a640c23a62f3a-aec4fb05ee0mr708682966b.25.1752843323746;
        Fri, 18 Jul 2025 05:55:23 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6caf76bfsm116466566b.160.2025.07.18.05.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 05:55:23 -0700 (PDT)
Date: Fri, 18 Jul 2025 14:55:21 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Zijiang Huang <huangzjsmile@gmail.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zijiang Huang <kerayhuang@tencent.com>, 
	Hao Peng <flyingpeng@tencent.com>
Subject: Re: [PATCH 2/2] cgroup: Fix reference count leak when cft->open is
 NULL
Message-ID: <vlgk7nn72odfg4xk34yagrvtwlqb3qkq24wbsrvjctd4upa5vm@7jg2iy7pkqof>
References: <20250718115409.878122-1-kerayhuang@tencent.com>
 <20250718115409.878122-2-kerayhuang@tencent.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uydoxl7wjkyfaz5w"
Content-Disposition: inline
In-Reply-To: <20250718115409.878122-2-kerayhuang@tencent.com>


--uydoxl7wjkyfaz5w
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] cgroup: Fix reference count leak when cft->open is
 NULL
MIME-Version: 1.0

On Fri, Jul 18, 2025 at 07:54:09PM +0800, Zijiang Huang <huangzjsmile@gmail=
=2Ecom> wrote:
> @@ -4134,8 +4134,10 @@ static int cgroup_file_open(struct kernfs_open_fil=
e *of)
>  	get_cgroup_ns(ctx->ns);
>  	of->priv =3D ctx;
> =20
> -	if (!cft->open)
> +	if (!cft->open) {
> +		get_cgroup_ns(ctx->ns);
>  		return 0;
> +	}
> =20
>  	ret =3D cft->open(of);
>  	if (ret) {

1) You wanted to call put_cgroup_ns() instead of get_cgroup_ns()
2) The refernce needs to be kept during the whole lifetime of
   cgroup_file_ctx, this return path still leads to a valid ctx, so it's
   released in cgroup_file_release().

Or could you decribe more how could a release be missed?

Thanks,
Michal

--uydoxl7wjkyfaz5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaHpENwAKCRB+PQLnlNv4
CJS6AP9o2W2dD9M35Rn+YDuf7/+TjAsjRe0hI78st/4KabFwfwEA4VyCxW3CCeJm
wPAo6jXhcovxRqkp7iAGgCzzl2oHzgo=
=X3JP
-----END PGP SIGNATURE-----

--uydoxl7wjkyfaz5w--

