Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB2477CF7D
	for <lists+cgroups@lfdr.de>; Tue, 15 Aug 2023 17:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbjHOPpx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Aug 2023 11:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbjHOPpq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Aug 2023 11:45:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1340DE72
        for <cgroups@vger.kernel.org>; Tue, 15 Aug 2023 08:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692114299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TawkjbN36L2tJSa3Vtp7sv1FkX0qieEa0khYy9fqi68=;
        b=Osvw/9nj7kfiCa4t1hvz3aW8EiIvZKfT0BHoCK2LB27YIzbTbYAULaIBMsvQjqmIWFr77L
        9rbzGEhhLE9qAceX9hvm2XDiNVpUsjiyqCC30rgiQjNI+t7affQMD89Bu2LK28EPpgw1sw
        Y9swAo2Dj6FaAWJN3mvc0d7enruqh/0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-Tdg2iIrqNFaYgkrb_S-NTw-1; Tue, 15 Aug 2023 11:44:53 -0400
X-MC-Unique: Tdg2iIrqNFaYgkrb_S-NTw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DC1529DD987;
        Tue, 15 Aug 2023 15:44:43 +0000 (UTC)
Received: from [10.22.18.67] (unknown [10.22.18.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6AAEC15BAD;
        Tue, 15 Aug 2023 15:44:42 +0000 (UTC)
Message-ID: <54e8c38d-c805-2666-b559-ce785ba24b67@redhat.com>
Date:   Tue, 15 Aug 2023 11:44:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mm: memcg: provide accurate stats for userspace reads
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, Yosry Ahmed <yosryahmed@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <CAJD7tkbF1tNi8v0W4Mnqs0rzpRBshOFepxFTa1SiSvmBEBUEvw@mail.gmail.com>
 <CALvZod55S3XeK-MquTq0mDuipq8j0vFymQeX_XnPb_HuPK+oGQ@mail.gmail.com>
 <CAJD7tkYZxjAHrodVDK=wmz-sULJrq2VhC_5ecRP7T-KiaOcTuw@mail.gmail.com>
 <CALvZod46Cz_=5UgiyAKM+VgKyk=KJCqDqXu91=9uHy7-2wk53g@mail.gmail.com>
 <CAJD7tkY-ezyYebvcs=8Z_zrw2UVW8jf2WvP1G8tu2rT=2sMnAA@mail.gmail.com>
 <CALvZod5fH9xu_+6x85K38f63GfKGWD1LqtD2R4d09xmDtLB7ew@mail.gmail.com>
 <ZNdEaw2nktq1NfmH@dhcp22.suse.cz>
 <CAJD7tkaFHgc3eN1K1wYsQFWMLu4+Frf9DJ-5HOja2nC20Es9Dw@mail.gmail.com>
 <ZNrDWqfjXtAYhnvT@slm.duckdns.org>
 <CAJD7tkYBFz-gZ2QsHxUMT=t0KNXs66S-zzMPebadHx9zaG0Q3w@mail.gmail.com>
 <ZNrITZVTf2EILRJq@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZNrITZVTf2EILRJq@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 8/14/23 20:35, Tejun Heo wrote:
> Hello,
>
> On Mon, Aug 14, 2023 at 05:28:22PM -0700, Yosry Ahmed wrote:
>>> So, the original design used mutex for synchronize flushing with the idea
>>> being that updates are high freq but reads are low freq and can be
>>> relatively slow. Using rstats for mm internal operations changed this
>>> assumption quite a bit and we ended up switching that mutex with a lock.
>> Naive question, do mutexes handle thundering herd problems better than
>> spinlocks? I would assume so but I am not sure.
> I don't know. We can ask Waiman if that becomes a problem.

We had essentially solved the thundering herd problems for both 
spinlocks and mutexes. Both types of lock waiters will spin in their own 
cachelines (in the OSP wait queue in the case of mutex) except one that 
is at the head of the queue. So there should be minimal cacheline 
bouncing. One should certainly uses mutexes in sleep-able context or 
when the critical section is long.

Cheers,
Longman

