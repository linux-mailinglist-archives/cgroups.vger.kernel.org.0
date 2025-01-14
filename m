Return-Path: <cgroups+bounces-6145-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1007AA10D30
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 18:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60877161B86
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 17:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22251CF7AF;
	Tue, 14 Jan 2025 17:12:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAFB1BD9E7;
	Tue, 14 Jan 2025 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736874727; cv=none; b=bP51WdgkuHP9Pk68JjSEl+mUze+1cQasRlzLm7mxF9D1S6ExeGb8TQ65ghZyvHXj0G31HNnaUxEmkSqYxQJnIyKD4xgyMGLNrdEfqzSS5a/jgzzZ6KS6kWZCx062oN5akJ+py97Sw4UV2WJiF3Efe7tztkHtYruwuuSFASgZpYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736874727; c=relaxed/simple;
	bh=f2U7tOnZPuRxU/wb1Bm7gMMLy4PIWvSH0mVGFR0Al1Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TwKJxbm0QKPV5+a06QfG9xoQuQMTfNiW0NFBRW7TbnVKz8BPct47jfMlRkKQ+oD+ajWKk8kA/AkwoQAWNZi7SQcoBwK4kwNIEgHjtpkgo3o98U2E4KINUQQj99SU3Kb2BPfhNRKjZAwNaJQhYVyn6Y+NSxNzfwXv5BreJ39lseE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tXkSI-000000000XQ-3kHZ;
	Tue, 14 Jan 2025 12:11:54 -0500
Message-ID: <193d98b0d5d2b14da1b96953fcb5d91b2a35bf21.camel@surriel.com>
Subject: Re: [PATCH v2] memcg: allow exiting tasks to write back data to swap
From: Rik van Riel <riel@surriel.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed
 <yosryahmed@google.com>,  Balbir Singh <balbirs@nvidia.com>, Roman Gushchin
 <roman.gushchin@linux.dev>, hakeel Butt	 <shakeel.butt@linux.dev>, Muchun
 Song <muchun.song@linux.dev>, Andrew Morton	 <akpm@linux-foundation.org>,
 cgroups@vger.kernel.org, linux-mm@kvack.org, 	linux-kernel@vger.kernel.org,
 kernel-team@meta.com, Nhat Pham <nphamcs@gmail.com>
Date: Tue, 14 Jan 2025 12:11:54 -0500
In-Reply-To: <Z4aYSdEamukBGAZi@tiehlicka>
References: <20241212115754.38f798b3@fangorn>
	 <CAJD7tkY=bHv0obOpRiOg4aLMYNkbEjfOtpVSSzNJgVSwkzaNpA@mail.gmail.com>
	 <20241212183012.GB1026@cmpxchg.org> <Z2BJoDsMeKi4LQGe@tiehlicka>
	 <20250114160955.GA1115056@cmpxchg.org> <Z4aU7dn_TKeeTmP_@tiehlicka>
	 <af6b1cb66253ad045c9af7c954c94ad91230e449.camel@surriel.com>
	 <Z4aYSdEamukBGAZi@tiehlicka>
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

On Tue, 2025-01-14 at 18:00 +0100, Michal Hocko wrote:
> On Tue 14-01-25 11:51:18, Rik van Riel wrote:
> > On Tue, 2025-01-14 at 17:46 +0100, Michal Hocko wrote:
> > > On Tue 14-01-25 11:09:55, Johannes Weiner wrote:
> > >=20
> > > > charge_memcg
> > > > mem_cgroup_swapin_charge_folio
> > > > __read_swap_cache_async
> > > > swapin_readahead
> > > > do_swap_page
> > > > handle_mm_fault
> > > > do_user_addr_fault
> > > > exc_page_fault
> > > > asm_exc_page_fault
> > > > __get_user
> > >=20
> > > All the way here and return the failure to futex_cleanup which
> > > doesn't
> > > retry __get_user on the failure AFAICS (exit_robust_list). But I
> > > might
> > > be missing something, it's been quite some time since I've looked
> > > into
> > > futex code.
> >=20
> > Can you explain how -ENOMEM would get propagated down
> > past the page fault handler?
> >=20
> > This isn't get_user_pages(), which can just pass
> > -ENOMEM on to the caller.
> >=20
> > If there is code to pass -ENOMEM on past the page
> > fault exception handler, I have not been able to
> > find it. How does this work?
>=20
> This might be me misunderstading get_user machinery but doesn't it
> return a failure on PF handler returing ENOMEM?

I believe __get_user simply does a memcpy, and ends
up in the page fault handler.

It does not access userspace explicitly like we do
with functions like get_user_pages.

--=20
All Rights Reversed.

