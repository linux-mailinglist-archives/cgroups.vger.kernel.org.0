Return-Path: <cgroups+bounces-16208-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sM2VHgBoEGpJXAYAu9opvQ
	(envelope-from <cgroups+bounces-16208-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 16:28:16 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E9C5B6258
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 16:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0595D301AFC4
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 14:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFAB42668E;
	Fri, 22 May 2026 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eIImTcFT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC0223AE9B
	for <cgroups@vger.kernel.org>; Fri, 22 May 2026 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459449; cv=none; b=A7OACCMXkhIfTPpxVdmO5gWBwFj3/85ll7tyBzxL7Nt10kWUGDOyFzARgbaxXFzHG7gjpYDhd5RzogQMbFfJtWv4leQejYTycQxC/+a9pv/oyPFaErAoJz1gNi4JZwG6Zd6tKYxMzkmrZL0Vzi/9sC84kPOBPqZhDXCXiYbpeTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459449; c=relaxed/simple;
	bh=2IT4bU7zJWIhEAUx5KMcM7p2nf/aXZLIR7rfEpTYgnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clqghS5fR98uzSt0GTE3tDA4nKMd6ZlhmaVBB4pvQHUWZJXZCUnELsAj1OwuBnjSlAkBXJ4r5YzZ/guqA+VZLpEvzlZcDU1wrRit+hLw+RP1OFRo+D3YZwLo4czthcvr7FaDbwXAWUkur0nzdAnG+qk1jLYWq9t/I0rFnMqbkh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eIImTcFT; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-44ce78ab5feso6177490f8f.0
        for <cgroups@vger.kernel.org>; Fri, 22 May 2026 07:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779459441; x=1780064241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q3AZPvBEFe3lqUHmEjYuLSqF1EqkmBHaAzjNMZgdm2Q=;
        b=eIImTcFTlAlr9HOQzgXQPUBKfb7ft69d9iss6RXOmKFxsMd1ToaR9DPW4WXvbfBolv
         JEhqlj24APDnehsYP3wDssxWXZdKd4NI2hpFZLXot+2m827U6XmLrKgr+Qn+Xnas21QM
         hAV5pU+aDlPo1tXCz/DQSrrB8OhHAU+B9IiH191EloPUlR9FTiVA5i0fQ/dzxDSAKDp7
         Th1O+HX2wmzi6oFJnkvyldzOzze8rwyyJvWhIeisEFCSvz5LbzzqPzyKTPCUnH6YoW/m
         2I6goD8TsaInZVCPRvte5ikhIonoDmAvK/gTzexhAwRP8NBazkgi8x1/FGl0+EFuo8Ic
         aqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779459441; x=1780064241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3AZPvBEFe3lqUHmEjYuLSqF1EqkmBHaAzjNMZgdm2Q=;
        b=DIRZxmqV4/LnKlyMFRvMhl2MwUgt9NvNqs6IEbsa37uq5O+96VKf/6oe46VuxQTTiM
         Ph+RsNg8RJ3QRv+3fXkIckYy9cVDR0FC/wIh9hGa3EPrJVGhwDvX7IgtuJB5NjIqb0GU
         BxXyR/BJ7vfsE7iKHYnq5g4ueCzudVN8cvSupxSlnwRNIUJ/4Giceznwg/C3O6XpAHFx
         O07lXKT5gvRJZp7Ed1ye8akOzvZBvOE49GOGrGmunQkIiny7Wj51QnsvhB2i6F+5zfiH
         z70qN3xm1xKpAmNDWnCKtvPLKlIYTBF0PlT8IpMWWwO/rlGZEdE/UvcaYWLo3RWm1KYL
         aTjA==
X-Forwarded-Encrypted: i=1; AFNElJ8Qpwml3bAm6HJkngIx57l21lnLa6e6rwLBk8sQGQWw+YfO4v4tjX8fPklkEwz+lPVtsFxgzL1Z@vger.kernel.org
X-Gm-Message-State: AOJu0YyzhXhDmveNncstzoJ7pWZTjBkP5mT86kFQLKnXNsmRjK/8fJvh
	pN/w3rKODYETV1aIVDD6AITel6nwTE7jS0ZYK5/kTNPKH3AKNPUfsagYHGaJ6SarI8I=
X-Gm-Gg: Acq92OEMQhXAFjdDxg82LJA2Ts/jSuwfq0QbP8W/xqegE/qpoo9dHqwuz1JZcF1Vp6p
	Xt27H0kHZmCULkVzhbS9K4UcYwM6lIJ455RHp+zc+fg6AWyXGHgKWy07VwPdPYJlHpTjQLMguZk
	ny/32JfcTIvgTX2B4is7aV43w0wPCg2kFq5ddupOYprUveGpU7ikXq/iSuLCmG/btgTFo627Iih
	hHAVr7RAaqtC7DMeTOUkposG2FoYkOQuceVDrN9c0E/g/OHZjmctLab0L10ZQ6kqwNJeVx+AbVG
	cdvydzqMJSa+dMIWV5uf0DjdEKfuylY9fX/bdT4uuYP52bIbeu1l3+eahw7XVmym9fI5rir4Ui6
	0ZsKaA2ndYUC4BnGqrPvVKX4y7/b5/ysgS4z/kTEgW5i9KNUa+3B1ZYiE0urV4QSIemTAP7rJGN
	rudTMVQhVbgzBwlz5zNJeFMvUNtVWsLCHdV0GY3DHKBiGMhfaq
X-Received: by 2002:a05:6000:1446:b0:43c:f1a5:56f6 with SMTP id ffacd0b85a97d-45eb38df638mr6017569f8f.43.1779459441546;
        Fri, 22 May 2026 07:17:21 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9f598sm4662287f8f.6.2026.05.22.07.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 07:17:20 -0700 (PDT)
Date: Fri, 22 May 2026 16:17:19 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/cgroup: enable memory controller in hugetlb
 memcg test
Message-ID: <ahBlG9kRRFD8xSVc@localhost.localdomain>
References: <20260520093130.490020-1-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4ioeyy53bhh73ifv"
Content-Disposition: inline
In-Reply-To: <20260520093130.490020-1-zhangguopeng@kylinos.cn>
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16208-lists,cgroups=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 15E9C5B6258
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--4ioeyy53bhh73ifv
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] selftests/cgroup: enable memory controller in hugetlb
 memcg test
