Return-Path: <cgroups+bounces-3897-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB8B93C2B7
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2024 15:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9EFA1C213B1
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2024 13:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5728D199EA3;
	Thu, 25 Jul 2024 13:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JK9Ag9XY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD6F54759
	for <cgroups@vger.kernel.org>; Thu, 25 Jul 2024 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721913331; cv=none; b=WdOsEBHb04wSp/ET39Ap75jg0ywq/27Hh/MMdBMRbMyilDsJKQwddKyGxJisLpHvZkbROMpDIgyqBtXzwG1PobG7v6FMiNeiKTjBNPPm4R1bS0H9BeeN94OQ4PoFrLF8jyi++rbN+hvL2W9q37c7A3fjM2OJLgB7z7ebhWL5Ki0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721913331; c=relaxed/simple;
	bh=wBQvpVohbd2W4vplmrY5Z64LjAwjMZD6ae8o/85wxuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EurMfPJ4gOavsyYAu0hrnhcdv/8oFCMZFjh9MFKNuUF6mAfJklGq2uIbnH9HZO82uvTFaVvr5xbP6hDQTihWs6ZYbgeHWg4k7aW2bIFY6jqCE9IMi94vdiHwauC0CAcPI32GCd3xvCXWm1mEmKcxS8Nn/Ree8tlTwLIXTx+8LXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JK9Ag9XY; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7a9a369055so54767666b.3
        for <cgroups@vger.kernel.org>; Thu, 25 Jul 2024 06:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721913327; x=1722518127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=efjrSpUOXuKmG3Wgod3ChlCv7XK4z1uzPlvVqgjPuBA=;
        b=JK9Ag9XYaZqA8OukqAJzzxy4jhUF8yUERMSQyfToSjG+wbQoOK0HvDiFGtHxr4GJpa
         I61DfPMfgV/syuDVSQ1zVg29Y18mZLzIa/ciRI9jBT3RhTFMV+PGDnFopyvpb6hKwiPw
         U4jZRWw60YPUFcDEEqkXCGVpH2lR2/l04poff53RpaDxaPQ2OA+ZtvAsX3Ohdo1ttfsw
         L78BOtzudFPIQu+/8BszZxBs7G4GCj39d8iSa2FKoH0pd7l6iHdSuAALnd+QhCZHMeKK
         WFM2yZ6aYafnJP3N+0mLCskF4smXCR/b5T7Rq94ojOjwtf7ae/6IxXM/I6lhrTitlgXS
         QkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721913327; x=1722518127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efjrSpUOXuKmG3Wgod3ChlCv7XK4z1uzPlvVqgjPuBA=;
        b=XrIeEbS/g+AwBsjHIb/sROnE2RCcilmXVgo/Kbmgx8gHIVl/+zIwwfpNCXqUOwR1+E
         2iK7ZvQHHUG3xIw7rAaS2em7l5s15IUoRYgh8MwjyR/PuHT4We91qLaj5pCq7xuHr082
         bHk3Nqb5OMAqUtVPQwKCrn0AZ1+ao8dUg3zGAJR/bHdD5lkIq6KKqoMvfjfIUPtL0B8S
         QyX9PQht0kixYAr/azcrOQfQoHoM+flyYaOj9FOQDysdntTjelK7S33O8j9+zIWOIrME
         jy+Pp/JtW+Ny049jRNya2kZTsC+2OKskQ0D3ftPKI1HASuz7QGOlQ8gDxM7sW/RPpT7h
         utKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu4dFHWZcbQP4dkLxDq/GCf/WdJ2tcWy+pUPFiTGsqVFZMMfhuRWPLu+g2Cn4hO8uK7/uVOWieCgfVWZheKL2OolJgYqmOvg==
