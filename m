Return-Path: <cgroups+bounces-6144-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A754A10CE8
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 18:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D69416A12F
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 17:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723DA1AA1DC;
	Tue, 14 Jan 2025 17:01:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC83C14AD2E;
	Tue, 14 Jan 2025 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736874086; cv=none; b=ngoAClRhE2TsVxeLQMqshJRloC2+g3+xp9K89I9lEc1pBQoIdpttyOk1KQENqgwYFSTVLamu/5HBmgU3CcjwZ09HVmYwCaN/5yi1BuPGATr0hPchNY4h3xqbcZ+PC4hI/uW/POcKavgy8IyOjtj8kWZQZdRpfOInTXy6Md83cDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736874086; c=relaxed/simple;
	bh=R88i/iRzxO2ixybo41pWF1KELxLSXSWNqc/8wXFSIqE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i1LlmwaYyFjcL1wyMql6In5FHpXdV7h0eUeoyaBjWnFfg/u3ZoF99e5Ho8GW6rp2Gz0m5J85RoJuqGJHDYf1FpU1wlUxft66/9GFRDjCut99FNmdDTBE+F/shEvSsS9qWYsOfUpJMTkFockMlRyxkotXgqsYCjdpnQR/lf6nPXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tXkDf-0000000008F-0ZN1;
	Tue, 14 Jan 2025 11:56:47 -0500
Message-ID: <298822027ef468c290a67fe98e228348e2b389de.camel@surriel.com>
Subject: Re: [PATCH v2] memcg: allow exiting tasks to write back data to swap
From: Rik van Riel <riel@surriel.com>
To: Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Balbir Singh <balbirs@nvidia.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, hakeel Butt
 <shakeel.butt@linux.dev>, Muchun Song	 <muchun.song@linux.dev>, Andrew
 Morton <akpm@linux-foundation.org>, 	cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 	kernel-team@meta.com,
 Nhat Pham <nphamcs@gmail.com>
Date: Tue, 14 Jan 2025 11:56:47 -0500
In-Reply-To: <Z4aWuD_-BkcEjvj7@tiehlicka>
References: <20241212115754.38f798b3@fangorn>
	 <CAJD7tkY=bHv0obOpRiOg4aLMYNkbEjfOtpVSSzNJgVSwkzaNpA@mail.gmail.com>
	 <20241212183012.GB1026@cmpxchg.org> <Z2BJoDsMeKi4LQGe@tiehlicka>
	 <20250114160955.GA1115056@cmpxchg.org> <Z4aU7dn_TKeeTmP_@tiehlicka>
	 <Z4aWuD_-BkcEjvj7@tiehlicka>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Tue, 2025-01-14 at 17:54 +0100, Michal Hocko wrote:
> O
> Btw. is there any actual reason why we cannot go nomem without going
> to the oom killer (just to bail out) and go through the whole cycle
> again? That seems arbitrary and simply burning a lot of cycle without
> much chances to make any better outcome
>=20
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7b3503d12aaf..eb45eaf0acfc 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2268,8 +2268,7 @@ int try_charge_memcg(struct mem_cgroup *memcg,
> gfp_t gfp_mask,
> =C2=A0	if (gfp_mask & __GFP_RETRY_MAYFAIL)
> =C2=A0		goto nomem;
> =C2=A0
> -	/* Avoid endless loop for tasks bypassed by the oom killer
> */
> -	if (passed_oom && task_is_dying())
> +	if (task_is_dying())
> =C2=A0		goto nomem;
> =C2=A0
> =C2=A0	/*

When we return from the page fault handler, we
restart the instruction that faulted.

That means we could just end up repeating the
same fault over and over again.

--=20
All Rights Reversed.

