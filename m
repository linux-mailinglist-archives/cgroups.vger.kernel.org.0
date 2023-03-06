Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B686ACB52
	for <lists+cgroups@lfdr.de>; Mon,  6 Mar 2023 18:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjCFRwo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Mar 2023 12:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCFRwn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Mar 2023 12:52:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D5C6A9FC;
        Mon,  6 Mar 2023 09:52:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2D91A1FDDD;
        Mon,  6 Mar 2023 17:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678124825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yyo0XeW7H32v2n33gFS+jMOXmRmlgHGjCX1E7zeS1w0=;
        b=R5OU+pfkoKfQA+ShDkrA2Ab/7GQX8V5UAbQDog+dOafDsBbUj/UFcnZ9pk4PuaqeDlUO+f
        oEJZK3fuTgGttOPw1FFsK2b1lsEmqtpmRJraKGUb4fXL/rOpwohtJYV8v2U74LbuU0qxLx
        7GQOmS+j6Iq/Ip1rqQ6QQwJHu958cZ8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F44013513;
        Mon,  6 Mar 2023 17:47:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rL6vARknBmSSfAAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 06 Mar 2023 17:47:05 +0000
Date:   Mon, 6 Mar 2023 18:47:04 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yue Zhao <findns94@gmail.com>
Cc:     akpm@linux-foundation.org, roman.gushchin@linux.dev,
        hannes@cmpxchg.org, shakeelb@google.com, muchun.song@linux.dev,
        willy@infradead.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangyeechou@gmail.com
Subject: Re: [PATCH v2, 1/4] mm, memcg: Prevent memory.oom.group load/store
 tearing
Message-ID: <ZAYnGK8mXjxmarDm@dhcp22.suse.cz>
References: <20230306154138.3775-1-findns94@gmail.com>
 <20230306154138.3775-2-findns94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306154138.3775-2-findns94@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 06-03-23 23:41:35, Yue Zhao wrote:
> The knob for cgroup v2 memory controller: memory.oom.group
> is not protected by any locking so it can be modified while it is used.
> This is not an actual problem because races are unlikely (the knob is
> usually configured long before any workloads hits actual memcg oom)
> but it is better to use READ_ONCE/WRITE_ONCE to prevent compiler from
> doing anything funky.
> 
> The access of memcg->oom_group is lockless, so it can be
> concurrently set at the same time as we are trying to read it.
> 
> Signed-off-by: Yue Zhao <findns94@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  mm/memcontrol.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5abffe6f8389..06821e5f7604 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2067,7 +2067,7 @@ struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
>  	 * highest-level memory cgroup with oom.group set.
>  	 */
>  	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
> -		if (memcg->oom_group)
> +		if (READ_ONCE(memcg->oom_group))
>  			oom_group = memcg;
>  
>  		if (memcg == oom_domain)
> @@ -6623,7 +6623,7 @@ static int memory_oom_group_show(struct seq_file *m, void *v)
>  {
>  	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
>  
> -	seq_printf(m, "%d\n", memcg->oom_group);
> +	seq_printf(m, "%d\n", READ_ONCE(memcg->oom_group));
>  
>  	return 0;
>  }
> @@ -6645,7 +6645,7 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
>  	if (oom_group != 0 && oom_group != 1)
>  		return -EINVAL;
>  
> -	memcg->oom_group = oom_group;
> +	WRITE_ONCE(memcg->oom_group, oom_group);
>  
>  	return nbytes;
>  }
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
