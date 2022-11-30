Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A031763D9C2
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 16:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiK3Pps (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 10:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiK3Ppo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 10:45:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA445813B3
        for <cgroups@vger.kernel.org>; Wed, 30 Nov 2022 07:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669823084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lHWzy0FM79r3PLFfRwF2L7xXZGTYCWGH6Me/ph3/zE0=;
        b=f3+8D26UfBV/qh3C1IDF4Xsb/KrmQ1goY32XuHC3xAzc9XnlCJN+vFooThJy+YEv+0L/FR
        DrImlRLRMmk86tuSf57Ypec2K13R296YIAxYqMGWYdB5Fljg5DC/IleQvkJjSkJxnIS8da
        3Falher+ZJja3uiZJDnil0gFPJ0Axuc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-ykxiv1TXOwGZ2tocqAhH0A-1; Wed, 30 Nov 2022 10:44:41 -0500
X-MC-Unique: ykxiv1TXOwGZ2tocqAhH0A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A4F13C0F437;
        Wed, 30 Nov 2022 15:44:39 +0000 (UTC)
Received: from [10.22.17.5] (unknown [10.22.17.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DE741415119;
        Wed, 30 Nov 2022 15:44:38 +0000 (UTC)
Message-ID: <d689d6d9-9206-028e-1363-8d7d77d55e79@redhat.com>
Date:   Wed, 30 Nov 2022 10:44:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH-block v2] bdi, blk-cgroup: Fix potential UAF of blkcg
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Yi Zhang <yi.zhang@redhat.com>
References: <20221129203400.1456100-1-longman@redhat.com>
 <20221130151639.GE27838@blackbody.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221130151639.GE27838@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 11/30/22 10:16, Michal Koutný wrote:
> On Tue, Nov 29, 2022 at 03:34:00PM -0500, Waiman Long <longman@redhat.com> wrote:
>> The reproducing system can no longer produce a warning with this patch.
>> All the runnable block/0* tests including block/027 were run successfully
>> without failure.
> Thanks for the test!
>
>> @@ -1088,7 +1088,15 @@ static void blkcg_destroy_blkgs(struct blkcg *blkcg)
>>   
>>   	might_sleep();
>>   
>> -	css_get(&blkcg->css);
>> +	/*
>> +	 * blkcg_destroy_blkgs() shouldn't be called with all the blkcg
>> +	 * references gone and rcu_read_lock not held.
>> +	 */
>> +	if (!css_tryget(&blkcg->css)) {
>> +		WARN_ON_ONCE(!rcu_read_lock_held());
>> +		return;
>> +	}
> As I followed the previous discussion, the principle is that obtaining a
> reference or being inside an RCU read section is sufficient.
>
> Consequently, I'd expect the two situations handled equally but here the
> no-ref but RCU bails out. (Which is OK because blkg_list must be empty?)
>
> However, the might_sleep() in (non-sleepable) RCU reader section combo
> makes me wary anyway (not with the early return but tools would likely
> complain).
>
> All in all, can't the contract of blkcg_destroy_blkgs() declare that
> a caller must pass blkcg with a valid reference? (The body of
> blkcg_destroy_blkgs then wouldn't need to get neither put the inner
> reference).

You are right. I should have pushed the might_sleep down(). Will post a 
new version to fix that.

Thanks,
Longman

