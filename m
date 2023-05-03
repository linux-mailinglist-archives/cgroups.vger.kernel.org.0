Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2396F5D64
	for <lists+cgroups@lfdr.de>; Wed,  3 May 2023 19:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjECR5a (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 3 May 2023 13:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjECR53 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 3 May 2023 13:57:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C439E26A0
        for <cgroups@vger.kernel.org>; Wed,  3 May 2023 10:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683136600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bsL+UOJbF/TNc0P0DpLZQCkCHaeoLKCd8i3Rcq5uipg=;
        b=H3tnvFTqcuyG37ZxxW4ZXFSoIF2u0pztE2GIGuCfdSQ+ncebQ6KHn52FSMtEFa1jSEeo5k
        H/ex+LWwes5JFNR7AihRg1qoJMf0RfaIRtEJyc9Ts5W7eVSLFHIvOn3vAlOjIZA8DhRIhB
        UodSotj5APyo6yofDRK+tJUpcupFEYw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-WCcH1OIFMTyPQJExjOqJfw-1; Wed, 03 May 2023 13:56:36 -0400
X-MC-Unique: WCcH1OIFMTyPQJExjOqJfw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 891D8185A79C;
        Wed,  3 May 2023 17:56:35 +0000 (UTC)
Received: from [10.22.17.228] (unknown [10.22.17.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF33C492C13;
        Wed,  3 May 2023 17:56:34 +0000 (UTC)
Message-ID: <86854aad-d649-9369-c53d-75446ab8de7b@redhat.com>
Date:   Wed, 3 May 2023 13:56:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 4/6] cgroup/cpuset: Iterate only if DEADLINE tasks are
 present
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
 <20230503072228.115707-5-juri.lelli@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230503072228.115707-5-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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
> update_tasks_root_domain currently iterates over all tasks even if no
> DEADLINE task is present on the cpuset/root domain for which bandwidth
> accounting is being rebuilt. This has been reported to introduce 10+ ms
> delays on suspend-resume operations.
>
> Skip the costly iteration for cpusets that don't contain DEADLINE tasks.
>
> Reported-by: Qais Yousef <qyousef@layalina.io>
> Link: https://lore.kernel.org/lkml/20230206221428.2125324-1-qyousef@layalina.io/
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>   kernel/cgroup/cpuset.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index b9f4d5602517..6587df42cb61 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1090,6 +1090,9 @@ static void dl_update_tasks_root_domain(struct cpuset *cs)
>   	struct css_task_iter it;
>   	struct task_struct *task;
>   
> +	if (cs->nr_deadline_tasks == 0)
> +		return;
> +
>   	css_task_iter_start(&cs->css, 0, &it);
>   
>   	while ((task = css_task_iter_next(&it)))
Reviewed-by: Waiman Long <longman@redhat.com>

