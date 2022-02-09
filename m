Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467E34AFDA5
	for <lists+cgroups@lfdr.de>; Wed,  9 Feb 2022 20:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiBITqP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Feb 2022 14:46:15 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiBITqO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Feb 2022 14:46:14 -0500
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178EDE00ED60;
        Wed,  9 Feb 2022 11:46:12 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id n24so2254101ljj.10;
        Wed, 09 Feb 2022 11:46:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mI+M+mpK8d6GUtu7pCBOaGOdu7sx/dJ/6QGGwi/Jk00=;
        b=BPBcR5MWpt3lJzgo3WfePMLWbEtab6Sso6wUGTMDZ3JAWFfnI6d0x0IFL+B9+sLoMd
         Mc3x3Dr/TUmvA+0wl0XRBC51hiBHdeFWPXMABsvCHMmCmiX/30YOASqUAUdjCRBKmuAq
         BOGqS3g99JPUaVTOHatodmWBeEEPaNGXK594IDRnwyzY1acBovzPnkSVXPnyCx+aOxys
         tlDu7G9T8QTcS0fIE3TKTnv/XH2OUaU0vsZkcIhnzp0m9s2zzIWsqzomZm6WtmN8btbV
         LoIC36OuWFRc9pd9U35ASlVdRhy9maip2rF4iLFf/JOccuLFUslK7p+h0p2U1iVMfIyy
         Br6Q==
X-Gm-Message-State: AOAM5335ZfvzznOeGsd5F4K3V0W+YbPcbZ2XjGE14eQhhyST419rGfbB
        xMs51e/WEMriMff60PayPiqE+1l9HkRubOBykPc=
X-Google-Smtp-Source: ABdhPJxVSOnkXD7hI3w7PfvaBvSIaDepKBIElf+UxIlokkvG7/1wW0KYALgOvKXGhDUoR0FDS0DS3ySD+sopph9e06A=
X-Received: by 2002:a2e:b611:: with SMTP id r17mr2522075ljn.457.1644435970319;
 Wed, 09 Feb 2022 11:46:10 -0800 (PST)
MIME-Version: 1.0
References: <20220208184208.79303-1-namhyung@kernel.org> <20220209090908.GK23216@worktop.programming.kicks-ass.net>
 <24fe6a08-5931-8e8d-8d77-459388c4654e@redhat.com> <919214156.50301.1644431371345.JavaMail.zimbra@efficios.com>
 <69e5f778-8715-4acf-c027-58b6ec4a9e77@redhat.com> <CAM9d7ci=N2NVj57k=W0ebqBzfW+ThBqYSrx-CZbgwGcbOSrEGA@mail.gmail.com>
 <718973621.50447.1644434890744.JavaMail.zimbra@efficios.com>
In-Reply-To: <718973621.50447.1644434890744.JavaMail.zimbra@efficios.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 9 Feb 2022 11:45:59 -0800
Message-ID: <CAM9d7cj=tj6pA48q_wkQOGn-2vUc9FRj63bMBOm5R7OukmMbTQ@mail.gmail.com>
Subject: Re: [RFC 00/12] locking: Separate lock tracepoints from
 lockdep/lock_stat (v1)
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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

On Wed, Feb 9, 2022 at 11:28 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Feb 9, 2022, at 2:22 PM, Namhyung Kim namhyung@kernel.org wrote:
> > I'm also concerning dynamic allocated locks in a data structure.
> > If we keep the info in a hash table, we should delete it when the
> > lock is gone.  I'm not sure we have a good place to hook it up all.
>
> I was wondering about this use case as well. Can we make it mandatory to
> declare the lock "class" (including the name) statically, even though the
> lock per-se is allocated dynamically ? Then the initialization of the lock
> embedded within the data structure would simply refer to the lock class
> definition.

Isn't it still the same if we have static lock classes that the entry needs
to be deleted from the hash table when it frees the data structure?
I'm more concerned about free than alloc as there seems to be no
API to track that in a place.

Thanks,
Namhyung
