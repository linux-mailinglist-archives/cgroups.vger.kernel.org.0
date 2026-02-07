Return-Path: <cgroups+bounces-13762-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJqZAh+VhmkUPAQAu9opvQ
	(envelope-from <cgroups+bounces-13762-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 07 Feb 2026 02:27:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F08104810
	for <lists+cgroups@lfdr.de>; Sat, 07 Feb 2026 02:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06E3F3008D41
	for <lists+cgroups@lfdr.de>; Sat,  7 Feb 2026 01:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A0227B357;
	Sat,  7 Feb 2026 01:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3oDwvai"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3645C275B05
	for <cgroups@vger.kernel.org>; Sat,  7 Feb 2026 01:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770427676; cv=none; b=A5lnAE8yNuaJv7SWEzJhWCKBVgCVHZ6JrdQG7evRpIh+T+JY8yQYZLz0Oz7YBaKnddEiYoeKlmcQRb0HwQwfvQpJiGkPaxU6RLNy0iXmtopFXIbP+9H71wDddCZikeJWJPFRoAZze/EGCEpE9V3Xj92kL98njsR7LjPj9sFZeC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770427676; c=relaxed/simple;
	bh=WyFXAR5qhlFHxei4rJCheH3WhPvV1qW1/XjNwtjQ3y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=u6mkBaLxGENsj7gT4ekAiq9Fpppfmeok14qgrM4vD4Ex5zO6R/ZnPQAlzS285s4U2Qebn4p9rAYQrf5/ZXh6aByaqLgyyq+fXb2eS34nduQRGZDNR1wUfHN0e+Un06LAqR1U99I/X9w14jDFwHvKZAKVnO7Pzqr67MjB/PbPzmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3oDwvai; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-482f2599980so32147105e9.0
        for <cgroups@vger.kernel.org>; Fri, 06 Feb 2026 17:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770427674; x=1771032474; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PE7gzxqot5BRL9QsDMUVjbbKM2mWn3uLSLIy5IeNUqk=;
        b=X3oDwvaitOrPWfAspkuM7sC/N1oHMIy0lYNVzqit9yWuNDfD1Rg3stxhDxTGy1nMOh
         itotSTB/PRn2SzDQO8SPUNaYufxvN1DNo7VDAf03H8mF0swR6gsRHdWxFThslRMlDurB
         LHKwqkhtOahcuhz1U/4id311/0XCUixdzpEJG5W1mn5cfjwJ9ZnU7cgScGgLbZp0xuMx
         EGXYySZwnkCqa5Y7zQihE66lnxQfXqroieysWqMWS0XewWJ3bHdAGWbfc7pOKHjIieRv
         8R/aOWoVFxrEffpxkmm0knTHZCm9Bv8w1utmVv0qZyY2NWGgf1SzqbAmmPHWP4dDUQNa
         b6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770427674; x=1771032474;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PE7gzxqot5BRL9QsDMUVjbbKM2mWn3uLSLIy5IeNUqk=;
        b=ia/1/NaH3QaIlE+4ew/L6+10uICxQKN8Im+bVICnxLLmIDktp9GJUd3KjgvwMXmWLU
         MjJw8+xRsg4DGCAqfHvQJF6Rgau4hZEv1CAs2U88VnOM/en72sFfJvVLlRl+YIkL6yxf
         XFopKr5UpltmbeCBEZuDi6G1GeiJouxMeYk+zf7UHMiU7Ok/EypKAweBkWL2g5SGHiA/
         8rrMT3VMiGYFRN6GEMgPeIC/MQsNtecW3/XAWJ3HulEKUzbrhdeJiv1O+6L0AnxnVvTv
         nwhSRRUaLTx4SszQJk4eHuErC3W+uWjC88QvU4Hx1b84p++iM2oucv5PKozfpsRpo1WZ
         grzA==
X-Forwarded-Encrypted: i=1; AJvYcCVpQO41gXWx10CZi8ZzAMy4Dxbf92vlRRkhY62jeKQVLxzWc7eCYwDOcELoQGmcHYuC0Flq8/qh@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/P146vkpSOjhRA502UbrcBpD5a5XgtpMOzYmv9eyD7I4lei6K
	ERUHCVU18t19bmyDLxGv0cMuayV9mR4diJQp2gBp1QSCHwkDML9qo2dq
X-Gm-Gg: AZuq6aLgvRxDrxo7uCyL3RH3WdxnCATo3RbtBxPq400TLzJIkDLb7PmWUvkCOOFRiJR
	rrlf/1/RBNlyy8N0jroPaKN9Z0E/grd4Oi+iCM9PTJUiqaz81oKySfRptfhWGAevbzBPs8TdjWM
	gbBu3ib1EKPrI7m5oJDIt8JpVABybV06EK3u0wOjaFYQVsDo6yTA878BBcHgq5Z1jpxop3GFtwz
	GMccEBCPqC1Md0ouQLDHZFoT+MrRJuRuong7lLOaPFSZ6+DSseBKmRDo4PKBCBeq3cKJ3DcC7oy
	Uaj6s9WGQuDKJg3InFQ5PeKQ/QQH0Aqz/oI9P0i4KzSrw4cbrVEGPAOywqq2dSum05aifisX9nA
	h+yH+jrGHcwxKI1glOLUl1g2S35472/+PiqIh4tlHjYCWUvdjoaAMDL3FySnw6zN5F7CKSJWyJQ
	+Z7c1zx2vM24yjvcxnVkduGh8=
X-Received: by 2002:a05:600c:35d1:b0:480:3a72:524a with SMTP id 5b1f17b1804b1-4832021b572mr58580195e9.19.1770427674181;
        Fri, 06 Feb 2026 17:27:54 -0800 (PST)
Received: from WindFlash.powerhub ([2a0a:ef40:1b2a:fa01:9944:6a8c:dc37:eba5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629756bc3sm8833460f8f.39.2026.02.06.17.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 17:27:53 -0800 (PST)
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
Subject: Re: [PATCH 4/4] slub: apply new queue_percpu_work_on() interface
Date: Fri,  6 Feb 2026 22:27:39 -0300
Message-ID: <aYaVC11FZ1XOxMl2@WindFlash>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206143741.621816322@redhat.com>
References: <20260206143430.021026873@redhat.com> <20260206143741.621816322@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13762-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1F08104810
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 11:34:34AM -0300, Marcelo Tosatti wrote:
> Make use of the new qpw_{un,}lock*() and queue_percpu_work_on()
> interface to improve performance & latency on PREEMPT_RT kernels.
> 
> For functions that may be scheduled in a different cpu, replace
> local_{un,}lock*() by qpw_{un,}lock*(), and replace schedule_work_on() by
> queue_percpu_work_on(). The same happens for flush_work() and
> flush_percpu_work().
> 
> This change requires allocation of qpw_structs instead of a work_structs,
> and changing parameters of a few functions to include the cpu parameter.
> 
> This should bring no relevant performance impact on non-RT kernels:

Same as prev patch

> For functions that may be scheduled in a different cpu, the local_*lock's
> this_cpu_ptr() becomes a per_cpu_ptr(smp_processor_id()).
> 
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---
>  mm/slub.c |  218 ++++++++++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 142 insertions(+), 76 deletions(-)
> 
> Index: slab/mm/slub.c
> ===================================================================
> --- slab.orig/mm/slub.c
> +++ slab/mm/slub.c
> @@ -49,6 +49,7 @@
>  #include <linux/irq_work.h>
>  #include <linux/kprobes.h>
>  #include <linux/debugfs.h>
> +#include <linux/qpw.h>
>  #include <trace/events/kmem.h>
>  
>  #include "internal.h"
> @@ -128,7 +129,7 @@
>   *   For debug caches, all allocations are forced to go through a list_lock
>   *   protected region to serialize against concurrent validation.
>   *
> - *   cpu_sheaves->lock (local_trylock)
> + *   cpu_sheaves->lock (qpw_trylock)
>   *
>   *   This lock protects fastpath operations on the percpu sheaves. On !RT it
>   *   only disables preemption and does no atomic operations. As long as the main
> @@ -156,7 +157,7 @@
>   *   Interrupts are disabled as part of list_lock or barn lock operations, or
>   *   around the slab_lock operation, in order to make the slab allocator safe
>   *   to use in the context of an irq.
> - *   Preemption is disabled as part of local_trylock operations.
> + *   Preemption is disabled as part of qpw_trylock operations.
>   *   kmalloc_nolock() and kfree_nolock() are safe in NMI context but see
>   *   their limitations.
>   *
> @@ -417,7 +418,7 @@ struct slab_sheaf {
>  };
>  
>  struct slub_percpu_sheaves {
> -	local_trylock_t lock;
> +	qpw_trylock_t lock;
>  	struct slab_sheaf *main; /* never NULL when unlocked */
>  	struct slab_sheaf *spare; /* empty or full, may be NULL */
>  	struct slab_sheaf *rcu_free; /* for batching kfree_rcu() */
> @@ -479,7 +480,7 @@ static nodemask_t slab_nodes;
>  static struct workqueue_struct *flushwq;
>  
>  struct slub_flush_work {
> -	struct work_struct work;
> +	struct qpw_struct qpw;
>  	struct kmem_cache *s;
>  	bool skip;
>  };
> @@ -2826,7 +2827,7 @@ static void __kmem_cache_free_bulk(struc
>   *
>   * returns true if at least partially flushed
>   */
> -static bool sheaf_flush_main(struct kmem_cache *s)
> +static bool sheaf_flush_main(struct kmem_cache *s, int cpu)
>  {
>  	struct slub_percpu_sheaves *pcs;
>  	unsigned int batch, remaining;
> @@ -2835,10 +2836,10 @@ static bool sheaf_flush_main(struct kmem
>  	bool ret = false;
>  
>  next_batch:
> -	if (!local_trylock(&s->cpu_sheaves->lock))
> +	if (!qpw_trylock(&s->cpu_sheaves->lock, cpu))
>  		return ret;
>  
> -	pcs = this_cpu_ptr(s->cpu_sheaves);
> +	pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
>  	sheaf = pcs->main;
>  
>  	batch = min(PCS_BATCH_MAX, sheaf->size);
> @@ -2848,7 +2849,7 @@ next_batch:
>  
>  	remaining = sheaf->size;
>  
> -	local_unlock(&s->cpu_sheaves->lock);
> +	qpw_unlock(&s->cpu_sheaves->lock, cpu);
>  
>  	__kmem_cache_free_bulk(s, batch, &objects[0]);
>  
> @@ -2932,13 +2933,13 @@ static void rcu_free_sheaf_nobarn(struct
>   * flushing operations are rare so let's keep it simple and flush to slabs
>   * directly, skipping the barn
>   */
> -static void pcs_flush_all(struct kmem_cache *s)
> +static void pcs_flush_all(struct kmem_cache *s, int cpu)
>  {
>  	struct slub_percpu_sheaves *pcs;
>  	struct slab_sheaf *spare, *rcu_free;
>  
> -	local_lock(&s->cpu_sheaves->lock);
> -	pcs = this_cpu_ptr(s->cpu_sheaves);
> +	qpw_lock(&s->cpu_sheaves->lock, cpu);
> +	pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
>  
>  	spare = pcs->spare;
>  	pcs->spare = NULL;
> @@ -2946,7 +2947,7 @@ static void pcs_flush_all(struct kmem_ca
>  	rcu_free = pcs->rcu_free;
>  	pcs->rcu_free = NULL;
>  
> -	local_unlock(&s->cpu_sheaves->lock);
> +	qpw_unlock(&s->cpu_sheaves->lock, cpu);
>  
>  	if (spare) {
>  		sheaf_flush_unused(s, spare);
> @@ -2956,7 +2957,7 @@ static void pcs_flush_all(struct kmem_ca
>  	if (rcu_free)
>  		call_rcu(&rcu_free->rcu_head, rcu_free_sheaf_nobarn);
>  
> -	sheaf_flush_main(s);
> +	sheaf_flush_main(s, cpu);
>  }
>  
>  static void __pcs_flush_all_cpu(struct kmem_cache *s, unsigned int cpu)
> @@ -3881,13 +3882,13 @@ static void flush_cpu_sheaves(struct wor
>  {
>  	struct kmem_cache *s;
>  	struct slub_flush_work *sfw;
> +	int cpu = qpw_get_cpu(w);
>  
> -	sfw = container_of(w, struct slub_flush_work, work);
> -
> +	sfw = &per_cpu(slub_flush, cpu);
>  	s = sfw->s;
>  
>  	if (cache_has_sheaves(s))
> -		pcs_flush_all(s);
> +		pcs_flush_all(s, cpu);
>  }
>  
>  static void flush_all_cpus_locked(struct kmem_cache *s)
> @@ -3904,17 +3905,17 @@ static void flush_all_cpus_locked(struct
>  			sfw->skip = true;
>  			continue;
>  		}
> -		INIT_WORK(&sfw->work, flush_cpu_sheaves);
> +		INIT_QPW(&sfw->qpw, flush_cpu_sheaves, cpu);
>  		sfw->skip = false;
>  		sfw->s = s;
> -		queue_work_on(cpu, flushwq, &sfw->work);
> +		queue_percpu_work_on(cpu, flushwq, &sfw->qpw);
>  	}
>  
>  	for_each_online_cpu(cpu) {
>  		sfw = &per_cpu(slub_flush, cpu);
>  		if (sfw->skip)
>  			continue;
> -		flush_work(&sfw->work);
> +		flush_percpu_work(&sfw->qpw);
>  	}
>  
>  	mutex_unlock(&flush_lock);
> @@ -3933,17 +3934,18 @@ static void flush_rcu_sheaf(struct work_
>  	struct slab_sheaf *rcu_free;
>  	struct slub_flush_work *sfw;
>  	struct kmem_cache *s;
> +	int cpu = qpw_get_cpu(w);
>  
> -	sfw = container_of(w, struct slub_flush_work, work);
> +	sfw = &per_cpu(slub_flush, cpu);
>  	s = sfw->s;
>  
> -	local_lock(&s->cpu_sheaves->lock);
> -	pcs = this_cpu_ptr(s->cpu_sheaves);
> +	qpw_lock(&s->cpu_sheaves->lock, cpu);
> +	pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
>  
>  	rcu_free = pcs->rcu_free;
>  	pcs->rcu_free = NULL;
>  
> -	local_unlock(&s->cpu_sheaves->lock);
> +	qpw_unlock(&s->cpu_sheaves->lock, cpu);
>  
>  	if (rcu_free)
>  		call_rcu(&rcu_free->rcu_head, rcu_free_sheaf_nobarn);
> @@ -3968,14 +3970,14 @@ void flush_rcu_sheaves_on_cache(struct k
>  		 * sure the __kfree_rcu_sheaf() finished its call_rcu()
>  		 */
>  
> -		INIT_WORK(&sfw->work, flush_rcu_sheaf);
> +		INIT_QPW(&sfw->qpw, flush_rcu_sheaf, cpu);
>  		sfw->s = s;
> -		queue_work_on(cpu, flushwq, &sfw->work);
> +		queue_percpu_work_on(cpu, flushwq, &sfw->qpw);
>  	}
>  
>  	for_each_online_cpu(cpu) {
>  		sfw = &per_cpu(slub_flush, cpu);
> -		flush_work(&sfw->work);
> +		flush_percpu_work(&sfw->qpw);
>  	}
>  
>  	mutex_unlock(&flush_lock);
> @@ -4472,22 +4474,24 @@ bool slab_post_alloc_hook(struct kmem_ca
>   *
>   * Must be called with the cpu_sheaves local lock locked. If successful, returns
>   * the pcs pointer and the local lock locked (possibly on a different cpu than
> - * initially called). If not successful, returns NULL and the local lock
> - * unlocked.
> + * initially called), and migration disabled. If not successful, returns NULL
> + * and the local lock unlocked, with migration enabled.
>   */
>  static struct slub_percpu_sheaves *
> -__pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs, gfp_t gfp)
> +__pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs, gfp_t gfp,
> +			 int *cpu)
>  {
>  	struct slab_sheaf *empty = NULL;
>  	struct slab_sheaf *full;
>  	struct node_barn *barn;
>  	bool can_alloc;
>  
> -	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
> +	qpw_lockdep_assert_held(&s->cpu_sheaves->lock);
>  
>  	/* Bootstrap or debug cache, back off */
>  	if (unlikely(!cache_has_sheaves(s))) {
> -		local_unlock(&s->cpu_sheaves->lock);
> +		qpw_unlock(&s->cpu_sheaves->lock, *cpu);
> +		migrate_enable();
>  		return NULL;
>  	}
>  
> @@ -4498,7 +4502,8 @@ __pcs_replace_empty_main(struct kmem_cac
>  
>  	barn = get_barn(s);
>  	if (!barn) {
> -		local_unlock(&s->cpu_sheaves->lock);
> +		qpw_unlock(&s->cpu_sheaves->lock, *cpu);
> +		migrate_enable();
>  		return NULL;
>  	}
>  
> @@ -4524,7 +4529,8 @@ __pcs_replace_empty_main(struct kmem_cac
>  		}
>  	}
>  
> -	local_unlock(&s->cpu_sheaves->lock);
> +	qpw_unlock(&s->cpu_sheaves->lock, *cpu);
> +	migrate_enable();
>  
>  	if (!can_alloc)
>  		return NULL;
> @@ -4550,7 +4556,9 @@ __pcs_replace_empty_main(struct kmem_cac
>  	 * we can reach here only when gfpflags_allow_blocking
>  	 * so this must not be an irq
>  	 */
> -	local_lock(&s->cpu_sheaves->lock);
> +	migrate_disable();
> +	*cpu = smp_processor_id();
> +	qpw_lock(&s->cpu_sheaves->lock, *cpu);
>  	pcs = this_cpu_ptr(s->cpu_sheaves);
>  
>  	/*
> @@ -4593,6 +4601,7 @@ void *alloc_from_pcs(struct kmem_cache *
>  	struct slub_percpu_sheaves *pcs;
>  	bool node_requested;
>  	void *object;
> +	int cpu;
>  
>  #ifdef CONFIG_NUMA
>  	if (static_branch_unlikely(&strict_numa) &&
> @@ -4627,13 +4636,17 @@ void *alloc_from_pcs(struct kmem_cache *
>  		return NULL;
>  	}
>  
> -	if (!local_trylock(&s->cpu_sheaves->lock))
> +	migrate_disable();
> +	cpu = smp_processor_id();
> +	if (!qpw_trylock(&s->cpu_sheaves->lock, cpu)) {
> +		migrate_enable();
>  		return NULL;
> +	}
>  
>  	pcs = this_cpu_ptr(s->cpu_sheaves);
>  
>  	if (unlikely(pcs->main->size == 0)) {
> -		pcs = __pcs_replace_empty_main(s, pcs, gfp);
> +		pcs = __pcs_replace_empty_main(s, pcs, gfp, &cpu);
>  		if (unlikely(!pcs))
>  			return NULL;
>  	}
> @@ -4647,7 +4660,8 @@ void *alloc_from_pcs(struct kmem_cache *
>  		 * the current allocation or previous freeing process.
>  		 */
>  		if (page_to_nid(virt_to_page(object)) != node) {
> -			local_unlock(&s->cpu_sheaves->lock);
> +			qpw_unlock(&s->cpu_sheaves->lock, cpu);
> +			migrate_enable();
>  			stat(s, ALLOC_NODE_MISMATCH);
>  			return NULL;
>  		}
> @@ -4655,7 +4669,8 @@ void *alloc_from_pcs(struct kmem_cache *
>  
>  	pcs->main->size--;
>  
> -	local_unlock(&s->cpu_sheaves->lock);
> +	qpw_unlock(&s->cpu_sheaves->lock, cpu);
> +	migrate_enable();
>  
>  	stat(s, ALLOC_FASTPATH);
>  
> @@ -4670,10 +4685,15 @@ unsigned int alloc_from_pcs_bulk(struct
>  	struct slab_sheaf *main;
>  	unsigned int allocated = 0;
>  	unsigned int batch;
> +	int cpu;
>  
>  next_batch:
> -	if (!local_trylock(&s->cpu_sheaves->lock))
> +	migrate_disable();
> +	cpu = smp_processor_id();
> +	if (!qpw_trylock(&s->cpu_sheaves->lock, cpu)) {
> +		migrate_enable();
>  		return allocated;
> +	}
>  
>  	pcs = this_cpu_ptr(s->cpu_sheaves);
>  
> @@ -4683,7 +4703,8 @@ next_batch:
>  		struct node_barn *barn;
>  
>  		if (unlikely(!cache_has_sheaves(s))) {
> -			local_unlock(&s->cpu_sheaves->lock);
> +			qpw_unlock(&s->cpu_sheaves->lock, cpu);
> +			migrate_enable();
>  			return allocated;
>  		}
>  
> @@ -4694,7 +4715,8 @@ next_batch:
>  
>  		barn = get_barn(s);
>  		if (!barn) {
> -			local_unlock(&s->cpu_sheaves->lock);
> +			qpw_unlock(&s->cpu_sheaves->lock, cpu);
> +			migrate_enable();
>  			return allocated;
>  		}
>  
> @@ -4709,7 +4731,8 @@ next_batch:
>  
>  		stat(s, BARN_GET_FAIL);
>  
> -		local_unlock(&s->cpu_sheaves->lock);
> +		qpw_unlock(&s->cpu_sheaves->lock, cpu);
> +		migrate_enable();
>  
>  		/*
>  		 * Once full sheaves in barn are depleted, let the bulk
> @@ -4727,7 +4750,8 @@ do_alloc:
>  	main->size -= batch;
>  	memcpy(p, main->objects + main->size, batch * sizeof(void *));
>  
> -	local_unlock(&s->cpu_sheaves->lock);
> +	qpw_unlock(&s->cpu_sheaves->lock, cpu);
> +	migrate_enable();
>  
>  	stat_add(s, ALLOC_FASTPATH, batch);
>  
> @@ -4877,6 +4901,7 @@ kmem_cache_prefill_sheaf(struct kmem_cac
>  	struct slub_percpu_sheaves *pcs;
>  	struct slab_sheaf *sheaf = NULL;
>  	struct node_barn *barn;
> +	int cpu;
>  
>  	if (unlikely(!size))
>  		return NULL;
> @@ -4906,7 +4931,9 @@ kmem_cache_prefill_sheaf(struct kmem_cac
>  		return sheaf;
>  	}
>  
> -	local_lock(&s->cpu_sheaves->lock);
> +	migrate_disable();
> +	cpu = smp_processor_id();
> +	qpw_lock(&s->cpu_sheaves->lock, cpu);
>  	pcs = this_cpu_ptr(s->cpu_sheaves);
>  
>  	if (pcs->spare) {
> @@ -4925,7 +4952,8 @@ kmem_cache_prefill_sheaf(struct kmem_cac
>  			stat(s, BARN_GET_FAIL);
>  	}
>  
> -	local_unlock(&s->cpu_sheaves->lock);
> +	qpw_unlock(&s->cpu_sheaves->lock, cpu);
> +	migrate_enable();
>  
>  
>  	if (!sheaf)
> @@ -4961,6 +4989,7 @@ void kmem_cache_return_sheaf(struct kmem
>  {
>  	struct slub_percpu_sheaves *pcs;
>  	struct node_barn *barn;
> +	int cpu;
>  
>  	if (unlikely((sheaf->capacity != s->sheaf_capacity)
>  		     || sheaf->pfmemalloc)) {
> @@ -4969,7 +4998,9 @@ void kmem_cache_return_sheaf(struct kmem
>  		return;
>  	}
>  
> -	local_lock(&s->cpu_sheaves->lock);
> +	migrate_disable();
> +	cpu = smp_processor_id();
> +	qpw_lock(&s->cpu_sheaves->lock, cpu);
>  	pcs = this_cpu_ptr(s->cpu_sheaves);
>  	barn = get_barn(s);
>  
> @@ -4979,7 +5010,8 @@ void kmem_cache_return_sheaf(struct kmem
>  		stat(s, SHEAF_RETURN_FAST);
>  	}
>  
> -	local_unlock(&s->cpu_sheaves->lock);
> +	qpw_unlock(&s->cpu_sheaves->lock, cpu);
> +	migrate_enable();
>  
>  	if (!sheaf)
>  		return;
> @@ -5507,9 +5539,9 @@ slab_empty:
>   */
>  static void __pcs_install_empty_sheaf(struct kmem_cache *s,
>  		struct slub_percpu_sheaves *pcs, struct slab_sheaf *empty,
> -		struct node_barn *barn)
> +		struct node_barn *barn, int cpu)
>  {
> -	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
> +	qpw_lockdep_assert_held(&s->cpu_sheaves->lock);
>  
>  	/* This is what we expect to find if nobody interrupted us. */
>  	if (likely(!pcs->spare)) {
> @@ -5546,31 +5578,34 @@ static void __pcs_install_empty_sheaf(st
>  /*
>   * Replace the full main sheaf with a (at least partially) empty sheaf.
>   *
> - * Must be called with the cpu_sheaves local lock locked. If successful, returns
> - * the pcs pointer and the local lock locked (possibly on a different cpu than
> - * initially called). If not successful, returns NULL and the local lock
> - * unlocked.
> + * Must be called with the cpu_sheaves local lock locked, and migration counter

					   ^~ qpw?	

> + * increased. If successful, returns the pcs pointer and the local lock locked
> + * (possibly on a different cpu than initially called), with migration counter
> + * increased. If not successful, returns NULL and the local lock unlocked,

					   		   ^~ qpw?

> + * and migration counter decreased.
>   */
>  static struct slub_percpu_sheaves *
>  __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
> -			bool allow_spin)
> +			bool allow_spin, int *cpu)
>  {
>  	struct slab_sheaf *empty;
>  	struct node_barn *barn;
>  	bool put_fail;
>  
>  restart:
> -	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
> +	qpw_lockdep_assert_held(&s->cpu_sheaves->lock);
>  
>  	/* Bootstrap or debug cache, back off */
>  	if (unlikely(!cache_has_sheaves(s))) {
> -		local_unlock(&s->cpu_sheaves->lock);
> +		qpw_unlock(&s->cpu_sheaves->lock, *cpu);
> +		migrate_enable();
>  		return NULL;
>  	}
>  
>  	barn = get_barn(s);
>  	if (!barn) {
> -		local_unlock(&s->cpu_sheaves->lock);
> +		qpw_unlock(&s->cpu_sheaves->lock, *cpu);
> +		migrate_enable();
>  		return NULL;
>  	}
>  
> @@ -5607,7 +5642,8 @@ restart:
>  		stat(s, BARN_PUT_FAIL);
>  
>  		pcs->spare = NULL;
> -		local_unlock(&s->cpu_sheaves->lock);
> +		qpw_unlock(&s->cpu_sheaves->lock, *cpu);
> +		migrate_enable();
>  
>  		sheaf_flush_unused(s, to_flush);
>  		empty = to_flush;
> @@ -5623,7 +5659,8 @@ restart:
>  	put_fail = true;
>  
>  alloc_empty:
> -	local_unlock(&s->cpu_sheaves->lock);
> +	qpw_unlock(&s->cpu_sheaves->lock, *cpu);
> +	migrate_enable();
>  
>  	/*
>  	 * alloc_empty_sheaf() doesn't support !allow_spin and it's
> @@ -5640,11 +5677,17 @@ alloc_empty:
>  	if (put_fail)
>  		 stat(s, BARN_PUT_FAIL);
>  
> -	if (!sheaf_flush_main(s))
> +	migrate_disable();
> +	*cpu = smp_processor_id();
> +	if (!sheaf_flush_main(s, *cpu)) {
> +		migrate_enable();
>  		return NULL;
> +	}
>  
> -	if (!local_trylock(&s->cpu_sheaves->lock))
> +	if (!qpw_trylock(&s->cpu_sheaves->lock, *cpu)) {
> +		migrate_enable();
>  		return NULL;
> +	}
>  
>  	pcs = this_cpu_ptr(s->cpu_sheaves);
>  
> @@ -5659,13 +5702,14 @@ alloc_empty:
>  	return pcs;
>  
>  got_empty:
> -	if (!local_trylock(&s->cpu_sheaves->lock)) {
> +	if (!qpw_trylock(&s->cpu_sheaves->lock, *cpu)) {
> +		migrate_enable();
>  		barn_put_empty_sheaf(barn, empty);
>  		return NULL;
>  	}
>  
>  	pcs = this_cpu_ptr(s->cpu_sheaves);
> -	__pcs_install_empty_sheaf(s, pcs, empty, barn);
> +	__pcs_install_empty_sheaf(s, pcs, empty, barn, *cpu);
>  
>  	return pcs;
>  }
> @@ -5678,22 +5722,28 @@ static __fastpath_inline
>  bool free_to_pcs(struct kmem_cache *s, void *object, bool allow_spin)
>  {
>  	struct slub_percpu_sheaves *pcs;
> +	int cpu;
>  
> -	if (!local_trylock(&s->cpu_sheaves->lock))
> +	migrate_disable();
> +	cpu = smp_processor_id();
> +	if (!qpw_trylock(&s->cpu_sheaves->lock, cpu)) {
> +		migrate_enable();
>  		return false;
> +	}
>  
>  	pcs = this_cpu_ptr(s->cpu_sheaves);
>  
>  	if (unlikely(pcs->main->size == s->sheaf_capacity)) {
>  
> -		pcs = __pcs_replace_full_main(s, pcs, allow_spin);
> +		pcs = __pcs_replace_full_main(s, pcs, allow_spin, &cpu);
>  		if (unlikely(!pcs))
>  			return false;
>  	}
>  
>  	pcs->main->objects[pcs->main->size++] = object;
>  
> -	local_unlock(&s->cpu_sheaves->lock);
> +	qpw_unlock(&s->cpu_sheaves->lock, cpu);
> +	migrate_enable();
>  
>  	stat(s, FREE_FASTPATH);
>  
> @@ -5777,14 +5827,19 @@ bool __kfree_rcu_sheaf(struct kmem_cache
>  {
>  	struct slub_percpu_sheaves *pcs;
>  	struct slab_sheaf *rcu_sheaf;
> +	int cpu;
>  
>  	if (WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT)))
>  		return false;
>  
>  	lock_map_acquire_try(&kfree_rcu_sheaf_map);
>  
> -	if (!local_trylock(&s->cpu_sheaves->lock))
> +	migrate_disable();
> +	cpu = smp_processor_id();
> +	if (!qpw_trylock(&s->cpu_sheaves->lock, cpu)) {
> +		migrate_enable();
>  		goto fail;
> +	}
>  
>  	pcs = this_cpu_ptr(s->cpu_sheaves);
>  
> @@ -5795,7 +5850,8 @@ bool __kfree_rcu_sheaf(struct kmem_cache
>  
>  		/* Bootstrap or debug cache, fall back */
>  		if (unlikely(!cache_has_sheaves(s))) {
> -			local_unlock(&s->cpu_sheaves->lock);
> +			qpw_unlock(&s->cpu_sheaves->lock, cpu);
> +			migrate_enable();
>  			goto fail;
>  		}
>  
> @@ -5807,7 +5863,8 @@ bool __kfree_rcu_sheaf(struct kmem_cache
>  
>  		barn = get_barn(s);
>  		if (!barn) {
> -			local_unlock(&s->cpu_sheaves->lock);
> +			qpw_unlock(&s->cpu_sheaves->lock, cpu);
> +			migrate_enable();
>  			goto fail;
>  		}
>  
> @@ -5818,15 +5875,18 @@ bool __kfree_rcu_sheaf(struct kmem_cache
>  			goto do_free;
>  		}
>  
> -		local_unlock(&s->cpu_sheaves->lock);
> +		qpw_unlock(&s->cpu_sheaves->lock, cpu);
> +		migrate_enable();
>  
>  		empty = alloc_empty_sheaf(s, GFP_NOWAIT);
>  
>  		if (!empty)
>  			goto fail;
>  
> -		if (!local_trylock(&s->cpu_sheaves->lock)) {
> +		migrate_disable();
> +		if (!qpw_trylock(&s->cpu_sheaves->lock, cpu)) {
>  			barn_put_empty_sheaf(barn, empty);
> +			migrate_enable();
>  			goto fail;
>  		}
>  
> @@ -5862,7 +5922,8 @@ do_free:
>  	if (rcu_sheaf)
>  		call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
>  
> -	local_unlock(&s->cpu_sheaves->lock);
> +	qpw_unlock(&s->cpu_sheaves->lock, cpu);
> +	migrate_enable();
>  
>  	stat(s, FREE_RCU_SHEAF);
>  	lock_map_release(&kfree_rcu_sheaf_map);
> @@ -5889,6 +5950,7 @@ static void free_to_pcs_bulk(struct kmem
>  	void *remote_objects[PCS_BATCH_MAX];
>  	unsigned int remote_nr = 0;
>  	int node = numa_mem_id();
> +	int cpu;
>  
>  next_remote_batch:
>  	while (i < size) {
> @@ -5918,7 +5980,9 @@ next_remote_batch:
>  		goto flush_remote;
>  
>  next_batch:
> -	if (!local_trylock(&s->cpu_sheaves->lock))
> +	migrate_disable();
> +	cpu = smp_processor_id();
> +	if (!qpw_trylock(&s->cpu_sheaves->lock, cpu))
>  		goto fallback;
>  
>  	pcs = this_cpu_ptr(s->cpu_sheaves);
> @@ -5961,7 +6025,8 @@ do_free:
>  	memcpy(main->objects + main->size, p, batch * sizeof(void *));
>  	main->size += batch;
>  
> -	local_unlock(&s->cpu_sheaves->lock);
> +	qpw_unlock(&s->cpu_sheaves->lock, cpu);
> +	migrate_enable();
>  
>  	stat_add(s, FREE_FASTPATH, batch);
>  
> @@ -5977,7 +6042,8 @@ do_free:
>  	return;
>  
>  no_empty:
> -	local_unlock(&s->cpu_sheaves->lock);
> +	qpw_unlock(&s->cpu_sheaves->lock, cpu);
> +	migrate_enable();
>  
>  	/*
>  	 * if we depleted all empty sheaves in the barn or there are too
> @@ -7377,7 +7443,7 @@ static int init_percpu_sheaves(struct km
>  
>  		pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
>  
> -		local_trylock_init(&pcs->lock);
> +		qpw_trylock_init(&pcs->lock);
>  
>  		/*
>  		 * Bootstrap sheaf has zero size so fast-path allocation fails.
> 
> 


Conversions look correct.

I have some ideas, but I am still not sure about the need of 
migrate_*able() here, but if they are indeed needed, I think we should work 
on having them inside helpers that are special for local_cpu-only 
functions, instead of happening on user code like this.

What do you think?

Thanks for getting this upstream!
Leo

