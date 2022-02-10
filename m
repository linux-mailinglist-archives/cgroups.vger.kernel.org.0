Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C87E4B029F
	for <lists+cgroups@lfdr.de>; Thu, 10 Feb 2022 03:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbiBJCAS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Feb 2022 21:00:18 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbiBJB7V (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Feb 2022 20:59:21 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85B1270F0;
        Wed,  9 Feb 2022 17:34:08 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id s18so6888042wrv.7;
        Wed, 09 Feb 2022 17:34:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S7eVUoreTdbtEAolbtfKVyv4dZoqeTIGEz+EBJSn9AQ=;
        b=HiXDpS4p5aclt5sJhGVSnvMD9694FZ04yJaRqWqvGmu0j8OoQMV63r+TC6T17cE3+t
         PPwUV0F3K+pbBQnaYfEgcJwq9s1pqBaeOnUcclljXbn/iiuM1ygpL2Jn5W3cT/KKp8HZ
         edGeycpXSbEh/8Z9633HhnpNwp8pZp9RgTxZHYzGZUHfqYcKzoQNQ75t0q25PRQBF5zt
         OPbAjakjnVl+KssnbJZ4rhAKwXDCpcrApPbkRPQL/ARkftCKiznsqHQXWTyxOrow5f+R
         BLQT6mhqmE2cWdVSdlgG9LnL+3Qw8vZ4g7ykRaCYEVu8WN6REh/uVOCZtMp1JPsGZdpS
         33Tg==
X-Gm-Message-State: AOAM531syoCndjIjntNV6kfpDHr0/oKD11Vm1Ss4J9QfZTVCGyHsgUp4
        UcO+9tDJgpfargjQ1knngJtwH+iQMLdeZ69AqCnZ/s3+
X-Google-Smtp-Source: ABdhPJxECgtyvabxbqWLIvad75/MXw7Bove9aVEmgchS/RAiH0bwkldePoCObtsg2kp8bdf3KphsStFgI9e5U3sEWSA=
X-Received: by 2002:a05:6512:3b9a:: with SMTP id g26mr3428751lfv.71.1644452844971;
 Wed, 09 Feb 2022 16:27:24 -0800 (PST)
MIME-Version: 1.0
References: <20220208184208.79303-1-namhyung@kernel.org> <20220209090908.GK23216@worktop.programming.kicks-ass.net>
 <24fe6a08-5931-8e8d-8d77-459388c4654e@redhat.com> <919214156.50301.1644431371345.JavaMail.zimbra@efficios.com>
 <69e5f778-8715-4acf-c027-58b6ec4a9e77@redhat.com> <CAM9d7ci=N2NVj57k=W0ebqBzfW+ThBqYSrx-CZbgwGcbOSrEGA@mail.gmail.com>
 <718973621.50447.1644434890744.JavaMail.zimbra@efficios.com>
 <CAM9d7cj=tj6pA48q_wkQOGn-2vUc9FRj63bMBOm5R7OukmMbTQ@mail.gmail.com> <f8b7760f-16a2-6ada-de88-9e21a7e8fef9@redhat.com>
In-Reply-To: <f8b7760f-16a2-6ada-de88-9e21a7e8fef9@redhat.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 9 Feb 2022 16:27:13 -0800
Message-ID: <CAM9d7chH0Pvxx_FURL0sZvawwenRmjPyfac_9oinOaRwv8isng@mail.gmail.com>
Subject: Re: [RFC 00/12] locking: Separate lock tracepoints from
 lockdep/lock_stat (v1)
To:     Waiman Long <longman@redhat.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 9, 2022 at 12:17 PM Waiman Long <longman@redhat.com> wrote:
>
>
> On 2/9/22 14:45, Namhyung Kim wrote:
> > On Wed, Feb 9, 2022 at 11:28 AM Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> >> ----- On Feb 9, 2022, at 2:22 PM, Namhyung Kim namhyung@kernel.org wrote:
> >>> I'm also concerning dynamic allocated locks in a data structure.
> >>> If we keep the info in a hash table, we should delete it when the
> >>> lock is gone.  I'm not sure we have a good place to hook it up all.
> >> I was wondering about this use case as well. Can we make it mandatory to
> >> declare the lock "class" (including the name) statically, even though the
> >> lock per-se is allocated dynamically ? Then the initialization of the lock
> >> embedded within the data structure would simply refer to the lock class
> >> definition.
> > Isn't it still the same if we have static lock classes that the entry needs
> > to be deleted from the hash table when it frees the data structure?
> > I'm more concerned about free than alloc as there seems to be no
> > API to track that in a place.
>
> We may have to invent some new APIs to do that. For example,
> spin_lock_exit() can be the counterpart of spin_lock_init() and so on.
> Of course, existing kernel code have to be modified to designate the
> point after which a lock is no longer being used or is freed.

Yeah, but I'm afraid that it could be easy to miss something.
Also it would add some runtime overhead due to maintaining
the hash table even if the tracepoints are not used.

Thanks,
Namhyung
