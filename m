Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04250360638
	for <lists+cgroups@lfdr.de>; Thu, 15 Apr 2021 11:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhDOJwU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Apr 2021 05:52:20 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:36890 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231725AbhDOJwT (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 15 Apr 2021 05:52:19 -0400
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Apr 2021 05:52:19 EDT
Received: by gentwo.de (Postfix, from userid 1001)
        id 21905B00648; Thu, 15 Apr 2021 11:44:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 1FE1BB0002A;
        Thu, 15 Apr 2021 11:44:55 +0200 (CEST)
Date:   Thu, 15 Apr 2021 11:44:55 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
cc:     Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [PATCH v3 5/5] mm/memcg: Optimize user context object stock
 access
In-Reply-To: <20210415032836.lohexqge3cvpsqoa@gabell>
Message-ID: <alpine.DEB.2.22.394.2104151143080.632904@gentwo.de>
References: <20210414012027.5352-1-longman@redhat.com> <20210414012027.5352-6-longman@redhat.com> <20210415032836.lohexqge3cvpsqoa@gabell>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 14 Apr 2021, Masayoshi Mizuma wrote:

> Please feel free to add:
>
> Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>
> Thanks!
> Masa
>

Would you please stop quoting the whole patch when you have nothing to say
about the details? It is enough to just respond without quoting. I was
looking through this trying to find something you said about individual
sections of code but there was nothing.



