Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919ED1C33F0
	for <lists+cgroups@lfdr.de>; Mon,  4 May 2020 10:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgEDIDN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 May 2020 04:03:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40831 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgEDIDN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 May 2020 04:03:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id e16so14623682wra.7;
        Mon, 04 May 2020 01:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/dle8w9T/9fZDXiBv7O2x4fp68bt2R/VvMXMsCmw1pE=;
        b=mrd6kTFB+WjVAUnCqoaxN6kSyAfmShjurd/as1bJan51An2esasyt9EunGhlqNd/w6
         RCMNpTPimcj15FTHrrLvLwrQP3+DPd9A8HqUhKOUJLoC7bpgXVuQh3WuIYoqhEaciZUc
         V0B51MiKhb8l88xbDAGVQB312OstY2yhYby+udHNgMMZ4vqa4TUfeGVNo3JnJ0xYDQNB
         guXIBzNmKcrWCgVRZAiV+C9r6v22dxV5w1s3hM7mSqS5JVMe9vIIPuEcez9WN1T3WqAn
         5hu0m8aMKUCQFWyoUDNgzMBfUDKlPTjwl6RnN5+XYcMOj1aOQB2zIRSwMkE/WxFKmqns
         2yXg==
X-Gm-Message-State: AGi0PuajxtVLtggKv4qGdWveo28Ghl3iQ9b81V2EHaou0rx8ugAFGmsz
        8jWNofIL+vA4u/SsB6HcZdU=
X-Google-Smtp-Source: APiQypLfZaQESks6MYn/H7NmDLU6oeSUQW3/ziKVk3jh4HhIx6Ky1zIML5CFi2gReyWlooECxA5PkA==
X-Received: by 2002:adf:9564:: with SMTP id 91mr18305719wrs.246.1588579389756;
        Mon, 04 May 2020 01:03:09 -0700 (PDT)
Received: from localhost (ip-37-188-183-9.eurotel.cz. [37.188.183.9])
        by smtp.gmail.com with ESMTPSA id d143sm12147653wmd.16.2020.05.04.01.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 01:03:09 -0700 (PDT)
Date:   Mon, 4 May 2020 10:03:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
Message-ID: <20200504080308.GI22838@dhcp22.suse.cz>
References: <20200430182712.237526-1-shakeelb@google.com>
 <CALOAHbC4WY00yQ46b8CFqVQ3S=JSJxE2HR00TtMqXOWLRPRZ8w@mail.gmail.com>
 <20200504070301.GC22838@dhcp22.suse.cz>
 <CALOAHbCJBaa26m2cUkE0evwDnSFvUPrdBg9=WMjC7Yt_33-BJQ@mail.gmail.com>
 <20200504073549.GE22838@dhcp22.suse.cz>
 <CALOAHbDd8hjURSi9jAdjQTbSLDvu9vkOkjS1hZNn04G8Yj7WdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbDd8hjURSi9jAdjQTbSLDvu9vkOkjS1hZNn04G8Yj7WdQ@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 04-05-20 15:40:18, Yafang Shao wrote:
> On Mon, May 4, 2020 at 3:35 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Mon 04-05-20 15:26:52, Yafang Shao wrote:
[...]
> > > As explianed above, no eligible task is different from no task.
> > > If there are some candidates but no one is eligible, the system will panic.
> > > While if there's no task, it is definitely no OOM, because that's an
> > > improssible thing for the system.
> >
> > This is very much possible situation when all eligible tasks have been
> > already killed but they didn't really help to resolve the oom situation
> > - e.g. in kernel memory leak or unbounded shmem consumption etc...
> >
> 
> That's still an impossible thing, because many tasks are invisible to
> the oom killer.
> See oom_unkillable_task().

I do not follow, really. oom_unkillable_task only says that global init
cannot be killed and that it doesn't make any sense to kill kernel
threads as they do not own any mm normally.

-- 
Michal Hocko
SUSE Labs
