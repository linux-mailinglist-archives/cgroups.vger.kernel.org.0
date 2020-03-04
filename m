Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C71D17954D
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2020 17:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgCDQas (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Mar 2020 11:30:48 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43192 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbgCDQar (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Mar 2020 11:30:47 -0500
Received: by mail-qk1-f196.google.com with SMTP id q18so2190917qki.10
        for <cgroups@vger.kernel.org>; Wed, 04 Mar 2020 08:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=K4BeHblYXMy0jWZevx0X7etvY4HSc10p3TfF4SsNt5M=;
        b=iVS3T6wquyX/FWV1nq/cJXE2LdWrz8AEhTgPW18XqQ2ELQwisn/W76smiuCyICLB0p
         TAuQJ0fJRabTH6jMTNK89S9FTpC0JKCVgih+m7VKtN3BbfzMX/0U9DD9oJxdQQaMs1+C
         zs4xCYDaiTiEpGJHW+QzoVI5K5OsoD1PUSS2ibvwrty7ZE4fPVPlPAz8WNaU0lDKXhmO
         j7JKPSrzzP94Ky2NJN++LguGAGKgi7x7IwtHmQgSC5Xat8yN8aCJvvCeYWf6zYkD0/Np
         0MEaHYzQyScqzH0QmIfa0tFkWIJc1v8+pveYzECCi8suYzEonyDvZlXMknoNkof7QBOt
         RxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=K4BeHblYXMy0jWZevx0X7etvY4HSc10p3TfF4SsNt5M=;
        b=pQDdVNPGzRKyHnY5R5XSoQa41M9kpt9azBaab9p+6f0xquBVSjeIZ5UJ4vKze7rlCm
         Kb0t5ZK1UQ7CIFoOV/j2XQhHa/HZPzHtczgtoas8ubY9LfqmaQbTmhsrxtq5sTJYGPzo
         erE9M6R8Mrwild+L3Tsr8gT83VDVJfVklqDLKs0fMXjmlWha/LOc6PtXVMbduKNBjMF5
         YCa0oKc3YH3wI6MaGGcLJogM/2fwOUbVFsR+mTcm/+tG37w6gqcLX3PsxYuDmwLFFVfi
         g5gZRjFI69WjSL22ASU9GpjPwOLQJplBDGRKUiXA0jxKewC1pFtvkTbzaXo4TY/31sFz
         gvRQ==
X-Gm-Message-State: ANhLgQ2p246L1shXBIJjiuJoooSLoz3UxeepCP6NyBWGcn5R/Dk+lRw8
        Qygci0mJBxeu4FjEXWF8UryZUYtcsTY=
X-Google-Smtp-Source: ADFU+vsWAl8Llot94c7MeH+hc39to+NLcgycHlu+sCcv/afdavFw0EEZd5NGLAN1fj9gX5kSNrw1Qw==
X-Received: by 2002:ae9:f205:: with SMTP id m5mr3787154qkg.152.1583339446004;
        Wed, 04 Mar 2020 08:30:46 -0800 (PST)
Received: from localhost ([71.172.127.161])
        by smtp.gmail.com with ESMTPSA id i91sm14577151qtd.70.2020.03.04.08.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 08:30:45 -0800 (PST)
Date:   Wed, 4 Mar 2020 11:30:44 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Benjamin Berg <benjamin@sipsolutions.net>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: Memory reclaim protection and cgroup nesting (desktop use)
Message-ID: <20200304163044.GF189690@mtj.thefacebook.com>
References: <d4826b9e568f1ab7df19f94c409df11956a8e262.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4826b9e568f1ab7df19f94c409df11956a8e262.camel@sipsolutions.net>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

(cc'ing Johannes and quoting whole msg)

On Wed, Mar 04, 2020 at 10:44:44AM +0100, Benjamin Berg wrote:
> Hi,
> 
> TL;DR: I seem to need memory.min/memory.max to be set on each child
> cgroup and not just the parents. Is this expected?

Yes, currently. However, v5.7+ will have a cgroup2 mount option to
propagate protection automatically.

  https://lore.kernel.org/linux-mm/20191219200718.15696-4-hannes@cmpxchg.org/

> I have been experimenting with using cgroups to protect a GNOME
> session. The intention is that the GNOME Shell itself and important
> other services remain responsive, even if the application workload is
> thrashing. The long term goal here is to bridge the time until an OOM
> killer like oomd would get the system back into normal conditions using
> memory pressure information.
> 
> Note that I have done these tests without any swap and with huge
> memory.min/memory.low values. I consider this scenario pathological,
> however, it seems like a reasonable way to really exercise the cgroup
> reclaim protection logic.

It's incomplete and more brittle in that the kernel has to treat a
large portion of memory usage as essentially memlocked.

> The resulting cgroup hierarchy looked something like:
> 
> -.slice
> ├─user.slice
> │ └─user-1000.slice
> │   ├─user@1000.service
> │   │ ├─session.slice
> │   │ │ ├─gsd-*.service
> │   │ │ │ └─208803 /usr/libexec/gsd-rfkill
> │   │ │ ├─gnome-shell-wayland.service
> │   │ │ │ ├─208493 /usr/bin/gnome-shell
> │   │ │ │ ├─208549 /usr/bin/Xwayland :0 -rootless -noreset -accessx -core -auth /run/user/1000/.mutter-Xwayla>
> │   │ │ │ └─ …
> │   │ └─apps.slice
> │   │   ├─gnome-launched-tracker-miner-fs.desktop-208880.scope
> │   │   │ └─208880 /usr/libexec/tracker-miner-fs
> │   │   ├─dbus-:1.2-org.gnome.OnlineAccounts@0.service
> │   │   │ └─208668 /usr/libexec/goa-daemon
> │   │   ├─flatpak-org.gnome.Fractal-210350.scope
> │   │   ├─gnome-terminal-server.service
> │   │   │ ├─209261 /usr/libexec/gnome-terminal-server
> │   │   │ ├─209434 bash
> │   │   │ └─ … including the test load i.e. "make -j32" of a C++ code
> 
> 
> I also enabled the CPU and IO controllers in my tests, but I don't
> think that is as relevant. The main thing is that I set

CPU control isn't but IO is. Without working IO isolation, it's
relatively easy to drive the system into the ground given enough
stress ouside the protected area.

>   memory.min: 2GiB
>   memory.low: 4GiB
> 
> using systemd on all of
> 
>  * user.slice,
>  * user-1000.slice,
>  * user@1000.slice,
>  * session.slice and
>  * everything inside session.slice
>    (i.e. gnome-shell-wayland.service, gsd-*.service, …)
> 
> excluding apps.slice from protection.
> 
> (In a realistic scenario I expect to have swap and then reserving maybe
> a few hundred MiB; DAMON might help with finding good values.)

What's DAMON?

> At that point, the protection started working pretty much flawlessly.
> i.e. my gnome-shell would continue to run without major page faulting
> even though everything in apps.slice was thrashing heavily. The
> mouse/keyboard remained completely responsive, and interacting with
> applications ended up working much better thanks to knowing where input
> was going. Even if the applications themselves took seconds to react.
> 
> So far, so good. What surprises me is that I needed to set the
> protection on the child cgroups (i.e. gnome-shell-wayland.service).
> Without this, it would not work (reliably) and my gnome-shell would
> still have a lot of re-faults to load libraries and other mmap'ed data
> back into memory (I used "perf --no-syscalls -F" to trace this and
> observed these to be repeatedly for the same pages loading e.g.
> functions for execution).
> 
> Due to accounting effects, I would expect re-faults to happen up to one
> time in this scenario. At that point the page in question will be
> accounted against the shell's cgroup and reclaim protection could kick
> in. Unfortunately, that did not seem to happen unless the shell's
> cgroup itself had protections and not just all of its parents.
> 
> Is it expected that I need to set limits on each child?

Yes, right now, memory.low needs to be configured all the way down to
the leaf to be effective, which can be rather cumbersome. As written
above, future kernels will be easier to work with in this respect.

Thanks.

-- 
tejun
