Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB48C6ACB68
	for <lists+cgroups@lfdr.de>; Mon,  6 Mar 2023 18:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjCFRxz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Mar 2023 12:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjCFRxy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Mar 2023 12:53:54 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5810842BDF;
        Mon,  6 Mar 2023 09:53:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5A5DD1FDED;
        Mon,  6 Mar 2023 17:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678125196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C1hwoiYmIzjyFk8ZALc5sULe62pU2P1ms/hhtGj0y1k=;
        b=jwHB7kNZdVMu7pORMKiDgDdWZI0fuRoEnFOqAwGt0mE6k4eAt5T1x+raVUsiRb0qyU9riW
        /SXi4S4tVqanqOvQoom/OxpX4HBsaGCkjfQqJxpcVgINgSZL+rhxKWmFU8fDVzgu1acaMV
        /jN2VHcmUYjvKvHqXSsbaYb3PY9Heng=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B50813513;
        Mon,  6 Mar 2023 17:53:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6U3zC4woBmTgfwAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 06 Mar 2023 17:53:16 +0000
Date:   Mon, 6 Mar 2023 18:53:15 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yue Zhao <findns94@gmail.com>
Cc:     akpm@linux-foundation.org, roman.gushchin@linux.dev,
        hannes@cmpxchg.org, shakeelb@google.com, muchun.song@linux.dev,
        willy@infradead.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangyeechou@gmail.com
Subject: Re: [PATCH v2, 3/4] mm, memcg: Prevent memory.oom_control load/store
 tearing
Message-ID: <ZAYoi8ZwwbXT9j7f@dhcp22.suse.cz>
References: <20230306154138.3775-1-findns94@gmail.com>
 <20230306154138.3775-4-findns94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306154138.3775-4-findns94@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 06-03-23 23:41:37, Yue Zhao wrote:
> The knob for cgroup v1 memory controller: memory.oom_control
> is not protected by any locking so it can be modified while it is used.
> This is not an actual problem because races are unlikely.
> But it is better to use READ_ONCE/WRITE_ONCE to prevent compiler from
> doing anything funky.
> 
> The access of memcg->oom_kill_disable is lockless,
> so it can be concurrently set at the same time as we are
> trying to read it.
> 
> Signed-off-by: Yue Zhao <findns94@gmail.com>
> ---
>  mm/memcontrol.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index dca895c66a9b..26605b2f51b1 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4515,7 +4515,7 @@ static int mem_cgroup_oom_control_read(struct seq_file *sf, void *v)
>  {
>  	struct mem_cgroup *memcg = mem_cgroup_from_seq(sf);
>  
> -	seq_printf(sf, "oom_kill_disable %d\n", memcg->oom_kill_disable);
> +	seq_printf(sf, "oom_kill_disable %d\n", READ_ONCE(memcg->oom_kill_disable));
>  	seq_printf(sf, "under_oom %d\n", (bool)memcg->under_oom);
>  	seq_printf(sf, "oom_kill %lu\n",
>  		   atomic_long_read(&memcg->memory_events[MEMCG_OOM_KILL]));
> @@ -4531,7 +4531,7 @@ static int mem_cgroup_oom_control_write(struct cgroup_subsys_state *css,
>  	if (mem_cgroup_is_root(memcg) || !((val == 0) || (val == 1)))
>  		return -EINVAL;
>  
> -	memcg->oom_kill_disable = val;
> +	WRITE_ONCE(memcg->oom_kill_disable, val);
>  	if (!val)
>  		memcg_oom_recover(memcg);

Any specific reasons you haven't covered other accesses
(mem_cgroup_css_alloc, mem_cgroup_oom, mem_cgroup_oom_synchronize)?
>  
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
