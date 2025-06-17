Return-Path: <cgroups+bounces-8549-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EC2ADC5D4
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 11:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C6A3B98C6
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 09:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533FA294A0A;
	Tue, 17 Jun 2025 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y0djug0p"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEC429345A
	for <cgroups@vger.kernel.org>; Tue, 17 Jun 2025 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750151359; cv=none; b=My51Q6A0BXO7q6WeN2Z/QqTrT4AsiJwFw8Rkp5xyxvJReC5gz91yAKROFTNQCmnkEICSeCEMyKMf69+ckYCbjX64+XcPe0dBXR49c1FTwuyJmNazr+Y43+4kTmi6OFG9zdj4iPQdoj+vZJItCB+efLjjYtOFuJQy+Jx1WCU2OuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750151359; c=relaxed/simple;
	bh=1EuzBJOTCRuTh+bXUhNXXsRstdjUOzQiLWRMoOTqmZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMI0ZBMOBB5FnzPZzEfrRNfSluTfnaYrEIk9+Y6RBQSmKWk64N+wfMaH4WcnW5NxMRyoY7jAYSZ9veC3OvDA8UnV1FtzLNh/M9c2Foolj+L6z0SVAtlEX5XoY/ruCTXsMSx4HDSnylsvDjSxuCO5k+4RItE/D0uSh0kwDniDfnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y0djug0p; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-453066fad06so40659845e9.2
        for <cgroups@vger.kernel.org>; Tue, 17 Jun 2025 02:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750151355; x=1750756155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=67hmXdGYuBxuLUIzFKnoNocDhsxtxIrQkBw3JogtMN0=;
        b=Y0djug0pKpAXHSE/VS6fpBhf+tvkKX88RtcRVHK1bj4Z9g0eQOKmISkxfeGFoO9s+j
         Tiz289wX7T7tMb3kEJeyGBwcdIRHIHBDR48HYnvnUSWBKZyVLScSvatIxRP7oG1IL6a4
         69kJpBMVD6hhmxLkQHIteTTL7+WxI+0XIo8gSN3IVRzotBGKLDuzIVUQycBuJJ/V4D25
         qaTlBkBR4uCglqviHayXFhbUUygDnSQ8ApSOS2brOZguDE+Q+d1IswLQtwvAyIqN/M3N
         U31snEotvU5xJKuu8DEqjoF7eu8gb3y+lrnZUL19PSWpBS4K+iktcDB/T7/JCuL+Un7U
         hn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750151355; x=1750756155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67hmXdGYuBxuLUIzFKnoNocDhsxtxIrQkBw3JogtMN0=;
        b=rp3yluk4AEDTW24wI1eE/d+HPcWCf1rp2rO1W0ISARicYfcAIp5BgOBdnddmdW+zzX
         wqLxmEKR428FQmzznkDWuzyc/tErcUvTXAcTiDie/wQF+75QXm6UdYoohJVTUqVMK4tk
         unZqj33rdE3K6quNckftFQ1NsD/K7QjfFMCuhtmS20gmshl5tXv9gK2eOlw8zjQHb9RH
         SFYq6H2IhPHyLwKqkQH8gTr7lVlC9ii1mNn2lkvje5G4djBH6cw73bXkSivLG7dDFEI+
         CKX1x0AjuAc6BgW/3d9Sc3qb89YrroGNxX4mDYahOt0ex8+FAFmQKTMsxwN6BMp7EXEi
         RQgg==
X-Forwarded-Encrypted: i=1; AJvYcCWlJo3YHPZr7a0An7FU0Y3r77dakT9mw2gkb88qN9q+5w3EX1/Jdf0j9ppc2cQTaKPLBy67blzL@vger.kernel.org
X-Gm-Message-State: AOJu0YwcIfd+6sYMtkeOQ1BnpTcWJvyJzLO2MDyudul/O7gtTS0/1gpo
	3yqYAYwyxbanOv06wZOJNvyQpTYp724YnAtOgEuALaIQSVmAiBufkx+EPZ8e/63moyY=
X-Gm-Gg: ASbGncuWY7r7obYfQzFNE9HMAaowyapo1+N6kPY74N8mydrY3/hJXMtej/2CNB8eCbG
	rk22is7OorqAEqwVKV7dhx0oQ/vPoZYTU56kK2F9HUzw+QaaZPiWZC5yBEC7p38zbXF0ayBtxW2
	oUoi+BhHxEJ11WVJ6aIts//3nSEyF0xYPx0sPojKpe6Ht6PsRzX/QmtE2RZ6oqeikCJ4exunjTl
	rlctre255en83govyjMtMDuJTIp8B4ygUbBzI00yx3JfqCr4/vTS+NC1dmwrqrd1x+HvryNT/ec
	e52DRqkAs0Yynft7SGafuJ1gHT5XGBKRzDiiOj/ZHd+S1ytlO9LyQos/L/73+wER
X-Google-Smtp-Source: AGHT+IHDLDoidxwK5Hm81mzEBaOuu2RD8Lte8EMwlWR3lvsilQqT7tB5ntDOfsObExewaMZ36iQ9AQ==
X-Received: by 2002:a05:600c:37c3:b0:43c:fe90:1279 with SMTP id 5b1f17b1804b1-453561ce33bmr274155e9.21.1750151355356;
        Tue, 17 Jun 2025 02:09:15 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e2449f1sm173368565e9.23.2025.06.17.02.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 02:09:14 -0700 (PDT)
Date: Tue, 17 Jun 2025 11:09:13 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Jemmy Wong <jemmywong512@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] cgroup: add lock guard support for cgroup_muetx
Message-ID: <o6i5idjcvyhkw3bgewr2qs2try2xm44wjlsfspolj7da3yc23n@g3x7wgiu3oyd>
References: <20250606161841.44354-1-jemmywong512@gmail.com>
 <20250606161841.44354-2-jemmywong512@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nlaedpfqordpxuch"
Content-Disposition: inline
In-Reply-To: <20250606161841.44354-2-jemmywong512@gmail.com>


--nlaedpfqordpxuch
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/3] cgroup: add lock guard support for cgroup_muetx
MIME-Version: 1.0

(typo in subject)

On Sat, Jun 07, 2025 at 12:18:39AM +0800, Jemmy Wong <jemmywong512@gmail.co=
m> wrote:
=2E..
> @@ -5489,14 +5488,14 @@ static void css_free_rwork_fn(struct work_struct =
*work)
>  	}
>  }
> =20
> -static void css_release_work_fn(struct work_struct *work)
> +static inline void css_release_work_fn_locked(struct work_struct *work)
>  {
>  	struct cgroup_subsys_state *css =3D
>  		container_of(work, struct cgroup_subsys_state, destroy_work);
>  	struct cgroup_subsys *ss =3D css->ss;
>  	struct cgroup *cgrp =3D css->cgroup;
> =20
> -	cgroup_lock();
> +	guard(cgroup_mutex)();

I think this should use different name suffix than _locked to
distinguish it from traditional _locked functions that expect a lock
being held. E.g. *_locking? or __* (like __cgroup_task_count()).


--nlaedpfqordpxuch
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaFEwtgAKCRB+PQLnlNv4
CE2FAQDjzMzoE3Fh2MUSlE0ouZynega55I7I/C0XccuIggos2AD/e7h1o2QgvMmi
6We6AzgU86/c5l04tFq8wfc4UYez8Q0=
=ZYxO
-----END PGP SIGNATURE-----

--nlaedpfqordpxuch--

