Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CAA5FB8BD
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 19:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiJKRAc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Oct 2022 13:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiJKRAc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Oct 2022 13:00:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F305443ADE
        for <cgroups@vger.kernel.org>; Tue, 11 Oct 2022 10:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665507629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+rCyzNiafV5vn9qzVyq2e5KcGK78bTJRE4XDDdx4VjI=;
        b=D6E5zEoN2COIye4o0bHlVvTc6SUSwDmnq/zA4JD689nUCw1BNmFd5I/02xRXvRr8c3qX3V
        AQ1G8AuxwuHbeEA0h8QXPUshNkKE/+7TCasouLDZ4LSUVlApO+Q17wkWUlnTQNZ++omkrx
        Zf/Vs+2C8bd0TtQSTCkod3mpAFqX68o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-FnjlEY_zMwGOlULVLQmSFg-1; Tue, 11 Oct 2022 13:00:24 -0400
X-MC-Unique: FnjlEY_zMwGOlULVLQmSFg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 197AD801585;
        Tue, 11 Oct 2022 17:00:23 +0000 (UTC)
Received: from [10.22.17.56] (unknown [10.22.17.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7CD35414A809;
        Tue, 11 Oct 2022 17:00:22 +0000 (UTC)
Message-ID: <defdb421-342e-ebcb-d7f0-005559dd1e0d@redhat.com>
Date:   Tue, 11 Oct 2022 13:00:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] mm/memcontrol: Don't increase effective low/min if no
 protection needed
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Tejun Heo <tj@kernel.org>,
        Chris Down <chris@chrisdown.name>
References: <20221011143015.1152968-1-longman@redhat.com>
 <Y0WOPZxWSnUjzZ8e@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y0WOPZxWSnUjzZ8e@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/11/22 11:39, Michal Hocko wrote:
> On Tue 11-10-22 10:30:15, Waiman Long wrote:
>> Since commit bc50bcc6e00b ("mm: memcontrol: clean up and document
>> effective low/min calculations"), the effective low/min protections can
>> be non-zero even if the corresponding memory.low/min values are 0. That
>> can surprise users to see MEMCG_LOW events even when the memory.low
>> value is not set. One example is the LTP's memcontrol04 test which fails
>> because it detects some MEMCG_LOW events for a cgroup with a memory.min
>> value of 0.
> Is this with memory_recursiveprot mount option?
Yes, the memory_recursiveprot mount option is indeed turned on.
>
>> Fix this by updating effective_protection() to not returning a non-zero
>> low/min protection values if the corresponding memory.low/min values
>> or those of its parent are 0.
>>
>> Fixes: bc50bcc6e00b ("mm: memcontrol: clean up and document effective low/min calculations")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   mm/memcontrol.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index b69979c9ced5..893d4d5e518a 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -6660,6 +6660,9 @@ static unsigned long effective_protection(unsigned long usage,
>>   	unsigned long protected;
>>   	unsigned long ep;
>>   
>> +	if (!setting || !parent_effective)
>> +		return 0UL;	/* No protection is needed */
>> +
> This will break the above memory_recursiveprot AFAICS.

You are right about that. An alternative way to address this issue is to 
disable memory low event when memory.low isn't set. An user who want to 
track memory.low event has to set it to a non-zero value. Would that be 
acceptable?

Cheers,
Longman


