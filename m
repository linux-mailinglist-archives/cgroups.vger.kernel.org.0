Return-Path: <cgroups+bounces-4328-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF158954B11
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2024 15:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AD5EB20C63
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2024 13:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF5F1BB6A3;
	Fri, 16 Aug 2024 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b="QIivD/yS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867261B86F4;
	Fri, 16 Aug 2024 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723814745; cv=none; b=DPJj9nBJT4PJvK3gGyW4I54xIz+53NLclpprxqb443OYVzhAP/6dt2JNlEho9HftwiuM56CSfHvxIINX7qYcGZyRgAN9bFfgG0PXtCG17ogxlN78BJ0Nuqzn360lpUlL8tl83kUBHwIsvhL9DknDs9KDg+2sN4vvk+B9stxZ9HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723814745; c=relaxed/simple;
	bh=gUQKPQWrSGIzIAb1agk+B7rokGhBVzlNv0SdQW41qLE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKG27tgSmHSWXaAn8+uQZdyHhyQqWl+zeV1QCzvHIJg5HU8j+oWxiJwguZa+WD+7ho2deyf3luUpB4HNJo0n/WGfWKg8+PcD6OxMdFgOOEMqL6VpU+WwWrLuhqNV2K5fsw+dPAbubrowCOooH5QbSITGBrjY32JRbFfeQteZ0cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com; spf=pass smtp.mailfrom=yhndnzj.com; dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b=QIivD/yS; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yhndnzj.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yhndnzj.com;
	s=protonmail; t=1723814735; x=1724073935;
	bh=gUQKPQWrSGIzIAb1agk+B7rokGhBVzlNv0SdQW41qLE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QIivD/ySxixwlj05RryDWDXZp6PyI2q8OBu30dSarcdjdVF5M1DEpYYdIke0Q7GW6
	 HkHAs2Uv88IYHoVvV9OmUV8AaJgZ2SlNDINwv4OeZKkfmOVkhXr12XipvcuBJv4dIg
	 5GuenFz3MvgfW/sN0Fo3qttOPJmEWaIABC/FjssxDSrv9Ks7pCgOztU2+fuOjCkj+w
	 srE3hhpowApYaobTx2RzkV4hAnpJhARiE3WfxxnCGLQBXKIw9XDRPlCb5VcVHl1sgo
	 MiGvM/l/6r3BCzkQoBNOpIkzftRTy68Qt8Q6tCOZWdHQBEf9pVjvHiaPu/2Ze5fc4h
	 c+icybJNAKEtw==
Date: Fri, 16 Aug 2024 13:25:29 +0000
To: Nhat Pham <nphamcs@gmail.com>
From: Mike Yuan <me@yhndnzj.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH] mm/memcontrol: respect zswap.writeback setting from parent cg too
Message-ID: <27d13707674a1458c489d7f951355c8339aae83d.camel@yhndnzj.com>
In-Reply-To: <CAKEwX=Ok3g0Cm7dDgGJPpMBGWukTHFy2389Yc5_2WqzNd4Nmag@mail.gmail.com>
References: <20240814171800.23558-1-me@yhndnzj.com> <CAKEwX=NrOBg0rKJnXGaiK9-PWeUDS+c3cFmaFFV0RrE8GkNZZA@mail.gmail.com> <CAKEwX=Nbp40S2o_3gy9K84eWG4bnOxGm9AuAL4aEey22dpibLQ@mail.gmail.com> <5a671a9fca4534e499976bbc2b0a380ec496b4c4.camel@yhndnzj.com> <CAKEwX=Ok3g0Cm7dDgGJPpMBGWukTHFy2389Yc5_2WqzNd4Nmag@mail.gmail.com>
Feedback-ID: 102487535:user:proton
X-Pm-Message-ID: 86c75d9a5060338a62b1923f3bedb13f931c9127
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2024-08-15 at 12:10 -0700, Nhat Pham wrote:
> On Thu, Aug 15, 2024 at 11:39=E2=80=AFAM Mike Yuan <me@yhndnzj.com> wrote=
:
> >=20
> >=20
> > Hmm, I tried to, but the test_zswap_writeback_enabled and
> > test_zswap_writeback_disabled tests in the current tree already
> > fail for me... Should I still add new test cases under this
> > circumstance?
>=20
> Hmm interesting. We need to fix it - could you forward me the details
> of the failure mode?
>=20
> But yeah, for now let's skip the selftest. Could you send a fixlet or
> a follow up patch to update the documentation :)

Sorry for the noise. It seems to be local configuration issue from my
side.
I'll submit a v2 with Documentation update and selftest :)


