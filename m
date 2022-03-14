Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2274D9047
	for <lists+cgroups@lfdr.de>; Tue, 15 Mar 2022 00:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbiCNXWr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Mar 2022 19:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237486AbiCNXWq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Mar 2022 19:22:46 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA68E3EBA8
        for <cgroups@vger.kernel.org>; Mon, 14 Mar 2022 16:21:35 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gb39so37139065ejc.1
        for <cgroups@vger.kernel.org>; Mon, 14 Mar 2022 16:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6R11bvjmYsahK0gJVGfVX+7+GFhuag8IbRPGFQJNZaM=;
        b=j/wjktA6qFCOxz1OA06/g8dx7uSwFMKqT1oNnSCtnjX9Lwo4cFU16UFCNsIueVvXs3
         45cYyul1S9P2C1B2MTsXqDa+LqH63ZmJDUpI/YuAkns8KCXgyzG+XhkXpr/Sb2PaBZVQ
         jtm2fGEWfakDVIzWQT6BBDk4cQ/qmZE24a5z6tPgjz6b8d3yvqR33lFdb9rzMIoz9f6y
         UzW/dz/Hy034/KJ/7PKPUFNDjOoOqD/03/K1NY/K9qqYu58Yw5ZUpnevBvhbCt9D35Xs
         CJNYN4OQxQcseaAPOhKoLWG9KQ70ftA298t96NXG+TUhplqRXylnSw91DLK+l9P+g6r/
         kAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6R11bvjmYsahK0gJVGfVX+7+GFhuag8IbRPGFQJNZaM=;
        b=3W6zHceaJ6dGz9qzVNKEa5nnEIy3pQfgJZUu3JyQH6YrRqzlj6Hg8JIs0aGnuXXs97
         osiwOC0NQs1ue1rmsMkpNbgId4jfxgrXLUYt7dk5agyymcN4XQZkJel9cWfFUwEKl2WO
         6AuRe8lCr59nUWW3pq0JQBJmS2ZLqkwW2FOQrtla3jCO5cs6r/Hhd9Vt5xACw1Nf2hWk
         X51id/N/IS4tx95YlldLpFWM6ZcUl1pl0+BFR/zFHOv0+Gm6xQers3fS5De2/og5zDtq
         V4m67KVQj3yKcBjgcbBywITPy6RmtUGsom3+jmTt9Azfz3zLN10u11j3fs7zZRwB+fef
         h/pg==
X-Gm-Message-State: AOAM533tEh/0xvkYbxnyq52ffRDs8aRVyO+N9L1fkzlZz1UN2ys2viw9
        V/1l4rtMSPSK5/kdziPW7uY=
X-Google-Smtp-Source: ABdhPJx6MtlWw8feC1uuozWu7W0VrXop/X2ZU1IUPQUgarYKXBHnpU+TH2gk8ejob/DgFMewUmo5tA==
X-Received: by 2002:a17:907:a089:b0:6db:ef38:1a29 with SMTP id hu9-20020a170907a08900b006dbef381a29mr1540111ejc.269.1647300094426;
        Mon, 14 Mar 2022 16:21:34 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709063a0500b006da8fa9526esm7355971eje.178.2022.03.14.16.21.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Mar 2022 16:21:34 -0700 (PDT)
Date:   Mon, 14 Mar 2022 23:21:33 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [Patch v2 1/3] mm/memcg: mz already removed from rb_tree in
 mem_cgroup_largest_soft_limit_node()
Message-ID: <20220314232133.owoq5vzsd2bvggma@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220312071623.19050-1-richard.weiyang@gmail.com>
 <Yi8QN+5oeUWWJQNv@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi8QN+5oeUWWJQNv@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Mar 14, 2022 at 10:51:51AM +0100, Michal Hocko wrote:
>On Sat 12-03-22 07:16:21, Wei Yang wrote:
>> When mz is not NULL, mem_cgroup_largest_soft_limit_node() has removed
>> it from rb_tree.
>> 
>> Not necessary to call __mem_cgroup_remove_exceeded() again.
>
>Yes, the call seems to be unnecessary with the current code. mz can
>either come from mem_cgroup_largest_soft_limit_node or
>__mem_cgroup_largest_soft_limit_node both rely on the latter so the mz
>is always off the tree indeed.
> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>
>After the changelog is completed you can add
>Acked-by: Michal Hocko <mhocko@suse.com>

Will adjust it.

>
>In general, though, I am not a super fan of changes like these. The code
>works as expected, the call for __mem_cgroup_remove_exceeded will not
>really add much of an overhead and at least we can see that mz is always
>removed before it is re-added back. In a hot path I would care much more
>of course but this is effectivelly a dead code as the soft limit itself
>is mostly a relict of past.
>
>Please keep this in mind when you want to make further changes to this
>area. The review is not free of cost and I am not sure spending time on
>this area is worthwhile unless there is a real usecase in mind.
>

Yes, after more understanding of the code, I found soft reclaim seems to be
not that often.

Thanks for your time and will choose some more important area for change.

>Thanks!
>
>> ---
>>  mm/memcontrol.c | 1 -
>>  1 file changed, 1 deletion(-)
>> 
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index f898320b678a..d70bf5cf04eb 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -3458,7 +3458,6 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>>  		nr_reclaimed += reclaimed;
>>  		*total_scanned += nr_scanned;
>>  		spin_lock_irq(&mctz->lock);
>> -		__mem_cgroup_remove_exceeded(mz, mctz);
>>  
>>  		/*
>>  		 * If we failed to reclaim anything from this memory cgroup
>> -- 
>> 2.33.1
>
>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
