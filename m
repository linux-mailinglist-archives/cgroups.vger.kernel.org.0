Return-Path: <cgroups+bounces-8966-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 121FEB17234
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 15:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE511C2143D
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 13:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EDC2C3273;
	Thu, 31 Jul 2025 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ekIlq9nz"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ECA2C1581
	for <cgroups@vger.kernel.org>; Thu, 31 Jul 2025 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969153; cv=none; b=RyeW9/sGa5mwg6O3mr1CgfpTJ5YRn9R1tMAmaN5u9FqtFKqdsUGxSf6fBAh3a0ukTOTvI6I46n8Al64OcTnUn08AsK21ElWkgI9+T7rxUbqa012uP7phe+aTFu7a1dO4iMIsl537MzhLDFS5xZ7eh7IGUKltejyIt5qo+2lsxQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969153; c=relaxed/simple;
	bh=b0p3P4TSj0m67jYyynFdzfNgF0dMZsVUy/M9Sl8OXsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mN5vHHD9ragZZ/RNVAOpJPuSPuUqsjjprq0BH5QoFTXGAZupJOOA7AVxZDOIGm1OxddNXAWqmCPcWIMSms5934EfRhW2R/a4e+PzEseRUH5itmH5vVpjWdKoQh0jqsF6k61CopwXARl7JUMrLDK7IVT12eKlzUrFlliRFSaM6oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ekIlq9nz; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a54700a46eso589815f8f.1
        for <cgroups@vger.kernel.org>; Thu, 31 Jul 2025 06:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753969150; x=1754573950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TTMiwDI5I7ZpdDu7u29+O3OSLlyCf5CWJBCKHAd19vQ=;
        b=ekIlq9nzRszaqgTCrn5kzLewg5H95GGKISjEAMbYlIt0q4M2dWw2iWDdBCmTeNlqWT
         BhX2FV9d7c0wh4LWDEyCJp4narEEcecnJWELEVW5nsdwMEW1NhhvEH8fiNCR72392vRl
         taPdDKCoib/uV7s4TI/HyyTsfDPmMglnEnrBFNl74USvkJr+mASkBfGFrwZFIhhAqe9x
         7LFf5yZ+4zeyNcgn2enlfreKGU6BM1ZpRmPDGtCdGdsOvsh3o0mnHd/SHT0uKcIKhnwC
         B8i8BIujazYL689ZEGrY5W+YkxV9xtX5PLp+x2ZPKJ4M+d8CNDxVxgYuUabstkBirsI+
         uucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753969150; x=1754573950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTMiwDI5I7ZpdDu7u29+O3OSLlyCf5CWJBCKHAd19vQ=;
        b=LvFyveG1e9GazhDYaekp+IIf2A7uGjxDt7TVLyqhUzl9sZhSH1MRSKbEnVr2mQ+vF6
         F2qGXWOJzZVb1V50HSdVf16EY0Bn/B0GVvH7obKQWM/dDwVUjmk0HaaC+r0c/LsGjUYY
         G1hhCr+ANHAkWPQsQuNVfCHJnFVZGHioz/uPtfrF7wTmFL+6DWSbFDabwlhMTkkkcGf+
         ZgNRlj4/ho9LSUEkwL5dZvp6i3J0wJSl4x0XuLaHm8hdhulNYpdIzKPXNuxwxQT+OaPe
         oEfEsKlsDCpZLy/EhH6EO0Z04fdHX7eR8mkQJqUXNkxha9Wwck/DBM2yN3QIr2Oh9KAe
         jrnA==
X-Forwarded-Encrypted: i=1; AJvYcCVFs0aLnS44QgzYqCg5hx3sY0JUt0q4V932qowKwB7jPKgL5bmXnySyOFLbJKu96AofiwnoI6Ad@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2/OyDFhsNny6rnh+fIxCWi9VsrqTUBQOoBokuhZr9GfTX1cry
	pbwTuFNoeKg9FLl0aSAWrntdThRGQjhX535txNf9dQsH7uZZaDkeEee7ay7jMCL5zNM=
