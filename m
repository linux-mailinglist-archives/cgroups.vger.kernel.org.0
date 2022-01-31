Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1244A4D1F
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 18:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381016AbiAaRZl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 12:25:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29419 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380940AbiAaRZN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 12:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643649913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PaMPeaT7bqTywU/6EXOdBYInz5ZUKSgh51n5zqNu8us=;
        b=SdsQt7oSykSd+YU9Ahe1hqcwFqg61gHRjbsMh+/IXP8gHOrlrI9VQqc/CqW8CrLs0TXe9e
        /fpSeo155cS3r5tYPCbg2jT0dpf9DVpTU8FItiytL3dNNJ+R1WcJxHesGr2uTLIVqOvblL
        K9KLkSINzSBqcaV8d7J54rAd0DImFuc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-WevAcsvfPmSx_CbH-QId1w-1; Mon, 31 Jan 2022 12:25:09 -0500
X-MC-Unique: WevAcsvfPmSx_CbH-QId1w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3450793921;
        Mon, 31 Jan 2022 17:25:07 +0000 (UTC)
Received: from [10.22.16.244] (unknown [10.22.16.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD20F6E202;
        Mon, 31 Jan 2022 17:25:05 +0000 (UTC)
Message-ID: <9abc9cb8-8734-90b0-c495-8df89c7bb579@redhat.com>
Date:   Mon, 31 Jan 2022 12:25:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/3] mm, memcg: Don't put offlined memcg into local stock
Content-Language: en-US
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
References: <20211001190938.14050-1-longman@redhat.com>
 <20211001190938.14050-2-longman@redhat.com>
 <YVefHLo1+6lgw3aB@carbon.dhcp.thefacebook.com>
 <f7026256-4086-6632-569e-5b13594cb3fc@redhat.com>
 <YfgV2iiaVlR0hozD@carbon.dhcp.thefacebook.com>
 <95ba1931-e9c9-45c3-b080-d28f2ad368a7@redhat.com>
 <c950a93d-bb70-9a97-dabe-a1d58d755dad@redhat.com>
 <YfgaIcSJhqEOnh65@carbon.dhcp.thefacebook.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YfgaIcSJhqEOnh65@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/31/22 12:19, Roman Gushchin wrote:
> On Mon, Jan 31, 2022 at 12:15:19PM -0500, Waiman Long wrote:
>> On 1/31/22 12:09, Waiman Long wrote:
>>> On 1/31/22 12:01, Roman Gushchin wrote:
>>>> On Sun, Jan 30, 2022 at 10:55:56PM -0500, Waiman Long wrote:
>>>>> On 10/1/21 19:51, Roman Gushchin wrote:
>>>>>> On Fri, Oct 01, 2021 at 03:09:36PM -0400, Waiman Long wrote:
>>>>>>> When freeing a page associated with an offlined memcg, refill_stock()
>>>>>>> will put it into local stock delaying its demise until another memcg
>>>>>>> comes in to take its place in the stock. To avoid that, we now check
>>>>>>> for offlined memcg and go directly in this case to the slowpath for
>>>>>>> the uncharge via the repurposed cancel_charge() function.
>>>>>> Hi Waiman!
>>>>>>
>>>>>> I'm afraid it can make a cleanup of a dying cgroup slower: for every
>>>>>> released page we'll potentially traverse the whole cgroup tree and
>>>>>> decrease atomic page counters.
>>>>>>
>>>>>> I'm not sure I understand the benefits we get from this change which
>>>>>> do justify the slowdown on the cleanup path.
>>>>>>
>>>>>> Thanks!
>>>>> I was notified of a lockdep splat that this patch may help to prevent.
>>>> Would you mind to test this patch:
>>>> https://www.spinics.net/lists/cgroups/msg31244.html  ?
>>>>
>>>> It should address this dependency.
>>> Thanks for the pointer. I believe that your patch should be able to
>>> address this circular locking dependency.
>>>
>>> Feel free to add my
>>>
>>> Reviewed-by: Waiman Long <longman@redhat.com>
>> BTW, have you posted it to lkml? If not, would you mind doing so?
> Not yet.
>
> I was waiting for Alexander to confirm that it resolves the originally reported
> issue. I just pinged him, will wait for tomorrow and post the patch in any case.
>
> Thanks!

I see. This is not a problem that is easily reproducible. You need to 
hit the right timing for the lockdep splat to appear.

Regards,
Longman

