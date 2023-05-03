Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1EA6F5D41
	for <lists+cgroups@lfdr.de>; Wed,  3 May 2023 19:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjECRqa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 3 May 2023 13:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjECRq3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 3 May 2023 13:46:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5709810F3
        for <cgroups@vger.kernel.org>; Wed,  3 May 2023 10:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683135930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i+1daImuCgAFQ62zz1n0R8N9/43jAwavxjwtDs1QPpw=;
        b=M41QegfpV+70HZ4DUbNQqfbYVju4PefYqYGauOZybahXoWlyYzdtHoBr44/esieFWj+pKo
        BloZvmTb15rdjbNmH/0GP14BG7Us2H1B/uB1E0o1xwwMC2IEwNScsFyx0nyR3rDQckaTLF
        3RH+tDvnkZb0WR+OgYeCzT3nLD/MSzM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-7jHQmRNDOZ-W3uIAMepP2g-1; Wed, 03 May 2023 13:45:28 -0400
X-MC-Unique: 7jHQmRNDOZ-W3uIAMepP2g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BCEA293248C;
        Wed,  3 May 2023 17:45:27 +0000 (UTC)
Received: from [10.22.17.228] (unknown [10.22.17.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 117331121331;
        Wed,  3 May 2023 17:45:25 +0000 (UTC)
Message-ID: <5a64fdd5-ee1a-7609-99a9-a8d1e282e393@redhat.com>
Date:   Wed, 3 May 2023 13:45:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 5/6] sched/deadline: Create DL BW alloc, free & check
 overflow interface
Content-Language: en-US
To:     Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20230503072228.115707-1-juri.lelli@redhat.com>
 <20230503072228.115707-6-juri.lelli@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230503072228.115707-6-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/3/23 03:22, Juri Lelli wrote:
> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
>
> Rework the existing dl_cpu_busy() interface which offers DL BW overflow
> checking and per-task DL BW allocation.
>
> Add dl_bw_free() as an interface to be able to free DL BW.
> It will be used to allow freeing of the DL BW request done during
> cpuset_can_attach() in case multiple controllers are attached to the
> cgroup next to the cpuset controller and one of the non-cpuset
> can_attach() fails.
>
> dl_bw_alloc() (and dl_bw_free()) now take a `u64 dl_bw` parameter
> instead of `struct task_struct *p` used in dl_cpu_busy().  This allows
> to allocate DL BW for a set of tasks too rater than only for a single

Typo: "rater" => "rather".

Cheers,
Longman