X-Gm-Gg: ASbGncsKNbvvAf7V7w+zV5XOaaJZxlPECPkJFIxAm7iuWxSBBI4T3kh2sIfEVxNoLXR
	gEFnCEUBcQNyN2t9AoxWl2vFyXgi3B/rWP8Oieys4I1GTjKOLCUF7ev/Aqp+/DxVS/qXt7uk2iQ
	3t6LE8u/D8N5W9ycacUNRkHGXLnfo+ssIPfGJMKO/TOdvhSlxH5sCG6YLkMvMvou5wb5ClWV+PC
	pgh6kNa0FL+C05nCAlIZIrTCtFXv0q2ZyxwDWJ8sbMjP4bGD87CrXkE0oGKnOH0WhjZKTsUiMeN
	Q8iHyetI6iAY6lI+7s2DBhilIKU6bUGLTx0Ynsj6jcDWR5vjr9GzB65sFn4/NuuskvDrh8upOfe
	ZDXZDEs0GgFKjodSmEBGZJ7t24r0MGkul+ioX7DtPO9rUidH8j42M
X-Google-Smtp-Source: AGHT+IHYvsEIX5itHKow1mLcVDqvWDuNXSbVTG7QQc1tvuwHoyl4F7TOUm51Nd1pmo+PXsqydNAs+w==
X-Received: by 2002:a05:6000:40c9:b0:3b7:7c3b:1073 with SMTP id ffacd0b85a97d-3b794fffcd7mr6922320f8f.52.1753969149579;
        Thu, 31 Jul 2025 06:39:09 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4532c4sm2448753f8f.36.2025.07.31.06.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 06:39:08 -0700 (PDT)
Date: Thu, 31 Jul 2025 15:39:06 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 net-next 11/13] net-memcg: Add memory.socket_isolated
 knob.
Message-ID: <pvygtpy4b7napeudlk5dtbacgvqf6j4lrr5nhye6obrwv2ss2o@ubxpyqwf56pz>
References: <20250721203624.3807041-1-kuniyu@google.com>
 <20250721203624.3807041-12-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wvv7vwafoorhn7v5"
Content-Disposition: inline
In-Reply-To: <20250721203624.3807041-12-kuniyu@google.com>


--wvv7vwafoorhn7v5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 net-next 11/13] net-memcg: Add memory.socket_isolated
 knob.
MIME-Version: 1.0

Hello  Kuniyuki.

On Mon, Jul 21, 2025 at 08:35:30PM +0000, Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1878,6 +1878,22 @@ The following nested keys are defined.
>  	Shows pressure stall information for memory. See
>  	:ref:`Documentation/accounting/psi.rst <psi>` for details.
> =20
> +  memory.socket_isolated
> +	A read-write single value file which exists on non-root cgroups.
> +	The default value is "0".

Such attributes don't fit well into hierarchy.
What are expectations in non-root non-leaf cgroups?

Also the global limit is not so much different from a memcg limit
configured on ancestors. This provision thus looks like handling only
one particular case.

> +
> +	Some networking protocols (e.g., TCP, UDP) implement their own memory
> +	accounting for socket buffers.
> +
> +	This memory is also charged to a non-root cgroup as sock in memory.stat.
> +
> +	Since per-protocol limits such as /proc/sys/net/ipv4/tcp_mem and
> +	/proc/sys/net/ipv4/udp_mem are global, memory allocation for socket
> +	buffers may fail even when the cgroup has available memory.
> +
> +	Sockets created with socket_isolated set to 1 are no longer subject
> +	to these global protocol limits.

What happens when it's changed during lifetime of cgroup?

Thanks,
Michal

--wvv7vwafoorhn7v5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaItx+AAKCRB+PQLnlNv4
CKBoAQCcPd3B8EVlIuJkCxAatf+KBj5iSIWjGLHkL/wZBSIiOAD/Td1vVJkjNLj+
ooVS07G9ZINI6535eRR8nUFbbc4lGwI=
=8P5/
-----END PGP SIGNATURE-----

--wvv7vwafoorhn7v5--

