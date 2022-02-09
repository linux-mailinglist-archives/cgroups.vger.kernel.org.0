Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351C74AFAB1
	for <lists+cgroups@lfdr.de>; Wed,  9 Feb 2022 19:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbiBISjS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Feb 2022 13:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239972AbiBISi6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Feb 2022 13:38:58 -0500
X-Greylist: delayed 539 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 10:38:33 PST
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15877C03E97C;
        Wed,  9 Feb 2022 10:38:32 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 578B63B44D6;
        Wed,  9 Feb 2022 13:29:32 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id PvkRZioEQ2qz; Wed,  9 Feb 2022 13:29:31 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 959143B44D5;
        Wed,  9 Feb 2022 13:29:31 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 959143B44D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1644431371;
        bh=+Zw/hovgsG1BmQcx6P8MQWbrVbn2r+dD1nEP9OsP7vM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=d+/EJaPNp+fG2gPBRFh9aZtT/SzlY0BX9NyB3hkOcS9zHh3V1BO8Lz/3adWucY2QW
         fmTuQ3YcN/KOYJrI8BuHL72b6g6lUEW6w4xwgAMoqSiW7w7szEM9zsL/eHioPgbpXt
         BhOBvhBW78a6BZjb9dC5qSmzAh+B/y3sbfqKHplgFhF/QqJkHvfRrYlFNTh8PtgLE5
         YuimU6VD1LdRv7w1yOFSszTZpzhDbxLS6XX6bIZpG6sh4sOKBDn+HUVj5k8p6VVtC1
         gkcbUtZ/uVhNNHX3U8U1+Wcy3GCtGTDanpe09W6+vdOFPKH58JmcUWSnShPQC5H0Ee
         EHG/4T/xZ8KSg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XNJjAuNwWaY3; Wed,  9 Feb 2022 13:29:31 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 7E0593B4782;
        Wed,  9 Feb 2022 13:29:31 -0500 (EST)
Date:   Wed, 9 Feb 2022 13:29:31 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Waiman Long <longman@redhat.com>
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
        intel-gfx@lists.freedesktop.org
Message-ID: <919214156.50301.1644431371345.JavaMail.zimbra@efficios.com>
In-Reply-To: <24fe6a08-5931-8e8d-8d77-459388c4654e@redhat.com>
References: <20220208184208.79303-1-namhyung@kernel.org> <20220209090908.GK23216@worktop.programming.kicks-ass.net> <24fe6a08-5931-8e8d-8d77-459388c4654e@redhat.com>
Subject: Re: [RFC 00/12] locking: Separate lock tracepoints from
 lockdep/lock_stat (v1)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4203)
Thread-Topic: locking: Separate lock tracepoints from lockdep/lock_stat (v1)
Thread-Index: mgD4nhH5tY/jYF4873tct6XNo0H1KQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

----- On Feb 9, 2022, at 1:19 PM, Waiman Long longman@redhat.com wrote:

> On 2/9/22 04:09, Peter Zijlstra wrote:
>> On Tue, Feb 08, 2022 at 10:41:56AM -0800, Namhyung Kim wrote:
>>
>>> Eventually I'm mostly interested in the contended locks only and I
>>> want to reduce the overhead in the fast path.  By moving that, it'd be
>>> easy to track contended locks with timing by using two tracepoints.
>> So why not put in two new tracepoints and call it a day?
>>
>> Why muck about with all that lockdep stuff just to preserve the name
>> (and in the process continue to blow up data structures etc..). This
>> leaves distros in a bind, will they enable this config and provide
>> tracepoints while bloating the data structures and destroying things
>> like lockref (which relies on sizeof(spinlock_t)), or not provide this
>> at all.
>>
>> Yes, the name is convenient, but it's just not worth it IMO. It makes
>> the whole proposition too much of a trade-off.
>>
>> Would it not be possible to reconstruct enough useful information from
>> the lock callsite?
>>
> I second that as I don't want to see the size of a spinlock exceeds 4
> bytes in a production system.
> 
> Instead of storing additional information (e.g. lock name) directly into
> the lock itself. Maybe we can store it elsewhere and use the lock
> address as the key to locate it in a hash table. We can certainly extend
> the various lock init functions to do that. It will be trickier for
> statically initialized locks, but we can probably find a way to do that too.

If we go down that route, it would be nice if we can support a few different
use-cases for various tracers out there.

One use-case (a) requires the ability to query the lock name based on its address as key.
For this a hash table is a good fit. This would allow tracers like ftrace to
output lock names in its human-readable output which is formatted within the kernel.

Another use-case (b) is to be able to "dump" the lock { name, address } tuples
into the trace stream (we call this statedump events in lttng), and do the
translation from address to name at post-processing. This simply requires
that this information is available for iteration for both the core kernel
and module locks, so the tracer can dump this information on trace start
and module load.

Use-case (b) is very similar to what is done for the kernel tracepoints. Based
on this, implementing the init code that iterates on those sections and populates
a hash table for use-case (a) should be easy enough.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
