Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54D2792EB7
	for <lists+cgroups@lfdr.de>; Tue,  5 Sep 2023 21:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242434AbjIETTW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Sep 2023 15:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242292AbjIETTM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Sep 2023 15:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5448C173E
        for <cgroups@vger.kernel.org>; Tue,  5 Sep 2023 12:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693941422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SMpQ+y8pzoI3FgXSqQEZ+CjbI89jtL1Ecd6vIhxWaHE=;
        b=LzUSqEyg7C9g3KL/duUIaXNCf7Zkpmgd8sKslfoqwvW50b5eCkboPRpyVOXu+o/gefYmsD
        MrZvo/MO7cycsrBOC1B1x+HbypeTpVO3DjMaUsxZMzDu6wDfYwB7VPYYwJMpPeMF91Opld
        iUHaQrlAzPY1GSYmGpWAb7wEFLg/Hy0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-grp9xyeBMZy_bWfI7yBe7A-1; Tue, 05 Sep 2023 15:04:43 -0400
X-MC-Unique: grp9xyeBMZy_bWfI7yBe7A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A15018DA723;
        Tue,  5 Sep 2023 19:03:49 +0000 (UTC)
Received: from [10.22.9.87] (unknown [10.22.9.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0008820BAE38;
        Tue,  5 Sep 2023 19:03:48 +0000 (UTC)
Message-ID: <664019c3-c4b1-6603-7a3d-f44a81737178@redhat.com>
Date:   Tue, 5 Sep 2023 15:03:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATH] cgroup: add cgroup_favordynmods= command-line option
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Luiz Capitulino <luizcap@amazon.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lcapitulino@gmail.com
References: <20230831142046.37177-1-luizcap@amazon.com>
 <20230905170318.GA16629@dev-dsk-luizcap-1d-37beaf15.us-east-1.amazon.com>
 <af394f53-224d-baff-5c7d-87eff7fcaad2@redhat.com>
In-Reply-To: <af394f53-224d-baff-5c7d-87eff7fcaad2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 9/5/23 14:59, Waiman Long wrote:
>
> On 9/5/23 13:03, Luiz Capitulino wrote:
>> On Thu, Aug 31, 2023 at 10:20:46AM -0400, Luiz Capitulino wrote:
>>> We have a need of using favordynmods with cgroup v1, which doesn't 
>>> support
>>> changing mount flags during remount. Enabling CONFIG_FAVOR_DYNMODS at
>>> build-time is not an option because we want to be able to selectively
>>> enable it for certain systems.
>>>
>>> This commit addresses this by introducing the cgroup_favordynmods=
>>> command-line option. This option works for both cgroup v1 and v2 and
>>> also allows for disabling favorynmods when the kernel built with
>>> CONFIG_FAVOR_DYNMODS=y.
>>>
>>> Signed-off-by: Luiz Capitulino <luizcap@amazon.com>
>> Hi,
>>
>> Would somebody take a look at this patch please?
>>
>> Thanks,
>>
>> - Luiz
>
> The patch looks good to me. I do have a minor comment that it may be 
> better to use the relatively new __ro_after_init qualifier instead of 
> __read_mostly.
>
With this patch, CGROUP_FAVOR_DYNMODS kconfig option will have no user. 
So this config option should be removed as well.

Cheers,
Longman

