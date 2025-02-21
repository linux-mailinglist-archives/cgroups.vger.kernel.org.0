Return-Path: <cgroups+bounces-6637-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BB9A3F91B
	for <lists+cgroups@lfdr.de>; Fri, 21 Feb 2025 16:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF85A7AB698
	for <lists+cgroups@lfdr.de>; Fri, 21 Feb 2025 15:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA691D5CCC;
	Fri, 21 Feb 2025 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XecPJcC+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A398632E
	for <cgroups@vger.kernel.org>; Fri, 21 Feb 2025 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152480; cv=none; b=ScRVM6fxGDYRY28EsauOTE+5oRn6boG8pG/cF6cObT8puZt2XDy20z0Co4n9Z7MmD648PfKqTt+2MjKqmHjgcUkmYzH0K1SwV945TRgkkOiGh1/TVwIv+WSa9hzXHow/W4orzxWk+/ihzjM0DEgGwdBhejoco2VG6ZKllUsPNjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152480; c=relaxed/simple;
	bh=FYE/XaLSpZzHV3UAYCqEEhw0Z6Xwh3vFV1VBGMVXrqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHXmoFD9NXofR5gtR6JnB3ib1+yfff5pNoxLq3zjyMgX4NQBSZBh0BI52ya9KIWCkD1TOnrnxRT2vPvNcFGofLCW1XqcO28DoN2PuGs2l2bHaBOzJRTtpTeC6Z7R4/KnGRQfLF+QgXxBZq9zWHMBEWSsCzoomvhbi7kzdX0zM68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XecPJcC+; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5deb1266031so4153513a12.2
        for <cgroups@vger.kernel.org>; Fri, 21 Feb 2025 07:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740152477; x=1740757277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NpwjCzv4LKgUYN/jIekCLcNNtxWtAtGntsZBcDkghxc=;
        b=XecPJcC+zb5WpCO6eSYfW/X6QMOACZzCzDv8Oag7tgmH+fbk85WYqd7T+NvrE1pkRv
         bcgl8JhTtyPlNGBTqC5E+K6jfP+wcgvy6wjBlsGAm2FJQtY4elDuUrl1qV+MEpInVELb
         M5rjyxhAvD4DMm16IsIuENKxyt2HjOFWxOrVQtTFqJP0ilqrIlF3HHOaP1xUMKrAchHK
         7/0+Hq793/2jL8TzT+5113/dZwNBdX/9TvioWLHFbiVlFkaV0MEkkAcdZQ9BqROEJUzt
         cPatO9envdcw9Y3GO0MTYTk+1LKQB+9VcLwpdOcuN62yzf8yZIxQAXmcC5gMjQw+a5MK
         N9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740152477; x=1740757277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpwjCzv4LKgUYN/jIekCLcNNtxWtAtGntsZBcDkghxc=;
        b=iUFxjR31YJk//xmRggBn65WQaHm6NDHwPAt3WjGFb0FfXm13LnJpi0undegMEzC2ma
         UiR26AKHH1KgoLdZumStf48PQPoRZSE0AQUZkK+BikdlewYuN8k0cgww/jAhP8OlJzgB
         xoLonY+cKUNYwcnZV1hl5z7yLAQQjuMgtktlFJqD4bSoYpQnxG+IUxAuxv4XV5TyczTz
         3Nzga04gKTa7ooEHRjGy/4NPXWGZ3A0+M9W0yUoFgLE5Q/0cn6opiWGwNcehdRrdTGMV
         QcHUUiGEYcgBFTqAbd6/MxgsM7gN7l+RFkq/SY0d3WRuUycuF/sazyahrpFZPvRDby1d
         ICRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDwf6Twad+vD9CJInyDOdJKaPE0EFhDPXL9baeGMcypPqXg3bcBOutGo3av5T8cXcetEg4yT/T@vger.kernel.org
X-Gm-Message-State: AOJu0Yww/kzp6Bu+DiMD2265ZBoaJYlR6RnhO33LMhvbpkWc0ImN1gG1
	ntPaWEgoj2zGKUnTQIHux5nZG6Hmk8Bqk3Lbk5Ba4Kf9ATJjJpx3PuFPibjFm54=
X-Gm-Gg: ASbGnct9XsL5X496qDqIm87j0ln5s1AjTFp0XpzgMnf5/KF+7+69la6xHkQ2eqL6WCi
	wjgv9EnJ7o5sE1OwS8ivs77bbpfbZmg0CpWWn8wSER7u3/s1cRsf44fOJSYWy8qpndJ3PEFqbNs
	ROnQEZ5Ejynpo4lq/xdIEAp02Bur5MVZbU1IJa0sJlnNGD7EMSOUB4l637pAbYonP9reQxiqdyQ
	iPGjsw3xdfIkreCtfOx5CRX88HEgngOfTLLkWpX9GOB/TQQpTVi5AlAcRUmOUnv8mWv8Hnjkqo3
	Yk9wI7kKTjB7sSmhfT3dDTats9Ib
X-Google-Smtp-Source: AGHT+IFoGQzBBs1QEqa8a+/ZOxTGf25HGli0bYTE/TaoWJzEs883/D07QzveegE43BogfPX1KTlIwQ==
X-Received: by 2002:a05:6402:440b:b0:5e0:52df:d569 with SMTP id 4fb4d7f45d1cf-5e0b7252db5mr3912491a12.28.1740152477187;
        Fri, 21 Feb 2025 07:41:17 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece28808fsm13714461a12.75.2025.02.21.07.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:41:16 -0800 (PST)
Date: Fri, 21 Feb 2025 16:41:15 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Yury Norov <yury.norov@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Bitao Hu <yaoma@linux.alibaba.com>, Chen Ridong <chenridong@huawei.com>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/2] Fix and extend cpu.stat
Message-ID: <puq53yk7guef3itr4d2uq5ka2m6cdbdflzzdumuvs2giyefwns@2e5ynejmu5ht>
References: <20250209061322.15260-1-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="boga3dtsvv5zrl6a"
Content-Disposition: inline
In-Reply-To: <20250209061322.15260-1-wuyun.abel@bytedance.com>


--boga3dtsvv5zrl6a
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 0/2] Fix and extend cpu.stat
MIME-Version: 1.0

On Sun, Feb 09, 2025 at 02:13:10PM +0800, Abel Wu <wuyun.abel@bytedance.com=
> wrote:
> v4:
>  - Fixed a Kconfig dependency issue. (0day robot)
> v3:
>  - Dropped the cleanup patch. (Tejun)
>  - Modified 2nd patch's commit log.

But the modification isn't the usage examples that Johannes asked about?

Also as I'm unsure about some plain PSI values (posted to v2). Maybe
it'd be good if you could accompany the =CE=A3run_delay with some examples
showing what different values tell about workload.

Thanks,
Michal

--boga3dtsvv5zrl6a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ7iemAAKCRAt3Wney77B
SQo1AP9KEg+rebuhZQwOkT+QXD/la48d+6E5IDI2HbAlGtlVywD9FON965afUo4W
D9fw5Iux3ogkW0/9rAgcYZnW1dVUCgA=
=OUDn
-----END PGP SIGNATURE-----

--boga3dtsvv5zrl6a--

