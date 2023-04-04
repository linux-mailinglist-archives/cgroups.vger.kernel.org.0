Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7346D6AB6
	for <lists+cgroups@lfdr.de>; Tue,  4 Apr 2023 19:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjDDRfu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Apr 2023 13:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbjDDRft (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Apr 2023 13:35:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591AD55A9
        for <cgroups@vger.kernel.org>; Tue,  4 Apr 2023 10:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680629581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+zbXb6Euw4EpIZ9qJHPVIzO46HN/te+bwrGro+cOrx4=;
        b=JmuRGwHujMJWP4I3EU90/37F5DCO1qAUQb9j8UgQUC0YKYH2UcN8HVAg17GAWMkXCiAe9l
        o1qq6u/aj3THFQrZ7NBxj0RJvcEJjhViOhdvhUy4Xu6fS85P+pa1jB8xjxm6HWhR+sYNJT
        oDZo6blCtaoG2A354X5mx+ZNj9Vke90=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-K0iMKucdO3-tSyah-zg1QA-1; Tue, 04 Apr 2023 13:26:18 -0400
X-MC-Unique: K0iMKucdO3-tSyah-zg1QA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1CD421C0754D;
        Tue,  4 Apr 2023 17:26:11 +0000 (UTC)
Received: from [10.22.32.153] (unknown [10.22.32.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8962AFD6E;
        Tue,  4 Apr 2023 17:26:10 +0000 (UTC)
Message-ID: <1100a740-3da4-a5bd-6a98-49b49c97b11b@redhat.com>
Date:   Tue, 4 Apr 2023 13:26:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/3] cgroup/cpuset: Make cpuset_fork() handle
 CLONE_INTO_CGROUP properly
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        gscrivan@redhat.com
References: <20230331145045.2251683-1-longman@redhat.com>
 <20230331145045.2251683-2-longman@redhat.com>
 <20230403165523.aphsec2epqi72k27@blackpad>
 <d9f0005c-6825-b2a0-eac3-fcbad6e32b2f@redhat.com>
 <20230404091953.tcu3zg7npstk3ztc@blackpad>
 <a01585bc-03f8-e32c-ac46-99ac484a5e5d@redhat.com>
In-Reply-To: <a01585bc-03f8-e32c-ac46-99ac484a5e5d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/4/23 09:52, Waiman Long wrote:
>
> On 4/4/23 05:19, Michal Koutný wrote:
>> On Mon, Apr 03, 2023 at 01:18:42PM -0400, Waiman Long 
>> <longman@redhat.com> wrote:
>>> 1) PF_NO_SETAFFINITY flag - which won't be set in the case of fork() 
>>> as it
>>> is for kthread only.
>>> 2) DL bandwidth - Juri has a cpuset outstanding to modify the way 
>>> this check
>>> is being done. I want to wait until it is settled before tackling 
>>> this, if
>>> necessary.
>> BTW what about CLONE_INTO_CGROUP where the target cpuset has empty
>> effective cpuset?
> Good point. That will require a can_fork() method then. I will look 
> into that.
>>
>>> 3) security_task_setscheduler() - the CLONE_INTO_CGROUP code has 
>>> already
>>> checked that, we don't need to duplicate the check.
>> Not sure what this refers to.
> It is just checking of the task the has privilege of running into that 
> cgroup.
>>
>>> So we don't need a can_fork() check for now.
>> Anyway, good breakdown. Could you please add it to the commit message
>> too?
>
> Yes, I can put that into the commit log.

I decide to add the can_fork method to do a pre-check. So I don't think 
I need to update the commit log of this patch.

Cheers,
Longman

