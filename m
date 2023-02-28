Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3712C6A5175
	for <lists+cgroups@lfdr.de>; Tue, 28 Feb 2023 03:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjB1Cx1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Feb 2023 21:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB1Cx0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Feb 2023 21:53:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B035126855
        for <cgroups@vger.kernel.org>; Mon, 27 Feb 2023 18:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677552762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XPbt6/x+qYDE9MQFVpKTztSTkJHQtPGD9fckbhyxCmo=;
        b=Eu6Pa3FXAx0/qgSb6TMPzZMDk+tifDBYQ3jhYRM0d700eUO9jzP7iGrnV4WYKKHJwvRHSb
        LG4Q8lk/VWSzgFNgv6dLxh/QiTF9jscTIb7gnjYJ36RUM/nMar32Q6lZWSQUEL8VwnXqqK
        EG+OcciIrhiGgBzT1towIFypekJ79yI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-82-IbbaSl6yNn-Vrqv_QFI3YA-1; Mon, 27 Feb 2023 21:52:41 -0500
X-MC-Unique: IbbaSl6yNn-Vrqv_QFI3YA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C7F91C02D33;
        Tue, 28 Feb 2023 02:52:41 +0000 (UTC)
Received: from [10.22.8.211] (unknown [10.22.8.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D10B8C15BAD;
        Tue, 28 Feb 2023 02:52:40 +0000 (UTC)
Message-ID: <d6df5140-ed7c-2c12-8e5a-d5c3fbf30a47@redhat.com>
Date:   Mon, 27 Feb 2023 21:52:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] cpuset: Remove unused cpuset_node_allowed
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     lizefan.x@bytedance.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230227080719.20280-1-haifeng.xu@shopee.com>
 <9953284e-05da-56b0-047d-ecf18aa53892@redhat.com>
 <0222742e-3c31-b75d-6027-3b6da2be16be@shopee.com>
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <0222742e-3c31-b75d-6027-3b6da2be16be@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/27/23 21:40, Haifeng Xu wrote:
>
> On 2023/2/27 22:56, Waiman Long wrote:
>> On 2/27/23 03:07, Haifeng Xu wrote:
>>> Commit 002f290627c2 ("cpuset: use static key better and convert to new API")
>>> has used __cpuset_node_allowed instead of cpuset_node_allowed to check
>>> whether we can allocate on a memory node. Now this function isn't used by
>>> anyone, so we can remove it safely.
>>>
>>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>>> ---
>>>    include/linux/cpuset.h | 12 ------------
>>>    1 file changed, 12 deletions(-)
>>>
>>> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
>>> index d58e0476ee8e..7fad5afe3bba 100644
>>> --- a/include/linux/cpuset.h
>>> +++ b/include/linux/cpuset.h
>>> @@ -82,13 +82,6 @@ int cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask);
>>>      extern bool __cpuset_node_allowed(int node, gfp_t gfp_mask);
>>>    -static inline bool cpuset_node_allowed(int node, gfp_t gfp_mask)
>>> -{
>>> -    if (cpusets_enabled())
>>> -        return __cpuset_node_allowed(node, gfp_mask);
>>> -    return true;
>>> -}
>>> -
>>>    static inline bool __cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
>>>    {
>>>        return __cpuset_node_allowed(zone_to_nid(z), gfp_mask);
>>> @@ -223,11 +216,6 @@ static inline int cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask)
>>>        return 1;
>>>    }
>>>    -static inline bool cpuset_node_allowed(int node, gfp_t gfp_mask)
>>> -{
>>> -    return true;
>>> -}
>>> -
>>>    static inline bool __cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
>>>    {
>>>        return true;
>> The kernel convention is to add a "__" prefix to a function name if there is higher level helper without the "__" prefix that uses it. Since cpuset_node_allowed() is no longer used. We should just rename __cpuset_node_allowed() to cpuset_node_allowed() and get rid of the unused helper. A bit more code changes are needed for this, though.
>>
>> Cheers,
>> Longman
>>
> Maybe we can still use cpuset_node_allowed in __cpuset_zone_allowed? If so, less code need to be changed.
>
mm/page_alloc.c has 2 references to __cpuset_node_allowed() in their 
comments. These references should also be updated as well. That is why I 
said a bit more code needs to be touched.

Cheers,
Longman

