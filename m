Return-Path: <cgroups+bounces-7149-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8371EA687AF
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 10:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CBA318919AD
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 09:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EF325291F;
	Wed, 19 Mar 2025 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="edF5KG9j"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6633A250BEB
	for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375724; cv=none; b=PUY52eEsecuA+1J/3+U8BkqQaAv+l4ekt8TJSeLVUySoA0xET9dIESQsDb/rKK8aUt5axpp1lo+MNob82TUlaI3SytQApud6l9E4NVnj/ulMpZH5v2j9BX3yJ+6W+yyRN9PcD78L9P1n+XobLsyPRbkZ4XELdMzXc2eZb9r/jSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375724; c=relaxed/simple;
	bh=sdoWtmP8lcFKkLO6YKHdSDaFP6raFIU4DI5wjtYIURA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdJp2VuyNMO/apk+0E1QHaeCaqz9IhjQNN6SVAnqSJ7X8mcoVhWT2q0rOPwJlUtWfIV3k6vp2EXomyhY4U4DnhFDbCaBBrA+n1FsVqkcimp9ClaMPhTslFVejdqVvFxLACEj6ZNoxGA6HycuhDnKQ5Xw5VsmFaUmb8PFqp6GQnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=edF5KG9j; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso3036085e9.0
        for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 02:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742375720; x=1742980520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ahIpFM+QNyoBpC1gPfBS5sPiHVhg0tBQ7r3MPVtw/d8=;
        b=edF5KG9jLZLUN18XPd0AqVDW5B35OYV942dGR6Gam5ddWNuNE1O/QDkojmyhFLuJo6
         R5OHvmHwe1ZwV1uYmb3hg4UdrmyVyoEOdaQHmP5EjROsMVl2qj1okO2BJ0m3u61FiBfA
         TgDvnAlO4/tWPskMz1a9BzBevQU8dSBxdEpuy4deuveDuw4V40lbJg1UJRWszB133UAy
         8AVUcyngjPNm65vIcbBVVrdwhJKP3DA6PhANX7fWO0gsTK24Vw+2ZZK5mUafT5st0Jj6
         RVht+tdj//U7tIJ4ZxFrNQHwetJpV4ufw9hVmp5jxEQIkt49Amtn41U8mKec9BNVJ4u5
         j/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742375720; x=1742980520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahIpFM+QNyoBpC1gPfBS5sPiHVhg0tBQ7r3MPVtw/d8=;
        b=TnvylQeZCN9/vvTI97geq06daYIRG2fTJbrJwI5GvRgPvx3Uq329ULYsfUEGY2aws9
         3ehM4pt75t9f57Wm5QevgpsBioZvgcbRZ6vNASbaByT4DC/xFwqcvwA/RNmBbrJy9Mu4
         mD8hmzj06yXmfnqOp0Ikhfy6QRQ8fYqVC8h/NKOtzznCZQv7OjT04xxmIPQPPmGB0+8Z
         ntSiozGbuoT1bBmu+XgpumoCKN30Oxt9R+3zg7EedaZy4JCqXIiovE3EifZDUXC3xvvm
         Mdz68NFyQJ2THZa13oEOZ9+gMR7KsjK35x2WY7nciZEvOeIHdqrlTR7nYvlqwlBlLUtq
         95VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBoKvtrKa63FNLYztTS3eLO4mqUbhnt9IUS2Gwn7NVdxAg9UP9+CAVmJOU6Ht7z9dvR9qMb1OM@vger.kernel.org
X-Gm-Message-State: AOJu0YzpKdCBxCm6dn82t5zuGV8++DPggqWYL2zg2dwkmgTg7QcoYja5
	q5Pv74m98Xxr+uWdXqsiXj/dCuPyVErp75CmCGSSTC3pGgoJYilA4kRY/L9nMOo=
