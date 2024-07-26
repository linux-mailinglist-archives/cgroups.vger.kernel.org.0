Return-Path: <cgroups+bounces-3912-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B8993CF73
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 10:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F211F21A42
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 08:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F039176FA1;
	Fri, 26 Jul 2024 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TM4i/mnD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680CB176FA8
	for <cgroups@vger.kernel.org>; Fri, 26 Jul 2024 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721981951; cv=none; b=EiL8DS4KzANk2PWdwqnBQG939qKnzOwQggrNKuD7S0u/a7EwG149qzr10gve7PGX3QlsUSg67Kcqx918DoMOPQ0aXBpEJ/zwzhz12yrlNTAlydzD42JibAvqwmDIVYllTQeX9fJ8Mrf9wlL+twTjOLbDcEEfHTCmVxrgEkXJVCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721981951; c=relaxed/simple;
	bh=cx+01TCbO6DpaC7tHPkUFYEU6Li5+7QekGE9g6IIqA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVgphc9B3v/wcgt+wbbxIjgEJsgSyHqFCa53AglkN6lid1PcMJkBM5QaFTp0M06f/Emyasro3VTAEoJZqHHZmag6TZRUgbaBeLe4BnbJLR7H0HCAt98OHAvrANNnnDAeFPLHrZIvvq02gUtC5G6NtCreYGrW+T5DGqqwRjkTEd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TM4i/mnD; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a1f9bc80e3so1250529a12.2
        for <cgroups@vger.kernel.org>; Fri, 26 Jul 2024 01:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721981948; x=1722586748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1nxDdDPuqoZhhkQdgxi6lLL82Z/S+1HfGQKwxEW2Xr4=;
        b=TM4i/mnDYtKQL7xhLSs7LMUrBSea7QQJmkeJeK5KEHxkPhzYOA1rGqYiX6Uv7SCL7z
         U0zHIWXFCIGYxY95ua/eIIjfJHlk9gpXfu3g+rXpJ+JZ4z31rWpRWBReETjD/0Zzc0Iu
         7tR2Fv4qL38ujKfpLZMinDbFFaSmkgedgpJNnMf2x/HhwvDXGrWXC8bRAgEzSZ6AMDo7
         PuZDaS+Z8C8306yv50ebFhaNKR6kQ9+C4P/2VLQgX/DZvAHwo2ulJ9Cx4pKhl8OEIFqj
         OWrh7LFimO4ZRu7xe9IeqpHRC/Pl4ipCZSdG4F3K2Jyns3um3ceQ7ySzVDOfshAOgmEf
         qh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721981948; x=1722586748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nxDdDPuqoZhhkQdgxi6lLL82Z/S+1HfGQKwxEW2Xr4=;
        b=V4jXlva1EhLcPKPhLFxHbaUokLtpqzghUokYQc6ZW2Dn+diGUUQDGxmQCod7H26sVF
         NqfQDYHs0C/j8n1yXMv/kiV033T/P93q0L8QlazFlzu8TE957Jr1ca4uo9iCnl3AfBEA
         DAFm98pn9itSJH7CC46g2A3HaBB6r8gQEffllW7rIkSyuhgxnGdpgeiewvn3+SMgQj9n
         NStw6Wgnl4TDlF0+aS3RTsU313H5GMQ7Dnf+by6q8UCOjGCsOLe9vgr1p2u9tWARSGKU
         SDqAdhB1Q0RgZ/nOe5GWMQxfi/SPCORbmKTvjSkxgYBzIrd9MqhrYiNuzeahlb/XHkXG
         M7ug==
X-Forwarded-Encrypted: i=1; AJvYcCUCfRG18MLQF+u5N+98+1tXtk4o1YSOPUh9rnsv8SmCajDqA5VqD9PM/+3yi45jtlXMDGGLXWz4OsgxU4AbrS4gx8vbeza99w==
X-Gm-Message-State: AOJu0YyV6ZXa7EBOFQZc8EjUpK4NKIhXAu0lJiqeIOgnHxjhksB86bd0
	Y67RZ+GvsPG1vfHmuwfRrI8FpsoEx8fPPObdSDzOZYBdqVBVtCACYIkYxt/xGXA=
X-Google-Smtp-Source: AGHT+IEKCNWFIWSIa0WEqcLAmK79+P9DH8UDMg3F8CdyMwZNKChDWbgmxYrh315TuPC354rnk9EOyA==
X-Received: by 2002:a50:d54a:0:b0:5a3:d140:1a57 with SMTP id 4fb4d7f45d1cf-5ac6203a1f4mr4350486a12.1.1721981947474;
        Fri, 26 Jul 2024 01:19:07 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63b59c86sm1641627a12.42.2024.07.26.01.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 01:19:06 -0700 (PDT)
Date: Fri, 26 Jul 2024 10:19:05 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kamalesh Babulal <kamalesh.babulal@oracle.com>, Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH-cgroup v4] cgroup: Show # of subsystem CSSes in
 cgroup.stat
Message-ID: <qozzqah5blnsvc73jrhfuldsaxwsoluuewvgpukzgcuud4nqgc@xnctlkgk5yjv>
References: <20240711025153.2356213-1-longman@redhat.com>
 <23hhazcy34yercbmsogrljvxatfmy6b7avtqrurcze3354defk@zpekfjpgyp6h>
 <0efbedff-3456-4e6a-8d2d-79b89a18864d@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xlb3knarn2v64q76"
Content-Disposition: inline
In-Reply-To: <0efbedff-3456-4e6a-8d2d-79b89a18864d@redhat.com>


--xlb3knarn2v64q76
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 04:05:42PM GMT, Waiman Long <longman@redhat.com> wr=
ote:
> > There's also 'debug' subsys. Have you looked at (extending) that wrt
> > dying csses troubleshooting?
> > It'd be good to document here why you decided against it.
> The config that I used for testing doesn't include CONFIG_CGROUP_DEBUG.

I mean if you enable CONFIG_CGROUP_DEBUG, there is 'debug' controller
that exposes files like debug.csses et al.

> That is why "debug" doesn't show up in the sample outputs. The CSS #
> for the debug subsystem should show up if it is enabled.

So these "debugging" numbers could be implemented via debug subsys. So I
wondered why it's not done this way. That reasoning is missing in the
commit message.

> > > +	for_each_css(css, ssid, cgroup) {
> > > +		if ((BIT(ssid) & cgrp_dfl_inhibit_ss_mask) ||
> > > +		    (cgroup_subsys[ssid]->root !=3D  &cgrp_dfl_root))
> > > +			continue;
> > Is this taken? (Given cgroup.stat is only on the default hierarchy.)
>=20
> I am not sure what you are asking here. Since cgroup.stat is a cgroup v2
> only control file, it won't show subsystems that are bound to cgroup v1.

So, is the if (...) ever true? (The file won't exist on v1.)

Michal

--xlb3knarn2v64q76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZqNb9wAKCRAt3Wney77B
Se+pAPoDu9bBY0yYCOVsOkk/g0USVMXESbUsc4TCgMsB5DRypAEAufCXfjxxMNXX
uOu6x5is+qJ4tUK/UzXu47ZzQQqsHg8=
=NpIn
-----END PGP SIGNATURE-----

--xlb3knarn2v64q76--

