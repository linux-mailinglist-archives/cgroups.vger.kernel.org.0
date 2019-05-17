Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE12421DFA
	for <lists+cgroups@lfdr.de>; Fri, 17 May 2019 21:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfEQTEZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 May 2019 15:04:25 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:38339 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfEQTEY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 May 2019 15:04:24 -0400
Received: by mail-pf1-f171.google.com with SMTP id b76so4115459pfb.5
        for <cgroups@vger.kernel.org>; Fri, 17 May 2019 12:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xuh8AvfRHyKt8wFOgAYzPXD6mpnRhkLu6Cz7c9n98Ts=;
        b=J7bcW3dketKiYlf25WPCh4PI8Mbjyiwq4wcw6yR4Vct1Rp3cZlrXethBayJBmPBzEv
         y0DIHHKj6vr07ubFFc+9FzOR1tXcxlcKik+PuLdkDQVhF4MDRYvVRb55+kJLilYmv2kd
         UwGXU71/StM7zN4RjrOUfjVx4luRcvWQblbtxVfXXuKcUM1BEzBtNY9TBchPaKEWMd20
         Vwh0s339HQRIxV+w4CuW+DUijAWDJc3B/XGx6EZgkNsvngKE1Ut3DwZXVTlhWeDWQ89h
         B/XEFLsE33iMXb5ZBxu99aMy7EA8u7TrG9estArZM7d6z77iMavGMq66F1weGtk9TfLj
         W5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xuh8AvfRHyKt8wFOgAYzPXD6mpnRhkLu6Cz7c9n98Ts=;
        b=iyjH0zZZGG3vM/PZ07ysE4NEmFKCnfCXCmGK3DVu8OPzaNbbdowjVe2Od9vEmErRvD
         hG8ZDFYWuoj2/vLftAaL9sHTX8lN5v5abyjgCGh43HxOxmcvViv0E10Cpxdo+n222zjI
         txpgV5R/ksIR5rrlsITuydtxZ9vJvrIU7pmdYty7nozhDV60rsCCPmidn8LwGNgDPf/G
         ZHx6SCrwgf4ZSvnS5XMAKkKfjgquxCSVbFGvXGlDXgrfQtQxbVx85XWpNKkspKdwfMUi
         dyvUbPjFnwaN05t/+uhRBSTydt+dNPgNX6ENxnpRsF+2aW27oqsYLYn9c7qUugtyXMDd
         JIgw==
X-Gm-Message-State: APjAAAWSP7O+BX8/nWWkqUvcuyX+I7HXbyNE3GfKTP2r7EAuaZWtqvMI
        d6jqDWbkjcrVpvPs23x7wFznHw==
X-Google-Smtp-Source: APXvYqyuIk+UkPjjkd1V+6w1s2mmy7Z9ea6q8FLScbdq74OswTvSQoEo52OQ8Nb0o4d/RevpxkuEMQ==
X-Received: by 2002:a62:ea0a:: with SMTP id t10mr62261738pfh.236.1558119864166;
        Fri, 17 May 2019 12:04:24 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::b0f6])
        by smtp.gmail.com with ESMTPSA id s134sm15617911pfc.110.2019.05.17.12.04.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 12:04:23 -0700 (PDT)
Date:   Fri, 17 May 2019 15:04:21 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        mm-commits@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        Chris Down <chris@chrisdown.name>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: + mm-consider-subtrees-in-memoryevents.patch added to -mm tree
Message-ID: <20190517190421.GA6166@cmpxchg.org>
References: <20190212224542.ZW63a%akpm@linux-foundation.org>
 <20190213124729.GI4525@dhcp22.suse.cz>
 <CALvZod6c9OCy9p79hTgByjn+_BmnQ6p216kD9dgEhCSNFzpeKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6c9OCy9p79hTgByjn+_BmnQ6p216kD9dgEhCSNFzpeKw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 17, 2019 at 06:00:11AM -0700, Shakeel Butt wrote:
> On Wed, Feb 13, 2019 at 4:47 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > notifications.
> > >
> > > After this patch, events are propagated up the hierarchy:
> > >
> > >     [root@ktst ~]# cat /sys/fs/cgroup/system.slice/memory.events
> > >     low 0
> > >     high 0
> > >     max 0
> > >     oom 0
> > >     oom_kill 0
> > >     [root@ktst ~]# systemd-run -p MemoryMax=1 true
> > >     Running as unit: run-r251162a189fb4562b9dabfdc9b0422f5.service
> > >     [root@ktst ~]# cat /sys/fs/cgroup/system.slice/memory.events
> > >     low 0
> > >     high 0
> > >     max 7
> > >     oom 1
> > >     oom_kill 1
> > >
> > > As this is a change in behaviour, this can be reverted to the old
> > > behaviour by mounting with the `memory_localevents' flag set.  However, we
> > > use the new behaviour by default as there's a lack of evidence that there
> > > are any current users of memory.events that would find this change
> > > undesirable.
> > >
> > > Link: http://lkml.kernel.org/r/20190208224419.GA24772@chrisdown.name
> > > Signed-off-by: Chris Down <chris@chrisdown.name>
> > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Thanks, Shakeel.

> However can we please have memory.events.local merged along with this one?

Could I ask you to send a patch for this? It's not really about the
code - that should be trivial. Rather it's about laying out the exact
usecase for that, which is harder for me/Chris/FB since we don't have
one. I imagine simliar arguments could be made for memory.stat.local,
memory.pressure.local etc. since they're also reporting events and
behavior manifesting in different levels of the cgroup subtree?
