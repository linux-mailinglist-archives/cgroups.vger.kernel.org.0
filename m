Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1E93CB144
	for <lists+cgroups@lfdr.de>; Fri, 16 Jul 2021 05:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhGPEAX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Jul 2021 00:00:23 -0400
Received: from relay.sw.ru ([185.231.240.75]:44756 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhGPEAW (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 16 Jul 2021 00:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=bgQrMW8axuqa/T8OOKL/8pzBoixeuP3GcTBvX+k2SpY=; b=ABeW19tYTEkgGjO1b
        3IjN+IBg+c61j/saK+k9QaFFs2jRbXXrudHF8U++xtdk2StgGhWTLooje6M3F88/32vXqHYW69kk9
        n7YlZZoTDtX7B7xEH7ILb7BiQcbl0qx7xV8fAQSQLhfKlVVZ2njJ+GqbBw1/00kUxxYTAiw2rUqGM
        =;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1m4EyW-00499f-Pv; Fri, 16 Jul 2021 06:57:20 +0300
Subject: Re: [PATCH] memcg: charge semaphores and sem_undo objects
To:     Shakeel Butt <shakeelb@google.com>, Yutian Yang <nglaive@gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        shenwenbo@zju.edu.cn
References: <1626333284-1404-1-git-send-email-nglaive@gmail.com>
 <CALvZod4-Vh4O4-PN661jqicSg95GPf87nv10xAYr1yG6oZQk8A@mail.gmail.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <44325e3a-f4e9-c19a-4a00-672d1d61120d@virtuozzo.com>
Date:   Fri, 16 Jul 2021 06:57:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CALvZod4-Vh4O4-PN661jqicSg95GPf87nv10xAYr1yG6oZQk8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/15/21 8:05 PM, Shakeel Butt wrote:
> On Thu, Jul 15, 2021 at 12:15 AM Yutian Yang <nglaive@gmail.com> wrote:
>> Signed-off-by: Yutian Yang <nglaive@gmail.com>
> 
> Thanks for the patch Yutian. I remember patch from Vasily regarding
> memcg charging of similar objects.

Yes, it is part of my "memcg: enable accounting of ipc resources" patch.
We account few other IPC objects too. 

> Vasily, what's the status of your patch?

It is still not merged, unfortunately, I will try to push it again.

Thank you,
	Vasily Averin
