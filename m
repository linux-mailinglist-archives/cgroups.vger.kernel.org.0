Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5045E9845
	for <lists+cgroups@lfdr.de>; Mon, 26 Sep 2022 05:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiIZDiT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 25 Sep 2022 23:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiIZDiS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 25 Sep 2022 23:38:18 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF7B25E9A
        for <cgroups@vger.kernel.org>; Sun, 25 Sep 2022 20:38:17 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so11147173pjm.1
        for <cgroups@vger.kernel.org>; Sun, 25 Sep 2022 20:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date;
        bh=6Kb4i0mm6v9pZwbBNK1La/6ffxmbjpXjTkCflKZS3Mw=;
        b=M7KqJY/7x2gd1PCsMuoLwDKeICBqKrtnRWM2bztZmkzd/A+6MHl1gbKPWdDuJbBakh
         PObbN+N9EUBGqIsKWMx5ikDS+Lg/xwj5vIkhB+Ekifcxg5SwEyOECa5ZhL2uiNwOLRci
         I1z2OHsX/u7lOEzhLt3eP6aJGMfsOzEGSYm816K66IK3mR5+12u6qLR1NROPV3tEPvH2
         l2t3XatAqMc58mSloeRlA1DCry7YZhVa27mKiNC9holgSmDdk3FmwjTTuwYhwiF+/Rai
         rgsPtkZSy0uc70R9npGAOlByKBHXm3mbYJOD1ieitPokI7+2RpmYhYIsBt/KxG5Xb+Zz
         9HMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6Kb4i0mm6v9pZwbBNK1La/6ffxmbjpXjTkCflKZS3Mw=;
        b=Y8saY+EZHA8btcn4iI0Ht4OyIug3xhppRjSY5V7vMLV0LEOD3mqg5HDjbW4p8y/lt0
         /T9dU1Q0qzrJj6i3cvTUj4lr1KdUOW+b1ByiyuzsrXEtCyU3K1nbUQAlsS1Jvg7j1KRG
         wUQ2MrjNLSaGiUkQcXTJTX2ZaOv0lB5CZIrINXyRHCwpvexnyn7qP8ZPvoJSWKFL6s1Q
         hDjiXiWnQSZJ0oebVd9pqh9Soze1eumfrlxQVRRXaWWNa5j89PpgIaP4t/hqBq44f/lv
         unPXsW2EwdNcaYCiBFDg1hz89JXXYT3ExE1rsn7SyZki67nOBTli513WJ/x2z11k1NpJ
         G5Fw==
X-Gm-Message-State: ACrzQf39A5SfimcSC62M3jzKNpH3LDSh5HbOj5UGp9gTZu5H4RuMThTc
        31hNMZTyy3gHBY+MYinEgtv8WA==
X-Google-Smtp-Source: AMsMyM7Bdnsa1flHbxEuWPOlLVF87TvYWHB19s570bZFaFP3UAWPt+/Oi5dgiSPE44oZUDmmTQeNVw==
X-Received: by 2002:a17:90b:4f8d:b0:202:dd39:c03a with SMTP id qe13-20020a17090b4f8d00b00202dd39c03amr35063928pjb.71.1664163496691;
        Sun, 25 Sep 2022 20:38:16 -0700 (PDT)
Received: from [10.76.43.192] ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090341c700b0015e8d4eb219sm10185058ple.99.2022.09.25.20.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 20:38:16 -0700 (PDT)
Message-ID: <b3ff8456-fe0e-95a0-cccd-e94025a82560@bytedance.com>
Date:   Mon, 26 Sep 2022 11:38:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
From:   Gang Li <ligang.bdlg@bytedance.com>
Subject: Re: Re: [RFC PATCH v1] mm: oom: introduce cpuset oom
To:     David Rientjes <rientjes@google.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20220921064710.89663-1-ligang.bdlg@bytedance.com>
 <18621b07-256b-7da1-885a-c96dfc8244b6@google.com>
Content-Language: en-US
In-Reply-To: <18621b07-256b-7da1-885a-c96dfc8244b6@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 2022/9/23 03:18, David Rientjes wrote:
> On Wed, 21 Sep 2022, Gang Li wrote:
> 
>> cpuset confine processes to processor and memory node subsets.
>> When a process in cpuset triggers oom, it may kill a completely
>> irrelevant process on another numa node, which will not release any
>> memory for this cpuset.
>>
>> It seems that `CONSTRAINT_CPUSET` is not really doing much these
>> days. Using CONSTRAINT_CPUSET, we can easily achieve node aware oom
>> killing by selecting victim from the cpuset which triggers oom.
>>
>> Suggested-by: Michal Hocko <mhocko@suse.com>
>> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
> 
> Hmm, is this the right approach?
> 
> If a cpuset results in a oom condition, is there a reason why we'd need to
> find a process from within that cpuset to kill?  I think the idea is to
> free memory on the oom set of nodes (cpuset.mems) and that can happen by
> killing a process that is not a member of this cpuset.
> 
Hi,

My last patch implemented this idea[1][2]. But it needs to inc/dec a per 
mm_struct counter on every page allocation/release/migration.

As the Unixbench show, this takes 0%-3% performance loss on different 
workloads[2]. So Michal Hocko inspired me to use cpuset[3].

[1]. 
https://lore.kernel.org/all/20220512044634.63586-1-ligang.bdlg@bytedance.com/
[2]. 
https://lore.kernel.org/all/20220708082129.80115-1-ligang.bdlg@bytedance.com/
[3]. https://lore.kernel.org/all/YoJ%2FioXwGTdCywUE@dhcp22.suse.cz/

> I understand the challenges of creating a NUMA aware oom killer to target
> memory that is actually resident on an oom node, but this approach doesn't
> seem right and could actually lead to pathological cases where a small
> process trying to fork in an otherwise empty cpuset is repeatedly oom
> killing when we'd actually prefer to kill a single large process.
> 

I think there are three ways to achieve NUMA aware oom killer:

1. Count every page operations, which cause performance loss[2].
2. Iterate over pages(like show_numa_map) for all processes, which may 
stuck oom.
3. Select victim in a cpuset, which may leads to pathological kill.(this 
patch)

None of them are perfect and I'm getting stuck, do you have any ideas?
