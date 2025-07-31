Return-Path: <cgroups+bounces-8967-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3277B173EC
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 17:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 227627A83DB
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 15:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF371C07C3;
	Thu, 31 Jul 2025 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Azrhfok/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0611715A8
	for <cgroups@vger.kernel.org>; Thu, 31 Jul 2025 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753975594; cv=none; b=erlMl7ssxnoKedpdIUaOtQlGmQL/tPUZzcF8Cm0U69IpxGxzAJQQlMtgOUr1W9vf8Wl42Nv/jAEcFbtxPezPHEiVm1IfCLlyXR3q33FV8XfgOyRli8qVENz6XmfiO5dPvymNJDck7ZvIdXo9+CFuZYMZAaXL3TdJyBkq6HR8Tcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753975594; c=relaxed/simple;
	bh=9juaDkkLRGmc8ob7w3T4Osbk94u62LnIkmznSae3mdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiJUIlXRb8Uf7oO2lnCrdHsSQiWeKW2/fLZLDb3fnGu0mXbp2IhBrWT4j6nMm4OEmAKbzgYweCGfzV6cGx33f6flJPf+YZA/6dJ+yCtp/4NZKNDOi+aD3TPTEQlygZs6DQmVPzTf8GlHb9gxM8mlP/lrV/DAy23KhvyPlr1kxhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Azrhfok/; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b7910123a0so1061241f8f.1
        for <cgroups@vger.kernel.org>; Thu, 31 Jul 2025 08:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753975590; x=1754580390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9juaDkkLRGmc8ob7w3T4Osbk94u62LnIkmznSae3mdw=;
        b=Azrhfok/TWrImiBSL9E80nt3ytazljmPJ5rUFRtrVlezIhGKOlves3IHvNYAO4OnOl
         2nSfope8RGkC8h1KdSNP9fNfVZSvkoEMtEVRHL3Ky3v5fyUzqEXJV3dGiBE7iTQXHlIM
         G8s6qcotzs6VjE7xMbvFyiOVXRzgC9sU/Bsk2xhwWuSS744xEbV+9uGbMUbFNYl+5t36
         C09vVLiW4mZFBcV/s/ZthE8cdnwe4cq40tKm+zmhQ0PPnapzZNc6jciMsFQgB/gYUzGr
         Myhw6dzZPsrRqZEqnqK+/img89zxsh6BWAFAOS0Yso/Wp12gBVNsBITN6WlZFDMmyjMC
         v/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753975590; x=1754580390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9juaDkkLRGmc8ob7w3T4Osbk94u62LnIkmznSae3mdw=;
        b=WFYRmCuWw3jiCX2w4xM81dRBqMt0hpmeUqNVkfQg0W9Sc3yI1l3EOkNo/0HBJ1u9ra
         +KharQeOgnZ+3TD4tAtwZEp4MI8iR0R41DRfY8FnNkdM51Qvk5Apbyo6Defh1ZAykU4E
         f5mTeGG62xKyuM56xhvMp3LQKCrmjasn9IntEUc2Vwd+gIEMKphbO9/C4jyaeEGkLl84
         O1J2aJTdAtQUIsHnl1LTSFYvZOoVz1ezQlRUJMmjMxwSM+xYg4PQAqs9T2YjGgG+bhjG
         EQFZ/LMCy3XOeuuLf61D7DfCaETyuYbe6xWqf/WABoL2rEPfAUtQh5X7APnmQz4XiJzW
         jHFw==
X-Forwarded-Encrypted: i=1; AJvYcCVtUmEicEDNyF1L+30vebAzGUGoXGhjN4fbIAJa/8bA44fjpXnYr7UOI+aysTkz/FcsXp4I3vbP@vger.kernel.org
X-Gm-Message-State: AOJu0YzrqFdO4DuP0bneyOq6RBHQKuarnqz+pgZvxLyh5442qymZB8TG
	NcJ+JNtp3Pw7AJijjKjZ/YrtI5IGVilfGIsM49rvoUm4Eh5nOJzTOFxZ106d2qVtr9U=
X-Gm-Gg: ASbGnctD6MImX4Uqy9aqNxET2i7WtikRHKjnMLd2k9/IQdEpzcOETV4vcegIoA5Svn1
	lbW/BHURs4AXSJovlhPOnJIkvO4YDtqTV+/N9D3pzxKbeiHtBNaWYInjJBD0rWY3u7jDCDXXhm8
	8WrWXKacrl3E6PBpj/5dM+JIgF/mRo/2+FPsbJLquIRQ0NZipxEwTbV5FLsAf+MPZ7tKf2WM+M8
	//LkPw+48+Tid0NUsC5OJ7OjWvtoRCGgRicWT+nUXfoDVfFx0bdF+qxTnNf75TzaNjyQEi9btXs
	shPeTydCF6NUYgWfwH8Gu5WvAdUU5McNMWpCiDMNnuuHmzSGxyN3y/FGY7QoobQZrzyz9I0vfIT
	tXyeemiITQDVNdEH+WXSaby4gskdKpV2awXTS69b4Gw==
X-Google-Smtp-Source: AGHT+IHosNTNqSAYsiaRoVcj5bbYqHUmmD3ECRLqjZ0BCWAL/u1qGF9hjcwGucQfYS+n1yPTnFEUpg==
X-Received: by 2002:a05:6000:4287:b0:3b7:7633:4e71 with SMTP id ffacd0b85a97d-3b794fecc7cmr6509494f8f.13.1753975590264;
        Thu, 31 Jul 2025 08:26:30 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3c51e2sm2651464f8f.32.2025.07.31.08.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 08:26:29 -0700 (PDT)
Date: Thu, 31 Jul 2025 17:26:28 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Bertrand Wlodarczyk <bertrand.wlodarczyk@intel.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shakeel.butt@linux.dev, inwardvessel@gmail.com
Subject: Re: [PATCH] cgroup/rstat: move css_rstat_lock outside cpu loop
Message-ID: <v572yf2qnle6ikxjb2ofvcmkuvpantmngrprrofd4kcia4xtld@uge7ti65njyj>
References: <20250722124317.2698497-3-bertrand.wlodarczyk@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gfal7nrfele3ayud"
Content-Disposition: inline
In-Reply-To: <20250722124317.2698497-3-bertrand.wlodarczyk@intel.com>


--gfal7nrfele3ayud
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] cgroup/rstat: move css_rstat_lock outside cpu loop
MIME-Version: 1.0

On Tue, Jul 22, 2025 at 02:43:19PM +0200, Bertrand Wlodarczyk <bertrand.wlodarczyk@intel.com> wrote:
> By moving the lock outside the CPU loop, we reduce the frequency
> of costly lock acquisition.

So IIUC, mere acquisition is so costly that it dwarves actual holding
(flushing) as there are presumbly no updates collected.

As Shakeel wrote, there are reasons for not holding this lock for very
long (beside that being a general rule).

> This adjustment slightly improves performance in scenarios where
> multiple CPUs concurrently attempt to acquire the lock for
> the same css.

It means they can read cpu.stat more frequently but will they get any
fresher or more precise data? This is not clear to me, I understand why
this benchmark improves but does it represent some real world
improvement?

Thanks,
Michal

--gfal7nrfele3ayud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaIuLIgAKCRB+PQLnlNv4
CNeaAQC+/JNywSmgXWFmYEIKoxAL9joW7RMKPLnEE16OZ45WpAD+I/LqOgwJh0Dk
RkEoupDQifaFFt68kTjVnu03PgaTGAU=
=+FI6
-----END PGP SIGNATURE-----

--gfal7nrfele3ayud--

