Return-Path: <cgroups+bounces-969-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E0C815891
	for <lists+cgroups@lfdr.de>; Sat, 16 Dec 2023 10:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA1D1F25A22
	for <lists+cgroups@lfdr.de>; Sat, 16 Dec 2023 09:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DCF14291;
	Sat, 16 Dec 2023 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="pAbTiIRE"
X-Original-To: cgroups@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CCE13ACA
	for <cgroups@vger.kernel.org>; Sat, 16 Dec 2023 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4Ssgz65dcdzDqM4;
	Sat, 16 Dec 2023 09:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1702719570; bh=nX71/Bk+1gCmO8q2up8c+yLNSVk3hfpJKxRQxt684XA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pAbTiIRE7d7W0GlvSqQ0vB6KLJd39Oo4ctmkr0TEEVcCAEXv66x5Kye1/bCmvZHEM
	 2pcyzyaSztCegm4sCOUciC1vKHFH6VuEwlubmatRHaLSzqk8DOtd7VYjGhA2ZnLX3X
	 ZTgNzxPlnJWDRfmF2FdF45CeMpqESCiRCM3tNaE8=
X-Riseup-User-ID: 167AA9AA7492077BA3AC2819434F35829004FA977D1DDE28811C60B2370BDBC7
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4Ssgz45dXZzJq6R;
	Sat, 16 Dec 2023 09:39:28 +0000 (UTC)
Date: Sat, 16 Dec 2023 09:39:26 +0000
From: donoban <donoban@riseup.net>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org
Subject: Re: EOPNOTSUPP while trying to enable memory on
 cgroup.subtree_control
Message-ID: <n3x2las2haaqhjwhnwje4j4qaqsofioegqptic3x747zwnp6ym@i5jpplof5uan>
References: <rare3lakkfrp7lkcfosuhivot6vuwuuwkgj74bbzmsjjpgwkt7@udo2e6layb3d>
 <6alnige6ue22honr2a5a3k255ikvosanp2f4za3musgseadzki@6alspejj3hvp>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6alnige6ue22honr2a5a3k255ikvosanp2f4za3musgseadzki@6alspejj3hvp>

On Thu, Dec 07, 2023 at 05:37:06PM +0100, Michal Koutný wrote:
> Hello.
> 
> It does. Memory controller cannot be passed down to a threaded subtree (i.e. you
> only get memcg for the whole `docker` subtree) because memory controller
> is not threaded (e.g. two threads that share memory space but could be
> in two different cgroups make no sense for such a controller).
> 
> > Any clue? Is there some bug here or could be some problem with kernel
> > build/config?
> 
> And why your cgroup subtree is threaded? I suspect because of some
> threaded controllers were passed down [1] the tree while there are also some
> internal node processes (see cgroups(7) paragraph beginning with: "The
> second way of creating a threaded subtree").
> 
> To get out of this, your docker(?) needs to migrate all processes down
> from `docker` cgroup before enabling the memory controller.
> 

Hi!

Thanks for the reply and excuse me the delay, all that I investigated
seemed correctly so I was still thinking that there was something wrong
in the kernel....

But finally the problem is not docker, is openrc who creates initially
'/sys/fs/cgroup/docker'. Avoiding that both openrc and docker use the
same path fixes the problem.

