Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5CA64BDA4
	for <lists+cgroups@lfdr.de>; Tue, 13 Dec 2022 20:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236586AbiLMTyt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Dec 2022 14:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236532AbiLMTys (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Dec 2022 14:54:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2A926559
        for <cgroups@vger.kernel.org>; Tue, 13 Dec 2022 11:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670961241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q04pXB0nuaw4NyeT98qJ4CK1uIQuz5FaT/xQVCDx6WM=;
        b=JCmwPGxirhGJYKpRyt1r9ZyNe7o0QqLX9XGScrZu9kV2Cc5LoKErZ+CCYtrUMVV4pb3rGs
        wjANjJq/x/oZDvTsqZ9PfvUV/FyWVhWLIXf0o2SbJGEb6XEekn7IX47FSlUOX/7wLpC6mI
        qxXx9AYuGe/bi1QoiXo8zJJ4CPvedkU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-mkDnArbIMqqYOe1_pd7cpA-1; Tue, 13 Dec 2022 14:53:56 -0500
X-MC-Unique: mkDnArbIMqqYOe1_pd7cpA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6C4E1C0756D;
        Tue, 13 Dec 2022 19:53:55 +0000 (UTC)
Received: from [10.22.32.205] (unknown [10.22.32.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3446492C14;
        Tue, 13 Dec 2022 19:53:54 +0000 (UTC)
Message-ID: <34a8c4a7-a58d-63fc-4599-accf1cbb6aae@redhat.com>
Date:   Tue, 13 Dec 2022 14:53:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH-block v3 1/2] bdi, blk-cgroup: Fix potential UAF of blkcg
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Yi Zhang <yi.zhang@redhat.com>
References: <20221213184446.50181-1-longman@redhat.com>
 <20221213184446.50181-2-longman@redhat.com>
 <Y5jSllwwBdmQ1jQz@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y5jSllwwBdmQ1jQz@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 12/13/22 14:29, Tejun Heo wrote:
> On Tue, Dec 13, 2022 at 01:44:45PM -0500, Waiman Long wrote:
>> Commit 59b57717fff8 ("blkcg: delay blkg destruction until after
>> writeback has finished") delayed call to blkcg_destroy_blkgs() to
>> cgwb_release_workfn(). However, it is done after a css_put() of blkcg
>> which may be the final put that causes the blkcg to be freed as RCU
>> read lock isn't held.
>>
>> Another place where blkcg_destroy_blkgs() can be called indirectly via
>> blkcg_unpin_online() is from the offline_css() function called from
>> css_killed_work_fn(). Over there, the potentially final css_put() call
>> is issued after offline_css().
>>
>> By adding a css_tryget() into blkcg_destroy_blkgs() and warning its
>> failure, the following stack trace was produced in a test system on
>> bootup.
> This doesn't agree with the code anymore. Otherwise
>
> Acked-by: Tejun Heo <tj@kernel.org>

Sorry, I overlooked the commit log in my update. I will update it if I 
need another version, or Jens can make the following edit:

css_tryget() -> percpu_ref_is_zero().

Thanks,
Longman

