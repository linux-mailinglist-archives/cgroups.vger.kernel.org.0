Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAF43CA39D
	for <lists+cgroups@lfdr.de>; Thu, 15 Jul 2021 19:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbhGOROQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Jul 2021 13:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhGOROQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Jul 2021 13:14:16 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD71DC06175F
        for <cgroups@vger.kernel.org>; Thu, 15 Jul 2021 10:11:22 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id b26so11164024lfo.4
        for <cgroups@vger.kernel.org>; Thu, 15 Jul 2021 10:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7bC7OSAi9agetXXpK35QVSGmKS8AgVugfnrXcpn3Dns=;
        b=oV8bWJnOMcqDiyr0EEcrUCFtr4BMdFOqgv31ZoDSoO3gbciYC2/GnL9d3E8g3kFyoR
         TuNYJwrY8HJTIT3oVRzFGI5hPlaBY8cEGhLJ1LnpN1rLT8iqJJY6F3Tr/mTCG+p4ja70
         6dPMHVY6v+3XAdY7+6CHPbWFEA0+hsuvyLSQLImPXVhoV5i2sZ9Ey1Fl6QmGQgHWmLBR
         wYE0wzjsd9Lxip18YoD2mr/S/TGsszZWQ8QBWI8oz24cP1EBHhPmaV4eT09MB2QUrCrN
         Q+elf9KtHyTyifjirK5MT978iFGeTPvl9KPDAa94CLE52eDIMo4mw7ouMF7B5b+qelwv
         UJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7bC7OSAi9agetXXpK35QVSGmKS8AgVugfnrXcpn3Dns=;
        b=tRMVdlnOwkZi6nswTk9nETbyWKeyWshBKbK/lvuT1dvUnlheS7IYvc9Wo3+B/BbFh2
         fVA/UrAWVz3uGplE7nUTDCXNBvEEQRRRKtEb68IYof6B9eD/k4i5ZkYQAdUDm+pBPXHx
         eJuraKjycCTdlf4asMxggE7XHNmtBr5n9yZME5t4cT1VlTgzuuGPrUtNDuPR9UACCLL/
         pX5JFzl2Qd/saGykCqCnMwQ2PDfOoXmsB58QpHPK0NMlomO56qLcw2ttDwBdmOOTYT7j
         7BboikZEVa/U9NvdUofKMgVKkFmyakZDX0xlsI8zQyEAD5S4lPHuXj0yrWzY/Vbb8V9/
         uElA==
X-Gm-Message-State: AOAM533GmqNUfOFgo6B44fk9N2OQi+meuY63PQsllqn9U9Uk38MKwUEI
        VfWamKk6r0DSr7jwzT6nwsfgyv7pJrLEU04wbox1aC3SqeE=
X-Google-Smtp-Source: ABdhPJyzoWcYOMmd3YO5faRlMZsNYbj4t2PODdkzIp67+zsnvIoMjBy45Jf5vRVMeFqQ/CggTMJlP5KGNSgk62vVCtM=
X-Received: by 2002:a19:ad4d:: with SMTP id s13mr4200989lfd.432.1626369080651;
 Thu, 15 Jul 2021 10:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <8664122a-99d3-7199-869a-781b21b7e712@virtuozzo.com> <919bd022-075e-98a7-cefb-89b5dee80ae8@virtuozzo.com>
In-Reply-To: <919bd022-075e-98a7-cefb-89b5dee80ae8@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 15 Jul 2021 10:11:09 -0700
Message-ID: <CALvZod5Kxrj3T99CEd8=OaoW8CwKtHOVhno58_nNOqjR2y=x6Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/16] memcg accounting from OpenVZ
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Serge Hallyn <serge@hallyn.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zefan Li <lizefan.x@bytedance.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 27, 2021 at 11:51 PM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> OpenVZ uses memory accounting 20+ years since v2.2.x linux kernels.
> Initially we used our own accounting subsystem, then partially committed
> it to upstream, and a few years ago switched to cgroups v1.
> Now we're rebasing again, revising our old patches and trying to push
> them upstream.
>
> We try to protect the host system from any misuse of kernel memory
> allocation triggered by untrusted users inside the containers.
>
> Patch-set is addressed mostly to cgroups maintainers and cgroups@ mailing
> list, though I would be very grateful for any comments from maintainersi
> of affected subsystems or other people added in cc:
>
> Compared to the upstream, we additionally account the following kernel objects:
> - network devices and its Tx/Rx queues
> - ipv4/v6 addresses and routing-related objects
> - inet_bind_bucket cache objects
> - VLAN group arrays
> - ipv6/sit: ip_tunnel_prl
> - scm_fp_list objects used by SCM_RIGHTS messages of Unix sockets
> - nsproxy and namespace objects itself
> - IPC objects: semaphores, message queues and share memory segments
> - mounts
> - pollfd and select bits arrays
> - signals and posix timers
> - file lock
> - fasync_struct used by the file lease code and driver's fasync queues
> - tty objects
> - per-mm LDT
>
> We have an incorrect/incomplete/obsoleted accounting for few other kernel
> objects: sk_filter, af_packets, netlink and xt_counters for iptables.
> They require rework and probably will be dropped at all.
>
> Also we're going to add an accounting for nft, however it is not ready yet.
>
> We have not tested performance on upstream, however, our performance team
> compares our current RHEL7-based production kernel and reports that
> they are at least not worse as the according original RHEL7 kernel.
>

Hi Vasily,

What's the status of this series? I see a couple patches did get
acked/reviewed. Can you please re-send the series with updated ack
tags?

thanks,
Shakeel
