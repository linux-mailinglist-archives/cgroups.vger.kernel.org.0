Return-Path: <cgroups+bounces-8450-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7B5ACFF61
	for <lists+cgroups@lfdr.de>; Fri,  6 Jun 2025 11:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7BB1736F9
	for <lists+cgroups@lfdr.de>; Fri,  6 Jun 2025 09:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF14D20297C;
	Fri,  6 Jun 2025 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MRA303t/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B962A1D5CE0
	for <cgroups@vger.kernel.org>; Fri,  6 Jun 2025 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749202504; cv=none; b=p8St2BCiUR6pp7g+AaXTDXs0R9kgKhXM2ScVDLzw4oOlH3NXAgPkFyWu9yIoNR8KyncIg1W7kREYJl7zOeZSyE63gFFjtkTjEwWZZtnC3KffuUgLYh3Gyf3tpq3hygXzV/jznYUBRMDGHfKZU68VfRLIOI61KZmpz6VvrB1MvsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749202504; c=relaxed/simple;
	bh=WgAzWRE7She4otQlVJzaMK08pPPq7NcuL5CVfsMI03w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+h+50HzBgVITMJ0RZN2iyoJ0OXoQFlFVVMiFE0mszlUN8iB8jWurVhszITA8UlwXZPFbxx9Jb44j7bNYVNJYkJwlHnlKUsy9dKIJbhxoYTOHuclxYCJ6FL60bqbPZtP5sO3M3w3o76NWY9Lkb4cVusVWSbakILCzuTfACKQ+ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MRA303t/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451d3f72391so24723085e9.3
        for <cgroups@vger.kernel.org>; Fri, 06 Jun 2025 02:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749202501; x=1749807301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=16WVU7r379wE285Rct5yNMoMsint6/gzKjFKMpi3cK4=;
        b=MRA303t/swoE9ZnEjcNKszLUaoKTtTpsMcjuwrh1eTyRuQM9/5DQxrqXzusY5nkSUo
         aC4F6+mDxqpx/xwFQBnhTYE4+2j7Zluj6mityfUKNvpawAywN/J0vGluT10eRsoD63h1
         igJ3oNbYznJK0IfYSfyZLzvzFok1+1/ku4Ri6J7SnyWpnsonEgB8vbTJuSs0yShF9k+t
         QArUuG6Bu0rauzo6OdxTQ623z7wiLnF+ZnN7jdy2VoQ+czBeAyLndH2Y0wfZvhDc0AlL
         rRKSJp2mvwjp5sgdfgoXzpEjgFSWSpfV0+bBOZA1Q8WXZnHDIG7Az/ThGjiM0bQiY1MY
         t/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749202501; x=1749807301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16WVU7r379wE285Rct5yNMoMsint6/gzKjFKMpi3cK4=;
        b=B4ZrB8EYrvbq/6dBVOjvYt/W9U3jRN3iwS14nWG+9VtESEE5l3ifPDH1MD1csXHUAL
         Ww+Mqx+p7HQ48iEC1IlkMuFeIISQev940cZy+vJ7shZ5KhQPmvsqaMQw+pkUfGvO6vTS
         njViu+gaMzj8CWRYfvqJ0/A98hLlSrqZm8CWZZJISZfsyKdOyw5t10Geh+qYco+2Qy9m
         T429D1VXCDX/TJkX3+WVaiw1ozzrJI/DnfBPlJtJ7kPmr9zd0e+sp4IzXRO/5BnzDn/A
         VphySpTQ9ZH4igFMd2RKh8M7qCGM/T6qEr522XhF/JGzpRF3DBTm3hPIfMJN7WEklsyk
         qgsg==
X-Forwarded-Encrypted: i=1; AJvYcCWWGMvAGs9hJOQ5nDhk+WPveznz+kFLwqDr9K0R/0R+thuNlf1z9MOxBa9mzvY+GaYw7b3PuFCE@vger.kernel.org
X-Gm-Message-State: AOJu0YwLziNkAJ5B0V/6dkA2NDyP9PKmz1JIFnuejB4OHq2VIUj1AXUU
	47gmsUzg+Y6dKKYa7pkeR/zMgPpGK1j0bb47fqBRZmcouUOgcHolxd4uaczK2J9v9gs=
