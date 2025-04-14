Return-Path: <cgroups+bounces-7526-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18747A88AFE
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 20:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA393B3A2C
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 18:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AA728B51F;
	Mon, 14 Apr 2025 18:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BzbTPNFX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650D328BA89
	for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 18:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655219; cv=none; b=Z8VOMVhlN2OXw14M8MTHHRD13HhcHWL9G6BvSrquD+YiwATKBAzPcGIuMsQO6CBogy8nUlfIGOgwnEZQO4nIxNbWe6RMK8MWNAAcdgxvxY7OWYT1dyQvVnmUP2f4dxeXgbyDZPrtAce0cxdUd1No+sdiUO9gmWsFh2ezqDTKOlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655219; c=relaxed/simple;
	bh=xd5jcO/BnBVZ1KGnoNKPpwebkDQMkVngLYRvhQQPt7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbCuc1WH5rjijE+zLSvn3OoVm+zBrnS8eb7hMI5arEBLXw/RdAW9BbSsEcsb+nE72QS6nOPJKFXnoo1mWw7wpP07IakAP8XjB29L65sNOUudyrzo6MoJyfjbFSTjuS75463IfspCkqivwYO57zGFeYO7ZuJYUPDRqBd5wKgLVzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BzbTPNFX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39d83782ef6so3707646f8f.0
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 11:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744655216; x=1745260016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xd5jcO/BnBVZ1KGnoNKPpwebkDQMkVngLYRvhQQPt7U=;
        b=BzbTPNFXo66w7ZzDCz75iXLFqT9z3TUMPExALvWfv442W5lZ8Cp0eP8gg3S6cwRcXy
         kdpM5GnwjQbR1nty9GJClOUxyyENshN7vEpkdTPrnnCstHjqaU96gYiBm2ti1i0DfQYb
         EkQ8pOZoIp/HSl/OottEP8vzjjMFA4bvfKhI29FVAKADzX3pagM56+jLCCGjMowis1XB
         Eq2APjdfKjN5WaiRu0ga4ZWJlTcggnnEnfrT9KT4MF7oLm9/eBuI8pSGjyYB2Yc8yDu8
         r4iPnVSsQutz/i+OUUiVCJiQ0sJnn4Pa/yJ5zPDWpb01eJOrslf+tt82dt/OEY1b2kn7
         rOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744655216; x=1745260016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xd5jcO/BnBVZ1KGnoNKPpwebkDQMkVngLYRvhQQPt7U=;
        b=wds2rk400UZZI0VlFNtDdLgM55ZW99WjY/Yk1jo8MkTfw3CwpLvZaxGeDtaORKKOZ2
         E/gLdcyM9C2Km/wUBIRiCQmzlcQXvAllvjYtDzEfedcTd53qimFyJsyxKe2ZABqLDwrg
         tGb4pU4SoJN1VZfmwO3FPHp8uUFCKPsz+7bxY35pu7Owmzgmz+rggh+rIu7Io439XZ/V
         9KaLf1M8dzdZSkh6z/q3FjVHncEm9zcyg3T56DOw0z934Hn2z2tjWmPI8SCeJkYdbGGV
         MPkaWIgjbhjlVeyKPFXaeRwNwkyPnj5TX0Jpt9bRmuo1t4vQAKAXCnECOnQAvrAvvmX1
         sHag==
X-Forwarded-Encrypted: i=1; AJvYcCVzjRXRIIYaCIdLoR6l6tL8ud5yBvCNZGamA+MN7dZdXR+7KM6Glxqyo634+SEqX0IuAq4H2yhD@vger.kernel.org
X-Gm-Message-State: AOJu0YwoBuQqcueiVC3HoR8XiIUz6NZK22CbYVLm4bZXLFukzc9PrgoI
	TBnPIwvsn2CxIvZ7G31iohlIVMwEjaKsKF4Xti0vkIpsyH25QfhnlJFAdeViNTg=
X-Gm-Gg: ASbGncsYZYPuKF4tJSKoYhx43K7llZxgkui9rNtzLRp/rM0MIJoJ9qorXK5LQQtjJHY
	vkkJzPq3gVjs1LWpZ3WK89j5Mu3OOFNtk+OBTumOGQSKvwAC1q8rLhU4MH14tVIuCQwwQCTa/ld
	OsuHWRK+NXCTAIbHkurjothTZGSdl8P+1ZSyUpV7q3TMxGDiRmnqxbBYVqYfZfSncwwjDOkXbTL
	80Jivc7ZUzsgq8oZLO5r5Y59SsMqGP7ljQGT36ohHLjR0MNVtTfbREokyVZHc4TWM7qmdT+U+Ia
	O2pskNhkRbxkBDGAvBfMJUDWeoyzPUfdX28lKg6ZbrY=
X-Google-Smtp-Source: AGHT+IEgtFl79lgav6UWKkPN+8xkDBQnarv3nm1k6JqhcjfOJxYNuRFCM5qVW5DXBpugJOQoLYbwZw==
X-Received: by 2002:a05:6000:40c9:b0:39b:f44b:e176 with SMTP id ffacd0b85a97d-39edc32fee5mr331676f8f.24.1744655215559;
        Mon, 14 Apr 2025 11:26:55 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f20626c0csm189776595e9.14.2025.04.14.11.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 11:26:55 -0700 (PDT)
Date: Mon, 14 Apr 2025 20:26:53 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset-v1: Add missing support for cpuset_v2_mode
Message-ID: <ysc4oguaisa7s5qvdevxyiqoerhmcvywhvfnmnpryaeookmjzc@667ethp4kp4p>
References: <20250414162842.3407796-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qatjcuy2nkc33ezb"
Content-Disposition: inline
In-Reply-To: <20250414162842.3407796-1-tjmercier@google.com>


--qatjcuy2nkc33ezb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] cgroup/cpuset-v1: Add missing support for cpuset_v2_mode
MIME-Version: 1.0

Hello.

On Mon, Apr 14, 2025 at 04:28:41PM +0000, "T.J. Mercier" <tjmercier@google.com> wrote:
> Add cgroup v1 parameter parsing to the cpuset filesystem type so that it
> works like the cgroup filesystem type:

Nothing against 'cpuset_v2_mode' for the cpuset_fs_type (when it's
available on cgroup v1) but isn't it too benevolent reusing all of
cgroup1_fs_parameters? AFAICS, this would allow overriding release agent
also for cpuset fs hierarchies among other options from
cgroup1_fs_parameters.

(This would likely end up with a separate .parse_param callback but I
think that's better than adding so many extra features to cpuset fs.)


Thanks,
Michal

--qatjcuy2nkc33ezb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ/1TawAKCRAt3Wney77B
SeFhAP4o1uTFfPkkQOlsOgROOemLGJYDrUvCWIEij3sRqZQEJwD+Ltb/wknA2pcO
wBptU3n4FMcngZcezGJlb19l8MTA7gU=
=XJgl
-----END PGP SIGNATURE-----

--qatjcuy2nkc33ezb--

