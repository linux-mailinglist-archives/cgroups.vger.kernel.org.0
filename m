Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C46918C32F
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2020 23:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgCSWqA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Mar 2020 18:46:00 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44647 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbgCSWqA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Mar 2020 18:46:00 -0400
Received: by mail-qt1-f194.google.com with SMTP id y24so3388369qtv.11
        for <cgroups@vger.kernel.org>; Thu, 19 Mar 2020 15:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hg6/XErwieCbKEfwaK23H7KvFdhoOokx+O1ndfHjdpU=;
        b=K35Xul1BPwATBVYVGK1BzNwg1AfbzIoEMcMIYFIqZpTfU1JbG3He3l99NhGYwgWPbs
         u+xfPnUrH81APCqnVXY50nhKQe+ibkMS6ecDck1xrFL/vkqdoUZAXjGM5K5s03HW0Aoa
         AV5WoC6OrOCmXVwZewxhhuhbjcgCsDJIrX+EQ2xk5snNqTolW+uP+GRkYkobmARhQsUa
         MX6rxQVC9wEFCyXiEKPNjK2a/ofXMo0ny2KPnalzfVm81aV/W8CND2olyxDgGBeJd/jw
         dD3iSNij3AxA+/LNEFdtOU91evmTLVH+cdGxvLXoCkeAy4wDv4TFfwKjhecSF6aMb0Wb
         kvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hg6/XErwieCbKEfwaK23H7KvFdhoOokx+O1ndfHjdpU=;
        b=UdY0mfiSD6Wd0cGI6kVWqpwJa0ex7ZyBimqLDmEpABSECUdfuLwtkJqAm1Q0Dn1TPY
         6tUjCFz5C4WsDF/LcoHn7OKVbnavpnDmg6OKAHaQh6vzI2rU81VXntGFc9qpMurxvfds
         vpAXDMsSAWzlN8cY9QNt/L9igmVEaNzyFJs+WPICaaFTng7ky9TuEEcc858MtUt4bxu1
         tnjQCujUeMaHJdgrWkPYu4zxf5pkFgD3+rW1Jc0MWJB7Z3LWJ+VswAZbVvnotff6ZPJx
         WLBMNeNyBGKUtBRxtITy8JFF49dTGCwdHVYNgRTFDmaJQ/GCKmW/gQfvWLjx0O8jZ8NE
         7HLQ==
X-Gm-Message-State: ANhLgQ3NmsvbJeptQZZE0Q7X6JDam2rjWAoyTLvJnYl97bb5KkBE7Dfn
        r+mCNUAIJb1D4F7T/pqQy/XAqfz7H6f5OCVk2iDjKw==
X-Google-Smtp-Source: ADFU+vuXEDkZdqwcA6ixqZ1MJr03UDx5UVIrRa+dLF75K2KQgFf3jrcjivNnTNOHve786HRh0iyHi2Aa1IvSOWXmc3U=
X-Received: by 2002:ac8:47cc:: with SMTP id d12mr5510636qtr.234.1584657958214;
 Thu, 19 Mar 2020 15:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200311010113.136465-1-joshdon@google.com> <20200311140533.pclgecwhbpqzyrks@e107158-lin.cambridge.arm.com>
 <20200317192401.GE20713@hirez.programming.kicks-ass.net> <CABk29NuAYvkqNmZZ6cjZBC6=hv--2siPPjZG-BUpNewxm02O6A@mail.gmail.com>
 <20200318113456.3h64jpyb6xiczhcj@e107158-lin.cambridge.arm.com>
In-Reply-To: <20200318113456.3h64jpyb6xiczhcj@e107158-lin.cambridge.arm.com>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 19 Mar 2020 15:45:47 -0700
Message-ID: <CABk29NvvJCYyEnEkDt4JgZacf6XLd+0wxx_BNGnX8oZcrBp4EA@mail.gmail.com>
Subject: Re: [PATCH v2] sched/cpuset: distribute tasks within affinity masks
To:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 18, 2020 at 4:35 AM Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 03/17/20 14:35, Josh Don wrote:
> > On Wed, Mar 11, 2020 at 7:05 AM Qais Yousef <qais.yousef@arm.com> wrote:
> > >
> > > It might be a good idea to split the API from the user too.
> >
> > Not sure what you mean by this, could you clarify?
>
> I meant it'd be a good idea to split the cpumask API into its own patch and
> have a separate patch for the user in sched/core.c. But that was a small nit.
> If the user (in sched/core.c) somehow introduces a regression, reverting it
> separately should be trivial.
>
> Thanks

Ah, yes I agree that sounds like a good idea, I can do that.

Peter, any other nit before I re-send?
