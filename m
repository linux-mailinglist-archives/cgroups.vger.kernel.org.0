Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1757364AC42
	for <lists+cgroups@lfdr.de>; Tue, 13 Dec 2022 01:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbiLMAWp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Dec 2022 19:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbiLMAWR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Dec 2022 19:22:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0851EC46
        for <cgroups@vger.kernel.org>; Mon, 12 Dec 2022 16:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670890755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gI+6HXmXS35AZXXUiiiCAtaTnfFzC0toG7xNuA9nRrA=;
        b=Tu1dO6itKgbnEFFelRlVXxzPTq6mFmu4Rkftw5zqg0dbH/wmNWUDRwKJuZ3pr+/bmC0Ntt
        2VeIX0t8BbBPXKo3i3Q+qQ2AuHxBpwaQz2B0X1yZjeXEW/z2448yAmdVBxvlRuLl3la4r6
        gTHD/he75AoLPDslFvC6u7WYNVFl6pw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-vE5xQ8OyP5a4p8qoy9ut0A-1; Mon, 12 Dec 2022 19:19:11 -0500
X-MC-Unique: vE5xQ8OyP5a4p8qoy9ut0A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4248185A78B;
        Tue, 13 Dec 2022 00:19:10 +0000 (UTC)
Received: from [10.22.11.98] (unknown [10.22.11.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0B6414152F4;
        Tue, 13 Dec 2022 00:19:09 +0000 (UTC)
Message-ID: <81f14365-a153-44aa-8ee7-4910f6988d7c@redhat.com>
Date:   Mon, 12 Dec 2022 19:19:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH-block v2 3/3] blk-cgroup: Flush stats at blkgs destruction
 path
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
References: <20221211222058.2946830-1-longman@redhat.com>
 <20221211222058.2946830-4-longman@redhat.com>
 <Y5eqAtwnpfEUG0EL@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y5eqAtwnpfEUG0EL@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 12/12/22 17:24, Tejun Heo wrote:
> On Sun, Dec 11, 2022 at 05:20:58PM -0500, Waiman Long wrote:
>> As noted by Michal, the blkg_iostat_set's in the lockless list
>> hold reference to blkg's to protect against their removal. Those
>> blkg's hold reference to blkcg. When a cgroup is being destroyed,
>> cgroup_rstat_flush() is only called at css_release_work_fn() which is
>> called when the blkcg reference count reaches 0. This circular dependency
>> will prevent blkcg from being freed until some other events cause
>> cgroup_rstat_flush() to be called to flush out the pending blkcg stats.
>>
>> To prevent this delayed blkcg removal, add a new cgroup_rstat_css_flush()
>> function to flush stats for a given css and cpu and call it at the blkgs
>> destruction path, blkcg_destroy_blkgs(), whenever there are still some
>> pending stats to be flushed. This will ensure that blkcg reference
>> count can reach 0 ASAP.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: Tejun Heo <tj@kernel.org>
>
> But a nit below
>
>> +	/*
>> +	 * Flush all the non-empty percpu lockless lists.
>> +	 */
> Can you please explain the deadlock that's being avoided in the above
> comment? ie. it should say why this flush is necessary.

Sure. I will expand the comment to elaborate a bit more.

Cheers,
Longman

>
>> +	for_each_possible_cpu(cpu) {
>> +		struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
>> +
>> +		if (!llist_empty(lhead))
>> +			cgroup_rstat_css_cpu_flush(&blkcg->css, cpu);
>> +	}

