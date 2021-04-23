Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890D136905F
	for <lists+cgroups@lfdr.de>; Fri, 23 Apr 2021 12:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhDWKao (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Apr 2021 06:30:44 -0400
Received: from relay.sw.ru ([185.231.240.75]:53696 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236052AbhDWKan (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 23 Apr 2021 06:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=o1TMSU6U0xli7XU/m9XwkhWjb5UG9AFTKXPRNJ3+I1Q=; b=eDHWN7Oue1H0/S/BP
        vxRRH4lBiCXyQM1RYMwk/Wmb8w9BArAaz4yaSrOgFULUeugHfTF0DpjraK+svei+OgF0cRxvTJVLM
        L/dRl/5gN/eXitHPExTKURHgsrQFN6oKLhN0G7nppcH18GZ3yeWVxIuQlweTT3zM3Xf5L8hV+uVrk
        =;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <vvs@virtuozzo.com>)
        id 1lZt4M-001Dxp-9D; Fri, 23 Apr 2021 13:29:54 +0300
Subject: Re: [PATCH v3 15/16] memcg: enable accounting for tty-related objects
To:     Michal Hocko <mhocko@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        cgroups@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Jiri Slaby <jirislaby@kernel.org>
References: <dddf6b29-debd-dcb5-62d0-74909d610edb@virtuozzo.com>
 <da450388-2fbc-1bb8-0839-b6480cb0eead@virtuozzo.com>
 <YIFcqcd4dCiNcILj@kroah.com> <YIFhuwlXKaAaY3IU@dhcp22.suse.cz>
 <YIFjI3zHVQr4BjHc@kroah.com>
 <6e697a1f-936d-5ffe-d29f-e4dcbe099799@virtuozzo.com>
 <03cb1ce9-143a-1cd0-f34b-d608c3bbc66c@virtuozzo.com>
 <YIKMMSf1uPrWmT2V@dhcp22.suse.cz>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <31c49c60-44db-0363-3d07-5febe0048e86@virtuozzo.com>
Date:   Fri, 23 Apr 2021 13:29:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YIKMMSf1uPrWmT2V@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/23/21 11:58 AM, Michal Hocko wrote:
> On Fri 23-04-21 10:53:55, Vasily Averin wrote:
>> On 4/22/21 4:59 PM, Vasily Averin wrote:
>>> On 4/22/21 2:50 PM, Greg Kroah-Hartman wrote:
>>>> On Thu, Apr 22, 2021 at 01:44:59PM +0200, Michal Hocko wrote:
>>>>> On Thu 22-04-21 13:23:21, Greg KH wrote:
>>>>>> On Thu, Apr 22, 2021 at 01:37:53PM +0300, Vasily Averin wrote:
>>>>>>> At each login the user forces the kernel to create a new terminal and
>>>>>>> allocate up to ~1Kb memory for the tty-related structures.
>>>>>>
>>>>>> Does this tiny amount of memory actually matter?
>>>>>
>>>>> The primary question is whether an untrusted user can trigger an
>>>>> unbounded amount of these allocations.
>>>>
>>>> Can they?  They are not bounded by some other resource limit?
>>>
>>> I'm not ready to provide usecase right now,
>>> but on the other hand I do not see any related limits.
>>> Let me take time out to dig this question.
>>
>> By default it's allowed to create up to 4096 ptys with 1024 reserve for initns only
>> and the settings are controlled by host admin. It's OK.
>> Though this default is not enough for hosters with thousands of containers per node.
>> Host admin can be forced to increase it up to NR_UNIX98_PTY_MAX = 1<<20.
>>
>> By default container is restricted by pty mount_opt.max = 1024, but admin inside container 
>> can change it via remount. In result one container can consume almost all allowed ptys 
>> and allocate up to 1Gb of unaccounted memory.
>>
>> It is not enough per-se to trigger OOM on host, however anyway, it allows to significantly
>> exceed the assigned memcg limit and leads to troubles on the over-committed node.
>> So I still think it makes sense to account this memory.
> 
> This is a very valuable information to have in the changelog. It is not
> my call but if all the above is correct then the accounting is worth
> IMO.

If Greg doesn't have any objections, I'll add this explanation to the next version of the patch.

