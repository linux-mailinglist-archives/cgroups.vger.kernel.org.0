Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D085B64AC4D
	for <lists+cgroups@lfdr.de>; Tue, 13 Dec 2022 01:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbiLMAYr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Dec 2022 19:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbiLMAYQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Dec 2022 19:24:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2891B3
        for <cgroups@vger.kernel.org>; Mon, 12 Dec 2022 16:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670890910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XSSw4rDrHdkebs9yVeYoOqKNZTGifGu/wo1Yfh7rryY=;
        b=LpnkpXwiA6lo5Rx29Ts9A9UcJB+WbCqonBpKaI0fFkICcPGppOdnU7SnCTV3UF3Aiv1AH+
        F5Lu1e6JEoaKeJo6f9NBgATxf1gmmKBpfTIq4uHFzjbz4j0s9LSq95pvPhp7Ticm2MdzWp
        +LO8z2SCe7zYbFGr7jE06ooQWLHxmj0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-GEEItmPjPjSumL71UddJfg-1; Mon, 12 Dec 2022 19:21:46 -0500
X-MC-Unique: GEEItmPjPjSumL71UddJfg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BCB385A5A6;
        Tue, 13 Dec 2022 00:21:45 +0000 (UTC)
Received: from [10.22.11.98] (unknown [10.22.11.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3D8D492C14;
        Tue, 13 Dec 2022 00:21:44 +0000 (UTC)
Message-ID: <1fe8b5b3-c066-649b-fa4a-07d67ed7eb17@redhat.com>
Date:   Mon, 12 Dec 2022 19:21:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH-block v2 2/3] blk-cgroup: Don't flush a blkg if destroyed
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
References: <20221211222058.2946830-1-longman@redhat.com>
 <20221211222058.2946830-3-longman@redhat.com>
 <20221212125953.GE16456@blackbody.suse.cz> <Y5eoQ8UBN8Xpc+Wp@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y5eoQ8UBN8Xpc+Wp@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/12/22 17:16, Tejun Heo wrote:
> On Mon, Dec 12, 2022 at 01:59:53PM +0100, Michal Koutný wrote:
>> Hello.
>>
>> On Sun, Dec 11, 2022 at 05:20:57PM -0500, Waiman Long <longman@redhat.com> wrote:
>>> Before commit 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()"),
>>> blkg's stats is only flushed if they are online.
>> I'm not sure I follow -- css_release_work_fn/cgroup_rstat_flush may be
>> called on an offlined blkcg (offlined!=released). There's no invariant
>> ensuring offlined blkcg won't be flushed. (There is only current
>> situation when there is no reader of io data that'd need them flushed
>> [1].)
>>
>>> In addition, the stat flushing of blkgs in blkcg_rstat_flush()
>>> includes propagating the rstat data to its parent. However, if a blkg
>>> has been destroyed (offline), the validity of its parent may be
>>> questionable.
>> Parents won't be freed (neither offlined) before children (see
>> css_killed_work_fn). It should be regularly OK to pass data into a
>> parent of an offlined blkcg.
>>
>>> For safety, revert back to the old behavior by ignoring offline
>>> blkg's.
>> I don't know if this is a good reasoning. If you argue that offlined
>> children needn't be taken into parent's account, then I think it's more
>> efficient to exclude the offlined blkcgs from update. (With the caveat I
>> have in [1].)
> Yeah, I'm not sure about this patch either. Doesn't seem necessary.

I wrote this patch because I am not totally sure it is safe to flush 
offline blkgs. Since both you and Michal don't see any problem with it. 
I am fine taking it out.

Cheers,
Longman

