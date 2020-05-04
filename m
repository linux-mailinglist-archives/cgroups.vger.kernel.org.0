Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6821C3C77
	for <lists+cgroups@lfdr.de>; Mon,  4 May 2020 16:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgEDOLl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 May 2020 10:11:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51708 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgEDOLk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 May 2020 10:11:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id x4so8637425wmj.1;
        Mon, 04 May 2020 07:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zhg/lpI81ciSxh0fDjxdl8lxOebSyQ78Sv338/w3oPQ=;
        b=rJIqbzgWbe7JBoG3mO5trfY5HjP8qfYv99u8R1TuD+G+Mj/VL+na024fmiaR9AD742
         eqc4VfTuEyZrOL9WwFTlGWnONZcwAg1w7fBtcOpeCahYeUBNpQnkbKzPz4y9mDWGgdkC
         i5FADfLQp6aePQV8OALyoM0djJdiN69kS7XdJIeegEd0jbdETE05FLnWmJ13YUqDWkdY
         xoRiyxCYG5aol+c9vcQRE7+GcjRJyHM+aLYCsvbiQm1L/1AUP+Jn8k2uYEm/04/9WsPL
         JCcw5V6A9H1006n5rihoqEm5hsACb2hf+f3yScls98Kc2B6cC74oka0UYPucQeRlrH0+
         //Cg==
X-Gm-Message-State: AGi0PuYB+cUheJGVUHYUgUtJlbrc4TpzePDoNKWw7FLs2i+ThCLCarDs
        ZqykuGT97jQsww1wd/IcBHA=
X-Google-Smtp-Source: APiQypLBTMdBsqI3e05mfgV9qMZytUOnyP9gk3F560DYzx00KopeXxRT1ghjjg42a4hKAmUBPodayQ==
X-Received: by 2002:a1c:9e43:: with SMTP id h64mr14579214wme.0.1588601498915;
        Mon, 04 May 2020 07:11:38 -0700 (PDT)
Received: from localhost (ip-37-188-183-9.eurotel.cz. [37.188.183.9])
        by smtp.gmail.com with ESMTPSA id i25sm13328487wml.43.2020.05.04.07.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 07:11:38 -0700 (PDT)
Date:   Mon, 4 May 2020 16:11:36 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
Message-ID: <20200504141136.GR22838@dhcp22.suse.cz>
References: <20200430182712.237526-1-shakeelb@google.com>
 <20200504065600.GA22838@dhcp22.suse.cz>
 <CALvZod5Ao2PEFPEOckW6URBfxisp9nNpNeon1GuctuHehqk_6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5Ao2PEFPEOckW6URBfxisp9nNpNeon1GuctuHehqk_6Q@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 04-05-20 06:54:40, Shakeel Butt wrote:
> On Sun, May 3, 2020 at 11:56 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Thu 30-04-20 11:27:12, Shakeel Butt wrote:
> > > Lowering memory.max can trigger an oom-kill if the reclaim does not
> > > succeed. However if oom-killer does not find a process for killing, it
> > > dumps a lot of warnings.
> >
> > It shouldn't dump much more than the regular OOM report AFAICS. Sure
> > there is "Out of memory and no killable processes..." message printed as
> > well but is that a real problem?
> >
> > > Deleting a memcg does not reclaim memory from it and the memory can
> > > linger till there is a memory pressure. One normal way to proactively
> > > reclaim such memory is to set memory.max to 0 just before deleting the
> > > memcg. However if some of the memcg's memory is pinned by others, this
> > > operation can trigger an oom-kill without any process and thus can log a
> > > lot un-needed warnings. So, ignore all such warnings from memory.max.
> >
> > OK, I can see why you might want to use memory.max for that purpose but
> > I do not really understand why the oom report is a problem here.
> 
> It may not be a problem for an individual or small scale deployment
> but when "sweep before tear down" is the part of the workflow for
> thousands of machines cycling through hundreds of thousands of cgroups
> then we can potentially flood the logs with not useful dumps and may
> hide (or overflow) any useful information in the logs.

If you are doing this in a large scale and the oom report is really a
problem then you shouldn't be resetting hard limit to 0 in the first
place.

> > memory.max can trigger the oom kill and user should be expecting the oom
> > report under that condition. Why is "no eligible task" so special? Is it
> > because you know that there won't be any tasks for your particular case?
> > What about other use cases where memory.max is not used as a "sweep
> > before tear down"?
> 
> What other such use-cases would be? The only use-case I can envision
> of adjusting limits dynamically of a live cgroup are resource
> managers. However for cgroup v2, memory.high is the recommended way to
> limit the usage, so, why would resource managers be changing
> memory.max instead of memory.high? I am not sure. What do you think?

There are different reasons to use the hard limit. Mostly to contain
potential runaways. While high limit might be a sufficient measure to
achieve that as well the hard limit is the last resort. And it clearly
has the oom killer semantic so I am not really sure why you are
comparing the two.

> FB is moving away from limits setting, so, not sure if they have
> thought of these cases.
> 
> BTW for such use-cases, shouldn't we be taking the memcg's oom_lock?

This is a good question. I would have to go and double check the code
but I suspect that this is an omission.
-- 
Michal Hocko
SUSE Labs
