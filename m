Return-Path: <cgroups+bounces-7298-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC98A79016
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 15:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8013A9A3B
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 13:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7CD23771C;
	Wed,  2 Apr 2025 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BSwxymEM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C014A1DA5F
	for <cgroups@vger.kernel.org>; Wed,  2 Apr 2025 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743601231; cv=none; b=d+F5I0Oa21VAi6sjW25j+dDXqzYs+/yDVFzTl201um7JMH+dessMOlT+SLHhWNPAdBN2239dd9yECJg50jDXf415Jg5RvtwcmI88CCPfWImGvp0ze28vhHWjHHf/qi8iGcggU0wyzCzaIrFfcDceVpyPtlLzvQIB4AtSLuHdy5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743601231; c=relaxed/simple;
	bh=2fd8hxX+gYJ6lDhryumm3A0+ASoxP9QgI8YrdL3sitI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChKF0Yw9pY6iOSIW7xZzTFhcqVXtGLnX7/meTN+UuYaz0x2H8DKz+kNIm0c/h2Z2/0YoqFwNG2Gr643VTMZC3lZULa4vD6ziF/7hGi5ux79KhPJcltYfSo+TbAhijzpYq7Zh8APmfj6ig6+zebVdRZJ8tNKlxnLI7qASzdSxP8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BSwxymEM; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4394a823036so63005325e9.0
        for <cgroups@vger.kernel.org>; Wed, 02 Apr 2025 06:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743601228; x=1744206028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2fd8hxX+gYJ6lDhryumm3A0+ASoxP9QgI8YrdL3sitI=;
        b=BSwxymEMWGQEv0WwG9y+SQhbBaxmTDNuGhba2N68jB6Dp8uJr12geMfXlAdUlw4w7l
         y2wFgtHrklsuEGioEL8t3twNagSp95uhyAUV0hhWZNWkcF4e9cmoSatDmfnpEclizB66
         N0bBAw5h/SbQEWfooqpIajO8Ie+A+bOyaxf/axuWNd+Ls4VqDGIvg/djBz4nhqr+EnPU
         G9DWSf6RGnHU+xfbNMbvyY3w1S6UoKBBQPJ1HUVgbtyd5sJ/sczgtTh0nGjtVLsHuRjX
         hjj/vXHTwmMTxdoQ3CjqvchhEK89pbI0zIJK7yKOH6KC69xZW9hPR+1pG857BMHLRvSj
         Cxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743601228; x=1744206028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fd8hxX+gYJ6lDhryumm3A0+ASoxP9QgI8YrdL3sitI=;
        b=VwfKkKqsCDrcfCegCDAGmx6aWBxsfq1gAHpWYrtgv0+iW092Y+obUGEEJGjCyDY4cI
         V8mwHGwDeB6KAS1XwDhqA/cAQlz+Z/lcHhkBh2h1d6ZbsUJC3hufYAzZqvYOQFLEih5P
         lljW1K/Bj3lixJntHxZkgiQgcBXeGzDdYKLrNvMuTnviDlyhRAGeYfaP1+haRTOVdG5/
         5pFQvfcFvWGc/YaHudj2VOSWomumF2NB57Ajwi65F1EestKknm/cogMeSg0osoL5hx3b
         S1FLfwF6tFE48AYZdpbTH/lRk+y9d9LO/PtK6D5fIjO9e2DohN29ymyIa58KoX9U6AOA
         F9OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC5HAw4szugHZMWAHtcoO1DoX8oz8PNf/Wt+MeffizRGtXP45Y39TFFjx8IB1mpgfoDMOWq+70@vger.kernel.org
X-Gm-Message-State: AOJu0Yxug/QZI/TYPHlErl8Q5iY+S1qYtWwaejz6r1Dj5fpRj0Tm5dp0
	TizUTptbDS4SkE2OWaeoXGu5ZQKfJ9qiBkXERojCJwTycpWvlbYRPPs8m2FfjpA=
X-Gm-Gg: ASbGncvPj6sQosavI+MMJnZBVtkwVhaUeXQZ67gBIAjul2rRroYjXmN9Fizv0j5oH3R
	gmhy428zZZX0aqizkTDiScPv3OoH4W/xrzF6VEzjIgvr4bBKVWj5M8wZ+fIqcj/9OhgkTFVfHUf
	mgwMpDtdh1jT+gL/m/vswE5qizu7BsD/qutI8SUff2izqXOZmpiLk8WNu7w1ULfaEznbW9+07fS
	yyMS+fb1gz9Y033bvU8rrugqPedKoiFWC2RiKGljAoNWiod1LayFd9IyqHDCjGx4z7Xg2D+6Sba
	ds7Q8CVjn+5w/mJaBzwoZwHRsFzKnBJsNx9rCzj+ihwG5g8=
X-Google-Smtp-Source: AGHT+IFoylUzo0whZWEE0vZN2Ek48agc4KnhEC0CToW9yiEQ1Zbe2ioVf8m7e/VfOfiJfcet9PVsqQ==
X-Received: by 2002:a05:600c:5026:b0:43c:f470:7605 with SMTP id 5b1f17b1804b1-43eb5c21036mr29632815e9.12.1743601228011;
        Wed, 02 Apr 2025 06:40:28 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43eb60cba2dsm21467045e9.18.2025.04.02.06.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 06:40:27 -0700 (PDT)
Date: Wed, 2 Apr 2025 15:40:26 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Jingxiang Zeng <linuszeng@tencent.com>, 
	akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mhocko@kernel.org, muchun.song@linux.dev, kasong@tencent.com
Subject: Re: [RFC 2/5] memcontrol: add boot option to enable memsw account on
 dfl
Message-ID: <4lygax4lgpkkmtmpxif6psl7broial2h74lel37faelc3dlsx3@s56hfvqiazgc>
References: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
 <20250319064148.774406-3-jingxiangzeng.cas@gmail.com>
 <m35wwnetfubjrgcikiia7aurhd4hkcguwqywjamxm4xnaximt7@cnscqcgwh4da>
 <7ia4tt7ovekj.fsf@castle.c.googlers.com>
 <20250320142846.GG1876369@cmpxchg.org>
 <ipskzxjtm656f5srrp42uxemh5e4jdwzsyj2isqlldfaokiyoo@ly4gfvldjc2p>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fpxy367fgz7uxy3l"
Content-Disposition: inline
In-Reply-To: <ipskzxjtm656f5srrp42uxemh5e4jdwzsyj2isqlldfaokiyoo@ly4gfvldjc2p>


--fpxy367fgz7uxy3l
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC 2/5] memcontrol: add boot option to enable memsw account on
 dfl
MIME-Version: 1.0

On Thu, Mar 20, 2025 at 08:33:09AM -0700, Shakeel Butt <shakeel.butt@linux.=
dev> wrote:
> However I want us to discuss and decide the semantics of
> memsw from scratch rather than adopting v1 semantics.

+1

> Also we should discuss how memsw and swap limits would interact and
> what would be the appropriate default.

Besides more complicated implementation, merged memsw won't represent an
actual resource.

So I'd be interested in use cases (other than "used to it from v1") that
cannot be controlled with separate memory. and swap. limits.


0.02=E2=82=AC,
Michal

--fpxy367fgz7uxy3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ+0+SAAKCRAt3Wney77B
SReaAP9PEf6fTG7T1DvIBCBKLHUb4pZJXbS4PrfsTVvv75/n5gEA2pS1+3FrrRz3
Mw0xE0eo8DliHcSRXj528SqePrQKZw4=
=Wsdl
-----END PGP SIGNATURE-----

--fpxy367fgz7uxy3l--

