Return-Path: <cgroups+bounces-1131-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 263DA82C43D
	for <lists+cgroups@lfdr.de>; Fri, 12 Jan 2024 18:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B922B1F24985
	for <lists+cgroups@lfdr.de>; Fri, 12 Jan 2024 17:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FD55683;
	Fri, 12 Jan 2024 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CzJmzX9u";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CzJmzX9u"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1311B5A5;
	Fri, 12 Jan 2024 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 242151F396;
	Fri, 12 Jan 2024 17:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705079200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J9TtdXtQR+ltHvURBV7RXOVWC44VVGVh8yNJ9YJwFIw=;
	b=CzJmzX9u/E6mMsRugcI6NK+0u8PnDPix0v9Q/Rj9A8iPbOT0dNbc6jqgkpKGS4zmknQo6Y
	nIqjvMm6yUu7OqvNEShPQ9pXBdcSSFJug7d5GEvNFQ38jwbAZZn+TEs+VcHT4RSYo93MS1
	eTper5Sk6OKwn1MnaARO0/lLWHv0xW0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705079200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J9TtdXtQR+ltHvURBV7RXOVWC44VVGVh8yNJ9YJwFIw=;
	b=CzJmzX9u/E6mMsRugcI6NK+0u8PnDPix0v9Q/Rj9A8iPbOT0dNbc6jqgkpKGS4zmknQo6Y
	nIqjvMm6yUu7OqvNEShPQ9pXBdcSSFJug7d5GEvNFQ38jwbAZZn+TEs+VcHT4RSYo93MS1
	eTper5Sk6OKwn1MnaARO0/lLWHv0xW0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB05013782;
	Fri, 12 Jan 2024 17:06:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f6NVNp9xoWUGNAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 12 Jan 2024 17:06:39 +0000
Date: Fri, 12 Jan 2024 18:06:39 +0100
From: Michal Hocko <mhocko@suse.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <schatzberg.dan@gmail.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: don't throttle dying tasks on memory.high
Message-ID: <ZaFxn7JC8FeR-Si0@tiehlicka>
References: <20240111132902.389862-1-hannes@cmpxchg.org>
 <ZaAsbwFP-ttYNwIe@P9FQF9L96D>
 <20240111192807.GA424308@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111192807.GA424308@cmpxchg.org>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.29
X-Spamd-Result: default: False [-0.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.99)[87.09%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux.dev,linux-foundation.org,google.com,kernel.org,gmail.com,vger.kernel.org,kvack.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Thu 11-01-24 14:28:07, Johannes Weiner wrote:
[...]
> @@ -2867,11 +2882,17 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  		}
>  	} while ((memcg = parent_mem_cgroup(memcg)));
>  
> +	/*
> +	 * Reclaim is set up above to be called from the userland
> +	 * return path. But also attempt synchronous reclaim to avoid
> +	 * excessive overrun while the task is still inside the
> +	 * kernel. If this is successful, the return path will see it
> +	 * when it rechecks the overage and simply bail out.
> +	 */
>  	if (current->memcg_nr_pages_over_high > MEMCG_CHARGE_BATCH &&
>  	    !(current->flags & PF_MEMALLOC) &&
> -	    gfpflags_allow_blocking(gfp_mask)) {
> +	    gfpflags_allow_blocking(gfp_mask))
>  		mem_cgroup_handle_over_high(gfp_mask);

Have you lost the check for the dying task here?

Other than that looks good to me.
-- 
Michal Hocko
SUSE Labs

