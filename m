Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A932474EE
	for <lists+cgroups@lfdr.de>; Mon, 17 Aug 2020 21:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387439AbgHQTRM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Aug 2020 15:17:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57643 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387426AbgHQPi6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Aug 2020 11:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597678736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZkWVLRXZ5vVFgxHkOqqYvCoNjff7Y5hvG4el3ZRbhHA=;
        b=hfQld+O6Dxs7anZDlpfGLHC1/7KiaFkJeU4Fjdw/dGVOAzg3M4d24w7R5pzMkIUehlf9T3
        3SX1hmbWE6WUGLWHB71aylEC89J+8Fr+fNHe13wrzK/0pf/EwmR5hGExBCs6/+qONVGZRA
        EbgqUiCgKfe17auBwCaON+8d+E38Uis=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-RxczTlPaMrKBj81he1F3KQ-1; Mon, 17 Aug 2020 11:38:52 -0400
X-MC-Unique: RxczTlPaMrKBj81he1F3KQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D38AF807333;
        Mon, 17 Aug 2020 15:38:50 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-35.rdu2.redhat.com [10.10.118.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F98A614F9;
        Mon, 17 Aug 2020 15:38:46 +0000 (UTC)
Subject: Re: [RFC PATCH 1/8] memcg: Enable fine-grained control of over
 memory.high action
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
References: <20200817140831.30260-1-longman@redhat.com>
 <20200817140831.30260-2-longman@redhat.com>
 <20200817143044.GA1987@chrisdown.name>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <934e4bc3-bab6-b19a-49f9-6a6ae8638570@redhat.com>
Date:   Mon, 17 Aug 2020 11:38:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200817143044.GA1987@chrisdown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/17/20 10:30 AM, Chris Down wrote:
> Astractly, I think this really overcomplicates the API a lot. If these 
> are truly generally useful (and I think that remains to be 
> demonstrated), they should be additions to the existing API, rather 
> than a sidestep with prctl.
This patchset is derived from customer requests. With existing API, I 
suppose you mean the memory cgroup API. Right? The reason to use prctl() 
is that there are users out there who want some kind of per-process 
control instead of for a whole group of processes unless the users try 
to create one cgroup per process which is not very efficient.
>
> I also worry about some other more concrete things:
>
> 1. Doesn't this allow unprivileged applications to potentially bypass 
>    memory.high constraints set by a system administrator?
The memory.high constraint is for triggering memory reclaim. The new 
mitigation actions introduced by this patchset will only be applied if 
memory reclaim alone fails to limit the physical memory consumption. The 
current memory cgroup memory reclaim code will not be affected by this 
patchset.
> 2. What's the purpose of PR_MEMACT_KILL, compared to memory.max?
A user can use this to specify which processes are less important and 
can be sacrificed first instead of the other more important ones in case 
they are really in a OOM situation. IOW, users can specify the order 
where OOM kills can happen.
> 3. Why add this entirely separate signal delivery path when we already 
> have eventfd/poll/inotify support, which makes a lot more sense for 
> modern    applications?

Good question, I will look further into this to see if it can be 
applicable in this case.

Cheers,
Longman


