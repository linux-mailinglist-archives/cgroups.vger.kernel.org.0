Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3C65F7065
	for <lists+cgroups@lfdr.de>; Thu,  6 Oct 2022 23:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiJFVej (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Oct 2022 17:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbiJFVei (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Oct 2022 17:34:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A545F50
        for <cgroups@vger.kernel.org>; Thu,  6 Oct 2022 14:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665092075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z5KDkZsZZPUp3zvan69x4fPFamZUOxTgDM1WYdBR6n4=;
        b=Y3SMvA28jy38zyRl7OqxkHxczXhorHiVMe1TUf9OsxVMww+xyeMJVAS88LkSNaRDW4NvCC
        XVmGHnnOlZIbuXqUkh7ejywAFkJX0asZOuDvWRvWSS7EsmvJCEgF6xQW2/ZNAxr/mgHDoF
        6VUm3wZR7Nh2+Qml2uU49H0yOFIGb7s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-2nL_g01_N-q1EyxGH75tzQ-1; Thu, 06 Oct 2022 17:34:32 -0400
X-MC-Unique: 2nL_g01_N-q1EyxGH75tzQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0EFFD85A59D;
        Thu,  6 Oct 2022 21:34:32 +0000 (UTC)
Received: from [10.22.8.198] (unknown [10.22.8.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 800ED404705D;
        Thu,  6 Oct 2022 21:34:30 +0000 (UTC)
Message-ID: <5125cfc1-7710-9145-bf42-1826a30514e9@redhat.com>
Date:   Thu, 6 Oct 2022 17:34:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v8 3/3] blk-cgroup: Optimize blkcg_rstat_flush()
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
References: <20221004151748.293388-1-longman@redhat.com>
 <20221006101141.1832-1-hdanton@sina.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221006101141.1832-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/6/22 06:11, Hillf Danton wrote:
> On 4 Oct 2022 11:17:48 -0400 Waiman Long <longman@redhat.com>
>> For a system with many CPUs and block devices, the time to do
>> blkcg_rstat_flush() from cgroup_rstat_flush() can be rather long. It
>> can be especially problematic as interrupt is disabled during the flush.
>> It was reported that it might take seconds to complete in some extreme
>> cases leading to hard lockup messages.
>>
>> As it is likely that not all the percpu blkg_iostat_set's has been
>> updated since the last flush, those stale blkg_iostat_set's don't need
>> to be flushed in this case. This patch optimizes blkcg_rstat_flush()
>> by keeping a lockless list of recently updated blkg_iostat_set's in a
>> newly added percpu blkcg->lhead pointer.
>>
>> The blkg_iostat_set is added to a sentinel lockless list on the update
>> side in blk_cgroup_bio_start(). It is removed from the sentinel lockless
>> list when flushed in blkcg_rstat_flush(). Due to racing, it is possible
>> that blk_iostat_set's in the lockless list may have no new IO stats to
>> be flushed, but that is OK.
> So it is likely that another flag, updated when bis is added to/deleted
> from llist, can cut 1/3 off without raising the risk of getting your patch
> over complicated.
>
>>   
>>   struct blkg_iostat_set {
>>   	struct u64_stats_sync		sync;
>> +	struct llist_node		lnode;
>> +	struct blkcg_gq		       *blkg;
> +	atomic_t			queued;
>
>>   	struct blkg_iostat		cur;
>>   	struct blkg_iostat		last;
>>   };

Yes, by introducing a flag to record the lockless list state, it is 
possible to just use the current llist implementation. Maybe I can 
rework it for now without the sentinel variant and post a separate llist 
patch for that later on.

Cheers,
Longman

