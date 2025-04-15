Return-Path: <cgroups+bounces-7580-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B70CA8A3A1
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 18:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E80E24403FB
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 16:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14229217733;
	Tue, 15 Apr 2025 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gK7VuYa+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEF61AD41F
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744733178; cv=none; b=XuhKfJ1WUR9iJlSiiVlnw8gXcle5WDkDaTfKWOcPg350rqBzURDQYocdFpZzsH00ibUaTCQy4zkhb79juvUkDYvWXBbU9cl0iu/Rca/NaWIpZuOUees1jK9lo2riHFOUB2qSPKybClj3QgFOqBOOE+vW6JF6AOSNLYpgI2gVT6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744733178; c=relaxed/simple;
	bh=hgZy3Bs5bZtFb1xBAHv8Wk2VAlSG2m8POnP/PmcT6P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQhgJd8y7+unsUOgm+gRMqckgf2BAMhVR18ADxA2BvaPh3JzhwpHT/8PJ3NItqFU/Zw9xQgpqwboBsC1sTJpeOmNAK3A2djGWR1i5Zp2mOlszetS0G4IvxYJLISXU3cyoYXb9rM8BBQJ+tsD7qsOSe7zSsbswNgvGWmCFexwYPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gK7VuYa+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso66329805e9.3
        for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 09:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744733174; x=1745337974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hgZy3Bs5bZtFb1xBAHv8Wk2VAlSG2m8POnP/PmcT6P4=;
        b=gK7VuYa+0pKQ4E+ZfumwQapOyIwoEcOhko7opvwZbU/Er5aCxvmq7iBYGbIEPX4SPC
         1BvVEmV1+UhbXR1Ug6ywIATZbmywzZevnBBorWljaBiM+9D/zdg0OkJ7ExY1/Egvc8p1
         CILBY+toPDLBEPrnUyjg2VJmjxe/g560NxNj1m3QwyPksABbpn09VbuxYrUq8lFJqjvQ
         ikAxo+nWZavShlEk2JCeND19P44mQPKLLiIA0biH/Vx+Z6KLOGXJAUSWf/r3XThgSB8Z
         26hPU9r7JHJUCPdbnjVeSk36G77uwdQDeA7+tTvs3BpRC/yjwi80bfkq0xRReExqT5YT
         ajfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744733174; x=1745337974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgZy3Bs5bZtFb1xBAHv8Wk2VAlSG2m8POnP/PmcT6P4=;
        b=KimpMFv2pZdGe2l2+ObgNp3Oa876TE9haEvju16nba/sFw/n9aF0rJFGI+tesu/CbP
         VnAD9wx4Fq38FAuqdKdz32gHUjvRor9uhcBZ2vKyd/wOrNUVVG2wEiE6l+KBu8pMVLO4
         X9zJekARa+Ba86686/EXVQC0yblJuroT6OL0VnICxvJ+StVf1dA/zndDIDvzOe9JkEau
         d/WsF6OB2hjoahLZA8Ao74Ck7JsXbRiJPyicAGPcISla70Jz4kQbCAdiuiSWBPdEoOZC
         SOYRa5FZKdIRLKnXcbCdeq1Zg4GtC4bZDjAPpy0nm2vE3gj2RjuIrIHDIc+kYOY8t/8i
         zgvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaMlAp9C2Ow/vTjnCxtDHH5zXh+evABaR+UTF1QLKi4nZlvX/sbBiF71zDGR1uVFegHiOk8CgI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9bDkgoDHRyVie8RDvLUCxrE1jTTFevV8uFGnSkgV6Uo93xO56
	JAf3UuD/Pk41TgfkdH5qxIDrP0y3ZfL+OzJK2WkhVem6YoIPRobgMlPzTWkBwY8=
X-Gm-Gg: ASbGncvMQ5khWO1BWs0XzhpXfeslE48TDmOo+aeESsJdMVij3vgAZNmE3QpQqr0AdeJ
	B391sVO3zqJvNxePtxAFKdk40VwijHxjQhP4FCWBJqDSpistWSaLgGu0SMy1dJZlrdceBgVKeun
	bFp0s0trvDQzwGGP+IzYTXcsxSFkVwcWslJj0P1V+mrqoMmKrRno8Pe2GDNxqYQGRGWhIdLRSJ3
	E466kLu/eHxests+7+zfHkC4XqZwx3ne+zmuPdn08frhUpFcIq5hdCkxFb7WKNajvO7Dq8WBBa6
	LIW1M9I0OUzifiNksgkFXuWOlznBhTG1y4syOk12qm0=
X-Google-Smtp-Source: AGHT+IGTKkmP0oe0fauFieWns1mCFUH/1vQsWUwM+pO9VnG6/65IgNgDirpko2Yd+tXf8f74r72J5Q==
X-Received: by 2002:a05:600c:1e02:b0:43d:22d9:4b8e with SMTP id 5b1f17b1804b1-43f86e1f246mr49614045e9.10.1744733173992;
        Tue, 15 Apr 2025 09:06:13 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2338db0dsm219073455e9.7.2025.04.15.09.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 09:06:13 -0700 (PDT)
Date: Tue, 15 Apr 2025 18:06:11 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jakub Kicinski <kuba@kernel.org>, Jozsef Kadlecsik <kadlec@netfilter.org>
Subject: Re: [PATCH v3 0/3] netfilter: Make xt_cgroup independent from net_cls
Message-ID: <zu5vvfmz2kfktu5tuedmcm5cpajt6dotkf72okrzxnyosbx7k7@kss7qnr4lenr>
References: <20250401115736.1046942-1-mkoutny@suse.com>
 <o4q7vxrdblnuoiqbiw6qvb52bg5kb33helpfynphbbgt4bjttq@7344qly6lv5f>
 <Z_52r_v9-3JUzDT7@calendula>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pqcmzdxhrghzvc3f"
Content-Disposition: inline
In-Reply-To: <Z_52r_v9-3JUzDT7@calendula>


--pqcmzdxhrghzvc3f
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v3 0/3] netfilter: Make xt_cgroup independent from net_cls
MIME-Version: 1.0

On Tue, Apr 15, 2025 at 05:09:35PM +0200, Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> I am going to apply 1/3 and 2/3 to nf-next.git

Thanks.

> I suggest, then, you follow up to cgroups tree to submit 3/3.

OK.

> 3/3 does not show up in my patchwork for some reason.

The reason is -- my invocation of get_maintainer.pl on the 3rd patch
excluded anything netdev. Sorry.

Michal

--pqcmzdxhrghzvc3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ/6D8QAKCRAt3Wney77B
SdAMAQDdLxRxMCm8JCPMZyX9ZYadyzJ6nkt7nq78k1iLIvQDawD+ICbdnSZr7N2t
wIYe9I+drbFtQ44kwYWEDcKUdGL5wAs=
=zr9E
-----END PGP SIGNATURE-----

--pqcmzdxhrghzvc3f--

