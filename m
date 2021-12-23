Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9437C47E61E
	for <lists+cgroups@lfdr.de>; Thu, 23 Dec 2021 17:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhLWQBo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Dec 2021 11:01:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29918 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229552AbhLWQBo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Dec 2021 11:01:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640275303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+x9d3eMLDnOzojapyWMBgtJ2Do86y7jIA1pTdOWS/vg=;
        b=gNA589Y55py55zeCMG2Dv8LaDMuTdCcwZhAQ7E2TFA34tePQn/zRwC8IDitf+CWuDg8OyP
        QTeuja6evGmxs+peJjRZBlzMffgHaoSXIAtqnjbIczBN0yDNUk0AvQXiME5tgtlFOZa1Fm
        ohJJx1Wz8KRM5S3Th+eKktWeUIAtc/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-88-M2QYBhyQOoy4_zi7ZmOFvg-1; Thu, 23 Dec 2021 11:01:40 -0500
X-MC-Unique: M2QYBhyQOoy4_zi7ZmOFvg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9007161240;
        Thu, 23 Dec 2021 16:01:38 +0000 (UTC)
Received: from [10.22.17.249] (unknown [10.22.17.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A3BBADDD;
        Thu, 23 Dec 2021 16:01:37 +0000 (UTC)
Message-ID: <407858bc-a5ad-c17c-3f8b-ac65dc912990@redhat.com>
Date:   Thu, 23 Dec 2021 11:01:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [RFC PATCH 1/3] mm/memcg: Protect per-CPU counter by disabling
 preemption on PREEMPT_RT
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
References: <20211222114111.2206248-1-bigeasy@linutronix.de>
 <20211222114111.2206248-2-bigeasy@linutronix.de>
 <bdfc9791-4af2-f4fb-9ef5-dab1e2e3ff89@redhat.com>
 <YcQme8BPFl7P9T02@linutronix.de>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YcQme8BPFl7P9T02@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/23/21 02:34, Sebastian Andrzej Siewior wrote:
> On 2021-12-22 21:31:36 [-0500], Waiman Long wrote:
>> On 12/22/21 06:41, Sebastian Andrzej Siewior wrote:
>>> The per-CPU counter are modified with the non-atomic modifier. The
>>> consistency is ensure by disabling interrupts for the update.
>>> This breaks on PREEMPT_RT because some sections additionally
>>> acquire a spinlock_t lock (which becomes sleeping and must not be
>>> acquired with disabled interrupts). Another problem is that
>>> mem_cgroup_swapout() expects to be invoked with disabled interrupts
>>> because the caller has to acquire a spinlock_t which is acquired with
>>> disabled interrupts. Since spinlock_t never disables interrupts on
>>> PREEMPT_RT the interrupts are never disabled at this point.
>>>
>>> The code is never called from in_irq() context on PREEMPT_RT therefore
>> How do you guarantee that these percpu update functions won't be called in
>> in_irq() context for PREEMPT_RT? Do you think we should add a
>> WARN_ON_ONCE(in_irq()) just to be sure?
> There are no invocations to the memory allocator (neither malloc() nor
> free()) on RT and the memory allocator itself (SLUB and the
> page-allocator so both) has sleeping locks. That means invocations
> in_atomic() are bad. All interrupt handler are force-threaded. Those
> which are not (like timer, per-CPU interrupts or those which explicitly
> asked not to be force threaded) are limited in their doing as they can't
> invoke anything that has a sleeping lock. Lockdep or
> CONFIG_DEBUG_ATOMIC_SLEEP will yell here.
> The other counter are protected the same way, see
>    c68ed7945701a ("mm/vmstat: protect per cpu variables with preempt disable on RT")

Thanks for the explanation as I am less familiar with other PREEMPT_RT 
specific changes.

Cheers,
Longman

