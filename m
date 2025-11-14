Return-Path: <cgroups+bounces-11971-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C59C5EDE0
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 19:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85773A7B72
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 18:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB92F2D7DF7;
	Fri, 14 Nov 2025 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RJbPo++5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C4A31D723
	for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763144974; cv=none; b=VRFa6EwnkRZONGDI5dEmgDTBr7jC/M9KY2HgLdp/P/W0FgtvN3IjLiYrLv2EQ+BFVIGTJi0B3Vvwdur1xNhQBL/EQ4vMunLi7xEvt+5sDbDwyhZnmfpZZQNnThI/4tfRYxTWA3qdZssrSeZ+e+AFFhzrTP1xgghjcuSaVoKN/4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763144974; c=relaxed/simple;
	bh=V+os3BBZVwF/PrLDunpQ8w9lhgRvpQnhZ1tdXiJr0Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oW0l+vkYliCXS9O3fDN1zpOPx6WUoLqQ8rmeWINhe/8oKVjBBPn2fBqDFGSlK9ePG/sMU47QYyuZCUYdILBYHej1xiiXvvk9JCoQkEvQ0wNAwWt0l8w5/DpBKQwz8px2u7lmdO7LLsIImpKTKNZmBaaMyI2DEZbngTWAu8CqBCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RJbPo++5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4710022571cso21895185e9.3
        for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 10:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763144971; x=1763749771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rs6KuXzAAad7sbRP025YxG1G/WsCswtNWwIDQpANIbg=;
        b=RJbPo++5wNv5rMNXTV+GeN14ISgMPC/3K7VSFi9s6J2rV8C9c3A66+ecEG29j72MxK
         qRy0rel6NAPfA9xImlkWhRHvC5nGHkFmquW4nI556G4LyDr8HWeVLegnUsTDf8gz7gV2
         VhmQTqeLZHl946mS4UocJIEqTfA2XUt4tBu+qPl1sPYV/A25Zpez5cYkVQvp4jJdg59M
         0MPgNSLV5IDmb33WqFGSnWbz9rpgWwM5zTSZ956B0WJqy9F3A0VWSon/O3mbm5fB3H8i
         9LixIjF+EYI/lewA4H6xrkr7/j3s0Jx5t1Dnoept3bPw87WPq+/5gb/7ZRNIz+LD0Ph6
         g3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763144971; x=1763749771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rs6KuXzAAad7sbRP025YxG1G/WsCswtNWwIDQpANIbg=;
        b=MjqKcPY+oDeNS7DxW+l4m7EC95M6vvtMJ8rqZQZuRjCgu5ma2U1jCFjo4ZuPdKiREe
         dEywCmwJPd3ATupv6lADeX6dK7e/P2/oks/vBBa9tustdsODlUkCvtGXxcFYyxg+VBL5
         867ETZrngciYOB/Zwua9vm0qNJvDSGSYX9ASE8lkJ7ncx80XaVChJS7cojb2xSODvcNJ
         AOm6J8aXGROc5VuEfP/IGLzejxIU/b490OeXkrkZSKo9OIMKwtAmooCr52hHtcMjWU2B
         7v5VwydB4cLEatWDoV5WM+6Apu7SsLFDLKUx9cxBNJw8y5e9fW3S/SMPk2w58gg8ZpY3
         ks0g==
X-Gm-Message-State: AOJu0Yw4MDVrfsWxNATKUkXr3UqP7bpFsYeJy/nOqrIHgNyZEo1zQ0XA
	0qZ9M/4TIG4AG240q+IkTTAsV91mALu2KdUXpLGdN/cdw4bGGRRbVjySruqA8gHIIr4=
X-Gm-Gg: ASbGnctEWQlV/vLKKzYdMU8SOV8hnB5XCyt9pJkCs34EzL0+MYqnF3BuO5sgIXq8cQO
	eVvZtxz+rrjEwtXMBI99FLe73bKEYjN5Fo10jotarQ7i2jtdiDaWsW8l1hMCyur12DyxJFPyNO9
	R9JcYQOrHrThNQD8k7INfuAeq79AQEW1WeciVIPJVLDVU7x1gOUzzCyRTDRNJ3QDwoyryH8yYNR
	kDQL+upYiuWLJ3mmchYwjwN6q4uKzsbFwvL3qfkisX4vLI6ZsNHcCDGxTaLsGxxPGNh6hNqv9Tv
	bO1wd9YaWNrqeAJ3j323cUo0Vi1FZZxJMCXnrrbM5U3dHqmRWRrJQ28PbWgM1mcdZidth5YtAql
	0XkfGuzeig6bXyTr9T5VOGG5IthcrGrrjjyFGbQjtKrBlBkWFn5niGp4KQwp1FWbGmk6eHzO8or
	50NAHJIcQ2HGiGjAp2Re+dtUhBWH0MgeE=
X-Google-Smtp-Source: AGHT+IGiVuh5NjUH3OUXRwywEj3dAAcLkuSOQxnMCr/Tjl01waowqDE5+kN/bovUGSqLMkvh7dTWrw==
X-Received: by 2002:a05:600c:630d:b0:477:89d5:fdac with SMTP id 5b1f17b1804b1-4778fea1becmr45809045e9.31.1763144970812;
        Fri, 14 Nov 2025 10:29:30 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787daab3fsm184371285e9.0.2025.11.14.10.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 10:29:30 -0800 (PST)
Date: Fri, 14 Nov 2025 19:29:28 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Natalie Vock <natalie.vock@gmx.de>, 
	Maarten Lankhorst <dev@lankhorst.se>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH RESEND 1/3] docs: cgroup: Explain reclaim protection
 target
Message-ID: <qhywsiwlbrpe4el3pcprtnpwdyifmfxesmsdgxuze6ho3d4wqe@mweffv3yoxlt>
References: <20251110193638.623208-1-mkoutny@suse.com>
 <20251110193638.623208-2-mkoutny@suse.com>
 <87wm3xwtcm.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iit6ajlbncbnam5z"
Content-Disposition: inline
In-Reply-To: <87wm3xwtcm.fsf@trenco.lwn.net>


--iit6ajlbncbnam5z
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RESEND 1/3] docs: cgroup: Explain reclaim protection
 target
MIME-Version: 1.0

On Mon, Nov 10, 2025 at 01:00:41PM -0700, Jonathan Corbet <corbet@lwn.net> =
wrote:
> > @@ -53,7 +53,8 @@ v1 is available under :ref:`Documentation/admin-guide=
/cgroup-v1/index.rst <cgrou
> >       5-2. Memory
> >         5-2-1. Memory Interface Files
> >         5-2-2. Usage Guidelines
> > -       5-2-3. Memory Ownership
> > +       5-2-3. Reclaim Protection
> > +       5-2-4. Memory Ownership
>=20
> I always have to ask...do we really need the manually maintained TOC
> here?=20

Tejun [1] (and maybe some others) like it.

Thanks,
Michal

[1] https://lore.kernel.org/r/aMwo-IW35bsdc1BM@slm.duckdns.org/

--iit6ajlbncbnam5z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRd1BhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AgYPQEApUkkuPc8jpbhA9W1qLNR
2OzJ5OQuiJ+KJRVk9vv4/AQBAInGMLPC1Ye6Oy6vRBeNzV+ocTcDynZ9usjxMN5D
Jf0P
=7GH6
-----END PGP SIGNATURE-----

--iit6ajlbncbnam5z--

