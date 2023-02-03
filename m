Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CADE689E61
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 16:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjBCPgP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 10:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjBCPgO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 10:36:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620296CC97
        for <cgroups@vger.kernel.org>; Fri,  3 Feb 2023 07:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675438526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uug3Jhs3c7xaX/Rx/hsjur5gbFszvyaZzpEQCntiDz4=;
        b=CPdK4CBF44zKDePe/148nBkJBugcYXoP0fRjksht9ED9dQddYYejzyQjcccinVdU4wAO+s
        5StJlciAUZwg2fSYprXxf6Pz6nvb6ankkCcfwmemeI0V9GuxbOPNRmSw+tx7Gt2PNJSqSh
        ibUjCnp+8f9BlAlODPONjm/X1i/Q6tI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-IX-c6cz7MPWM2dwMahZlJg-1; Fri, 03 Feb 2023 10:35:15 -0500
X-MC-Unique: IX-c6cz7MPWM2dwMahZlJg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4536857A93;
        Fri,  3 Feb 2023 15:35:14 +0000 (UTC)
Received: from [10.22.18.35] (unknown [10.22.18.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE28D40398A0;
        Fri,  3 Feb 2023 15:35:13 +0000 (UTC)
Message-ID: <26617070-e32b-cfc2-d741-0294d5aea0c3@redhat.com>
Date:   Fri, 3 Feb 2023 10:35:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] cpuset: Fix cpuset_cpus_allowed() to not filter
 offline CPUs
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Zefan Li <lizefan.x@bytedance.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
References: <20230131221719.3176-1-will@kernel.org>
 <20230131221719.3176-2-will@kernel.org>
 <6b068916-5e1b-a943-1aad-554964d8b746@redhat.com>
 <Y9otWX+MGOLDKU6t@hirez.programming.kicks-ass.net>
 <83e53632-27ed-8dde-84f4-68c6776d6da8@redhat.com>
 <a892d340-ea99-1562-0e70-176f02f195c2@redhat.com>
 <Y9rVVldS19oyIZ+g@hirez.programming.kicks-ass.net>
 <773e2f22-211e-163f-64bb-15ae29ad161b@redhat.com>
 <20230203115045.GB5927@willie-the-truck>
 <d626998b-4cb0-dd8f-fd97-21715bf2eb0b@redhat.com>
 <Y90nn9NVkEhcZ6nq@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y90nn9NVkEhcZ6nq@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 2/3/23 10:26, Peter Zijlstra wrote:
> On Fri, Feb 03, 2023 at 10:13:10AM -0500, Waiman Long wrote:
>
>> I think I know where the problem is. It is due to the fact the cpuset
>> hotplug code doesn't update cpumasks of the tasks in the top cpuset (root)
>> at all when there is a cpu offline or online event. It is probably because
>> for some of the tasks in the top cpuset, especially the percpu kthread,
>> changing their cpumasks can be catastrophic. The hotplug code does update
>> the cpumasks of the tasks that are not in the top cpuset. This problem is
>> irrespective of whether v1 or v2 is in use.
> I've been saying this exact thing for how many mails now?

My bad. The fact that sched_getaffinity() masks off the offline cpus 
makes me thought incorrectly that tasks in the top cpuset were also 
updated by the hotplug code. Further testing indicates this is the case.

Thanks,
Longman

