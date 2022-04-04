Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE584F1D13
	for <lists+cgroups@lfdr.de>; Mon,  4 Apr 2022 23:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382462AbiDDVaC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Apr 2022 17:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380200AbiDDTNH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Apr 2022 15:13:07 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5F7377DF
        for <cgroups@vger.kernel.org>; Mon,  4 Apr 2022 12:11:11 -0700 (PDT)
Date:   Mon, 4 Apr 2022 12:11:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649099469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IQhgBimXjsff3C4o+7n/5Q3wYW2UqkiKGEeJ94ihq2Y=;
        b=mvCuJqdY/cG41YOkKNjL26KNm9A/3wMmhWMTazOGnFypRIqmqp7Za3sv/lZRIEk+DNNR9Z
        RYaKlu1imlw/XYW7u7VkTHv6GBZ42hhkfKzXjobhMz88QCmYsDX32KJGwK5zbxTpjlZ5Ia
        EQqU6oPNG5ZMiBRaqVDQe41jtCgiySk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm/memcg: non-hierarchical mode is deprecated
Message-ID: <YktCyf4sJ11aC8xn@carbon.dhcp.thefacebook.com>
References: <20220403020833.26164-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403020833.26164-1-richard.weiyang@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Apr 03, 2022 at 02:08:33AM +0000, Wei Yang wrote:
> After commit bef8620cd8e0 ("mm: memcg: deprecate the non-hierarchical
> mode"), we won't have a NULL parent except root_mem_cgroup. And this
> case is handled when (memcg == root).
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Roman Gushchin <roman.gushchin@linux.dev>
> CC: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

> ---
>  mm/memcontrol.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 2cd8bfdec379..3ceb9b8592b1 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6587,9 +6587,6 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
>  		return;
>  
>  	parent = parent_mem_cgroup(memcg);
> -	/* No parent means a non-hierarchical mode on v1 memcg */
> -	if (!parent)
> -		return;
>  
>  	if (parent == root) {
>  		memcg->memory.emin = READ_ONCE(memcg->memory.min);
> -- 
> 2.33.1
> 
