Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A6542E037
	for <lists+cgroups@lfdr.de>; Thu, 14 Oct 2021 19:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhJNRp1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Oct 2021 13:45:27 -0400
Received: from relay.sw.ru ([185.231.240.75]:37442 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231853AbhJNRp1 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 14 Oct 2021 13:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=eD7O+RRWLIkfKyTJ6TKMyILhSbZVJ9w0wV/dWtK5Dv0=; b=chOijwLa4Moa5XyKb
        NTr/9oJ/r8pthIDIG2J4jg3zwc7oEUg3K1Dt4kuMmIvnnpl51iX5bHSlyA5r+UStbj4vPx3i5rW5c
        VjuKA6U1viK2KmSz8Wf01Tb+ZwUo2NgiL0niYCBDTJ0/h5mPerexOJJ9uBOLSGG2iF6zgUWCtXCsc
        =;
Received: from [172.29.1.17]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mb4lB-0062ie-69; Thu, 14 Oct 2021 20:43:17 +0300
Subject: Re: [PATCH] memcg: page_alloc: skip bulk allocator for __GFP_ACCOUNT
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Uladzislau Rezki <urezki@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20211013194338.1804247-1-shakeelb@google.com>
 <YWfZNF7T7Fm69sik@dhcp22.suse.cz>
 <CALvZod4Br9iwq-qfdwj6dzgW2g1vEr2YL4=w_mQjOeWWDQzFjw@mail.gmail.com>
 <YWhLeAL5RPfLjrlO@cmpxchg.org>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <f4fd9e5f-b054-41af-e8a8-7a3074f937d8@virtuozzo.com>
Date:   Thu, 14 Oct 2021 20:43:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YWhLeAL5RPfLjrlO@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 14.10.2021 18:23, Johannes Weiner wrote:
> On Thu, Oct 14, 2021 at 08:01:16AM -0700, Shakeel Butt wrote:
>> Regarding xfs_buf_alloc_pages(), it is not using __GFP_ACCOUNT
> 
> It probably should, actually. Sorry, somewhat off-topic, but we've
> seen this consume quite large amounts of memory. __GFP_ACCOUNT and
> vmstat tracking seems overdue for this one.

If this will be required, you can use
[PATCH mm v5] memcg: enable memory accounting in __alloc_pages_bulk
https://lkml.org/lkml/2021/10/14/197

As far as I understand it will not be used right now,
however I decided to submit it anyway, perhaps it may be needed later.

Thank you,
	Vasily Averin
