Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2F26873CA
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 04:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBBD1g (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Feb 2023 22:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBBD1f (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Feb 2023 22:27:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1B34FC13
        for <cgroups@vger.kernel.org>; Wed,  1 Feb 2023 19:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675308411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SomATYxJ25mjdEUM/kMCsDAyR8EdHP8aHoITCDKVtgQ=;
        b=IT17UoitWCUWPUWP8VKZjUI/SXJPuo+gs02xzscBWJQw0RK3Xrqf3gIXhyKsdOTxNZM9F4
        2ooLMTELDGApms0GknFius3mOzEiP8qyykYzDCX1C868AafZfhJvWrgdSH/MhWzwiyrG6Y
        CYE471ULbUSemWhn7BMRrNbbXUDWE70=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-CSEqgLmZP6GHOFnI3P5FfA-1; Wed, 01 Feb 2023 22:26:47 -0500
X-MC-Unique: CSEqgLmZP6GHOFnI3P5FfA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE14C29AA2C5;
        Thu,  2 Feb 2023 03:26:46 +0000 (UTC)
Received: from [10.22.32.115] (unknown [10.22.32.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4CCE62166B33;
        Thu,  2 Feb 2023 03:26:46 +0000 (UTC)
Message-ID: <4db0b257-4c8b-6e30-0c72-b581198d4a68@redhat.com>
Date:   Wed, 1 Feb 2023 22:26:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 0/2] blk-cgroup: Fix potential UAF & flush rstat at
 blkgs destruction path
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
References: <20221215033132.230023-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221215033132.230023-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 12/14/22 22:31, Waiman Long wrote:
>   v4:
>    - Update comment and commit logs for both patches.
>
>   v3:
>    - Drop v2 patch 2 as it may not be needed.
>    - Replace css_tryget() with percpu_ref_is_zero() in patch 1 as
>      suggested by Tejun.
>    - Expand comment on patch 2 to elaborate the reason for this patch.
>
>   v2:
>    - Remove unnecessary rcu_read_{lock|unlock} from
>      cgroup_rstat_css_cpu_flush() in patch 3.
>
> It was found that blkcg_destroy_blkgs() may be called with all blkcg
> references gone. This may potentially cause user-after-free and so should
> be fixed. The second patch flushes rstat when calling blkcg_destroy_blkgs().
>
> Waiman Long (2):
>    bdi, blk-cgroup: Fix potential UAF of blkcg
>    blk-cgroup: Flush stats at blkgs destruction path
>
>   block/blk-cgroup.c     | 23 +++++++++++++++++++++++
>   include/linux/cgroup.h |  1 +
>   kernel/cgroup/rstat.c  | 18 ++++++++++++++++++
>   mm/backing-dev.c       |  8 ++++++--
>   4 files changed, 48 insertions(+), 2 deletions(-)
>
Ping!

Any comments on these patches.

Thanks,
Longman

