Return-Path: <cgroups+bounces-11762-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8E8C492A7
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 21:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46DC2188E371
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 20:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47991337B8A;
	Mon, 10 Nov 2025 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="MvdQFh+p"
X-Original-To: cgroups@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD61823ABAA;
	Mon, 10 Nov 2025 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762804844; cv=none; b=qV5nnmALa/TJnYUYWlUVXst//ii4cpMegkzQuSY/vr5y/6wxZc5cgmuQEFwjhLb0Udozo06O49xYeXR7pK43duqmj20aEzKCRyYuFmChUQr1Vn4q0aI39sM7Ku1/M4OSAhjbb9d2Ybqtbqy0RKA9XXEFBrn51L8fxSTp5nC/Xtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762804844; c=relaxed/simple;
	bh=x3/zNfptxWLesTC0zLnXtLKCOdpS9US28LaLU57PJYE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BOvzKw0hPGByXYdEbDj8OfJjhkfdCegi71WEH9RMhYjXLjY/5lJjtKlSZETMHLr2imt/vDJdhWAmBSzUYYTdQTTYwZH1ofYoiTesoSyCDUmHIF/EfqSbLDeyHv+y4/nLBFu8a7g5HHEjv76DiDwNqRySlaNM7VrhJ9cnLAeWXQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=MvdQFh+p; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EC94D40AFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762804842; bh=q4tGKQ/Buw90yug1sDXqAML16zlt1m1AKUdfO1e3XuU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MvdQFh+p7soAU+Q4EEOZVUp40TCC9BxygeHkyl0sPBwXPK6AQnUTsQhHSxB9jMPSx
	 AIrwtaELKfZcSWiNqlazlRGh8/Hq2rZZUV2BkbFAqvj3C+ACxgOIDkVUuULoRze6qa
	 Wf84RK+3IVFkrmBbpddmNbzKF0cwXjbBO3ceLPMxtfiDgsqC+kg72ysq+nIK7QGEzE
	 O89awm2CQ9lB83VkLmV5pr6xe6TkZjSWEcQV6OeaU+QtJJQFD0uOUJPShwunaVJhB8
	 JjzzhxGq0+/OKtZyzcVV68vjVhmoOKtnupiaIjD/e7v8lWzN8+Xni5fMuiKrM71nIC
	 DRMIUyKDU2fzQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id EC94D40AFB;
	Mon, 10 Nov 2025 20:00:41 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Natalie Vock <natalie.vock@gmx.de>, Maarten Lankhorst
 <dev@lankhorst.se>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
 Tejun Heo
 <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH RESEND 1/3] docs: cgroup: Explain reclaim protection target
In-Reply-To: <20251110193638.623208-2-mkoutny@suse.com>
References: <20251110193638.623208-1-mkoutny@suse.com>
 <20251110193638.623208-2-mkoutny@suse.com>
Date: Mon, 10 Nov 2025 13:00:41 -0700
Message-ID: <87wm3xwtcm.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Michal Koutn=C3=BD <mkoutny@suse.com> writes:

> The protection target is necessary to understand how effective reclaim
> protection applies in the hierarchy.
>
> Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 0e6c67ac585a0..a6def773a3072 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -53,7 +53,8 @@ v1 is available under :ref:`Documentation/admin-guide/c=
group-v1/index.rst <cgrou
>       5-2. Memory
>         5-2-1. Memory Interface Files
>         5-2-2. Usage Guidelines
> -       5-2-3. Memory Ownership
> +       5-2-3. Reclaim Protection
> +       5-2-4. Memory Ownership

I always have to ask...do we really need the manually maintained TOC
here?=20

>       5-3. IO
>         5-3-1. IO Interface Files
>         5-3-2. Writeback
> @@ -1317,7 +1318,7 @@ PAGE_SIZE multiple when read back.
>  	smaller overages.
>=20=20
>  	Effective min boundary is limited by memory.min values of
> -	all ancestor cgroups. If there is memory.min overcommitment
> +	ancestor cgroups. If there is memory.min overcommitment
>  	(child cgroup or cgroups are requiring more protected memory
>  	than parent will allow), then each child cgroup will get
>  	the part of parent's protection proportional to its
> @@ -1343,7 +1344,7 @@ PAGE_SIZE multiple when read back.
>  	smaller overages.
>=20=20
>  	Effective low boundary is limited by memory.low values of
> -	all ancestor cgroups. If there is memory.low overcommitment
> +	ancestor cgroups. If there is memory.low overcommitment
>  	(child cgroup or cgroups are requiring more protected memory
>  	than parent will allow), then each child cgroup will get
>  	the part of parent's protection proportional to its
> @@ -1934,6 +1935,23 @@ memory - is necessary to determine whether a workl=
oad needs more
>  memory; unfortunately, memory pressure monitoring mechanism isn't
>  implemented yet.
>=20=20
> +Reclaim Protection
> +~~~~~~~~~~~~~~~~~~
> +
> +The protection configured with "memory.low" or "memory.min" applies rela=
tively
> +to the target of the reclaim (i.e. any of memory cgroup limits, proactive
> +memory.reclaim or global reclaim apparently located in the root cgroup).
> +
> +  root ... - A - B - C
> +              \    ` D
> +               ` E

This will not render properly, you want it in a literal block.  The
easiest way is to just make the line above read:

   ...located in the root cgroup)::

Thanks,

jon

