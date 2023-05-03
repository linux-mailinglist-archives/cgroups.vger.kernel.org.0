Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041D06F53AB
	for <lists+cgroups@lfdr.de>; Wed,  3 May 2023 10:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjECIuf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 3 May 2023 04:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjECIue (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 3 May 2023 04:50:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2158F49EC;
        Wed,  3 May 2023 01:50:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 830AD2012C;
        Wed,  3 May 2023 08:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683103826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ul/eRvjJNwgzsz68pXRd2n0gAab7FZ4+JZMOpZQ7Fmk=;
        b=E7nOXGkagIHZAeNeXv4OHtyrZNiSq8kYNv3dg6Z3/iKRPimqxX4mNUFHjlbhast3Sr+l0x
        S06eHHL4eegbjynM0mgZaNwf9JzieFz4mXxbL1B7n8xyGEUlfx4ZO7HCcLwNGN2jbAY4N7
        BkidJsQJ7flwWWTqfT0qBXCtUacG1PM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 675BD13584;
        Wed,  3 May 2023 08:50:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zh85F1IgUmRbfQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 03 May 2023 08:50:26 +0000
Date:   Wed, 3 May 2023 10:50:25 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>, Chris Li <chrisl@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] memcg: dump memory.stat during cgroup OOM for v1
Message-ID: <ZFIgUfPrinUKLIVI@dhcp22.suse.cz>
References: <20230428132406.2540811-1-yosryahmed@google.com>
 <20230428132406.2540811-3-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428132406.2540811-3-yosryahmed@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 28-04-23 13:24:06, Yosry Ahmed wrote:
