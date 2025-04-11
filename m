Return-Path: <cgroups+bounces-7471-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B885A863D1
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 18:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8CF16A8FC
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 16:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450E621CC7D;
	Fri, 11 Apr 2025 16:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EZNd6p8i"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0259021CC5D
	for <cgroups@vger.kernel.org>; Fri, 11 Apr 2025 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744390675; cv=none; b=Q97MquMWFYHRY81OrfMKIJ9mtfn8mSg0ZLhcn2+1vmlQBC6GZh62wIerNy9Mgp5IsvawpH1hPJ6smTxGPrqXsL30hawSyTxqKlRRt2wZ+lXyw9DWEtmm7wu2hpJtEjXBPjvpbwAAN6/srt7MJvX/w+R8V+kuL/GfuQoG5GQwsIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744390675; c=relaxed/simple;
	bh=v331HTWEjWrY75FzM9Glh5DbMe5VAachmJixsMGV098=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNhll89nXZtH6a6W1l2mvkurKNieJJhWewIBz0BvTD97wOe779XBlb3E+nJy6BEmORyWJFJ8aNbYWjhKt14P2LQYSzZs4AfxkYCC0ivIWetDZTaOMw91vj28+jOdduWtWYXQSQwlRvgs1cEEFcOkPAB4Lr/M64j79In3mv/95Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EZNd6p8i; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-399737f4fa4so1200012f8f.0
        for <cgroups@vger.kernel.org>; Fri, 11 Apr 2025 09:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744390671; x=1744995471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=04xvq7rYUEoUgFpD/ewNZ0HJkNgz6MW/nJUoaxZ4pGA=;
        b=EZNd6p8ieeiPLQ+M9YyeVn1RY7HGp5JijdKg2RijEqnP+hWVn/eMi5DADQXASB6Wfz
         e0Kdv7KKY4NgE92PPLQLr1v2axGRReIKJmax+y9eB2w4mGtFEKbpmgd2OH+zA+whnK7r
         5l0pa4BvCCPTa0OxqjaW6fb1eMOxuioY2ehV7fVGL9FJv1qrQ9LK0aWFLT80LOEwg0nU
         16ob/riWyuNilQB5Rhpg+RKWgCiaK2j2n1KeXNXqLOsfwPqm6NIKIk44ixrCZ0DcTfGX
         yPqCdB/r8aAB6exevRBZuM1MUSRYBoOEh9v6wvZAqMZUZ85GvX599xQvHZp5DfLm+ls+
         Bjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744390671; x=1744995471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04xvq7rYUEoUgFpD/ewNZ0HJkNgz6MW/nJUoaxZ4pGA=;
        b=JSD34R+u8hd9NofHqpsZCtQn5foaOtBEarWF06RN8Nq+bbIihvN2EIy/2hWrgAHHdf
         nq2GoF2WMwsqq21iKBffwYol4FxhJHEhBKDb9qEcqvV9YPfT5/DPYP/rhs2AUjCGqXyS
         4Xm5aMqZfhe51W0usLM28DG+ofqP4ch9g5dR/LdZ5SVSltmqMX2CNkuIM5FbzbJ+Sbgx
         YwfdVYEdXU1XQQxBo1F/7wvGr8ygfJbzbGcdj9aOZH8XemIwwM/CuFtXJSuxBThTDy4a
         fxzD/fvdU1WVcADk/NRlQs5V1qVju+vbYol9OusYhsfQ769SiIB7/Q1CReeBcuMrcVpG
         y0dA==
X-Forwarded-Encrypted: i=1; AJvYcCWKRdyduKGbvcpMtbeeAzFqNvzxYmzamMsUf1rSmltJsFUVjTBVdDvbqDLVewv/qH/crEgmnUJR@vger.kernel.org
X-Gm-Message-State: AOJu0YxmtPySbzm31rMvqORtzBj5pUScc+wSXnmvEVpfzMZBv4ZaSQ2K
	pf4gFa/8nfrRN2yrmX0tjaP7QkkikasIn7KEY3BBUp1n6tKcjL/Gd5xpzmkAaWg=
X-Gm-Gg: ASbGnctUvxfB6ufZiRt9pQdWcwpwT71zgRJj6q6PihFlYYafCogISc+j7teGf0I39Rv
	1F498B8WhHOzIH/aWyO3p1at4Rsq8qSiU3ivBarPLQns4H+vqM78U7TvUIPdH65/Wkrb7NvpUjO
	PuwJDFoyYWwkWDiMiLwfgikkmtveB1ueZYZC+HFl5F3/QSM3p6CL+b0ruttbythmucbzGUraLHb
	XGUvnvAxC3EQqHRe+05lFDTunN2arM0+lozDPDa5rkyEuhXWtfJphmjNiiLmV22wz/VCbakzJ2n
	nyC+zo9EHv6zReSGbKdXvN/RIjtXNouxuBAFhzKQPfw=
