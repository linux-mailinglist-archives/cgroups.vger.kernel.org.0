Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD0C4EB3B6
	for <lists+cgroups@lfdr.de>; Tue, 29 Mar 2022 20:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbiC2SuR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Mar 2022 14:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240718AbiC2SuP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Mar 2022 14:50:15 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B467635C
        for <cgroups@vger.kernel.org>; Tue, 29 Mar 2022 11:48:31 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 85so14822450qkm.9
        for <cgroups@vger.kernel.org>; Tue, 29 Mar 2022 11:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2Ue720j7ugMkQUnb/lt991xjPAItzSMjnM76/9qe6aU=;
        b=m6HX8Nmsz+ICbn4fQENinggQ3NePah2mEpss7FwHfTZ8TgTA/q2tp4ZWR/xTIIBTFG
         2lPBT9Ao7i0bjlT6pVRcUsxuGI++hVnjIjc+wSd05nK4flH1vx52YMeMGifUVs4GHKBa
         u2ALEJs2/rMaS4dpk/yXsQVQR6AfguhD+rpcrxOsZKDZnovFsXauEbmFOfWOaGDbvW0R
         T7Lifas5OuwCA5raKzWXiMNQyKauI4h23+MmdmPeO20ChEq6Uhv5la9v2uD6ztvm5tLn
         HfShR2sq1TmiBfZFvvwtR5vFW0eii01viX0Zb6xemCxICMTUXTTLWLlUsG/sCOrGPxa0
         R3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2Ue720j7ugMkQUnb/lt991xjPAItzSMjnM76/9qe6aU=;
        b=QOPucIdus7wKhLnfOj7loRVAzKHZSna673ds181oU/0oB7WIVntJ+9STpwcoxCcvyE
         ++cl0nBqpm86EyRlT+Y6VhMcfqPvlvXsD/nYebKOcf36gcPv9EMKfKf7l0sQf0GKnX0c
         oYInMjyKxWyfI3OFKAU0HWM3u+DA7ZNBMTdkbZQJWTqZ5rx+h0iN8cUAngH1T9vPRkZQ
         qr1AbR42wIYWT63zYgQB83dFak6sjbrEoPnME7ktkAj5uaQGE11+JDf29MRIiJdKitrY
         xE+wnL7hz+X4RFRV4mqSKjk7nCwBgf0JetngLgtFoGmqI0Pjv/R6Q/m8/5IwibaNWt6y
         ZyGA==
X-Gm-Message-State: AOAM53266UQTkdPBpRiv2mKX4bLXzwVACiG2vJSMIcgN3SCpHHX3a/XI
        NL0sdnOkY8P1SsstgUiwy69UxzL/4Lzqeg==
X-Google-Smtp-Source: ABdhPJxNiPEKaJrzC+HT1E7oTA3fORCRoHwfRrknt4QDb+d4iWkOWh0CnuOYXtcWionchC59pLzJGg==
X-Received: by 2002:a05:620a:4452:b0:67d:b94a:8c34 with SMTP id w18-20020a05620a445200b0067db94a8c34mr21479729qkp.167.1648579710538;
        Tue, 29 Mar 2022 11:48:30 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id m4-20020ac85b04000000b002e1dcaed228sm15078404qtw.7.2022.03.29.11.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 11:48:30 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:48:05 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/3] mm/memcg: set pos to prev unconditionally
Message-ID: <YkNUZYrSHPjJ1XOb@cmpxchg.org>
References: <20220225003437.12620-1-richard.weiyang@gmail.com>
 <20220225003437.12620-3-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225003437.12620-3-richard.weiyang@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 25, 2022 at 12:34:36AM +0000, Wei Yang wrote:
> Current code set pos to prev based on condition (prev && !reclaim),
> while we can do this unconditionally.
> 
> Since:
> 
>   * If !reclaim, pos is the same as prev no matter it is NULL or not.
>   * If reclaim, pos would be set properly from iter->position.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>  mm/memcontrol.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 9464fe2aa329..03399146168f 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -980,7 +980,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
>  	struct mem_cgroup_reclaim_iter *iter;
>  	struct cgroup_subsys_state *css = NULL;
>  	struct mem_cgroup *memcg = NULL;
> -	struct mem_cgroup *pos = NULL;
> +	struct mem_cgroup *pos = prev;

I don't like this so much. It suggests pos always starts with prev, no
matter what. But this isn't true for reclaim mode, which overrides the
initialized value again.

>  	if (mem_cgroup_disabled())
>  		return NULL;
> @@ -988,9 +988,6 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
>  	if (!root)
>  		root = root_mem_cgroup;
>  
> -	if (prev && !reclaim)
> -		pos = prev;

How about making the reclaim vs non-reclaim mode explicit and do:

	if (reclaim) {
		...
		pos = iter->position;
		...
	} else {
		pos = prev;
	}
