Return-Path: <cgroups+bounces-8014-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B09BAA9B88
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 20:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5E718951C8
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 18:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867E626B949;
	Mon,  5 May 2025 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YmF0b+ix"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4332561A6
	for <cgroups@vger.kernel.org>; Mon,  5 May 2025 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746469773; cv=none; b=pglnKz+qSkGCMqrnkOAl8FPGoSt6l2CsmiuOgyODnqsc1Ds3cDldg+MqeynavPP+4bLpxtQ33pk6EnUFeN2yKRmMeeD7njme0/7++MC/n9HI//eL/Mo1ZfFrUBas8LKoYMMzYS6jfHixjwvXIttBJlQjDJRSapzI9GkMaPMi16k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746469773; c=relaxed/simple;
	bh=lPCYSBZtLDj85i4BVegSGg0sp3VhVAkWTVDJeS+W7fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSB+R/X2H8YZ/2opjbjH4ivH3Trwm35SvDVLZ4lWiurFN+vtekE5eZ9blKpEtltlw3XnVGroz1coQonaHBG2E1YShhbwIdm1EqKwTPAcPr13Y/8czw3o4nuhsYjuu8LYkFc2vLNMlKxiLXU8pvh+7e6vQLMVKdfIjGXuCz+IpRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YmF0b+ix; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5f7ec0e4978so3884129a12.1
        for <cgroups@vger.kernel.org>; Mon, 05 May 2025 11:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746469769; x=1747074569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lPCYSBZtLDj85i4BVegSGg0sp3VhVAkWTVDJeS+W7fs=;
        b=YmF0b+ixWcArheH2zt88I/CO0bvTFsd/l3bdhIpvBLoeFo26E237dUguCZr9pJeDYl
         hBDDzYt5sypfbENj5lVFpXeOpPw4fjrV+FW6ATt8tJdyq62Fex3MyATTGGmViintcWYa
         u4YgmLanTWKo8E1C1hkvsKlYHjFibQA+jXLcZ20JaaRVhD1z2FfZPfxSr1+h3g52lPlx
         WmvNcjtwf0/9AJzRbfIPtEyeXfeUphFxVSzmcNdsgkQ1ooyiRBj9MY1mhnW8IOGI/2k/
         LclsNKAMuEx8yB0Nf/47YTalW66+cf+cGlp8Z6i9KbqFOv0Z7/cFA1qWD7tqAPxT9pXe
         sp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746469769; x=1747074569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPCYSBZtLDj85i4BVegSGg0sp3VhVAkWTVDJeS+W7fs=;
        b=pzCyScOCRtodGAuE+WivwgVB8fGoSquQeF4cPm4S8zlE3Esm2tzzsbwZ0FdzC6ZGjw
         tfhfIrHwFsX0tF0vTTMDOsTdtdnC0jtrnZFiS0SbkhKu5I0hcc+4XhpOg/NaDd6f+e+k
         7hmIatvISWZ5aTSOGhq9XIPX825DDUe5oZeboXT5eX8E9INVzrLzhOyuyPseXuYnhy1r
         rn8Mmcq3OOIdhydrwZd4FuvdPPxMfxdNtOMaxoQcKJTdCjciAGNYjEMhqWXFy3oxOQMu
         TJtzwaJNVoARyMelU4XxMBblbQKhvHNA8EUg1E9VtDM2h1wUQYE6YEfPQ5UHUGryq2Js
         nz8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzc94Hgm2bjRLMd/frVe93CVOZ7QmGp0sTFs2+wpqxo5SWc2nn2ayvjYwHkrBNEgdu5EIHqlv7@vger.kernel.org
X-Gm-Message-State: AOJu0YzJWJ1OMbQFr0bfWGcyw6TeVpEUIuDBDHAzf7c7F3H9po8IaXDL
	j4IPOjnUdUK+aW29bCGmacVpgFdW6DQIhOuxmXXSUIfU0Er2njN92+1dQA0wZ78=
X-Gm-Gg: ASbGncu/SRvQ0SqdTO5awmRbwcdSB++bc12+u4p5TyikTO/5ayIgqjgKDMHsr1AeOpY
	WASDMG0kN0StZgTXScDHOxX8J6pCdeS3Decyd7aNkM9i/Tk264xvyRn7waeCkpAekg3i5XeXWel
	IdMCRz/6yDkAuCEoxVUhYGx7sP5PaWtbouaI+oHInO5CNxn3ELfh+5nlfZcNE+cDGo2xbQbKtlX
	aUTBmKMBNctGOeg3pK1luSjkwwX7iHY2SzV0cCvUSXBe80IWBvy/Ayt51WmCmEGTkGYCPwh/XJp
	Wf3x441jeoA0jdB/oM4YSOWxUVT/SQwVB4Ztmldvp4c=
