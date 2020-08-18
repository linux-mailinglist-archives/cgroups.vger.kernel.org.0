Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC53C2481A2
	for <lists+cgroups@lfdr.de>; Tue, 18 Aug 2020 11:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgHRJPR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 Aug 2020 05:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgHRJPQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 Aug 2020 05:15:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD81BC061389;
        Tue, 18 Aug 2020 02:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UBwdQabxborBnUE/RMGD20d7Ru/Oheb0wmXWjUiC0/E=; b=YbqYH54dJpbZukfJbcHBX5gIe6
        4fGR1JnoO2J5ou9rqay98pZf09b2sJvtXYzco+ShIGTbQCUJanYELbMUIKzdUJp8m6gqGDh2Vy5dz
        Z85kRmbOcs2R9yO6b+qiXnRvxaiEOIVu1SfG+AZ1aEeGjWd8zXPOHQnLG0G/xaBKWZcnjPHK5THwY
        NUFDfGvip/hUyZNwCTe8rH2KlZoyzIbkjSr4WisborRSryZSeC0mSG/mHjMtr6YgsnrQ7qlP834T9
        2AXdgEs4etYbr2acZv2wBRyLfyez9vj90z97qq/VvNlLitUCukARb3errqkqzDH0jEAYtn4LMlLjg
        uY4c2NiA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7xhs-000568-8H; Tue, 18 Aug 2020 09:15:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7C4093060F2;
        Tue, 18 Aug 2020 11:14:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 293DB2BDBFE38; Tue, 18 Aug 2020 11:14:53 +0200 (CEST)
Date:   Tue, 18 Aug 2020 11:14:53 +0200
From:   peterz@infradead.org
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/8] memcg: Enable fine-grained per process memory
 control
Message-ID: <20200818091453.GL2674@hirez.programming.kicks-ass.net>
References: <20200817140831.30260-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817140831.30260-1-longman@redhat.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 17, 2020 at 10:08:23AM -0400, Waiman Long wrote:
> Memory controller can be used to control and limit the amount of
> physical memory used by a task. When a limit is set in "memory.high" in
> a v2 non-root memory cgroup, the memory controller will try to reclaim
> memory if the limit has been exceeded. Normally, that will be enough
> to keep the physical memory consumption of tasks in the memory cgroup
> to be around or below the "memory.high" limit.
> 
> Sometimes, memory reclaim may not be able to recover memory in a rate
> that can catch up to the physical memory allocation rate. In this case,
> the physical memory consumption will keep on increasing. 

Then slow down the allocator? That's what we do for dirty pages too, we
slow down the dirtier when we run against the limits.

