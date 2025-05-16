Return-Path: <cgroups+bounces-8227-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF6BAB98D1
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 11:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092D81BA8A69
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 09:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C72222592;
	Fri, 16 May 2025 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nBK3Pned";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0wpiyr9L";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oIu9JqTE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BeIDIuWc"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D7A1ADFFE
	for <cgroups@vger.kernel.org>; Fri, 16 May 2025 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747387822; cv=none; b=twtEt3NEwRzEmisUj2WLwxl6kwKnPTibGPBdcbBCPJFTHSkgZK6WxoepMp5WoLfMom2NV439d1gURXeFzgy4m4dZuemgomoKOLzvRNvNbSLOdUKWmvAqYT1/7g1CjGXIdXQvtico1pqpCzRhtSHVwtJV5lFrd7OcxPfdSlUC5uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747387822; c=relaxed/simple;
	bh=B3ZiegLFQaw1r3vMP0kPLfqnEJazIqxt1qXYD5ufMtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DaSzP8bINhU7mnea+ACLs6HCF+6RfynO9QueWYHOxdEtdKOi1nWKMHY4BEAu64V027Ip8lndLHC3mkisvbFc87Kl27StD1Lo4pEOb8+ScMfhhbdst8aXg8AE3M6hheEFK9Qf0JR57pZLDAAnxKRibJvdmdsjvTW+2BQ8f/1I8Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nBK3Pned; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0wpiyr9L; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oIu9JqTE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BeIDIuWc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CF1151F7EE;
	Fri, 16 May 2025 09:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747387818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LnNsAI1IEVWCtij7B5BWUMuimEnRefvZxFuas2D3CYU=;
	b=nBK3PnedZEa9h2ej/g/xvNm/M2yRae02nNU9//8OsnP/ecRZPpR3/hFfrveZmY6g5pCXy+
	tcVh1UURlD9RJMOOQq/+wITgjhWDELbJVlfpo7xf8IDxbQBdSbqZKkND3V+cy5bWBdBW2l
	WhCfev1G/XcyTHVIN/BILpZluFZ0MJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747387818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LnNsAI1IEVWCtij7B5BWUMuimEnRefvZxFuas2D3CYU=;
	b=0wpiyr9LPnIQN1UK0HgmvHvsp9Si3Rsl7sJEyauQjVxba8lKXU4u9koXGpNh+XhBtdneNN
	+gRRY35TS8fOYHCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oIu9JqTE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BeIDIuWc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747387817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LnNsAI1IEVWCtij7B5BWUMuimEnRefvZxFuas2D3CYU=;
	b=oIu9JqTERf+VFgsx0h9WN6glkx7Bpd7Dp4Q6gaFE0RLc/0AdaP/AXNkLzQFhqGOEOwj82C
	ExEosXZCVR4zWi2nA+LVqvl22ugQpjMSqQV+Va8775gA4wVZT2r2luN4Hqf3oxgBWgZgqx
	HEpZFdf4pa6gwL4GzOXzSzz1/F44Dcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747387817;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LnNsAI1IEVWCtij7B5BWUMuimEnRefvZxFuas2D3CYU=;
	b=BeIDIuWccp1BwpHkJNGkUsj018CLfpIF3wzQrux4XlziPPZiO06QGiAR0NndtNEHT0FRUr
	nRueyc8tCyB3kQCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA17F13977;
	Fri, 16 May 2025 09:30:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jqIfKakFJ2gNbgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 16 May 2025 09:30:17 +0000
Message-ID: <050484a9-c08c-40d2-b431-76903a639222@suse.cz>
Date: Fri, 16 May 2025 11:30:17 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] memcg: disable kmem charging in nmi for unsupported
 arch
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf@vger.kernel.org,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>
References: <20250516064912.1515065-1-shakeel.butt@linux.dev>
 <20250516064912.1515065-2-shakeel.butt@linux.dev>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250516064912.1515065-2-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CF1151F7EE
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action

On 5/16/25 08:49, Shakeel Butt wrote:
> The memcg accounting and stats uses this_cpu* and atomic* ops. There are
> archs which define CONFIG_HAVE_NMI but does not define
> CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS and ARCH_HAVE_NMI_SAFE_CMPXCHG, so
> memcg accounting for such archs in nmi context is not possible to
> support. Let's just disable memcg accounting in nmi context for such
> archs.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  include/linux/memcontrol.h |  5 +++++
>  mm/memcontrol.c            | 15 +++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index f7848f73f41c..53920528821f 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -62,6 +62,11 @@ struct mem_cgroup_reclaim_cookie {
>  
>  #ifdef CONFIG_MEMCG
>  
> +#if defined(CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS) || \
> +	!defined(CONFIG_HAVE_NMI) || defined(ARCH_HAVE_NMI_SAFE_CMPXCHG)
> +#define MEMCG_SUPPORTS_NMI_CHARGING
> +#endif
> +
>  #define MEM_CGROUP_ID_SHIFT	16
>  
>  struct mem_cgroup_id {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e17b698f6243..dface07f69bb 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2647,11 +2647,26 @@ static struct obj_cgroup *current_objcg_update(void)
>  	return objcg;
>  }
>  
> +#ifdef MEMCG_SUPPORTS_NMI_CHARGING
> +static inline bool nmi_charging_allowed(void)
> +{
> +	return true;
> +}
> +#else
> +static inline bool nmi_charging_allowed(void)
> +{
> +	return false;
> +}
> +#endif
> +
>  __always_inline struct obj_cgroup *current_obj_cgroup(void)
>  {
>  	struct mem_cgroup *memcg;
>  	struct obj_cgroup *objcg;
>  
> +	if (in_nmi() && !nmi_charging_allowed())

Exchange the two as the latter is compile-time constant, so it can shortcut
the in_nmi() check away in all the good cases?

> +		return NULL;
> +
>  	if (in_task()) {
>  		memcg = current->active_memcg;
>  		if (unlikely(memcg))


