Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0899D4A6023
	for <lists+cgroups@lfdr.de>; Tue,  1 Feb 2022 16:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240333AbiBAP3g (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Feb 2022 10:29:36 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59424 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240294AbiBAP3g (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Feb 2022 10:29:36 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7FB222110A;
        Tue,  1 Feb 2022 15:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643729375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zSBg3nPWuNIwbLhGHez+BKTr0BYdn5qn2z9ShJZjgw8=;
        b=r9uApZUC2gSP8IWVhMEXOBCd81yy+Rrx+VyO5jX55MI1A0eqMr6RgEcnASEW/oOxPXo0dy
        Os/1BBc6LyHfW8ISc8Oc1cDkOi5TC+kFpwKWio/8eOK8RocMKYsP3j6FqFwH6X/0HljnYc
        YnP3+cnHuO5EXywFEEZEJsBTfBd4eIQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6A1AEA3B84;
        Tue,  1 Feb 2022 15:29:35 +0000 (UTC)
Date:   Tue, 1 Feb 2022 16:29:35 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Waiman Long <longman@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH 3/4] mm/memcg: Add a local_lock_t for IRQ and TASK object.
Message-ID: <YflR3/RuGjYuQZPH@dhcp22.suse.cz>
References: <20220125164337.2071854-1-bigeasy@linutronix.de>
 <20220125164337.2071854-4-bigeasy@linutronix.de>
 <YfFmxH1IXeegNOa9@dhcp22.suse.cz>
 <YfKHxKda7bGJmrLJ@linutronix.de>
 <YfkhsiWHzsyQSBfl@dhcp22.suse.cz>
 <Yfkjjamj09lZn4sA@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yfkjjamj09lZn4sA@linutronix.de>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 01-02-22 13:11:57, Sebastian Andrzej Siewior wrote:
> On 2022-02-01 13:04:02 [+0100], Michal Hocko wrote:
> > 
> > Thanks! This gives us some picture from the microbenchmark POV. I was
> > more interested in some real life representative benchmarks. In other
> > words does the optimization from Weiman make any visible difference for
> > any real life workload?
> 
> my understanding is that this was micro-benchmark driven.

Weiman was this driven by any real world workload?

> > Sorry, I know that this all is not really related to your work but if
> > the original optimization is solely based on artificial benchmarks then
> > I would rather drop it and also make your RT patchset easier.
> 
> Do you have any real-world benchmark in mind? Like something that is
> already used for testing/ benchmarking and would fit here?

Anything that even remotely resembles a real allocation heavy workload.

-- 
Michal Hocko
SUSE Labs
