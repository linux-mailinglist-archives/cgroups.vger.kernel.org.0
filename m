Return-Path: <cgroups+bounces-2084-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 356BA885979
	for <lists+cgroups@lfdr.de>; Thu, 21 Mar 2024 13:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3273282078
	for <lists+cgroups@lfdr.de>; Thu, 21 Mar 2024 12:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D64F83CCA;
	Thu, 21 Mar 2024 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eDRIT9VY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eDRIT9VY"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F541CA83;
	Thu, 21 Mar 2024 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711025911; cv=none; b=CBVV5KFt6/DmEiO71CvG4owc3W3pOFvmC/fI8xi/FEKyfTaeOYekYzHSlFb/4t3wHzOb00Q1priwyTN/4a2pX9U/SKFUumhXOD0vCGAPVpwxSmGUy8T7cQJdzkLHcB8BVo1baHQ8pZ00Z/Py2hAZ7XB8Njpu5B6o9ods1cI+300=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711025911; c=relaxed/simple;
	bh=yHzWlgMvexL/4zkbF158Iee8weCY8LouKs27+QuNRnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGnbDQCo9mjQwfd8zjuZvcDfxvsie2OTG+BjHA2zscbDN2AtInH9rVw17vhK9snoQsAgxbNnlo6EyvC0v7vc2v0UMk4M3s76D+rHgnvDKQwq3LW5S8GvNu875dLxnruH4RwoCFgrgELw/pmPPyIaHEFwjewp4Ad4a44QTfTc+Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eDRIT9VY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eDRIT9VY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6A6445CE7F;
	Thu, 21 Mar 2024 12:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1711025907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=93QxAQP5ZM16jg+U1fz+z2aWxXn55c/xIhJmz7m/Bz8=;
	b=eDRIT9VYSu02snUagXPwSm/gDgHeLUNXI+Hv85SU8wBDFoKf2XkUDe0aHfpCLsVKPaqVrn
	ELj9Xx5Yxk9fpIvLd0r8tuTMLBR/iXfi5H+xDWoeGOd/y69j0xJ+6rkIU4ZLgN0D/w14FU
	4MD7z65xI0Nq9zaDbaBzGCuWOWvt46w=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1711025907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=93QxAQP5ZM16jg+U1fz+z2aWxXn55c/xIhJmz7m/Bz8=;
	b=eDRIT9VYSu02snUagXPwSm/gDgHeLUNXI+Hv85SU8wBDFoKf2XkUDe0aHfpCLsVKPaqVrn
	ELj9Xx5Yxk9fpIvLd0r8tuTMLBR/iXfi5H+xDWoeGOd/y69j0xJ+6rkIU4ZLgN0D/w14FU
	4MD7z65xI0Nq9zaDbaBzGCuWOWvt46w=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C460136AD;
	Thu, 21 Mar 2024 12:58:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DZvkD/Mu/GXhUAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 21 Mar 2024 12:58:27 +0000
Date: Thu, 21 Mar 2024 13:58:18 +0100
From: Michal Hocko <mhocko@suse.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove CONFIG_MEMCG_KMEM
Message-ID: <Zfwu6oquhe7CSkOz@tiehlicka>
References: <20240320202745.740843-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320202745.740843-1-hannes@cmpxchg.org>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.84
X-Spamd-Result: default: False [-0.84 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.04)[57.51%]
X-Spam-Flag: NO

On Wed 20-03-24 16:27:45, Johannes Weiner wrote:
> CONFIG_MEMCG_KMEM used to be a user-visible option for whether slab
> tracking is enabled. It has been default-enabled and equivalent to
> CONFIG_MEMCG for almost a decade. We've only grown more kernel memory
> accounting sites since, and there is no imaginable cgroup usecase
> going forward that wants to track user pages but not the multitude of
> user-drivable kernel allocations.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

But this
> @@ -422,7 +422,7 @@ kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1];
>  #define KMALLOC_NOT_NORMAL_BITS					\
>  	(__GFP_RECLAIMABLE |					\
>  	(IS_ENABLED(CONFIG_ZONE_DMA)   ? __GFP_DMA : 0) |	\
> -	(IS_ENABLED(CONFIG_MEMCG_KMEM) ? __GFP_ACCOUNT : 0))
> +	(IS_ENABLED(CONFIG_KMEM) ? __GFP_ACCOUNT : 0))

seems like a typo and should be CONFIG_MEMCG, right?
-- 
Michal Hocko
SUSE Labs

