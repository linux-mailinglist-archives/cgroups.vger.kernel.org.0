Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49D97CC002
	for <lists+cgroups@lfdr.de>; Tue, 17 Oct 2023 11:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbjJQJ56 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Oct 2023 05:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbjJQJ55 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Oct 2023 05:57:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDC99F;
        Tue, 17 Oct 2023 02:57:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BEB7F1FF08;
        Tue, 17 Oct 2023 09:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697536672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eEaZQ67ZzBmPtT089KzO2cV6RfUDc9ZCAirxkq78+uM=;
        b=t/rQxHkdtPkTtRiPUMVIT0XrLh5P7GUE4zyQ5ZmECf59dv62qzsb682J1jIiUSaPfxT+A6
        ZTb59IH/Mld8BYJ2k5Co7N6iJrODXm3+lFG8/N3rtXnYiVTSuR1HC1kYqz2xQvp/8ZINMV
        h1m/Db2d5w+ZVaz/zrA3miYQ58JvU0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697536672;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eEaZQ67ZzBmPtT089KzO2cV6RfUDc9ZCAirxkq78+uM=;
        b=9CP5jrkkBpcvwkMw+KfhpNFZ+knWHGX3JsS6yiZ2Hk9XxUTidm+LBFOEegVAojwRxCa/Xg
        cHfaT+fEdswDg/DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92CDE13597;
        Tue, 17 Oct 2023 09:57:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kzsOI6BaLmVTfgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 17 Oct 2023 09:57:52 +0000
Message-ID: <0588a0ed-f6b5-6365-8721-edb69b935a6c@suse.cz>
Date:   Tue, 17 Oct 2023 11:57:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/5] mm: kmem: optimize get_obj_cgroup_from_current()
Content-Language: en-US
To:     Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, shakeelb@google.com,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
References: <20231016221900.4031141-1-roman.gushchin@linux.dev>
 <20231016221900.4031141-2-roman.gushchin@linux.dev>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231016221900.4031141-2-roman.gushchin@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -11.10
X-Spamd-Result: default: False [-11.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[11];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/17/23 00:18, Roman Gushchin wrote:
> Manually inline memcg_kmem_bypass() and active_memcg() to speed up
> get_obj_cgroup_from_current() by avoiding duplicate in_task() checks
> and active_memcg() readings.

I guess the compiler could figure out most of it, except maybe the
active_memcg() after rcu_read_lock(), as I note below.

But anyway it's a single caller of memcg_kmem_bypass() so this makes sense.

> Also add a likely() macro to __get_obj_cgroup_from_memcg():
> obj_cgroup_tryget() should succeed at almost all times except a very
> unlikely race with the memcg deletion path.
> 
> Signed-off-by: Roman Gushchin (Cruise) <roman.gushchin@linux.dev>
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Acked-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/memcontrol.c | 34 ++++++++++++++--------------------
>  1 file changed, 14 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 9741d62d0424..16ac2a5838fb 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1068,19 +1068,6 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
>  }
>  EXPORT_SYMBOL(get_mem_cgroup_from_mm);
>  
> -static __always_inline bool memcg_kmem_bypass(void)
> -{
> -	/* Allow remote memcg charging from any context. */
> -	if (unlikely(active_memcg()))
> -		return false;
> -
> -	/* Memcg to charge can't be determined. */
> -	if (!in_task() || !current->mm || (current->flags & PF_KTHREAD))
> -		return true;
> -
> -	return false;
> -}
> -
>  /**
>   * mem_cgroup_iter - iterate over memory cgroup hierarchy
>   * @root: hierarchy root
> @@ -3007,7 +2994,7 @@ static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
>  
>  	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
>  		objcg = rcu_dereference(memcg->objcg);
> -		if (objcg && obj_cgroup_tryget(objcg))
> +		if (likely(objcg && obj_cgroup_tryget(objcg)))
>  			break;
>  		objcg = NULL;
>  	}
> @@ -3016,16 +3003,23 @@ static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
>  
>  __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
>  {
> -	struct obj_cgroup *objcg = NULL;
>  	struct mem_cgroup *memcg;
> +	struct obj_cgroup *objcg;
>  
> -	if (memcg_kmem_bypass())
> -		return NULL;
> +	if (in_task()) {
> +		memcg = current->active_memcg;
> +
> +		/* Memcg to charge can't be determined. */
> +		if (likely(!memcg) && (!current->mm || (current->flags & PF_KTHREAD)))
> +			return NULL;
> +	} else {
> +		memcg = this_cpu_read(int_active_memcg);
> +		if (likely(!memcg))
> +			return NULL;
> +	}
>  
>  	rcu_read_lock();
> -	if (unlikely(active_memcg()))
> -		memcg = active_memcg();

I guess the rcu_read_lock() has in theory prevented us from being migrated
to a different cpu after doing the !in_task()
this_cpu_read(int_active_memcg); and now we trust the reading outside of the
rcu lock, but it's ok because a) nothing prevented us from migrating cpu
after getting to the objcg anyway so we could end up with a wrong one, and
b) if we're not in_task() and thus read int_active_memcg, it means our
context is some interrupt handler that can't be migrated to another cpu
anyway, right?

> -	else
> +	if (!memcg)
>  		memcg = mem_cgroup_from_task(current);
>  	objcg = __get_obj_cgroup_from_memcg(memcg);
>  	rcu_read_unlock();

