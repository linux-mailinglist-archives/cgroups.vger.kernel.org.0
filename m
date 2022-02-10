Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1954B0303
	for <lists+cgroups@lfdr.de>; Thu, 10 Feb 2022 03:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiBJCCP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Feb 2022 21:02:15 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbiBJCAP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Feb 2022 21:00:15 -0500
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18FB2AA8C;
        Wed,  9 Feb 2022 17:37:13 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id ka4so11626412ejc.11;
        Wed, 09 Feb 2022 17:37:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hi13+0AtzbStYByZM4x4aFlINJC7bo3Kt6Lh5RP5h4I=;
        b=dS54NUwsHmTH733rbm6skuFOqNSWHxb0d+f/jhaNF5rcqklxEw9ZbWjwh9/rUMoYdY
         Fs6FF6u7mOsAM/Rkjy5+dyZBUsfH9XLdr5PhGPDQ2XdjbDtKV/kxZ1PUsnz7+qxIPuh4
         MsLR7ayLq6BV9pTh5EqLKy5278SH1iL5vfvW4AFzV2ex0Xw4wc0RmPBm8zdTC8M6jbRp
         i+5Pu/lzSj3BhIMmthm3IvfRJ5D4zKRsxfzFGGy73l6LdAHpyO3Vs0v19tb4HsEK4WoI
         6Y+56wa7uchPqi76l/s2tle42N9CGV8GkWRtn33Qk39X3cXa6ffQaR6jJAp4YtljvTBc
         2zSA==
X-Gm-Message-State: AOAM531cnxLpkYwASiI2Ouvm4Rz76Tk5Y2NC0Pf9JJGB1+Gn3Xr+RIN9
        OQUCfoPPPZg5SvaZ8baBXcWqAH94YIUjjHVoM+wRyvP2
X-Google-Smtp-Source: ABdhPJzZvnlJt99+GIG+klBaTJQcc/Z6vAhuqEVXq5NuAa23zEuQluX/L2PyRqxOmq/geXpyXWqIXcWqvbgPSRooCuM=
X-Received: by 2002:a05:6512:3186:: with SMTP id i6mr3590137lfe.47.1644453189598;
 Wed, 09 Feb 2022 16:33:09 -0800 (PST)
MIME-Version: 1.0
References: <20220208184208.79303-1-namhyung@kernel.org> <20220209090908.GK23216@worktop.programming.kicks-ass.net>
In-Reply-To: <20220209090908.GK23216@worktop.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 9 Feb 2022 16:32:58 -0800
Message-ID: <CAM9d7cgq+jxu6FJuKhZkprn7dO4DiG5pDjmYZzneQYTfKOM85g@mail.gmail.com>
Subject: Re: [RFC 00/12] locking: Separate lock tracepoints from
 lockdep/lock_stat (v1)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>, Tejun Heo <tj@kernel.org>,
        rcu <rcu@vger.kernel.org>, cgroups <cgroups@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 9, 2022 at 1:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Feb 08, 2022 at 10:41:56AM -0800, Namhyung Kim wrote:
>
> > Eventually I'm mostly interested in the contended locks only and I
> > want to reduce the overhead in the fast path.  By moving that, it'd be
> > easy to track contended locks with timing by using two tracepoints.
>
> So why not put in two new tracepoints and call it a day?
>
> Why muck about with all that lockdep stuff just to preserve the name
> (and in the process continue to blow up data structures etc..). This
> leaves distros in a bind, will they enable this config and provide
> tracepoints while bloating the data structures and destroying things
> like lockref (which relies on sizeof(spinlock_t)), or not provide this
> at all.

If it's only lockref, is it possible to change it to use arch_spinlock_t
so that it can remain in 4 bytes?  It'd be really nice if we can keep
spin lock size, but it'd be easier to carry the name with it for
analysis IMHO.

Thanks,
Namhyung
