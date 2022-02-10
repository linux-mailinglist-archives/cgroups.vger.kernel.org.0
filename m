Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521884B0993
	for <lists+cgroups@lfdr.de>; Thu, 10 Feb 2022 10:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238697AbiBJJdn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Feb 2022 04:33:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiBJJdn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Feb 2022 04:33:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5B2C64;
        Thu, 10 Feb 2022 01:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I+KdT8Ft4gEDreuv2bs/lK/WKosbMae+Gs2ZDIi52r8=; b=v5x6DP/o1WOVzInYWj+OWguYjf
        eLQpr7RM3CnxAAk3jaO2rcVftZ1e+5phpKIodTkLSxDXOwSvcTLi4qk5/ySJRc/hI1ychJkAen1z0
        Zp9OoP3OirWBCpXqLYBpe9/Sj5681YQ0jr1jxFHLaRwcMpikdJabxjYU5JWHBXZkz9o4nzeVsrg6P
        3kcm8y3Q7W1+pNSL5ou9mrCzcTeYQh59B1RYKiy79tD66DAHw03/JjWeZzPf9H4ShJonEVXh+vnnk
        BnDNFiE1x/ux56JFcpXclclJQt/Xhc668p+s+htSe08/XCrlKbLPn7mqxLMMMLhiQWq2+o3CtuCxk
        YxstcdEw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nI5p4-009J34-3j; Thu, 10 Feb 2022 09:33:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CBA9A3002DB;
        Thu, 10 Feb 2022 10:33:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B6A72201D84A1; Thu, 10 Feb 2022 10:33:03 +0100 (CET)
Date:   Thu, 10 Feb 2022 10:33:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
Subject: Re: [RFC 00/12] locking: Separate lock tracepoints from
 lockdep/lock_stat (v1)
Message-ID: <YgTbz55YtOQbnA3m@hirez.programming.kicks-ass.net>
References: <20220208184208.79303-1-namhyung@kernel.org>
 <20220209090908.GK23216@worktop.programming.kicks-ass.net>
 <24fe6a08-5931-8e8d-8d77-459388c4654e@redhat.com>
 <919214156.50301.1644431371345.JavaMail.zimbra@efficios.com>
 <69e5f778-8715-4acf-c027-58b6ec4a9e77@redhat.com>
 <CAM9d7ci=N2NVj57k=W0ebqBzfW+ThBqYSrx-CZbgwGcbOSrEGA@mail.gmail.com>
 <718973621.50447.1644434890744.JavaMail.zimbra@efficios.com>
 <CAM9d7cj=tj6pA48q_wkQOGn-2vUc9FRj63bMBOm5R7OukmMbTQ@mail.gmail.com>
 <f8b7760f-16a2-6ada-de88-9e21a7e8fef9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8b7760f-16a2-6ada-de88-9e21a7e8fef9@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 09, 2022 at 03:17:38PM -0500, Waiman Long wrote:
> 
> On 2/9/22 14:45, Namhyung Kim wrote:
> > On Wed, Feb 9, 2022 at 11:28 AM Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> > > ----- On Feb 9, 2022, at 2:22 PM, Namhyung Kim namhyung@kernel.org wrote:
> > > > I'm also concerning dynamic allocated locks in a data structure.
> > > > If we keep the info in a hash table, we should delete it when the
> > > > lock is gone.  I'm not sure we have a good place to hook it up all.
> > > I was wondering about this use case as well. Can we make it mandatory to
> > > declare the lock "class" (including the name) statically, even though the
> > > lock per-se is allocated dynamically ? Then the initialization of the lock
> > > embedded within the data structure would simply refer to the lock class
> > > definition.
> > Isn't it still the same if we have static lock classes that the entry needs
> > to be deleted from the hash table when it frees the data structure?
> > I'm more concerned about free than alloc as there seems to be no
> > API to track that in a place.
> 
> We may have to invent some new APIs to do that. For example,
> spin_lock_exit() can be the counterpart of spin_lock_init() and so on. Of
> course, existing kernel code have to be modified to designate the point
> after which a lock is no longer being used or is freed.

The canonical name is _destroy(). We even have mutex_destroy() except
it's usage isn't mandatory.

The easy way out is doing as lockdep does and hook into the memory
allocators and check every free'd hunk of memory for a lock. It does
hoever mean your data structure of choice needs to be able to answer: do
I have an entry in @range. Which mostly disqualifies a hash-table.

Still, I really don't think you need any of this, it's just bloat. A
very limited stack unwind for one of the two tracepoints should allow
you to find the offending lock just fine.
