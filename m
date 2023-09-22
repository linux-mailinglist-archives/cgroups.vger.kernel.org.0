Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C26E7ABC47
	for <lists+cgroups@lfdr.de>; Sat, 23 Sep 2023 01:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjIVX2n (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Sep 2023 19:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjIVX2m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Sep 2023 19:28:42 -0400
X-Greylist: delayed 366 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Sep 2023 16:28:36 PDT
Received: from out-193.mta0.migadu.com (out-193.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6601A2
        for <cgroups@vger.kernel.org>; Fri, 22 Sep 2023 16:28:36 -0700 (PDT)
Date:   Fri, 22 Sep 2023 16:22:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695424949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Yd5FAYRp2gWhAoux+J4rXbuTHxCOAELJy5W8/YW14E=;
        b=SpxHInxhdJoSkVJUo8IGgUe0T+xeuNN/TwfobKv6NiHAwLsdG8y1Y7g7X+2NNsUrtNDvEF
        KWX9a/mwXDZt6d7i0ga1Kyily9Clp8bpc23e6KTYoBISUl8//BqxkZz2k+ILhW+gTIfOc4
        yOr0z/NNYPOR5SKg4wCaICwa8fC0JXU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     mhocko@kernel.org, hannes@cmpxchg.org, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] memcg, oom: do not wake up memcg_oom_waitq if
 waitqueue is empty
Message-ID: <ZQ4hsQRp31RXMOfv@P9FQF9L96D.corp.robot.car>
References: <20230922070529.362202-2-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922070529.362202-2-haifeng.xu@shopee.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 22, 2023 at 07:05:29AM +0000, Haifeng Xu wrote:
> Only when memcg oom killer is disabled, the task which triggers memecg
> oom handling will sleep on a waitqueue. Except this case, the waitqueue
> is empty though under_oom is true. There is no need to step into wake
> up path when resolve the oom situation. So add a check that whether the
> waitqueue is empty.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 0b6ed63504ca..2bb98ff5be3d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1918,7 +1918,7 @@ static void memcg_oom_recover(struct mem_cgroup *memcg)
>  	 * achieved by invoking mem_cgroup_mark_under_oom() before
>  	 * triggering notification.
>  	 */
> -	if (memcg && memcg->under_oom)
> +	if (memcg && memcg->under_oom && !list_empty(&memcg_oom_waitq.head))
>  		__wake_up(&memcg_oom_waitq, TASK_NORMAL, 0, memcg);

This change looks questionable to me:
1) it's not obvious that this racy check is fine. can an oom event be
   missed because of a race here? why not?
2) is there any measurable impact? it's not a hot path, so I'd keep it
   simple.

Thanks!
