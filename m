Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45C0522CEE
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 09:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242713AbiEKHNc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 May 2022 03:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241161AbiEKHN3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 May 2022 03:13:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7551053FC
        for <cgroups@vger.kernel.org>; Wed, 11 May 2022 00:13:25 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8EE0E1F8F7;
        Wed, 11 May 2022 07:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652253204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v3MEE3PCAin488+Sg3Y+cPevPCOC3na5cXBSCbF/tME=;
        b=hii84q44ZpbI1s2/MUpEY3XkgMdDGRV2xp78zOJXyihOgzmQEi+DNBtqkYvHwDXFUJNOsW
        3r6eitcIEOKRtc3ctO4Z6BS337p/XjSUR88unGCHvAeKx1SdDBlKwRliO8LTFlHDwyg9YF
        t3j9/HCDO2FZ4TvAUwSTCh49OYvHv1U=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 430EC2C141;
        Wed, 11 May 2022 07:13:24 +0000 (UTC)
Date:   Wed, 11 May 2022 09:13:23 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Ganesan Rajagopal <rganesan@arista.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/memcontrol: Export memcg->watermark via sysfs for
 v2 memcg
Message-ID: <YntiE+qNnHQBV4zE@dhcp22.suse.cz>
References: <20220507050916.GA13577@us192.sjc.aristanetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507050916.GA13577@us192.sjc.aristanetworks.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 06-05-22 22:09:16, Ganesan Rajagopal wrote:
> We run a lot of automated tests when building our software and run into
> OOM scenarios when the tests run unbounded. v1 memcg exports
> memcg->watermark as "memory.max_usage_in_bytes" in sysfs. We use this
> metric to heuristically limit the number of tests that can run in
> parallel based on per test historical data.
> 
> This metric is currently not exported for v2 memcg and there is no
> other easy way of getting this information. getrusage() syscall returns
> "ru_maxrss" which can be used as an approximation but that's the max
> RSS of a single child process across all children instead of the
> aggregated max for all child processes. The only work around is to
> periodically poll "memory.current" but that's not practical for
> short-lived one-off cgroups.
> 
> Hence, expose memcg->watermark as "memory.peak" for v2 memcg.

Yes, I can imagine that a very short lived process can easily escape
from the monitoring. The memory consumption can be still significant
though.

The v1 interface allows to reset the value by writing to the file. Have
you considered that as well?
 
> Signed-off-by: Ganesan Rajagopal <rganesan@arista.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  Documentation/admin-guide/cgroup-v2.rst |  7 +++++++
>  mm/memcontrol.c                         | 13 +++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 69d7a6983f78..828ce037fb2a 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1208,6 +1208,13 @@ PAGE_SIZE multiple when read back.
>  	high limit is used and monitored properly, this limit's
>  	utility is limited to providing the final safety net.
>  
> +  memory.peak
> +	A read-only single value file which exists on non-root
> +	cgroups.
> +
> +	The max memory usage recorded for the cgroup and its
> +	descendants since the creation of the cgroup.
> +
>    memory.oom.group
>  	A read-write single value file which exists on non-root
>  	cgroups.  The default value is "0".
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 725f76723220..88fa70b5d8af 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6098,6 +6098,14 @@ static u64 memory_current_read(struct cgroup_subsys_state *css,
>  	return (u64)page_counter_read(&memcg->memory) * PAGE_SIZE;
>  }
>  
> +static u64 memory_peak_read(struct cgroup_subsys_state *css,
> +			    struct cftype *cft)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> +
> +	return (u64)memcg->memory.watermark * PAGE_SIZE;
> +}
> +
>  static int memory_min_show(struct seq_file *m, void *v)
>  {
>  	return seq_puts_memcg_tunable(m,
> @@ -6361,6 +6369,11 @@ static struct cftype memory_files[] = {
>  		.flags = CFTYPE_NOT_ON_ROOT,
>  		.read_u64 = memory_current_read,
>  	},
> +	{
> +		.name = "peak",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.read_u64 = memory_peak_read,
> +	},
>  	{
>  		.name = "min",
>  		.flags = CFTYPE_NOT_ON_ROOT,
> -- 
> 2.28.0

-- 
Michal Hocko
SUSE Labs
