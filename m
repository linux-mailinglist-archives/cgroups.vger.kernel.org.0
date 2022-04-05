Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F1F4F2125
	for <lists+cgroups@lfdr.de>; Tue,  5 Apr 2022 06:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiDECyu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Apr 2022 22:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiDECyl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Apr 2022 22:54:41 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBF52957E5
        for <cgroups@vger.kernel.org>; Mon,  4 Apr 2022 19:22:21 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id f18so8192491edc.5
        for <cgroups@vger.kernel.org>; Mon, 04 Apr 2022 19:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PGMcc6BBrVtiS+i2Ug0VtK3wbbeBQEHvMN1RCK8rtJM=;
        b=T7b/kFnop+W+o3vMn+4faNMaH/6FVivfWcDvLooM6SXo3IuYPc5Pc/iLnyOFOYM4Lx
         +PEnWnwS+79f6ahrGXwHJKWetACHMgs7G8t1cyqZ/8gcnVcaAmosyjvJMWlkARoO3RmJ
         AZzav9BHLYzjA2Y//zznKm9QPwReL4zr+QJcHW1TNKytJQfT/NVLXQ2Tcmumf69mJ0vk
         MssrfEYgxZ2RJN81lAy3kL3NgqjHh9yzfbCWWLeIznHl8O3kh/X4EH2kRL6VK4TcYF9r
         CUsz2CB0x9Zg/1pD4IlLrggiu8K3gzEViK9SKYb1Z86W1Gqv7qXkzGy1TvdQIrf8gxkB
         ULcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PGMcc6BBrVtiS+i2Ug0VtK3wbbeBQEHvMN1RCK8rtJM=;
        b=rG+lnpGuHXk7BOYYZNBb0JoKBWvtQldYikgHrirDtVOy0C5hMqtwZixC1dbuCiuJ/E
         KRSQYokpPphrSsysHF30z501ayMJD2OkOEy4PB7veHQRusppl1sfF9peNtIZmYkJ4QNz
         nrmeDnlPUDdNORVTWFvHduljca8mhXJclO/sfIozR1h1pmfLtob+awLXnJ6BeD8eGuy/
         SKGgU03NMGtPOFo+o08HwoeqWjaqUpFx5bOx+n+how8w2Szr0BTqp92fJ0PGIXB0cXIY
         +Qq1LvY07rAef70KPW1FQd1SCsh0LVlmGPDJNsNgkpPGKHzORvMO7GdTJgFAboagDFFs
         w03g==
X-Gm-Message-State: AOAM530OI5JQieK1AK2CsNXYLlz7BwNzdxXSu0PmwH89KY0A53bqfOZl
        VipVSqewovA5m361yN3VPNs=
X-Google-Smtp-Source: ABdhPJyo/xdpPRsyGVYrEqRBQBwfDNp5B9V9lJiT+LnoQtMPKnQy/GcJWhyFgpqLAXDHzuyD/XR6/Q==
X-Received: by 2002:a05:6402:22d8:b0:41c:c3cd:478e with SMTP id dm24-20020a05640222d800b0041cc3cd478emr1228107edb.34.1649125339797;
        Mon, 04 Apr 2022 19:22:19 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id c1-20020a50cf01000000b0041cb7e02a5csm4085867edk.87.2022.04.04.19.22.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Apr 2022 19:22:19 -0700 (PDT)
Date:   Tue, 5 Apr 2022 02:22:18 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm/memcg: non-hierarchical mode is deprecated
Message-ID: <20220405022218.53idmvm2ha2tzmy2@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220403020833.26164-1-richard.weiyang@gmail.com>
 <Ykq6Gbt5MX9GCiKM@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ykq6Gbt5MX9GCiKM@dhcp22.suse.cz>
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

On Mon, Apr 04, 2022 at 11:27:53AM +0200, Michal Hocko wrote:
>On Sun 03-04-22 02:08:33, Wei Yang wrote:
>> After commit bef8620cd8e0 ("mm: memcg: deprecate the non-hierarchical
>> mode"), we won't have a NULL parent except root_mem_cgroup. And this
>> case is handled when (memcg == root).
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> CC: Roman Gushchin <roman.gushchin@linux.dev>
>> CC: Johannes Weiner <hannes@cmpxchg.org>
>
>Acked-by: Michal Hocko <mhocko@suse.com>
>Thanks!
>

Thanks for the ack. When reading the code, I found one redundant check in
shrink_node_memcgs().

  shrink_node_memcgs
    mem_cgroup_below_min
      mem_cgroup_supports_protection
    mem_cgroup_below_low
      mem_cgroup_supports_protection

I am not sure it worthwhile to take it out.

  shrink_node_memcgs
    mem_cgroup_supports_protection
      mem_cgroup_below_min
      mem_cgroup_below_low

Look forward your opinion.

-- 
Wei Yang
Help you, Help me