X-Gm-Gg: ASbGncue5cRA8LEHfONyq/UZDKrfaapxzfBzntbJwH71nX45EeIy3SzUxDwUKUfDNgv
	bKUyyaNQF+SaHy/HTIPwq7f8SswE7src7sxpDeuZzBWB47ucNswuZ/H00rrDyu/rSWBnIIUw/7X
	B5lmuKJZfplz4Uw5tfp7taA4h+QtkRJJ0jUDVPXgvLeutLX+QnZanlqQKmCy77C+PRKr2iGe6UU
	sGuQeJPb8O10Ss6gHJPjV4lV1qAzOEU4R3iOd1EqYTTWNGH5AHqPV0OzEv7fKBNrinNhtlY3ksZ
	/I3xb2yF/SXxujo9qHuy1y4I+unoLb7SBq0pPZVOPSTIJr7Qgeu67g==
X-Google-Smtp-Source: AGHT+IEXrINuMkdEIP9xCA7rioc8ocp0d0MYKrrke+NTaRENXHWiMhnlDpotpkYsrzCiqFR7r81jXg==
X-Received: by 2002:a05:600c:4f0f:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-452014d74b6mr22334105e9.20.1749202500773;
        Fri, 06 Jun 2025 02:35:00 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452730b9beasm14825415e9.22.2025.06.06.02.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 02:35:00 -0700 (PDT)
Date: Fri, 6 Jun 2025 11:34:58 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Jemmy Wong <jemmywong512@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v0] cgroup: Add lock guard support
Message-ID: <fo5le4uonsrv24z5gikojq7hxwaqaidgco25pypnppk5h2czap@egdwx6yte4lf>
References: <20250605211053.19200-1-jemmywong512@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ua3zb34t3kfdq7gf"
Content-Disposition: inline
In-Reply-To: <20250605211053.19200-1-jemmywong512@gmail.com>


--ua3zb34t3kfdq7gf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v0] cgroup: Add lock guard support
MIME-Version: 1.0

Hello.

On Fri, Jun 06, 2025 at 05:10:53AM +0800, Jemmy Wong <jemmywong512@gmail.co=
m> wrote:
> This change replaces manual lock acquisition and release with lock guards
> to improve code robustness and reduce the risk of lock mismanagement.
> No functional changes to the cgroup logic are introduced.

I like this.
Could you possible split it to individual commits to ease the review
for: cgroup_mutex, css_set_lock, RCU and the rest?

=2E..
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -382,6 +382,10 @@ static inline void cgroup_put(struct cgroup *cgrp)
> =20
>  extern struct mutex cgroup_mutex;
> =20
> +DEFINE_LOCK_GUARD_0(cgroup_mutex,
> +	mutex_lock(&cgroup_mutex),
> +	mutex_unlock(&cgroup_mutex))
> +
>  static inline void cgroup_lock(void)
>  {
>  	mutex_lock(&cgroup_mutex);
> @@ -656,6 +660,9 @@ struct cgroup *cgroup_get_from_id(u64 id);
>  struct cgroup_subsys_state;
>  struct cgroup;
> =20
> +extern struct mutex cgroup_mutex;

I assume this was because of the BPF code, which wouldn't be needed in
the end.

=2E..

Thanks,
Michal

--ua3zb34t3kfdq7gf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaEK2NgAKCRAt3Wney77B
SVT1AQCRa4xOZhTwPK9tNZnPZhJdBQ0U0Y4hWIj1hPsIJzCwcgD3Xdkw3M+MD4HW
muBCdmP7vHKczXzk4Fal9QO7O72gAg==
=8HJL
-----END PGP SIGNATURE-----

--ua3zb34t3kfdq7gf--

