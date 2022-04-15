Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B42A502B7E
	for <lists+cgroups@lfdr.de>; Fri, 15 Apr 2022 16:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240569AbiDOOKx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Apr 2022 10:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbiDOOKw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Apr 2022 10:10:52 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3881C056B;
        Fri, 15 Apr 2022 07:08:21 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id c1so6673674qkf.13;
        Fri, 15 Apr 2022 07:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uHT+rtsiU2AlOqKjuhO/N6AsKRtwVlo+UNwK//XAC5E=;
        b=KowIXnpoCSb9fMB3hjO5fn6nGk+x0m6UrPnqXWRO8OwmyGEtOybZfGTaZVVmhZfik2
         hhVlB108J+BdWJqaZ64wTLOvxRk3CfFMjxdTqCn61kLNOAFfKaAOsuiSbg8NWnCjuoRP
         Y5Imkmr9/WrefITZQxIJtD9wIkfvuIA7REPejg7b/GPdXM+6irVMMJerZ918G1iCHQsO
         ZF2x9DXOiadnGrahIbOW3dO10bIc6hpA6KXngLnAAJCBM7VgNuKyPFNNF4XxtnSA17Xk
         122jO5jLfQJO0oqQouWe7Ar/n75CRAF/ppWjENjJC6OfhrDESjHyMU8BhLmy9XWwZlXv
         NmJA==
X-Gm-Message-State: AOAM532BErqszpSQd6/z3lfxafQrdiMEH3xObC6RMCwusuf1cxxo3JWH
        mmPA50CBbBiCRGVUoKkIU8ztJvLOfNp8VA==
X-Google-Smtp-Source: ABdhPJyQuMIVfA3EofR+pKzVdgIzoZLxbA/QPzQX7WZh1MG4ZvuwD4FbA60REwVdu7d5mrVWF/z69g==
X-Received: by 2002:a05:620a:2946:b0:699:c582:f319 with SMTP id n6-20020a05620a294600b00699c582f319mr5622724qkp.118.1650031700522;
        Fri, 15 Apr 2022 07:08:20 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-117.fbsv.net. [2a03:2880:20ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id i136-20020a379f8e000000b0069c7f8b69b8sm1947719qke.82.2022.04.15.07.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 07:08:20 -0700 (PDT)
Date:   Fri, 15 Apr 2022 07:08:17 -0700
From:   David Vernet <void@manifault.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>
Subject: Re: [PATCH 1/4] kselftests: memcg: update the oom group leaf events
 test
Message-ID: <20220415140817.ljznpvacne6nchg5@dev0025.ash9.facebook.com>
References: <20220415000133.3955987-1-roman.gushchin@linux.dev>
 <20220415000133.3955987-2-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415000133.3955987-2-roman.gushchin@linux.dev>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 14, 2022 at 05:01:30PM -0700, Roman Gushchin wrote:
> Commit 9852ae3fe529 ("mm, memcg: consider subtrees in memory.events") made
> memory.events recursive: all events are propagated upwards by the
> tree. It was a change in semantics.

In one of our offline discussions you mentioned that we may want to
consider having the test take mount options into account. If we decide to
go that route we should probably have this testcase take memory_localevents
into account as well. If so, I'm happy to take care of that in a follow-on
patch after this is merged as I already have a patch locally that reads and
parses /proc/mounts to detect these mount options.

> 
> It broke the oom group leaf events test: it assumes that after
> an OOM the oom_kill counter is zero on parent's level.
> 
> Let's adjust the test: it should have similar expectations
> for the child and parent levels.
> 
> The test passes after this fix.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Chris Down <chris@chrisdown.name>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  tools/testing/selftests/cgroup/test_memcontrol.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> index 36ccf2322e21..00b430e7f2a2 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -1079,7 +1079,8 @@ static int test_memcg_sock(const char *root)
>  /*
>   * This test disables swapping and tries to allocate anonymous memory
>   * up to OOM with memory.group.oom set. Then it checks that all
> - * processes in the leaf (but not the parent) were killed.
> + * processes in the leaf were killed. It also checks that oom_events
> + * were propagated to the parent level.
>   */
>  static int test_memcg_oom_group_leaf_events(const char *root)
>  {
> @@ -1122,7 +1123,7 @@ static int test_memcg_oom_group_leaf_events(const char *root)
>  	if (cg_read_key_long(child, "memory.events", "oom_kill ") <= 0)
>  		goto cleanup;
>  
> -	if (cg_read_key_long(parent, "memory.events", "oom_kill ") != 0)
> +	if (cg_read_key_long(parent, "memory.events", "oom_kill ") <= 0)
>  		goto cleanup;
>  
>  	ret = KSFT_PASS;
> -- 
> 2.35.1
> 

Looks good, thanks.

Reviewed-by: David Vernet <void@manifault.com>
