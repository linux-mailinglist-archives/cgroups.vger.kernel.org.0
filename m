Return-Path: <cgroups+bounces-6169-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89393A12A0C
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 18:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA49188AFD5
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 17:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0A11C07EE;
	Wed, 15 Jan 2025 17:41:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499F9161321;
	Wed, 15 Jan 2025 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736962887; cv=none; b=bEjpGuqUCQ9D8qd7r+9IchD6APq8NOMV7PB6GVA4QZVIcdpWdizeol6fmiR5bPbFkPhF5E7yp+Uj6jbTBMgsgA5X/03+SMhSDZlmkFVCbFc3Y8S0vkgkDBSZkWvNUN+PGWQrhEUHr6TLDdP4BholH043kn4wfEvEYXeNWZRo+zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736962887; c=relaxed/simple;
	bh=u8xPXUUiATHTukmThT9/U1wCgI/RWPxeBH+a+jDLIUM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mmy4lKJy9A9yuIRZ5BfUDXwG34oZs0sk4VyORgul9Ss6BZStMDNrAlMIONhz7LMnOdN3vr75ekti4sg3j/N0h2CuWjbrRL1/91qWlSADh1nvnDa9uiVM0vYovGNot9wvOMKZQNlYfhKAxM1PE6ZQ/ObeLgQojkOUFj98gWltCwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tY7In-000000005QV-3mbL;
	Wed, 15 Jan 2025 12:35:37 -0500
Message-ID: <7a4e5591f45df455e6a485fc5400989569d3d22d.camel@surriel.com>
Subject: Re: [PATCH v2] memcg: allow exiting tasks to write back data to swap
From: Rik van Riel <riel@surriel.com>
To: Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Balbir Singh <balbirs@nvidia.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, hakeel Butt
 <shakeel.butt@linux.dev>, Muchun Song	 <muchun.song@linux.dev>, Andrew
 Morton <akpm@linux-foundation.org>, 	cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 	kernel-team@meta.com,
 Nhat Pham <nphamcs@gmail.com>
Date: Wed, 15 Jan 2025 12:35:37 -0500
In-Reply-To: <Z4a-GllRm7KABAu7@tiehlicka>
References: 
	<CAJD7tkY=bHv0obOpRiOg4aLMYNkbEjfOtpVSSzNJgVSwkzaNpA@mail.gmail.com>
	 <20241212183012.GB1026@cmpxchg.org> <Z2BJoDsMeKi4LQGe@tiehlicka>
	 <20250114160955.GA1115056@cmpxchg.org> <Z4aU7dn_TKeeTmP_@tiehlicka>
	 <af6b1cb66253ad045c9af7c954c94ad91230e449.camel@surriel.com>
	 <Z4aYSdEamukBGAZi@tiehlicka>
	 <193d98b0d5d2b14da1b96953fcb5d91b2a35bf21.camel@surriel.com>
	 <Z4apM9lbuptQBA5Z@tiehlicka> <20250114192322.GB1115056@cmpxchg.org>
	 <Z4a-GllRm7KABAu7@tiehlicka>
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

On Tue, 2025-01-14 at 20:42 +0100, Michal Hocko wrote:
> O
> I do agreee that a memory deadlock is not really proper way to deal
> with
> the issue. I have to admit that my understanding was based on ENOMEM
> being properly propagated out of in kernel user page faults.=20

It looks like it kind of is.

In case of VM_FAULT_OOM, the page fault code calls
kernelmode_fixup_or_oops(), which a few functions
down calls ex_handler_default(), which advances
regs->ip to the next instruction after the one
that faulted.

Of course, if we have a copy_from_user loop, we
could end up there a bunch of times :)

--=20
All Rights Reversed.

