Return-Path: <cgroups+bounces-3997-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF8D9415AC
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 17:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AE81B22BF8
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 15:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A703E1B583C;
	Tue, 30 Jul 2024 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ApcGJKV9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AFB1B5830
	for <cgroups@vger.kernel.org>; Tue, 30 Jul 2024 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722354497; cv=none; b=TahvTTJjdWFuzVIJ2YDpLqLk9rM+VO1eDyzhN5lSTwyqx1EgdGLfR3yRyX0AAdRA2c4yMy5wj8nBN9ika9uZFysr9nmVnTXj1gB7N5zUqKv2CcS9I4Z8OEmWrJEti4Of4JBwO5wMnGWcNPLdNKr3mctuAUWO1Yr7VI5VPn7ddzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722354497; c=relaxed/simple;
	bh=WyNq8YsumSLxdlcOiBSQJPBphd1srZMCXa47KPqsWN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBg4fZtn/4MWYrc2kOhgNepPAmItNYYJAIYbE+yIGzDHMljvuYjfGgUePuMfj9CIG7pGkkEtsLnnZizFfeF/dNr5KerR8M6j1rmohRpbPnB/4O0+rAfJpXpcEl5qW8wKZhP4ObfezbQRfc64rm04KIcBXc/82YnXGZ1Sq2DKGdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ApcGJKV9; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a728f74c23dso640406366b.1
        for <cgroups@vger.kernel.org>; Tue, 30 Jul 2024 08:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722354494; x=1722959294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3H3zc2XckgBeMfg/ss6t5PIdHdtIJYeowfICmheZoHU=;
        b=ApcGJKV9imBkWwkYBBGim+CW0xJnJzSpDOSysJs6xC5ZmYzMxW9NChEzSHZlAtZxRU
         nCxopgJdTZkPmwEncgtK0rgnG0QFw7KOW4v2DfPe/Ip31Qx2wG2Dj4Q+8l4mtHmIEss9
         hcjHRe2HeubNieUY0HkyEhK13qY2v2Rx6LmZyJSLAQR7spJiMZTLEb+HdfWvgDrBqdEp
         RKw0dDHAQKg1DFb3qQhbguN7znKe8vvYW8nmJhgM/G4CF5rNrcjutuiB9HuVBdMBS4lA
         K8CDwQMP/P3OSmpxlKPJd3Dl3Xlm3nGP1ujZ6EccuMhnnlL0C6ha7deRO1T2f9VFOOK5
         rJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722354494; x=1722959294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3H3zc2XckgBeMfg/ss6t5PIdHdtIJYeowfICmheZoHU=;
        b=k545/qd8632iKW/wgx9zVxbuCB6p99RjN8f3Nnh0XFiXNHk80lNZHOSYfCNO4hENhl
         waVVK8q1TdAVkfDufmZJLbOt32JfGyuojnK8HJV5AMztMNWd0vICS7/i6J5lRWpfFXqI
         oNaQcKb2WP0GcuEJWkXu4VRHfD7owEQcAuOkggD8OIcYNkS4lgR9ytU4ulSheLN67SeC
         4XAio+A0o2plgDB32p6jpUFyYe55LQJPfEDF+y5AgUND2LuUT0cbgY+EH6NcCMWBR4cz
         nsvTS1Gt9movPxmCsbUTayMckwXnhk5+MiMD7RKtvCNldW/sGLoMZk/CPMtJ4VpOxgue
         Q27w==
X-Forwarded-Encrypted: i=1; AJvYcCWzlb5VcULtLCAmwzyPAXpdhSU2mgFh8u6Syz+diG16IpFE/sYhdSeE9nYe/2Hl2LoDEeGgDs4ay6UleQ8eqjdfPDWnWLxhLw==
X-Gm-Message-State: AOJu0Yw8IaV1hofNH7OEI48ziWyc4O1z4YBcPYIUyGkLn4+7T1aiO7WJ
	e0RYfBpq4iyCrJQQ7eUhZw3j8+hIchgiEqceintVHH7MpYNb0YoZw2PUUqwPkDw=
X-Google-Smtp-Source: AGHT+IHx8cAG8qt06h8O+vQMz5ylfzVI9zatMIDF2iye+fJMGPQzpxVamyfv4QTZ7m8qnq1ZA400MQ==
X-Received: by 2002:a17:906:c10f:b0:a7a:bae8:f292 with SMTP id a640c23a62f3a-a7d40101a57mr813329666b.41.1722354493847;
        Tue, 30 Jul 2024 08:48:13 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab5948asm657937766b.85.2024.07.30.08.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 08:48:13 -0700 (PDT)
Date: Tue, 30 Jul 2024 17:48:11 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: David Finkel <davidf@vimeo.com>
Cc: Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	core-services@vimeo.com, Jonathan Corbet <corbet@lwn.net>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v6 1/2] mm, memcg: cg2 memory{.swap,}.peak write handlers
Message-ID: <p5p2il4njypdlaolbidz6bid3cv2dlz6vs3xd64ghn4zhw3igc@zxut62vhkwwb>
References: <20240729143743.34236-1-davidf@vimeo.com>
 <20240729143743.34236-2-davidf@vimeo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4gx6so2i3yytl6uk"
Content-Disposition: inline
In-Reply-To: <20240729143743.34236-2-davidf@vimeo.com>


--4gx6so2i3yytl6uk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 10:37:42AM GMT, David Finkel <davidf@vimeo.com> wro=
te:
> ...
>  Documentation/admin-guide/cgroup-v2.rst |  22 +++--
>  include/linux/cgroup-defs.h             |   5 +
>  include/linux/cgroup.h                  |   3 +
>  include/linux/memcontrol.h              |   5 +
>  include/linux/page_counter.h            |  11 ++-
>  kernel/cgroup/cgroup-internal.h         |   2 +
>  kernel/cgroup/cgroup.c                  |   7 ++
>  mm/memcontrol.c                         | 116 ++++++++++++++++++++++--
>  mm/page_counter.c                       |  30 ++++--
>  9 files changed, 174 insertions(+), 27 deletions(-)

Thanks for the fixups, you can add

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

(I believe the test failure in the other thread is unrelated.)


--4gx6so2i3yytl6uk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZqkLOQAKCRAt3Wney77B
Sc8rAQCcFO+D74+1cXWsMXxGu3oxDtVtulirZ1NqSHNVNXmmiQEAlNV5ARTstXPQ
l/+VVlYzT/mxoLdRLR4oakWCXl/BngI=
=DQce
-----END PGP SIGNATURE-----

--4gx6so2i3yytl6uk--