X-Google-Smtp-Source: AGHT+IErI8KPwmdEuvWBk3FlgHVGYN+RcWvJM0a6rOwTi5daYDu+ij9vivNIziwzw8Zo71ai7Dk1fg==
X-Received: by 2002:a05:6000:1a8a:b0:39a:d20b:5c14 with SMTP id ffacd0b85a97d-39eaaed2122mr3057697f8f.36.1744390671095;
        Fri, 11 Apr 2025 09:57:51 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf445315sm2533527f8f.82.2025.04.11.09.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 09:57:50 -0700 (PDT)
Date: Fri, 11 Apr 2025 18:57:48 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: jingxiang zeng <jingxiangzeng.cas@gmail.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Jingxiang Zeng <linuszeng@tencent.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, mhocko@kernel.org, 
	muchun.song@linux.dev, kasong@tencent.com
Subject: Re: [External] Re: [RFC 2/5] memcontrol: add boot option to enable
 memsw account on dfl
Message-ID: <qfxzzbcfnojz3oz2ackzorwokhmr2dbkxfgbmewd74vtzrzxkh@rlqide3wg2v7>
References: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
 <20250319064148.774406-3-jingxiangzeng.cas@gmail.com>
 <m35wwnetfubjrgcikiia7aurhd4hkcguwqywjamxm4xnaximt7@cnscqcgwh4da>
 <7ia4tt7ovekj.fsf@castle.c.googlers.com>
 <20250320142846.GG1876369@cmpxchg.org>
 <ipskzxjtm656f5srrp42uxemh5e4jdwzsyj2isqlldfaokiyoo@ly4gfvldjc2p>
 <4lygax4lgpkkmtmpxif6psl7broial2h74lel37faelc3dlsx3@s56hfvqiazgc>
 <CACSyD1NisD-ZggRz0BaxUdJ9so4j-sKPZi361HJAum3+bHO+tQ@mail.gmail.com>
 <CAJqJ8ihLfcDROuCjMfoNzOtRRZhVDWEx04ik6cS9NO6hVua0xA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kvvrqpgkexpz34pw"
Content-Disposition: inline
In-Reply-To: <CAJqJ8ihLfcDROuCjMfoNzOtRRZhVDWEx04ik6cS9NO6hVua0xA@mail.gmail.com>


--kvvrqpgkexpz34pw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [External] Re: [RFC 2/5] memcontrol: add boot option to enable
 memsw account on dfl
MIME-Version: 1.0

On Thu, Apr 03, 2025 at 05:16:45PM +0800, jingxiang zeng <jingxiangzeng.cas=
@gmail.com> wrote:
> > We encountered an issue, which is also a real use case. With memory off=
loading,
> > we can move some cold pages to swap. Suppose an application=E2=80=99s p=
eak memory
> > usage at certain times is 10GB, while at other times, it exists in a
> > combination of
> > memory and swap. If we set limits on memory or swap separately, it woul=
d lack
> > flexibility=E2=80=94sometimes it needs 1GB memory + 9GB swap, sometimes=
 5GB
> > memory + 5GB swap, or even 10GB memory + 0GB swap. Therefore, we strong=
ly
> > hope to use the mem+swap charging method in cgroupv2

App's peak need determines memory.max=3D10G.
The apparent flexibility is dependency on how much competitors the app
has. It can run 5GB memory + 5GB swap with some competition or 1GB
memory + 9 GB with different competition (more memory demanding).
If you want to prevent faulty app to eating up all of swap for itself
(like it's possible with memsw), you may define some memory.swap.max.
(There's no unique correspondence between this and original memsw value
since the cost of mem<->swap is variable.)


> Yes, in the container scenario, if swap is enabled on the server and
> the customer's container requires 10GB of memory, we only need to set
> memory.memsw.limit_in_bytes=3D10GB, and the kernel can automatically
> swap out part of the business container's memory to swap according to
> the server's memory pressure, and it can be fully guaranteed that the
> customer's container will not use more memory because swap is enabled
> on the server.

This made me consider various causes of the pressure:

- global pressure
  - it doesn't change memcg's total consuption (memsw.usage=3Dconst)
  - memsw limit does nothing
- self-memcg pressure
  - new allocations against own limit and memsw.usage hits memsw.limit
  - memsw.limit prevents new allocations that would extend swap
  - achievable with memory.swap.max=3D0
- ancestral pressure=20
  - when sibling needs to allocate but limit is on ancestor
  - similar to global pressure (memsw.usage=3Dconst), self memsw.limit
    does nothing

- or there is no outer pressure but you want to prevent new allocations
  when something has been swapped out already
  - swapped out amount is a debt
    - memsw.limit behavior is suboptimal until the debt needs to be
      repaid
      - repay is when someone else needs the swap space

The above is a free flow of thoughts but I'd condense such conversions:
- memory.max :=3D memory.memsw.limit_in_bytes
- memory.swap.max :=3D anything between 0 and memory.memsw.limit_in_bytes

Did I fail to capture some mode where memsw limits were superior?

Thanks,
Michal

--kvvrqpgkexpz34pw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ/lKCgAKCRAt3Wney77B
Sd4XAQD1bRQA6yZDQoj/MJ+ik5mlhJTIQdWWOLsLZzeI3md67QD/V43upzY0A00m
MglkEUF7IOFMdyMrZOaQ5CzGBLohuwE=
=g4em
-----END PGP SIGNATURE-----

--kvvrqpgkexpz34pw--

