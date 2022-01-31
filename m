Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A814A4E98
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 19:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356790AbiAaSih (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 13:38:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60843 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356739AbiAaSih (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 13:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643654316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DiBnAFdQdse7D2Q1MQrjsVd8hfDU0Q4Z6wXjB4bB+ic=;
        b=cP1Ii4hxSm+0Xe2SqHwilseLd+hoavcQG+3xcrlyWxCte5DlwbNSvM/t7f3QMa7jjbyMh/
        tNZs0Dld85Of4QHPgbd96QO9cTMwvhMRGaP/gUifOcZ+CUz2935hzM4RiX3u1L8Bg1rsVk
        db8hd1STOFwdKLEZw4e2NuB8CoKATDU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-wk6H0LuIP_2AxFRLUl6LTQ-1; Mon, 31 Jan 2022 13:38:33 -0500
X-MC-Unique: wk6H0LuIP_2AxFRLUl6LTQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B70884B9A7;
        Mon, 31 Jan 2022 18:38:31 +0000 (UTC)
Received: from [10.22.16.244] (unknown [10.22.16.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3D8285EEC;
        Mon, 31 Jan 2022 18:38:28 +0000 (UTC)
Message-ID: <12686956-612d-d89b-5641-470d5e913090@redhat.com>
Date:   Mon, 31 Jan 2022 13:38:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 3/3] mm/page_owner: Dump memcg information
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Rafael Aquini <aquini@redhat.com>
References: <20220129205315.478628-1-longman@redhat.com>
 <20220129205315.478628-4-longman@redhat.com>
 <YfeuK5j7cbgM+Oo+@dhcp22.suse.cz> <YfgT/9tEREQNiiAN@cmpxchg.org>
 <YfgnUZQBRkqhrEIb@carbon.dhcp.thefacebook.com>
 <Yfgpknwr1tMnPkqh@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Yfgpknwr1tMnPkqh@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/31/22 13:25, Michal Hocko wrote:
> On Mon 31-01-22 10:15:45, Roman Gushchin wrote:
>> On Mon, Jan 31, 2022 at 11:53:19AM -0500, Johannes Weiner wrote:
>>> On Mon, Jan 31, 2022 at 10:38:51AM +0100, Michal Hocko wrote:
>>>> On Sat 29-01-22 15:53:15, Waiman Long wrote:
>>>>> It was found that a number of offlined memcgs were not freed because
>>>>> they were pinned by some charged pages that were present. Even "echo
>>>>> 1 > /proc/sys/vm/drop_caches" wasn't able to free those pages. These
>>>>> offlined but not freed memcgs tend to increase in number over time with
>>>>> the side effect that percpu memory consumption as shown in /proc/meminfo
>>>>> also increases over time.
>>>>>
>>>>> In order to find out more information about those pages that pin
>>>>> offlined memcgs, the page_owner feature is extended to dump memory
>>>>> cgroup information especially whether the cgroup is offlined or not.
>>>> It is not really clear to me how this is supposed to be used. Are you
>>>> really dumping all the pages in the system to find out offline memcgs?
>>>> That looks rather clumsy to me. I am not against adding memcg
>>>> information to the page owner output. That can be useful in other
>>>> contexts.
>>> We've sometimes done exactly that in production, but with drgn
>>> scripts. It's not very common, so it doesn't need to be very efficient
>>> either. Typically, we'd encounter a host with an unusual number of
>>> dying cgroups, ssh in and poke around with drgn to figure out what
>>> kind of objects are still pinning the cgroups in question.
>>>
>>> This patch would make that process a little easier, I suppose.
>> Right. Over last few years I've spent enormous amount of time digging into
>> various aspects of this problem and in my experience the combination of drgn
>> for the inspection of the current state and bpf for following various decisions
>> on the reclaim path was the most useful combination.
>>
>> I really appreciate an effort to put useful tools to track memcg references
>> into the kernel tree, however the page_owner infra has a limited usefulness
>> as it has to be enabled on the boot. But because it doesn't add any overhead,
>> I also don't think there any reasons to not add it.
> Would it be feasible to add a debugfs interface to displa dead memcg
> information?

Originally, I added some debug code to keep track of the list of memcg 
that has been offlined but not yet freed. After some more testing, I 
figured out that the memcg's were not freed because they were pinned by 
references in the page structs. At this point, I realize the using the 
existing page owner debugging tool will be useful to track this kind of 
problem since it already have all the infrastructure to list where the 
pages were allocated as well as various field in the page structures.

Of course, it is also possible to have a debugfs interface to list those 
dead memcg information, displaying more information about the page that 
pins the memcg will be hard without using the page owner tool. Keeping 
track of the list of dead memcg's may also have some runtime overhead.

Cheers,
Longman

