Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB9042FA97
	for <lists+cgroups@lfdr.de>; Fri, 15 Oct 2021 19:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242360AbhJOR5n (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Oct 2021 13:57:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48750 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242303AbhJOR5l (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Oct 2021 13:57:41 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 17DF21FD4F;
        Fri, 15 Oct 2021 17:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634320533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4jBn2VNfaCZDHefss5Z1r9mqIdP3xRVwotwlK+Rm7xY=;
        b=n1K8M3Dt3d5TeTHwFKotWO6NgpCUxVj9yloDRCzY2ACk+N04k0IsJk9kqYAIr5CkXCtahO
        nlU9a0EBiwuhBPySCxctmkoH2iaJWzcfoYspQAfFg6jbjBTLBTW345dDdKwJR+lFFJ2ZBN
        k3qq64TE8yeQUYARubZvGlGdIcnGP1c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F13F413C6F;
        Fri, 15 Oct 2021 17:55:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id d+pMOpTAaWHgJQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 15 Oct 2021 17:55:32 +0000
Date:   Fri, 15 Oct 2021 19:55:31 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org
Subject: Re: [PATCH v2 1/2] memcg: flush stats only if updated
Message-ID: <20211015175531.GB46263@blackbody.suse.cz>
References: <20211013180130.GB22036@blackbody.suse.cz>
 <20211014163146.2177266-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014163146.2177266-1-shakeelb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 14, 2021 at 09:31:46AM -0700, Shakeel Butt <shakeelb@google.com> wrote:
> Thanks for your review. This forces me to think more on this because each
> update does not necessarily be a single page sized update e.g. adding a hugepage
> to an LRU.

Aha, hugepages... (I also noticed that on the opposite size scale are
NR_SLAB_{UN,}RECLAIMABLE_B, the complementary problem to too big error
would be too frequent flushes.)

> Though I think the error is time bounded by 2 seconds but in those 2 seconds
> mathematically the error can be large.

Honestly, I can't tell how much the (transient) errors in various
node_stat_item entries will or won't affect MM behavior. But having some
guards on it sounds practical when some problems to troubleshoot arise.

> What do you think of the following change? It will bound the error
> better within the 2 seconds window.
> [...]
> -static inline void memcg_rstat_updated(struct mem_cgroup *memcg)
> +static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
>  {
> +	unsigned int x;
> +
>  	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id());
> -	if (!(__this_cpu_inc_return(stats_updates) % MEMCG_CHARGE_BATCH))
> -		atomic_inc(&stats_flush_threshold);
> +
> +	x = abs(__this_cpu_add_return(stats_diff, val));
> +	if (x > MEMCG_CHARGE_BATCH) {
> +		atomic_add(x / MEMCG_CHARGE_BATCH, &stats_flush_threshold);
> +		__this_cpu_write(stats_diff, 0);
> +	}
>  }

Looks better wrt meaningful error calculation (and hopefully still
doesn't add too much to the hot path).

> @@ -807,7 +813,7 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
>  		return;
>  
>  	__this_cpu_add(memcg->vmstats_percpu->events[idx], count);
> -	memcg_rstat_updated(memcg);
> +	memcg_rstat_updated(memcg, val);

s/val/count/

(Just thinking loudly.) At one moment I thought, it could
effectively be even s/val/0/ since events aren't(?) inputs for reclaim
calculations. But with the introduced stats_diff it may happen
stats_diff flickers (its abs value) within the MEMCG_CHARGE_BATCH and
stats_flush_threshold would never be incremented. Basically disabling
the periodic flush. Therefore the events must also increment the
stats_diff.

