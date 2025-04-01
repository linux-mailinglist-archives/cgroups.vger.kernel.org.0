Return-Path: <cgroups+bounces-7280-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2046EA77E64
	for <lists+cgroups@lfdr.de>; Tue,  1 Apr 2025 17:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D2AD7A410C
	for <lists+cgroups@lfdr.de>; Tue,  1 Apr 2025 14:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5247205501;
	Tue,  1 Apr 2025 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U2OFy7cF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB122046AE
	for <cgroups@vger.kernel.org>; Tue,  1 Apr 2025 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743519606; cv=none; b=RaWW5MvTjkOriRlbkfrT/BlZI2Fs9vPQWlzdVmHmqW4AR/9etzb99m922me2DBgv240NJUa7+qe3zSEdLxpRxI2VycZ7hhjbeoJ5ohJCr/lcCS1ZuMHRKKxUu+fHO55SgTFby7HrqLRvY2szweEdOc9GPebW+ll1Z6Slz6mjKEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743519606; c=relaxed/simple;
	bh=zr0JB/HLjKttrKx+8iTToD2UVKmFBCMnGHEi26ulUYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKkoqFxX8enIi31yVqxdn5d7ocBL1FIIBxCNlSEXaP6wELoPZCYz4dJDdAIORpuG3phTlHHm0fh18TdBhm/XsxViJlKzsiHGtjgT/yiWjh97Rl1VaA1Juf3hpL710G230WQWVqfmVqnpDRJVOlrnYsda8HXpf67TvDM+QD3Btog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U2OFy7cF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso54873065e9.1
        for <cgroups@vger.kernel.org>; Tue, 01 Apr 2025 08:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743519603; x=1744124403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zr0JB/HLjKttrKx+8iTToD2UVKmFBCMnGHEi26ulUYw=;
        b=U2OFy7cFCfo2MeYGTLyxzJ/P7pD/d9EG/1hPIns2WCdRLDVUUjOW5UyUTz5DvIDJdx
         etrGjCoLZu1WP3NCDg760YcO1FKGGJbDKG9fVEHQ3x8g0M48vazigGNwJNyEP1sm8sIb
         Vw9uh9Jkt6ADmB1mMWxfwZMOWqn4PYOS2z8YfwW4h93sX9ZMAgStfzmK9zS6qNXgE384
         5iGDC7Ve8PZp1TEgC2anA289xNA+rAmkKWM7cOoBOByD65bxRvB719zJ51nEOmRAlOGd
         /onTEjZXKxfuh0VOl17k9+cKOsBzvdofbDJXjg1A4m21Rheoz5NS5kYc+3OXKC+OAyLk
         kbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743519603; x=1744124403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zr0JB/HLjKttrKx+8iTToD2UVKmFBCMnGHEi26ulUYw=;
        b=P2Gfqjvkncc58yr2XjD+Ec4teB65/SXfivT+6g9YlO7CxafsOPTMrSFY0EchJFD5f/
         D0JaxCaGOacHQG16fq5UAUcKaSEq4iKtr++dV1/RKbjhl/2testLK8064MDR6EQAV91r
         yrgdVB8H+RYXzs2njX2RK3B6rW4y/F3TiM6hGx7gwI6/0O5vnTRlKvv1GuGCHxXr0q5o
         pBUrWFTqGXFLElOTNOr75UZCcgQ52UdZNsb2glta6NhUE0KdU69dG+d+VYyrPhtLqUuy
         KFBnhwuSOWXShSzijP6WZdqAW5/TqynF80MfunoMVcZlvk8M/1ZEDTEufZakY5dwvmot
         Xy7g==
X-Forwarded-Encrypted: i=1; AJvYcCVXuxjESudF5KN/ujw40sYV/cbEu4Xr5hBR4DTvN7PgC+B7DUoYvmap+r9fAo3CKsYxB9Deg629@vger.kernel.org
X-Gm-Message-State: AOJu0YwEV/3+yPA0aNoT51iLSlFon52My+V1j3luAIwVjOohtPlhR4Fd
	aQEruyZhMPznerHfNlBNZQ6SPLqNJAQJxo79b/M2xI3IgLhIvjKZAO1CxwYpqy4=
