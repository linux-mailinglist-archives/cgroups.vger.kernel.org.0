Return-Path: <cgroups+bounces-2860-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FABC8C240F
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2024 13:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91151F21683
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2024 11:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A208F16E890;
	Fri, 10 May 2024 11:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bQAriabN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bQAriabN"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B9421340;
	Fri, 10 May 2024 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342264; cv=none; b=VLbBC6yH9AD3wT06BHNpHtiO6D63VRGLTxOkiIArWLhj1y5G5GyvCrrvj5KpPpc6Bbnutjx9WEo2QfD5UqyjubSFWCMdzynX64X4d8J1An2ebzYNjI8P62DD/jZRM7NjfJbm55psGQlQWMsJYO3+o1n+uesmefmrMdxgjJlP594=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342264; c=relaxed/simple;
	bh=+h0DH4aBy7AE34S2X04B+UROh2mSH4naMR406/7GhFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDRWkUsOLaSp/zC6Sa2jLIVyNtsIqx1DzV2P1MIBU90WPTrFEpVZDeQ5enWcyF4EYChjDHL7qmbMwRsmrwozxICjf+doou5Mq6dcQWnfvI72Q7Ggh3hGgU6bSwqIAvQhTIOV06eHMRa1wxgyy0OA/lpTe0VUoRFhTn/Tpt2ZO/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bQAriabN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bQAriabN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B3493EC9C;
	Fri, 10 May 2024 11:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715342260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fxWM34KiqX62IKR1RnVV3lWHklyyFYPYe1Bmn9kILe8=;
	b=bQAriabNcwdwS00TgF7K7dc5ui7142wcn0+HDLCrs9cQMYCddKkZ0DnU38PKLhHvzcLB5n
	ccjcNw7Q9m8Nh6nRGyzJgGpbxpRfKrz4YJf9M8rZV4+zg+uJPxQePftqeWeDIdiHk20Hw1
	i6JGmXwPN4kbNKEpWQHFIVBpHczvJtc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715342260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fxWM34KiqX62IKR1RnVV3lWHklyyFYPYe1Bmn9kILe8=;
	b=bQAriabNcwdwS00TgF7K7dc5ui7142wcn0+HDLCrs9cQMYCddKkZ0DnU38PKLhHvzcLB5n
	ccjcNw7Q9m8Nh6nRGyzJgGpbxpRfKrz4YJf9M8rZV4+zg+uJPxQePftqeWeDIdiHk20Hw1
	i6JGmXwPN4kbNKEpWQHFIVBpHczvJtc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D2DF139AA;
	Fri, 10 May 2024 11:57:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MTCrF7QLPma7ZgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 10 May 2024 11:57:40 +0000
Date: Fri, 10 May 2024 13:57:39 +0200
From: Michal Hocko <mhocko@suse.com>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH -next] memcg, oom: cleanup unused memcg_oom_gfp_mask and
 memcg_oom_order
Message-ID: <Zj4Ls4aRW2Asyk7g@tiehlicka>
References: <20240509032628.1217652-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509032628.1217652-1-xiujianfeng@huawei.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.38 / 50.00];
	BAYES_HAM(-2.58)[98.10%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Score: -3.38
X-Spam-Flag: NO

On Thu 09-05-24 03:26:28, Xiu Jianfeng wrote:
> Since commit 857f21397f71 ("memcg, oom: remove unnecessary check in
> mem_cgroup_oom_synchronize()"), memcg_oom_gfp_mask and memcg_oom_order
> are no longer used any more.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
> ---
>  include/linux/sched.h | 2 --
>  mm/memcontrol.c       | 2 --
>  2 files changed, 4 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 8d1cf672ac4c..61591ac6eab6 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1449,8 +1449,6 @@ struct task_struct {
>  
>  #ifdef CONFIG_MEMCG
>  	struct mem_cgroup		*memcg_in_oom;
> -	gfp_t				memcg_oom_gfp_mask;
> -	int				memcg_oom_order;
>  
>  	/* Number of pages to reclaim on returning to userland: */
>  	unsigned int			memcg_nr_pages_over_high;
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5d4da23264fa..d127c9c5fabf 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2192,8 +2192,6 @@ static bool mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
>  		if (current->in_user_fault) {
>  			css_get(&memcg->css);
>  			current->memcg_in_oom = memcg;
> -			current->memcg_oom_gfp_mask = mask;
> -			current->memcg_oom_order = order;
>  		}
>  		return false;
>  	}
> -- 
> 2.34.1

-- 
Michal Hocko
SUSE Labs

