Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FB31C3BCB
	for <lists+cgroups@lfdr.de>; Mon,  4 May 2020 15:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgEDNzC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 May 2020 09:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728116AbgEDNzB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 May 2020 09:55:01 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D038C061A0E
        for <cgroups@vger.kernel.org>; Mon,  4 May 2020 06:55:01 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id g4so9756411ljl.2
        for <cgroups@vger.kernel.org>; Mon, 04 May 2020 06:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Itdyqr8e224xa0qoeMb+hZq4gtZJw27Kt/U4OO6UwfY=;
        b=VwcmkO0/GGrS6n5JI5GYBP8kGrKFLTo2xvM2ArBj0wbbTAFiLbviLMWKFElUpB1u6f
         WgULsIHvmc25XtTe+aJFycilL4dmDvYQXBjgWFAqwh6WcFlGwUP/KZN3Izhl5TPyVYWx
         G28TYGCkekQgzmA9OTUzT3vDw78RBR1mtkmpHdpljY6SYmnD2iBGW25ClTOYDjONv/DZ
         4dAknYrGHYB8MFaPSTGCOfozIdR+Z2EP6rW2LI59ejQ8A8zk69BN9FX540dADpBvZWg4
         AHm0elYmxfpvuY5b9nbJ9Bpb+6pyYKLZmUTWEUuMAMpCQzn3eLMnlpgruHUEUJdyhwJ7
         kVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Itdyqr8e224xa0qoeMb+hZq4gtZJw27Kt/U4OO6UwfY=;
        b=Gwx7M+HQxqRy+aQPSCec3W0VFX1Q7cVUe1wASaPky9a9qYpUvmWzZTK7w9iOIJkMHW
         nvhs25/dhGNR0ZkptMK7F+/XVL2GyXfz4b4z8TTpvcXqrJANJNUnWg+WONNOUpssmK4o
         xEHO5rDLTY2NjYivfK8abB+OzzxKDpt91IZmP1lO5ay5Eo5TcI/UiCWAO27geT+S0FpG
         2/0ECSTJsE7YMmDELguNq9vja240GGUqpGURKYT+7WNCzgRBGI57aRDcidU57G2Vl9UO
         YwGqoagTYwrAFDdQIxneCD0Fwf4G9GcPAaUjkUKAu/P/HbLvs6l2Q88m/TQ7oivDoRlp
         zEdg==
X-Gm-Message-State: AGi0Pub0j7qsfpPLiDBglurOex7n6f8bxG/bAn2xbMqwDxRK5XVGrDD1
        9rH8S4kkLO+DGRc6jgWexJjvQ+RUOZiqBX8mHPpxVA==
X-Google-Smtp-Source: APiQypKqAKnoOiCs/8EtnTYjFOuEKS1X7ml0nzp5cVcBNdTubHtkdwIUSuo4z/eUhZ7BmF9cZA0K+zzUomm2bREV/nw=
X-Received: by 2002:a2e:330f:: with SMTP id d15mr9701206ljc.250.1588600499500;
 Mon, 04 May 2020 06:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200430182712.237526-1-shakeelb@google.com> <20200430192907.GA2436@cmpxchg.org>
 <CALvZod6Gatw+sX7_hsVPB-O2yMt-ygXUSweQbHwxZHgwdEth4Q@mail.gmail.com> <20200504065701.GB22838@dhcp22.suse.cz>
In-Reply-To: <20200504065701.GB22838@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 4 May 2020 06:54:47 -0700
Message-ID: <CALvZod7qEE-k0uoSbUR-+pD2kWshz2SYQNXaVCLPiTTG8sqAmQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, May 3, 2020 at 11:57 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 30-04-20 13:20:10, Shakeel Butt wrote:
> > On Thu, Apr 30, 2020 at 12:29 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > On Thu, Apr 30, 2020 at 11:27:12AM -0700, Shakeel Butt wrote:
> > > > Lowering memory.max can trigger an oom-kill if the reclaim does not
> > > > succeed. However if oom-killer does not find a process for killing, it
> > > > dumps a lot of warnings.
> > > >
> > > > Deleting a memcg does not reclaim memory from it and the memory can
> > > > linger till there is a memory pressure. One normal way to proactively
> > > > reclaim such memory is to set memory.max to 0 just before deleting the
> > > > memcg. However if some of the memcg's memory is pinned by others, this
> > > > operation can trigger an oom-kill without any process and thus can log a
> > > > lot un-needed warnings. So, ignore all such warnings from memory.max.
> > >
> > > Can't you set memory.high=0 instead? It does the reclaim portion of
> > > memory.max, without the actual OOM killing that causes you problems.
> >
> > Yes that would work but remote charging concerns me. Remote charging
> > can still happen after the memcg is offlined and at the moment, high
> > reclaim does not work for remote memcg and the usage can go till max
> > or global pressure. This is most probably a misconfiguration and we
> > might not receive the warnings in the log ever. Setting memory.max to
> > 0 will definitely give such warnings.
>
> Can we add a warning for the remote charging on dead memcgs?
>

I don't think we should warn for all remote charging on dead memcgs.
One particular example is the buffer_head which can be allocated
within reclaim context and most probably pages which they are attached
to will be freed soon.

Shakeel