X-Gm-Gg: ASbGncvU0vD4/zdMSHdNuV3JmjgxX+DGLaTijtrwODTZ9l0+xvnFxB5AeVfc/eycHj5
	S+gOmA+gePD2N0Clb0HEX3nAlzqMRyvhlWa17f6IfBbrRmLh1hnb7bAFl9iIzLv9V1lGTdAKS4N
	H3YcCI75fgy1PcPopHbNJIBrdtx0uYwP9hygDE605W4+oSGFgOUfv2MAfl1M4EJUwoL5Gv+1wBb
	PHzS4EYRv7MaASslTA7oZYmnc2NBmVea+FWVS45bhpUygm5kEczRcFML8Es/JkCcAsEUJGxvsnw
	LOlhKxJOgHEnsvRJahZIVc5EQJ5ctbLiwsm+EAJC8m/KNVY=
X-Google-Smtp-Source: AGHT+IG9qiOpqHKnET2z+7+OYUzICkVCKNCjwa1bPumb3yrHpomG+RZkTXHeCPna/QWMaGS8InXddQ==
X-Received: by 2002:a05:6000:400e:b0:391:2e31:c7e5 with SMTP id ffacd0b85a97d-39c120cc88bmr10593073f8f.6.1743519602797;
        Tue, 01 Apr 2025 08:00:02 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8fbbfebasm157897815e9.10.2025.04.01.08.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 08:00:02 -0700 (PDT)
Date: Tue, 1 Apr 2025 17:00:00 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, Greg Thelen <gthelen@google.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet <edumzaet@google.com>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
Message-ID: <3mc7l6otsn4ufmyaiuqgpf64rfcukilgpjainslniwid6ajqm7@ltxbi5qennh7>
References: <20250319071330.898763-1-gthelen@google.com>
 <u5kcjffhyrjsxagpdzas7q463ldgqtptaafozea3bv64odn2xt@agx42ih5m76l>
 <Z9r8TX0WiPWVffI0@google.com>
 <2vznaaotzkgkrfoi2qitiwdjinpl7ozhpz7w6n7577kaa2hpki@okh2mkqqhbkq>
 <Z-WIDWP1o4g-N5mg@google.com>
 <CAGudoHHgMOQuvi5SJwNQ58XB=tDasy_-5SULPykWXOca6b=sDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lhtzb6rhkzysoxx3"
Content-Disposition: inline
In-Reply-To: <CAGudoHHgMOQuvi5SJwNQ58XB=tDasy_-5SULPykWXOca6b=sDQ@mail.gmail.com>


--lhtzb6rhkzysoxx3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
MIME-Version: 1.0

Hello Mateusz.

On Thu, Mar 27, 2025 at 06:47:56PM +0100, Mateusz Guzik <mjguzik@gmail.com> wrote:
> I feel compelled to note atomics on x86-64 were expensive for as long
> as the architecture was around so I'm confused what's up with the
> resistance to the notion that they remain costly even with modern
> uarchs. If anything, imo claims that they are cheap require strong
> evidence.

I don't there's strong resistance, your measurements show that it's not
negligible under given conditions.

The question is -- how much benefit would flushers have in practice with
coalesced unlock-locks. There is the approach now with releasing for
each CPU that is simple and benefits latency of irq dependants.

If you see practical issues with the limited throughputs of stat readers
(or flushers in general) because of this, please send a patch for
discussion that resolves it while preserving (some of) the irq freedom.

Also there is ongoing work of splitting up flushing per controller --
I'd like to see whether the given locks become "small" enough to require
no _irq exclusion at all during flushing.

Michal

--lhtzb6rhkzysoxx3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ+v/bgAKCRAt3Wney77B
SXa6AP9UY9UpmP/PK0EYqNZ2VFIM6F2xZ1gnkE8mn3oo41sCUwEAlM/YE51Kwt4+
B5zUl6bs53aI6sxUZYxjYcpl1p3zbw0=
=QqaZ
-----END PGP SIGNATURE-----

--lhtzb6rhkzysoxx3--

