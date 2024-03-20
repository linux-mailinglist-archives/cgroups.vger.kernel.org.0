Return-Path: <cgroups+bounces-2071-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E56880FD3
	for <lists+cgroups@lfdr.de>; Wed, 20 Mar 2024 11:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A5EDB242B6
	for <lists+cgroups@lfdr.de>; Wed, 20 Mar 2024 10:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220BD3FE44;
	Wed, 20 Mar 2024 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pgcv9NHD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pgcv9NHD"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4A83C08F;
	Wed, 20 Mar 2024 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930530; cv=none; b=gQ3jI39tOfCtqUv1jUGIjUSDsj6EyGMcrU9sGEVIzeytXq57rt30KA6Sr8FhE+oSLZeZi0MG+KgAtA7dLwiHjdGTx34ATtbJl28BB/jBZNqPhNijK+IE0DlD6TKLAxD80RqhgDi00rMu5e9I78Hh4McL0+q23JAMmieTQCHS7f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930530; c=relaxed/simple;
	bh=xxIEdTnasZgNTkdCtFzo5Tk7qlLmnwHb0r66ABM2Ybs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iO7T6iaEIlH0zLCwg3FVeFT17KkG2PRtOvcKSMWALx3elrum/yW4bkXA0DfTXUD1bbx8LbRaaTXK3dq5+P2B5kTeFwI+hfLBFghCBja/4qhHXPDe5aXwOsPrT8h3529Df3fexVkQGS6hOGAI8zlKXH17twpJxP3AMsYa0pecQUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pgcv9NHD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pgcv9NHD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B9C4420CBA;
	Wed, 20 Mar 2024 10:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710930526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uacu9M9JHXgrGZx8T4ZnA5/jeWUYi98hCKExLdiTswE=;
	b=pgcv9NHDcsId4tPYUG4FIFTciGb+EEh9RedFqboNkGDN3oZfX4O17F7vUr+Exr73PvO/3A
	YmiL9RnZSW5VqiIzHnLrbgaB7hYzXcH91Y4ilWlXDeBtRLyzHyR8/+JwmgJqWjo82PWrDq
	tRq6H9CaowL2kWy+J1K82ZKXMK8a0DA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710930526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uacu9M9JHXgrGZx8T4ZnA5/jeWUYi98hCKExLdiTswE=;
	b=pgcv9NHDcsId4tPYUG4FIFTciGb+EEh9RedFqboNkGDN3oZfX4O17F7vUr+Exr73PvO/3A
	YmiL9RnZSW5VqiIzHnLrbgaB7hYzXcH91Y4ilWlXDeBtRLyzHyR8/+JwmgJqWjo82PWrDq
	tRq6H9CaowL2kWy+J1K82ZKXMK8a0DA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BA68136D6;
	Wed, 20 Mar 2024 10:28:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TYuMI166+mW1agAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 20 Mar 2024 10:28:46 +0000
Date: Wed, 20 Mar 2024 11:28:45 +0100
From: Michal Hocko <mhocko@suse.com>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vladimir Davydov <vdavydov.dev@gmail.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH] mm/memcontrol: stop resize loop if limit was changed
 again
Message-ID: <Zfq6XaACmN2JssTW@tiehlicka>
References: <20240320100556.463266-1-ptikhomirov@virtuozzo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320100556.463266-1-ptikhomirov@virtuozzo.com>
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=pgcv9NHD
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.48 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.01)[45.04%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[cmpxchg.org,linux.dev,linux-foundation.org,gmail.com,vger.kernel.org,kvack.org,openvz.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 0.48
X-Rspamd-Queue-Id: B9C4420CBA
X-Spam-Flag: NO

On Wed 20-03-24 18:03:30, Pavel Tikhomirov wrote:
> In memory_max_write() we first set memcg->memory.max and only then
> try to enforce it in loop. What if while we are in loop someone else
> have changed memcg->memory.max but we are still trying to enforce
> the old value? I believe this can lead to nasty consequence like getting
> an oom on perfectly fine cgroup within it's limits or excess reclaim.

I would argue that uncoordinated hard limit configuration can cause
problems on their own. Beside how is this any different from changing
the high limit while we are inside the reclaim loop?

> We also have exactly the same thing in memory_high_write().
> 
> So let's stop enforcing old limits if we already have a new ones.

I do see any reasons why this would be harmful I just do not see why
this is a real thing or why the new behavior is any better for racing
updaters as those are not deterministic anyway. If you have any actual
usecase then more details would really help to justify this change.

The existing behavior makes some sense as it enforces the given limit
deterministically.

> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> ---
>  mm/memcontrol.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 61932c9215e7..81b303728491 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6769,6 +6769,9 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>  		unsigned long nr_pages = page_counter_read(&memcg->memory);
>  		unsigned long reclaimed;
>  
> +		if (memcg->memory.high != high)
> +			break;
> +
>  		if (nr_pages <= high)
>  			break;
>  
> @@ -6817,6 +6820,9 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
>  	for (;;) {
>  		unsigned long nr_pages = page_counter_read(&memcg->memory);
>  
> +		if (memcg->memory.max != max)
> +			break;
> +
>  		if (nr_pages <= max)
>  			break;
>  
> -- 
> 2.43.0

-- 
Michal Hocko
SUSE Labs

