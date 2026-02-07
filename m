Return-Path: <cgroups+bounces-13760-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KK7YKICQhmlwOwQAu9opvQ
	(envelope-from <cgroups+bounces-13760-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 07 Feb 2026 02:08:16 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 072151046B1
	for <lists+cgroups@lfdr.de>; Sat, 07 Feb 2026 02:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CCDB3059AA1
	for <lists+cgroups@lfdr.de>; Sat,  7 Feb 2026 01:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E88242D60;
	Sat,  7 Feb 2026 01:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOB0/8kt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27A223E358
	for <cgroups@vger.kernel.org>; Sat,  7 Feb 2026 01:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770426397; cv=none; b=X0luKmg3f0cQeZQ461IZ/X/Mt5Pze4L0KBB0o3aWvZGId2hF9hqphGM2JcQKM4oVBPQ8pgPpuZODOd/DFpcDfV8wPkiH8P/I5nxU6jDz5drBUpLuX+NGPxhNlwheeYVCAm/Pls5RpApVj4rSns5Nr+nq9OVeb+69DoV8O6frWgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770426397; c=relaxed/simple;
	bh=F+TcbP9vKmZaZxWd/wHdfT44F0lWaWW+qxy+W0llMuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=rGfrusk9jilKVlfUofMNrHTOh7PT8Gmh8sSujj4WyVuAoZYJ7IpiSZrA6/+BJurJE1GoryKg387jEW6K+/VdF/AZ91X8WC11BeIQftaaL/GcS5FUmFaMslxcMVuCU5jv0D3FvjMqkWmwa5QmiLh6zwnYo/cLqh65rNpyul24cW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOB0/8kt; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4362507f0bcso1514351f8f.0
        for <cgroups@vger.kernel.org>; Fri, 06 Feb 2026 17:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770426395; x=1771031195; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u/vJ3VIJuZtQuWjK4wytFxxOtJ+FrkJK3UbUw2RFviE=;
        b=dOB0/8ktEBGMZCeM3S08s+Vqh5HXVPlVcVWodWXt6F4B4qZZBY+uPRf2wR0WtcKpWt
         NCHufDmP93AWKJWZmf+0WUILfMFp+PQ8XiaZBNz6CXwtRO/tKBis+jqrgwC+NtzClyUT
         F0XLsTDNjqwnuw/QI8oyfPTZGUmcpjCwEplIFzE/Hwd10wiY+HZSfghKEtnouX9nHDQO
         e4sFX4Y13LDiWteW+caU1E4MFdvL9pwSGzCznElZc5Leosixnz13dKesjtZBS5WAfHPL
         g1hOoa8ClfFGwY4Pd7Zz1CieokcHiA6TRmEBVISSzm3vSJNYcCm22+X5ps3PdnmsBMH7
         g5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770426395; x=1771031195;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/vJ3VIJuZtQuWjK4wytFxxOtJ+FrkJK3UbUw2RFviE=;
        b=wVX4NkY2frWl246AIxhIFTPPVb/m9p+piG5qB8t3Q/XIzZJptz7OZdEDwdjW3uEw2K
         Z6dIungq4Ka1B+swp59QXDvoaP9a1Zto5NqWiu2hY9EGGDtLOqI3uZYuTbCLy8B0MqRq
         MX3sroDatSQK8tKrPZD8PtBauBdfx270ZJ9XIsia6IzICBbZshbYyKZZFNdGylGDhlTO
         zmJYYzUDJD71etAZkbp/TIAJrGaclQCyMdxoJm7NcAcC/cdcBJvwveit+tJ2eICHgD7+
         /2I0AHS9hzbwa0Ik6qYpOJtEIeCXGANmHOQ5a+uP9ZLG+JN7x4qymID+qgSNiYWOCdj8
         8ucQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+3aCB6RSzyo6un+m5nd1b63IjGd44SvIdnlahM7Q+9sXIhfxNXKbhOa3DL0Q3CbQByI3MM69u@vger.kernel.org
X-Gm-Message-State: AOJu0YzZLzowYKKtF34jPyZY3H7ie764NtTrHLSs9gUd2Z9ps+zlnvgR
	+N2ZcFydqAk6Rt9ZYt88vbou9iEIRhAX0hMRfeoCg/QuQek6YZQnnfWG
X-Gm-Gg: AZuq6aKoDaoZgtZQbloTLaOr8wMv21G7/FAlWyu1/fO9e+ceR7cleA81hB2pwzhJh80
	NXsGG1dlPajDgqAquwvG7O8DWAk6PQmjYJt3uJsdziFpe5HBIQyVuE9WVWmySotX4qgw73vhiKp
	2xI45ef5tBO4Mi4GIjudOep+oARGz0taHRQVcKinQOX6qGl0w+Sdd5CmXFhIvPHDIIkBEuPqyKX
	uY9OgFjQ3rMJbybEp7M/hETyOA4vtsKSA8hn/1w4fqun54Tdwjfre35AUd2gUBVkJQMmrYA0yOr
	fwwVDnEHgKNCpVcgszigG4qd7dHMsq1ezooqfce01A6aDSj6DypyaK1wQA3GXNOGmCe6JmfyeE+
	AUOetphT+PJVkxVrows75wYViVtQdxI5/L+aV3csOgCGNL7kWrcR7UNQcUAIkn2b22RHk0Jaj4I
	hzwg3vI5jN1MloPe/gwSgaSPs=
X-Received: by 2002:a05:6000:18a4:b0:431:c06:bc82 with SMTP id ffacd0b85a97d-436209967b3mr14539883f8f.12.1770426394964;
        Fri, 06 Feb 2026 17:06:34 -0800 (PST)
Received: from WindFlash.powerhub ([2a0a:ef40:1b2a:fa01:9944:6a8c:dc37:eba5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629664632sm9318385f8f.0.2026.02.06.17.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 17:06:34 -0800 (PST)
From: Leonardo Bras <leobras.c@gmail.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Leonardo Bras <leobras.c@gmail.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 3/4] swap: apply new queue_percpu_work_on() interface
Date: Fri,  6 Feb 2026 22:06:28 -0300
Message-ID: <aYaQFM9sBbauUn5c@WindFlash>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206143741.589656953@redhat.com>
References: <20260206143430.021026873@redhat.com> <20260206143741.589656953@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13760-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kvack.org,cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,linux.com,google.com,lge.com,suse.cz,redhat.com,linutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leobrasc@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 072151046B1
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 11:34:33AM -0300, Marcelo Tosatti wrote:
> Make use of the new qpw_{un,}lock*() and queue_percpu_work_on()
> interface to improve performance & latency on PREEMPT_RT kernels.
> 
> For functions that may be scheduled in a different cpu, replace
> local_{un,}lock*() by qpw_{un,}lock*(), and replace schedule_work_on() by
> queue_percpu_work_on(). The same happens for flush_work() and
> flush_percpu_work().
> 
> The change requires allocation of qpw_structs instead of a work_structs,
> and changing parameters of a few functions to include the cpu parameter.
> 
> This should bring no relevant performance impact on non-RT kernels:

I think this is still referencing the previuos version, as there may be 
impact in PREEMPT_RT=n kernels if QPW=y and qpw=1 in kernel cmdline.

I would go with:
This should bring no relevant performance impact on non-QPW kernels

> For functions that may be scheduled in a different cpu, the local_*lock's
> this_cpu_ptr() becomes a per_cpu_ptr(smp_processor_id()).
> 
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---
>  mm/internal.h   |    4 +-
>  mm/mlock.c      |   71 ++++++++++++++++++++++++++++++++------------
>  mm/page_alloc.c |    2 -
>  mm/swap.c       |   90 +++++++++++++++++++++++++++++++-------------------------
>  4 files changed, 108 insertions(+), 59 deletions(-)
> 
> Index: slab/mm/mlock.c
> ===================================================================
> --- slab.orig/mm/mlock.c
> +++ slab/mm/mlock.c
> @@ -25,17 +25,16 @@
>  #include <linux/memcontrol.h>
>  #include <linux/mm_inline.h>
>  #include <linux/secretmem.h>
> +#include <linux/qpw.h>
>  
>  #include "internal.h"
>  
>  struct mlock_fbatch {
> -	local_lock_t lock;
> +	qpw_lock_t lock;
>  	struct folio_batch fbatch;
>  };
>  
> -static DEFINE_PER_CPU(struct mlock_fbatch, mlock_fbatch) = {
> -	.lock = INIT_LOCAL_LOCK(lock),
> -};
> +static DEFINE_PER_CPU(struct mlock_fbatch, mlock_fbatch);
>  
>  bool can_do_mlock(void)
>  {
> @@ -209,18 +208,25 @@ static void mlock_folio_batch(struct fol
>  	folios_put(fbatch);
>  }
>  
> -void mlock_drain_local(void)
> +void mlock_drain_cpu(int cpu)
>  {
>  	struct folio_batch *fbatch;
>  
> -	local_lock(&mlock_fbatch.lock);
> -	fbatch = this_cpu_ptr(&mlock_fbatch.fbatch);
> +	qpw_lock(&mlock_fbatch.lock, cpu);
> +	fbatch = per_cpu_ptr(&mlock_fbatch.fbatch, cpu);
>  	if (folio_batch_count(fbatch))
>  		mlock_folio_batch(fbatch);
> -	local_unlock(&mlock_fbatch.lock);
> +	qpw_unlock(&mlock_fbatch.lock, cpu);
>  }
>  
> -void mlock_drain_remote(int cpu)
> +void mlock_drain_local(void)
> +{
> +	migrate_disable();
> +	mlock_drain_cpu(smp_processor_id());
> +	migrate_enable();
> +}
> +
> +void mlock_drain_offline(int cpu)
>  {
>  	struct folio_batch *fbatch;
>  
> @@ -242,9 +248,12 @@ bool need_mlock_drain(int cpu)
>  void mlock_folio(struct folio *folio)
>  {
>  	struct folio_batch *fbatch;
> +	int cpu;
>  
> -	local_lock(&mlock_fbatch.lock);
> -	fbatch = this_cpu_ptr(&mlock_fbatch.fbatch);
> +	migrate_disable();
> +	cpu = smp_processor_id();

Wondering if for these cases it would make sense to have something like:

qpw_get_local_cpu() and 
qpw_put_local_cpu() 

so we could encapsulate these migrate_{en,dis}able()
and the smp_processor_id().

Or even,

int qpw_local_lock() {
	migrate_disable();
	cpu = smp_processor_id();
	qpw_lock(..., cpu);

	return cpu;
}

and

qpw_local_unlock(cpu){
	qpw_unlock(...,cpu);
	migrate_enable();
} 

so it's more direct to convert the local-only cases.

What do you think?


> +	qpw_lock(&mlock_fbatch.lock, cpu);
> +	fbatch = per_cpu_ptr(&mlock_fbatch.fbatch, cpu);
>  
>  	if (!folio_test_set_mlocked(folio)) {
>  		int nr_pages = folio_nr_pages(folio);
> @@ -257,7 +266,8 @@ void mlock_folio(struct folio *folio)
>  	if (!folio_batch_add(fbatch, mlock_lru(folio)) ||
>  	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
>  		mlock_folio_batch(fbatch);
> -	local_unlock(&mlock_fbatch.lock);
> +	qpw_unlock(&mlock_fbatch.lock, cpu);
> +	migrate_enable();
>  }
>  
>  /**
> @@ -268,9 +278,13 @@ void mlock_new_folio(struct folio *folio
>  {
>  	struct folio_batch *fbatch;
>  	int nr_pages = folio_nr_pages(folio);
> +	int cpu;
> +
> +	migrate_disable();
> +	cpu = smp_processor_id();
> +	qpw_lock(&mlock_fbatch.lock, cpu);
>  
> -	local_lock(&mlock_fbatch.lock);
> -	fbatch = this_cpu_ptr(&mlock_fbatch.fbatch);
> +	fbatch = per_cpu_ptr(&mlock_fbatch.fbatch, cpu);
>  	folio_set_mlocked(folio);
>  
>  	zone_stat_mod_folio(folio, NR_MLOCK, nr_pages);
> @@ -280,7 +294,8 @@ void mlock_new_folio(struct folio *folio
>  	if (!folio_batch_add(fbatch, mlock_new(folio)) ||
>  	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
>  		mlock_folio_batch(fbatch);
> -	local_unlock(&mlock_fbatch.lock);
> +	migrate_enable();
> +	qpw_unlock(&mlock_fbatch.lock, cpu);

in the above conversion, the migrate_enable() happened after qpw_unlock,
and in this one is the oposite. Any particular reason?

>  }
>  
>  /**
> @@ -290,9 +305,13 @@ void mlock_new_folio(struct folio *folio
>  void munlock_folio(struct folio *folio)
>  {
>  	struct folio_batch *fbatch;
> +	int cpu;
>  
> -	local_lock(&mlock_fbatch.lock);
> -	fbatch = this_cpu_ptr(&mlock_fbatch.fbatch);
> +	migrate_disable();
> +	cpu = smp_processor_id();
> +	qpw_lock(&mlock_fbatch.lock, cpu);
> +
> +	fbatch = per_cpu_ptr(&mlock_fbatch.fbatch, cpu);
>  	/*
>  	 * folio_test_clear_mlocked(folio) must be left to __munlock_folio(),
>  	 * which will check whether the folio is multiply mlocked.
> @@ -301,7 +320,8 @@ void munlock_folio(struct folio *folio)
>  	if (!folio_batch_add(fbatch, folio) ||
>  	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
>  		mlock_folio_batch(fbatch);
> -	local_unlock(&mlock_fbatch.lock);
> +	qpw_unlock(&mlock_fbatch.lock, cpu);
> +	migrate_enable();
>  }
>  
>  static inline unsigned int folio_mlock_step(struct folio *folio,
> @@ -823,3 +843,18 @@ void user_shm_unlock(size_t size, struct
>  	spin_unlock(&shmlock_user_lock);
>  	put_ucounts(ucounts);
>  }
> +
> +int __init mlock_init(void)
> +{
> +	unsigned int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct mlock_fbatch *fbatch = &per_cpu(mlock_fbatch, cpu);
> +
> +		qpw_lock_init(&fbatch->lock);
> +	}
> +
> +	return 0;
> +}
> +
> +module_init(mlock_init);
> Index: slab/mm/swap.c
> ===================================================================
> --- slab.orig/mm/swap.c
> +++ slab/mm/swap.c
> @@ -35,7 +35,7 @@
>  #include <linux/uio.h>
>  #include <linux/hugetlb.h>
>  #include <linux/page_idle.h>
> -#include <linux/local_lock.h>
> +#include <linux/qpw.h>
>  #include <linux/buffer_head.h>
>  
>  #include "internal.h"
> @@ -52,7 +52,7 @@ struct cpu_fbatches {
>  	 * The following folio batches are grouped together because they are protected
>  	 * by disabling preemption (and interrupts remain enabled).
>  	 */
> -	local_lock_t lock;
> +	qpw_lock_t lock;
>  	struct folio_batch lru_add;
>  	struct folio_batch lru_deactivate_file;
>  	struct folio_batch lru_deactivate;
> @@ -61,14 +61,11 @@ struct cpu_fbatches {
>  	struct folio_batch lru_activate;
>  #endif
>  	/* Protecting the following batches which require disabling interrupts */
> -	local_lock_t lock_irq;
> +	qpw_lock_t lock_irq;
>  	struct folio_batch lru_move_tail;
>  };
>  
> -static DEFINE_PER_CPU(struct cpu_fbatches, cpu_fbatches) = {
> -	.lock = INIT_LOCAL_LOCK(lock),
> -	.lock_irq = INIT_LOCAL_LOCK(lock_irq),
> -};
> +static DEFINE_PER_CPU(struct cpu_fbatches, cpu_fbatches);
>  
>  static void __page_cache_release(struct folio *folio, struct lruvec **lruvecp,
>  		unsigned long *flagsp)
> @@ -183,22 +180,24 @@ static void __folio_batch_add_and_move(s
>  		struct folio *folio, move_fn_t move_fn, bool disable_irq)
>  {
>  	unsigned long flags;
> +	int cpu;
>  
>  	folio_get(folio);


don't we need the migrate_disable() here?

>  
> +	cpu = smp_processor_id();
>  	if (disable_irq)
> -		local_lock_irqsave(&cpu_fbatches.lock_irq, flags);
> +		qpw_lock_irqsave(&cpu_fbatches.lock_irq, flags, cpu);
>  	else
> -		local_lock(&cpu_fbatches.lock);
> +		qpw_lock(&cpu_fbatches.lock, cpu);
>  
> -	if (!folio_batch_add(this_cpu_ptr(fbatch), folio) ||
> +	if (!folio_batch_add(per_cpu_ptr(fbatch, cpu), folio) ||
>  			!folio_may_be_lru_cached(folio) || lru_cache_disabled())
> -		folio_batch_move_lru(this_cpu_ptr(fbatch), move_fn);
> +		folio_batch_move_lru(per_cpu_ptr(fbatch, cpu), move_fn);
>  
>  	if (disable_irq)
> -		local_unlock_irqrestore(&cpu_fbatches.lock_irq, flags);
> +		qpw_unlock_irqrestore(&cpu_fbatches.lock_irq, flags, cpu);
>  	else
> -		local_unlock(&cpu_fbatches.lock);
> +		qpw_unlock(&cpu_fbatches.lock, cpu);
>  }
>  
>  #define folio_batch_add_and_move(folio, op)		\
> @@ -358,9 +357,10 @@ static void __lru_cache_activate_folio(s
>  {
>  	struct folio_batch *fbatch;
>  	int i;

and here?

> +	int cpu = smp_processor_id();
>  
> -	local_lock(&cpu_fbatches.lock);
> -	fbatch = this_cpu_ptr(&cpu_fbatches.lru_add);
> +	qpw_lock(&cpu_fbatches.lock, cpu);
> +	fbatch = per_cpu_ptr(&cpu_fbatches.lru_add, cpu);
>  
>  	/*
>  	 * Search backwards on the optimistic assumption that the folio being
> @@ -381,7 +381,7 @@ static void __lru_cache_activate_folio(s
>  		}
>  	}
>  
> -	local_unlock(&cpu_fbatches.lock);
> +	qpw_unlock(&cpu_fbatches.lock, cpu);
>  }
>  
>  #ifdef CONFIG_LRU_GEN
> @@ -653,9 +653,9 @@ void lru_add_drain_cpu(int cpu)
>  		unsigned long flags;
>  
>  		/* No harm done if a racing interrupt already did this */
> -		local_lock_irqsave(&cpu_fbatches.lock_irq, flags);
> +		qpw_lock_irqsave(&cpu_fbatches.lock_irq, flags, cpu);
>  		folio_batch_move_lru(fbatch, lru_move_tail);
> -		local_unlock_irqrestore(&cpu_fbatches.lock_irq, flags);
> +		qpw_unlock_irqrestore(&cpu_fbatches.lock_irq, flags, cpu);
>  	}
>  
>  	fbatch = &fbatches->lru_deactivate_file;
> @@ -733,10 +733,12 @@ void folio_mark_lazyfree(struct folio *f
>  
>  void lru_add_drain(void)
>  {
> -	local_lock(&cpu_fbatches.lock);
> -	lru_add_drain_cpu(smp_processor_id());
> -	local_unlock(&cpu_fbatches.lock);
> -	mlock_drain_local();

and here?

> +	int cpu = smp_processor_id();
> +
> +	qpw_lock(&cpu_fbatches.lock, cpu);
> +	lru_add_drain_cpu(cpu);
> +	qpw_unlock(&cpu_fbatches.lock, cpu);
> +	mlock_drain_cpu(cpu);
>  }
>  
>  /*
> @@ -745,30 +747,32 @@ void lru_add_drain(void)
>   * the same cpu. It shouldn't be a problem in !SMP case since
>   * the core is only one and the locks will disable preemption.
>   */
> -static void lru_add_mm_drain(void)
> +static void lru_add_mm_drain(int cpu)
>  {
> -	local_lock(&cpu_fbatches.lock);
> -	lru_add_drain_cpu(smp_processor_id());
> -	local_unlock(&cpu_fbatches.lock);
> -	mlock_drain_local();
> +	qpw_lock(&cpu_fbatches.lock, cpu);
> +	lru_add_drain_cpu(cpu);
> +	qpw_unlock(&cpu_fbatches.lock, cpu);
> +	mlock_drain_cpu(cpu);
>  }
>  
>  void lru_add_drain_cpu_zone(struct zone *zone)
>  {
> -	local_lock(&cpu_fbatches.lock);
> -	lru_add_drain_cpu(smp_processor_id());

and here ?

> +	int cpu = smp_processor_id();
> +
> +	qpw_lock(&cpu_fbatches.lock, cpu);
> +	lru_add_drain_cpu(cpu);
>  	drain_local_pages(zone);
> -	local_unlock(&cpu_fbatches.lock);
> -	mlock_drain_local();
> +	qpw_unlock(&cpu_fbatches.lock, cpu);
> +	mlock_drain_cpu(cpu);
>  }
>  
>  #ifdef CONFIG_SMP
>  
> -static DEFINE_PER_CPU(struct work_struct, lru_add_drain_work);
> +static DEFINE_PER_CPU(struct qpw_struct, lru_add_drain_qpw);
>  
> -static void lru_add_drain_per_cpu(struct work_struct *dummy)
> +static void lru_add_drain_per_cpu(struct work_struct *w)
>  {
> -	lru_add_mm_drain();
> +	lru_add_mm_drain(qpw_get_cpu(w));
>  }
>  
>  static DEFINE_PER_CPU(struct work_struct, bh_add_drain_work);
> @@ -883,12 +887,12 @@ static inline void __lru_add_drain_all(b
>  	cpumask_clear(&has_mm_work);
>  	cpumask_clear(&has_bh_work);
>  	for_each_online_cpu(cpu) {
> -		struct work_struct *mm_work = &per_cpu(lru_add_drain_work, cpu);
> +		struct qpw_struct *mm_qpw = &per_cpu(lru_add_drain_qpw, cpu);
>  		struct work_struct *bh_work = &per_cpu(bh_add_drain_work, cpu);
>  
>  		if (cpu_needs_mm_drain(cpu)) {
> -			INIT_WORK(mm_work, lru_add_drain_per_cpu);
> -			queue_work_on(cpu, mm_percpu_wq, mm_work);
> +			INIT_QPW(mm_qpw, lru_add_drain_per_cpu, cpu);
> +			queue_percpu_work_on(cpu, mm_percpu_wq, mm_qpw);
>  			__cpumask_set_cpu(cpu, &has_mm_work);
>  		}
>  
> @@ -900,7 +904,7 @@ static inline void __lru_add_drain_all(b
>  	}
>  
>  	for_each_cpu(cpu, &has_mm_work)
> -		flush_work(&per_cpu(lru_add_drain_work, cpu));
> +		flush_percpu_work(&per_cpu(lru_add_drain_qpw, cpu));
>  
>  	for_each_cpu(cpu, &has_bh_work)
>  		flush_work(&per_cpu(bh_add_drain_work, cpu));
> @@ -950,7 +954,7 @@ void lru_cache_disable(void)
>  #ifdef CONFIG_SMP
>  	__lru_add_drain_all(true);
>  #else
> -	lru_add_mm_drain();

and here, I wonder

> +	lru_add_mm_drain(smp_processor_id());
>  	invalidate_bh_lrus_cpu();
>  #endif
>  }
> @@ -1124,6 +1128,7 @@ static const struct ctl_table swap_sysct
>  void __init swap_setup(void)
>  {
>  	unsigned long megs = PAGES_TO_MB(totalram_pages());
> +	unsigned int cpu;
>  
>  	/* Use a smaller cluster for small-memory machines */
>  	if (megs < 16)
> @@ -1136,4 +1141,11 @@ void __init swap_setup(void)
>  	 */
>  
>  	register_sysctl_init("vm", swap_sysctl_table);
> +
> +	for_each_possible_cpu(cpu) {
> +		struct cpu_fbatches *fbatches = &per_cpu(cpu_fbatches, cpu);
> +
> +		qpw_lock_init(&fbatches->lock);
> +		qpw_lock_init(&fbatches->lock_irq);
> +	}
>  }
> Index: slab/mm/internal.h
> ===================================================================
> --- slab.orig/mm/internal.h
> +++ slab/mm/internal.h
> @@ -1061,10 +1061,12 @@ static inline void munlock_vma_folio(str
>  		munlock_folio(folio);
>  }
>  
> +int __init mlock_init(void);
>  void mlock_new_folio(struct folio *folio);
>  bool need_mlock_drain(int cpu);
>  void mlock_drain_local(void);
> -void mlock_drain_remote(int cpu);
> +void mlock_drain_cpu(int cpu);
> +void mlock_drain_offline(int cpu);
>  
>  extern pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
>  
> Index: slab/mm/page_alloc.c
> ===================================================================
> --- slab.orig/mm/page_alloc.c
> +++ slab/mm/page_alloc.c
> @@ -6251,7 +6251,7 @@ static int page_alloc_cpu_dead(unsigned
>  	struct zone *zone;
>  
>  	lru_add_drain_cpu(cpu);
> -	mlock_drain_remote(cpu);
> +	mlock_drain_offline(cpu);
>  	drain_pages(cpu);
>  
>  	/*
> 
> 

TBH, I am still trying to understand if we need the migrate_{en,dis}able():
- There is a data dependency beween cpu being filled and being used.
- If we get the cpu, and then migrate to a different cpu, the operation 
  will still be executed with the data from that starting cpu 
- But maybe the compiler tries to optize this because the processor number 
  can be on a register and of easy access, which would break this.

Maybe a READ_ONCE() on smp_processor_id() should suffice?

Other than that, all the conversions done look correct.

That being said, I understand very little about mm code, so let's hope we 
get proper feedback from those who do :) 

Thanks!
Leo


