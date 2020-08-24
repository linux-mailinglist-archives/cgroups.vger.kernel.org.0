Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609202501A5
	for <lists+cgroups@lfdr.de>; Mon, 24 Aug 2020 18:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgHXQDF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Aug 2020 12:03:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24385 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726666AbgHXQC6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Aug 2020 12:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598284975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GOOvGMjNbf5XtLNCKd9ysNRuyAgV0fQgbTvlhMQq8xI=;
        b=DhR4iTc47y+ZBv2Yb0yNRGx26eVpZAbahIMo1FqqP+1ecPzgzFs/MSxB5P+m+doz4kk75H
        jbrK++sBKQtgLrlvTXKrkvmm7yOLfcEmAxOtRGyetmzgCjhPWDgBAaoDTCCN+b4WDC6dqL
        Za5fT+WODCbKQumsb6sY4ZjqcfyQdrk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-FWvG5sP1NauODAXLjclCsQ-1; Mon, 24 Aug 2020 12:02:52 -0400
X-MC-Unique: FWvG5sP1NauODAXLjclCsQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2DC710ABDA5;
        Mon, 24 Aug 2020 16:02:49 +0000 (UTC)
Received: from llong.remote.csb (ovpn-112-212.rdu2.redhat.com [10.10.112.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94F411002382;
        Mon, 24 Aug 2020 16:02:48 +0000 (UTC)
Subject: Re: [PATCH 3/3] mm/memcg: Unify swap and memsw page counters
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>
References: <20200820130350.3211-1-longman@redhat.com>
 <20200820130350.3211-4-longman@redhat.com>
 <CALvZod7cNkjgd_YWzPSFm=AeC8sy5kWspX3J_Q7237Q9+N5Pxw@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <18d02675-0c2a-bfc3-6953-42dcd10396b1@redhat.com>
Date:   Mon, 24 Aug 2020 12:02:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CALvZod7cNkjgd_YWzPSFm=AeC8sy5kWspX3J_Q7237Q9+N5Pxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/20/20 11:46 AM, Shakeel Butt wrote:
> On Thu, Aug 20, 2020 at 6:04 AM Waiman Long <longman@redhat.com> wrote:
>> The swap page counter is v2 only while memsw is v1 only. As v1 and v2
>> controllers cannot be active at the same time, there is no point to keep
>> both swap and memsw page counters in mem_cgroup. The previous patch has
>> made sure that memsw page counter is updated and accessed only when in
>> v1 code paths. So it is now safe to alias the v1 memsw page counter to v2
>> swap page counter. This saves 14 long's in the size of mem_cgroup. This
>> is a saving of 112 bytes for 64-bit archs.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   include/linux/memcontrol.h | 3 +--
>>   mm/memcontrol.c            | 8 +++++---
>>   2 files changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index d0b036123c6a..d2a819d7db70 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -216,10 +216,9 @@ struct mem_cgroup {
>>
>>          /* Accounted resources */
>>          struct page_counter memory;
>> -       struct page_counter swap;
>> +       struct page_counter swap;       /* memsw (memory+swap) for v1 */
>>
>>          /* Legacy consumer-oriented counters */
>> -       struct page_counter memsw;
>>          struct page_counter kmem;
>>          struct page_counter tcpmem;
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index d219dca5239f..04c3794cdc98 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -68,6 +68,11 @@
>>
>>   #include <trace/events/vmscan.h>
>>
>> +/*
>> + * The v1 memsw page counter is aliased to the v2 swap page counter.
>> + */
>> +#define memsw  swap
>> +
> Personally I would prefer a union instead of #define.

Yes, that is also what I am thinking about in the v2.

Cheers,
Longman


