Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249C762C642
	for <lists+cgroups@lfdr.de>; Wed, 16 Nov 2022 18:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbiKPRVp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Nov 2022 12:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbiKPRVo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Nov 2022 12:21:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071492D766
        for <cgroups@vger.kernel.org>; Wed, 16 Nov 2022 09:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668619247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fWWN9OGwNuMYO3D60HWCUrbCelzJvBP0Z8bqEe/19V0=;
        b=ANmQ9Ud3bpYhax6bhGsUFWHFeNILbayneenYnS/Uks6+xwi7XfYr3wmcTZBlJQtV3mPwxw
        ARzwMI4/iS2lkLSoD7USeV3jM5TXbfp4kDB5q+prDP55a3/kgqK1iKSb3J6knukwt66oVw
        osrJM39gclK6HTOF5JWVK0YYqzHddK8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-3VtoqoLbOSWbO0fk-2uOVQ-1; Wed, 16 Nov 2022 12:20:42 -0500
X-MC-Unique: 3VtoqoLbOSWbO0fk-2uOVQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 020E0811E75;
        Wed, 16 Nov 2022 17:20:42 +0000 (UTC)
Received: from [10.22.10.207] (unknown [10.22.10.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AF5849BB60;
        Wed, 16 Nov 2022 17:20:41 +0000 (UTC)
Message-ID: <4691d845-ae91-0cff-e66f-2662188b50b6@redhat.com>
Date:   Wed, 16 Nov 2022 12:20:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] cgroup/cpuset: Improve cpuset_css_alloc() description
Content-Language: en-US
To:     Kamalesh Babulal <kamalesh.babulal@oracle.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Hromatka <tom.hromatka@oracle.com>
References: <20221116054415.79157-1-kamalesh.babulal@oracle.com>
 <7eb8d6f9-b54c-aedc-982b-8ed2bddb948b@redhat.com>
 <c1c5910c-8f5d-1eea-8bd7-7d79f5b5ee87@oracle.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <c1c5910c-8f5d-1eea-8bd7-7d79f5b5ee87@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/16/22 10:40, Kamalesh Babulal wrote:
>
> On 11/16/22 20:06, Waiman Long wrote:
>> On 11/16/22 00:44, Kamalesh Babulal wrote:
>>> Change the function argument in the description of cpuset_css_alloc()
>>> from 'struct cgroup' -> 'struct cgroup_subsys_state'.  The change to the
>>> argument type was introduced by commit eb95419b023a ("cgroup: pass
>>> around cgroup_subsys_state instead of cgroup in subsystem methods").
>>> Also, add more information to its description.
>>>
>>> Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
>>> ---
>>>    kernel/cgroup/cpuset.c | 11 ++++++++---
>>>    1 file changed, 8 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index b474289c15b8..aac790462e74 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -3046,9 +3046,14 @@ static struct cftype dfl_files[] = {
>>>    };
>>>      -/*
>>> - *    cpuset_css_alloc - allocate a cpuset css
>>> - *    cgrp:    control group that the new cpuset will be part of
>>> +/**
>>> + * cpuset_css_alloc - Allocate a cpuset css
>>> + * @parent_css: Parent css of the control group that the new cpuset will be
>>> + *              part of
>>> + * Return: cpuset css on success, -ENOMEM on failure.
>>> + *
>>> + * Allocate and initialize a new cpuset css, for non-root cpuset or return the
>>> + * top cpuset css for root cpuset.
>> Strictly speaking, it returns the css of top cpuset set for NULL input parameter.
> Thank you for reviewing the patch. Does the following, rephrase, sound right:
>
> Allocate and initialize a new cpuset css, for non-NULL @parent_css, return
> top cpuset css otherwise.

That looks fine to me.

Cheers,
Longman

>>>     */
>>>      static struct cgroup_subsys_state *
>> While at it, could you also remove the blank line between the comment and the function body.
> Sure, will remove it.
>

