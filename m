Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3366A51B1
	for <lists+cgroups@lfdr.de>; Tue, 28 Feb 2023 04:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjB1DNi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Feb 2023 22:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjB1DNh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Feb 2023 22:13:37 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC53E5BA3
        for <cgroups@vger.kernel.org>; Mon, 27 Feb 2023 19:13:36 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id h8so5692280plf.10
        for <cgroups@vger.kernel.org>; Mon, 27 Feb 2023 19:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1677554016;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOmm/Vo67LFh2DeLQEl+PyGHp2QpvdcC8yMg1+l9oPo=;
        b=R1jqaA2eIonxb4RUDB15L7AxwldFeSpdbxSp05n/iPBlv6erUG5rKVF8HpSmd3yCsS
         l+9VL9FZS65HaOxr9D0t8IMxGDUaNU7gYPtc7boarOzEUUHtVwR2iJp4uE0euYThZJHW
         GBp99ckTO6UbgYy2kMGQltmQSAthhenH9IgYF8AjeN4voefOBtBHBQp073UJOib6EaOs
         ap1RxkorRzhb9lM6Cl0YvI+WoVwLn7IyBP2aGaS9ClWMPnkdR4xoQRzWGuU9accbOcug
         bFaBu5XYT8C+Fr49LBDla0PVjKcvZiJG33QTQTAgSUyLRJi0ZJlG2VpXKl3fd6ShNLly
         dTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677554016;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pOmm/Vo67LFh2DeLQEl+PyGHp2QpvdcC8yMg1+l9oPo=;
        b=fua8ImLvWAnb69Q9jrFPVrLthHhOJh+EgbpIrTxmT7GW0YxEj4lCVzlEbTmRYQNb+H
         4vHzCGhfrZPPyq/Vi9pC+T4jgcICjx5q6xObMNvPx3U3HykmyESjBx4QlEsXrYPmc5Ot
         XQzvwU5gdiDfAH7arFVcYpk8c+MEur9RMEp9uKeUyH+4/OJg+7vqDAtZ8fkgjG+kf8hc
         BBKrekSkGhaJzyF34GJpnR4eiO4HPIKVuwCOdJV1t/ZxwjU36LagvcOfGqK9tDvW+1+S
         SLLBwNsj6xbS5HI7oqRyXnal7VX5C/PoJk1fVBpISX6Lq5Sp9tbOCcq8ttmKlCDvOTej
         3HGg==
X-Gm-Message-State: AO0yUKXDYcyymhen68VBTDQicMEjWyxkqopHwTmvXhiVI8T/qIIrgJeY
        zrxWn8p+/yFyQpw/LWT3Oz9aHw==
X-Google-Smtp-Source: AK7set+rrl6uCpBddpqmVCFPuDnIQM2HuvpUbPUFAvzzi91CzifNh1DSkVaiMLl1zKaeNl3Rw/rOfQ==
X-Received: by 2002:a05:6a20:42a3:b0:cd:83b1:420d with SMTP id o35-20020a056a2042a300b000cd83b1420dmr1879064pzj.38.1677554016415;
        Mon, 27 Feb 2023 19:13:36 -0800 (PST)
Received: from [10.54.24.141] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id k10-20020aa7820a000000b005a9ea5d43ddsm5033146pfi.174.2023.02.27.19.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 19:13:36 -0800 (PST)
Message-ID: <802cb319-37d9-c5a7-46f3-73e729a27239@shopee.com>
Date:   Tue, 28 Feb 2023 11:13:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] cpuset: Remove unused cpuset_node_allowed
To:     Waiman Long <longman@redhat.com>
Cc:     lizefan.x@bytedance.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230227080719.20280-1-haifeng.xu@shopee.com>
 <9953284e-05da-56b0-047d-ecf18aa53892@redhat.com>
 <0222742e-3c31-b75d-6027-3b6da2be16be@shopee.com>
 <d6df5140-ed7c-2c12-8e5a-d5c3fbf30a47@redhat.com>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <d6df5140-ed7c-2c12-8e5a-d5c3fbf30a47@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2023/2/28 10:52, Waiman Long wrote:
> On 2/27/23 21:40, Haifeng Xu wrote:
>>
>> On 2023/2/27 22:56, Waiman Long wrote:
>>> On 2/27/23 03:07, Haifeng Xu wrote:
>>>> Commit 002f290627c2 ("cpuset: use static key better and convert to new API")
>>>> has used __cpuset_node_allowed instead of cpuset_node_allowed to check
>>>> whether we can allocate on a memory node. Now this function isn't used by
>>>> anyone, so we can remove it safely.
>>>>
>>>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>>>> ---
>>>>    include/linux/cpuset.h | 12 ------------
>>>>    1 file changed, 12 deletions(-)
>>>>
>>>> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
>>>> index d58e0476ee8e..7fad5afe3bba 100644
>>>> --- a/include/linux/cpuset.h
>>>> +++ b/include/linux/cpuset.h
>>>> @@ -82,13 +82,6 @@ int cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask);
>>>>      extern bool __cpuset_node_allowed(int node, gfp_t gfp_mask);
>>>>    -static inline bool cpuset_node_allowed(int node, gfp_t gfp_mask)
>>>> -{
>>>> -    if (cpusets_enabled())
>>>> -        return __cpuset_node_allowed(node, gfp_mask);
>>>> -    return true;
>>>> -}
>>>> -
>>>>    static inline bool __cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
>>>>    {
>>>>        return __cpuset_node_allowed(zone_to_nid(z), gfp_mask);
>>>> @@ -223,11 +216,6 @@ static inline int cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask)
>>>>        return 1;
>>>>    }
>>>>    -static inline bool cpuset_node_allowed(int node, gfp_t gfp_mask)
>>>> -{
>>>> -    return true;
>>>> -}
>>>> -
>>>>    static inline bool __cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
>>>>    {
>>>>        return true;
>>> The kernel convention is to add a "__" prefix to a function name if there is higher level helper without the "__" prefix that uses it. Since cpuset_node_allowed() is no longer used. We should just rename __cpuset_node_allowed() to cpuset_node_allowed() and get rid of the unused helper. A bit more code changes are needed for this, though.
>>>
>>> Cheers,
>>> Longman
>>>
>> Maybe we can still use cpuset_node_allowed in __cpuset_zone_allowed? If so, less code need to be changed.
>>
> mm/page_alloc.c has 2 references to __cpuset_node_allowed() in their comments. These references should also be updated as well. That is why I said a bit more code needs to be touched.
> 
> Cheers,
> Longman
> 

Ok. I mean maybe we could keep cpuset_node_allowed() and use it in __cpuset_zone_allowed(). So we don't need rename __cpuset_node_allowed() or update releated comments.

Thanks.
