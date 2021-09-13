Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A833640867E
	for <lists+cgroups@lfdr.de>; Mon, 13 Sep 2021 10:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbhIMIa4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 04:30:56 -0400
Received: from relay.sw.ru ([185.231.240.75]:56614 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234575AbhIMIa4 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 13 Sep 2021 04:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=hQgKXyWNPvle3hQKqsfae85Qw8UvU0A7uIpON9jfF6c=; b=S66sreVvkhtAHXlkX
        3SJin2YhAz6QeFhEq7J7kxn/rGoVZWl2UkW9Eu3DJAfRVRKeHYZoR6NOCDu/WxkuytAfsKdYnQUk1
        ZILk96zL8+M9MErZOpzrFJv0js8EdDQdJhzo8qlnfrLleAeUvEbpKSjx5c37qiI4EgHaSkT2AHxzo
        =;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mPhLO-001nZm-35; Mon, 13 Sep 2021 11:29:38 +0300
Subject: Re: [PATCH memcg] memcg: prohibit unconditional exceeding the limit
 of dying tasks
To:     Michal Hocko <mhocko@suse.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <5b06a490-55bc-a6a0-6c85-690254f86fad@virtuozzo.com>
 <099aa0db-045a-e5b8-6df7-b7c3fc4d3caa@i-love.sakura.ne.jp>
 <4a407474-ff7a-9e4f-d314-ab85f0eeaadf@virtuozzo.com>
 <YTtx3toUOMLXk4GZ@dhcp22.suse.cz>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <9556c2ae-2dc8-9d0a-55de-002d674680bf@virtuozzo.com>
Date:   Mon, 13 Sep 2021 11:29:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTtx3toUOMLXk4GZ@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/10/21 5:55 PM, Michal Hocko wrote:
> On Fri 10-09-21 16:20:58, Vasily Averin wrote:
>> On 9/10/21 4:04 PM, Tetsuo Handa wrote:
>>> Can't we add fatal_signal_pending(current) test to vmalloc() loop?
> 
> We can and we should.
> 
>> 1) this has been done in the past but has been reverted later.
> 
> The reason for that should be addressed IIRC.

I don't know the details of this, and I need some time to investigate it.

>> 2) any vmalloc changes will affect non-memcg allocations too.
>>  If we're doing memcg-related checks it's better to do it in one place.
> 
> I think those two things are just orthogonal. Bailing out from vmalloc
> early sounds reasonable to me on its own. Allocating a large thing that
> is likely to go away with the allocating context is just a waste of
> resources and potential reason to disruptions to others.

I doubt that fatal signal should block any vmalloc allocations.
I assume there are situations where rollback of some cancelled operation uses vmalloc.
Or coredump saving on some remote storage can uses vmalloc.

However for me it's abnormal that even OOM-killer cannot cancel huge vmalloc allocation.
So I think tsk_is_oom_victim(current) check should be added to vm_area_alloc_pages() 
to break vmalloc cycle.

Thank you,
	Vasily Averin
