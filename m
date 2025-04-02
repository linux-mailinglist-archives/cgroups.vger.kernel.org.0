Return-Path: <cgroups+bounces-7300-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB0EA79297
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 18:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4BE3170DC6
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 16:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B998714BFA2;
	Wed,  2 Apr 2025 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SnUqiwNG"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EFF288DA
	for <cgroups@vger.kernel.org>; Wed,  2 Apr 2025 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743609733; cv=none; b=jdZLtFN/nLvtA3NJ/qkV58uKvcQne9YuXpPkHB/33R9OwUB4djo2jhYZpNHvdSPMLuCedvd3bfoNztGrDkdc25zWIq4Clqrvpu0E3eUxPe0F7IxX15I3mH/PnISzMmL7lpQBMfiiII2W4MYmVPgPIFa2N4wfLZ6KJV1XT6i8uVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743609733; c=relaxed/simple;
	bh=g+ItB0TOGMldp9DtR2kf9cNdmDO55ZBo5GikKFTiLGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Asz6xR6+PZkWY7P7jTDUmcVJk83zPbyxIiX7xCHvqWExQ5CzffNB9A1axshL7Xd+6H4ak7H3RcWZfcIKQ+jyQm7zgid+Iadt9NVjVobsQ9KURMJJjvy7MffbsXYRyrd5A64bjVEOFQx/eqDeYVtsXoTS8S8MHjBEh6X6OVRCWZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SnUqiwNG; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 2 Apr 2025 09:01:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743609728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/JiTnDWrOw4/ephyEm9Qze5QTOtw1WA47YfgoERGCeA=;
	b=SnUqiwNGh8mEp8ceCSuVJqNu6sO0Sw4G9JaSpakl7cQAZJM3BZMT6mRqHG3ILl3ZKWK2kO
	cHA9LGYybdOoavHgbF4TcT/2xVIblc9mhuPlxfYJrqTe+715TeVlzDjMMqepR/rs+Ji5W5
	sKgfwIvF8stwhl2Ji7JItS0mRw3utdU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Rik van Riel <riel@surriel.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	cgroups mailinglist <cgroups@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] memcg, oom: do not bypass oom killer for dying tasks
Message-ID: <q6ianzrub4plkvyhxqxy5zoqdweamccvvndnnsbfz3qho3ti2b@gmqmnuq2g6wh>
References: <20250402090117.130245-1-mhocko@kernel.org>
 <20250402152715.GA198651@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402152715.GA198651@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 02, 2025 at 11:27:15AM -0400, Johannes Weiner wrote:
> On Wed, Apr 02, 2025 at 11:01:17AM +0200, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > 7775face2079 ("memcg: killed threads should not invoke memcg OOM killer") has added
> > a bypass of the oom killer path for dying threads because a very
> > specific workload (described in the changelog) could hit "no killable
> > tasks" path. This itself is not fatal condition but it could be annoying
> > if this was a common case.
> > 
> > On the other hand the bypass has some issues on its own. Without
> > triggering oom killer we won't be able to trigger async oom reclaim
> > (oom_reaper) which can operate on killed tasks as well as long as they
> > still have their mm available. This could be the case during futex
> > cleanup when the memory as pointed out by Johannes in [1]. The said case
> > is still not fully understood but let's drop this bypass that was mostly
> > driven by an artificial workload and allow dying tasks to go into oom
> > path. This will make the code easier to reason about and also help
> > corner cases where oom_reaper could help to release memory.
> > 
> > [1] https://lore.kernel.org/all/20241212183012.GB1026@cmpxchg.org/T/#u
> > 
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> 
> Thanks, yeah, the investigation stalled out over the new years break
> and then... distractions.
> 
> I think we'll eventually still need the second part of [2], to force
> charge from dying OOM victims, but let's go with this for now.

Agreed.

> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> [2] https://lore.kernel.org/all/20241212183012.GB1026@cmpxchg.org/
> 

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

