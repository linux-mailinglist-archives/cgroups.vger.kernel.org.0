Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC7336A100
	for <lists+cgroups@lfdr.de>; Sat, 24 Apr 2021 13:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbhDXLzO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 24 Apr 2021 07:55:14 -0400
Received: from relay.sw.ru ([185.231.240.75]:46682 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231203AbhDXLzN (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 24 Apr 2021 07:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=29HYTylwYhZ3dYsWBx6VPp71dTboK0VaoGXB6Hg/UoQ=; b=uijsUv9twbDkh0f/HsZ
        s3sQlHADWWDS3ZGT4302e/GJiseFOrKGcqCclo1Eva/7ahcHfoRfv0GEuR3IhtmXv1sD8goSwNKXX
        EmJ+AOqquy+3jDiiZB+n7dNUxk7Hd0PS+CsAZQWj/hBNOUKa+dKc6m4G6MgIKCu1CW/vtLzb7kc=
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <vvs@virtuozzo.com>)
        id 1laGri-001INj-Rw; Sat, 24 Apr 2021 14:54:26 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2 0/1] memcg: enable accounting for pids in nested pid
 namespaces
To:     Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Serge Hallyn <serge@hallyn.com>
References: <7b777e22-5b0d-7444-343d-92cbfae5f8b4@virtuozzo.com>
Message-ID: <163b816f-0655-1b4d-9c59-7878981be44e@virtuozzo.com>
Date:   Sat, 24 Apr 2021 14:54:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <7b777e22-5b0d-7444-343d-92cbfae5f8b4@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Pid was one the first kernel objects enabled for memcg accounting, see
5d097056c9a0 ("kmemcg: account certain kmem allocations to memcg")

init_pid_ns.pid_cachep marked by SLAB_ACCOUNT and we can expect that any new pids 
in the system are memcg-accounted.

Though recently I've noticed that it is wrong. nested pid namespaces creates 
own slab caches for pid objects, nested pids have increased size because contain 
id both for all parent and for own pid namespaces. The problem is that these slab
caches are _NOT_ marked by SLAB_ACCOUNT,as a result any pids allocated in 
nested pid namespaces are not memcg-accounted.

Pid struct in nested pid namespace consumes up to 500 bytes memory,
100000 such objects gives us up to ~50Mb unaccounted memory.
This allow container to exceed assigned memcg limits.

For me this issue lookslike bug and I would like to ask to push this fix 
both to upstream and to stable

Vasily Averin (1):
  memcg: enable accounting for pids in nested pid namespaces

 kernel/pid_namespace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
1.8.3.1

