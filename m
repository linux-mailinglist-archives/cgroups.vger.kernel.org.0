Return-Path: <cgroups+bounces-5667-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A17AF9D6831
	for <lists+cgroups@lfdr.de>; Sat, 23 Nov 2024 09:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6317D281D2A
	for <lists+cgroups@lfdr.de>; Sat, 23 Nov 2024 08:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF1417084F;
	Sat, 23 Nov 2024 08:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="feml8xv/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zKmztYkC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="feml8xv/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zKmztYkC"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C478D2309A9;
	Sat, 23 Nov 2024 08:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732351081; cv=none; b=LSzM4VzDCFHfDhA54ZP7CDwxUFm/Z/+/n1fzKcfJBI5Zq5N0IxTLrHirf3kyn04g3t6ByoAuDvcAwy0RT83W4F/3U8WjRKscz5pSicjJTJ4u1uHRcYSGwmsIVTxNaPbCgE+SNVDGvGdgIjsEuxH5O195rtoUAwEFvk2FGdiBPnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732351081; c=relaxed/simple;
	bh=CAcnt3SRdrFRIlIaq2ro0kpAewLW87Ahg0vz67O3WGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ludJH/ACnXeezB0iCM2F47bm72eYUntJH3QgxnebqG6Wn9vpaj7vVjhnUMwZjXuYs/gBws8ReISNJASoql9tcCfpXo3OHtmtATwsT+nXa59ABX/ILaYj5JfoXpqtzZEIBaQQ1tUtQke+BlrKYLEp2gX75H1K1pVku0+ClHggM+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=feml8xv/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zKmztYkC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=feml8xv/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zKmztYkC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A3F6211F6;
	Sat, 23 Nov 2024 08:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732351076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zjzHSNb6UuSRMmh2wxMJaZsWFuAXI6UC9IjABu5KGjM=;
	b=feml8xv/ZvjHVUROjvz2LHQFYTac0kA3ARRAgH8Y+hb+tNF0LCuVtiCAmYC4aeij49pv5y
	7RRP4SNd0tUVWSx8je34fqEo/77/LeXXQGpz5PYzqSj2cpeZtnfYvaezdRdnAP0wwWlJnm
	ZtLOBKv6NDS5zHFNqO4kY3Qfy+05IUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732351076;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zjzHSNb6UuSRMmh2wxMJaZsWFuAXI6UC9IjABu5KGjM=;
	b=zKmztYkCabYUvgOil2QKg4eDScMkI7X1c1BCAw9zuQ4OMVa8kZpPBcuhb/R2Bn65+jbxjt
	czBTqTlaWy/XLGAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="feml8xv/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zKmztYkC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732351076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zjzHSNb6UuSRMmh2wxMJaZsWFuAXI6UC9IjABu5KGjM=;
	b=feml8xv/ZvjHVUROjvz2LHQFYTac0kA3ARRAgH8Y+hb+tNF0LCuVtiCAmYC4aeij49pv5y
	7RRP4SNd0tUVWSx8je34fqEo/77/LeXXQGpz5PYzqSj2cpeZtnfYvaezdRdnAP0wwWlJnm
	ZtLOBKv6NDS5zHFNqO4kY3Qfy+05IUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732351076;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zjzHSNb6UuSRMmh2wxMJaZsWFuAXI6UC9IjABu5KGjM=;
	b=zKmztYkCabYUvgOil2QKg4eDScMkI7X1c1BCAw9zuQ4OMVa8kZpPBcuhb/R2Bn65+jbxjt
	czBTqTlaWy/XLGAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A659137D4;
	Sat, 23 Nov 2024 08:37:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LeLxEGSUQWeJCAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Sat, 23 Nov 2024 08:37:56 +0000
Message-ID: <99c6af52-942f-4262-a79d-53a9c2e8eefe@suse.cz>
Date: Sat, 23 Nov 2024 09:38:09 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: mmap_lock: optimize mmap_lock tracepoints
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tejun Heo
 <tj@kernel.org>, Michal Koutny <mkoutny@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Suren Baghdasaryan
 <surenb@google.com>, linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
References: <20241123060939.169978-1-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20241123060939.169978-1-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7A3F6211F6
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 11/23/24 7:09 AM, Shakeel Butt wrote:
> We are starting to deploy mmap_lock tracepoint monitoring across our
> fleet and the early results showed that these tracepoints are consuming
> significant amount of CPUs in kernfs_path_from_node when enabled.
> 
> It seems like the kernel is trying to resolved the cgroup path in the
> fast path of the locking code path when the tracepoints are enabled. In
> addition for some application their metrics are regressing when
> monitoring is enabled.
> 
> The cgroup path resolution can be slow and should not be done in the
> fast path. Most userspace tools, like bpftrace, provides functionality
> to get the cgroup path from cgroup id, so let's just trace the cgroup
> id and the users can use better tools to get the path in the slow path.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

