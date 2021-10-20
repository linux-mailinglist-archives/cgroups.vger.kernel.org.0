Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2B2434EEC
	for <lists+cgroups@lfdr.de>; Wed, 20 Oct 2021 17:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhJTPXL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Oct 2021 11:23:11 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:60121 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhJTPXJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Oct 2021 11:23:09 -0400
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 19KFK2FR077596;
        Thu, 21 Oct 2021 00:20:03 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Thu, 21 Oct 2021 00:20:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 19KFK2c3077592
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 21 Oct 2021 00:20:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH memcg 2/3] memcg: remove charge forcinig for dying tasks
To:     Michal Hocko <mhocko@suse.com>, Vasily Averin <vvs@virtuozzo.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
References: <YW/WoJDFM3ddHn7Y@dhcp22.suse.cz>
 <cover.1634730787.git.vvs@virtuozzo.com>
 <56180e53-b705-b1be-9b60-75e141c8560c@virtuozzo.com>
 <YXAOjQO5r1g/WKmn@dhcp22.suse.cz>
 <cbda9b6b-3ee5-06ab-9a3b-debf361b55bb@virtuozzo.com>
 <YXAubuMMgNDeguNx@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <dee26724-3ead-24d4-0c1b-23905bfcdae9@i-love.sakura.ne.jp>
Date:   Thu, 21 Oct 2021 00:20:02 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YXAubuMMgNDeguNx@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021/10/20 23:57, Michal Hocko wrote:
> One argument for removing it from here is the maintainability. Now you
> have a memcg specific check which is not in sync with the oom. E.g.
> out_of_memory does task_will_free_mem as the very first thing. You are
> also automatically excluding oom killer for cases where that might make
> a sense.

What makes it possible to remove this check?
This check was added because task_will_free_mem() in out_of_memory() does NOT work.
See commit 7775face207922ea ("memcg: killed threads should not invoke memcg OOM killer").
