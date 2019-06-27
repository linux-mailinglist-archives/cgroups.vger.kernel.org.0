Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C599583CE
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2019 15:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfF0Nr7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Jun 2019 09:47:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfF0Nr7 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 27 Jun 2019 09:47:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 34860883BA;
        Thu, 27 Jun 2019 13:47:46 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE13B5D707;
        Thu, 27 Jun 2019 13:47:40 +0000 (UTC)
Subject: Re: [PATCH] memcg: Add kmem.slabinfo to v2 for debugging purpose
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>
References: <20190626165614.18586-1-longman@redhat.com>
 <20190626152553.6f9178a0361e699a5d53e360@linux-foundation.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <78c5ba55-b755-1997-edcc-9ee03a3f3300@redhat.com>
Date:   Thu, 27 Jun 2019 09:47:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190626152553.6f9178a0361e699a5d53e360@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 27 Jun 2019 13:47:58 +0000 (UTC)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/26/19 6:25 PM, Andrew Morton wrote:
> On Wed, 26 Jun 2019 12:56:14 -0400 Waiman Long <longman@redhat.com> wrote:
>
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
>>
>> ...
>>
>> mm/memcontrol.c | 16 ++++++++++++++++
>> 1 file changed, 16 insertions(+)
> A change to the kernel's user interface triggers a change to the
> kernel's user interface documentation.  This should be automatic by
> now :(
>
>
We don't usually document debugging only files as they are subject to
change with no stability guarantee. That is the point of marking it for
debugging instead of a regular file that we need to support forever.

Cheers,
Longman