MIME-Version: 1.0

On Wed, May 20, 2026 at 05:31:30PM +0800, Guopeng Zhang <zhangguopeng@kylin=
os.cn> wrote:
> test_hugetlb_memcg creates a child cgroup and then writes memory.max and
> memory.swap.max. When the test is run standalone, the memory controller
> may not be enabled in the test root cgroup's subtree_control.
>=20
> In that case, the child cgroup is created without the memory control
> files, and the test fails during setup before reaching the hugetlb memcg
> accounting checks.
>=20
> Skip the test when the memory controller is unavailable. Otherwise, enable
> it in subtree_control before creating the test cgroup.

Makes sense.

> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> ---
> Tested with a cgroup namespace where memory is available in
> cgroup.controllers but not enabled in cgroup.subtree_control:
>=20
>   before: test_hugetlb_memcg failed with "fail to set cgroup memory limit"
>   after:  test_hugetlb_memcg passed and cgroup.subtree_control contained =
memory
>=20
>  tools/testing/selftests/cgroup/test_hugetlb_memcg.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

--4ioeyy53bhh73ifv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCahBlahsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Aj5lgD+KS03JEmXK2JC8snPY5sv
PAmo66NuwBsqgnP9kOfQ8ZcA/2IFpR2fC0yXtbS+OysEn2k3bmEuzcNLcjI0lbRg
ndEG
=yptN
-----END PGP SIGNATURE-----

--4ioeyy53bhh73ifv--

