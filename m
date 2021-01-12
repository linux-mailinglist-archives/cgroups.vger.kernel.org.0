Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE09B2F3B4C
	for <lists+cgroups@lfdr.de>; Tue, 12 Jan 2021 20:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406706AbhALT4N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Jan 2021 14:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406694AbhALT4M (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Jan 2021 14:56:12 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5AEC061794
        for <cgroups@vger.kernel.org>; Tue, 12 Jan 2021 11:55:32 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id p14so3032824qke.6
        for <cgroups@vger.kernel.org>; Tue, 12 Jan 2021 11:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r3RcTfMe7SWAKR9ZPaILuwCLkjEw52kXwdvMKFbxE+Y=;
        b=xNb+jXyynOtMDGYrXvcjUcO1CyQWacGxvJvRvEKyedu3WJVOTOZbv25S2m8yr5PD/y
         esanXfysmROgybxXxP9XniQQQPP+U2ROGwezs7psAGDv45Xpm5aWrVI8oSxAVXF1XtCn
         j5i8fxDNcSlJlDnjAONEV3qx3q4PnJeW4KW1ON266+jtRWCH+DPrg2eRcpmlBAutB4/a
         zBURoO0FdYjVF4uJ1NUQ1lfOMejaHhbbPKJeIoEd394wvVxBNxnPBewf6fmWsbc25Qg+
         SDeiRf0JkL/dhE75JqCf1XLpbdDd2fNM/edlnqtoxuKLhsbdAoz1qszvoTfX+R/IRXXI
         yQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r3RcTfMe7SWAKR9ZPaILuwCLkjEw52kXwdvMKFbxE+Y=;
        b=AsDNfANpCaAux79X1+25e482rAUzRF+gieUlLfceAM/AHJYdQeco8iVZ0XekRwZQzo
         ARtacFqVHYxDtJwL0K6Q93xNH1xD4KJPuvTBMpac3m14CIuv/wFzfAJGg9GD+NQwjHbb
         4dGhX0+At745ts8grH5oo0zbmVaa+DJ0agMLV5laaQJk+OUN5qM3rgXzLkZhYETebeyU
         bhtGvOSQJDe+IpUmTlu83ubvbHFuJl+81eK5WDfJ94ovPIoI236f2p8Vwv8vp1SQLU02
         EHIQ4gydjADm65+Wh6bRKH2bY6kI4+Codcs+h+CM2jY+jT+c81nKNuDh1Z6iJjrQ5jtz
         rTHQ==
X-Gm-Message-State: AOAM5312aw9zz0LdZpU90+DEJZmjvqPpraKJSILbmWD2LLXkAHUQmJAO
        OH0wZJZu3RGSCKr315LssSasNw==
X-Google-Smtp-Source: ABdhPJwdUOjZbwgAjqIx7Tyovg//RyInPzy5cdF3Vi8RfEjZFc9IuJzEagAhiIGiiOsn5iaIARk4kA==
X-Received: by 2002:a37:6382:: with SMTP id x124mr1081695qkb.398.1610481331701;
        Tue, 12 Jan 2021 11:55:31 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:1fb4])
        by smtp.gmail.com with ESMTPSA id 127sm1937307qkj.51.2021.01.12.11.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 11:55:31 -0800 (PST)
Date:   Tue, 12 Jan 2021 14:53:06 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH] mm: memcontrol: prevent starvation when writing
 memory.high
Message-ID: <X/3+IgDVb+Jn4XfQ@cmpxchg.org>
References: <20210112163011.127833-1-hannes@cmpxchg.org>
 <CALvZod4VFA52dsdkW79-gUbiCf2ONfFJj6LkRU+3-fQpvYXL+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4VFA52dsdkW79-gUbiCf2ONfFJj6LkRU+3-fQpvYXL+A@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 12, 2021 at 10:59:58AM -0800, Shakeel Butt wrote:
> On Tue, Jan 12, 2021 at 9:12 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > When a value is written to a cgroup's memory.high control file, the
> > write() context first tries to reclaim the cgroup to size before
> > putting the limit in place for the workload. Concurrent charges from
> > the workload can keep such a write() looping in reclaim indefinitely.
> >
> 
> Is this observed on real workload?

Yes.

On several production hosts running a particularly aggressive
workload, we've observed writers to memory.high getting stuck for
minutes while consuming significant amount of CPU.

> Any particular reason to remove !reclaimed?

It's purpose so far was to allow successful reclaim to continue
indefinitely, while restricting no-progress loops to 'nr_retries'.

Without the first part, it doesn't really matter whether reclaim is
making progress or not: we do a maximum of 'nr_retries' loops until
the cgroup size meets the new limit, then exit one way or another.
