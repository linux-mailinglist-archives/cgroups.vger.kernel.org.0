Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCFF3178725
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2020 01:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgCDArB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Mar 2020 19:47:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:54830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727725AbgCDArB (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 3 Mar 2020 19:47:01 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B8A8206D5;
        Wed,  4 Mar 2020 00:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583282820;
        bh=0+z7LmhvpR+/tgnsx78xZlf6Xtp1MPhvcA49EP7cCI8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gZdLAc3WmWRNXUh+LZD6fQ5PyaHfnkDYaLIo61uBfxx0u8qzP2R4ycU1QbdfHqXGt
         J+vL7N6dGXfyeVQAmdm1/Q/isaW3dosacn6BLaG1+8JZhMSJt2zoPP+NvcFbOtPJVU
         ReV40WQ5Vda3VQTcXJHT1TrT5dMjuCAkxdt0+EEg=
Date:   Tue, 3 Mar 2020 16:46:59 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v9 07/20] mm/lru: introduce TestClearPageLRU
Message-Id: <20200303164659.b3a30ab9d68c9ed82299a29c@linux-foundation.org>
In-Reply-To: <9cacdc21-9c1f-2a17-05cb-e9cf2959cef5@linux.alibaba.com>
References: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
        <1583146830-169516-8-git-send-email-alex.shi@linux.alibaba.com>
        <20200302141144.b30abe0d89306fd387e13a92@linux-foundation.org>
        <9cacdc21-9c1f-2a17-05cb-e9cf2959cef5@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 3 Mar 2020 12:11:34 +0800 Alex Shi <alex.shi@linux.alibaba.com> wrote:

> 
> 
> 在 2020/3/3 上午6:11, Andrew Morton 写道:
> >> -		if (PageLRU(page)) {
> >> +		if (TestClearPageLRU(page)) {
> >>  			lruvec = mem_cgroup_page_lruvec(page, pgdat);
> >> -			ClearPageLRU(page);
> >>  			del_page_from_lru_list(page, lruvec, page_lru(page));
> >>  		} else
> > 
> > The code will now get exclusive access of the page->flags cacheline and
> > will dirty that cacheline, even for !PageLRU() pages.  What is the
> > performance impact of this?
> > 
> 
> Hi Andrew,
> 
> Thanks a lot for comments!
> 
> I was tested the whole patchset with fengguang's case-lru-file-readtwice
> https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/
> which is most sensitive case on PageLRU I found. There are no clear performance
> drop.
> 
> On this single patch, I just test the same case again, there is still no perf
> drop. some data is here on my 96 threads machine:
> 
> 		no lock_dep	w lock_dep and few other debug option
> w this patch, 	50.96MB/s		32.93MB/s
> w/o this patch, 50.50MB/s		33.53MB/s
> 
> 

Well, any difference would be small and the numbers did get a bit
lower, albeit probably within the margin of error.

But you know, if someone were to send a patch which micro-optimized
some code by replacing 'TestClearXXX()' with `if PageXXX()
ClearPageXXX()', I would happily merge it!

Is this change essential to the overall patchset?  If not, I'd be
inclined to skip it?

