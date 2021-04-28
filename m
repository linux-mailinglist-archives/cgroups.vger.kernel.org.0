Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9046936D197
	for <lists+cgroups@lfdr.de>; Wed, 28 Apr 2021 07:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhD1FQA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Apr 2021 01:16:00 -0400
Received: from relay.sw.ru ([185.231.240.75]:35128 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229717AbhD1FQA (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 28 Apr 2021 01:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=0gJMy7DqAS1eYRTK9B131Vy4K+YMVwWNOR4yrE6X82I=; b=lvTFouv53BEh8mHyG
        NY7phcbGM0CieM5FyKUvFOhGkYhy9YpaXThdBSSwtS+55DAF1oe2Tf1w5GoChA6P4wWw8jBtBKm8H
        dNK0NijqbVaj0q9VRVxslSW4Cnu0YuCBEUgfpXxqTJh70FnrJu64+7td8LHRzhWHt8DC5+9slwvdc
        =;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <vvs@virtuozzo.com>)
        id 1lbcXW-001Vbz-HK; Wed, 28 Apr 2021 08:15:10 +0300
Subject: Re: [PATCH 2/2] ipc: use kmalloc for msg_queue and shmid_kernel
To:     Michal Hocko <mhocko@suse.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>
References: <e67f2a95-4b01-9db2-fe47-0b2210f0b138@virtuozzo.com>
 <b0845b85-f4fe-601d-3328-d707d7db27f5@virtuozzo.com>
 <YIaVKi+0VMrz5LGD@dhcp22.suse.cz>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <70805e05-5e56-2ab9-2654-3d48e9fe5a0a@virtuozzo.com>
Date:   Wed, 28 Apr 2021 08:15:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YIaVKi+0VMrz5LGD@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/26/21 1:25 PM, Michal Hocko wrote:
> Using kvmalloc for sub page size objects is suboptimal because kmalloc
> can easily fallback into vmalloc under memory pressure and smaller
> objects would fragment memory. Therefore replace kvmalloc by a simple
> kmalloc.

I think you're wrong here:
kvmalloc can failback to vmalloc for size > PAGE_SIZE only

Please take look at mm/util.c::kvmalloc_node()

        if (size > PAGE_SIZE) {
                kmalloc_flags |= __GFP_NOWARN;

                if (!(kmalloc_flags & __GFP_RETRY_MAYFAIL))
                        kmalloc_flags |= __GFP_NORETRY;
        }

        ret = kmalloc_node(size, kmalloc_flags, node);

        /*
         * It doesn't really make sense to fallback to vmalloc for sub page
         * requests
         */
        if (ret || size <= PAGE_SIZE)
                return ret;

        return __vmalloc_node(size, 1, flags, node,
                        __builtin_return_address(0));

For small objects kvmalloc is not much different just from kmalloc,
so the patch is mostly cosmetic.
