Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CFB4705DB
	for <lists+cgroups@lfdr.de>; Fri, 10 Dec 2021 17:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243697AbhLJQlD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Dec 2021 11:41:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33716 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243659AbhLJQlC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Dec 2021 11:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639154247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3RJ4kdqFy0a33uyqK6Ow9FidSYu04VaasEa+p2fofDM=;
        b=NnmA5eo04F2eqVXbzN3umt6xxQhM0U9XbIuI0NqtoXlz1HAIOn1MUl30o5wke1Qk4K+8TO
        gVP55p5LrfyqkmpD7KUWJXKA1NMP46+elqfgNbe+zbik3Pb5qUxasi9hGOAouJjmr+CP0O
        fCiS6VaRuLORmrxY2pmYsTB1D8rKEkU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-_jeNhYT9PZa8f4InEYHcaw-1; Fri, 10 Dec 2021 11:37:23 -0500
X-MC-Unique: _jeNhYT9PZa8f4InEYHcaw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64D31193F561;
        Fri, 10 Dec 2021 16:37:22 +0000 (UTC)
Received: from [10.22.33.49] (unknown [10.22.33.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18F2C22E09;
        Fri, 10 Dec 2021 16:37:21 +0000 (UTC)
Message-ID: <14de3f92-c1f8-e51e-0cd2-5ec9fc86d1c0@redhat.com>
Date:   Fri, 10 Dec 2021 11:37:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH-next v2] mm/memcg: Properly handle memcg_stock access for
 PREEMPT_RT
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
References: <20211210025228.158196-1-longman@redhat.com>
 <YbNPrGEjtKjzEjQa@linutronix.de>
 <80ee87bb-f36c-4a16-9095-43ea84818375@redhat.com>
 <YbOBmYrInQVI+VOR@linutronix.de>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YbOBmYrInQVI+VOR@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 12/10/21 11:34, Sebastian Andrzej Siewior wrote:
> On 2021-12-10 11:29:31 [-0500], Waiman Long wrote:
>> On 12/10/21 08:01, Sebastian Andrzej Siewior wrote:
>>> On 2021-12-09 21:52:28 [-0500], Waiman Long wrote:
>>> …
>>>> --- a/mm/memcontrol.c
>>>> +++ b/mm/memcontrol.c
>>> …
>>>> @@ -2210,7 +2211,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>>>>    	struct memcg_stock_pcp *stock;
>>>>    	unsigned long flags;
>>>> -	local_irq_save(flags);
>>>> +	local_lock_irqsave(&memcg_stock.lock, flags);
>>> Why is this one using the lock? It isn't accessing irq_obj, right?
>> Well, the lock isn't just for irq_obj. It protects the whole memcg_stock
>> structure which include irq_obj. Sometimes, data in irq_obj (or task_obj)
>> will get transfer to nr_pages and vice versa. So it is easier to use one
>> single lock for the whole thing.
> This needs way better documentation what protects what any why.
> I don't like the quick slapping for RT only usage without any kind of
> explanation. Once you think you know it is irq_obj only you end up here
> where you have the lock again for no obvious reason.

Sure, I will update the patch description and add comments to document 
that. Let's see what other feedback I have before I make the update.

Cheers,
Longman