X-Gm-Gg: ASbGnctT8bC4Y8BUhOibOSiw/lBWvxNHzNRSn6Tvvkv81Cb84EfY5hlFRolFI589nLn
	0RK3R1eJQM5QpfVxJLHoCvWEtXtIrLwqZg6l0du1laiAyT3/aoMNREPgLy3GWwyUFtiackiGLRk
	4BK66LuhAf9ZA4UqgXsEbSPfC8HpAnMHEMnGmm4i+f+OmdyWHd87Q5lI5rTzv4Uu/63InfBejLF
	EHTy5DiN1gx/esO2d91ygh4GzqSQ1vfZxOugSCJWfKqHNacRnNFCb32vFsVIVmARj085LPJbAzF
	tAwQxHxNaqIhuYXfucToq5FHVsjjAHvBSAXkkdLFHloa2FE=
X-Google-Smtp-Source: AGHT+IEHJqVdsFhvFTJ0j9XFeF9mtqW2S/78HUhgtYFtcniJo8M+ZzwHHxF5ImTnWsi+nzTq3v24/g==
X-Received: by 2002:a05:600c:46c7:b0:439:5f04:4f8d with SMTP id 5b1f17b1804b1-43d4309c628mr12508825e9.12.1742375720499;
        Wed, 19 Mar 2025 02:15:20 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f7460fsm12870405e9.28.2025.03.19.02.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 02:15:20 -0700 (PDT)
Date: Wed, 19 Mar 2025 10:15:18 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: hannes@cmpxchg.org, akpm@linux-foundation.org, tj@kernel.org, 
	corbet@lwn.net, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH 1/2] mm: vmscan: Split proactive reclaim statistics from
 direct reclaim statistics
Message-ID: <hvdw5o6trz5q533lgvqlyjgaskxfc7thc7oicdomovww4pn6fz@esy4zzuvkhf6>
References: <20250318075833.90615-1-jiahao.kernel@gmail.com>
 <20250318075833.90615-2-jiahao.kernel@gmail.com>
 <qt73bnzu5k7ac4hnom7jwhsd3qsr7otwidu3ptalm66mbnw2kb@2uunju6q2ltn>
 <f62cb0c2-e2a4-e104-e573-97b179e3fd84@gmail.com>
 <unm54ivbukzxasmab7u5r5uyn7evvmsmfzsd7zytrdfrgbt6r3@vasumbhdlyhm>
 <b8c1a314-13ad-e610-31e4-fa931531aea9@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2vr2zym4stjkfz33"
Content-Disposition: inline
In-Reply-To: <b8c1a314-13ad-e610-31e4-fa931531aea9@gmail.com>


--2vr2zym4stjkfz33
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 1/2] mm: vmscan: Split proactive reclaim statistics from
 direct reclaim statistics
MIME-Version: 1.0

On Wed, Mar 19, 2025 at 10:38:01AM +0800, Hao Jia <jiahao.kernel@gmail.com> wrote:
> However, binding the statistics to the memory.reclaim writers may not be
> suitable for our scenario. The userspace proactive memory reclaimer triggers
> proactive memory reclaim on different memory cgroups, and all memory reclaim
> statistics would be tied to this userspace proactive memory reclaim process.

It thought that was what you wanted -- have stats related precisely to
the process so that you can feedback-control the reclaim.

> This does not distinguish the proactive memory reclaim status of different
> cgroups.

	a
	`- b
	`- c

Or do you mean that you write to a/memory.reclaim and want to observe
respective results in {b,c}/memory.stat?

(I think your addition to memory.stat is also natural. If the case above
is the explanation why to prefer it over per-writer feedback, please
mention that in next-rev commit message.)

Thanks,
Michal


--2vr2zym4stjkfz33
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ9qLJAAKCRAt3Wney77B
Sdz/AQDecvjUIrBbge909wB9b5M9WL2CyeFc32hNE+fRPTIFHAEA6LHJUMgFCinA
+J9mJe//Ur+z8K0lQBS3T8v+E9CbmQQ=
=VFn0
-----END PGP SIGNATURE-----

--2vr2zym4stjkfz33--

