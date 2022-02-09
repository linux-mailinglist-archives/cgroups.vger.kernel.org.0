Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96264AFD98
	for <lists+cgroups@lfdr.de>; Wed,  9 Feb 2022 20:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiBITiR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Feb 2022 14:38:17 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiBIThe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Feb 2022 14:37:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD330DF48F00
        for <cgroups@vger.kernel.org>; Wed,  9 Feb 2022 11:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644435453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6JUoA8FsPLcKpPxdyzR/eLwwwQM5N1zY2+jV9i97vXk=;
        b=U8YVEsQp07ilHOphnfpnwdBTibdRoEG//5+FwLXryRZQ23ciwJG9m1D6nQBIiPSNnsMKqD
        NKylZ2JAua+jVFMlG9IPehk5mg0aMqwOSlDdQ4n4ItP33exMGh2mG20JBjszn9SLe9txtA
        mOVUn/Q4nVWARl9dW7WHs12ZiTvSLKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286--3niNG3CP-uxRDxLwklcvQ-1; Wed, 09 Feb 2022 14:37:30 -0500
X-MC-Unique: -3niNG3CP-uxRDxLwklcvQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 977438144E4;
        Wed,  9 Feb 2022 19:37:27 +0000 (UTC)
Received: from [10.22.9.207] (unknown [10.22.9.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7587E196FC;
        Wed,  9 Feb 2022 19:37:24 +0000 (UTC)
Message-ID: <5ac9e82e-c2f7-09a2-87d7-47e0cc10ad86@redhat.com>
Date:   Wed, 9 Feb 2022 14:37:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC 00/12] locking: Separate lock tracepoints from
 lockdep/lock_stat (v1)
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paul.mckenney@linaro.org>,
        Radoslaw Burny <rburny@google.com>, Tejun Heo <tj@kernel.org>,
        rcu <rcu@vger.kernel.org>, cgroups <cgroups@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>
References: <20220208184208.79303-1-namhyung@kernel.org>
 <20220209090908.GK23216@worktop.programming.kicks-ass.net>
 <24fe6a08-5931-8e8d-8d77-459388c4654e@redhat.com>
 <919214156.50301.1644431371345.JavaMail.zimbra@efficios.com>
 <69e5f778-8715-4acf-c027-58b6ec4a9e77@redhat.com>
 <593915946.50384.1644434229077.JavaMail.zimbra@efficios.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <593915946.50384.1644434229077.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/9/22 14:17, Mathieu Desnoyers wrote:
> ----- On Feb 9, 2022, at 2:02 PM, Waiman Long longman@redhat.com wrote:
>
>> On 2/9/22 13:29, Mathieu Desnoyers wrote:
>>> ----- On Feb 9, 2022, at 1:19 PM, Waiman Long longman@redhat.com wrote:
>>>
>>>> On 2/9/22 04:09, Peter Zijlstra wrote:
>>>>> On Tue, Feb 08, 2022 at 10:41:56AM -0800, Namhyung Kim wrote:
>>>>>
>>>>>> Eventually I'm mostly interested in the contended locks only and I
>>>>>> want to reduce the overhead in the fast path.  By moving that, it'd be
>>>>>> easy to track contended locks with timing by using two tracepoints.
>>>>> So why not put in two new tracepoints and call it a day?
>>>>>
>>>>> Why muck about with all that lockdep stuff just to preserve the name
>>>>> (and in the process continue to blow up data structures etc..). This
>>>>> leaves distros in a bind, will they enable this config and provide
>>>>> tracepoints while bloating the data structures and destroying things
>>>>> like lockref (which relies on sizeof(spinlock_t)), or not provide this
>>>>> at all.
>>>>>
>>>>> Yes, the name is convenient, but it's just not worth it IMO. It makes
>>>>> the whole proposition too much of a trade-off.
>>>>>
>>>>> Would it not be possible to reconstruct enough useful information from
>>>>> the lock callsite?
>>>>>
>>>> I second that as I don't want to see the size of a spinlock exceeds 4
>>>> bytes in a production system.
>>>>
>>>> Instead of storing additional information (e.g. lock name) directly into
>>>> the lock itself. Maybe we can store it elsewhere and use the lock
>>>> address as the key to locate it in a hash table. We can certainly extend
>>>> the various lock init functions to do that. It will be trickier for
>>>> statically initialized locks, but we can probably find a way to do that too.
>>> If we go down that route, it would be nice if we can support a few different
>>> use-cases for various tracers out there.
>>>
>>> One use-case (a) requires the ability to query the lock name based on its
>>> address as key.
>>> For this a hash table is a good fit. This would allow tracers like ftrace to
>>> output lock names in its human-readable output which is formatted within the
>>> kernel.
>>>
>>> Another use-case (b) is to be able to "dump" the lock { name, address } tuples
>>> into the trace stream (we call this statedump events in lttng), and do the
>>> translation from address to name at post-processing. This simply requires
>>> that this information is available for iteration for both the core kernel
>>> and module locks, so the tracer can dump this information on trace start
>>> and module load.
>>>
>>> Use-case (b) is very similar to what is done for the kernel tracepoints. Based
>>> on this, implementing the init code that iterates on those sections and
>>> populates
>>> a hash table for use-case (a) should be easy enough.
>> Yes, that are good use cases for this type of functionality. I do need
>> to think about how to do it for statically initialized lock first.
> Tracepoints already solved that problem.
>
> Look at the macro DEFINE_TRACE_FN() in include/linux/tracepoint.h. You will notice that
> it statically defines a struct tracepoint in a separate section and a tracepoint_ptr_t
> in a __tracepoints_ptrs section.
>
> Then the other parts of the picture are in kernel/tracepoint.c:
>
> extern tracepoint_ptr_t __start___tracepoints_ptrs[];
> extern tracepoint_ptr_t __stop___tracepoints_ptrs[];
>
> and kernel/module.c:find_module_sections()
>
> #ifdef CONFIG_TRACEPOINTS
>          mod->tracepoints_ptrs = section_objs(info, "__tracepoints_ptrs",
>                                               sizeof(*mod->tracepoints_ptrs),
>                                               &mod->num_tracepoints);
> #endif
>
> and the iteration code over kernel and modules in kernel/tracepoint.c.
>
> All you need in addition is in include/asm-generic/vmlinux.lds.h, we add
> to the DATA_DATA define an entry such as:
>
>          STRUCT_ALIGN();                                                 \
>          *(__tracepoints)                                                \
>
> and in RO_DATA:
>
>                  . = ALIGN(8);                                           \
>                  __start___tracepoints_ptrs = .;                         \
>                  KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
>                  __stop___tracepoints_ptrs = .;
>
> AFAIU, if you do something similar for a structure that contains your relevant
> lock information, it should be straightforward to handle statically initialized
> locks.
>
> Thanks,
>
> Mathieu

Thanks for the suggestion.

Cheers,
Longman

