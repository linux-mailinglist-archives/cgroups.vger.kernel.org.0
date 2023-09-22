Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80D07ABC41
	for <lists+cgroups@lfdr.de>; Sat, 23 Sep 2023 01:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjIVXXt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Sep 2023 19:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjIVXXs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Sep 2023 19:23:48 -0400
X-Greylist: delayed 366 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Sep 2023 16:23:41 PDT
Received: from out-209.mta1.migadu.com (out-209.mta1.migadu.com [95.215.58.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A7E1A1
        for <cgroups@vger.kernel.org>; Fri, 22 Sep 2023 16:23:41 -0700 (PDT)
Date:   Fri, 22 Sep 2023 16:17:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695424651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iQQ1ROeb5sVWDljoKrPkH1Y3Dt9naFHqMwDT9jkaz80=;
        b=lDcVe7Ctz0mr4FYdfk0PCQoXY9LxRip/ravP62GITtVHu/Vmta5XDggxyz6KEvsRfYJGd3
        /PvmthJtM6zLKMIC7BNZIJjh2XpsYjdkw8ehXNSVqIMHmqqdZDf0s+Jk2SEQU29sVHGeMX
        DfVr3cbPy8lpYlN/qX+ybiWaO7kS+eU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     mhocko@kernel.org, hannes@cmpxchg.org, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] memcg, oom: unmark under_oom after the oom killer is
 done
Message-ID: <ZQ4giCbTqUpmKWAa@P9FQF9L96D.corp.robot.car>
References: <20230922070529.362202-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922070529.362202-1-haifeng.xu@shopee.com>
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

On Fri, Sep 22, 2023 at 07:05:28AM +0000, Haifeng Xu wrote:
> When application in userland receives oom notification from kernel
> and reads the oom_control file, it's confusing that under_oom is 0
> though the omm killer hasn't finished. The reason is that under_oom
> is cleared before invoking mem_cgroup_out_of_memory(), so move the
> action that unmark under_oom after completing oom handling. Therefore,
> the value of under_oom won't mislead users.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>

Makes sense to me.

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e8ca4bdcb03c..0b6ed63504ca 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1970,8 +1970,8 @@ static bool mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
>  	if (locked)
>  		mem_cgroup_oom_notify(memcg);
>  
> -	mem_cgroup_unmark_under_oom(memcg);
>  	ret = mem_cgroup_out_of_memory(memcg, mask, order);
> +	mem_cgroup_unmark_under_oom(memcg);
>  
>  	if (locked)
>  		mem_cgroup_oom_unlock(memcg);
> -- 
> 2.25.1
> 
