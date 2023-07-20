Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2A575A875
	for <lists+cgroups@lfdr.de>; Thu, 20 Jul 2023 09:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjGTH7c (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Jul 2023 03:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjGTH7a (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Jul 2023 03:59:30 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD04269A
        for <cgroups@vger.kernel.org>; Thu, 20 Jul 2023 00:59:04 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-676f16e0bc4so293175b3a.0
        for <cgroups@vger.kernel.org>; Thu, 20 Jul 2023 00:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689839944; x=1690444744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QCBG10jWmv8n11PUl1At+mRhQs+STyCHC9Y8ykk98hs=;
        b=Nnu9yXWnT11QAdbQ9GUhYKZSFFcUk0bsZdtUNqUMHxBWMFa6402Ny2yH5iQxEZhGtt
         Kz3XRv01VgrqlGSpLQm7E8BKzJTbIbnZkymzLZbp9YmpoHsQYwRejn13SBbT7IrQTO6U
         SSKMw0RKNd+ruoF1X7gd4bGzDUdn3VZamns/FpVKcyZVE8bZfh3ZB7SkwGWidjmpWE2S
         z1eYV6E/QnugvkY/taUn0a53MkAB3OHG65tL3psRnBqx/L04+GCvHT8xrBnv01/ZpdL0
         kXwHSiBUs/WAYR8ArUnjYyaQ6W/MAMWTQXpvjgTEogO5unsJNpTbyHBzDOtgtGFpgt0g
         Sp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689839944; x=1690444744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCBG10jWmv8n11PUl1At+mRhQs+STyCHC9Y8ykk98hs=;
        b=ewb1aTH3L2a3bWtoFQHEciKYE9HJhV4ag0H8jGrhNG706z+y/WFEWU/JR6vkNGCkU7
         bhG9K0GGurhg+kHbcPADfadndBFui5CagHAp8ahVuQcjgnrieokIsobDr5XaxgXmVcGx
         ssen+OljBQLKR5rUmSGbN0/PYECJm97n+Cb6PpPJvqMDCLThvqFF94STpXCmwL9JXAmS
         Ek0jXRKHKTNVR/6V/TngkLdIX80fBQhE7Gkom43YDZ96H85ED1ZO9qMH8icE8A2aBOSX
         W8Z3m6P2UJ3/MEhFI7G9fpxjllA4y+7uTjEV55Az7Q9tD6pFtA90sflYPPjENNr6eT3+
         F7nA==
X-Gm-Message-State: ABy/qLaTG4DC3TUOh6gXDTs0Ggj19tvPmRWh3Dje9yResUq9ShoVJw9L
        c1W3fDf7byziQzD1zlu8IvtIBw==
X-Google-Smtp-Source: APBJJlGQceyOTHuEAgshImHxzNJeR5JGceBNvAodrsHOmgwDK+Re8De+gti6K7ICOvS0ObBFvVOw/A==
X-Received: by 2002:a05:6a20:72a4:b0:133:f5c1:57bb with SMTP id o36-20020a056a2072a400b00133f5c157bbmr17999503pzk.20.1689839943740;
        Thu, 20 Jul 2023 00:59:03 -0700 (PDT)
Received: from [10.4.72.29] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902d48100b001b895a17429sm579947plg.280.2023.07.20.00.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 00:59:03 -0700 (PDT)
Message-ID: <d114834c-2336-673f-f200-87fc6efb411f@bytedance.com>
Date:   Thu, 20 Jul 2023 15:58:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND net-next 1/2] net-memcg: Scopify the indicators of
 sockmem pressure
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Ahern <dsahern@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Breno Leitao <leitao@debian.org>,
        David Howells <dhowells@redhat.com>,
        Jason Xing <kernelxing@tencent.com>,
        Xin Long <lucien.xin@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Alexei Starovoitov <ast@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
References: <20230711124157.97169-1-wuyun.abel@bytedance.com>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20230711124157.97169-1-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Gentle ping :)

On 7/11/23 8:41 PM, Abel Wu wrote:
> Now there are two indicators of socket memory pressure sit inside
> struct mem_cgroup, socket_pressure and tcpmem_pressure.
> 
> When in legacy mode aka. cgroupv1, the socket memory is charged
> into a separate counter memcg->tcpmem rather than ->memory, so
> the reclaim pressure of the memcg has nothing to do with socket's
> pressure at all. While for default mode, the ->tcpmem is simply
> not used.
> 
> So {socket,tcpmem}_pressure are only used in default/legacy mode
> respectively. This patch fixes the pieces of code that make mixed
> use of both.
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>   include/linux/memcontrol.h | 4 ++--
>   mm/vmpressure.c            | 8 ++++++++
>   2 files changed, 10 insertions(+), 2 deletions(-)
> 
