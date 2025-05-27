Return-Path: <cgroups+bounces-8357-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FD2AC522B
	for <lists+cgroups@lfdr.de>; Tue, 27 May 2025 17:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C462E1BA37A3
	for <lists+cgroups@lfdr.de>; Tue, 27 May 2025 15:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FD027A91F;
	Tue, 27 May 2025 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YTwNWcci"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C22B27E7D9
	for <cgroups@vger.kernel.org>; Tue, 27 May 2025 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748360041; cv=none; b=uzMw3qnawdt6T+gOKPFOOlTSFFZjkh9mG5QgguE9ZFs3uHYWVpG4YQYIKT1jOr/SydSznt6NvoUHUeYK9zzXLWkLyuB/9bdN3eUitEU4od0J7uGI9+tGeakdl0Om2CTW3nObBX6lWg6+fAmtuBAMi3lb+9h0uG3V4bSshV0B9m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748360041; c=relaxed/simple;
	bh=Cv1Vo2DmzQ6FqHtwxc0u/gsIoHSEVlJATjuABAdLw0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9YQoNfzYwqAIY8z6Kq6UslqwbfMR3ZSAaqqu+V6q3ekXG/K1+BXDb7pCiL06rU1LZgzceetYgdFHR368vIt7XhnJ8i/o8/8bVYhSAWoELtwEeTXkn9AAKJIQwaSpgtjz/PSL5LyXL99p5bah2FjgbGocroTIbqz1WB857+IO7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YTwNWcci; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3a365a6804eso2218151f8f.3
        for <cgroups@vger.kernel.org>; Tue, 27 May 2025 08:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748360038; x=1748964838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cv1Vo2DmzQ6FqHtwxc0u/gsIoHSEVlJATjuABAdLw0g=;
        b=YTwNWccig6MA2gBV+mMYoRPekwrf1MsNmHQj7BAWsk4mxY/aFYnlhzaklG+DSGAHs6
         X1bPqErVwKNtvIe/8KERHpBa1qn+JlCodBwOSscH/510UGgxJbOwRw+972G2iQxGGqzg
         l7Vw3yDW0JIF+MV/mTuGHYprB7ROuD9rzBwaC0+E5HIj8nlpfuTArfSDtz3ii4F0qWuW
         Drt+/qTV/X1Frbpk1NWjD4pFzVI3A4yF4b32AoUGQXc1+lwQvP3xdYmObRmnp9rc3lmQ
         e9RJZNi8qtEnxXgC1tD6oGRsh5CP+WQrIZRQyvG07i/sSxrbzApvn6uMI8vNKBAbEQix
         7w3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748360038; x=1748964838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cv1Vo2DmzQ6FqHtwxc0u/gsIoHSEVlJATjuABAdLw0g=;
        b=Onm3UCaU8mWzT0q9sTdf+0AvzxntHSJvOAnOlrXP0RkXbj1IWC0y9X4EEv6a4ck+Im
         9PA1la/7tWk9BgyKKO3sMHIgE05di2Eo0olBePbs05KhR5mdbE4hj0gDWV++bVA8Ze8u
         oYV9Oph82O5+dAOA9ctYhuxoVv2rYeAnwZBLmcC1ge2Cm24e4DwjjQxBI0djnayQtCOw
         69N0KC40ZA4shlEsKr0zCpJfb3ajVZKnJAc1g153/ajwURVPFZt/bVeigueZsbikbLZo
         66VclQHHP19jNZJN9yJ+FKIHJwgRyteG5gV88SX6bZ1Y3PkOie8ajCXIvSkcN6gWTSoe
         7Rng==
X-Forwarded-Encrypted: i=1; AJvYcCUixUaOGs6oChfevhHL7cOB8LRu5nvuBqeJrDzvVgCP4CVtJj3+/fvrLVyReXw9M1fz/e8smzD2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3LaovRo3rgJo4oDx4QMG6Unw5Kh7K16yLLCUVsodj7kRkSFfN
	YTlh5lpqRcHBSf8N4cCsgoTPb2cHcXAtBI8QI5zVMS+ksOL0ZAXdL/wXFkVP/34g1Oo=
