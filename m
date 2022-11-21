Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF75C631870
	for <lists+cgroups@lfdr.de>; Mon, 21 Nov 2022 03:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiKUCCA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 20 Nov 2022 21:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiKUCB7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 20 Nov 2022 21:01:59 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4B018B0D
        for <cgroups@vger.kernel.org>; Sun, 20 Nov 2022 18:01:58 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 71-20020a17090a09cd00b00218adeb3549so1555963pjo.1
        for <cgroups@vger.kernel.org>; Sun, 20 Nov 2022 18:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McRhEbkJO4TzXUeiVWCG8MYZdpyYAh/UI0V02O72ffA=;
        b=EbJG7unhNaF/gUyUj4qAfK00TtL1GN9HurLGl/zwYmLVMkrGvboKfJiZhuUDzo8HVA
         y4g5YvzbCuOaXTRNGk0BXLhhqcvvO+EXOQMryhqNuZnrnyRWRY/Qg7jXG9uT+IBH/Fh9
         vgZyZxOVyJemEIdVp/5DmbICQ+iLM5CJjdh14olEhf789Z7895MyRp1MAzL9VEqbhwFf
         uL7X9B42yy0Fv4klFvrJReT74Vj4RVU5LiJpyWeN6yde0KuWYScOFjBMj9V/hNAHtrWT
         cZ5roky2c4+Nave/IzprJPWNOiBJeduXVBBmBCY7qzwBnBbyZDlPAkcMbJQFmfWwTW5U
         Wk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=McRhEbkJO4TzXUeiVWCG8MYZdpyYAh/UI0V02O72ffA=;
        b=ZiNE0QNV87Y2p+W8WR1tD3V3sK+8Rg8A22mj8NuC17BB5hpzlHrR+45lq2jMvCAkC2
         5mO+Pi+qQsMmglmHDon3GWmIK96ZHMgagbirjVSEC0FRUzkYp2tB5cha68U2xOHMlr/K
         ZFalopQLspsukySzpIylYTOpUtLaewkmDruENjvMFa19lp7MZzse5bhso8GVQM5vjSwU
         +p6yRylu3r6I3yX2tCmY7HVDVjN/8OerFlgkgwSkFRkqSDvHz7iVpGb/CLCFHbyCM7LY
         vw/jow/IwgW8MA6MnaMAXbDRPtFlbxIRUCdpwMSshKz1VVnhryEif078NpYWH+GxsUxn
         GYBQ==
X-Gm-Message-State: ANoB5pkkiG2TEg7HZj24jCoq4PVSJcxOV993wiAvDyKzeLBhj8Tg87KY
        7rhU/PytgDAS8MNyZojruQrzvg==
X-Google-Smtp-Source: AA0mqf7DPvc8+2WmXr/6xGH6mpfr9RtNtSowWIqlpbC9fJR762IDW9tBW9tgSCDaqZuFlaEZ/DECrw==
X-Received: by 2002:a17:902:ca92:b0:17f:7f60:480a with SMTP id v18-20020a170902ca9200b0017f7f60480amr1100591pld.145.1668996117484;
        Sun, 20 Nov 2022 18:01:57 -0800 (PST)
Received: from [10.54.24.49] ([143.92.118.2])
        by smtp.gmail.com with ESMTPSA id m13-20020a170902db0d00b00188767268ddsm8271223plx.151.2022.11.20.18.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 18:01:57 -0800 (PST)
Message-ID: <191a3853-70c5-b89e-0911-e046207876e5@shopee.com>
Date:   Mon, 21 Nov 2022 10:01:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH] cgroup: Fix typo in comment
To:     Kamalesh Babulal <kamalesh.babulal@oracle.com>, tj@kernel.org
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221120155134.57193-1-haifeng.xu@shopee.com>
 <819bdb10-2569-b7b1-b75b-168b77d1959f@oracle.com>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <819bdb10-2569-b7b1-b75b-168b77d1959f@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2022/11/21 00:38, Kamalesh Babulal wrote:
> 
> 
> On 11/20/22 21:21, haifeng.xu wrote:
>> Replace iff with if.
>>
>> Signed-off-by: haifeng.xu <haifeng.xu@shopee.com>
>> ---
>>  kernel/cgroup/cgroup.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>> index f2743a476190..93c5e50b1392 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -814,7 +814,7 @@ static bool css_set_populated(struct css_set *cset)
>>   * One of the css_sets associated with @cgrp is either getting its first
>>   * task or losing the last.  Update @cgrp->nr_populated_* accordingly.  The
>>   * count is propagated towards root so that a given cgroup's
>> - * nr_populated_children is zero iff none of its descendants contain any
>> + * nr_populated_children is zero if none of its descendants contain any
>>   * tasks.
>>   *
>>   * @cgrp's interface file "cgroup.populated" is zero if both
> 
> iff abbreviates to if and only if and it's a valid usage.
> 

Ok, thanks.
