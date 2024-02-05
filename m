Return-Path: <cgroups+bounces-1343-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CDD8497E6
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 11:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE962868A3
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 10:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9251755E;
	Mon,  5 Feb 2024 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RXedL9vU";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RXedL9vU"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9294F17581;
	Mon,  5 Feb 2024 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707129647; cv=none; b=CNhLtXEtBe/pkWStFjqm889j42TGa7QenbFlZwTs7NKPPXP3pWxxswpjaP+YrxITnf/TFBmgGwkDW+AQ62dESB+EtWx4pT7CKNXkM3JEgnXReCJBVPylqAE5zNonB3Qq9K7sLVlFNW5DeI7P5VEspP24lrnuygaieNe0TnyMYag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707129647; c=relaxed/simple;
	bh=9YZSEeWXeoLQgpLT/zkhzH4CoQDzzd4C+BWVfb1NVWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPnH+T0ZPw3zVeDzCVaN83JxbAsZ48r06G8UnYG0fV+03+EAXwhphN8fxu+ea/thgaWDSlNcM+6xNCHanK26NinXTMSLyatuDHVxjmXuD06sr0HGDQQBkXDEdKJ/ji37DQMUFJJVZZ8kh/vsJ9OWv1VtiYcVtUuTrsxGd9jaV1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RXedL9vU; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RXedL9vU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 61E251F8BA;
	Mon,  5 Feb 2024 10:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707129643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BKBcU6YqpKLkMWFaxv08QTXYXsDD02PgmQ2I1AtJz+o=;
	b=RXedL9vUcEuWj1kOAGQude6sI1XZvW3JH8Vha6feqQkRxz7fk56UU8KSiB/LhqI32Gcpmf
	YnUBZy8SMZqfGjJ4m6ejuFCmM4r4xwN5wjnfV+no2W7go7Uz7bna5jsW5Hls/LI2vkkcAF
	S5vFe2Og5HMOTzYUnm1zUNb49ciJZpQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707129643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BKBcU6YqpKLkMWFaxv08QTXYXsDD02PgmQ2I1AtJz+o=;
	b=RXedL9vUcEuWj1kOAGQude6sI1XZvW3JH8Vha6feqQkRxz7fk56UU8KSiB/LhqI32Gcpmf
	YnUBZy8SMZqfGjJ4m6ejuFCmM4r4xwN5wjnfV+no2W7go7Uz7bna5jsW5Hls/LI2vkkcAF
	S5vFe2Og5HMOTzYUnm1zUNb49ciJZpQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43A1B132DD;
	Mon,  5 Feb 2024 10:40:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Gv15DSu7wGWUMwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 05 Feb 2024 10:40:43 +0000
Date: Mon, 5 Feb 2024 11:40:42 +0100
From: Michal Hocko <mhocko@suse.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Efly Young <yangyifei03@kuaishou.com>, android-mm@google.com,
	yuzhao@google.com, mkoutny@suse.com,
	Yosry Ahmed <yosryahmed@google.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: memcg: Use larger batches for proactive reclaim
Message-ID: <ZcC7Kgew3GDFNIux@tiehlicka>
References: <20240202233855.1236422-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240202233855.1236422-1-tjmercier@google.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=RXedL9vU
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 61E251F8BA
X-Spam-Flag: NO

On Fri 02-02-24 23:38:54, T.J. Mercier wrote:
> Before 388536ac291 ("mm:vmscan: fix inaccurate reclaim during proactive
> reclaim") we passed the number of pages for the reclaim request directly
> to try_to_free_mem_cgroup_pages, which could lead to significant
> overreclaim. After 0388536ac291 the number of pages was limited to a
> maximum 32 (SWAP_CLUSTER_MAX) to reduce the amount of overreclaim.
> However such a small batch size caused a regression in reclaim
> performance due to many more reclaim start/stop cycles inside
> memory_reclaim.

You have mentioned that in one of the previous emails but it is good to
mention what is the source of that overhead for the future reference.
 
> Reclaim tries to balance nr_to_reclaim fidelity with fairness across
> nodes and cgroups over which the pages are spread. As such, the bigger
> the request, the bigger the absolute overreclaim error. Historic
> in-kernel users of reclaim have used fixed, small sized requests to
> approach an appropriate reclaim rate over time. When we reclaim a user
> request of arbitrary size, use decaying batch sizes to manage error while
> maintaining reasonable throughput.

These numbers are with MGLRU or the default reclaim implementation?
 
> root - full reclaim       pages/sec   time (sec)
> pre-0388536ac291      :    68047        10.46
> post-0388536ac291     :    13742        inf
> (reclaim-reclaimed)/4 :    67352        10.51
> 
> /uid_0 - 1G reclaim       pages/sec   time (sec)  overreclaim (MiB)
> pre-0388536ac291      :    258822       1.12            107.8
> post-0388536ac291     :    105174       2.49            3.5
> (reclaim-reclaimed)/4 :    233396       1.12            -7.4
> 
> /uid_0 - full reclaim     pages/sec   time (sec)
> pre-0388536ac291      :    72334        7.09
> post-0388536ac291     :    38105        14.45
> (reclaim-reclaimed)/4 :    72914        6.96
> 
> Fixes: 0388536ac291 ("mm:vmscan: fix inaccurate reclaim during proactive reclaim")
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> ---
> v3: Formatting fixes per Yosry Ahmed and Johannes Weiner. No functional
> changes.
> v2: Simplify the request size calculation per Johannes Weiner and Michal Koutný
> 
>  mm/memcontrol.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 46d8d02114cf..f6ab61128869 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6976,9 +6976,11 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
>  		if (!nr_retries)
>  			lru_add_drain_all();
>  
> +		/* Will converge on zero, but reclaim enforces a minimum */
> +		unsigned long batch_size = (nr_to_reclaim - nr_reclaimed) / 4;

This doesn't fit into the existing coding style. I do not think there is
a strong reason to go against it here.

> +
>  		reclaimed = try_to_free_mem_cgroup_pages(memcg,
> -					min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
> -					GFP_KERNEL, reclaim_options);
> +					batch_size, GFP_KERNEL, reclaim_options);

Also with the increased reclaim target do we need something like this?

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4f9c854ce6cc..94794cf5ee9f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1889,7 +1889,7 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 
 		/* We are about to die and free our memory. Return now. */
 		if (fatal_signal_pending(current))
-			return SWAP_CLUSTER_MAX;
+			return sc->nr_to_reclaim;
 	}
 
 	lru_add_drain();
>  
>  		if (!reclaimed && !nr_retries--)
>  			return -EAGAIN;
> -- 
> 2.43.0.594.gd9cf4e227d-goog

-- 
Michal Hocko
SUSE Labs

