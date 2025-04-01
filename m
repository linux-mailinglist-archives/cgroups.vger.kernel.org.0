Return-Path: <cgroups+bounces-7282-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E41A780EE
	for <lists+cgroups@lfdr.de>; Tue,  1 Apr 2025 18:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2412516888E
	for <lists+cgroups@lfdr.de>; Tue,  1 Apr 2025 16:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49C520D516;
	Tue,  1 Apr 2025 16:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NcX85FE1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B5B2045A3
	for <cgroups@vger.kernel.org>; Tue,  1 Apr 2025 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743526777; cv=none; b=sBYSfQAvW3EW8/Y35+85YuTgIO3dhrwypahqi7Hc/B2kYIfmrDoPc2OWz+BYTJr3xeOjLn/zk/SiaYnM+1Jnr3eHBBdJ6TWYWW5hB9niQE3WjKqed/SPimInIFfxIZDgOBULWGDmUBFjnlXkbS+HlThwnpqRTeetUALCp8zDBWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743526777; c=relaxed/simple;
	bh=8j9csT7T3zFsxrVa5MUSaZdxw5xmhTU1QQJitylqOeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRBvbzhTK5l6nEkGSuuVyeNlI4tZVtQoSAX8C7Yw8VKkuU6iif+Rq5A53tnXzcfXDQ3Wf0SOIZTP+L2ljHWFIXpqxt0MEsumFT3ZPoY/8QJfyzshKOacwsYuXIm8J76og4ZlEtqAYFB7BVNlQTJAdTUo7ipqhHtkEaK2uigg594=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NcX85FE1; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c1efc4577so966785f8f.0
        for <cgroups@vger.kernel.org>; Tue, 01 Apr 2025 09:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743526773; x=1744131573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8j9csT7T3zFsxrVa5MUSaZdxw5xmhTU1QQJitylqOeI=;
        b=NcX85FE1/CpHE6BWCyrLlqWi8jYUsrkGVmUdZOpLvhUZwc7ArFAV7Kdb4cuAu+9itT
         FPT5jUyXzx5A0ROWQK8as5XMvvS/a55CEJsK34WW+AIf/LZTjVNA72sr5F9mR2GfB+aF
         WCiTwvvhZ3lAmuHKfVPUC1P7hHwDldIIeAmD+mMOGItrtAgLuWODnb93mRMu86B13LXi
         pRErUxNsK/wFU2IVI4xLEHe3KKJGdes7wHT9Kxo3VkUOIrFTyOUgOjP/N43+G2YIlfuV
         vBPn05V3QXR6SzUBacXNOycDLiFLm0vUHig7g65vmExe33YAQNk4af1MddVbJtA5eFfB
         VG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743526773; x=1744131573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8j9csT7T3zFsxrVa5MUSaZdxw5xmhTU1QQJitylqOeI=;
        b=dmH/e1vpVJpvQcn7Y35i2IP1rleFIDYpaTCYcbnFORmujs4eZ+MsBQvySDjYsPxORw
         IxbME8ILLMZBoenQv2ULexZEy5hg6BzAs7mRZHppK8KWDot6WE3gA4AoVEJIB+2ZjCK3
         TK5njwS0GK5OINhKbB7LdfNp8g4D84W3MGW9LDv3nbZkpNbUPmB5WdV2QmIGEnC0oJki
         ibsu3pb4ArM15WF9evj+8kxLsXcSTocxbknAs0jbWEYEU/htOG7y7+Ih4iwv2uREKpk1
         5K9SmLUEbB0waUnspncZUNu5yo1E4JPRKsy4DVLs086ThDNcQH21wmGTIxoZCcSVYg84
         iakQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+QmWK7WuYj/z8JVNgswkrzP5axH0SaPE3eSnpUTFjJSmSX+ZsPt0jM+ShdeSlWnCREw+pGNMR@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyl4s1ega86YuHq36It+X5TgVU71iiD+Xo8D4UrEcxpW0FTCB9
	dNhHloo+UurOrr5ZYUw5k2qxcfTMpr7c/crPxt+B1sdykBXLfl4r7jNiCyIlavM=
