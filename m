Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B633D4AFE17
	for <lists+cgroups@lfdr.de>; Wed,  9 Feb 2022 21:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiBIURu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Feb 2022 15:17:50 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiBIURt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Feb 2022 15:17:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1DD7E0314A3
        for <cgroups@vger.kernel.org>; Wed,  9 Feb 2022 12:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644437867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KHy+FrMszZUXNvq7VkE1Sw+oLSzIRN5aM5gdNpzgAuE=;
        b=VzOJEpmAzd93oUA+joxWfCChYeeAvHgHqRFIIc2EghoML73dzEDx3j1exxCkDK2uIfAip3
        8CfYVKOqpcP8eZ5A9wZmyLeQkIfg8cEHLhUIipoyT0faLJppPHgtfnn++WlTRB+cgT3ODL
        FFKyIhpPoNDk+/4dhyhRSuz0Dib4uqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-9Cqsjq2nPzOSvqBNqWFcoA-1; Wed, 09 Feb 2022 15:17:44 -0500
X-MC-Unique: 9Cqsjq2nPzOSvqBNqWFcoA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E37D4814243;
        Wed,  9 Feb 2022 20:17:41 +0000 (UTC)
Received: from [10.22.9.207] (unknown [10.22.9.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12EB55D6D5;
        Wed,  9 Feb 2022 20:17:38 +0000 (UTC)
Message-ID: <f8b7760f-16a2-6ada-de88-9e21a7e8fef9@redhat.com>
Date:   Wed, 9 Feb 2022 15:17:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC 00/12] locking: Separate lock tracepoints from
 lockdep/lock_stat (v1)
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
References: <20220208184208.79303-1-namhyung@kernel.org>
 <20220209090908.GK23216@worktop.programming.kicks-ass.net>
 <24fe6a08-5931-8e8d-8d77-459388c4654e@redhat.com>
 <919214156.50301.1644431371345.JavaMail.zimbra@efficios.com>
 <69e5f778-8715-4acf-c027-58b6ec4a9e77@redhat.com>
 <CAM9d7ci=N2NVj57k=W0ebqBzfW+ThBqYSrx-CZbgwGcbOSrEGA@mail.gmail.com>
 <718973621.50447.1644434890744.JavaMail.zimbra@efficios.com>
 <CAM9d7cj=tj6pA48q_wkQOGn-2vUc9FRj63bMBOm5R7OukmMbTQ@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CAM9d7cj=tj6pA48q_wkQOGn-2vUc9FRj63bMBOm5R7OukmMbTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 2/9/22 14:45, Namhyung Kim wrote:
> On Wed, Feb 9, 2022 at 11:28 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>> ----- On Feb 9, 2022, at 2:22 PM, Namhyung Kim namhyung@kernel.org wrote:
>>> I'm also concerning dynamic allocated locks in a data structure.
>>> If we keep the info in a hash table, we should delete it when the
>>> lock is gone.  I'm not sure we have a good place to hook it up all.
>> I was wondering about this use case as well. Can we make it mandatory to
>> declare the lock "class" (including the name) statically, even though the
>> lock per-se is allocated dynamically ? Then the initialization of the lock
>> embedded within the data structure would simply refer to the lock class
>> definition.
> Isn't it still the same if we have static lock classes that the entry needs
> to be deleted from the hash table when it frees the data structure?
> I'm more concerned about free than alloc as there seems to be no
> API to track that in a place.

We may have to invent some new APIs to do that. For example, 
spin_lock_exit() can be the counterpart of spin_lock_init() and so on. 
Of course, existing kernel code have to be modified to designate the 
point after which a lock is no longer being used or is freed.

Cheers,
Longman

