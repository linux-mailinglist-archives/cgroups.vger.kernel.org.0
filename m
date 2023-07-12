Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B1974FFA1
	for <lists+cgroups@lfdr.de>; Wed, 12 Jul 2023 08:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjGLGqE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jul 2023 02:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjGLGqD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jul 2023 02:46:03 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80C411D
        for <cgroups@vger.kernel.org>; Tue, 11 Jul 2023 23:45:38 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666e6ecb52dso3873791b3a.2
        for <cgroups@vger.kernel.org>; Tue, 11 Jul 2023 23:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689144338; x=1691736338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y8WhpdF8/RW8zGFH/BZgsqEuwmUxTSnkz6bmGMUpKLg=;
        b=W/GvKFglSlPxZ7GDe3SBJk00S68EMh1nVTwsJAwhPkQ3MT365bsUjoqdqE+/sA7CSN
         NRbg4zl/wx1Ls0jXTms3+eFHtQJyUHaiDmc3++U9grS799Xvv+6VfZ7rUTRs7OMQTQAB
         FWp2o073tH2I2V2BGGYkcvq9X9akSwkleCwtv4Cgn9Gl0v/0cXvmNCmhRYQdPENheFEs
         xGjTHkxJaBaShbI/QBVm5k2nSoBimFca0JrTPTEOBCnwYyet961sXcDsDzRAZpzsM6Db
         MLVmvFZEDnKOJT+7M+5szD2mCWMufCAeW02SnLCg9kpv0jB3gHFFeTNQKSCl0J7aqjAE
         5n8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689144338; x=1691736338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8WhpdF8/RW8zGFH/BZgsqEuwmUxTSnkz6bmGMUpKLg=;
        b=aswb/kX4YxJJ42q3IOntV5tglwd7Mkwuw5JNRCMdexpHSLW7sQrqe8ydV4i94jJgSm
         kmEWTcOu+JdqzbBiC3Ap9EMKfT3oIb11Xc9/DmfV3yspuAT0sVFlFar2mnvwaWrglR0z
         VmmCaVaK0dzmMwRpmO58rX08vi7jVQyT4bHliGCrbZyJmJv32jjNrk4XKY/acxctTeI6
         HyqrwZCFB/xsWCxstLVhnhDpfucMaKLstGHMO9xfDkW1pG/I9u5y5d3TlYTSVmLsUArB
         /TmZyBfI11soqzi9CsIuXkWlyOPgdWUHt1xZB0izOEGtsAqSt5VUBDW2KG/+XAL8AAEf
         VBig==
X-Gm-Message-State: ABy/qLZltWVDtxrw/q00MAqSmLGspsUSOA5imvu8kOdh0JGxiXbN9a/u
        mfPliUfu7zXUYaJVwgbgc+9IIQ==
X-Google-Smtp-Source: APBJJlF4k1pkoB3GqDRrCOhh7latAjS6/d0b535BaPunB3YtROa/Y2UxTSwoSRKXrxX78yz7cfx0Xg==
X-Received: by 2002:a05:6a20:7f94:b0:12f:dc60:2b9e with SMTP id d20-20020a056a207f9400b0012fdc602b9emr17247332pzj.48.1689144338323;
        Tue, 11 Jul 2023 23:45:38 -0700 (PDT)
Received: from [10.94.58.170] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id c11-20020a170902cb0b00b001aaf2e8b1eesm3085131ply.248.2023.07.11.23.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 23:45:36 -0700 (PDT)
Message-ID: <987f7855-8b1e-ad1a-29d3-8511ccaa00b2@bytedance.com>
Date:   Wed, 12 Jul 2023 14:45:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: Re: [PATCH RESEND net-next 1/2] net-memcg: Scopify the indicators
 of sockmem pressure
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
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
        Xin Long <lucien.xin@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Alexei Starovoitov <ast@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
References: <20230711124157.97169-1-wuyun.abel@bytedance.com>
 <20230711204537.04cb1124@kernel.org>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20230711204537.04cb1124@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jakub,

On 7/12/23 11:45 AM, Jakub Kicinski wrote:
> On Tue, 11 Jul 2023 20:41:43 +0800 Abel Wu wrote:
>> Now there are two indicators of socket memory pressure sit inside
>> struct mem_cgroup, socket_pressure and tcpmem_pressure.
>>
>> When in legacy mode aka. cgroupv1, the socket memory is charged
>> into a separate counter memcg->tcpmem rather than ->memory, so
>> the reclaim pressure of the memcg has nothing to do with socket's
>> pressure at all. While for default mode, the ->tcpmem is simply
>> not used.
>>
>> So {socket,tcpmem}_pressure are only used in default/legacy mode
>> respectively. This patch fixes the pieces of code that make mixed
>> use of both.
> 
> Eric Dumazet is currently AFK, can we wait for him to return
> (in about a week) before merging?

Sure, thanks for providing this information!

Best Regards,
	Abel
