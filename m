Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3D7B58C57
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2019 22:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfF0U7c (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Jun 2019 16:59:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbfF0U7c (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 27 Jun 2019 16:59:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A2BD930BB37D;
        Thu, 27 Jun 2019 20:59:26 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3273544ED;
        Thu, 27 Jun 2019 20:59:24 +0000 (UTC)
Subject: Re: [PATCH] memcg: Add kmem.slabinfo to v2 for debugging purpose
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>
References: <20190626165614.18586-1-longman@redhat.com>
 <20190627142024.GW657710@devbig004.ftw2.facebook.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <afc95bfa-d913-b834-c4b7-39839e7a902d@redhat.com>
Date:   Thu, 27 Jun 2019 16:59:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190627142024.GW657710@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 27 Jun 2019 20:59:31 +0000 (UTC)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/27/19 10:20 AM, Tejun Heo wrote:
> Hello, Waiman.
>
> On Wed, Jun 26, 2019 at 12:56:14PM -0400, Waiman Long wrote:
>> With memory cgroup v1, there is a kmem.slabinfo file that can be
>> used to view what slabs are allocated to the memory cgroup. There
>> is currently no such equivalent in memory cgroup v2. This file can
>> be useful for debugging purpose.
>>
>> This patch adds an equivalent kmem.slabinfo to v2 with the caveat that
>> this file will only show up as ".__DEBUG__.memory.kmem.slabinfo" when the
>> "cgroup_debug" parameter is specified in the kernel boot command line.
>> This is to avoid cluttering the cgroup v2 interface with files that
>> are seldom used by end users.
> Can you please take a look at drgn?
>
>   https://github.com/osandov/drgn
>
> Baking in debug interface files always is limited and nasty and drgn
> can get you way more flexible debugging / monitoring tool w/o having
> to bake in anything into the kernel.  For an example, please take a
> look at
>
>   https://lore.kernel.org/bpf/20190614015620.1587672-10-tj@kernel.org/
>
> Thanks.
>
Thanks for the information. Will take a serious look at that.

Cheers,
Longman

