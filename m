Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F6A5A9AC3
	for <lists+cgroups@lfdr.de>; Thu,  1 Sep 2022 16:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbiIAOqY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Sep 2022 10:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiIAOqE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Sep 2022 10:46:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547E875CF8;
        Thu,  1 Sep 2022 07:46:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 82A1F2015A;
        Thu,  1 Sep 2022 14:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662043559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d7JBI/07yd8WyaO8RcKiT0B2kXWtniRx5v9bl5XBNpQ=;
        b=GS1zPTgzUE7SA44v31qD+AF4XlSoLr11tpr0vjqCs+efGkDBBFb84tSlbKYIVFvq+9Bbxg
        1gChdqfyylgk0jM/3/KNCh57buu3X/Asiq54vFxcf6MyZrYILVJzzn+0uFG07K6PhaUaoX
        3+RP+L1VtsfNVpeMC7kf8MDnB3x4wgU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 629F413A79;
        Thu,  1 Sep 2022 14:45:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h5jOFafFEGPNZQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 01 Sep 2022 14:45:59 +0000
Date:   Thu, 1 Sep 2022 16:45:58 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 5/8] mm/memcontrol: Replace the PREEMPT_RT conditionals
Message-ID: <YxDFplJXPudU4AS7@dhcp22.suse.cz>
References: <20220825164131.402717-1-bigeasy@linutronix.de>
 <20220825164131.402717-6-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825164131.402717-6-bigeasy@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 25-08-22 18:41:28, Sebastian Andrzej Siewior wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Use VM_WARN_ON_IRQS_ENABLED() and preempt_disable/enable_nested() to
> replace the CONFIG_PREEMPT_RT #ifdeffery.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  mm/memcontrol.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b69979c9ced5c..d35b6fa560f0a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -597,25 +597,18 @@ static u64 flush_next_time;
>   */
>  static void memcg_stats_lock(void)
>  {
> -#ifdef CONFIG_PREEMPT_RT
> -      preempt_disable();
> -#else
> -      VM_BUG_ON(!irqs_disabled());
> -#endif
> +	preempt_disable_nested();
> +	VM_WARN_ON_IRQS_ENABLED();
>  }
>  
>  static void __memcg_stats_lock(void)
>  {
> -#ifdef CONFIG_PREEMPT_RT
> -      preempt_disable();
> -#endif
> +	preempt_disable_nested();
>  }
>  
>  static void memcg_stats_unlock(void)
>  {
> -#ifdef CONFIG_PREEMPT_RT
> -      preempt_enable();
> -#endif
> +	preempt_enable_nested();
>  }
>  
>  static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
> @@ -715,7 +708,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>  	 * interrupt context while other caller need to have disabled interrupt.
>  	 */
>  	__memcg_stats_lock();
> -	if (IS_ENABLED(CONFIG_DEBUG_VM) && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +	if (IS_ENABLED(CONFIG_DEBUG_VM)) {
>  		switch (idx) {
>  		case NR_ANON_MAPPED:
>  		case NR_FILE_MAPPED:
> @@ -725,7 +718,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>  			WARN_ON_ONCE(!in_task());
>  			break;
>  		default:
> -			WARN_ON_ONCE(!irqs_disabled());
> +			VM_WARN_ON_IRQS_ENABLED();
>  		}
>  	}
>  
> -- 
> 2.37.2

-- 
Michal Hocko
SUSE Labs