X-Google-Smtp-Source: AGHT+IH1DMGrjvMR0iZ2kuzL6k++Y5DftjWP+Z5kCnC6eOxBBJC6ew/wnz0RL27A2XSzdtPcIRI89Q==
X-Received: by 2002:a05:6402:84d:b0:5fb:2041:6bd2 with SMTP id 4fb4d7f45d1cf-5fb700a2dd3mr57272a12.16.1746469769372;
        Mon, 05 May 2025 11:29:29 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa777561d3sm5960382a12.16.2025.05.05.11.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 11:29:28 -0700 (PDT)
Date: Mon, 5 May 2025 20:29:27 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: jingxiang zeng <jingxiangzeng.cas@gmail.com>
Cc: Zhongkun He <hezhongkun.hzk@bytedance.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Jingxiang Zeng <linuszeng@tencent.com>, 
	akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mhocko@kernel.org, muchun.song@linux.dev, kasong@tencent.com
Subject: Re: [External] Re: [RFC 2/5] memcontrol: add boot option to enable
 memsw account on dfl
Message-ID: <qdqgmkj6tq7er7seav4oeb76m2fgydmn3k5pdybfkdoo4gjgsd@wce6kn6opn35>
References: <20250319064148.774406-3-jingxiangzeng.cas@gmail.com>
 <m35wwnetfubjrgcikiia7aurhd4hkcguwqywjamxm4xnaximt7@cnscqcgwh4da>
 <7ia4tt7ovekj.fsf@castle.c.googlers.com>
 <20250320142846.GG1876369@cmpxchg.org>
 <ipskzxjtm656f5srrp42uxemh5e4jdwzsyj2isqlldfaokiyoo@ly4gfvldjc2p>
 <4lygax4lgpkkmtmpxif6psl7broial2h74lel37faelc3dlsx3@s56hfvqiazgc>
 <CACSyD1NisD-ZggRz0BaxUdJ9so4j-sKPZi361HJAum3+bHO+tQ@mail.gmail.com>
 <CAJqJ8ihLfcDROuCjMfoNzOtRRZhVDWEx04ik6cS9NO6hVua0xA@mail.gmail.com>
 <qfxzzbcfnojz3oz2ackzorwokhmr2dbkxfgbmewd74vtzrzxkh@rlqide3wg2v7>
 <CAJqJ8iiyVQxf1Kg_UKuRM_Zg6u4Hqb=DwpbOH_7CrAscAonD-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="znhqjsuofvi4yhsq"
Content-Disposition: inline
In-Reply-To: <CAJqJ8iiyVQxf1Kg_UKuRM_Zg6u4Hqb=DwpbOH_7CrAscAonD-g@mail.gmail.com>


--znhqjsuofvi4yhsq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [External] Re: [RFC 2/5] memcontrol: add boot option to enable
 memsw account on dfl
MIME-Version: 1.0

(Excuse my long turnarounds, I assume this needs time.)

On Wed, Apr 16, 2025 at 04:29:13PM +0800, jingxiang zeng <jingxiangzeng.cas=
@gmail.com> wrote:
> ...
> In fact, the memsw counter is mainly effective in proactive memory offload
> scenarios.

Is that some downstream experience or aspiration? Because there's
no kernel where memsw and proactive reclaim coexist.

> It is difficult to set an accurate memory.swap.max value.
> memory.swap.current =3D [0GB, 9GB]
> memory.swap.max =3D ?

I likely don't understand, I'd consider the value of 10GB in this
case...

> The memory space saved by swapping out to swap can continue to load
> the operation of system components or more workloads.
> memory.limit_in_bytes =3D 10GB
> memory.usage_in_bytes =3D 9GB - [0GB, 9GB]
> memory.swap.current =3D [0GB, 9GB]
>=20
> The memory usage of memory.usage_in_bytes is reduced due to proactive
> offload to swap, which will cause additional problems, such as:
> 1. There may be some memory leaks or abnormal imported network traffic
> in the container, which may cause OOM to fail to trigger or be triggered =
late;
> 2. In the oversold scenario, if the container's memory requirement is 10G=
B,
> the container's memory+swap should only use 10GB.

=2E..which would mean per-container usage doesn't exceed 20GB (leaks
remain bound).
Apparently, you could fit less containers but would they be actually
running (memsw doesn't guarantee that). Or what is problematic with
different treatment of overcommit between memsw vs .max and .swap.max?

Regards,
Michal

--znhqjsuofvi4yhsq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaBkDhAAKCRAt3Wney77B
SWVfAQDEYCGUpihkrs6lrJZQ2l11z6zLSe1X6gTzGNkq07GeigEAoJvkjzmWE5cF
s7J0Vu9+y6QYMKBE9olMU3eHCOmQgQ8=
=hxPO
-----END PGP SIGNATURE-----

--znhqjsuofvi4yhsq--

