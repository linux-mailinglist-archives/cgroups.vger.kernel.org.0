Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30A51E6C8D
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2020 22:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407247AbgE1UaT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 May 2020 16:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407237AbgE1UaN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 May 2020 16:30:13 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C39C08C5C7
        for <cgroups@vger.kernel.org>; Thu, 28 May 2020 13:30:13 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id a23so167988qto.1
        for <cgroups@vger.kernel.org>; Thu, 28 May 2020 13:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L+uuww7KS91z0nXdlfs6K0/JqdQm8qFbzuFZ4bz09+E=;
        b=T4uR5w6goaSmuZxanF5ibEDLR8DFMtolK8czTkUsdCgVU67PtXlnMbDfpVYllqkPdI
         ApaK+UVOxphIh9ZQT/kWCm1zbqNmWRM1ksEGDCHEZCcVLh+z30c3RlIIDNlT7dt2nxK7
         2nkmg9EE4K1ZcS8zZYoUlOYOGI/2pvlmSrk3LIxjTVmqZE27/Fy99p/3ARprz8FNgs2B
         ZsNM2pMLHy64De2YYBpEgborefHSARHN9BYvXsZthJqYuQHlnmYjq2qWw0+nB2cy0Uy6
         FyfRDokq88+4H7WW13zWbxn43F+gkRR01F5iYVcLzpEm4XwU9Oqdv0i9njeXjCFft77e
         Rrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L+uuww7KS91z0nXdlfs6K0/JqdQm8qFbzuFZ4bz09+E=;
        b=C+1B3HGcvetr7Fahq8JugtKKP4z0D6TyBe/AVq73VTeTA083/8yhSHokF/eXz0to+e
         +5cDNn46HYeJ5pWPRbVUh4oFC6bdkLGC0VxGDQ1rkgJhVqJv4j0Z2gbVLiEBzeobMEG/
         qR7fz/kd+j+thpGNdsDgq0XxfDYPE+RfvqeLMkQ9YcjUi4lGXnoe1KweudnC7LvGSNUS
         fVAjnK9I2wrPQGAESlsx2/IEmzOmkRyHUQKq4X10/wZzMvpPhvBZzJzgiPk7Lo8U2Je9
         oq2OTYR5v3PPm5UUTbMFMymwYMim49ZuLTkhtkC3YqSo3F+i28rRKA58a4ePZDZtOC5K
         BydA==
X-Gm-Message-State: AOAM531qWMe8n0tQUt1hbJ2fnByx80ubUNXXLlF1C+RGyuNGyDbuE5DO
        /nkqgI4B1GfDuKFNT7tXhRlERQ==
X-Google-Smtp-Source: ABdhPJxu0NvCcg7BPhIDHEyV78qHQ2Lv1ChfGwNkXc/GzQb9QH2RK6tfuAWXO0ql1bNWRQ4DQU5mog==
X-Received: by 2002:aed:23d2:: with SMTP id k18mr5279451qtc.224.1590697812736;
        Thu, 28 May 2020 13:30:12 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2535])
        by smtp.gmail.com with ESMTPSA id c191sm5965436qke.114.2020.05.28.13.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 13:30:12 -0700 (PDT)
Date:   Thu, 28 May 2020 16:29:44 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200528202944.GA76514@cmpxchg.org>
References: <20200520143712.GA749486@chrisdown.name>
 <CALvZod7rSeAKXKq_V0SggZWn4aL8pYWJiej4NdRd8MmuwUzPEw@mail.gmail.com>
 <20200528194831.GA2017@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528194831.GA2017@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 28, 2020 at 08:48:31PM +0100, Chris Down wrote:
> Shakeel Butt writes:
> > What was the initial reason to have different behavior in the first place?
> 
> This differing behaviour is simply a mistake, it was never intended to be
> this deviate from what happens elsewhere. To that extent this patch is as
> much a bug fix as it is an improvement.

Yes, it was an oversight.

> > >  static void high_work_func(struct work_struct *work)
> > > @@ -2378,16 +2384,20 @@ void mem_cgroup_handle_over_high(void)
> > >  {
> > >         unsigned long penalty_jiffies;
> > >         unsigned long pflags;
> > > +       unsigned long nr_reclaimed;
> > >         unsigned int nr_pages = current->memcg_nr_pages_over_high;
> > 
> > Is there any benefit to keep current->memcg_nr_pages_over_high after
> > this change? Why not just use SWAP_CLUSTER_MAX?

It's there for the same reason why try_to_free_pages() takes a reclaim
argument in the first place: we want to make the thread allocating the
most also do the most reclaim work. Consider a thread allocating THPs
in a loop with another thread allocating regular pages.

Remember that all callers loop. They could theoretically all just ask
for SWAP_CLUSTER_MAX pages over and over again.

The idea is to have fairness in most cases, and avoid allocation
failure, premature OOM, and containment failure in the edge cases that
are caused by the inherent raciness of page reclaim.

> I don't feel strongly either way, but current->memcg_nr_pages_over_high can
> be very large for large allocations.
> 
> That said, maybe we should just reclaim `max(SWAP_CLUSTER_MAX, current -
> high)` for each loop? I agree that with this design it looks like perhaps we
> don't need it any more.
> 
> Johannes, what do you think?

How about this:

Reclaim memcg_nr_pages_over_high in the first iteration, then switch
to SWAP_CLUSTER_MAX in the retries.

This acknowledges that while the page allocator and memory.max reclaim
every time an allocation is made, memory.high is currently batched and
can have larger targets. We want the allocating thread to reclaim at
least the batch size, but beyond that only what's necessary to prevent
premature OOM or failing containment.

Add a comment stating as much.

Once we reclaim memory.high synchronously instead of batched, this
exceptional handling is no longer needed and can be deleted again.

Does that sound reasonable?
