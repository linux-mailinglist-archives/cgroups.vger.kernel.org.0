Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F3562CE81
	for <lists+cgroups@lfdr.de>; Thu, 17 Nov 2022 00:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbiKPXHX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Nov 2022 18:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbiKPXHT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Nov 2022 18:07:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEFE32066
        for <cgroups@vger.kernel.org>; Wed, 16 Nov 2022 15:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668639979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fWNz/QE0hFws1BC7T/rZzODjo9Sug+sYTjrv+WWI+bk=;
        b=U5cX8q78eexoRCHQ34zKOt1YbXrznKq2JiF5P6JleTXSOXmZUlG7xEoSwnb3G80xSDO7Tb
        QR7ulssHqYlYV1FiclBW3G0ml9sh6QsY1XMhWPmtdqXz/YmqpHUZPeMj2bNtwn8Ak11bXo
        wSD7KLeZnecoJm8fHRyF7mD2Pb08TQw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-Kh4_YGnwNsCefQGPtUsbUA-1; Wed, 16 Nov 2022 18:06:16 -0500
X-MC-Unique: Kh4_YGnwNsCefQGPtUsbUA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED237811E67;
        Wed, 16 Nov 2022 23:06:15 +0000 (UTC)
Received: from [10.22.10.207] (unknown [10.22.10.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35079C1908A;
        Wed, 16 Nov 2022 23:06:15 +0000 (UTC)
Message-ID: <4b5142be-6a47-9dfd-a238-5b9d29b296b8@redhat.com>
Date:   Wed, 16 Nov 2022 18:06:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v10 0/3] blk-cgroup: Optimize blkcg_rstat_flush()
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>, Tejun Heo <tj@kernel.org>
References: <20221105005902.407297-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221105005902.407297-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/4/22 20:58, Waiman Long wrote:
>   v10:
>    - Update patch 3 to rename the rstat function to
>      cgroup_rstat_css_cpu_flush().
>
>   v9:
>    - Remove patch "llist: Allow optional sentinel node terminated lockless
>      list" for now. This will be done as a follow-up patch.
>    - Add a new lqueued field to blkg_iostat_set to store the status of
>      whether lnode is in a lockless list.
>    - Add a new patch 3 to speed up the freeing of blkcg by flushing out
>      the rstat lockless lists at blkcg offline time.
>
>   v8:
>    - Update the llist patch to make existing llist functions and macros
>      work for both NULL and sentinel terminated lockless list as much
>      as possible and leave only the initialization and removal functions
>      to have a sentinel terminated llist variants.
>
> This patch series improves blkcg_rstat_flush() performance by eliminating
> unnecessary blkg enumeration and flush operations for those blkg's and
> blkg_iostat_set's that haven't been updated since the last flush.
>
> Waiman Long (3):
>    blk-cgroup: Return -ENOMEM directly in blkcg_css_alloc() error path
>    blk-cgroup: Optimize blkcg_rstat_flush()
>    blk-cgroup: Flush stats at blkgs destruction path
>
>   block/blk-cgroup.c     | 103 +++++++++++++++++++++++++++++++++++------
>   block/blk-cgroup.h     |  10 ++++
>   include/linux/cgroup.h |   1 +
>   kernel/cgroup/rstat.c  |  20 ++++++++
>   4 files changed, 119 insertions(+), 15 deletions(-)

Jens, do you have any further comment on this patchset? Is it possible 
to queue it for the next Linux version?

Cheers,
Longman

