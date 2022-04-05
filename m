Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BB64F28F8
	for <lists+cgroups@lfdr.de>; Tue,  5 Apr 2022 10:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbiDEIYY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Apr 2022 04:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237169AbiDEIRp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Apr 2022 04:17:45 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC4369284
        for <cgroups@vger.kernel.org>; Tue,  5 Apr 2022 01:05:30 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bg10so25019045ejb.4
        for <cgroups@vger.kernel.org>; Tue, 05 Apr 2022 01:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yyy8ZziaZgnmwLljTWyYhZF76iEy/skny2JVUymVUfc=;
        b=ZrPqW6X6T9AHIOoCE+8DXcGn6ONM3ECUQG7TA8kMbhD/l9G0Y5nl/2aIRaT4SRTqlJ
         iC7dDZTQEwT/ayXIVBtrvcfW3GdeHa2zVQON+czr57By8Bz0qkC8H5IaNBoxEbc8UWgz
         xFlGtjhVE7iZSxOYWyMsFOxQJgFA9YNX9booe1ijJGicN3y52sdh20P0e74Tk4nCLD6m
         G+qjItVnouOs6TR4SaQoEsLAZmfRWNgoDGL91oT0+yhSepn4IpC04eO2/33duVBa7OI7
         TkCrxA766VbsxvW9Q5kVCNu0E919RJy/hMkBS+QXbPg5qhOKSArA3qETqjQ1Ll5wH347
         Tbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yyy8ZziaZgnmwLljTWyYhZF76iEy/skny2JVUymVUfc=;
        b=FsjZ+rDQiNoERIEJ8xaUgUwE7B+yv0Uy7vJXA5BYGpRYAiL4lakuXnH5UCukSlGbzF
         UpMGIB8oBAx818K8bgyBSxsSVBKL18tDM8JymmGeVylv4qg36A6frdvjCPrgsBYX2In2
         qYLT7AVM4nEtpMRt9TNblp/gLN5gZDbV+2PDOXaeCseG5SqejnarZk5OHfdEZAsHg37B
         Ka8TKr8cPZXOFnEDjZPJZ9ujUNwf5nqfB4SVHQ2zjGZ2FigLqDBlDHB2IoCJy2srxYdr
         duo+qPhhvTdQKFIm7cjkm0y4n3HfwWEimzePMkg8r2NKSrHn6zX9hIjI+HlCMYh6OtnC
         8snQ==
X-Gm-Message-State: AOAM532l2Ff5nReWGQp62usBvS/O2n2apQGlk+gCyVko/eIiQC/ltFJ+
        tCv3q3Gewj6zVJyN/PNdUpU=
X-Google-Smtp-Source: ABdhPJxtPeDK1wQijISZPUqOP0D13mscIkjVUd8SzRqm4SJfpK3j0uuamT5f+ZtqTBncfQS3NXF1KQ==
X-Received: by 2002:a17:907:2d2a:b0:6df:c027:a3ac with SMTP id gs42-20020a1709072d2a00b006dfc027a3acmr2172161ejc.179.1649145928749;
        Tue, 05 Apr 2022 01:05:28 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id d7-20020a170906174700b006e80a7e3111sm537587eje.17.2022.04.05.01.05.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Apr 2022 01:05:28 -0700 (PDT)
Date:   Tue, 5 Apr 2022 08:05:27 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm/memcg: non-hierarchical mode is deprecated
Message-ID: <20220405080527.6eoziuwyfc76xvry@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220403020833.26164-1-richard.weiyang@gmail.com>
 <Ykq6Gbt5MX9GCiKM@dhcp22.suse.cz>
 <20220405022218.53idmvm2ha2tzmy2@master>
 <YkvhMx2EVVisfjRG@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkvhMx2EVVisfjRG@dhcp22.suse.cz>
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

On Tue, Apr 05, 2022 at 08:26:59AM +0200, Michal Hocko wrote:
>On Tue 05-04-22 02:22:18, Wei Yang wrote:
>> On Mon, Apr 04, 2022 at 11:27:53AM +0200, Michal Hocko wrote:
>> >On Sun 03-04-22 02:08:33, Wei Yang wrote:
>> >> After commit bef8620cd8e0 ("mm: memcg: deprecate the non-hierarchical
>> >> mode"), we won't have a NULL parent except root_mem_cgroup. And this
>> >> case is handled when (memcg == root).
>> >> 
>> >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> >> CC: Roman Gushchin <roman.gushchin@linux.dev>
>> >> CC: Johannes Weiner <hannes@cmpxchg.org>
>> >
>> >Acked-by: Michal Hocko <mhocko@suse.com>
>> >Thanks!
>> >
>> 
>> Thanks for the ack. When reading the code, I found one redundant check in
>> shrink_node_memcgs().
>> 
>>   shrink_node_memcgs
>>     mem_cgroup_below_min
>>       mem_cgroup_supports_protection
>>     mem_cgroup_below_low
>>       mem_cgroup_supports_protection
>> 
>> I am not sure it worthwhile to take it out.
>> 
>>   shrink_node_memcgs
>>     mem_cgroup_supports_protection
>>       mem_cgroup_below_min
>>       mem_cgroup_below_low
>> 
>> Look forward your opinion.
>
>I guess you refer to mem_cgroup_is_root check in mem_cgroup_supports_protection,
>right?
>
>You are right that the check is not really required because e{min,low}
>should always stay at 0 for the root memcg AFAICS. On the other hand the
>check is not in any hot path and it really adds clarity here because
>protection is not really supported on the root memcg. So I am not this
>is an overall win.

Agree.

>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
