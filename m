Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555F563698B
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 20:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239639AbiKWTHJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 14:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236590AbiKWTHI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 14:07:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A1CB0420
        for <cgroups@vger.kernel.org>; Wed, 23 Nov 2022 11:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669230366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SDRg/5ZBX3XDzjEuh83I6NIeECdfJo03H+sBbmb+sh8=;
        b=Brta+LkyS9A8u/1n42xRhg9epE0iJtV+LtHV3EmTn6IB6eqH8LOUGBU4zekJZ/1Tw9mZh7
        Cko5YvtuSjnvcUZThjDyZwYLzaFdO8Lo8FRHGPBchpc23KZC+mNcdmZhydi4FrJ4gHXakA
        yl0FyFWEF6Lzchjb/At9XD+4SYG1+pg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-6s7-BiPVP5G29OaqdhZcgg-1; Wed, 23 Nov 2022 14:06:02 -0500
X-MC-Unique: 6s7-BiPVP5G29OaqdhZcgg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 392181C068CC;
        Wed, 23 Nov 2022 19:06:02 +0000 (UTC)
Received: from [10.22.17.47] (unknown [10.22.17.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A86FDC15BA5;
        Wed, 23 Nov 2022 19:06:01 +0000 (UTC)
Message-ID: <a89de82d-41e7-a40f-a5a3-83ad62bf383f@redhat.com>
Date:   Wed, 23 Nov 2022 14:05:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] cgroup/cpuset: Optimize update_tasks_nodemask()
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     "haifeng.xu" <haifeng.xu@shopee.com>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221123082157.71326-1-haifeng.xu@shopee.com>
 <Y35Swdpq+rJe+Tu3@slm.duckdns.org>
 <5fccf438-fdbe-1bc8-6460-b3911cc51566@redhat.com>
 <Y35sbREgYE6aIdIp@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y35sbREgYE6aIdIp@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 11/23/22 13:54, Tejun Heo wrote:
> On Wed, Nov 23, 2022 at 01:48:46PM -0500, Waiman Long wrote:
>> I think it is an issue anyway if different threads of a process are in
>> different cpusets with different node mask. It is not a configuration that
>> should be used at all.
> Anything memory related is in the same boat and people still use them
> reaching whatever end results they reach. Given the whole thing is pretty
> ill-defined, I don't wanna change the behavior now.
I am just saying that this is not a good config. I don't have any 
intention to change the existing behavior at all.
>
>> This patch makes update_tasks_nodemask() somewhat similar to cpuset_attach()
>> where all tasks are iterated to update the node mask but only the task
>> leaders are required to update the mm. For a non-group leader task, maybe we
>> can check if the group leader is in the same cpuset. If so, we can skip the
>> mm update. Do we need similar change in cpuset_attach()?
> The leader isn't special tho. We just wanna avoid visiting the same mm more
> than once, right?

Right, the group leader is just a marker to make it easier to avoid 
duplicating the work for the same mm. If the group leader happens to be 
in another cpuset, it will suffer some performance consequence.

Cheers,
Longman

