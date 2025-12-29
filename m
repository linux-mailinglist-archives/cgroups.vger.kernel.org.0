Return-Path: <cgroups+bounces-12799-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45929CE6688
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 11:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F9373006622
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 10:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F5C2367DC;
	Mon, 29 Dec 2025 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CS8ZqZGO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152524A0C
	for <cgroups@vger.kernel.org>; Mon, 29 Dec 2025 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767005578; cv=none; b=PUF+4zfnczOXwiwHoyb052ElWby8NsKFC8nCU0hYl7ypOG5Ml6YbOYGvqW7luM8JqZmYqQSE71+p5qmSEmJX4+fEy9oLXYPJyTHeZLufRW+LI1WhDx34KpyCLj0QGp9EYBocr6429uKz8YXvFqOiSDRHHW51INljs5gH+lVfQmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767005578; c=relaxed/simple;
	bh=5Py4gZ4XPY0Wbxx+6Pv8wxOfSLppBo+FLZadyZrV9Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qm+zSLlIcHSanFcbXry2ex+FmpjVSigVri4c7j+GVUcgrG+NtygqHmaW4/sEkuXQWzJ3Z6aXdwbhA4jjQusUKAvWjlaa9UvzTkZoQosxazmFVj6esfGwG1Q8vrKYThNHEgQvMoLoHyv1vue0fkCaZSC30+I6czWG+i0GrupYX7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CS8ZqZGO; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so94499925e9.2
        for <cgroups@vger.kernel.org>; Mon, 29 Dec 2025 02:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767005574; x=1767610374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2je2Qn3fetVLzu93alqgF/no2c7aUP4V2wy0jPtd70U=;
        b=CS8ZqZGOgWuTOwwraEhfb0asKDWUiX+5W7bvBGF60Pw3IVPUGnw+PKusHfYpjAc/DZ
         K7UhoRFMS6cTWn8fegze2Y+Oi1PgnDzqgIxsxUf8AXKjjpaXynWoLO6MkUCRz31ZuM4c
         D9TGagwOm77KLnYvzXesmQsvDr/r91APP43U/h9O/yHwmCSWW05xy7EysJPqE2kmV7g6
         xSZWRPcOPSmOUu/80OTQfYKSdOW8ZQhkRJbsPRe+y9LAXT20EQxD7t76ebphYqPmaWn5
         lfuCPjnAWmEzhqyRjaGCsVsttQNkGAE5wBdpjbM65Of8Rpepd/8oYaiyTxO7jORsSfJP
         Q9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767005574; x=1767610374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2je2Qn3fetVLzu93alqgF/no2c7aUP4V2wy0jPtd70U=;
        b=AGB9FvvpJ8IW9rbaMuBdCxjUbQjOXq7YlPsmh/l4rniMZRD84iO71BBvHeyn0vDAcO
         bVqBDPzCct8XHJX9H5NPRreXzaaok15HiVNjOtVjj1zU7b8xaG4dN8b0n93TTQfYUHcB
         Yn3/McpovUhiJgwnnRyxjDIG1fM6RecgGUa0FrFvJq6pX7yEdtacdM7coozBSm/R0UvG
         NjcddxZW2OBYIOmVOtmftbLUw2FdeNCwMcoWARzGcl65kviWUPrfAmrPhLupo5CQpAE0
         qO6jsDhPpBswMYQ9fDEHKxrslb40bMKlA3nKGBmaq82wFWMIVmImx6WxYN9rlxteyvCC
         GeAg==
X-Forwarded-Encrypted: i=1; AJvYcCUfE89i0utJAwIQz6vZyUg/iA0YbgDb3eEIqlpdfNUwNueAEam0dtWtz87shZcfLahNqw8HosnF@vger.kernel.org
X-Gm-Message-State: AOJu0YzdeqN/Zms99Bdn00R+Isdrff7bfkuQPjPI7GUkGrZAYv4MaFC9
	S4kKeJDNm91tpsALNuJRg3dFIpERcJ9juXzXQxy2b2R7RBlyQYRVtpK+nmKgxZxi6+8=