X-Gm-Gg: ASbGncvnCYmy3D20QPFQ3bEuV+kvI+6f2BcQ+C1kpwA828Gs0POit+Sh+1Zu1vo0rlt
	9fFMDbOGJkqjvLrgWJ09AqMuaIq18iImKiVsSU6kZSCvmLDNoBSno5A95xA6AB0Wr3FQKt8So62
	dxVCCmDMTjgB7FrGsHd3DQvyl1qtZnQro6DJtoF+8i9P6GyKxlF4i8VbpY14C6CO2wWVZyy3tFk
	/SPzHk89gAgegS08nUVF6d8hm8MGiQqbzD1EMPxsh+19bBWcrtlCr1nJQCLwvOCs+gUqNNyTkT0
	FvXDRel4LkkcAzmDjmRUh3T6bg4iPI0pS4YOATUYeK0UVHvLsFs2mA==
X-Google-Smtp-Source: AGHT+IGk2qNk54noCscUr24iAodxJKN/7cT22Vh7jDH5UNWtoxDLDUp8G3Mzk08IM6dkmwqbyJXyKA==
X-Received: by 2002:a05:6000:11c5:b0:3a4:cfd7:dd4d with SMTP id ffacd0b85a97d-3a4cfd7deabmr8137691f8f.34.1748360037610;
        Tue, 27 May 2025 08:33:57 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d67795eesm7332405f8f.86.2025.05.27.08.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 08:33:57 -0700 (PDT)
Date: Tue, 27 May 2025 17:33:55 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, hannes@cmpxchg.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	surenb@google.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	lkp@intel.com, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v9 2/2] sched: Annotate sched_clock_irqtime with
 __read_mostly
Message-ID: <umy4kicwvlsaszajo62pcpgptcdqi2yp7pponvlch5h6tirabb@mhhq2en3piel>
References: <20250511030800.1900-1-laoar.shao@gmail.com>
 <20250511030800.1900-3-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6dxp2iqhjfg66h5e"
Content-Disposition: inline
In-Reply-To: <20250511030800.1900-3-laoar.shao@gmail.com>


--6dxp2iqhjfg66h5e
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 2/2] sched: Annotate sched_clock_irqtime with
 __read_mostly
MIME-Version: 1.0

On Sun, May 11, 2025 at 11:08:00AM +0800, Yafang Shao <laoar.shao@gmail.com=
> wrote:
> Eric reported an issue [0] as follows,
> : rebalance_domains() can attempt to change sched_balance_running
> : more than 350,000 times per second on our servers.
>=20
> : If sched_clock_irqtime and sched_balance_running share the
> : same cache line, we see a very high cost on hosts with 480 threads
> : dealing with many interrupts.

I'd say this patch could be independent from the "series".

> While the rebalance_domains() issue has been resolved [1], we should
> proactively annotate sched_clock_irqtime with __read_mostly to prevent
> potential cacheline false sharing. This optimization is particularly
> justified since sched_clock_irqtime is only modified during TSC instabili=
ty
> events.
>=20
> Link: https://lore.kernel.org/all/20250423174634.3009657-1-edumazet@googl=
e.com/ [0]
> Link: https://lore.kernel.org/all/20250416035823.1846307-1-tim.c.chen@lin=
ux.intel.com/ [1]
>=20
> Reported-by: Eric Dumazet <edumazet@google.com>
> Debugged-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Eric Dumazet <edumazet@google.com>

I can say
Reviewed-by: Michal Koutn=C3=BD <mkoutny@suse.com>

but it'd be good to have also Tested-by: wrt the cache traffic
reduction.

0.02=E2=82=AC,
Michal

--6dxp2iqhjfg66h5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaDXbYAAKCRAt3Wney77B
SYk8AQDxDQZu9Uq0G7hrTUBP5punGWKQ/PIZHEkHzu6U4BtnuQEAkhyUQFGbgI+F
dQmTzezgKzsQ4prNcbWJpgimSB4ygAo=
=CNdf
-----END PGP SIGNATURE-----

--6dxp2iqhjfg66h5e--

