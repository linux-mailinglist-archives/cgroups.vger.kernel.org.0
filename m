Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6FB4AF9D4
	for <lists+cgroups@lfdr.de>; Wed,  9 Feb 2022 19:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239306AbiBISUO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Feb 2022 13:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239410AbiBIST4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Feb 2022 13:19:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2ABDBC03C1A6
        for <cgroups@vger.kernel.org>; Wed,  9 Feb 2022 10:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644430759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qax2p4QYoRES22yBVTV0pqT1gnZb7y7VCXsID9Egc7E=;
        b=HxJEaVkm1+6kPS7grqpovtsOHCaQxxc+wGPrASmnMP6uZEM2YJTV58f0iqRwVqeqfqi987
        GU9vsUD5YB6oCFZEqjYG5UBgoc9pffdQVg45qSCwR7M1Do3Ei2KpoLwx8SJ4Cxethw99JE
        JnS10x/+R76ulgyHd0ZRozRAyOaXpEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-zHSc6UrVO8a503hE2f2VtA-1; Wed, 09 Feb 2022 13:19:15 -0500
X-MC-Unique: zHSc6UrVO8a503hE2f2VtA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68A4881433D;
        Wed,  9 Feb 2022 18:19:11 +0000 (UTC)
Received: from [10.22.9.207] (unknown [10.22.9.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 887577DE57;
        Wed,  9 Feb 2022 18:19:08 +0000 (UTC)
Message-ID: <24fe6a08-5931-8e8d-8d77-459388c4654e@redhat.com>
Date:   Wed, 9 Feb 2022 13:19:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC 00/12] locking: Separate lock tracepoints from
 lockdep/lock_stat (v1)
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paul.mckenney@linaro.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>, Tejun Heo <tj@kernel.org>,
        rcu@vger.kernel.org, cgroups@vger.kernel.org,
        linux-btrfs@vger.kernel.org, intel-gfx@lists.freedesktop.org
References: <20220208184208.79303-1-namhyung@kernel.org>
 <20220209090908.GK23216@worktop.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220209090908.GK23216@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/9/22 04:09, Peter Zijlstra wrote:
> On Tue, Feb 08, 2022 at 10:41:56AM -0800, Namhyung Kim wrote:
>
>> Eventually I'm mostly interested in the contended locks only and I
>> want to reduce the overhead in the fast path.  By moving that, it'd be
>> easy to track contended locks with timing by using two tracepoints.
> So why not put in two new tracepoints and call it a day?
>
> Why muck about with all that lockdep stuff just to preserve the name
> (and in the process continue to blow up data structures etc..). This
> leaves distros in a bind, will they enable this config and provide
> tracepoints while bloating the data structures and destroying things
> like lockref (which relies on sizeof(spinlock_t)), or not provide this
> at all.
>
> Yes, the name is convenient, but it's just not worth it IMO. It makes
> the whole proposition too much of a trade-off.
>
> Would it not be possible to reconstruct enough useful information from
> the lock callsite?
>
I second that as I don't want to see the size of a spinlock exceeds 4 
bytes in a production system.

Instead of storing additional information (e.g. lock name) directly into 
the lock itself. Maybe we can store it elsewhere and use the lock 
address as the key to locate it in a hash table. We can certainly extend 
the various lock init functions to do that. It will be trickier for 
statically initialized locks, but we can probably find a way to do that too.

Cheers,
Longman


