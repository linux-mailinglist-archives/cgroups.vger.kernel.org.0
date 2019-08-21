Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7058B96EC4
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2019 03:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfHUBVW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Aug 2019 21:21:22 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:56133 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726202AbfHUBVW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Aug 2019 21:21:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Ta0SZIU_1566350478;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Ta0SZIU_1566350478)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 21 Aug 2019 09:21:19 +0800
Subject: Re: [PATCH 00/14] per memcg lru_lock
To:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@kernel.org>
Cc:     Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Yu Zhao <yuzhao@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
References: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com>
 <20190820104532.GP3111@dhcp22.suse.cz>
 <CALvZod7-dL90jwd2pywpaD8NfUByVU9Y809+RfvJABGdRASYUg@mail.gmail.com>
 <alpine.LSU.2.11.1908201038260.1286@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <319c7a6c-6f1a-64c5-4920-e8279eb1e80b@linux.alibaba.com>
Date:   Wed, 21 Aug 2019 09:21:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.1908201038260.1286@eggly.anvils>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> 
> Thanks for the Cc Michal.  As Shakeel says, Google prodkernel has been
> using our per-memcg lru locks for 7 years or so.  Yes, we did not come
> up with supporting performance data at the time of posting, nor since:
> I see Alex has done much better on that (though I haven't even glanced
> to see if +s are persuasive).
> 
> https://lkml.org/lkml/2012/2/20/434
> was how ours was back then; some parts of that went in, then attached
> lrulock417.tar is how it was the last time I rebased, to v4.17.
> 
> I'll set aside what I'm doing, and switch to rebasing ours to v5.3-rc
> and/or mmotm.  Then compare with what Alex has, to see if there's any
> good reason to prefer one to the other: if no good reason to prefer ours,
> I doubt we shall bother to repost, but just use it as basis for helping
> to review or improve Alex's.
> 

Thanks for you all! Very glad to see we are trying on same point. :)
Not only on per memcg lru_lock, there are much room on lru and page replacement
tunings. Anyway Hope to see your update and more review comments soon.

Thanks
Alex
