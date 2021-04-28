Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B68136D342
	for <lists+cgroups@lfdr.de>; Wed, 28 Apr 2021 09:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhD1Hfz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Apr 2021 03:35:55 -0400
Received: from relay.sw.ru ([185.231.240.75]:45718 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhD1Hfz (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 28 Apr 2021 03:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=rt9hMUShGGdTkFhHM9nn7jw5xlKeoUNDnqLfS9j0MZU=; b=oN0VbyebvbVj4UP7nYI
        0e6DEFhmpt1zjLehASYxqZh/T/RalZFrj1ifVvRu99O+mr+3PYe3frgOTzIHgfq4AIg8k8rtNzrBX
        bEX+PjVxzIl8PsbhpZleCbmHsl//U9BjP5xvGI2PHstUqwVcJtZdyTV6xuhl6ucCPZPQJwjiQ4w=
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <vvs@virtuozzo.com>)
        id 1lbeiw-001VrE-7M; Wed, 28 Apr 2021 10:35:06 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2 0/2] ipc: allocations cleanup
To:     Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>
References: <ebc3ac79-3190-520d-81ce-22ad194986ec@virtuozzo.com>
Message-ID: <d98fca4d-f2ef-edfe-e075-bad1ec6557ee@virtuozzo.com>
Date:   Wed, 28 Apr 2021 10:35:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <ebc3ac79-3190-520d-81ce-22ad194986ec@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Some ipc objects use the wrong allocation functions: small objects can use kmalloc(),
and vice versa, potentially large objects can use kmalloc().

I think it's better to handle these patches via cgroups@ to avoid merge conflicts
with "memcg: enable accounting of ipc resources" patch included to 
"memcg accounting from OpenVZ" patch set.

v2:
- improved patch description

Vasily Averin (2):
  ipc sem: use kvmalloc for sem_undo allocation
  ipc: use kmalloc for msg_queue and shmid_kernel

 ipc/msg.c |  6 +++---
 ipc/sem.c | 10 +++++-----
 ipc/shm.c |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

-- 
1.8.3.1

