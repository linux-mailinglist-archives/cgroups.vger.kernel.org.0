Return-Path: <cgroups+bounces-6176-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C07A1305F
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 01:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5FC1887F37
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 00:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6D712E7F;
	Thu, 16 Jan 2025 00:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QwAGSlcN"
X-Original-To: cgroups@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56771CF96
	for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 00:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736989069; cv=none; b=IJOiXwMHdOEweQxLeHx0hRa/wLKu5CSPEdNCLtMh5J5ukwD8zMwpFPOUOwCB2KMfyKBCOFgsg5jfgePBNSWxoLHrnnk2WrSrNUvmAT5sWwHOTjO4NDRWrixRl/JTG42RjQHjNHAn73NVQ73C9+kSE2+iTFfow34T+8vXwO6L8qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736989069; c=relaxed/simple;
	bh=m9scXufIq3UYJYZ2i6+U9pMLGVov9XZjunxoTKrX8cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpwZg6X1zlKsBzFmQ/rcfY2faF2QyRlSs2yh4X9/Jqy3mXc8X1C9Ulmk+wqdlYCBpqacoO1jPZUdcFNvw4hbp0aa2yRsAdDarcyOqwyix0SvaZrJjWR0YFBdYkP5P9vRkXpzFQT325XXbPKmrxD917m1ovVHp8tdeYumVvAqMPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QwAGSlcN; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 15 Jan 2025 16:57:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736989060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pAAEiGYmJObwoT1canIZx0/wo2Cdb23cKDo/iWmlemA=;
	b=QwAGSlcNh4JHPhRyAlQ6iKgSGGIjllgqQ5Dll+ZEKSHk4KddO6wY+k1jYeX7KKO0t92KYQ
	vHICkakMH9Bo3sq8vzq1WM1PSHr3bopwWnJsASWZYOaumhCkVgupME8B6vO8CbVVwgTeuS
	VyHTxUAScc9ai1PDDoAEtcs7T4GS2q8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Chen Ridong <chenridong@huaweicloud.com>, akpm@linux-foundation.org, 
	mhocko@kernel.org, hannes@cmpxchg.org, yosryahmed@google.com, muchun.song@linux.dev, 
	davidf@vimeo.com, vbabka@suse.cz, mkoutny@suse.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, chenridong@huawei.com, 
	wangweiyang2@huawei.com
Subject: Re: [PATCH -v2 next 4/4] memcg: factor out
 stat(event)/stat_local(event_local) reading functions
Message-ID: <csuymdtyrj2tch2m4lhn5hz5aeojhzvixepxydvphvawqsn5ky@dx4o25o4wzlw>
References: <20250114122519.1404275-1-chenridong@huaweicloud.com>
 <20250114122519.1404275-5-chenridong@huaweicloud.com>
 <Z4awwH3cbhjl0H4W@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4awwH3cbhjl0H4W@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jan 14, 2025 at 06:45:20PM +0000, Roman Gushchin wrote:
> On Tue, Jan 14, 2025 at 12:25:19PM +0000, Chen Ridong wrote:
> > From: Chen Ridong <chenridong@huawei.com>
> > 
> > The only difference between 'lruvec_page_state' and
> > 'lruvec_page_state_local' is that they read 'state' and 'state_local',
> > respectively. Factor out an inner functions to make the code more concise.
> > Do the same for reading 'memcg_page_stat' and 'memcg_events'.
> > 
> > Signed-off-by: Chen Ridong <chenridong@huawei.com>
> > ---
> >  mm/memcontrol.c | 72 +++++++++++++++++++++----------------------------
> >  1 file changed, 30 insertions(+), 42 deletions(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index b10e0a8f3375..14541610cad0 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -375,7 +375,8 @@ struct lruvec_stats {
> >  	long state_pending[NR_MEMCG_NODE_STAT_ITEMS];
> >  };
> >  
> > -unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx)
> > +static unsigned long __lruvec_page_state(struct lruvec *lruvec,
> > +		enum node_stat_item idx, bool local)
> >  {
> >  	struct mem_cgroup_per_node *pn;
> >  	long x;
> > @@ -389,7 +390,8 @@ unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx)
> >  		return 0;
> >  
> >  	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> > -	x = READ_ONCE(pn->lruvec_stats->state[i]);
> > +	x = local ? READ_ONCE(pn->lruvec_stats->state_local[i]) :
> > +		    READ_ONCE(pn->lruvec_stats->state[i]);
> >  #ifdef CONFIG_SMP
> >  	if (x < 0)
> >  		x = 0;
> > @@ -397,27 +399,16 @@ unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx)
> >  	return x;
> >  }
> >  
> > +
> > +unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx)
> > +{
> > +	return __lruvec_page_state(lruvec, idx, false);
> > +}
> 
> I'd move these wrapper function definitions to memcontrol.h and make them
> static inline.

+1

> 
> Other than that, lgtm.
> 
> Thank you!

