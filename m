Return-Path: <cgroups+bounces-9871-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 015ACB517CF
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 15:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8CD468388
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 13:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17E71E9B35;
	Wed, 10 Sep 2025 13:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="HxPUD65k"
X-Original-To: cgroups@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8EB3F9D2;
	Wed, 10 Sep 2025 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757510690; cv=none; b=jUFlU5DX3RE+/XF2GGOuUXs31xlqf8Q6tcxhrRfqYuS0HjEKecYlkF/PZCfMUHnLY1jWse4tXDiTJ5UH85bKxADZ+IQNrBjz/LGTtOQtXgkYN0p2RSmXaSxfxG+4yyCmlyNaQUwcxO3xGsIazRq2VaoBtNqeHcxmyHbEonfz7uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757510690; c=relaxed/simple;
	bh=TZW5gX/6qtXMGbF4KiAfYU4cE1nMCXqFJmICiZe061w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dieIQLs0LJGx6G8styJ9VDlwhK+yZt90ZtdENkLpCgvWyEVWfhBcj7aBTOyR9LkK+P/OU0/zYGKG8MKCIAN7dCee7E1CsRKlsbJU153DQj80oes7IwlDKm9502Q66OhyxqfT2WKtxgiIq6G0eSyUCl4sf7CKUNELwjrdKisBDoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=HxPUD65k; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AF6AF40ACB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757510686; bh=Qj1nK8ZbsuLCpuByA7Bh4RAtk9SpG6e8ewgeSpJXNhc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HxPUD65k4miJo4fmzLAAY7PNzBXsfSN6b3fLlCttd+hvkwnjSC3JEFkUhHP5/d+FM
	 M0spH6opiCdwLw/a9x/eVVOvNyYZW/GjQuwwrIhHBr7EVamUR93qLj0Hz2jlNEp3Ym
	 WgG/riaCfON/0zVXCXXe9sdyUoamN5oRby4C6mBLtaGSCRwZk63LiC0VrqeHFzMcEI
	 qIOWF3W63hZfRI6XQ2sm9MW51SmTvqsKg8NEog3gK9NYhFFWBbeZobFNZt8uaTm304
	 uJgrX+9eeRpXZTyxQFvcSHn8W0Kghp2MO8FOyia4eNgYdfedh4Gfb53l5P1hMCdMg9
	 zj/7ZUBHRkX8Q==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id AF6AF40ACB;
	Wed, 10 Sep 2025 13:24:46 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Bagas Sanjaya
 <bagasdotme@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux
 Documentation <linux-doc@vger.kernel.org>, Linux cgroups
 <cgroups@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Andrea Righi <arighi@nvidia.com>, Johannes
 Bechberger <me@mostlynerdless.de>, Changwoo Min <changwoo@igalia.com>,
 Shashank Balaji <shashank.mahadasyam@sony.com>, Ingo Molnar
 <mingo@kernel.org>, Jake Rice <jake@jakerice.dev>, Cengiz Can
 <cengiz@kernel.wtf>
Subject: Re: [PATCH 2/2] Documentation: cgroup-v2: Replace manual table of
 contents with contents:: directive
In-Reply-To: <6geggl3iu2hffdop43rtd6yp2ivd26ytfn4xdclurwce6mapal@4ve46y652dbj>
References: <20250910072334.30688-1-bagasdotme@gmail.com>
 <20250910072334.30688-3-bagasdotme@gmail.com>
 <6geggl3iu2hffdop43rtd6yp2ivd26ytfn4xdclurwce6mapal@4ve46y652dbj>
Date: Wed, 10 Sep 2025 07:24:45 -0600
Message-ID: <875xdqtp7m.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Michal Koutn=C3=BD <mkoutny@suse.com> writes:

> On Wed, Sep 10, 2025 at 02:23:34PM +0700, Bagas Sanjaya <bagasdotme@gmail=
.com> wrote:
>> manually-arranged table of contents (as reST comments) gets out-of-sync
>> with actual toctree as not all of these are added to it.
>
> Is this true? I generated HTML with this patch and the resulting ToC
> matches what's in the comment.
>
>> Replace it with automatically-generated table of contents via contents::
>> directive.
>
> Mauro, what's the best practice wrt consistent ToC and having it in
> plaintext form?

I fairly routinely get patches fixing manual TOCs that are not updated
to match changes elsewhere.  We have a nice system that can manage the
TOC automatically for us, it seems best to me to use it.

That said, if having the TOC in the plain-text version of the document
is deemed to be important, then it needs to be kept and manually
maintained.

Thanks,

jon

