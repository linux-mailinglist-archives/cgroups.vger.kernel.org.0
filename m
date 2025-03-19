Return-Path: <cgroups+bounces-7150-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC1FA68958
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 11:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A933BB807
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 10:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB1B253B69;
	Wed, 19 Mar 2025 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HYcPHMJS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865802512F5
	for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742379632; cv=none; b=sWKlazj3RBPOTXA6WHaRuhZTcNNr07MjTLEfWT/7va8rSD+o8slwaC0ZaPGiXUvXkrNOF4mNP8M/E2YN92I5tijS8P0InQa9cUVgtt6X+GKYQn0gx4eRJ6DLXYuqkO5FPA6v4Ska/7UE+YKQIruZA7kVIwqMplLxwTwv4mx1dZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742379632; c=relaxed/simple;
	bh=5uC/PftdPErtzjo8S3rNKeyr0qcS9CE4mc75WRiF7r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqAZ0s1gnhuiMQlRokvbFALhD5GwzdSQOLU++WtVUXCfCfXdKRXaBJqQNkliMU7ZWWDVaQVfo2PUZXsP0fc4ZQnfmAUs1JVpyVuvvLmTmP07xT4bZ45me65dxLzAjz/8BOHeWLkAFNCnweflk2cjK+vpdMyacHKaoplHIvlY7ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HYcPHMJS; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so30374065e9.0
        for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 03:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742379629; x=1742984429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uRvazjyez6/I61YAL9k58Mn3QJZtFdatNwV/fP1ktrc=;
        b=HYcPHMJSoLI6GdVIljriLHlFcgrUmFkXfeWysygUgyKHK+bqMC8/Hse7EzEPTESFh+
         EGZkAMYawMx2/oPen8pp/MJ65U9Zgf6v2FnGK9P7peeYPO4k3rTj0nBYukebdRzi2JZP
         6j4Z8N9ES3pxH18fLUyWmX0EPYzkFHpPQaCUqpcr2LzS/Txhn5TYmJSsvCiD10+TyXik
         5l6H1hSyNLAt1tfGGuj+6aTTJ76COFNC/W0cEAIEmhD0B1CVyXRFIDq98pP5Uu8jCpqZ
         2A+yYpLk1e1zbeaZBvtfMdyfyYk60YiBKYh5YidIQKpRcFk8+CiEamMoSA/WYQrW/xvC
         mt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742379629; x=1742984429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRvazjyez6/I61YAL9k58Mn3QJZtFdatNwV/fP1ktrc=;
        b=ern+KYBGr1i+VpOn4imVgYFjyyzhphTMjngqHBz/aTjpuwvwwVI7QiDmi8GJ9rOpbw
         F6c50UIH1g2rgZL5uHpGmdOF1wBY+uiTFvpAqdT22A1h7B4N+GxJcDBpOoKpwC3wiBSC
         hxXUUjR+QvVAElWAwL9F8imV0iHYsosQSeaj00tMifjxzI5sDlRtpOTovR/yYpErTrY0
         EGQ9AqjVTiYiE8/05+ZbxfaXhkLXZCdY9kuDuCNdetfp5GMrDqY7wyGy43GuHVmzmZqJ
         e1m+iNksT07xoHj0KJ+UrEpJ9DKsBg82P6cLlSDXXNliDJgTSFWEnZhkEh+qoJMl2jyb
         amWw==
X-Forwarded-Encrypted: i=1; AJvYcCW2lzaey5nAQPCt1A4f/lqAUkkHsB/EclMA9RvZ3l4pb75GIijUV7M6mKccjL5eKx8P/nLX8Tu9@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwjuy6CF9/6SdAFdTmhiJzMU4ZK2NnHjQClZjidzMfO8H3BJZN
	lGFnaDsh1LBkzGodqRVw0IeDfh07IXf6QXFuKzO82IIXXW56b1Pk9+cK0yGvuzxEUqugzHwIvuT
	igm1k5A==
