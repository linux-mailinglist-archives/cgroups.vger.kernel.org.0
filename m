Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F3763AD07
	for <lists+cgroups@lfdr.de>; Mon, 28 Nov 2022 16:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiK1Pye (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Nov 2022 10:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiK1Pyc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Nov 2022 10:54:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6000523EBB
        for <cgroups@vger.kernel.org>; Mon, 28 Nov 2022 07:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669650817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/AJ0l8IgalwuHi6aQkbaTJH6CSV9/VHsYq9E6VyGE4U=;
        b=eSVRIpgMN4qnDtw6UyLGWp50zUGr667hJajlIZKEyCGApdax7Il/2A8tL1LDwduq8nWYv3
        soV9XutBzerXB7jZ4YYVFbO1lWoF0iRSrHn+r0D30DhA9vV27kjPsH4XZ1RnJYIfVgWKV+
        js1Kt7/VCa/jVTYNIMS1+Bu3edCZBnk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-Uqa5zVnyMkuBLW5ut3eDSQ-1; Mon, 28 Nov 2022 10:53:36 -0500
X-MC-Unique: Uqa5zVnyMkuBLW5ut3eDSQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 626638027F5;
        Mon, 28 Nov 2022 15:53:35 +0000 (UTC)
Received: from [10.22.10.34] (unknown [10.22.10.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D3731415100;
        Mon, 28 Nov 2022 15:53:34 +0000 (UTC)
Message-ID: <e89e94b6-6bc8-8d1e-0f6f-ad1ea6c60e0f@redhat.com>
Date:   Mon, 28 Nov 2022 10:53:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH-block] blk-cgroup: Use css_tryget() in
 blkcg_destroy_blkgs()
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>, Yi Zhang <yi.zhang@redhat.com>
References: <20221128033057.1279383-1-longman@redhat.com>
 <427068db-6695-a1e2-4aa2-033220680eb9@kernel.dk>
 <b9018641-d39f-ff74-8cfb-ba597f5ee0c2@redhat.com>
 <786aacda-b25d-67f6-bad3-0030b0e2637e@kernel.dk>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <786aacda-b25d-67f6-bad3-0030b0e2637e@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/28/22 10:42, Jens Axboe wrote:
> On 11/28/22 8:38?AM, Waiman Long wrote:
>> On 11/28/22 09:14, Jens Axboe wrote:
>>> On 11/27/22 8:30?PM, Waiman Long wrote:
>>>> Commit 951d1e94801f ("blk-cgroup: Flush stats at blkgs destruction
>>>> path") incorrectly assumes that css_get() will always succeed. That may
>>>> not be true if there is no blkg associated with the blkcg. If css_get()
>>>> fails, the subsequent css_put() call may lead to data corruption as
>>>> was illustrated in a test system that it crashed on bootup when that
>>>> commit was included. Also blkcg may be freed at any time leading to
>>>> use-after-free. Fix it by using css_tryget() instead and bail out if
>>>> the tryget fails.
>>>>
>>>> Fixes: 951d1e94801f ("blk-cgroup: Flush stats at blkgs destruction path")
>>>> Reported-by: Yi Zhang <yi.zhang@redhat.com>
>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>> ---
>>>> ? block/blk-cgroup.c | 7 ++++++-
>>>> ? 1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>>>> index 57941d2a8ba3..74fefc8cbcdf 100644
>>>> --- a/block/blk-cgroup.c
>>>> +++ b/block/blk-cgroup.c
>>>> @@ -1088,7 +1088,12 @@ static void blkcg_destroy_blkgs(struct blkcg *blkcg)
>>>> ? ????? might_sleep();
>>>> ? -??? css_get(&blkcg->css);
>>>> +??? /*
>>>> +???? * If css_tryget() fails, there is no blkg to destroy.
>>>> +???? */
>>>> +??? if (!css_tryget(&blkcg->css))
>>>> +??????? return;
>>>> +
>>>> ????? spin_lock_irq(&blkcg->lock);
>>>> ????? while (!hlist_empty(&blkcg->blkg_list)) {
>>>> ????????? struct blkcg_gq *blkg = hlist_entry(blkcg->blkg_list.first,
>>> This doesn't seem safe to me, but maybe I'm missing something. A tryget
>>> operation can be fine if we're under RCU lock and the entity is freed
>>> appropriately, but what makes it safe here? Could blkcg already be gone
>>> at this point?
>> The actual freeing of the blkcg structure is under RCU protection. So
>> the structure won't be freed immediately even if css_tryget() fails. I
>> suspect what Michal found may be the root cause of this problem. If
>> so, this is an existing bug which gets exposed by my patch.
> But what prevents it from going away here since you're not under RCU
> lock for the tryget? Doesn't help that the freeing side is done in an
> RCU safe manner, if the ref attempt is not.

You are right. blkcg_destroy_blkgs() shouldn't be called with all the 
blkcg references gone. Will work on a revised patch.

Cheers,
Longman