X-Gm-Gg: ASbGncsj0NBpb+BD4TD5Fj513Ce4mAiWSWx+E8wMCuTr6Jl+pR5RtyI7ZsX8/Up6W1U
	fi42rf05wPD3GAls2t465kjooaV7LDlDHsMg2G7kb6gecQmPjO6VMoR/g8na/Xw9xvdlXyiZRH/
	1ivSkZNz/bdfQ9c4BwQnrpxztbmkA5y49pwd46POTXclMb1VZ7bPw7B74kqeYMGPMRgwmlMLeB5
	4Y7H2E82ZUTnpNF4HdKXgV4PPs6OtXfC8dtZ2793ZnIx0fNdikLvcPfMBCQyzqH2BNQxtsCNpJB
	SJh9ZOYp9otO9KYCxbYiJfY+OZ8oEZB181cbxjNte1cqX/U=
X-Google-Smtp-Source: AGHT+IGmGuZ7CH1h/J68rAu6ViUqsODA1aGv7bhMu084X5Uyc7AHBFxfQpvF9waMpSU3HwerGbLZqg==
X-Received: by 2002:a5d:47cb:0:b0:391:300f:749e with SMTP id ffacd0b85a97d-39c23646f8dmr3602896f8f.11.1743526773618;
        Tue, 01 Apr 2025 09:59:33 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82efe678sm204228865e9.20.2025.04.01.09.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 09:59:33 -0700 (PDT)
Date: Tue, 1 Apr 2025 18:59:31 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, Greg Thelen <gthelen@google.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet <edumzaet@google.com>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
Message-ID: <454qatlzbtbfsh3vub7qrnropuyux4lxsokxt72fbiy2fpy2pu@dmfi22u5d64k>
References: <20250319071330.898763-1-gthelen@google.com>
 <u5kcjffhyrjsxagpdzas7q463ldgqtptaafozea3bv64odn2xt@agx42ih5m76l>
 <Z9r8TX0WiPWVffI0@google.com>
 <2vznaaotzkgkrfoi2qitiwdjinpl7ozhpz7w6n7577kaa2hpki@okh2mkqqhbkq>
 <Z-WIDWP1o4g-N5mg@google.com>
 <CAGudoHHgMOQuvi5SJwNQ58XB=tDasy_-5SULPykWXOca6b=sDQ@mail.gmail.com>
 <3mc7l6otsn4ufmyaiuqgpf64rfcukilgpjainslniwid6ajqm7@ltxbi5qennh7>
 <CAGudoHEF+dZmkoOJ2O_iaNEo5pR=BAbmYU8zuzKnfXcdKysj3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ckjmqmzjeeu6jrji"
Content-Disposition: inline
In-Reply-To: <CAGudoHEF+dZmkoOJ2O_iaNEo5pR=BAbmYU8zuzKnfXcdKysj3A@mail.gmail.com>


--ckjmqmzjeeu6jrji
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
MIME-Version: 1.0

On Tue, Apr 01, 2025 at 05:46:41PM +0200, Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
> Is this really going to suffer for toggling every 8 CPUs? that's a 50x
> factor reduction

As per the original patch, there's ~10x saving in max holding irqs-off,
na=EFevely thinking aggregating it flushing by 8 CPUs could reduce it to
(10/8) ~1.25x saving only.
(OTOH, it's not 400x effect, so it's not explained completely, not all
CPUs are same.) I can imagine the balanced value with this information
would be around 20 CPUs (sqrt(400)).
But the issue is it could as well be 4 or 32 or 8. Starting with 1 is
the simplest approach without introducing magic constants or heuristics.


> the temp changes like the to stay for a long time.

That'd mean that no one notices the performance impact there :-)
It can be easily changed later too.

> that said, there is bigger fish to fry elsewhere and I have no stake
> in this code, so I'm not going to mail any further about this.

Thank you for spending your effort on this, it's useful reference for
the future!

Michal

--ckjmqmzjeeu6jrji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ+wbcAAKCRAt3Wney77B
SUIHAP9R7MNVsOC2kC8SuClU2Ujt3vNJJBQmJymjTBteIYJxDwEAx6VVMgJxZFnZ
PTvgEioCGVZr8IxxN6gnrY74Paj+OAA=
=gAnH
-----END PGP SIGNATURE-----

--ckjmqmzjeeu6jrji--

