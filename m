Return-Path: <cgroups+bounces-1071-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3A9823F43
	for <lists+cgroups@lfdr.de>; Thu,  4 Jan 2024 11:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A348286761
	for <lists+cgroups@lfdr.de>; Thu,  4 Jan 2024 10:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B4020B29;
	Thu,  4 Jan 2024 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kkhryevb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kkhryevb"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C5F20B02;
	Thu,  4 Jan 2024 10:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2AD2D1F7E5;
	Thu,  4 Jan 2024 10:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704362948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bND18w68yzB2SgjbqiPCCcEMkHhbzrkW11rEOW63lmg=;
	b=kkhryevbbiV0D/EU/gER1KJNG+R06H3r7PcmthuHyTwNtFIn0GCC6HkICP/Y8+g6ugOzVj
	bcwSJoHEHIBitu9DctaXEX7JpiZTb7yiupXVzMYRdd+cxiEOn4IcdBsLweKAzfPD6VMiRZ
	0HghKhYaGXDsvM5R98amuFP6ZAnROyM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704362948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bND18w68yzB2SgjbqiPCCcEMkHhbzrkW11rEOW63lmg=;
	b=kkhryevbbiV0D/EU/gER1KJNG+R06H3r7PcmthuHyTwNtFIn0GCC6HkICP/Y8+g6ugOzVj
	bcwSJoHEHIBitu9DctaXEX7JpiZTb7yiupXVzMYRdd+cxiEOn4IcdBsLweKAzfPD6VMiRZ
	0HghKhYaGXDsvM5R98amuFP6ZAnROyM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC6F5137E8;
	Thu,  4 Jan 2024 10:09:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ubvJNsODlmVvbAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 04 Jan 2024 10:09:07 +0000
Date: Thu, 4 Jan 2024 11:09:07 +0100
From: Michal Hocko <mhocko@suse.com>
To: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	Yosry Ahmed <yosryahmed@google.com>,
	David Rientjes <rientjes@google.com>, Chris Li <chrisl@kernel.org>,
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v6 2/2] mm: add swapiness= arg to memory.reclaim
Message-ID: <ZZaDw1Fak_q9BnW-@tiehlicka>
References: <20240103164841.2800183-1-schatzberg.dan@gmail.com>
 <20240103164841.2800183-3-schatzberg.dan@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103164841.2800183-3-schatzberg.dan@gmail.com>
X-Spam-Level: *******
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=kkhryevb
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLsgd6kpfonsu388crrfsk7e3y)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[20];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,google.com,kernel.org,bytedance.com,cmpxchg.org,lwn.net,linux.dev,redhat.com,infradead.org,huawei.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -1.51
X-Rspamd-Queue-Id: 2AD2D1F7E5
X-Spam-Flag: NO

On Wed 03-01-24 08:48:37, Dan Schatzberg wrote:
[...]
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index d91963e2d47f..394e0dd46b2e 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -92,6 +92,11 @@ struct scan_control {
>  	unsigned long	anon_cost;
>  	unsigned long	file_cost;
>  
> +#ifdef CONFIG_MEMCG
> +	/* Swappiness value for proactive reclaim. Always use sc_swappiness()! */
> +	int *proactive_swappiness;
> +#endif
> +
>  	/* Can active folios be deactivated as part of reclaim? */
>  #define DEACTIVATE_ANON 1
>  #define DEACTIVATE_FILE 2
> @@ -227,6 +232,13 @@ static bool writeback_throttling_sane(struct scan_control *sc)
>  #endif
>  	return false;
>  }
> +
> +static int sc_swappiness(struct scan_control *sc, struct mem_cgroup *memcg)
> +{
> +	if (sc->proactive && sc->proactive_swappiness)
> +		return *sc->proactive_swappiness;
> +	return mem_cgroup_swappiness(memcg);
> +}

If you really want to make this sc->proactive bound then do not use
CONFIG_MEMCG as sc->proactive is not guarded either.

I do not think that sc->proactive check is really necessary. A pure NULL
check is sufficient to have a valid and self evident code that is future
proof. But TBH this is not the most important aspect of the patch to
spend much more time discussing. Either go with sc->proactive but make
it config space consistent or simply rely on NULL check (with or without
MEMCG guard as both are valid options).

-- 
Michal Hocko
SUSE Labs

