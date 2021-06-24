Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9C93B34F7
	for <lists+cgroups@lfdr.de>; Thu, 24 Jun 2021 19:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbhFXRsz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Jun 2021 13:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhFXRsw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Jun 2021 13:48:52 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CB3C061574
        for <cgroups@vger.kernel.org>; Thu, 24 Jun 2021 10:46:31 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id i6so5839491pfq.1
        for <cgroups@vger.kernel.org>; Thu, 24 Jun 2021 10:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=znmbspe43gdGgRV/upQrZxOnaNJ/GmfYqjXiwM9oleo=;
        b=ELA+YbvkUh75ll+mDif4Kq+XgYyX0/XvX6qHn5DIZ3JSdG7TIpCzYTJ7CNH0KRs3JQ
         Qgkx5zASyU7ccV7yFcYLKO98UIOlSU5t+3oC08J51aQ6VDKmSsmosrLP5mK5XKZH4DOB
         rc3sA+6PfyO7SBkqCTHaxwRQ27zE+saKJVPSYZHYjWq2lEfUYOLFqXc2sZ2Ik+iPfLd1
         +PNPOaXQeDUQOdkgYW1f99+LpTjBPMyir979HxcahAH9czGxYic2o+kRWVQPLdp7iHiA
         dkMXuOkUP8YzBUGP5HW3nSC2tU3ODM4u6gwHL+4RLZB1cqymZxwwHxcn0u5rX2uf3IqK
         neKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=znmbspe43gdGgRV/upQrZxOnaNJ/GmfYqjXiwM9oleo=;
        b=priuB85vUHf/EV81K7bVzIAQhDzun4aDPWRnJxBN6Fl2Gzpdea4JxjhYmRXDh4979A
         3h1mhRJ29zg9n9oL1Em0cAB+UE/4vg2DJK2qowLf1Hv3nxtoQlFCD4Qg7vg1989V/6gI
         bYvhueo+p8+uPz0WUzxGHHcX2xb9SNhQfrX2tOgZxmZzPrAsMEJgScrBb3sIGSTSBne5
         FyHDUzp1xVWEMglTk8TXgvv1ZTy8e/F2+AtH+/lPDn1s64ITH8XkBv2xTT1/CbxEDcVk
         exHzIltTnWFGR5p5lxyQkO5obHkvfMHxJcwPg7wUEzg5pPS2IOepKAslqTPYCublshlf
         bo/g==
X-Gm-Message-State: AOAM532/3ViXa7AZBRLhcAQdaRXOYXZQP+eHlwxYzAUKPjhNhXhx47Bl
        iT+MzWhyhOS5XLl4/U1zwcjjGQ==
X-Google-Smtp-Source: ABdhPJxf+CO3FV4JwefrjcjX8xn2R1SEQls6s7OcO66HWYSqfY+is1vM4MpBeNGGwNYjEfn94z3eKg==
X-Received: by 2002:a62:830e:0:b029:306:3c52:2a74 with SMTP id h14-20020a62830e0000b02903063c522a74mr6305156pfe.50.1624556791303;
        Thu, 24 Jun 2021 10:46:31 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:52cc])
        by smtp.gmail.com with ESMTPSA id x6sm8861654pjn.53.2021.06.24.10.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 10:46:30 -0700 (PDT)
Date:   Thu, 24 Jun 2021 13:46:27 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] memcg: periodically flush the memcg stats
Message-ID: <YNTE88wHs4Ac/DKp@cmpxchg.org>
References: <20210615174435.4174364-1-shakeelb@google.com>
 <20210615174435.4174364-2-shakeelb@google.com>
 <YMj/s26uF+cQOB2D@cmpxchg.org>
 <CALvZod6Hpema0uMcnMGPS+_2iZuxc8JqkjHRVBeEGp-vdcpPYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6Hpema0uMcnMGPS+_2iZuxc8JqkjHRVBeEGp-vdcpPYA@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hey Shakeel,

Sorry about the delay.

On Tue, Jun 15, 2021 at 02:52:37PM -0700, Shakeel Butt wrote:
> On Tue, Jun 15, 2021 at 12:29 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > The way the global vmstat implementation manages error is doing both:
> > ratelimiting and timelimiting. It uses percpu batching to limit the
> > error when it gets busy, and periodic flushing to limit the length of
> > time consumers of those stats could be stuck trying to reach a state
> > that the batching would otherwise prevent from being reflected.
> >
> > Maybe we can use a combination of ratelimiting and timelimiting too?
> >
> > We shouldn't flush on every fault, but what about a percpu ratelimit
> > that would at least bound the error to NR_CPU instead of nr_cgroups?
> >
> 
> Couple questions here:
> 
> First, to convert the error bound to NR_CPU from nr_cgroups, I think
> we have to move from (delta > threshold) comparison to
> (num_update_events > threshold). Previously an increment event
> followed by decrement would keep the delta to 0 (or same) but after
> this change num_update_events would be 2. Is that ok?

Yeah, I think that's fine. Or at least I can't think of a real-world
application that would inc and dec the same counter over and over and
so would do much better with delta spilling over event ratelimiting.

And the ratelimiting should already ensure by itself that the cost is
at least acceptable when continuously updating and reading counters.

> Second, do we want to synchronously flush the stats when we cross the
> threshold on update or asynchronously by queuing the flush with zero
> delay?

I think flushing by worker is better because we can see updates from
all sorts of contexts with all sorts of locks held. That could make
for some difficult dependencies and latency sources when serializing
those on cgroup_rstat_lock.
