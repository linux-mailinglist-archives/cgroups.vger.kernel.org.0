Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE673CF63C
	for <lists+cgroups@lfdr.de>; Tue, 20 Jul 2021 10:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbhGTH4q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Jul 2021 03:56:46 -0400
Received: from relay.sw.ru ([185.231.240.75]:47922 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234449AbhGTHzA (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 20 Jul 2021 03:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=GCfwuXuzQlyWhoFqI2bAb5C2O3u0V1H4t9sAk8gyaiU=; b=o2x2uM9kxU9Ii8mcM
        ngv33zeb7qweb0P3mK2R8eAhFqaxQt6ZcEaksmqdwoZYzXdctpdlMovEX+oZSjSFpM8uxJ6gLHMkO
        Mu0Ncl43GqGbeSSpHpKFig1cIERZbIr86yVht+RnKUlNXocFFbYkh9yY1cEeu5YE7PC2U+Mx7Foi8
        =;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1m5lDk-004YDr-BU; Tue, 20 Jul 2021 11:35:20 +0300
Subject: Re: [PATCH v5 13/16] memcg: enable accounting for signals
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Jens Axboe <axboe@kernel.dk>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org
References: <CALvZod66KF-8xKB1dyY2twizDE=svE8iXT_nqvsrfWg1a92f4A@mail.gmail.com>
 <cover.1626688654.git.vvs@virtuozzo.com>
 <b19f065e-f3c9-2b20-2798-b60f0fc6b05f@virtuozzo.com>
 <87k0lmryyp.fsf@disp2133>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <56816a9d-c2e5-127d-4d90-5d7d17782c8a@virtuozzo.com>
Date:   Tue, 20 Jul 2021 11:35:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87k0lmryyp.fsf@disp2133>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/19/21 8:32 PM, Eric W. Biederman wrote:
> Vasily Averin <vvs@virtuozzo.com> writes:
> 
>> When a user send a signal to any another processes it forces the kernel
>> to allocate memory for 'struct sigqueue' objects. The number of signals
>> is limited by RLIMIT_SIGPENDING resource limit, but even the default
>> settings allow each user to consume up to several megabytes of memory.
>> Moreover, an untrusted admin inside container can increase the limit or
>> create new fake users and force them to sent signals.
> 
> Not any more.  Currently the number of sigqueue objects is limited
> by the rlimit of the creator of the user namespace of the container.
> 
>> It makes sense to account for these allocations to restrict the host's
>> memory consumption from inside the memcg-limited container.
> 
> Does it?  Why?  The given justification appears to have bit-rotted
> since -rc1.

Could you please explain what was changed in rc1?
From my POV accounting is required to help OOM-killer to select proper target.

> I know a lot of these things only really need a limit just to catch a
> program that starts malfunctioning.  If that is indeed the case
> reasonable per-resource limits are probably better than some great big
> group limit that can be exhausted with any single resource in the group.
> 
> Is there a reason I am not aware of that where it makes sense to group
> all of the resources together and only count the number of bytes
> consumed?

Any new limits:
a) should be set properly depending on huge number of incoming parameters.
b) should properly notify about hits
c) should be updated properly after b) 
d) do a)-c) automatically if possible

In past OpenVz had own accounting subsystem, user beancounters (UBC).
It accounted and limited 20+ resources  per-container: numfiles, file locks,
signals, netfilter rules, socket buffers and so on.
I assume you want to do something similar, so let me share our experience. 

We had a lot of problems with UBC:
- it's quite hard to set up the limit. 
  Why it's good to consume N entities of some resource but it's bad to consume N+1 ones? 
  per-process? per-user? per-thread? per-task? per-namespace? if nested? per-container? per-host?
  To answer the questions host admin should have additional knowledge and skills.

- Ok, we have set all limits. Some application hits it and fails.
  It's quite hard to understand that application hits the limit, and failed due to this reason.
  From users point of view, if some application does not work (stable enough)
  inside container => containers are guilty.

- It's quite hard to understand that failed application just want to increase limit X up to N entities.

As result both host admins and container users was unhappy.
So after years of such fights we decided just to limit accounted memory instead.

Anyway, OOM-killer must know who consumed memory to select proper target.

Thank you,
	vasily Averin
 
