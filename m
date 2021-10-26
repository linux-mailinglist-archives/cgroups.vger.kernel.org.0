Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD7043B378
	for <lists+cgroups@lfdr.de>; Tue, 26 Oct 2021 15:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbhJZN7z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Oct 2021 09:59:55 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:60125 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236345AbhJZN7w (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Oct 2021 09:59:52 -0400
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 19QDulsa003967;
        Tue, 26 Oct 2021 22:56:47 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Tue, 26 Oct 2021 22:56:47 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 19QDukhj003946
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 26 Oct 2021 22:56:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <62a326bc-37d2-b8c9-ddbf-7adaeaadf341@i-love.sakura.ne.jp>
Date:   Tue, 26 Oct 2021 22:56:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH memcg v3 2/3] mm, oom: do not trigger out_of_memory from
 the #PF
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vasily Averin <vvs@virtuozzo.com>, Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <YXJ/63kIpTq8AOlD@dhcp22.suse.cz>
 <cover.1634994605.git.vvs@virtuozzo.com>
 <f5fd8dd8-0ad4-c524-5f65-920b01972a42@virtuozzo.com>
 <e2a847a2-a414-2535-e3d1-b100a023b9d1@i-love.sakura.ne.jp>
 <YXZk9Lr217e+saSM@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <YXZk9Lr217e+saSM@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021/10/25 17:04, Michal Hocko wrote:
> I do not think there is any guarantee. This code has meant to be a
> safeguard but it turns out to be adding more harm than a safety. There
> are several scenarios mentioned in this thread where this would be
> counter productive or outright wrong thing to do.

Setting PR_IO_FLUSHER via prctl(PR_SET_IO_FLUSHER) + hitting legacy kmem
charge limit might be an unexpected combination?

> 
> On the other hand it is hard to imagine any legitimate situation where
> this would be a right thing to do. Maybe you have something more
> specific in mind? What would be the legit code to rely on OOM handling
> out of the line (where the details about the allocation scope is lost)?

I don't have specific scenario, but I feel that it might be a chance to
retry killable vmalloc(). Commit b8c8a338f75e ("Revert "vmalloc: back off
when the current task is killed"") was 4.5 years ago, and fuzz testing found
many bugs triggered by memory allocation fault injection. Thus, I think that
the direction is going towards "we can fail memory allocation upon SIGKILL
(rather than worrying about depleting memory reserves and/or escalating to
global OOM killer invocations)". Most memory allocation requests which
allocate memory for userspace process are willing to give up upon SIGKILL.

Like you are trying to add NOFS, NOIO, NOFAIL support to vmalloc(), you could
consider KILLABLE support as well. Of course, direct reclaim makes it difficult
to immediately give up upon SIGKILL, but killable allocation sounds still nice
even if best-effort basis.