X-Gm-Gg: ASbGncsI8QkIyFWPZ+c1UllZT4qiQapPdFjdhzi+mbxMC9XFJ3B+HU4xnT+5uGkcSFP
	iBLmyHwzsKLtXU8k/g5CnEULl7lU/LutXJvH6QoI9pdoXoMKnrP3pNX2QwSNe9Q5M1j+uOwEFTk
	GwoMspJ1TIZKSxoetPRJpnauEInHfMAq5dYARnqvsZrVrF9T8Y9Kr8n2ziJwefwqicnuOyITIYU
	mAEgDATiyz/Kvsb4taDtOIpGG9CO54R6L7iBvRj4E3vNf5LIIhWxwkTl/oJ0HwOCjpVxkJfhnZ4
	TJ9QSuJlKF1mSu/0HIiUYQ9R5TvcNaciRzi90hYtO5rJviY=
X-Google-Smtp-Source: AGHT+IFBijxngWJfWSrP0zxUR6KISoDK4M2HLz3EcfSwARMIp08CatCGZSMDqGgpT9PyUr4yPKbGrA==
X-Received: by 2002:a05:600c:35cd:b0:43c:ec28:d301 with SMTP id 5b1f17b1804b1-43d4388dafamr10717475e9.26.1742379628671;
        Wed, 19 Mar 2025 03:20:28 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440ed4b8sm14200965e9.35.2025.03.19.03.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 03:20:28 -0700 (PDT)
Date: Wed, 19 Mar 2025 11:20:26 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Greg Thelen <gthelen@google.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
Message-ID: <mvpuegbh5gttbflarqua5wa7ar42zy5d6hxqf7me6nxwk7yibm@bxwxkt4h5fx5>
References: <20250319071330.898763-1-gthelen@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="weublld6gas2cn5l"
Content-Disposition: inline
In-Reply-To: <20250319071330.898763-1-gthelen@google.com>


--weublld6gas2cn5l
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
MIME-Version: 1.0

Hello.

On Wed, Mar 19, 2025 at 12:13:30AM -0700, Greg Thelen <gthelen@google.com> =
wrote:
> cgroup_rstat_flush_locked() grabs the irq safe cgroup_rstat_lock while
> iterating all possible cpus. It only drops the lock if there is
> scheduler or spin lock contention. If neither, then interrupts can be
> disabled for a long time. On large machines this can disable interrupts
> for a long enough time to drop network packets. On 400+ CPU machines
> I've seen interrupt disabled for over 40 msec.

This is peanuts, watchdog_thresh defaults to 10000 msec.
(Tongue-in-cheek, to put that threshold into relation but I see the
problem.)


> The mode of memory.stat access latency after grouping by of 2 buckets:
                                                        power

> - without memory hogs: 64 usec =3D> 16 usec
> -    with memory hogs: 64 usec =3D>  8 usec
> The memory.stat latency improves.
>=20
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Greg Thelen <gthelen@google.com>
> Tested-by: Greg Thelen <gthelen@google.com>
> ---
>  kernel/cgroup/rstat.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

FTR, the lock may end up split per-subsys [1] but this would still make
sense for memcg's one. (I wonder if Tejun would consider it small enough
then to avoid interrupt disabling. Then this could be converted to more
widely used cond_resched_lock().)

[1] https://lore.kernel.org/r/20250227215543.49928-4-inwardvessel@gmail.com/

But all in all, thanks for this and

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

--weublld6gas2cn5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ9qaaAAKCRAt3Wney77B
SeofAQCRBDvo/r6sHgvgLjU9LafT+QwyWR/yByxGtg27ZjHPYwEAu/8pNOj+gJs7
sHE/DC6ID2Jh43yFSkVu8Y00gr+HxQg=
=qq/w
-----END PGP SIGNATURE-----

--weublld6gas2cn5l--

