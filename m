Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBB6368B75
	for <lists+cgroups@lfdr.de>; Fri, 23 Apr 2021 05:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhDWDOT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 23:14:19 -0400
Received: from relay.sw.ru ([185.231.240.75]:47364 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229868AbhDWDOT (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 22 Apr 2021 23:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=0NvUuvrWo3QAz8EIqcQBZaREE776KfZc12xPpNwjQWw=; b=g1poiREG0JAGILOf7
        +I7E+w+lXdutXm4LvYN63DqRAH5nnBD/yBz74tbY2XMuXHlgWZ6Y7U/YJ+YkhBMuoAtVjOFdpNECS
        zO0nzNi7numBF0yFvG6ATil3JZCklXb6HcgcDpZ2CXeiFvvOQUjNJQqgKzPprMVfIVCCWw4emAZxc
        =;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <vvs@virtuozzo.com>)
        id 1lZmG2-001D5k-RR; Fri, 23 Apr 2021 06:13:30 +0300
Subject: Re: [PATCH v3 16/16] memcg: enable accounting for ldt_struct objects
To:     Borislav Petkov <bp@alien8.de>
Cc:     cgroups@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Michal Hocko <mhocko@kernel.org>
References: <dddf6b29-debd-dcb5-62d0-74909d610edb@virtuozzo.com>
 <94dd36cb-3abb-53fc-0f23-26c02094ddf4@virtuozzo.com>
 <20210422122615.GA7021@zn.tnic>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <29fe6b29-d56a-6ea1-2fe7-2b015f6b74ef@virtuozzo.com>
Date:   Fri, 23 Apr 2021 06:13:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210422122615.GA7021@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/22/21 3:26 PM, Borislav Petkov wrote:
> On Thu, Apr 22, 2021 at 01:38:01PM +0300, Vasily Averin wrote:
> 
> You have forgotten to Cc LKML on your submission.
I think it's OK, patch set is addressed to cgroups subsystem amiling list.
Am I missed something and such patches should be sent to LKML anyway?

>> @@ -168,9 +168,10 @@ static struct ldt_struct *alloc_ldt_struct(unsigned int num_entries)
>>  	 * than PAGE_SIZE.
>>  	 */
>>  	if (alloc_size > PAGE_SIZE)
>> -		new_ldt->entries = vzalloc(alloc_size);
>> +		new_ldt->entries = __vmalloc(alloc_size,
>> +					     GFP_KERNEL_ACCOUNT | __GFP_ZERO);
> 
> You don't have to break that line - just let it stick out.
Hmm. I missed that allowed line limit was increased up to 100 bytes,
Thank you, I will fix it in next patch version. 
