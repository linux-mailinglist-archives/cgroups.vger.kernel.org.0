Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372216EF7B9
	for <lists+cgroups@lfdr.de>; Wed, 26 Apr 2023 17:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241289AbjDZPYS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Apr 2023 11:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240838AbjDZPYR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Apr 2023 11:24:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C616F26B9;
        Wed, 26 Apr 2023 08:24:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5E276219BC;
        Wed, 26 Apr 2023 15:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682522653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XvGm7kLitfuqoiLnLSTpWZlMY3cBw22b/188zgDmwA8=;
        b=Pd4YtmolqPoR6ZSAHJNpty0UCbzLQwQxg9Ydv6LcHpoL9/cvpoKWvrleT/+ErcdBH5dVgC
        pS4zhHmivMoRy2sv/Js8QBbWw+EZ62GqDLvrb4W7w8ZogGry78NoJledWSn9xjV4ywQ0pZ
        GpNzWr00UCLo4GKOVLYLFhHROP+p5LY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A5DD138F0;
        Wed, 26 Apr 2023 15:24:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qE8NDB1CSWSKAgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 26 Apr 2023 15:24:13 +0000
Date:   Wed, 26 Apr 2023 17:24:12 +0200
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
Subject: Re: [PATCH 1/2] memcg: use seq_buf_do_printk() with
 mem_cgroup_print_oom_meminfo()
Message-ID: <ZElCHJrkOVsy79KY@dhcp22.suse.cz>
References: <20230426133919.1342942-1-yosryahmed@google.com>
 <20230426133919.1342942-2-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426133919.1342942-2-yosryahmed@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 26-04-23 13:39:18, Yosry Ahmed wrote:
> Currently, we format all the memcg stats into a buffer in
> mem_cgroup_print_oom_meminfo() and use pr_info() to dump it to the logs.
> However, this buffer is large in size. Although it is currently working
> as intended, ther is a dependency between the memcg stats buffer and the
> printk record size limit.
> 
> If we add more stats in the future and the buffer becomes larger than
> the printk record size limit, or if the prink record size limit is
> reduced, the logs may be truncated.
> 
> It is safer to use seq_buf_do_printk(), which will automatically break
> up the buffer at line breaks and issue small printk() calls.
> 
> Refactor the code to move the seq_buf from memory_stat_format() to its
> callers, and use seq_buf_do_printk() to print the seq_buf in
> mem_cgroup_print_oom_meminfo().
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

No objection from me but is it possible that more printk calls (one per
line with this change correct?) would add a contention on the printk
path?

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5abffe6f8389..5922940f92c9 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1551,13 +1551,10 @@ static inline unsigned long memcg_page_state_output(struct mem_cgroup *memcg,
>  	return memcg_page_state(memcg, item) * memcg_page_state_unit(item);
>  }
>  
> -static void memory_stat_format(struct mem_cgroup *memcg, char *buf, int bufsize)
> +static void memory_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
>  {
> -	struct seq_buf s;
>  	int i;
>  
> -	seq_buf_init(&s, buf, bufsize);
> -
>  	/*
>  	 * Provide statistics on the state of the memory subsystem as
>  	 * well as cumulative event counters that show past behavior.
> @@ -1574,21 +1571,21 @@ static void memory_stat_format(struct mem_cgroup *memcg, char *buf, int bufsize)
>  		u64 size;
>  
>  		size = memcg_page_state_output(memcg, memory_stats[i].idx);
> -		seq_buf_printf(&s, "%s %llu\n", memory_stats[i].name, size);
> +		seq_buf_printf(s, "%s %llu\n", memory_stats[i].name, size);
>  
>  		if (unlikely(memory_stats[i].idx == NR_SLAB_UNRECLAIMABLE_B)) {
>  			size += memcg_page_state_output(memcg,
>  							NR_SLAB_RECLAIMABLE_B);
> -			seq_buf_printf(&s, "slab %llu\n", size);
> +			seq_buf_printf(s, "slab %llu\n", size);
>  		}
>  	}
>  
>  	/* Accumulated memory events */
> -	seq_buf_printf(&s, "pgscan %lu\n",
> +	seq_buf_printf(s, "pgscan %lu\n",
>  		       memcg_events(memcg, PGSCAN_KSWAPD) +
>  		       memcg_events(memcg, PGSCAN_DIRECT) +
>  		       memcg_events(memcg, PGSCAN_KHUGEPAGED));
> -	seq_buf_printf(&s, "pgsteal %lu\n",
> +	seq_buf_printf(s, "pgsteal %lu\n",
>  		       memcg_events(memcg, PGSTEAL_KSWAPD) +
>  		       memcg_events(memcg, PGSTEAL_DIRECT) +
>  		       memcg_events(memcg, PGSTEAL_KHUGEPAGED));
> @@ -1598,13 +1595,13 @@ static void memory_stat_format(struct mem_cgroup *memcg, char *buf, int bufsize)
>  		    memcg_vm_event_stat[i] == PGPGOUT)
>  			continue;
>  
> -		seq_buf_printf(&s, "%s %lu\n",
> +		seq_buf_printf(s, "%s %lu\n",
>  			       vm_event_name(memcg_vm_event_stat[i]),
>  			       memcg_events(memcg, memcg_vm_event_stat[i]));
>  	}
>  
>  	/* The above should easily fit into one page */
> -	WARN_ON_ONCE(seq_buf_has_overflowed(&s));
> +	WARN_ON_ONCE(seq_buf_has_overflowed(s));
>  }
>  
>  #define K(x) ((x) << (PAGE_SHIFT-10))
> @@ -1642,6 +1639,7 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
>  {
>  	/* Use static buffer, for the caller is holding oom_lock. */
>  	static char buf[PAGE_SIZE];
> +	struct seq_buf s;
>  
>  	lockdep_assert_held(&oom_lock);
>  
> @@ -1664,8 +1662,9 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
>  	pr_info("Memory cgroup stats for ");
>  	pr_cont_cgroup_path(memcg->css.cgroup);
>  	pr_cont(":");
> -	memory_stat_format(memcg, buf, sizeof(buf));
> -	pr_info("%s", buf);
> +	seq_buf_init(&s, buf, sizeof(buf));
> +	memory_stat_format(memcg, &s);
> +	seq_buf_do_printk(&s, KERN_INFO);
>  }
>  
>  /*
> @@ -6573,10 +6572,12 @@ static int memory_stat_show(struct seq_file *m, void *v)
>  {
>  	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
>  	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	struct seq_buf s;
>  
>  	if (!buf)
>  		return -ENOMEM;
> -	memory_stat_format(memcg, buf, PAGE_SIZE);
> +	seq_buf_init(&s, buf, PAGE_SIZE);
> +	memory_stat_format(memcg, &s);
>  	seq_puts(m, buf);
>  	kfree(buf);
>  	return 0;
> -- 
> 2.40.1.495.gc816e09b53d-goog

-- 
Michal Hocko
SUSE Labs
