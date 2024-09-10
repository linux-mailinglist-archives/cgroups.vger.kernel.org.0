Return-Path: <cgroups+bounces-4829-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7519743F9
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 22:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA00289431
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 20:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B86C183CC7;
	Tue, 10 Sep 2024 20:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="n0mpy8zV"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC51176252;
	Tue, 10 Sep 2024 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725999541; cv=none; b=fjHUop9uuowg9KdAl/iNGRE60jD503N3+zvPJmHVg2GvVDItoNnav8e/tOTdgsucc9kN51xhugg0oQuNd/7PNs7pj/UWw4l771yA//J9B88u3VDYYwwDSWNFwWyMLTWukWGL0lVNPgn4OosQ1gkKL/BqIZ9OJ3S5xFUUoir8nnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725999541; c=relaxed/simple;
	bh=75laWeeAWTRgZG79KiruKCR/lnIpOdrzgV36Hmy4/OM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XFx0h0+fGUdr8ElcUJrBXMFhIE6vYX8u8lkPAZ78AiKkQDJHtTlxxXUYhVhFmK1ChGMKV4V1MTdS9WqGrpF8RwkQ+xKI/7bxI4DMNeA3JrBPPN+gAaszIwXDeFDKzSIMjaxjgq1d/diOOW2xY9Hlz7NIE1ozzJFVhCEnPfwus4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=n0mpy8zV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6F9C4CEC3;
	Tue, 10 Sep 2024 20:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725999541;
	bh=75laWeeAWTRgZG79KiruKCR/lnIpOdrzgV36Hmy4/OM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n0mpy8zVaG+4zCIvwNUFzlJ9rltSaQVNvLMHfgwENxcr+Hz9qb08SzGU2rWiXJUJv
	 9GBtuFn0QnSwF5+3WKQkvAaFuS/1jdsfJ62BGcPFImNuszJKaWGN0MU5pg7XfKUepW
	 xHH6zA5Mzv2u+4GlYDPhcr6mu/6XFEYJ5WQvkRnc=
Date: Tue, 10 Sep 2024 13:19:00 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Tejun Heo <tj@kernel.org>
Cc: Michal =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Muchun
 Song <muchun.song@linux.dev>, Chen Ridong <chenridong@huawei.com>
Subject: Re: [PATCH 1/4] memcg: Cleanup with !CONFIG_MEMCG_V1
Message-Id: <20240910131900.65e40be84b7f70261c62e154@linux-foundation.org>
In-Reply-To: <ZuCmpW2JFFAxmGvS@slm.duckdns.org>
References: <20240909163223.3693529-1-mkoutny@suse.com>
	<20240909163223.3693529-2-mkoutny@suse.com>
	<ZuCmpW2JFFAxmGvS@slm.duckdns.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Sep 2024 10:05:57 -1000 Tejun Heo <tj@kernel.org> wrote:

> On Mon, Sep 09, 2024 at 06:32:20PM +0200, Michal Koutn=FD wrote:
> > Extern declarations have no definitions with !CONFIG_MEMCG_V1 and no
> > users, drop them altogether.
> >=20
> > Signed-off-by: Michal Koutn=FD <mkoutny@suse.com>
>=20
> Acked-by: Tejun Heo <tj@kernel.org>
>=20
> This one should go through -mm. If Andrew doesn't pick it up from this
> thread, it might be better to repost it.
>=20

Yep, thanks, I grabbed all four patches.

