Return-Path: <cgroups+bounces-8603-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFCCAE051E
	for <lists+cgroups@lfdr.de>; Thu, 19 Jun 2025 14:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2A21637EF
	for <lists+cgroups@lfdr.de>; Thu, 19 Jun 2025 12:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B858A22E403;
	Thu, 19 Jun 2025 12:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XyceUW0V"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0F2221F26
	for <cgroups@vger.kernel.org>; Thu, 19 Jun 2025 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750335041; cv=none; b=pkl6Wy1FgIocgUPhOo7paEkjgVAAxbnYExpjQ4FM6TnbFtITd0RLAJ8Fa2VR+vcUpLPbX0Rl3obtKFFX3lc0YPu/bHgLpbeLoZzQnmSunUjuCt6OSTZ+BnMVrg1JBcrxDzsN53RGzX3GMSpzNPjcYxKkHaa03Np8iyi8WwpJBpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750335041; c=relaxed/simple;
	bh=Z1k28oh2bsjAp3J9sxhgKELPLL0pOh9fG5HeC1Y+BL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvaYu4MVZjEiP4E3GxJBkk6keA4GcYiqjD7KeTWkzywkHe9GntJlrAM7++ZSjNTKyKyt45MaV7ka7QuX0B4bAkLnNn/90lVUbXwLGtGxSmgw0eB6mOPCpORohryJmVGxPhYO13PHwgW/4QfdKiZu01mMeYd45F9dkMw1TizcWHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XyceUW0V; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4535ee201e9so2924975e9.1
        for <cgroups@vger.kernel.org>; Thu, 19 Jun 2025 05:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750335037; x=1750939837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GdGldtwlWNchi8rv7SkT/y3UPzEmCjdby+cLRpS1Y/4=;
        b=XyceUW0VpaBj4ARN4LGjcsntClzLyhTeF6XYjRnBXg/ncvFVA+rX4G1hPZZQZVlbKn
         rBazKOWVMRC7YeBPdTnE214kL+1uzucYANZTGNjXccA9aFkeo3P4zCnaeASr6rNW0hQQ
         gNITWkQAe4W7c58IIPOyxYbFo4DNMfOyWy9freQG+twEVGJaq+e3zCV4OGUMeCQwsg/b
         3MrMq18D+xbOitATEXDFlu9JMZLK9lpyGRobniIhw8+Ulat8U5kSOaKfyNENTdMffW8r
         Z/KigykcqXPtSPbQw85FhNFL0kKbvN/Tu/036/7+9qLIrokl3ztjUH58QGZeOt9WBMv3
         Z9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750335037; x=1750939837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdGldtwlWNchi8rv7SkT/y3UPzEmCjdby+cLRpS1Y/4=;
        b=KU/6y16CB/a+eYsyS6CFWttqtPUaxDcbGg9AL9kj7ICwbNTA2md+pFjPexcrPvyU68
         vHJeushY2B3CJLJv1We4vCox1o8qNG9v6fWd2YuxGe/LowPjL2I+BHLPB/5prv5rWK07
         em2ssiBQBMbEMjdGEbmoiQ2tq002hd4hk+0Tkg6+kHUZ6PVgS1/rhLhACj17sFaNNiq1
         el4/DiiJrtuIJDbb5JivRJyVDXkgxuSIQWe7IkNmhkLkmUl8u9x1HD7VNttzmgwxCzBt
         H+9HZKs93M2ILTkNEahCXYkTe5Mto3c/FdszDTFHieomnB5yc3OMAp7AChh406WF2EN/
         Tp1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWR9qsTp30AKkoozzR4J8JfbvSvDsYGg/PwjvZxUJEC9x6p6KCHYmHxawsDgQKhDixrk1urOC5a@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9uflfQsUS9OSRfw1OxO3XKzO58WxgelYfG8qdG6+R9D8hH65Z
	7dGutMA7gHWU7fdyyIfzbMmD0adUmgdXgLO//S/3DwlIMtzlfHKer6HUgbbwUjuIKzI=
X-Gm-Gg: ASbGncslxfez1u3LIytPu091MkubuKHmMoKPfgpE42HZZuzxeizMRTfKuh2Y3C3mKyR
	Fskg0pogmGrqzTRttBO00iQ8gulx4NJ9ACyFzzwBntIrXb21sKdf7Z6l6stBUyfPSaCLKLT1ooV
	HyGD24n7ujvmD6TFlX/GOy5f3rJxPO5IupD8PHHdiWxwpq1iEY5lizGJRbcfOTgWddXF6rcETfI
	bOJ6mQIiwUF9kpEgNw8SSiMM7U0M8AsI9Xvjkzuere4FIfp6aZaI3VYRzaOQMdIZb4BcGZF3vYI
	kM3Budc4YbWLIrm4qDJppER3JtJ52nVLzoqbCwKlUka0aceOVuBmpDC3x5EbnZ18G+bBKTSb65U
	=
