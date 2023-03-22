Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38FD6C4FCA
	for <lists+cgroups@lfdr.de>; Wed, 22 Mar 2023 16:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjCVP5a (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Mar 2023 11:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjCVP53 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Mar 2023 11:57:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB905D742;
        Wed, 22 Mar 2023 08:57:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1811A20F93;
        Wed, 22 Mar 2023 15:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679500647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=izrxL5uNy/RlGAZkpdzzMJcPSf/6R/YxjFD0TFNLUvA=;
        b=nTk5m38N9QXJDWuO5Sl5xVqlCA5xhBf5fUEB/K4SYKENk8A9HFIPvTxi0olsuhYXtji1/T
        NS20L8cWUc/NC/9haLylj9pyg+PWaPMt2xi6uA6/qMUASS9f5AwMfT3U+RiZe7RXClP0hk
        7LH3Ziwa3w7bLzPJYtr9kH5uwZmnPnw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E9FD513416;
        Wed, 22 Mar 2023 15:57:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BnvONmYlG2TWXgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 22 Mar 2023 15:57:26 +0000
Date:   Wed, 22 Mar 2023 16:57:26 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Florian Schmidt <flosch@nutanix.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] memcg v1: provide read access to memory.pressure_level
Message-ID: <ZBslZrtFISfYqV5l@dhcp22.suse.cz>
References: <20230322142525.162469-1-flosch@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322142525.162469-1-flosch@nutanix.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 22-03-23 14:25:25, Florian Schmidt wrote:
> cgroups v1 has a unique way of setting up memory pressure notifications:
> the user opens "memory.pressure_level" of the cgroup they want to
> monitor for pressure, then open "cgroup.event_control" and write the fd
> (among other things) to that file. memory.pressure_level has no other
> use, specifically it does not support any read or write operations.
> Consequently, no handlers are provided, and the file ends up with
> permissions 000. However, to actually use the mechanism, the subscribing
> user must have read access to the file and open the fd for reading, see
> memcg_write_event_control().
> 
> This is all fine as long as the subscribing process runs as root and is
> otherwise unconfined by further restrictions. However, if you add strict
> access controls such as selinux, the permission bits will be enforced,
> and opening memory.pressure_level for reading will fail, preventing the
> process from subscribing, even as root.
>
> 
> There are several ways around this issue, but adding a dummy read
> handler seems like the least invasive to me.

I was struggling to see how that addresses the problem because all you
need is a read permission. But then I've looked into cgroup code and
learned that permissions are constructed based on available callbacks
(cgroup_file_mode). This would have made the review easier ;)

I have no issue with the patch. It would be great to hear from cgroup
maintainers whether a concept of default permissions is something that
would be useful also for other files.

> I'd be interested to hear:
> (a) do you think there is a less invasive way? Alternatively, we could
>     add a flag in cftype in include/linux/cgroup-defs.h, but that seems
>     more invasive for what is a legacy interface.
> (b) would you be interested to take this patch, or is it too niche a fix
>     for a legacy subsystem?

After you add your s-o-b, feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

If cgroup people find a concept of default permissions for a cgroup file
sound then this could be replaced by that approach but this is really an
easy workaround.
> ---
>  mm/memcontrol.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5abffe6f8389..e48c749d9724 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3734,6 +3734,16 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
>  	}
>  }
>  
> +/*
> + * This function doesn't do anything useful. Its only job is to provide a read
> + * handler so that the file gets read permissions when it's created.

I would just reference cgroup_file_mode() in the comment to make our
lifes easier and comment more helpful.

> + */
> +static int mem_cgroup_dummy_seq_show(__always_unused struct seq_file *m,
> +				     __always_unused void *v)
> +{
> +	return -EINVAL;
> +}
> +
>  #ifdef CONFIG_MEMCG_KMEM
>  static int memcg_online_kmem(struct mem_cgroup *memcg)
>  {
> @@ -5064,6 +5074,7 @@ static struct cftype mem_cgroup_legacy_files[] = {
>  	},
>  	{
>  		.name = "pressure_level",
> +		.seq_show = mem_cgroup_dummy_seq_show,
>  	},
>  #ifdef CONFIG_NUMA
>  	{
> -- 
> 2.32.0

-- 
Michal Hocko
SUSE Labs
