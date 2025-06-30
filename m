Return-Path: <cgroups+bounces-8658-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF333AEE600
	for <lists+cgroups@lfdr.de>; Mon, 30 Jun 2025 19:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69E363E0549
	for <lists+cgroups@lfdr.de>; Mon, 30 Jun 2025 17:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9922E3B17;
	Mon, 30 Jun 2025 17:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HIewKhAw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C282E6113
	for <cgroups@vger.kernel.org>; Mon, 30 Jun 2025 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751305202; cv=none; b=KtCVKX2gfBYpMCbh7b2/72v0rRNeQW/7f9jo3weUd+5rEwiYTcQ91EWlJiOh6SXygHbENVSsTFztZrnD587ACYKhOtc1/v11NyU6MrVv9TScWjSIxJsVs6hXtmO8zSJJl8dRFFXjWG53FaQXdFQpfzR+TTG06GwsDVbvbX2JMQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751305202; c=relaxed/simple;
	bh=kF69PbKH3v9K2NyJ9RPiVgwPyU0A+sLE7fuw+9YvFCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQvfXYJcBOO0zVwvvASpmFp8OkhaIPdIAzrfSdQO0FPNXEL2GLS5AXhhzT0U6a94/eY2AhxKjP2iQBKHzr3xtO5Q3ITXOPu0W42YjWE4X5KUORPG8TSoXhJnryIOrRpmpTectDKW5d55ISIJvqIxYlAFkU812zUxhiL7NodD3Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HIewKhAw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so31573165e9.1
        for <cgroups@vger.kernel.org>; Mon, 30 Jun 2025 10:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751305198; x=1751909998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kF69PbKH3v9K2NyJ9RPiVgwPyU0A+sLE7fuw+9YvFCo=;
        b=HIewKhAw4LqbUHYNvCmsvdWSvEmbRu+4aj1p1H+V33cPW3sq/jy3VtafEi7HB9lcLT
         C2OE7C8SOzi0Qb9Mb8FeNlD36bH328QprT0l8nXjsIooBKb4v95I6pSiyR3YfuqoDsf0
         9lKMTAvnHP7eSZlhGhXPKVa92r0zaHQR2SHdU0wzK0MtZhyUEFA1gZGbw8zU03kmROkL
         9Vj+Cy1MvuWeYRPriTG66paijqc0Ccb9FsuSCciDriTvxpVOAvvvxzOk9H2RNuccQFeh
         aWNelNra3usq9qkbyMbs/fFAIvzrMozFexCpBghs0y/kYwPhaHwFbnVDSNsQGDklC3lG
         ESbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751305198; x=1751909998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kF69PbKH3v9K2NyJ9RPiVgwPyU0A+sLE7fuw+9YvFCo=;
        b=br0PAEncmiEUjKdjBnDSG8hyLr+YmLsq3uUimREZxP1oWsMHdrP77yMvrdXsTTHUt7
         AFRXxf6FCdHqsROEyyrGARDdH/QJEf+c4rw+vlZgDHKLCj+LsUB8XZXC3hH02fPE8CJL
         KNEdjMTR8Z7OwH/nQinaMLMmIVRAgvNRmc6ODn5uXdtJuULySvUycySkIsfRDp4ogx3P
         nKegjy5P70reJroXile/VB6XqwGWJAbmaKmUBOdZ4UL6n5/VJEiN001W2+SGquGuBXhj
         ebFPnqd5lGHwC28f18h+gn7yYrAW8YmY8Fm2XqTYQTnJflv0KDqtShv2WtvyKE4lTim+
         Xn1A==
X-Forwarded-Encrypted: i=1; AJvYcCV++3ZxYt9+n1kc1WX8tT1B2k9pfPOoTI9qkoJQwE3epDIeiJ6WqyhcGmGwbCHKhQDDM+wbBnpb@vger.kernel.org
X-Gm-Message-State: AOJu0YwtDd1c6giRazjs5M7+icO3AFSfszUIa2Igws0lm3iH27NLzjcN
	14rye+ZrkKqw52zOvMMCUVKp402dnXek6ujruLLV+a4h7oeowgFszXhoOzTmRSm2+z0=
