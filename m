Return-Path: <cgroups+bounces-12936-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D15CFAA7C
	for <lists+cgroups@lfdr.de>; Tue, 06 Jan 2026 20:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F01532938D4
	for <lists+cgroups@lfdr.de>; Tue,  6 Jan 2026 18:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFAE2DC336;
	Tue,  6 Jan 2026 18:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="uzgfWQKK"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CB82BDC3F;
	Tue,  6 Jan 2026 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767725440; cv=none; b=u+Am2cVWOpZv2zmgV76DVCM1luCKnU8JmzaCzIysbRM3gG//Oxmm6qJP/v9PHcEmeNESXMtFEdVXQqzuJNQyA1fW3iCigFgMp5JaIdqqGLUxYGXzDkvqXxojA+89xInu1qLZ4VIAIJL8kNuKaykJ6FN9e1fnPprSupon1uRDFoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767725440; c=relaxed/simple;
	bh=BGJr4bLtW5UW/a277QKOKmHsnFt20Odg1H9gTtbyE1s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Iyc9okw2CrnrcYTTWY56QA1bE99SsJalR7ujWWI32H/BcvSUY4Ez2PeJiDQ/iZQfWlXlwP7XuME23pngIpn92iT8uT+pvBPnXsK4rrgD6JxhVB1Slk5csxxpW2suf/Z74th9JOLkT1f3VSVodxQuTYMDatl9zfvzXOolh6K/nBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=uzgfWQKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF539C19422;
	Tue,  6 Jan 2026 18:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1767725440;
	bh=BGJr4bLtW5UW/a277QKOKmHsnFt20Odg1H9gTtbyE1s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uzgfWQKKLTZB1dDYmXUoV0mbXXgbygdMa6q5F+JbPdi5wCqV/md1YPFhVTLmxdXWE
	 2ibS+rwuIr9LAPOSD0Q2ern1ti+UqhyzqBUy/LkEFSmDoeJvARo2crGd5UdY/cmmGx
	 kj9K0yvRMDC86cki2gcu5A8aKn+QXC71u83F6Bug=
Date: Tue, 6 Jan 2026 10:50:39 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner
 <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, Muchun
 Song <muchun.song@linux.dev>, SeongJae Park <sj@kernel.org>, Meta kernel
 team <kernel-team@meta.com>, linux-mm@kvack.org, cgroups@vger.kernel.org,
 damon@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] memcg: separate private and public ID namespaces
Message-Id: <20260106105039.6f1cdcead82934422e755ac3@linux-foundation.org>
In-Reply-To: <aVzjN5z3w114fNB4@tiehlicka>
References: <20251225232116.294540-1-shakeel.butt@linux.dev>
	<aVzjN5z3w114fNB4@tiehlicka>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Jan 2026 11:25:59 +0100 Michal Hocko <mhocko@suse.com> wrote:

> > Note: please apply this series after the patch at
> > https://lore.kernel.org/20251225002904.139543-1-shakeel.butt@linux.dev/

OK, that's in mm-hotfixes-unstable.

> Makes sense to me. Originally I was not supper happy about the private
> interface as this should be really private to memcg proper but then I
> have noticed the lru code needs this outside and dealing with that would
> be quite messy so an explicit name is probably better in the end.
> 
> Feel free to add
> Acked-by: Michal Hocko <mhocko@suse.com>

Great, thanks, I'll add it.  The series in somewhat old (Dec 25) but
nothing seems to have changed.