AFAIU this would also remove the lockdep issue that patch [1] is solving
with RCU conversion. It probably has other benefits on its own too, so
just FYI. It's definitely better to avoid complex operations to gather
tracepoint data, if avoidable.

[1] https://lore.kernel.org/all/20241121175250.EJbI7VMb@linutronix.de/

> ---
>  include/linux/memcontrol.h       | 18 ++++++++++++
>  include/trace/events/mmap_lock.h | 32 ++++++++++----------
>  mm/mmap_lock.c                   | 50 ++------------------------------
>  3 files changed, 36 insertions(+), 64 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 5502aa8e138e..d82f08cd70cd 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1046,6 +1046,19 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
>  
>  void split_page_memcg(struct page *head, int old_order, int new_order);
>  
> +static inline u64 memcg_id_from_mm(struct mm_struct *mm)
> +{
> +	struct mem_cgroup *memcg;
> +	u64 id = 0;
> +
> +	rcu_read_lock();
> +	memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
> +	if (likely(memcg))
> +		id = cgroup_id(memcg->css.cgroup);
> +	rcu_read_unlock();
> +	return id;
> +}
> +
>  #else /* CONFIG_MEMCG */
>  
>  #define MEM_CGROUP_ID_SHIFT	0
> @@ -1466,6 +1479,11 @@ void count_memcg_event_mm(struct mm_struct *mm, enum vm_event_item idx)
>  static inline void split_page_memcg(struct page *head, int old_order, int new_order)
>  {
>  }
> +
> +static inline u64 memcg_id_from_mm(struct mm_struct *mm)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_MEMCG */
>  
>  /*
> diff --git a/include/trace/events/mmap_lock.h b/include/trace/events/mmap_lock.h
> index bc2e3ad787b3..5529933d19c5 100644
> --- a/include/trace/events/mmap_lock.h
> +++ b/include/trace/events/mmap_lock.h
> @@ -5,6 +5,7 @@
>  #if !defined(_TRACE_MMAP_LOCK_H) || defined(TRACE_HEADER_MULTI_READ)
>  #define _TRACE_MMAP_LOCK_H
>  
> +#include <linux/memcontrol.h>
>  #include <linux/tracepoint.h>
>  #include <linux/types.h>
>  
> @@ -12,64 +13,61 @@ struct mm_struct;
>  
>  DECLARE_EVENT_CLASS(mmap_lock,
>  
> -	TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write),
> +	TP_PROTO(struct mm_struct *mm, bool write),
>  
> -	TP_ARGS(mm, memcg_path, write),
> +	TP_ARGS(mm, write),
>  
>  	TP_STRUCT__entry(
>  		__field(struct mm_struct *, mm)
> -		__string(memcg_path, memcg_path)
> +		__field(u64, memcg_id)
>  		__field(bool, write)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->mm = mm;
> -		__assign_str(memcg_path);
> +		__entry->memcg_id = memcg_id_from_mm(mm);
>  		__entry->write = write;
>  	),
>  
>  	TP_printk(
> -		"mm=%p memcg_path=%s write=%s",
> -		__entry->mm,
> -		__get_str(memcg_path),
> +		"mm=%p memcg_id=%llu write=%s",
> +		__entry->mm, __entry->memcg_id,
>  		__entry->write ? "true" : "false"
>  	)
>  );
>  
>  #define DEFINE_MMAP_LOCK_EVENT(name)                                    \
>  	DEFINE_EVENT(mmap_lock, name,                                   \
> -		TP_PROTO(struct mm_struct *mm, const char *memcg_path,  \
> -			bool write),                                    \
> -		TP_ARGS(mm, memcg_path, write))
> +		TP_PROTO(struct mm_struct *mm, bool write),		\
> +		TP_ARGS(mm, write))
>  
>  DEFINE_MMAP_LOCK_EVENT(mmap_lock_start_locking);
>  DEFINE_MMAP_LOCK_EVENT(mmap_lock_released);
>  
>  TRACE_EVENT(mmap_lock_acquire_returned,
>  
> -	TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write,
> -		bool success),
> +	TP_PROTO(struct mm_struct *mm, bool write, bool success),
>  
> -	TP_ARGS(mm, memcg_path, write, success),
> +	TP_ARGS(mm, write, success),
>  
>  	TP_STRUCT__entry(
>  		__field(struct mm_struct *, mm)
> -		__string(memcg_path, memcg_path)
> +		__field(u64, memcg_id)
>  		__field(bool, write)
>  		__field(bool, success)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->mm = mm;
> -		__assign_str(memcg_path);
> +		__entry->memcg_id = memcg_id_from_mm(mm);
>  		__entry->write = write;
>  		__entry->success = success;
>  	),
>  
>  	TP_printk(
> -		"mm=%p memcg_path=%s write=%s success=%s",
> +		"mm=%p memcg_id=%llu write=%s success=%s",
>  		__entry->mm,
> -		__get_str(memcg_path),
> +		__entry->memcg_id,
>  		__entry->write ? "true" : "false",
>  		__entry->success ? "true" : "false"
>  	)
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index f186d57df2c6..e7dbaf96aa17 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -17,51 +17,7 @@ EXPORT_TRACEPOINT_SYMBOL(mmap_lock_start_locking);
>  EXPORT_TRACEPOINT_SYMBOL(mmap_lock_acquire_returned);
>  EXPORT_TRACEPOINT_SYMBOL(mmap_lock_released);
>  
> -#ifdef CONFIG_MEMCG
> -
> -/*
> - * Size of the buffer for memcg path names. Ignoring stack trace support,
> - * trace_events_hist.c uses MAX_FILTER_STR_VAL for this, so we also use it.
> - */
> -#define MEMCG_PATH_BUF_SIZE MAX_FILTER_STR_VAL
> -
> -#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)				\
> -	do {								\
> -		if (trace_mmap_lock_##type##_enabled()) {		\
> -			char buf[MEMCG_PATH_BUF_SIZE];                  \
> -			get_mm_memcg_path(mm, buf, sizeof(buf));        \
> -			trace_mmap_lock_##type(mm, buf, ##__VA_ARGS__); \
> -		}							\
> -	} while (0)
> -
> -#else /* !CONFIG_MEMCG */
> -
> -#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
> -	trace_mmap_lock_##type(mm, "", ##__VA_ARGS__)
> -
> -#endif /* CONFIG_MEMCG */
> -
>  #ifdef CONFIG_TRACING
> -#ifdef CONFIG_MEMCG
> -/*
> - * Write the given mm_struct's memcg path to a buffer. If the path cannot be
> - * determined, empty string is written.
> - */
> -static void get_mm_memcg_path(struct mm_struct *mm, char *buf, size_t buflen)
> -{
> -	struct mem_cgroup *memcg;
> -
> -	buf[0] = '\0';
> -	memcg = get_mem_cgroup_from_mm(mm);
> -	if (memcg == NULL)
> -		return;
> -	if (memcg->css.cgroup)
> -		cgroup_path(memcg->css.cgroup, buf, buflen);
> -	css_put(&memcg->css);
> -}
> -
> -#endif /* CONFIG_MEMCG */
> -
>  /*
>   * Trace calls must be in a separate file, as otherwise there's a circular
>   * dependency between linux/mmap_lock.h and trace/events/mmap_lock.h.
> @@ -69,20 +25,20 @@ static void get_mm_memcg_path(struct mm_struct *mm, char *buf, size_t buflen)
>  
>  void __mmap_lock_do_trace_start_locking(struct mm_struct *mm, bool write)
>  {
> -	TRACE_MMAP_LOCK_EVENT(start_locking, mm, write);
> +	trace_mmap_lock_start_locking(mm, write);
>  }
>  EXPORT_SYMBOL(__mmap_lock_do_trace_start_locking);
>  
>  void __mmap_lock_do_trace_acquire_returned(struct mm_struct *mm, bool write,
>  					   bool success)
>  {
> -	TRACE_MMAP_LOCK_EVENT(acquire_returned, mm, write, success);
> +	trace_mmap_lock_acquire_returned(mm, write, success);
>  }
>  EXPORT_SYMBOL(__mmap_lock_do_trace_acquire_returned);
>  
>  void __mmap_lock_do_trace_released(struct mm_struct *mm, bool write)
>  {
> -	TRACE_MMAP_LOCK_EVENT(released, mm, write);
> +	trace_mmap_lock_released(mm, write);
>  }
>  EXPORT_SYMBOL(__mmap_lock_do_trace_released);
>  #endif /* CONFIG_TRACING */


