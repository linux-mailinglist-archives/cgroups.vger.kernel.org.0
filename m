Return-Path: <cgroups+bounces-8830-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9D4B0D5E9
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 11:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA935561C8F
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 09:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B842DA749;
	Tue, 22 Jul 2025 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khirnov.net header.i=@khirnov.net header.b="YGxtdJpH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail0.khirnov.net (red.khirnov.net [176.97.15.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867552DEA66
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.97.15.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753176281; cv=none; b=p34CD5tSrsoouOuZSmxOGIhbe1eXzw8lDHj8IAmlw0kZSp95pbjTeQDypnTxcFLfsArzUBVqvyB1vh4YKBUXr1/FYIAZ/1szw5fUEApinqKZl/qgS3B2j0HbZ6qfZuT2nrNIXLggAUCyY6yHkFgNfdgcbZRdqllBQbB9Sv3eiKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753176281; c=relaxed/simple;
	bh=kkK2qYvd37nll/4qcfylEq/sJMtupYUhTb/9UrjJo/w=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-ID:MIME-Version; b=sROav7xWfB/faJ9TctoETBTDr1mR+K/goWSBgbYnYqMfRlASY/n4nD3sIKRQXTmPSOxOOnkKqjH0sI758pwmu7GsUMNClkr9qKg8tirK/HM2HO4LSGXulbTmLi3qFTAeWuttTx1qCaxPt4oXvGq5Gt3AMVRxizNKBWUJQFLE4/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khirnov.net; spf=pass smtp.mailfrom=khirnov.net; dkim=pass (2048-bit key) header.d=khirnov.net header.i=@khirnov.net header.b=YGxtdJpH; arc=none smtp.client-ip=176.97.15.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khirnov.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khirnov.net
Authentication-Results: mail0.khirnov.net;
	dkim=pass (2048-bit key; unprotected) header.d=khirnov.net header.i=@khirnov.net header.a=rsa-sha256 header.s=mail header.b=YGxtdJpH;
	dkim-atps=neutral
Received: from localhost (localhost [IPv6:::1])
	by mail0.khirnov.net (Postfix) with ESMTP id 46C5C244764;
	Tue, 22 Jul 2025 11:24:28 +0200 (CEST)
Received: from mail0.khirnov.net ([IPv6:::1])
 by localhost (mail0.khirnov.net [IPv6:::1]) (amavis, port 10024) with ESMTP
 id Ag4P7WlbhTA1; Tue, 22 Jul 2025 11:24:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=khirnov.net; s=mail;
	t=1753176267; bh=kkK2qYvd37nll/4qcfylEq/sJMtupYUhTb/9UrjJo/w=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=YGxtdJpHpVSV8yrrEqJCaWvcdTYAI3QtkA5JLp9wFfOwjOjTHBMC/A7EnXS5VyzAb
	 u0zgAZk6oPK9EqX6gqxF/9U1CzdrbKfT4k/DmUr1u9PnC3mnaMXmCgHeyHlWRuzwcn
	 uEgpREf0ZF9NzIr45+Ch7Va3VpJv1BrB78qC2gfVGuWLX1B8kEqMLlC5fkt/lZJhvN
	 VbQ8lAcVLMDDZ16rSCLVp97WFJ9yWDIV5YU6vUzVzGKg42vP3hC8WHfARC8sYRLT3Z
	 ootjPF+SrGwaKHhullhGbXOKCnW8hL59h+2KINJp8GxzOBc2v+Mh7NV0ntnpXNO9Xh
	 L3CTZHIAafecQ==
Received: from lain.khirnov.net (lain.khirnov.net [IPv6:2001:67c:1138:4306::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "lain.khirnov.net", Issuer "smtp.khirnov.net SMTP CA" (verified OK))
	by mail0.khirnov.net (Postfix) with ESMTPS id E67A2244763;
	Tue, 22 Jul 2025 11:24:26 +0200 (CEST)
Received: by lain.khirnov.net (Postfix, from userid 1000)
	id C78871601BA; Tue, 22 Jul 2025 11:24:26 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject:  Re: unexpected memory.low events
From:  Anton Khirnov <anton@khirnov.net>
To:  Michal =?utf-8?q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:  cgroups@vger.kernel.org
In-Reply-To:
  <gik2vqz5bkqj2d3cgtsewxf2ty22dbghlkjaj7ghp7trshikrh@2moxbvqgkdsn>
References:  <175300294723.21445.5047177326801959331@lain.khirnov.net>
 <gik2vqz5bkqj2d3cgtsewxf2ty22dbghlkjaj7ghp7trshikrh@2moxbvqgkdsn>
Date: Tue, 22 Jul 2025 11:24:26 +0200
Message-ID: <175317626678.21445.13079906521329219727@lain.khirnov.net>
User-Agent: alot/0.8.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Michal,
thank you for the reply
Quoting Michal Koutn=C3=BD (2025-07-21 14:18:07)
> Hello Anton.
>=20
> On Sun, Jul 20, 2025 at 11:15:47AM +0200, Anton Khirnov <anton@khirnov.net>=
 wrote:
> > memory.low in every other cgroup is 0. I would expect that with this
> > setup the anon memory in <protectedcontainer> would not be swapped out
> > unless it exceeded 512M.
>=20
> It depends on how much reclaimable memory is out of the protected
> cgroup. Another factor is why the reclaim happens -- is it limited by
> physical memory on the machine itself or is it due to memory.max on some
> of the ancestors?

I am not touching memory.max in any cgroup, it is left at 'max'
everywhere. The events (which I get by polling memory.events) always
seem to be triggered by high IO activity - e.g. every container
rechecks the checksums of all system files at midnight, etc.

>=20
> > However, what actually happens is:
> > * the 'low' entry in memory.events under <protectedcontainer> goes up
> >   during periods of high IO activity, even though according to
> >   documentation this should not happen unless the low boundary is
> >   overcommitted
>=20
> It should not happen _usually_ but it's not ruled out.
>=20
> > * the container's memory.current and memory.swap.current are 336M and
> >   301M respectively, as of writing this email
> > * there is a highly noticeable delay when accessing web services running
> >   in this container, as their pages are loaded from swap (which is
> >   precisely what I wanted to prevent)
>=20
> That sounds like there's large demand for reclaim which this protection
> cannot help with (also assuming all of the swapped out amount is part of
> workingset for give latency, 336+301>512, so your config is actually
> overcommited).

So if I'm understanding it right, memory.current also includes page
cache, correct? And then if I'm to achieve effective protection, I
either need to account for all files that the container will read, or
protect individual processes within the container?

Or is there a way to give a higher weight to page cache during reclaim
on a per-cgroup basis? Apparently swappiness can not longer be
configured per-cgroup in v2.

Cheers,
--=20
Anton Khirnov

