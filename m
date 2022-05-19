Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D297752CB62
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 07:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbiESFIl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 01:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbiESFIk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 01:08:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A75C92D2E
        for <cgroups@vger.kernel.org>; Wed, 18 May 2022 22:08:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b11-20020a5b008b000000b00624ea481d55so3439334ybp.19
        for <cgroups@vger.kernel.org>; Wed, 18 May 2022 22:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ssVw9Fz9ZtI8VSN2PnnCy16Ie6cjZqhXq7jkPcwK+VI=;
        b=p1NA6cOyXSw5ouGNdhysoNKwpC+u544fyrDYu0KRc2c2e3ge13jLIY2R6C9yI7FNxq
         lvhOpidQwLWrlHfaI75+qsSfVYwYmwzwxfCSsYuVmW20p+OGVFMJ11n4krPvP+4y4yQ3
         ArzvvSz0qUdPdAjWkkkdSdgrgz6lcxZrq3hcwLXfVX1xbuRBis2dKkf871l1prfl+BVv
         o7GhGIaYR4wz+MT62Ioh36TOJ/bKjcTPUZdj+8zF3R3erlBHaKgbD6RpGxh8SAEJFC1I
         DBj+/pEpHKZXlI9DEH4YqWzNp7m8KXD40ml1jejz/hE/UOXcup3+tYdHpbBarswgdd+m
         TrBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ssVw9Fz9ZtI8VSN2PnnCy16Ie6cjZqhXq7jkPcwK+VI=;
        b=kNGR63bPxeOj5dds/FHEPrJX/FdVBIJzymS5qS319Vh06NqR/hl1bqt/+180L4FO9G
         Tza0YbVae0njLDG/UnJM43Yu+0+uat3Ed5SlbegjGIH8qIYFURTc+P2Iui1Op4zV+mW1
         r5whvYNXGcqYKJrxJNktIVCmnUIzs014fZ0z0t17TaBPAvDSAWvlttWDyGjGXNwWJzib
         liJbX93PxZ7wiLtlaFBhdxn54E8Sp/+WwOj9nEIJiuKN3iMchI/vmozfbloI9r9Xh/Qb
         ntYCHHkI1wjGTR64+2I9CYG/aeGpRsCxXxKRbjyuHW0NTzP5UrD4i8guzZ3lzpkqQImm
         TRDg==
X-Gm-Message-State: AOAM531SJzvZ9s6RD/oN5Sa61Y951CSSIYjb4CvsBU9NLXnS1UUsIjyk
        5oHmN7NrNoNOM9zWHlhMPH7oDah6NFITAA==
X-Google-Smtp-Source: ABdhPJy6egbvWliClWw+tkL9hQFg8B3U3tLKaSMVV5VHERLmykIYj5eKmwucruUJqbwmeTA+EslCfrpd5FE0hQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a25:8c0c:0:b0:64e:a4ce:62db with SMTP id
 k12-20020a258c0c000000b0064ea4ce62dbmr2743231ybl.294.1652936918833; Wed, 18
 May 2022 22:08:38 -0700 (PDT)
Date:   Thu, 19 May 2022 05:08:35 +0000
In-Reply-To: <20220518223815.809858-1-vaibhav@linux.ibm.com>
Message-Id: <20220519050835.ebpiukexgiys6t57@google.com>
Mime-Version: 1.0
References: <20220518223815.809858-1-vaibhav@linux.ibm.com>
Subject: Re: [PATCH] memcg: provide reclaim stats via 'memory.reclaim'
From:   Shakeel Butt <shakeelb@google.com>
To:     Vaibhav Jain <vaibhav@linux.ibm.com>
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 19, 2022 at 04:08:15AM +0530, Vaibhav Jain wrote:
> [1] Provides a way for user-space to trigger proactive reclaim by introducing
> a write-only memcg file 'memory.reclaim'. However reclaim stats like number
> of pages scanned and reclaimed is still not directly available to the
> user-space.
> 
> This patch proposes to extend [1] to make the memcg file 'memory.reclaim'
> readable which returns the number of pages scanned / reclaimed during the
> reclaim process from 'struct vmpressure' associated with each memcg. This should
> let user-space asses how successful proactive reclaim triggered from memcg
> 'memory.reclaim' was ?
> 
> With the patch following command flow is expected:
> 
>  # echo "1M" > memory.reclaim
> 
>  # cat memory.reclaim
>    scanned 76
>    reclaimed 32
> 

Yosry already mentioned the race issue with the implementation and I
would prefer we don't create any new dependency on vmpressure which I
think we should deprecate.

Anyways my question is how are you planning to use these metrics i.e.
scanned & reclaimed? I wonder if the data you are interested in can be
extracted without a stable interface. Have you tried BPF way to get
these metrics? We already have a tracepoint in vmscan tracing the
scanned and reclaimed. 
