Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F210F6CEF21
	for <lists+cgroups@lfdr.de>; Wed, 29 Mar 2023 18:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjC2QTq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Mar 2023 12:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjC2QTo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Mar 2023 12:19:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DAB46BF
        for <cgroups@vger.kernel.org>; Wed, 29 Mar 2023 09:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680106743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BK4E10sij+UjBr4h6hMh56nRJwsX+E/yiWATUoPCWNU=;
        b=ZIPSwZWX96VSiXGPoxswmy/jL7reqF7ixmC0QqydjQhzRfd8zSGbYDqPNLDw9HnqcXxUA0
        kXJXdizghmX9bVsDQmbB6KCJb1QlMWYJIhdxSj91VJmrm+unafhb1ZrMBxW7TY3ufArOIy
        vwGgo9M8tL9H9itElnVZsl0A6bymSI0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-5kwB7d74P1WUzrrEszAoSw-1; Wed, 29 Mar 2023 12:05:22 -0400
X-MC-Unique: 5kwB7d74P1WUzrrEszAoSw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C33E855315;
        Wed, 29 Mar 2023 16:05:21 +0000 (UTC)
Received: from [10.22.34.224] (unknown [10.22.34.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73F48492B00;
        Wed, 29 Mar 2023 16:05:20 +0000 (UTC)
Message-ID: <0eae9e7c-8bfc-6e89-c4ad-e1cd40ec03b5@redhat.com>
Date:   Wed, 29 Mar 2023 12:05:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 6/7] cgroup/cpuset: Protect DL BW data against parallel
 cpuset_attach()
Content-Language: en-US
To:     Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20230329125558.255239-1-juri.lelli@redhat.com>
 <20230329160240.2093277-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230329160240.2093277-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 3/29/23 12:02, Waiman Long wrote:
> It is possible to have parallel attach operations to the same cpuset in
> progress. To avoid possible corruption of single set of DL BW data in
> the cpuset structure, we have to disallow parallel attach operations if
> DL tasks are present. Attach operations can still proceed in parallel
> as long as no DL tasks are involved.
>
> This patch also stores the CPU where DL BW is allocated and free that BW
> back to the same CPU in case cpuset_can_attach() is called.
>
> Signed-off-by: Waiman Long <longman@redhat.com>

Juri, this patch is an addendum to your series to address the issues 
that I found from the cpuset point of view.

Cheers,
Longman

