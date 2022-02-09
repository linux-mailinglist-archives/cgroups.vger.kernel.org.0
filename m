Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0F64AFD6D
	for <lists+cgroups@lfdr.de>; Wed,  9 Feb 2022 20:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbiBIT3E (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Feb 2022 14:29:04 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238091AbiBIT23 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Feb 2022 14:28:29 -0500
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB0CC03FED5;
        Wed,  9 Feb 2022 11:28:12 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9169C3B494A;
        Wed,  9 Feb 2022 14:28:11 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Bq5hzq76zMBx; Wed,  9 Feb 2022 14:28:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E99E43B4AC7;
        Wed,  9 Feb 2022 14:28:10 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E99E43B4AC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1644434891;
        bh=XjlwNl1On6TmPijh5BHJldK1Cy6f5rlPU65IQRBXecc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=lcJ6LjDxmssvDwIKOUoMlicr5d+aywJSmXlRJTfbmH4xgmPoedFrQV6r3q9tKD4a/
         1dpN6ymkorGYD/RLPPgIwIdyLfChfI76yVxI9JFrZhlPb9f0m8Oc9zLtHilxIKXZBQ
         jwKiwRDxiDvRaUtKcxU1/za8f4GK7gbP62qkVEdK0YvR7hWR+wQ+zLFLMFuwjteyOH
         cMGzzJ09LJP7kAVUHeFlpfr4ABMeEU0uDrDGCpZfG8rK+Cczk81jLml32FeeqyTNrq
         bab+3bK6c37tOu2GAzhkpLNpJPKTcXxyJtwFznXm3SstTE8AhxT/olKl2Jd8w1Sndl
         yJW42XHRsAMyQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qTEEX-tAWWFU; Wed,  9 Feb 2022 14:28:10 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id D2A0A3B4B38;
        Wed,  9 Feb 2022 14:28:10 -0500 (EST)
Date:   Wed, 9 Feb 2022 14:28:10 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        Radoslaw Burny <rburny@google.com>, Tejun Heo <tj@kernel.org>,
        rcu <rcu@vger.kernel.org>, cgroups <cgroups@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        paulmck <paulmck@kernel.org>
Message-ID: <718973621.50447.1644434890744.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAM9d7ci=N2NVj57k=W0ebqBzfW+ThBqYSrx-CZbgwGcbOSrEGA@mail.gmail.com>
References: <20220208184208.79303-1-namhyung@kernel.org> <20220209090908.GK23216@worktop.programming.kicks-ass.net> <24fe6a08-5931-8e8d-8d77-459388c4654e@redhat.com> <919214156.50301.1644431371345.JavaMail.zimbra@efficios.com> <69e5f778-8715-4acf-c027-58b6ec4a9e77@redhat.com> <CAM9d7ci=N2NVj57k=W0ebqBzfW+ThBqYSrx-CZbgwGcbOSrEGA@mail.gmail.com>
Subject: Re: [RFC 00/12] locking: Separate lock tracepoints from
 lockdep/lock_stat (v1)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4203)
Thread-Topic: locking: Separate lock tracepoints from lockdep/lock_stat (v1)
Thread-Index: XmneyW/Z8kaQOCvcLgzEg6AAvUOeRA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

----- On Feb 9, 2022, at 2:22 PM, Namhyung Kim namhyung@kernel.org wrote:

> Hello,
> 
> On Wed, Feb 9, 2022 at 11:02 AM Waiman Long <longman@redhat.com> wrote:
>>
>> On 2/9/22 13:29, Mathieu Desnoyers wrote:
>> > ----- On Feb 9, 2022, at 1:19 PM, Waiman Long longman@redhat.com wrote:
>> >
>> >> On 2/9/22 04:09, Peter Zijlstra wrote:
>> >>> On Tue, Feb 08, 2022 at 10:41:56AM -0800, Namhyung Kim wrote:
>> >>>
>> >>>> Eventually I'm mostly interested in the contended locks only and I
>> >>>> want to reduce the overhead in the fast path.  By moving that, it'd be
>> >>>> easy to track contended locks with timing by using two tracepoints.
>> >>> So why not put in two new tracepoints and call it a day?
>> >>>
>> >>> Why muck about with all that lockdep stuff just to preserve the name
>> >>> (and in the process continue to blow up data structures etc..). This
>> >>> leaves distros in a bind, will they enable this config and provide
>> >>> tracepoints while bloating the data structures and destroying things
>> >>> like lockref (which relies on sizeof(spinlock_t)), or not provide this
>> >>> at all.
>> >>>
>> >>> Yes, the name is convenient, but it's just not worth it IMO. It makes
>> >>> the whole proposition too much of a trade-off.
>> >>>
>> >>> Would it not be possible to reconstruct enough useful information from
>> >>> the lock callsite?
>> >>>
>> >> I second that as I don't want to see the size of a spinlock exceeds 4
>> >> bytes in a production system.
>> >>
>> >> Instead of storing additional information (e.g. lock name) directly into
>> >> the lock itself. Maybe we can store it elsewhere and use the lock
>> >> address as the key to locate it in a hash table. We can certainly extend
>> >> the various lock init functions to do that. It will be trickier for
>> >> statically initialized locks, but we can probably find a way to do that too.
>> > If we go down that route, it would be nice if we can support a few different
>> > use-cases for various tracers out there.
>> >
>> > One use-case (a) requires the ability to query the lock name based on its
>> > address as key.
>> > For this a hash table is a good fit. This would allow tracers like ftrace to
>> > output lock names in its human-readable output which is formatted within the
>> > kernel.
>> >
>> > Another use-case (b) is to be able to "dump" the lock { name, address } tuples
>> > into the trace stream (we call this statedump events in lttng), and do the
>> > translation from address to name at post-processing. This simply requires
>> > that this information is available for iteration for both the core kernel
>> > and module locks, so the tracer can dump this information on trace start
>> > and module load.
>> >
>> > Use-case (b) is very similar to what is done for the kernel tracepoints. Based
>> > on this, implementing the init code that iterates on those sections and
>> > populates
>> > a hash table for use-case (a) should be easy enough.
>>
>> Yes, that are good use cases for this type of functionality. I do need
>> to think about how to do it for statically initialized lock first.
> 
> Thank you all for the review and good suggestions.
> 
> I'm also concerning dynamic allocated locks in a data structure.
> If we keep the info in a hash table, we should delete it when the
> lock is gone.  I'm not sure we have a good place to hook it up all.

I was wondering about this use case as well. Can we make it mandatory to
declare the lock "class" (including the name) statically, even though the
lock per-se is allocated dynamically ? Then the initialization of the lock
embedded within the data structure would simply refer to the lock class
definition.

But perhaps I am missing something here.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
