Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E328D4BE0BD
	for <lists+cgroups@lfdr.de>; Mon, 21 Feb 2022 18:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377778AbiBUO1q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Feb 2022 09:27:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377797AbiBUO1o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Feb 2022 09:27:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F562196
        for <cgroups@vger.kernel.org>; Mon, 21 Feb 2022 06:27:21 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3F37E21127;
        Mon, 21 Feb 2022 14:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645453640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x7qlynhI6VNEu44qmvL7ARJ1jvjijtZcw+Rs2WqC7BU=;
        b=cQs2PZLCJnE2+44odjuVX/QVbqM5A9SJqHn/bj8zvDOHajtiXL1KUsXpytN/TTFMh1UVSW
        QAzf9biM8mwylRViQrjJqU6EIstjeY2LSDu6uFMLtTt6/F9lhgR2Q7ARQgISSsCc4EUvlt
        Ms4d/g60ij+I1u4EPbKqUX2FwA2z7y8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0F4EEA3B81;
        Mon, 21 Feb 2022 14:27:20 +0000 (UTC)
Date:   Mon, 21 Feb 2022 15:27:19 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v3 2/5] mm/memcg: Disable threshold event handlers on
 PREEMPT_RT
Message-ID: <YhOhRzAqC4PxsSx6@dhcp22.suse.cz>
References: <20220217094802.3644569-1-bigeasy@linutronix.de>
 <20220217094802.3644569-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220217094802.3644569-3-bigeasy@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 17-02-22 10:47:59, Sebastian Andrzej Siewior wrote:
> During the integration of PREEMPT_RT support, the code flow around
> memcg_check_events() resulted in `twisted code'. Moving the code around
> and avoiding then would then lead to an additional local-irq-save
> section within memcg_check_events(). While looking better, it adds a
> local-irq-save section to code flow which is usually within an
> local-irq-off block on non-PREEMPT_RT configurations.
> 
> The threshold event handler is a deprecated memcg v1 feature. Instead of
> trying to get it to work under PREEMPT_RT just disable it. There should
> be no users on PREEMPT_RT. From that perspective it makes even less
> sense to get it to work under PREEMPT_RT while having zero users.
> 
> Make memory.soft_limit_in_bytes and cgroup.event_control return
> -EOPNOTSUPP on PREEMPT_RT. Make an empty memcg_check_events() and
> memcg_write_event_control() which return only -EOPNOTSUPP on PREEMPT_RT.
> Document that the two knobs are disabled on PREEMPT_RT.
> 
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Suggested-by: Michal Koutný <mkoutny@suse.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Acked-by: Roman Gushchin <guro@fb.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  Documentation/admin-guide/cgroup-v1/memory.rst |  2 ++
>  mm/memcontrol.c                                | 14 ++++++++++++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
> index faac50149a222..2cc502a75ef64 100644
> --- a/Documentation/admin-guide/cgroup-v1/memory.rst
> +++ b/Documentation/admin-guide/cgroup-v1/memory.rst
> @@ -64,6 +64,7 @@ Brief summary of control files.
>  				     threads
>   cgroup.procs			     show list of processes
>   cgroup.event_control		     an interface for event_fd()
> +				     This knob is not available on CONFIG_PREEMPT_RT systems.
>   memory.usage_in_bytes		     show current usage for memory
>  				     (See 5.5 for details)
>   memory.memsw.usage_in_bytes	     show current usage for memory+Swap
> @@ -75,6 +76,7 @@ Brief summary of control files.
>   memory.max_usage_in_bytes	     show max memory usage recorded
>   memory.memsw.max_usage_in_bytes     show max memory+Swap usage recorded
>   memory.soft_limit_in_bytes	     set/show soft limit of memory usage
> +				     This knob is not available on CONFIG_PREEMPT_RT systems.
>   memory.stat			     show various statistics
>   memory.use_hierarchy		     set/show hierarchical account enabled
>                                       This knob is deprecated and shouldn't be
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8ab2dc75e70ec..0b5117ed2ae08 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -859,6 +859,9 @@ static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
>   */
>  static void memcg_check_events(struct mem_cgroup *memcg, int nid)
>  {
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		return;
> +
>  	/* threshold event is triggered in finer grain than soft limit */
>  	if (unlikely(mem_cgroup_event_ratelimit(memcg,
>  						MEM_CGROUP_TARGET_THRESH))) {
> @@ -3731,8 +3734,12 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
>  		}
>  		break;
>  	case RES_SOFT_LIMIT:
> -		memcg->soft_limit = nr_pages;
> -		ret = 0;
> +		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +			ret = -EOPNOTSUPP;
> +		} else {
> +			memcg->soft_limit = nr_pages;
> +			ret = 0;
> +		}
>  		break;
>  	}
>  	return ret ?: nbytes;
> @@ -4708,6 +4715,9 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
>  	char *endp;
>  	int ret;
>  
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		return -EOPNOTSUPP;
> +
>  	buf = strstrip(buf);
>  
>  	efd = simple_strtoul(buf, &endp, 10);
> -- 
> 2.34.1

-- 
Michal Hocko
SUSE Labs