X-Gm-Gg: AY/fxX53dNtp72htcAmQDPsBbk6QCcJmUuyRcyXAbgNF2jIF6fq1Z0p8ooqL5PBa9AB
	l68dcReXZ/7HmBdhJem1Vg3e6xw97SUq8aKXEySVQQmHXBKL28DbWBbyYyt81y//qf/4YAAUEGI
	D77MSlYSfHh2zflq5BUYt/WJ9KIlO0IsNHXk9/W4TwMi9w+feHPiJmFI13wdf6w2YTeQJZA7Sg9
	yDu6RBdZh3Bjr7DjMh+ykaxfjRdBMaoxAVZqvaVO1WXqK5m7WoqUDYWd82PRqCRuOch2Qu0Y032
	VhobIIScTz7H3dKudnyIOfxdyt44coox+I34+BObizI7ppcDxi4+7XrzRfJHiWgQ2Ysq1oEs0Y0
	h2cZJAR3OOABpivM6RC8dwehWUZuQnt27P2GIy/aexJVnRhdCk+SU0U+88HS/unGgGeISOKxRjR
	RxFmKa7ABzDDBn+vys2uM1NtpcuBptGB0=
X-Google-Smtp-Source: AGHT+IFAZIRctmetW9tapLi56WB2FNZTvHaLwojYq9Phgcvqi/IEQa13TNzXYWZussaQmRw51uyEfA==
X-Received: by 2002:a05:600c:4e90:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-47d1959440dmr359077865e9.34.1767005574275;
        Mon, 29 Dec 2025 02:52:54 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be2723d19sm629127655e9.2.2025.12.29.02.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 02:52:53 -0800 (PST)
Date: Mon, 29 Dec 2025 11:52:52 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, imran.f.khan@oracle.com, 
	kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	chenridong@huaweicloud.com, akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, 
	apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
Message-ID: <xlvmvjieqfltqtf5y6y37elcwstrhs6sp7qco2npgucdd4ggus@icfvpgxrwljl>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <5dsb6q2r4xsi24kk5gcnckljuvgvvp6nwifwvc4wuho5hsifeg@5ukg2dq6ini5>
 <vsr4khfsp4unk73a75ky7i35nzdjqsbodyeeuxipu3arormfjr@awi2srdwawfu>
 <utl6esq7jz5e4f7kwgrpwdjc2rm3yi33ljb6xkm5nxzufa4o7s@hblq2piu3vnz>
 <7enyz6xhyjjp5djpj7jnvqiymqfpmb2gmhmmj7r5rkzjyix7o7@mpxpa566abyd>
 <llwoiz4k5l44z2dyo6oubcflfarhep654cr5tvcrnkltbw4eni@kxywzukbgyha>
 <wvj4w7ifmrifnh5bvftdziudsj52fdnwlhbt2oifwmxmi4eore@ob3mrfahhnm5>
 <63c958ae-9db2-4da8-935b-a596cc8535d3@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="illqhsqtgan5bpog"
Content-Disposition: inline
In-Reply-To: <63c958ae-9db2-4da8-935b-a596cc8535d3@linux.dev>


--illqhsqtgan5bpog
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
MIME-Version: 1.0

On Tue, Dec 23, 2025 at 04:36:18PM -0800, Shakeel Butt <shakeel.butt@linux.=
dev> wrote:
=2E..
> The core stats update functions are mod_memcg_state() and
> mod_memcg_lruvec_state(). If for v1 only, we add additional check for
> CSS_DYING and go to parent if CSS_DYING is set then shouldn't we avoid
> this issue?

=2E..and go to first !CSS_DYING ancestor :-/ (as the whole chain of memcgs
can be offlined)

IIUC thanks to the reparenting charging (modifying state) to an offlined
memcg should be an exception...


On Mon, Dec 29, 2025 at 05:42:43PM +0800, Qi Zheng <qi.zheng@linux.dev> wro=
te:

> > We do reparenting in css_offline() callback and cgroup offlining
> > happen somewhat like this:
> >=20
> > 1. Set CSS_DYING
> > 2. Trigger percpu ref kill
> > 3. Kernel makes sure css ref killed is seen by all CPUs and then trigger
> >     css_offline callback.
>=20
> it seems that we can add the following to
> mem_cgroup_css_free():
>=20
> parent->vmstats->state_local +=3D child->vmstats->state_local;
>=20
> Right? I will continue to take a closer look.

=2E..and the time between offlining and free'ing a memcg should not be
arbitrarily long anymore (right?, the crux of the series).
So only transferring local stats in mem_cgroup_css_free should yield a
correct result after limited time range (with possible underflows
between) with no special precaution for CSS_DYING on charging side.

0.02=E2=82=AC,
Michal

--illqhsqtgan5bpog
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaVJdgRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Ah51gD/doiKV5VyTZFiXLb4HtUI
bo6/lt/P2BnUD8eq16i80doA/2jQKFn6l9VxvBFRi5i/AuI8/e+ynY2uvwooHwCr
c5IO
=7fmn
-----END PGP SIGNATURE-----

--illqhsqtgan5bpog--

