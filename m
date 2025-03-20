Return-Path: <cgroups+bounces-7201-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF026A6A9FC
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 16:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733F01691D0
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 15:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EB51E5B93;
	Thu, 20 Mar 2025 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ytld5BRz"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D571DC185
	for <cgroups@vger.kernel.org>; Thu, 20 Mar 2025 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484804; cv=none; b=gpXGCzHdLFaV7L+Uo7LORc3qULo1E41J4P/xK7dAOljnNpRvDxvMciVg7wRsWFEI2cVuytTA03tBQIvZGI0EAhSsktcafA3b+CTtSq/ZxgFa9zwI6nHB3ic4+3Mx1HxpH86RS4uh3SfQFrCDVH6aHDSXeQKrTEjxx631/LqX6ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484804; c=relaxed/simple;
	bh=4Jb8Mhz2k8ybbXFtrO52Rg6hq9KdXTDEauR3qG+Oq/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMnOyUvepBvf0FWPejV/AaaipbKVH9x098EaTu7vLcTXFSgjDL9FGrQwAFT42e9t8sXaTlGsGskFKvDmdaxmu+d+erysVNp+50jzvw4k6rGxpeHsqdEsEyn7XtVa6kxNwBLhGVxl5WWVcG+DIp/o8fFOPB3p7hu2gFR6COasLOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ytld5BRz; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Mar 2025 08:33:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742484796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wBWIFHFRJcaNoFMrG97otHmcDK1seyDFqXM9Jg7jnHA=;
	b=Ytld5BRzpnCKlRLYi6Gn0nRcKP8RdSrrUtdOUlnVnY8VjgE9KfoZ/QmqumX0+Nb1h0kFLy
	qIcLF2AfyZIs3Fq/UYeqbDa8q2Z/zvpBjLwTPyC58BRnph3tIsINK7Oqa0x8pKWGjqkGbl
	bNetuiMCPEwVKqCy4CK3izeDcCyw9R0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
	Jingxiang Zeng <linuszeng@tencent.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, mhocko@kernel.org, 
	muchun.song@linux.dev, kasong@tencent.com
Subject: Re: [RFC 2/5] memcontrol: add boot option to enable memsw account on
 dfl
Message-ID: <ipskzxjtm656f5srrp42uxemh5e4jdwzsyj2isqlldfaokiyoo@ly4gfvldjc2p>
References: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
 <20250319064148.774406-3-jingxiangzeng.cas@gmail.com>
 <m35wwnetfubjrgcikiia7aurhd4hkcguwqywjamxm4xnaximt7@cnscqcgwh4da>
 <7ia4tt7ovekj.fsf@castle.c.googlers.com>
 <20250320142846.GG1876369@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320142846.GG1876369@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 20, 2025 at 10:28:46AM -0400, Johannes Weiner wrote:
> On Wed, Mar 19, 2025 at 10:30:20PM +0000, Roman Gushchin wrote:
> > Shakeel Butt <shakeel.butt@linux.dev> writes:
> > 
> > > On Wed, Mar 19, 2025 at 02:41:45PM +0800, Jingxiang Zeng wrote:
> > >> From: Zeng Jingxiang <linuszeng@tencent.com>
> > >> 
> > >> Added cgroup.memsw_account_on_dfl startup parameter, which
> > >> is off by default. When enabled in cgroupv2 mode, the memory
> > >> accounting mode of swap will be reverted to cgroupv1 mode.
> > >> 
> > >> Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
> > >> ---
> > >>  include/linux/memcontrol.h |  4 +++-
> > >>  mm/memcontrol.c            | 11 +++++++++++
> > >>  2 files changed, 14 insertions(+), 1 deletion(-)
> > >> 
> > >> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > >> index dcb087ee6e8d..96f2fad1c351 100644
> > >> --- a/include/linux/memcontrol.h
> > >> +++ b/include/linux/memcontrol.h
> > >> @@ -62,10 +62,12 @@ struct mem_cgroup_reclaim_cookie {
> > >>  
> > >>  #ifdef CONFIG_MEMCG
> > >>  
> > >> +DECLARE_STATIC_KEY_FALSE(memsw_account_on_dfl);
> > >>  /* Whether enable memory+swap account in cgroupv2 */
> > >>  static inline bool do_memsw_account_on_dfl(void)
> > >>  {
> > >> -	return IS_ENABLED(CONFIG_MEMSW_ACCOUNT_ON_DFL);
> > >> +	return IS_ENABLED(CONFIG_MEMSW_ACCOUNT_ON_DFL)
> > >> +				|| static_branch_unlikely(&memsw_account_on_dfl);
> > >
> > > Why || in above condition? Shouldn't it be && ?
> > >
> > >>  }
> > >>  
> > >>  #define MEM_CGROUP_ID_SHIFT	16
> > >> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > >> index 768d6b15dbfa..c1171fb2bfd6 100644
> > >> --- a/mm/memcontrol.c
> > >> +++ b/mm/memcontrol.c
> > >> @@ -5478,3 +5478,14 @@ static int __init mem_cgroup_swap_init(void)
> > >>  subsys_initcall(mem_cgroup_swap_init);
> > >>  
> > >>  #endif /* CONFIG_SWAP */
> > >> +
> > >> +DEFINE_STATIC_KEY_FALSE(memsw_account_on_dfl);
> > >> +static int __init memsw_account_on_dfl_setup(char *s)
> > >> +{
> > >> +	if (!strcmp(s, "1"))
> > >> +		static_branch_enable(&memsw_account_on_dfl);
> > >> +	else if (!strcmp(s, "0"))
> > >> +		static_branch_disable(&memsw_account_on_dfl);
> > >> +	return 1;
> > >> +}
> > >> +__setup("cgroup.memsw_account_on_dfl=", memsw_account_on_dfl_setup);
> > >
> > > Please keep the above in memcontrol-v1.c
> > 
> > Hm, I'm not sure about this. This feature might be actually useful with
> > cgroup v2, as some companies are dependent on the old cgroup v1
> > semantics here but otherwise would prefer to move to v2.
> > In other words, I see it as a cgroup v2 feature, not as a cgroup v1.
> > So there is no reason to move it into the cgroup v1 code.
> 
> Agreed. Let's think of this proposal as making memsw tracking and
> control a full-fledged v2 feature.
> 

Sounds good. However I want us to discuss and decide the semantics of
memsw from scratch rather than adopting v1 semantics. Particularly I
don't like the failure of setting memsw limit on v1. Also we should
discuss how memsw and swap limits would interact and what would be the
appropriate default.

