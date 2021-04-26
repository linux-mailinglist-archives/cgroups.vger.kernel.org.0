Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD7536B171
	for <lists+cgroups@lfdr.de>; Mon, 26 Apr 2021 12:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhDZKSt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Apr 2021 06:18:49 -0400
Received: from relay.sw.ru ([185.231.240.75]:39724 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232194AbhDZKSt (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 26 Apr 2021 06:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=bS7qJCt+apou1io9EP23fTA+ismXHEBNwUulXjfdPVc=; b=V2aHQIRfxkj2C8JYCW1
        Xdjs8pF7wKtVSDoELvOh/RFwlqsae9Dqmm8vtmLAkEhzGI3q5f0mGU3RnF8qdWtEIb9Cep2vLJwtp
        dOkPOTieBEBVyNLrF17DZtRKDEF1wvZuQFSQh6KJcVBZDYCdpSywmJJC1H8FbyvsJdkbrDksIQM=
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <vvs@virtuozzo.com>)
        id 1layJV-001LXz-SY; Mon, 26 Apr 2021 13:18:01 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 0/2] ipc: allocations cleanup
To:     Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>
References: <e67f2a95-4b01-9db2-fe47-0b2210f0b138@virtuozzo.com>
Message-ID: <ebc3ac79-3190-520d-81ce-22ad194986ec@virtuozzo.com>
Date:   Mon, 26 Apr 2021 13:18:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <e67f2a95-4b01-9db2-fe47-0b2210f0b138@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Some ipc objects use the wrong allocation functions: small objects can use kmalloc(),
and vice versa, potentially large objects can use kmalloc().

I think it's better to handle these patches via cgroups@ to avoid merge conflicts
with my patches that include accounting for ipc objects.

Vasily Averin (2):
  ipc sem: use kvmalloc for sem_undo allocation
  ipc: use kmalloc for msg_queue and shmid_kernel

 ipc/msg.c |  6 +++---
 ipc/sem.c | 10 +++++-----
 ipc/shm.c |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

-- 
1.8.3.1

