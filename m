Return-Path: <cgroups+bounces-8912-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E83DCB12FD8
	for <lists+cgroups@lfdr.de>; Sun, 27 Jul 2025 16:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538773BB0A9
	for <lists+cgroups@lfdr.de>; Sun, 27 Jul 2025 14:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521ED1F866A;
	Sun, 27 Jul 2025 14:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khirnov.net header.i=@khirnov.net header.b="pPIfSL3b"
X-Original-To: cgroups@vger.kernel.org
Received: from mail0.khirnov.net (red.khirnov.net [176.97.15.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD34126BF1
	for <cgroups@vger.kernel.org>; Sun, 27 Jul 2025 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.97.15.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753626357; cv=none; b=cpCjBirKzPL4Z9vkVSxwlGQebVBdxSIHXYlYVG2db3+BM+3dDmVKAwG5nzfKXbxeAf3WDwx5/3s6Vv7aRIJUEHMxfIH/+LnPEl5mrEc34o0jv/rMHCgjfEmoayQUfg7PnrJf3mJSrRBDkQ2bB+atNaMbZ73WQI8nU9HZSIKs7CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753626357; c=relaxed/simple;
	bh=M/Er1HH9uB2nWqhBLyyPZcNrXu8DlpMPm93KHpihLTU=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-ID:MIME-Version; b=qs0lkwOXnwCRic/XISOq+sN6afFHT6Hp8nOfChs+/pHqPekThgtdgEEb/kxrRfi2Gef9d6fNccIFTz68uMM9Dm53rj70nYVRXrEOkAg8+wif9w6zIBl268OHx0yaqpmIF4kgmyhZD8hHdCcqB8UM9emB+r57QeEqHyLJpBArF5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khirnov.net; spf=pass smtp.mailfrom=khirnov.net; dkim=pass (2048-bit key) header.d=khirnov.net header.i=@khirnov.net header.b=pPIfSL3b; arc=none smtp.client-ip=176.97.15.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khirnov.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khirnov.net
Authentication-Results: mail0.khirnov.net;
	dkim=pass (2048-bit key; unprotected) header.d=khirnov.net header.i=@khirnov.net header.a=rsa-sha256 header.s=mail header.b=pPIfSL3b;
	dkim-atps=neutral
Received: from localhost (localhost [IPv6:::1])
	by mail0.khirnov.net (Postfix) with ESMTP id A6DBB244926;
	Sun, 27 Jul 2025 16:25:42 +0200 (CEST)
Received: from mail0.khirnov.net ([IPv6:::1])
 by localhost (mail0.khirnov.net [IPv6:::1]) (amavis, port 10024) with ESMTP
 id P4zobyCOieTg; Sun, 27 Jul 2025 16:25:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=khirnov.net; s=mail;
	t=1753626342; bh=M/Er1HH9uB2nWqhBLyyPZcNrXu8DlpMPm93KHpihLTU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=pPIfSL3bTQsP8tpEBOSBb4WJ1PLB4Y9KNw7eK3lPNnYO+CET/KrP+02bWGVAlPGVM
	 8Fec8parrE8Ol/L61UCqiepZn1UFz0kqqm5k/t96jbCf0IvtXqFtpkzYzJGegxGwAM
	 DzLyRgxBvZuQPyBWo348Zz3XisAt7Iwolo/Leq/WmRkPamnQMIL60jHEB4E4fWYXR0
	 ezoLcjLAdzU3UfcqkhR24KK49tY9/Qk6pSg8QXitg1OMZvSaMB4rvyVGxMmpvVv7GR
	 Zk0uNySGAgBYlZ0mrCV/CZiAKj5YLWxsiGHIYQAu0xCLWpsyGJTYBI5h6NNdbdbDL2
	 rU82PUWfXC2hg==
Received: from lain.khirnov.net (lain.khirnov.net [IPv6:2001:67c:1138:4306::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "lain.khirnov.net", Issuer "smtp.khirnov.net SMTP CA" (verified OK))
	by mail0.khirnov.net (Postfix) with ESMTPS id 234A4244925;
	Sun, 27 Jul 2025 16:25:42 +0200 (CEST)
Received: by lain.khirnov.net (Postfix, from userid 1000)
	id 01A5D1601BA; Sun, 27 Jul 2025 16:25:41 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject:  Re: unexpected memory.low events
From:  Anton Khirnov <anton@khirnov.net>
To:  Michal =?utf-8?q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:  cgroups@vger.kernel.org
In-Reply-To:
  <nxcveyfssgmnap4xemebk26l577cq65hynibymtn4ofdtyubyx@kd2dzvqw2tkm>
References:  <175300294723.21445.5047177326801959331@lain.khirnov.net>
 <gik2vqz5bkqj2d3cgtsewxf2ty22dbghlkjaj7ghp7trshikrh@2moxbvqgkdsn>
 <175317626678.21445.13079906521329219727@lain.khirnov.net>
 <nxcveyfssgmnap4xemebk26l577cq65hynibymtn4ofdtyubyx@kd2dzvqw2tkm>
Date: Sun, 27 Jul 2025 16:25:41 +0200
Message-ID: <175362634197.21445.15806428334933448944@lain.khirnov.net>
User-Agent: alot/0.8.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Michal,
Quoting Michal Koutn=C3=BD (2025-07-22 13:47:00)
> > Or is there a way to give a higher weight to page cache during reclaim
> > on a per-cgroup basis? Apparently swappiness can not longer be
> > configured per-cgroup in v2.
>=20
> ...or you may add restriction with memory.swap.max which should push the
> reclaim the page cache side of LRUs.

I tried that and it seems to be working as I wanted.

Thanks again for your help.

Cheers,
--=20
Anton Khirnov

