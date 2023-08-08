Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8351773D26
	for <lists+cgroups@lfdr.de>; Tue,  8 Aug 2023 18:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjHHQOZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Aug 2023 12:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbjHHQNK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Aug 2023 12:13:10 -0400
Received: from out-121.mta0.migadu.com (out-121.mta0.migadu.com [IPv6:2001:41d0:1004:224b::79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D7A7EE7
        for <cgroups@vger.kernel.org>; Tue,  8 Aug 2023 08:47:16 -0700 (PDT)
Date:   Mon, 7 Aug 2023 20:59:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691467205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sez3/qKAzyH76xRy/KhqNgZqSUAZnWdnTT8oqdhcXFU=;
        b=Cp0f1StKAVL+rMJfbIbWcxpNVTgUYc6wQudKaze3wIjc5BC5XVXMk0mpSZhp3Wt/mYHEee
        YI4Sm7tEAnDW2LteipyOYEHK1B+WOjylDTJ5aOQDsBoX/ClxtVQAA2GoO9Q+OAfd27HcbQ
        9S3NIwPXnMBZ/gyDlHHFOXzZB1IjJl0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     xiongwei.song@windriver.com
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, shakeelb@google.com,
        muchun.song@linux.dev, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcontrol: add tips for kmem.slabinfo
Message-ID: <ZNG9vwg1K6fn1SvN@P9FQF9L96D>
References: <20230808022229.1560559-1-xiongwei.song@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment
In-Reply-To: <20230808022229.1560559-1-xiongwei.song@windriver.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 08, 2023 at 10:22:29AM +0800, xiongwei.song@windriver.com wrote:
> From: Xiongwei Song <xiongwei.song@windriver.com>
> 
> No any output from kmem.slabinfo, which is not friendly. Adding
> tips for it.
> 
> Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
> ---
>  mm/memcontrol.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e8ca4bdcb03c..58d3bd93890b 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5002,10 +5002,8 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
>  #if defined(CONFIG_MEMCG_KMEM) && (defined(CONFIG_SLAB) || defined(CONFIG_SLUB_DEBUG))
>  static int mem_cgroup_slab_show(struct seq_file *m, void *p)
>  {
> -	/*
> -	 * Deprecated.
> -	 * Please, take a look at tools/cgroup/memcg_slabinfo.py .
> -	 */
> +	seq_puts(m, "This file is deprecated.\n"
> +		"Please use tools/cgroup/memcg_slabinfo.py, which is in kernel source.\n");

It'll break the ABI.
The only possible option here is to use WARN_ON_ONCE(), which will print once to dmesg.
But honestly I'm not sure we need it.

Thanks!
