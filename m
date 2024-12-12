Return-Path: <cgroups+bounces-5863-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379489EF6E3
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 18:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2E728BB00
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 17:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F73222D44;
	Thu, 12 Dec 2024 17:29:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575E4222D64
	for <cgroups@vger.kernel.org>; Thu, 12 Dec 2024 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024592; cv=none; b=BtBkQXv2TPOXPi3Tygq7GNj3PHR2mrwnO6JG5FmYNf6SqSy+HrDzAckui7PCmK4QgPhZNDHQkoK7W+XZf9yVfy7Vc5lkP2GR1ql+H6IhMRa3bC+vtORC114/9wJcghJc0cYlS6G6zGcRoNwnulJphvl80ttX4+wREPekDoUsBe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024592; c=relaxed/simple;
	bh=ayFvDAuq2+Jwh2xZPoLyKRjBI+kW/hEHltWiLIYYHCs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=YANdbYyVWS/XUdhi+3jyXpIQAPnqXeHVDT0apd5noBrU6hiQXKsXH4AyL9pldAOXeAOLMYjQYkel48DyzwOoTmWKu6QAAl8lnx1rG2+3PKm0ECIoS4YGbZreAU6hiQmBsX02LzVXx9S1JYCW9D2jgLk2eLbN1YLTum7nh2fxAfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-37-nu4osZHLMQSYbwV6FMbTtw-1; Thu, 12 Dec 2024 17:29:41 +0000
X-MC-Unique: nu4osZHLMQSYbwV6FMbTtw-1
X-Mimecast-MFC-AGG-ID: nu4osZHLMQSYbwV6FMbTtw
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 12 Dec
 2024 17:28:44 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 12 Dec 2024 17:28:44 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Tejun Heo' <tj@kernel.org>, Nathan Chancellor <nathan@kernel.org>
CC: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, Linux Kernel Functional Testing <lkft@linaro.org>,
	kernel test robot <lkp@intel.com>
Subject: RE: [PATCH] blk-iocost: Avoid using clamp() on inuse in
 __propagate_weights()
Thread-Topic: [PATCH] blk-iocost: Avoid using clamp() on inuse in
 __propagate_weights()
Thread-Index: AQHbTLneKltIssSpBEabKMv+lJlW17Li3L3A
Date: Thu, 12 Dec 2024 17:28:44 +0000
Message-ID: <5231409257664f8097c82f79869fb52b@AcuMS.aculab.com>
References: <20241212-blk-iocost-fix-clamp-error-v1-1-b925491bc7d3@kernel.org>
 <Z1sbG2zh8xmb-lxu@slm.duckdns.org>
In-Reply-To: <Z1sbG2zh8xmb-lxu@slm.duckdns.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TV-U7kQjP1ind_z3i2xekM86Lm1uWVNzqLmS5z8-vwQ_1734024580
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Tejun Heo <tj@kernel.org>
> Sent: 12 December 2024 17:19
>=20
> On Thu, Dec 12, 2024 at 10:13:29AM -0700, Nathan Chancellor wrote:
> > After a recent change to clamp() and its variants [1] that increases th=
e
> > coverage of the check that high is greater than low because it can be
> > done through inlining, certain build configurations (such as s390
> > defconfig) fail to build with clang with:
> >
...
> > __propagate_weights() is called with an active value of zero in
> > ioc_check_iocgs(), which results in the high value being less than the
> > low value, which is undefined because the value returned depends on the
> > order of the comparisons.
> >
> > The purpose of this expression is to ensure inuse is not more than
> > active and at least 1. This could be written more simply with a ternary
> > expression that uses min(inuse, active) as the condition so that the
> > value of that condition can be used if it is not zero and one if it is.
> > Do this conversion to resolve the error and add a comment to deter
> > people from turning this back into clamp().
> >
> > Link: https://lore.kernel.org/r/34d53778977747f19cce2abb287bb3e6@AcuMS.=
aculab.com/ [1]
> > Suggested-by: David Laight <david.laight@aculab.com>
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Closes: https://lore.kernel.org/llvm/CA+G9fYsD7mw13wredcZn0L-KBA3yeoVST=
uxnss-
> AEWMN3ha0cA@mail.gmail.com/
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202412120322.3GfVe3vF-lkp=
@intel.com/
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>=20
> Acked-by: Tejun Heo <tj@kernel.org>
>=20
> This likely deserves:
>=20
> Fixes: 7caa47151ab2 ("blkcg: implement blk-iocost")
> Cc: stable@vger.kernel.org # v5.4+

Especially since the old defn was:

#define __clamp(val, lo, hi)=09\
=09((val) >=3D (hi) ? (hi) : ((val) <=3D (lo) ? (lo) : (val)))

so:
-=09=09inuse =3D clamp_t(u32, inuse, 1, active);

is zero if active is zero.

=09David

>=20
> Thanks.
>=20
> --
> tejun

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


