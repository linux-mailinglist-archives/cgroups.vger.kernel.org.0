Return-Path: <cgroups+bounces-9129-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA96B2491F
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 14:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40AA4727566
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 12:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFBF2FE570;
	Wed, 13 Aug 2025 12:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B1tnnVWx"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5732F83CC
	for <cgroups@vger.kernel.org>; Wed, 13 Aug 2025 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755086630; cv=none; b=AHmadWZviPhnIoJdOA1oyEYajY8yHp5Q7TqVUF2aGMTxhx7qDu0IE0NT30/7282XCyoZKVXkSUKx8da7fnxxlfN0d1GZ7nx/6xL+GUoA9V1vlntKHS/STdnEiUldozGFCWFRg8oOCjU7BR5WZ3I7deD1HFIVhXfrlFN77sm/Wsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755086630; c=relaxed/simple;
	bh=rKllLer5f5FhN5MIo5XwI96o6JVObfFA728JhVC+kZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCsrw02HPi3hHugGWIKWjGz16AWxtysS1XvprCyi44p5gt0gMLMdy7Zn8GcLXtQpAHhPmoUc9yJ4xjFlIm0NCzccIrHI87PrLHp1V4/sEqFcxmy+v7qO4f61z6hld6tEubPsXnMngzAGcGfoB1wFhz1SzyAmph4+N5mpXnOvxQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B1tnnVWx; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b913a76ba9so1557596f8f.3
        for <cgroups@vger.kernel.org>; Wed, 13 Aug 2025 05:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755086626; x=1755691426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AYV2Res5TppAzTUXHhwCHqIxqoUTRPjCneBHo1BZ53g=;
        b=B1tnnVWxIcF1fp7eBXFkBZOXm/PfNJROxgmqIyVC8U7ba1/Tkq5Z+ybql/RAsEdAOq
         k//9YPLtJScOsP8S106kG3HJoCSMYZrNQyQIAOTL+tHMSrJZVqKHfua8QSOZDXjVsxjm
         ljJgdCTtBmGtNrTPZLttsl+OVaH5FJqbdZe/bopj2hVvZvGqmB3+ZvnKWLN0g6XULvhz
         hojSSHaYxTuWp4R0ChyhOGdODGzsBLbWmVvIXnBW7rwlrij2FbWvgUN848A+BkkN/dfn
         ftDZp3nxJsDSqAJVgwFvscL5AzpwqJx8kqKKc75JzoBmL0xu2CHU4BnrrpjR0ZmDsTtD
         kMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755086626; x=1755691426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYV2Res5TppAzTUXHhwCHqIxqoUTRPjCneBHo1BZ53g=;
        b=I7sH3p2uXo6SGjW9fPtv4Nx9X7KlKDlehXSQGdRvMNCBPg6rEPaiKHoQSbWfGyedwf
         oeV7cgfexIwUDQ0I6LWHOqByE5WYSIMghQyxCpT5esnsV7YxnegrLApq6W2GdgUnVThd
         gvnLp5T5zaa7Tc9keBr2cdJPDaisUeRTl+eHUQeOii0zfdImrx7/kriS2UKh8Cd+winV
         w0kiloIDR5j8/W33+9TaOEMz62EukV2HMEnU2JHlHtYbBbSSDVH9mSQcdbbf4F114ea2
         Bz97lRREwo1w2qKryQrn45L3kZqF40nQMS1B9zify6HKQ5FOXzoNKQF6AXcNf03SiekQ
         a/8w==
X-Forwarded-Encrypted: i=1; AJvYcCXzIivJ61j4lAT66V0an1PJXCheI9QgqUkgjQbBRjVa2pHdbzKLnRrxZkRhvfvPj5XkusTOXL9I@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ZgwYS6m4KN0n4Pk4Wp9yzY1C4Eo7vUAzgrQtrN5t9ZbGS+zE
	DhSVbj+rg1VuW7GYLdB8I9rXcRB9AxbT6VOuEZDqL8Xbbdgj/DJ+IeK3z3B+Q78nLpk=
