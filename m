Return-Path: <cgroups+bounces-4322-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5EE95433A
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2024 09:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE261C24F8A
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2024 07:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71925136657;
	Fri, 16 Aug 2024 07:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CTaMv5/G"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D9812F375;
	Fri, 16 Aug 2024 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723794216; cv=none; b=lRonDxYUvAupQg80Z4QtGH05D4X0il7+uAYv6A7GJgJAq9wq1npvpnWPEkdtsdnAxvMzTxZ63zZAt5eSjUQg7YTz7DfXTyPFJ+YOMLFJ3mgX+dGkFIP7iDeiHKRW6YPUVA96XENHHADez/NEd2EUsyXOQCG3GSHCZAXRhIPY6uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723794216; c=relaxed/simple;
	bh=xOYM7Qklj+82wxFjdT+hTdHK52Fg8iyWGbBGNIk7KJk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fyBnYMhpCKOG3d1y+1iPxRosBxVTvsRAkLTxiPUq/VfgN6C/Du0MrPgJBZaH9tk/C70K0cH23Ox2UFuHZs6ikn7oq9QYb9crnHHqp6JJqSASxJfp98zK7f8lY9VT4GU1e0pDvJNyrZiczfuco0yyb9NcS+bZu6QVXstJMLwMPcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CTaMv5/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D08C4AF09;
	Fri, 16 Aug 2024 07:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723794215;
	bh=xOYM7Qklj+82wxFjdT+hTdHK52Fg8iyWGbBGNIk7KJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CTaMv5/GnlJvydPfHDUXcJ1C8vNskBad4fGwwS7Ugg725Q1EWNY406kVVu14oKRu2
	 jnIRrapy6DO6F3UC2cnaqYL6+aBMjO7itblpI7Km8rAg7eW1VprphCZIQrL+r63N3Z
	 vQDEFb2BP0PXk/GLQs773EaeV1W3aeeWWPQ2IM4A=
Date: Fri, 16 Aug 2024 00:43:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Matthew Wilcox <willy@infradead.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Johannes
 Weiner <hannes@cmpxchg.org>, Muchun Song <muchun.song@linux.dev>,
 "T . J . Mercier" <tjmercier@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>,
 cgroups@vger.kernel.org
Subject: Re: [PATCH v2] memcg: replace memcg ID idr with xarray
Message-Id: <20240816004334.41ce3acf52ba082399a76d88@linux-foundation.org>
In-Reply-To: <Zr79nrBAkfSdI4e5@tiehlicka>
References: <20240815155402.3630804-1-shakeel.butt@linux.dev>
	<Zr5Xn45wEJytFTl8@google.com>
	<Zr5wK7oUcUoB44OF@casper.infradead.org>
	<Zr79nrBAkfSdI4e5@tiehlicka>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 09:19:58 +0200 Michal Hocko <mhocko@suse.com> wrote:

> On Thu 15-08-24 22:16:27, Matthew Wilcox wrote:
> > On Thu, Aug 15, 2024 at 07:31:43PM +0000, Roman Gushchin wrote:
> > > There is another subtle change here: xa_alloc() returns -EBUSY in the case
> > > of the address space exhaustion, while the old code returned -ENOSPC.
> > > It's unlikely a big practical problem.
> > 
> > I decided that EBUSY was the right errno for this situation;
> > 
> > #define EBUSY           16      /* Device or resource busy */
> > #define ENOSPC          28      /* No space left on device */
> > 
> > ENOSPC seemed wrong; the device isn't out of space.
> 
> The thing is that this is observable by userspace - mkdir would return a
> different and potentially unexpected errno. We can try and see whether
> anybody complains or just translate the error.

The mkdir(2) manpage doesn't list EBUSY.  Maybe ENOMEM is close enough.

