Return-Path: <cgroups+bounces-3160-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0942C904730
	for <lists+cgroups@lfdr.de>; Wed, 12 Jun 2024 00:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8950EB21054
	for <lists+cgroups@lfdr.de>; Tue, 11 Jun 2024 22:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071AF1553B4;
	Tue, 11 Jun 2024 22:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ApdRJOQk"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F370B15445B
	for <cgroups@vger.kernel.org>; Tue, 11 Jun 2024 22:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718146256; cv=none; b=YE7EUQ2tK0ljSCWhjl4YJPEyeXsHB8RCwD7uhOXpa8WymUHTvjSDrI/KkA6IRIJvyOcMX9jo8EzMFyTeSaf1KbSpg4dsyY0FHO9aJ4RUpoY0DzPDEuug/moCKxBAQykLqCCLhO+WZ9Vx1k19i6YEcTHpQaqqZyO8S0bY09BJ6Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718146256; c=relaxed/simple;
	bh=Pq0kyvm/75O+gyJfb1qsshv+qehE6EtN2YIGMYBgmAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwrTgVbGsCny46IWWGDeVVGXKB15p8lEjrw9SwwtrB746piZP68o3AdPb6hK60BKgfSwyKBAu8GcCSNzCcW6hUzBDiOV2preU8bT2d3BRk61O07yEmaw+0esZsBWijKLPMdgfMmTvxP2ojhM3ZpGTKIVCScDjHom2jW1Dy0PqLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ApdRJOQk; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718146252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vSEzSkqup/knOirtJlTJESJGXCDzeS2QJ+7TZgH0574=;
	b=ApdRJOQkF3Lfj/bQNCTde5c8qnGdYtrCVSjBT6SS4UnLYI40cEhhKCHwwQgs0+ajxd1Li/
	jnKD/prj8jqkd2digm5PBwJiEcjWMYna02eCHPV9ByL2RE3hLMKtQPgAkVYnElhGaF9Hh8
	vUoJCIDu+j7ypf/wRZv46Op7dT1UCK4=
X-Envelope-To: yuzhao@google.com
X-Envelope-To: findns94@gmail.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: tj@kernel.org
X-Envelope-To: lizefan.x@bytedance.com
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: corbet@lwn.net
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: shakeelb@google.com
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: david@redhat.com
X-Envelope-To: chrisl@kernel.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: wangkefeng.wang@huawei.com
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: hughd@google.com
X-Envelope-To: schatzberg.dan@gmail.com
X-Envelope-To: yuzhao@google.com
Date: Tue, 11 Jun 2024 15:50:45 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>, Yu Zhao <yuzhao@google.com>
Cc: Yue Zhao <findns94@gmail.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Chris Li <chrisl@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Hugh Dickins <hughd@google.com>, Dan Schatzberg <schatzberg.dan@gmail.com>, 
	Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v6 0/2] Add swappiness argument to memory.reclaim
Message-ID: <mpshgxmd3c3gpxltlvquw7zvhq5rvukcws55yo7womgogjxu7q@4p7dr66ctwxh>
References: <20240103164841.2800183-1-schatzberg.dan@gmail.com>
 <htpurelstaqpswf5nkhtttm3vtbvga7qazs2estwzf2srmg65x@banbo2c5ewzw>
 <20240611124807.aedaa473507150bd65e63426@linux-foundation.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611124807.aedaa473507150bd65e63426@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 11, 2024 at 12:48:07PM GMT, Andrew Morton wrote:
> On Tue, 11 Jun 2024 12:25:24 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> > Hi folks,
> > 
> > This series has been in the mm-unstable for several months. Are there
> > any remaining concerns here otherwise can we please put this in the
> > mm-stable branch to be merged in the next Linux release?
> 
> The review didn't go terribly well so I parked the series awaiting more
> clarity.  Although on rereading, it seems that Yu Zhao isn't seeing any
> blocking issues?
> 

Yu, please share if you have any strong concern in merging this series?

