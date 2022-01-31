Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCA64A4CEA
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 18:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380925AbiAaRPp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 12:15:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42977 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245379AbiAaRPa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 12:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643649330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=517osVusanMuP0Y4/rkshkWytofYaoASsE2dV7IDjz4=;
        b=KTLmoCy4CbrZMih24Onu5bnXHU24DcKiFjIZGgTq4VXJKP57WcsTJmjyG9gEUoNnqyU0/i
        1gjPF3piW/aBQO8yCHhxOi6nZlU5f2hH3C9iwukrs/XHcX3yv5slXeBe5ijJxgoTq+fCV3
        +0reayxb/zTJYVhXywDu7Sq88Ud/ZvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-ccm5_wRKMk-Plwz2607tUA-1; Mon, 31 Jan 2022 12:15:24 -0500
X-MC-Unique: ccm5_wRKMk-Plwz2607tUA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A21701006AA3;
        Mon, 31 Jan 2022 17:15:21 +0000 (UTC)
Received: from [10.22.16.244] (unknown [10.22.16.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 483A77744B;
        Mon, 31 Jan 2022 17:15:20 +0000 (UTC)
Message-ID: <c950a93d-bb70-9a97-dabe-a1d58d755dad@redhat.com>
Date:   Mon, 31 Jan 2022 12:15:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/3] mm, memcg: Don't put offlined memcg into local stock
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
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
In-Reply-To: <95ba1931-e9c9-45c3-b080-d28f2ad368a7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/31/22 12:09, Waiman Long wrote:
> On 1/31/22 12:01, Roman Gushchin wrote:
>> On Sun, Jan 30, 2022 at 10:55:56PM -0500, Waiman Long wrote:
>>> On 10/1/21 19:51, Roman Gushchin wrote:
>>>> On Fri, Oct 01, 2021 at 03:09:36PM -0400, Waiman Long wrote:
>>>>> When freeing a page associated with an offlined memcg, refill_stock()
>>>>> will put it into local stock delaying its demise until another memcg
>>>>> comes in to take its place in the stock. To avoid that, we now check
>>>>> for offlined memcg and go directly in this case to the slowpath for
>>>>> the uncharge via the repurposed cancel_charge() function.
>>>> Hi Waiman!
>>>>
>>>> I'm afraid it can make a cleanup of a dying cgroup slower: for every
>>>> released page we'll potentially traverse the whole cgroup tree and
>>>> decrease atomic page counters.
>>>>
>>>> I'm not sure I understand the benefits we get from this change which
>>>> do justify the slowdown on the cleanup path.
>>>>
>>>> Thanks!
>>> I was notified of a lockdep splat that this patch may help to prevent.
>> Would you mind to test this patch:
>> https://www.spinics.net/lists/cgroups/msg31244.html ?
>>
>> It should address this dependency.
>
> Thanks for the pointer. I believe that your patch should be able to 
> address this circular locking dependency.
>
> Feel free to add my
>
> Reviewed-by: Waiman Long <longman@redhat.com>

BTW, have you posted it to lkml? If not, would you mind doing so?

Thanks,
Longman

