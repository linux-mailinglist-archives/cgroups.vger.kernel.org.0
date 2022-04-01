Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E9E4EE563
	for <lists+cgroups@lfdr.de>; Fri,  1 Apr 2022 02:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243547AbiDAAfl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 31 Mar 2022 20:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243548AbiDAAfk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 31 Mar 2022 20:35:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57B45749A;
        Thu, 31 Mar 2022 17:33:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 813E8617DC;
        Fri,  1 Apr 2022 00:33:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF76C340EE;
        Fri,  1 Apr 2022 00:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1648773231;
        bh=og4lU4dyrILrjlo8MbO414DxVtLpdEFdDjD3sS0QOBw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U5o07Jxr93Bh9u6zSuP89IQcL92kcAZ770UBXZgKYQhmAKYXLDrkqGlg6AvIB0FHv
         14Swf4CBx/hO7N8YcVLLInn2Sfp3NjT3dBk628qB+FYc9C4Z8jZZDhJLwXD6RMXoFP
         B5npudLXVCs+sY72+8rR2+3cyLmHtzPdxAJZykjk=
Date:   Thu, 31 Mar 2022 17:33:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
Message-Id: <20220331173350.1fe09370479a4a6f916b477d@linux-foundation.org>
In-Reply-To: <20220331084151.2600229-1-yosryahmed@google.com>
References: <20220331084151.2600229-1-yosryahmed@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 31 Mar 2022 08:41:51 +0000 Yosry Ahmed <yosryahmed@google.com> wrote:

> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6355,6 +6355,38 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
>  	return nbytes;
>  }
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
> +
> +		if (!reclaimed && !nr_retries--)
> +			break;
> +
> +		nr_reclaimed += reclaimed;
> +	}

Is there any way in which this can be provoked into triggering the
softlockup detector?

Is it optimal to do the MAX_RECLAIM_RETRIES loop in the kernel? 
Would additional flexibility be gained by letting userspace handle
retrying?