> Commit c8713d0b2312 ("mm: memcontrol: dump memory.stat during cgroup
> OOM") made sure we dump all the stats in memory.stat during a cgroup
> OOM, but it also introduced a slight behavioral change. The code used to
> print the non-hierarchical v1 cgroup stats for the entire cgroup
> subtree, now it only prints the v2 cgroup stats for the cgroup under
> OOM.
> 
> For cgroup v1 users, this introduces a few problems:
> (a) The non-hierarchical stats of the memcg under OOM are no longer
> shown.
> (b) A couple of v1-only stats (e.g. pgpgin, pgpgout) are no longer
> shown.
> (c) We show the list of cgroup v2 stats, even in cgroup v1. This list of
> stats is not tracked with v1 in mind. While most of the stats seem to be
> working on v1, there may be some stats that are not fully or correctly
> tracked.
> 
> Although OOM log is not set in stone, we should not change it for no
> reason. When upgrading the kernel version to a version including
> commit c8713d0b2312 ("mm: memcontrol: dump memory.stat during cgroup
> OOM"), these behavioral changes are noticed in cgroup v1.
> 
> The fix is simple. Commit c8713d0b2312 ("mm: memcontrol: dump memory.stat
> during cgroup OOM") separated stats formatting from stats display for
> v2, to reuse the stats formatting in the OOM logs. Do the same for v1.
> 
> Move the v2 specific formatting from memory_stat_format() to
> memcg_stat_format(), add memcg1_stat_format() for v1, and make
> memory_stat_format() select between them based on cgroup version.
> Since memory_stat_show() now works for both v1 & v2, drop
> memcg_stat_show().
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks

> ---
>  mm/memcontrol.c | 60 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 35 insertions(+), 25 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5922940f92c9..2b492f8d540c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1551,7 +1551,7 @@ static inline unsigned long memcg_page_state_output(struct mem_cgroup *memcg,
>  	return memcg_page_state(memcg, item) * memcg_page_state_unit(item);
>  }
>  
> -static void memory_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
> +static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
>  {
>  	int i;
>  
> @@ -1604,6 +1604,17 @@ static void memory_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
>  	WARN_ON_ONCE(seq_buf_has_overflowed(s));
>  }
>  
> +static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s);
> +
> +static void memory_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
> +{
> +	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +		memcg_stat_format(memcg, s);
> +	else
> +		memcg1_stat_format(memcg, s);
> +	WARN_ON_ONCE(seq_buf_has_overflowed(s));
> +}
> +
>  #define K(x) ((x) << (PAGE_SHIFT-10))
>  /**
>   * mem_cgroup_print_oom_context: Print OOM information relevant to
> @@ -4078,9 +4089,8 @@ static const unsigned int memcg1_events[] = {
>  	PGMAJFAULT,
>  };
>  
> -static int memcg_stat_show(struct seq_file *m, void *v)
> +static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
>  {
> -	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
>  	unsigned long memory, memsw;
>  	struct mem_cgroup *mi;
>  	unsigned int i;
> @@ -4095,18 +4105,18 @@ static int memcg_stat_show(struct seq_file *m, void *v)
>  		if (memcg1_stats[i] == MEMCG_SWAP && !do_memsw_account())
>  			continue;
>  		nr = memcg_page_state_local(memcg, memcg1_stats[i]);
> -		seq_printf(m, "%s %lu\n", memcg1_stat_names[i],
> +		seq_buf_printf(s, "%s %lu\n", memcg1_stat_names[i],
>  			   nr * memcg_page_state_unit(memcg1_stats[i]));
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(memcg1_events); i++)
> -		seq_printf(m, "%s %lu\n", vm_event_name(memcg1_events[i]),
> -			   memcg_events_local(memcg, memcg1_events[i]));
> +		seq_buf_printf(s, "%s %lu\n", vm_event_name(memcg1_events[i]),
> +			       memcg_events_local(memcg, memcg1_events[i]));
>  
>  	for (i = 0; i < NR_LRU_LISTS; i++)
> -		seq_printf(m, "%s %lu\n", lru_list_name(i),
> -			   memcg_page_state_local(memcg, NR_LRU_BASE + i) *
> -			   PAGE_SIZE);
> +		seq_buf_printf(s, "%s %lu\n", lru_list_name(i),
> +			       memcg_page_state_local(memcg, NR_LRU_BASE + i) *
> +			       PAGE_SIZE);
>  
>  	/* Hierarchical information */
>  	memory = memsw = PAGE_COUNTER_MAX;
> @@ -4114,11 +4124,11 @@ static int memcg_stat_show(struct seq_file *m, void *v)
>  		memory = min(memory, READ_ONCE(mi->memory.max));
>  		memsw = min(memsw, READ_ONCE(mi->memsw.max));
>  	}
> -	seq_printf(m, "hierarchical_memory_limit %llu\n",
> -		   (u64)memory * PAGE_SIZE);
> +	seq_buf_printf(s, "hierarchical_memory_limit %llu\n",
> +		       (u64)memory * PAGE_SIZE);
>  	if (do_memsw_account())
> -		seq_printf(m, "hierarchical_memsw_limit %llu\n",
> -			   (u64)memsw * PAGE_SIZE);
> +		seq_buf_printf(s, "hierarchical_memsw_limit %llu\n",
> +			       (u64)memsw * PAGE_SIZE);
>  
>  	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
>  		unsigned long nr;
> @@ -4126,19 +4136,19 @@ static int memcg_stat_show(struct seq_file *m, void *v)
>  		if (memcg1_stats[i] == MEMCG_SWAP && !do_memsw_account())
>  			continue;
>  		nr = memcg_page_state(memcg, memcg1_stats[i]);
> -		seq_printf(m, "total_%s %llu\n", memcg1_stat_names[i],
> +		seq_buf_printf(s, "total_%s %llu\n", memcg1_stat_names[i],
>  			   (u64)nr * memcg_page_state_unit(memcg1_stats[i]));
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(memcg1_events); i++)
> -		seq_printf(m, "total_%s %llu\n",
> -			   vm_event_name(memcg1_events[i]),
> -			   (u64)memcg_events(memcg, memcg1_events[i]));
> +		seq_buf_printf(s, "total_%s %llu\n",
> +			       vm_event_name(memcg1_events[i]),
> +			       (u64)memcg_events(memcg, memcg1_events[i]));
>  
>  	for (i = 0; i < NR_LRU_LISTS; i++)
> -		seq_printf(m, "total_%s %llu\n", lru_list_name(i),
> -			   (u64)memcg_page_state(memcg, NR_LRU_BASE + i) *
> -			   PAGE_SIZE);
> +		seq_buf_printf(s, "total_%s %llu\n", lru_list_name(i),
> +			       (u64)memcg_page_state(memcg, NR_LRU_BASE + i) *
> +			       PAGE_SIZE);
>  
>  #ifdef CONFIG_DEBUG_VM
>  	{
> @@ -4153,12 +4163,10 @@ static int memcg_stat_show(struct seq_file *m, void *v)
>  			anon_cost += mz->lruvec.anon_cost;
>  			file_cost += mz->lruvec.file_cost;
>  		}
> -		seq_printf(m, "anon_cost %lu\n", anon_cost);
> -		seq_printf(m, "file_cost %lu\n", file_cost);
> +		seq_buf_printf(s, "anon_cost %lu\n", anon_cost);
> +		seq_buf_printf(s, "file_cost %lu\n", file_cost);
>  	}
>  #endif
> -
> -	return 0;
>  }
>  
>  static u64 mem_cgroup_swappiness_read(struct cgroup_subsys_state *css,
> @@ -4998,6 +5006,8 @@ static int mem_cgroup_slab_show(struct seq_file *m, void *p)
>  }
>  #endif
>  
> +static int memory_stat_show(struct seq_file *m, void *v);
> +
>  static struct cftype mem_cgroup_legacy_files[] = {
>  	{
>  		.name = "usage_in_bytes",
> @@ -5030,7 +5040,7 @@ static struct cftype mem_cgroup_legacy_files[] = {
>  	},
>  	{
>  		.name = "stat",
> -		.seq_show = memcg_stat_show,
> +		.seq_show = memory_stat_show,
>  	},
>  	{
>  		.name = "force_empty",
> -- 
> 2.40.1.495.gc816e09b53d-goog

-- 
Michal Hocko
SUSE Labs
