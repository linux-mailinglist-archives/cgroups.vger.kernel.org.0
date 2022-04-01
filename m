Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B744EE671
	for <lists+cgroups@lfdr.de>; Fri,  1 Apr 2022 05:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244372AbiDADHh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 31 Mar 2022 23:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244360AbiDADHg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 31 Mar 2022 23:07:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258AA193B7C;
        Thu, 31 Mar 2022 20:05:48 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KV4lt3gqKzdZPy;
        Fri,  1 Apr 2022 11:04:58 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 11:05:18 +0800
Received: from [10.174.178.178] (10.174.178.178) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 11:05:17 +0800
Message-ID: <2025405d-c32b-338a-b668-48b07a34e4ef@huawei.com>
Date:   Fri, 1 Apr 2022 11:05:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
To:     Yosry Ahmed <yosryahmed@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>
CC:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        "Roman Gushchin" <roman.gushchin@linux.dev>,
        <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Jonathan Corbet <corbet@lwn.net>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>
References: <20220331084151.2600229-1-yosryahmed@google.com>
From:   Chen Wandun <chenwandun@huawei.com>
In-Reply-To: <20220331084151.2600229-1-yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.178]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2022/3/31 16:41, Yosry Ahmed 写道:
> From: Shakeel Butt <shakeelb@google.com>
>
> Introduce an memcg interface to trigger memory reclaim on a memory cgroup.
>
> Use case: Proactive Reclaim
> ---------------------------
>
> A userspace proactive reclaimer can continuously probe the memcg to
> reclaim a small amount of memory. This gives more accurate and
> up-to-date workingset estimation as the LRUs are continuously
> sorted and can potentially provide more deterministic memory
> overcommit behavior. The memory overcommit controller can provide
> more proactive response to the changing behavior of the running
> applications instead of being reactive.
>
> A userspace reclaimer's purpose in this case is not a complete replacement
> for kswapd or direct reclaim, it is to proactively identify memory savings
> opportunities and reclaim some amount of cold pages set by the policy
> to free up the memory for more demanding jobs or scheduling new jobs.
>
> A user space proactive reclaimer is used in Google data centers.
> Additionally, Meta's TMO paper recently referenced a very similar
> interface used for user space proactive reclaim:
> https://dl.acm.org/doi/pdf/10.1145/3503222.3507731
>
> Benefits of a user space reclaimer:
> -----------------------------------
>
> 1) More flexible on who should be charged for the cpu of the memory
> reclaim. For proactive reclaim, it makes more sense to be centralized.
>
> 2) More flexible on dedicating the resources (like cpu). The memory
> overcommit controller can balance the cost between the cpu usage and
> the memory reclaimed.
>
> 3) Provides a way to the applications to keep their LRUs sorted, so,
> under memory pressure better reclaim candidates are selected. This also
> gives more accurate and uptodate notion of working set for an
> application.
>
> Why memory.high is not enough?
> ------------------------------
>
> - memory.high can be used to trigger reclaim in a memcg and can
>    potentially be used for proactive reclaim.
>    However there is a big downside in using memory.high. It can potentially
>    introduce high reclaim stalls in the target application as the
>    allocations from the processes or the threads of the application can hit
>    the temporary memory.high limit.
>
> - Userspace proactive reclaimers usually use feedback loops to decide
>    how much memory to proactively reclaim from a workload. The metrics
>    used for this are usually either refaults or PSI, and these metrics
>    will become messy if the application gets throttled by hitting the
>    high limit.
>
> - memory.high is a stateful interface, if the userspace proactive
>    reclaimer crashes for any reason while triggering reclaim it can leave
>    the application in a bad state.
>
> - If a workload is rapidly expanding, setting memory.high to proactively
>    reclaim memory can result in actually reclaiming more memory than
>    intended.
>
> The benefits of such interface and shortcomings of existing interface
> were further discussed in this RFC thread:
> https://lore.kernel.org/linux-mm/5df21376-7dd1-bf81-8414-32a73cea45dd@google.com/
>
> Interface:
> ----------
>
> Introducing a very simple memcg interface 'echo 10M > memory.reclaim' to
> trigger reclaim in the target memory cgroup.
>
>
> Possible Extensions:
> --------------------
>
> - This interface can be extended with an additional parameter or flags
>    to allow specifying one or more types of memory to reclaim from (e.g.
>    file, anon, ..).
>
> - The interface can also be extended with a node mask to reclaim from
>    specific nodes. This has use cases for reclaim-based demotion in memory
>    tiering systens.
>
> - A similar per-node interface can also be added to support proactive
>    reclaim and reclaim-based demotion in systems without memcg.
>
> For now, let's keep things simple by adding the basic functionality.
>
> [yosryahmed@google.com: refreshed to current master, updated commit
> message based on recent discussions and use cases]
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>   Documentation/admin-guide/cgroup-v2.rst |  9 ++++++
>   mm/memcontrol.c                         | 37 +++++++++++++++++++++++++
>   2 files changed, 46 insertions(+)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 69d7a6983f78..925aaabb2247 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1208,6 +1208,15 @@ PAGE_SIZE multiple when read back.
>   	high limit is used and monitored properly, this limit's
>   	utility is limited to providing the final safety net.
>   
> +  memory.reclaim
> +	A write-only file which exists on non-root cgroups.
> +
> +	This is a simple interface to trigger memory reclaim in the
> +	target cgroup. Write the number of bytes to reclaim to this
> +	file and the kernel will try to reclaim that much memory.
> +	Please note that the kernel can over or under reclaim from
> +	the target cgroup.
> +
>     memory.oom.group
>   	A read-write single value file which exists on non-root
>   	cgroups.  The default value is "0".
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 725f76723220..994849fab7df 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6355,6 +6355,38 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
>   	return nbytes;
>   }
>   
> +static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
> +			      size_t nbytes, loff_t off)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> +	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
> +	unsigned long nr_to_reclaim, nr_reclaimed = 0;
> +	int err;
> +
> +	buf = strstrip(buf);
> +	err = page_counter_memparse(buf, "", &nr_to_reclaim);
> +	if (err)
> +		return err;
> +
> +	while (nr_reclaimed < nr_to_reclaim) {
> +		unsigned long reclaimed;
> +
> +		if (signal_pending(current))
> +			break;
> +
> +		reclaimed = try_to_free_mem_cgroup_pages(memcg,
> +						nr_to_reclaim - nr_reclaimed,
> +						GFP_KERNEL, true);
In some scenario there are lots of page cache,  and we only want to 
reclaim page cache,
how about add may_swap option?
> +
> +		if (!reclaimed && !nr_retries--)
> +			break;
> +
> +		nr_reclaimed += reclaimed;
> +	}
> +
> +	return nbytes;
> +}
> +
>   static struct cftype memory_files[] = {
>   	{
>   		.name = "current",
> @@ -6413,6 +6445,11 @@ static struct cftype memory_files[] = {
>   		.seq_show = memory_oom_group_show,
>   		.write = memory_oom_group_write,
>   	},
> +	{
> +		.name = "reclaim",
> +		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_NS_DELEGATABLE,
> +		.write = memory_reclaim,
> +	},
>   	{ }	/* terminate */
>   };
>   