X-Gm-Gg: ASbGncu1YdwkEtUBL8A8updbXGQsHSmU3NASkAD9AyxbM2Kft4pmJhTUlBBiRKEcZQf
	Uc8E6pCm9FtKqC9iawuVvRuOADvV7Q75FJaq3sq4dc+xC9h90CHxCYAmGDaQJUm/wEFbNZx/fj0
	lpoXq4CGlJycnWZpo8cpTr47Uy8gYdx8ec88Olggk8aKiXrP7BhsPPTErbUCeWllSgJ8Sm17DG+
	OYytd2CwwaRNGxQb7RkjUOMDUi0hZ4andcmndmAWTBL4gjmC3oVvO9I2TnKFsH0Tz7amQnDpZbX
	mwNUuWUNYspDhoBguTGqHNgCiGsURT6qTOazotuqbTxGGF/Ve32Uu6Mfo+WIU42DX+dDvk5trBM
	2qUe0jOF9GToTVLefxXloidbgVun2SlwCKUY4NwgMTg==
X-Google-Smtp-Source: AGHT+IER4YtqUb7xB1LDrkZc9vHAKsgWs444jj/zWeJsU/7bJPHATWgzRmAT2FLVQz2bMtHbgNBC8Q==
X-Received: by 2002:a05:6000:26c9:b0:3b8:d6ae:6705 with SMTP id ffacd0b85a97d-3b917ea1577mr1823732f8f.30.1755086626282;
        Wed, 13 Aug 2025 05:03:46 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b426f0883fasm18082064a12.21.2025.08.13.05.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 05:03:45 -0700 (PDT)
Date: Wed, 13 Aug 2025 14:03:28 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>, Daniel Sedlak <daniel.sedlak@cdn77.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Subject: Re: [PATCH v4] memcg: expose socket memory pressure in a cgroup
Message-ID: <gqeq3trayjsylgylrl5wdcrrp7r5yorvfxc6puzuplzfvrqwjg@j4rr5vl5dnak>
References: <20250805064429.77876-1-daniel.sedlak@cdn77.com>
 <aJeUNqwzRuc8N08y@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ohticu2i4xrkbaoa"
Content-Disposition: inline
In-Reply-To: <aJeUNqwzRuc8N08y@slm.duckdns.org>


--ohticu2i4xrkbaoa
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4] memcg: expose socket memory pressure in a cgroup
MIME-Version: 1.0

On Sat, Aug 09, 2025 at 08:32:22AM -1000, Tejun Heo <tj@kernel.org> wrote:
> Also, as Shakeel already pointed out, this would need to be accumulated
> hierarchically. The tricky thing is determining how the accumulation should
> work. Hierarchical summing up is simple and we can use the usual rstat
> propagation; however, that would deviate from how pressure durations are
> propagated for .pressure metrics, where each cgroup tracks all / some
> contention states in its descendants. For simplicity's sake and if the
> number ends up in memory.stat, I think simple summing up should be fine as
> long as it's so noted in the documentation. Note that this semantical
> difference would be another reason to avoid the "pressure" name.

One more point to clarify -- should the value include throttling from
ancestors or not. (I think both are fine but) this semantic should also
be described in the docs. I.e. current proposal is
	value = sum_children + self
and if you're see that C's value is 0, it doesn't mean its sockets
weren't subject of throttling. It just means you need to check also
values in C ancestors. Does that work?

Thanks,
Michal

--ohticu2i4xrkbaoa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaJx/DQAKCRB+PQLnlNv4
CG++AQDP1e1PiMrmOZVCNBib5p8lt5jF1ZYHE5uekhIEeGW/MwD9F23rTUtFtU0H
0id52DQEZKBz5V0PsOU7qzsmcZyROwM=
=yb3d
-----END PGP SIGNATURE-----

--ohticu2i4xrkbaoa--

