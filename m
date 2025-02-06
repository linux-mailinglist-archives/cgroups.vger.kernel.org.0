Return-Path: <cgroups+bounces-6447-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18506A2AD24
	for <lists+cgroups@lfdr.de>; Thu,  6 Feb 2025 16:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D4116A6DF
	for <lists+cgroups@lfdr.de>; Thu,  6 Feb 2025 15:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E95B1F4184;
	Thu,  6 Feb 2025 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LQ7TU7r9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0621F4174
	for <cgroups@vger.kernel.org>; Thu,  6 Feb 2025 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738857466; cv=none; b=YrB/5jUDdNOtA4IQqzGatqgQlX/i2Xt+Em0p0OiMzmwQPe/Gin0mLUttdMj0g+mNR4NBo/o9EfS6TBWpU2xnsod4I+EYNRn/0Ny/ZFCRYlFhWRv78LxF3efMrRhwCzwMr1xkrtyckxgj3TmkLnP70hRQ+b212nHXDQTJ83aX5J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738857466; c=relaxed/simple;
	bh=VVbyILDZ8O23cCbLemWssIEyMVaqbxgt8Ip2vBbHLgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNyLNY2vaO1aERGwJAXilzS0se/ySAiqPtKWgpLGbt0gI5+aRZI4jwymKB7T745iYjcVZ5QajOqu6v2Kwx8jsi/CGIUP3J1FW7XskPUy/IF+tYXPHZjl3KWsNL2mUaFryH5BP7psyJ44GlsThZLxdWNS2jg7IsXczi5xKQ62Ej0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LQ7TU7r9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso7712495e9.0
        for <cgroups@vger.kernel.org>; Thu, 06 Feb 2025 07:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738857461; x=1739462261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VVbyILDZ8O23cCbLemWssIEyMVaqbxgt8Ip2vBbHLgI=;
        b=LQ7TU7r9X3vpvWHFqz5/RnQFlO7jYbQxA7b6omxtGjka9Sr7TippAcHldsloIeqAGC
         hQZecHToCJ0ZgtwJi6P9t3pokD1eNf8sFoRxSZz/Je7hzL5FlV6bwUV0pKdeOny6XAhi
         VChIqtwJDzCY6vq82syNRoYlqAwbeNesRUWK2MrGn/Si1cv3WRSu6Vg60iQCuDNOMYAe
         9954EY8459nUhTt/BZMIVM5MDJNXMMjoctmT4CHRw4jl9iVhVJH9hgbf38BcXurDl95L
         QHEZCdaCZONEXmC2I+hWprmWJ0yRUGBlFg+cYgbXQCuUsp+miSl0YmS8rQPe2FBmpfii
         QTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738857461; x=1739462261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVbyILDZ8O23cCbLemWssIEyMVaqbxgt8Ip2vBbHLgI=;
        b=ZKtLPJr/bvByVPVDCzX2QIR+xk/YjdBwWz4O3LukWBzyb0zNy4BjeP4ofs5bgNHic/
         4Kdy72DDDZVtyb/GK0eTYdjF3+/Ls1i16jmyxyBF9K4QqZgpCM0r/y0lN1ww/ZjNQblT
         HwLgxIMsvkxJmohrFZrGJXm/gw7DNUrNvtBOWq4PmNHbrlwhphH1XEqHh0eBalEZkOrc
         i0j+CiDrqXe2RfHAwSyr+Rbo4QObZR6e+Yumm4uHCwYy1RFz4/z5WpACAJFZBcrRuQu8
         rB5321LPdr1E7QbVOhMDBlbC6q1vf4qv0v/yCFfMhcqWV/PRkLNSxJpkxmphQ2Rzfdnn
         lBoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV225xTXf5NlT4jtOIQbCjE7FHFkHhYGhmbfGvdVCvj9+T5PGwkZMyPyPj/1ODJJcHjPQzeGf7S@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8bbZPKbUwcLA4R94fDbRPKJVTdHnUttY+cTVK96ZQw2hOL3TB
	sb6ayCtuXXYoFk0kV5GXFDBtUtxF/iWx1Zk9M17YyVjeD4YNQo8b0/m8XWrAY+E=
X-Gm-Gg: ASbGncvwsDWFf5SOrhuPa+DT3+o720EXzy8bY5p9JLUo09sDHcC0NYF7nu6FmnGxM2/
	7211efk71guc/sYXZV3q1Pc5H7QiYZ0abG/KKLrw+5OL9feg3rkTA1U6HNrvTWGwAQsqezyF3mU
	K1tYM4KVtuWB654K7U3e5s/7UUYwAVPxQD3VGDwCnwH3SKvvlIj14ope479vNHRtiHfWZdjq7ee
	SfRN/D2S6hbtumiwnvbyqJV3yhrn4Bt+qQ0vzEO2A/+XCD5SUQRe4jF+ssXttc0SHXj7qrSp7l/
	tgyL4LyvvYBDumqI9A==
X-Google-Smtp-Source: AGHT+IEtnYVZgigZSV9GOOjiw4uU0akvJHJHUr5mEW7I59L42GPOmQnzeJu25Ocod8gQri8uVU0GSg==
X-Received: by 2002:a05:600c:354a:b0:434:fbcd:1382 with SMTP id 5b1f17b1804b1-4390d435cf2mr78308015e9.11.1738857461578;
        Thu, 06 Feb 2025 07:57:41 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390692a66esm58718075e9.0.2025.02.06.07.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 07:57:41 -0800 (PST)
Date: Thu, 6 Feb 2025 16:57:39 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: add hierarchical effective limits for v2
Message-ID: <mshcu3puv5zjsnendao73nxnvb2yiprml7aqgndc37d7k4f2em@vqq2l6dj7pxh>
References: <20250205222029.2979048-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="toufq4e4fjypkuvv"
Content-Disposition: inline
In-Reply-To: <20250205222029.2979048-1-shakeel.butt@linux.dev>


--toufq4e4fjypkuvv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] memcg: add hierarchical effective limits for v2
MIME-Version: 1.0

Hello Shakeel.

On Wed, Feb 05, 2025 at 02:20:29PM -0800, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> Memcg-v1 exposes hierarchical_[memory|memsw]_limit counters in its
> memory.stat file which applications can use to get their effective limit
> which is the minimum of limits of itself and all of its ancestors.

I was fan of equal idea too [1]. The referenced series also tackles
change notifications (to make this complete for apps that really want to
scale based on the actual limit). I ceased to like it when I realized
there can be hierarchies when the effective value cannot be effectively
:) determined [2].

> This is pretty useful in environments where cgroup namespace is used
> and the application does not have access to the full view of the
> cgroup hierarchy. Let's expose effective limits for memcg v2 as well.

Also, the case for this exposition was never strongly built.
Why isn't PSI enough in your case?

Thanks,
Michal

[1] https://lore.kernel.org/r/20240606152232.20253-1-mkoutny@suse.com
[2] https://lore.kernel.org/r/7chi6d2sdhwdsfihoxqmtmi4lduea3dsgc7xorvonugkm4qz2j@gehs4slutmtg

--toufq4e4fjypkuvv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ6Tb8AAKCRAt3Wney77B
SV0+AQDW1xJCBatKi6xRC0ZESDInrTI1kQ6qqN9CO6w5z8FpQgEA1zRlG0NxFEN7
nUgSeD9K4yF5HvSYXGo3jlGZRYaPPAc=
=wGHN
-----END PGP SIGNATURE-----

--toufq4e4fjypkuvv--