X-Google-Smtp-Source: AGHT+IHGGooM/miBYffjvJ8pX+BjB/MPFrva4W86C087uwV8r28dL9eXqgzrXWtmG3yVk4veuPOJVg==
X-Received: by 2002:a05:600c:1f94:b0:442:f956:53f9 with SMTP id 5b1f17b1804b1-4533caa6567mr222030495e9.18.1750335036830;
        Thu, 19 Jun 2025 05:10:36 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ebcecdcsm26406435e9.36.2025.06.19.05.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 05:10:36 -0700 (PDT)
Date: Thu, 19 Jun 2025 14:10:34 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: Tejun Heo <tj@kernel.org>, Waiman Long <llong@redhat.com>, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, muchun.song@linux.dev
Subject: Re: [External] Re: [PATCH] cpuset: introduce non-blocking
 cpuset.mems setting option
Message-ID: <jtjtb7sn7kxl7rw7tfdo2sn73rlre4w3iuvbk5hrolyimq7ixx@mo4k6r663tx2>
References: <aC4J9HDo2LKXYG6l@slm.duckdns.org>
 <CACSyD1MvwPT7i5_PnEp32seeb7X_svdCeFtN6neJ0=QPY1hDsw@mail.gmail.com>
 <aC90-jGtD_tJiP5K@slm.duckdns.org>
 <CACSyD1P+wuSP2jhMsLHBAXDxGoBkWzK54S5BRzh63yby4g0OHw@mail.gmail.com>
 <aDCnnd46qjAvoxZq@slm.duckdns.org>
 <CACSyD1OWe-PkUjmcTtbYCbLi3TrxNQd==-zjo4S9X5Ry3Gwbzg@mail.gmail.com>
 <x7wdhodqgp2qcwnwutuuedhe6iuzj2dqzhazallamsyzdxsf7k@n2tcicd4ai3u>
 <CACSyD1My_UJxhDHNjvRmTyNKHcxjhQr0_SH=wXrOFd+dYa0h4A@mail.gmail.com>
 <pkzbpeu7w6jc6tzijldiqutv4maft2nyfjsbmobpjfr5kkn27j@e6bflvg7mewi>
 <CACSyD1MhCaAzycSUSQfirLaLp22mcabVr3jfaRbJqFRkX2VoFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nops24fazq2mqnts"
Content-Disposition: inline
In-Reply-To: <CACSyD1MhCaAzycSUSQfirLaLp22mcabVr3jfaRbJqFRkX2VoFw@mail.gmail.com>


--nops24fazq2mqnts
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [External] Re: [PATCH] cpuset: introduce non-blocking
 cpuset.mems setting option
MIME-Version: 1.0

On Thu, Jun 19, 2025 at 11:49:58AM +0800, Zhongkun He <hezhongkun.hzk@byted=
ance.com> wrote:
> In our scenario, when we shrink the allowed cpuset.mems =E2=80=94for exam=
ple,
> from nodes 1, 2, 3 to just nodes 2,3=E2=80=94there may still be a large n=
umber of pages
> residing on node 1. Currently, modifying cpuset.mems triggers synchronous=
 memory
> migration, which results in prolonged and unacceptable service downtime u=
nder
> cgroup v2. This behavior has become a major blocker for us in adopting
> cgroup v2.
>=20
> Tejun suggested adding an interface to control the migration rate, and
> I plan to try that later.

It sounds unnecessarily not work-conserving and in principle adding
cond_resched()s (or eventually having a preemptible kernel) should
achieve the same. Or how would that project onto service metrics?
(But I'm not familiar with this migration path, thus I was asking about
the contention points.)

> However, we believe that the cpuset.migrate interface in cgroup v1 is
> also sufficient for our use case and is easier to work with.  :)

Too easy I think, it'd make cpuset.mems only "advisory" constraint. (I
know it could be justified too but perhaps not as a solution to costly
migrations.)

Michal

--nops24fazq2mqnts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaFP+OAAKCRB+PQLnlNv4
CA8yAQDkZ52REH93AgKN4IVKz0LKroFqjd21SWk9JuwSDHgn+AD8CRYl7w7CtgNq
nrZtwMOpxzenNE9b0wkmSdmWWYlidwI=
=+giD
-----END PGP SIGNATURE-----

--nops24fazq2mqnts--

