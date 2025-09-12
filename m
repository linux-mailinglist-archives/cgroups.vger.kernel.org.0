Return-Path: <cgroups+bounces-10043-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAFEB54E4E
	for <lists+cgroups@lfdr.de>; Fri, 12 Sep 2025 14:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D515F1B23ECA
	for <lists+cgroups@lfdr.de>; Fri, 12 Sep 2025 12:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9723043B6;
	Fri, 12 Sep 2025 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pi6wWXWm"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C096038FA3;
	Fri, 12 Sep 2025 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757681152; cv=none; b=lHJIa1zNpb2LjjEpGyCHaHr68cCFr9nFSmVw19Jl4jHeniuuohFy/0wWwroTDiGYFzvz6e/EhiQBMi/QtLmXXe3nzby/lL3nQD1k2sF4WXlcmB2qYJ06Ac9xvg+Gf5vraeNa1VxycOkYufCFSfzfcEydxtLRbNLkNyQ/SnO/4gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757681152; c=relaxed/simple;
	bh=lD5ROtoWeAtmKAISXqDN/6McT33HUmW9pjihJpJCvFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQwz6R3vrdin7nkHeYWwoSqL1M45EEl47ID5RjroJheyQ0byiCxxoJ9H99WzpQuvnsWiY7EF1rRCeqvco/CSMfB4SAHfiYXZtsUe3LMgD2AkL4pgCcKUsci1dNvTEcqMnEG13w0VJXENQUJlH8lPHjfrsImf/vjtJLI2BsDHdU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pi6wWXWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBCAC4CEF1;
	Fri, 12 Sep 2025 12:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757681152;
	bh=lD5ROtoWeAtmKAISXqDN/6McT33HUmW9pjihJpJCvFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pi6wWXWmQDtPgt2V60hAsaqZj1tVBkAvmTLZ+o3qpgRgmD2p03mdvdELPH70exUwF
	 WYpG8IWw43ziWv9WR/YMz+vytLSkBPhkovit7iN7uZ6iSxIKa/qfTGalJR2rxwyw7V
	 egJY3LU0VybbRWgl6Dm0NyepInCpRe3AAtOyUh9w=
Date: Fri, 12 Sep 2025 14:45:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrew Guerrero <ajgja@amazon.com>
Cc: akpm@linux-foundation.org, cgroups@vger.kernel.org, gunnarku@amazon.com,
	guro@fb.com, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	stable@vger.kernel.org, vdavydov.dev@gmail.com
Subject: Re: [PATCH] mm: memcontrol: fix memcg accounting during cpu hotplug
Message-ID: <2025091216-purveyor-prior-2a81@gregkh>
References: <2025090735-glade-paralegal-cdd1@gregkh>
 <20250908210900.24088-1-ajgja@amazon.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908210900.24088-1-ajgja@amazon.com>

On Mon, Sep 08, 2025 at 09:09:00PM +0000, Andrew Guerrero wrote:
> On 2025-09-07 13:10 UTC, Greg KH wrote:
> > On Sat, Sep 06, 2025 at 03:21:08AM +0000, Andrew Guerrero wrote:
> > > This patch is intended for the 5.10 longterm release branch. It will not apply
> > > cleanly to mainline and is inadvertantly fixed by a larger series of changes in 
> > > later release branches:
> > > a3d4c05a4474 ("mm: memcontrol: fix cpuhotplug statistics flushing").
> > 
> > Why can't we take those instead?
> > 
> > > In 5.15, the counter flushing code is completely removed. This may be another
> > > viable option here too, though it's a larger change.
> > 
> > If it's not needed anymore, why not just remove it with the upstream
> > commits as well?
> 
> Yeah, my understanding is the typical flow is to pull commits from upstream into
> stable branches. However, I'm not confident I know the the answer to "which
> upstream commits?" To get started,
> 
> `git log -L :memcg_hotplug_cpu_dead:mm/memcontrol.c linux-5.10.y..linux-5.15.y`
> 
> tells me that the upstream changes to pull are:
> 
> - https://lore.kernel.org/all/20210209163304.77088-1-hannes@cmpxchg.org/T/#u
> - https://lore.kernel.org/all/20210716212137.1391164-1-shakeelb@google.com/T/#u
> 
> However, these are substantial features that "fix" the issue indirectly by
> transitioning the memcg accounting system over to rstats. I can pick these 10
> upstream commits, but I'm worried I may overlook some additional patches from
> 5.15.y that need to go along with them. I may need some guidance if we go this
> route.

Testing is key :)

> Another reasonable option is to take neither route. We can maintain this patch
> internally and then drop it once we upgrade to a new kernel version.

Perhaps just do that for now if you all are hitting this issue?  It
seems to be the only report I've seen so far.

thanks,

greg k-h

