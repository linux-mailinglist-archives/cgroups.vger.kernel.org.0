Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E629F4229D5
	for <lists+cgroups@lfdr.de>; Tue,  5 Oct 2021 16:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbhJEOCi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Oct 2021 10:02:38 -0400
Received: from relay.sw.ru ([185.231.240.75]:33224 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235734AbhJEOB6 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 5 Oct 2021 10:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=Ed1xsp8lTrCrW27f1J4vH57YUUHw0q5d5pOknhx3OhI=; b=dlg9oxUUL9ON2P7NI
        FPotPplwDm0pN9yRtW6uR6cImMJygenILBxuPbXKwHqwkrR4Xsm7PM70jOo1HQjb2RHaPSRAf8sNN
        43yHyfSpf5DwKO2Vlo3GxDZ1spky8JiojDNWL2JimTvGua0MPzIGIEIvEsmMJTyevyQJZawJhUsLI
        =;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mXkzF-0054Yv-SG; Tue, 05 Oct 2021 17:00:05 +0300
Subject: Re: [PATCH mm v2] vmalloc: back off when the current task is
 OOM-killed
From:   Vasily Averin <vvs@virtuozzo.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
References: <YVGmMSJ3NrQZjLP8@dhcp22.suse.cz>
 <83efc664-3a65-2adb-d7c4-2885784cf109@virtuozzo.com>
Message-ID: <dd6f3cc5-70f3-4275-6458-118c463bf38a@virtuozzo.com>
Date:   Tue, 5 Oct 2021 17:00:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <83efc664-3a65-2adb-d7c4-2885784cf109@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/5/21 4:52 PM, Vasily Averin wrote:
> Huge vmalloc allocation on heavy loaded node can lead to a global
> memory shortage. Task called vmalloc can have worst badness and
> be selected by OOM-killer, however taken fatal signal does not
> interrupt allocation cycle. Vmalloc repeat page allocaions
> again and again, exacerbating the crisis and consuming the memory
> freed up by another killed tasks.
> 
> After a successful completion of the allocation procedure, a fatal
> signal will be processed and task will be destroyed finally.
> However it may not release the consumed memory, since the allocated
> object may have a lifetime unrelated to the completed task.
> In the worst case, this can lead to the host will panic
> due to "Out of memory and no killable processes..."
> 
> This patch allows OOM-killer to break vmalloc cycle, makes OOM more
> effective and avoid host panic. It does not check oom condition directly,
> however, and breaks page allocation cycle when fatal signal was received.
> 
> This may trigger some hidden problems, when caller does not handle
> vmalloc failures, or when rollaback after failed vmalloc calls own
> vmallocs inside. However all of these scenarios are incorrect:
> vmalloc does not guarantee successful allocation, it has never been called
> with __GFP_NOFAIL and threfore either should not be used for any rollbacks
> or should handle such errors correctly and not lead to critical
> failures.

I briefly checked this patch together with 
 v3 memcg: prohibit unconditional exceeding the limit of dying tasks
 over v5.15-rc4.
I executed LTP on host, all oom, cgroup and memcg tests was successfully finished.
and then experimented with memcg limited LXC containers.
I did not noticed any troubles on my test node.
Thank you,
	Vasily Averin
