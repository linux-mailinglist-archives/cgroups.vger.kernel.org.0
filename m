Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6169C1C3331
	for <lists+cgroups@lfdr.de>; Mon,  4 May 2020 08:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgEDG5F (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 May 2020 02:57:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33304 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgEDG5F (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 May 2020 02:57:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9so9194535wrt.0;
        Sun, 03 May 2020 23:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xSl6evXwDms0DkVG1e4tput3+oyyMpyjg7rDRHrIFnA=;
        b=GV4PjIxmJLiqes8RfFYT0i6jdfMfAtv2G0FEnTPa1GinYkC2xp+XAldaICojDbTjnp
         9qecKMv+X7d42HythEbK/dCZdem8ShvaiZP1v5xvuN4aajCJje6cq7KWzn5bX4DGJ6U5
         jNdHIN4/sU/yYnhZp9JafHnrrb/3XNY/9IukTZIBbQpOUoZqIKPidkkPItx3i1A5hAAY
         7F9zzj4J6d1IFFNcpef+7YgUiVbwljGEm2PGytDDF0+llSysxOvD/T69tk4luJoKBThI
         u8yRzmIGPQpzBd0w3uleUDe70Wf2eYf5eLhToUr/NLHNGYq/hbEqoyOsC5QawWA2M2EZ
         Fa7Q==
X-Gm-Message-State: AGi0Pubg5xRo86Dr76rq/dAQzir1lfqQbP23+Q7Zm1hb5JZh2aU0NFsN
        fBysjktsdL45uDf7w3X+0Eg=
X-Google-Smtp-Source: APiQypJR73hwmm8jLWhexLWoxvGri8Q3HFPBC6DXFNQCtWWPT+na+ygm3dUw9LicgcH16c8bKYtZyA==
X-Received: by 2002:adf:ea05:: with SMTP id q5mr3472116wrm.87.1588575422941;
        Sun, 03 May 2020 23:57:02 -0700 (PDT)
Received: from localhost (ip-37-188-183-9.eurotel.cz. [37.188.183.9])
        by smtp.gmail.com with ESMTPSA id k184sm11193286wmf.9.2020.05.03.23.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 23:57:02 -0700 (PDT)
Date:   Mon, 4 May 2020 08:57:01 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
Message-ID: <20200504065701.GB22838@dhcp22.suse.cz>
References: <20200430182712.237526-1-shakeelb@google.com>
 <20200430192907.GA2436@cmpxchg.org>
 <CALvZod6Gatw+sX7_hsVPB-O2yMt-ygXUSweQbHwxZHgwdEth4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6Gatw+sX7_hsVPB-O2yMt-ygXUSweQbHwxZHgwdEth4Q@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 30-04-20 13:20:10, Shakeel Butt wrote:
> On Thu, Apr 30, 2020 at 12:29 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Thu, Apr 30, 2020 at 11:27:12AM -0700, Shakeel Butt wrote:
> > > Lowering memory.max can trigger an oom-kill if the reclaim does not
> > > succeed. However if oom-killer does not find a process for killing, it
> > > dumps a lot of warnings.
> > >
> > > Deleting a memcg does not reclaim memory from it and the memory can
> > > linger till there is a memory pressure. One normal way to proactively
> > > reclaim such memory is to set memory.max to 0 just before deleting the
> > > memcg. However if some of the memcg's memory is pinned by others, this
> > > operation can trigger an oom-kill without any process and thus can log a
> > > lot un-needed warnings. So, ignore all such warnings from memory.max.
> >
> > Can't you set memory.high=0 instead? It does the reclaim portion of
> > memory.max, without the actual OOM killing that causes you problems.
> 
> Yes that would work but remote charging concerns me. Remote charging
> can still happen after the memcg is offlined and at the moment, high
> reclaim does not work for remote memcg and the usage can go till max
> or global pressure. This is most probably a misconfiguration and we
> might not receive the warnings in the log ever. Setting memory.max to
> 0 will definitely give such warnings.

Can we add a warning for the remote charging on dead memcgs?

-- 
Michal Hocko
SUSE Labs
