Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671F9535456
	for <lists+cgroups@lfdr.de>; Thu, 26 May 2022 22:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiEZURe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 May 2022 16:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiEZURd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 May 2022 16:17:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDF4FF583
        for <cgroups@vger.kernel.org>; Thu, 26 May 2022 13:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653596251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KcZz6yVLgZ62yrFoGOM5DElgQzD6OwyWHQ72tERIC7w=;
        b=N7dvC4O/ULBzOmQbXN11u4LrUcSGzunlR9vocUMbkG/7APyoPg/8q0fJ8H+l9yR+vyaKj8
        g+eY8NKsezseF/4949q7taNi7k7bFBYSlgw+ZQ42NU47KlWXNMphOg4pnSEUtWnckIni81
        Gvis44TkSUZqxVey52RWkwqe0WB3nJ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-dYebSbIfM4yLfnBJjQQ3eg-1; Thu, 26 May 2022 16:17:28 -0400
X-MC-Unique: dYebSbIfM4yLfnBJjQQ3eg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B89FF185A7A4;
        Thu, 26 May 2022 20:17:27 +0000 (UTC)
Received: from [10.22.8.143] (unknown [10.22.8.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 389B12026D64;
        Thu, 26 May 2022 20:17:27 +0000 (UTC)
Message-ID: <9fe57cf7-9d21-3f91-ef27-e046b426c219@redhat.com>
Date:   Thu, 26 May 2022 16:17:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 03/11] mm: memcontrol: make lruvec lock safe when LRU
 pages are reparented
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-4-songmuchun@bytedance.com>
 <Yo0xmKOkBkhRy+bq@cmpxchg.org> <Yo38mlkMBFz2h+yP@FVFYT0MHHV2J.googleapis.com>
 <Yo4hVw7B+bUlMzLX@cmpxchg.org> <Yo4pPw+IHPBZvZUv@FVFYT0MHHV2J.googleapis.com>
 <Yo5B1tLcYPUoaACS@cmpxchg.org> <Yo5NdncOsqL0xP8Q@FVFYT0MHHV2J.googleapis.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Yo5NdncOsqL0xP8Q@FVFYT0MHHV2J.googleapis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/25/22 11:38, Muchun Song wrote:
> On Wed, May 25, 2022 at 10:48:54AM -0400, Johannes Weiner wrote:
>> On Wed, May 25, 2022 at 09:03:59PM +0800, Muchun Song wrote:
>>> On Wed, May 25, 2022 at 08:30:15AM -0400, Johannes Weiner wrote:
>>>> On Wed, May 25, 2022 at 05:53:30PM +0800, Muchun Song wrote:
>>>>> On Tue, May 24, 2022 at 03:27:20PM -0400, Johannes Weiner wrote:
>>>>>> On Tue, May 24, 2022 at 02:05:43PM +0800, Muchun Song wrote:
>>>>>>> @@ -1230,10 +1213,23 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
>>>>>>>    */
>>>>>>>   struct lruvec *folio_lruvec_lock(struct folio *folio)
>>>>>>>   {
>>>>>>> -	struct lruvec *lruvec = folio_lruvec(folio);
>>>>>>> +	struct lruvec *lruvec;
>>>>>>>   
>>>>>>> +	rcu_read_lock();
>>>>>>> +retry:
>>>>>>> +	lruvec = folio_lruvec(folio);
>>>>>>>   	spin_lock(&lruvec->lru_lock);
>>>>>>> -	lruvec_memcg_debug(lruvec, folio);
>>>>>>> +
>>>>>>> +	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
>>>>>>> +		spin_unlock(&lruvec->lru_lock);
>>>>>>> +		goto retry;
>>>>>>> +	}
>>>>>>> +
>>>>>>> +	/*
>>>>>>> +	 * Preemption is disabled in the internal of spin_lock, which can serve
>>>>>>> +	 * as RCU read-side critical sections.
>>>>>>> +	 */
>>>>>>> +	rcu_read_unlock();
>>>>>> The code looks right to me, but I don't understand the comment: why do
>>>>>> we care that the rcu read-side continues? With the lru_lock held,
>>>>>> reparenting is on hold and the lruvec cannot be rcu-freed anyway, no?
>>>>>>
>>>>> Right. We could hold rcu read lock until end of reparting.  So you mean
>>>>> we do rcu_read_unlock in folio_lruvec_lock()?
>>>> The comment seems to suggest that disabling preemption is what keeps
>>>> the lruvec alive. But it's the lru_lock that keeps it alive. The
>>>> cgroup destruction path tries to take the lru_lock long before it even
>>>> gets to synchronize_rcu(). Once you hold the lru_lock, having an
>>>> implied read-side critical section as well doesn't seem to matter.
>>>>
>>> Well, I thought that spinlocks have implicit read-side critical sections
>>> because it disables preemption (I learned from the comments above
>>> synchronize_rcu() that says interrupts, preemption, or softirqs have been
>>> disabled also serve as RCU read-side critical sections).  So I have a
>>> question: is it still true in a PREEMPT_RT kernel (I am not familiar with
>>> this)?
>> Yes, but you're missing my point.
>>
>>>> Should the comment be deleted?
>>> I think we could remove the comments. If the above question is false, seems
>>> like we should continue holding rcu read lock.
>> It's true.
>>
> Thanks for your answer.
>
>> But assume it's false for a second. Why would you need to continue
>> holding it? What would it protect? The lruvec would be pinned by the
>> spinlock even if it DIDN'T imply an RCU lock, right?
>>
>> So I don't understand the point of the comment. If the implied RCU
>> lock is protecting something not covered by the bare spinlock itself,
>> it should be added to the comment. Otherwise, the comment should go.
>>
> Got it. Thanks for your nice explanation. I'll remove
> the comment here.

Note that there is a similar comment in patch 6 which may have to be 
removed as well.

Cheers,
Longman