X-Gm-Message-State: AOJu0YysS35moWO9Jc9MIePnI/yT70vP+Wg8lfNnWNZ7Efib45SEf2vz
	GwwLdgb0QXezP6R1l+GMEctnU6iWSDc7Nnf6bODJkl2twngkX1kjSlDz725ws6E=
X-Google-Smtp-Source: AGHT+IE7ycVbMTwcSDtveSbfPhTy1z6/v17KCNgRLQqdkNtT7UyXHl1UgyXUGldYyjNB28P9hbc4oA==
X-Received: by 2002:a17:907:3da7:b0:a7a:c106:3659 with SMTP id a640c23a62f3a-a7ac506f2f6mr222422866b.60.1721913327478;
        Thu, 25 Jul 2024 06:15:27 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad418f1sm71234566b.135.2024.07.25.06.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 06:15:26 -0700 (PDT)
Date: Thu, 25 Jul 2024 15:15:25 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kamalesh Babulal <kamalesh.babulal@oracle.com>, Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH-cgroup v4] cgroup: Show # of subsystem CSSes in
 cgroup.stat
Message-ID: <23hhazcy34yercbmsogrljvxatfmy6b7avtqrurcze3354defk@zpekfjpgyp6h>
References: <20240711025153.2356213-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p4ikx4ra2wliee3i"
Content-Disposition: inline
In-Reply-To: <20240711025153.2356213-1-longman@redhat.com>


--p4ikx4ra2wliee3i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Wed, Jul 10, 2024 at 10:51:53PM GMT, Waiman Long <longman@redhat.com> wr=
ote:
> As cgroup v2 had deprecated the use of /proc/cgroups, the hierarchical
> cgroup.stat file is now being extended to show the number of live and
> dying CSSes associated with all the non-inhibited cgroup subsystems
> that have been bound to cgroup v2 as long as it is not zero.  The number
> includes CSSes in the current cgroup as well as in all the descendants
> underneath it.  This will help us pinpoint which subsystems are
> responsible for the increasing number of dying (nr_dying_descendants)
> cgroups.

This implementation means every onlining/offlining (only additionally)
contends in root's css updates (even when stats aren't ever read).

There's also 'debug' subsys. Have you looked at (extending) that wrt
dying csses troubleshooting?
It'd be good to document here why you decided against it.

> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -3669,12 +3669,36 @@ static int cgroup_events_show(struct seq_file *se=
q, void *v)
>  static int cgroup_stat_show(struct seq_file *seq, void *v)
>  {
>  	struct cgroup *cgroup =3D seq_css(seq)->cgroup;
> +	struct cgroup_subsys_state *css;
> +	int ssid;
> =20
>  	seq_printf(seq, "nr_descendants %d\n",
>  		   cgroup->nr_descendants);
>  	seq_printf(seq, "nr_dying_descendants %d\n",
>  		   cgroup->nr_dying_descendants);
> =20
> +	/*
> +	 * Show the number of live and dying csses associated with each of
> +	 * non-inhibited cgroup subsystems bound to cgroup v2 if non-zero.
> +	 *
> +	 * Without proper lock protection, racing is possible. So the
> +	 * numbers may not be consistent when that happens.
> +	 */
> +	rcu_read_lock();
> +	for_each_css(css, ssid, cgroup) {
> +		if ((BIT(ssid) & cgrp_dfl_inhibit_ss_mask) ||
> +		    (cgroup_subsys[ssid]->root !=3D  &cgrp_dfl_root))
> +			continue;

Is this taken? (Given cgroup.stat is only on the default hierarchy.)

Thanks,
Michal

--p4ikx4ra2wliee3i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZqJP6wAKCRAt3Wney77B
SZZcAP9TGigif3uPku2ECmJ0PKbMFe2LxRWwMcG2m30wn2EgNwD/VDV8rVWE4gVZ
ht3p54KnGh7JUfslrPNkV9B/ivtzXgU=
=Nn+B
-----END PGP SIGNATURE-----

--p4ikx4ra2wliee3i--