X-Gm-Gg: ASbGncu0mJUjOteB+Iewt/k0sgZm2XfoElHseo2KfDeh0N3ErN0oiI4vLaGGgXD/1qy
	EkEYQaEa24wweiP6qsC4Ny2ax3sLYVtfxZ5KGiSrphDfJCzua1VImbPl1Zp6oQrAnfNjdDQnwLI
	9F/lYeXHVMjGkuSGX7tMqVtDcRkzCfHfUcsOfq4hhZ70jKjrLTKzlw5ZX3nyiPgjLemmT8vU+YJ
	IHH7cJ4ekfBcQxYKt4swt4FppNgbpEWNUzgkvO85CXQDd6MWa7tIpd57BSXDO1znHJzHNfcJcLR
	oFWfpUyEiZJ3fqR0AVftvmSyVRPhqSaWduK1FzRrc3cMpkFnQ7GPb9qnrw67kadC
X-Google-Smtp-Source: AGHT+IEn4x+LWHIZ+ye24E02ObY+nFFikxf87Wzg5FnfMupZhCIvdNxgTxB7ZFi5tWXEIE75/n9DUA==
X-Received: by 2002:a05:600c:c05a:b0:442:f482:c432 with SMTP id 5b1f17b1804b1-4538ee8565bmr115090155e9.18.1751305198454;
        Mon, 30 Jun 2025 10:39:58 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823b913esm168859405e9.33.2025.06.30.10.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:39:58 -0700 (PDT)
Date: Mon, 30 Jun 2025 19:39:56 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>, Jemmy Wong <jemmywong512@gmail.com>, 
	Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] cgroup: Add lock guard support
Message-ID: <zrl7ijmx6vrzcmmnxojgbkmhjymrpuhcjh3sc6py622abn5iee@qmbmkcwnnzgd>
References: <20250606161841.44354-1-jemmywong512@gmail.com>
 <2dd7rwkxuirjqpxzdvplt26vgfydomu56j3dkmr37765zk67pd@aou7jw4d6wtq>
 <9BDD726A-2EAE-46C3-9D00-004E051B8F5B@gmail.com>
 <aFYeU_dL0VOvyeYs@slm.duckdns.org>
 <20250623140321.GA3372@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xzakd6so4dlmt2c5"
Content-Disposition: inline
In-Reply-To: <20250623140321.GA3372@cmpxchg.org>


--xzakd6so4dlmt2c5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 0/3] cgroup: Add lock guard support
MIME-Version: 1.0

On Mon, Jun 23, 2025 at 04:03:21PM +0200, Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> > People can argue these things to high heavens on abstract grounds,
> > but if you break it down to practical gains vs. costs, it's not a
> > huge difference.

This makes it sound like we were discussing tabs-vs-spaces (at least I
perceive there are more benefits of guard locks ;-))

(I also believe that the encouraged separation per lock (locking type)
would allow easier backporting of this transformation.)

> > But, again, I'm not against it. Johannes, any second thoughts?
>=20
> Yeah, letting the primitives get used organically in new code and
> patches sounds better to me than retrofitting it into an existing
> function graph that wasn't designed with these in mind.

But OK, it sounds there's no objection against combining *_lock calling-
and guarded code at one time, so in the future the ratio of those two
may be more favorable for one-time switch to the latter.

I thank Jemmy for giving the preview of the transformation.


Michal


--xzakd6so4dlmt2c5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaGLL6gAKCRB+PQLnlNv4
CGX9AP9ZX2bNRF7xntOZQwCIHogFfK/3hdH71Tea4D3CBl0PxQEAktVMJ0BeFa7J
uVP84IbvErgGx89YR8RAKDCAsblaPwg=
=tIRH
-----END PGP SIGNATURE-----

--xzakd6so4dlmt2c5--

