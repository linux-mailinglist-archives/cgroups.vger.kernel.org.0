Return-Path: <cgroups+bounces-4314-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED121953D28
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2024 00:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294A11C250A7
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 22:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7135E155324;
	Thu, 15 Aug 2024 22:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a0ocZodL"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFF4487BF;
	Thu, 15 Aug 2024 22:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723759701; cv=none; b=KXZAO7yscPEHuXahizJOXfKDnWnb9Bm7LhPOb4Lca8nxQJmVy1NL4+c6xY0Xi27ezwyZt6up64GlUcDLyHsX9MM9p7d38zYRmh53qX9iTvNhHlsPpA0FzH2cuq3X4fFXyDijOwIRaL+FU7d4lZGYhdxcv0cJ/c+KYyJqjPiPzJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723759701; c=relaxed/simple;
	bh=YtFXgyqpzm2Rt1zT4t38YIrkQsdF3Y09PgGCqyONOtQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EN2C802QeGtCtzk1PdRLfDsPk5QaVYj4e5mI3G5BEqnF4ZhcLf5p50QNylWkqnPmwj2fThKWcZcGzCyWcmiRA/ewQh5TGpnxWN8mEkUCphrUPCmBCujh88Z2BrhBHfJ6FnRkjMLjr3K0ZgjCqIoJ0Ie3cPRB+cq1c0xL95oxcFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=a0ocZodL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BDCC32786;
	Thu, 15 Aug 2024 22:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723759700;
	bh=YtFXgyqpzm2Rt1zT4t38YIrkQsdF3Y09PgGCqyONOtQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a0ocZodLN84n+Y0Mw/qYnMIi1sHS4o6xYxB0OYzVlM6FgkKzWtx0AuVvdl6IyiTnE
	 N2ZqguA7CKuFWbG1fWjf24rjfItaGrhKWosd6OtGQoNPELywY6Xz6tApRpn6V1ZnH6
	 KEN+IVrsrZrrC9h0XkA45y7QWQRcdnY9aFTjrMwk=
Date: Thu, 15 Aug 2024 15:08:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Mike Yuan <me@yhndnzj.com>, Yosry Ahmed <yosryahmed@google.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
 Muchun Song <muchun.song@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko
 <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm/memcontrol: respect zswap.writeback setting from
 parent cg too
Message-Id: <20240815150819.9873910fa73a3f9f5e37ef4d@linux-foundation.org>
In-Reply-To: <CAKEwX=MDZdAHei3=UyYrsgWqyt-41_vOdCvTxj35O62NZhcN2A@mail.gmail.com>
References: <20240814171800.23558-1-me@yhndnzj.com>
	<CAKEwX=NrOBg0rKJnXGaiK9-PWeUDS+c3cFmaFFV0RrE8GkNZZA@mail.gmail.com>
	<CAJD7tkZ_jNuYQsGMyS1NgMf335Gi4_x5Ybkts_=+g5OyjtJQDQ@mail.gmail.com>
	<a2f67cbcc987cdb2d907f9c133e7fcb6a848992d.camel@yhndnzj.com>
	<CAKEwX=MDZdAHei3=UyYrsgWqyt-41_vOdCvTxj35O62NZhcN2A@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 12:12:26 -0700 Nhat Pham <nphamcs@gmail.com> wrote:

> > Yeah, I thought about the other way around and reached the same
> > conclusion.
> > And there's permission boundary in the mix too - if root disables zswap
> > writeback for its cgroup, the subcgroups, which could possibly be owned
> > by other users, should not be able to reenable this.
> 
> Hmm yeah, I think I agree with your and Yosry's reasonings :) It
> doesn't affect our use case AFAICS, and the code looks solid to me,
> so:
> 
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>

But you'd still like an update to Documentation/admin-guide/cgroup-v2.rst?

