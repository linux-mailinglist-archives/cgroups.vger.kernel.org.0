Return-Path: <cgroups+bounces-1719-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C5C85D1B6
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 08:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77513B24987
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 07:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A193B18A;
	Wed, 21 Feb 2024 07:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SrlViTr/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SrlViTr/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A964C3A1C2
	for <cgroups@vger.kernel.org>; Wed, 21 Feb 2024 07:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708501736; cv=none; b=aNio2yCVuEMHvZgOFTx1DjB2zGL57fEL0y+cFCn0euWvSWElC5ZAGa9xnV0wpgn76aVqk6q4e2aQR2oVtK6DURpCPMou8/dCY1o4slOrX0FFY9Mq7gegWKtWhOCfn9/75k37PbjF/Pc4jaKkLaFrpR5ukR22dWTIxrsO/+wRubQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708501736; c=relaxed/simple;
	bh=iWYgXHrQeOMYngex9iGgDaxslzMkVNo1v+9MYs0lxhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3Q0+2VSD9Un6Bchc1bkhXxbjRE467+tD2BRNG5JVYCrqnLiQL2cmWwYIYBSY9p+cUTLY+6jbe90XtFe6OtXVOJ2YUjTz9DpuV0/pmCe7PMHMNby2CWlzjLGwwl5lBEC0bNvXw3KWRfHj6NRpZjKoGoXm5T1UIbvITPdAbS2FyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SrlViTr/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SrlViTr/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CF7812208B;
	Wed, 21 Feb 2024 07:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708501732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IRbu95ndc5Q/k1aKpotHjrytQ9wAORSBPZnVG4BEI2M=;
	b=SrlViTr/C5TBZl7o+JwS33u9jVycvM3LjkdsrOAYDiVrHQnebyHHBzBlIa+e+FzWaUUx5b
	4ZwgBGIVATpHu4p7TlT0+Mw87OW/CBoxb20tZifCP/fKD8LWqpg+S/U5y0Hhp/mBZGNJQs
	gNAiD7l+pmpOAIm1tTkQdUgtgBTHjyE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708501732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IRbu95ndc5Q/k1aKpotHjrytQ9wAORSBPZnVG4BEI2M=;
	b=SrlViTr/C5TBZl7o+JwS33u9jVycvM3LjkdsrOAYDiVrHQnebyHHBzBlIa+e+FzWaUUx5b
	4ZwgBGIVATpHu4p7TlT0+Mw87OW/CBoxb20tZifCP/fKD8LWqpg+S/U5y0Hhp/mBZGNJQs
	gNAiD7l+pmpOAIm1tTkQdUgtgBTHjyE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AEEF413A69;
	Wed, 21 Feb 2024 07:48:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bf/4J+Sq1WWOHQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 21 Feb 2024 07:48:52 +0000
Date: Wed, 21 Feb 2024 08:48:48 +0100
From: Michal Hocko <mhocko@suse.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/4] Convert memcontrol charge moving to use folios
Message-ID: <ZdWq4K2O9Lpk7SBo@tiehlicka>
References: <20240111181219.3462852-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111181219.3462852-1-willy@infradead.org>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[25.85%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.40

Hi,

On Thu 11-01-24 18:12:15, Matthew Wilcox wrote:
> No part of these patches should change behaviour; all the called functions
> already convert from page to folio, so this ought to simply be a reduction
> in the number of calls to compound_head().
> 
> Matthew Wilcox (Oracle) (4):
>   memcg: Convert mem_cgroup_move_charge_pte_range() to use a folio
>   memcg: Return the folio in union mc_target
>   memcg: Use a folio in get_mctgt_type
>   memcg: Use a folio in get_mctgt_type_thp
> 
>  mm/memcontrol.c | 88 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 46 insertions(+), 42 deletions(-)

sorry, I have missed this before. Thanks for the conversion, all seem
fine. The code is rarely executed because it is not enabled by cgroup
v2. But I do agree that it nicer that it fits to the new folio scheme
after these patches.

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
-- 
Michal Hocko
SUSE Labs

