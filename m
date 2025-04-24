Return-Path: <cgroups+bounces-7813-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 280BBA9BB06
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 01:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5EB79A27BA
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 23:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B196A21FF2C;
	Thu, 24 Apr 2025 23:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U8qVdmDT"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217F21AA1F4
	for <cgroups@vger.kernel.org>; Thu, 24 Apr 2025 23:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745535645; cv=none; b=iQkX+P8VdmrH621shX3Ewu0TWse6+TAZn1e2ClP8EcsQQ9hr8+oV47MxOJSbW800HTOO6y1l1oB4/Pf4MDOlsaBPuLDyPfbuf2u/YgkTy0Wb2K/CRqrA3gOo7+ats/T1vV0MKxijD0DiTaBYcuSXYqGuqHEOy/64QevFABmljrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745535645; c=relaxed/simple;
	bh=hRUUYUg4bUCUj7FTfA50KwIVcNDhWjCmulZ/4J1T2lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLO/XBO+PRnVZ8n7PYf3wh7M2svkVOc6SxRu1YFiY4MdWY40NVEKF7uqePhQ382hU6WTtN5ewT9g7WUcWM4qHpZ1VwF7CiyV42ENVvmVDS+XlNqw6rl43QepFb3xVeGCdBSuRcuqiVtKAWyp02KqAdIE9IOPBLxNdEIDVsim2ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U8qVdmDT; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 24 Apr 2025 16:00:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745535638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RJVvQHLAm1I3auOzUVRa8UOMSKBiN+sklpD1+b2kdV4=;
	b=U8qVdmDTnXgyPjaOJj2SSPNteNgcAnqAj8hRfxofzZKxdBuOckUnzbmlqjFQihRGxq4/cp
	Z1JKuS2dF/qW6IhLHo6SsRT5jdTGSuwGSTHrcDvnvh+u+wHBx8mSIB2vQyn0uG7R/UqMI6
	liq8C4bc/gCXL9ESX4+eiIFqNtHnGGo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Huan Yang <link@vivo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Francesco Valla <francesco@valla.it>, 
	Huang Shijie <shijie@os.amperecomputing.com>, KP Singh <kpsingh@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, Guo Weikang <guoweikang.kernel@gmail.com>, 
	Raul E Rangel <rrangel@chromium.org>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Paul Moore <paul@paul-moore.com>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, opensource.kernel@vivo.com
Subject: Re: [PATCH v2 3/3] mm/memcg: introduce mem_cgroup_early_init
Message-ID: <lkumupd7gkzcui2wzssz4tzrw3cchta67onxnykxjldssmfnei@54mlc5fn3brk>
References: <20250424120937.96164-1-link@vivo.com>
 <20250424120937.96164-4-link@vivo.com>
 <2u4vpqa6do7tgtukqb7orgxmlixguexsxilhnsiwv7atssnht4@o4cwziz26wrs>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2u4vpqa6do7tgtukqb7orgxmlixguexsxilhnsiwv7atssnht4@o4cwziz26wrs>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 24, 2025 at 09:00:01AM -0700, Shakeel Butt wrote:
> On Thu, Apr 24, 2025 at 08:09:29PM +0800, Huan Yang wrote:
> > When cgroup_init() creates root_mem_cgroup through css_online callback,
> > some critical resources might not be fully initialized, forcing later
> > operations to perform conditional checks for resource availability.
> > 
> > This patch introduces mem_cgroup_early_init() to address the init order,
> > it invoke before cgroup_init, so, compare mem_cgroup_init which invoked
> > by initcall, mem_cgroup_early_init can use to prepare some key resources
> > before root_mem_cgroup alloc.
> > 
> > Signed-off-by: Huan Yang <link@vivo.com>
> > Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Please move this patch as the first patch of the series and also remove
> the "early" from the function name as it has a different meaning in the
> context of cgroup init. Something like either memcg_init() or
> memcg_kmem_caches_init().

BTW I think just putting this kmem cache creation in mem_cgroup_init()
and explicitly calling it before cgroup_init() would be fine. In that
case there would be a single memcg init function.

