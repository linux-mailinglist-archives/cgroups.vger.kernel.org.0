Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B06C32D064
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2019 22:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfE1UcV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 May 2019 16:32:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44750 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfE1UcV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 May 2019 16:32:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id g9so12184028pfo.11
        for <cgroups@vger.kernel.org>; Tue, 28 May 2019 13:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6BVjplRJjVAtzerMfL/A1WtErQukGLzsV7QIdL5tHLg=;
        b=jALHoOYbd78sWqXXZgYaR8eLxuPF63IYkarb8Baf2n7TaE6XnnepYOIMqCLibAQqG/
         0ZJcwCe35su/Un1bvTKr+H9yfbCkChIWYtLnHoLbFPQ+U51SOhGPOu4PDiNGWKDyuQHL
         0/Bh3Wz253mmN/utA/8DiIGX5r6qBJPfGgk2oct7Uvpyn5Aq64Mj1G8+uxa7XdNfHW+L
         8fhCvz7JKJm3Xx8NvpGLGFD4eU7BVn/g6ehW/Z+dcsnVXOV+p0CbvsIyL5hTi4cc4/M+
         4pbItZvCXZDDcetGaQGkGh6Bfg4tzcbzzSbFPSqysI8fYYPgfmUXhZy7tlj2NzsFGGpx
         tXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6BVjplRJjVAtzerMfL/A1WtErQukGLzsV7QIdL5tHLg=;
        b=LYsR9sKEj13tK7IAxEJehCC7bYOVA3tVCZQpgeemRaVWNn2dKmk2SkrjVhJa6RcYTM
         70btxSWcs/zxUPVTOv1h+WzyZ2mwt3Eyook9q60z2z6rA6v5i85q1QP4NNOAvYWh19uT
         6nDWhiNOKWdDfRJ8ojXutJibtM2BcM51S20FJhP705Ij0fT0MSeym8Jr1YoCXTo3LpUw
         AxnB5bSyRRFtoCGmlLm32AjoxX/vGGoNSYGQ+/oMZtaTVJnpzcqPlFbgyJHa9hlIbg1k
         8yhT1I9H+iAUSW1dh6D7dDqtd1pXVBkjjIzoeT2nlOkFYtSy4PSjfrfnqtkWJR2r52BF
         5YLw==
X-Gm-Message-State: APjAAAUULA9Zhv+tjcHvr3OHwJDhcYrKKV0tKGA9bytrRQr/x1kK/TAB
        kmDEUS+uHpwsFtHuRN6x05vstDsMPPs=
X-Google-Smtp-Source: APXvYqw0vMIiMqx3gefPlogq+TldEzNcR68Fc/ANu9jAbQ2F1nOLyVOiuJNwa6AgdrcS475hYpQKwQ==
X-Received: by 2002:a63:4f07:: with SMTP id d7mr83629540pgb.77.1559075540928;
        Tue, 28 May 2019 13:32:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:6316])
        by smtp.gmail.com with ESMTPSA id c15sm15664515pfi.172.2019.05.28.13.32.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 13:32:20 -0700 (PDT)
Date:   Tue, 28 May 2019 16:32:18 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <rong.a.chen@intel.com>, LKP <lkp@01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH] mm: memcontrol: don't batch updates of local VM stats
 and events
Message-ID: <20190528203218.GA20452@cmpxchg.org>
References: <20190520063534.GB19312@shao2-debian>
 <20190520215328.GA1186@cmpxchg.org>
 <20190521134646.GE19312@shao2-debian>
 <20190521151647.GB2870@cmpxchg.org>
 <CALvZod5KFJvfBfTZKWiDo_ux_OkLKK-b6sWtnYeFCY2ARiiKwQ@mail.gmail.com>
 <CAHk-=wgaLQjZ8AZj76_cwvk_wLPJjr+Dc=Qvac_vHY2RruuBww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgaLQjZ8AZj76_cwvk_wLPJjr+Dc=Qvac_vHY2RruuBww@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 28, 2019 at 10:37:15AM -0700, Linus Torvalds wrote:
> On Tue, May 28, 2019 at 9:00 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > I was suspecting the following for-loop+atomic-add for the regression.
> 
> If I read the kernel test robot reports correctly, Johannes' fix patch
> does fix the regression (well - mostly. The original reported
> regression was 26%, and with Johannes' fix patch it was 3% - so still
> a slight performance regression, but not nearly as bad).
> 
> > Why the above atomic-add is the culprit?
> 
> I think the problem with that one is that it's cross-cpu statistics,
> so you end up with lots of cacheline bounces on the local counts when
> you have lots of load.

In this case, that's true for both of them. The workload runs at the
root cgroup level, so per definition the local and the recursive
counters at that level are identical and written to at the same
rate. Adding the new counter obviously caused the regression, but
they're contributing equally to the cost, and we could
remove/per-cpuify either of them for the fix.

So why did I unshare the old counter instead of the new one? Well, the
old counter *used* to be unshared for the longest time, and was only
made into a shared one to make recursive aggregation cheaper - before
there was a dedicated recursive counter. But now that we have that
recursive counter, there isn't much reason to keep the local counter
shared and bounce it around on updates.

Essentially, this fix-up is a revert of a983b5ebee57 ("mm: memcontrol:
fix excessive complexity in memory.stat reporting") since the problem
described in that patch is now solved from the other end.

> But yes, the recursive updates still do show a small regression,
> probably because there's still some overhead from the looping up in
> the hierarchy. You still get *those* cacheline bounces, but now they
> are limited to the upper hierarchies that only get updated at batch
> time.

Right, I reduce the *shared* data back to how it was before the patch,
but it still adds a second (per-cpu) counter that needs to get bumped,
and the loop adds a branch as well.

But while I would expect that to show up in a case like will-it-scale,
I'd be surprised if the remaining difference would be noticeable for
real workloads that actually work with the memory they allocate.
