Return-Path: <cgroups+bounces-402-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4D87EAEAC
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 12:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C2E5B20AA0
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 11:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA51A224D4;
	Tue, 14 Nov 2023 11:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mFbVnbw1"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549EF224D3
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 11:14:40 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6493212C;
	Tue, 14 Nov 2023 03:14:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 134DD21898;
	Tue, 14 Nov 2023 11:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1699960477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XDqzWLx2K+JvK/ZPpwmsrJYyQOBFyyUyoFsG3is7Iq8=;
	b=mFbVnbw19yBLSGNX3rYmkMYGhAiCndHWSWr7B5HTniuoNjZSaTzjaKQqYG4c1XCEVXFCS0
	vjAkEPCobTE0w89xorZjRJk6yNd9lc2/TtQASS++HnibQxY0g6sRgGsU9eCfFS0h3+sMmP
	Af7AEkldSerwYs4dAk0WuFYxiiodvNM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D79A813460;
	Tue, 14 Nov 2023 11:14:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id sEGsMZxWU2UERQAAMHmgww
	(envelope-from <mhocko@suse.com>); Tue, 14 Nov 2023 11:14:36 +0000
Date: Tue, 14 Nov 2023 12:14:36 +0100
From: Michal Hocko <mhocko@suse.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Kees Cook <keescook@chromium.org>, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH 04/20] mm/memcontrol: remove CONFIG_SLAB #ifdef guards
Message-ID: <ZVNWnPYHXpQjCDZ3@tiehlicka>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-26-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-26-vbabka@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.97
X-Spamd-Result: default: False [-1.97 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_SPAM(0.13)[63.14%];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[google.com,linux.com,kernel.org,lge.com,linux-foundation.org,gmail.com,linux.dev,kvack.org,vger.kernel.org,lists.linux.dev,arm.com,cmpxchg.org,chromium.org,googlegroups.com];
	 RCVD_COUNT_TWO(0.00)[2];
	 SUSPICIOUS_RECIPS(1.50)[]

On Mon 13-11-23 20:13:45, Vlastimil Babka wrote:
> With SLAB removed, these are never true anymore so we can clean up.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 774bd6e21e27..947fb50eba31 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5149,7 +5149,7 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
>  	return ret;
>  }
>  
> -#if defined(CONFIG_MEMCG_KMEM) && (defined(CONFIG_SLAB) || defined(CONFIG_SLUB_DEBUG))
> +#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_SLUB_DEBUG)
>  static int mem_cgroup_slab_show(struct seq_file *m, void *p)
>  {
>  	/*
> @@ -5258,8 +5258,7 @@ static struct cftype mem_cgroup_legacy_files[] = {
>  		.write = mem_cgroup_reset,
>  		.read_u64 = mem_cgroup_read_u64,
>  	},
> -#if defined(CONFIG_MEMCG_KMEM) && \
> -	(defined(CONFIG_SLAB) || defined(CONFIG_SLUB_DEBUG))
> +#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_SLUB_DEBUG)
>  	{
>  		.name = "kmem.slabinfo",
>  		.seq_show = mem_cgroup_slab_show,
> -- 
> 2.42.1

-- 
Michal Hocko
SUSE Labs

