Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57578710F83
	for <lists+cgroups@lfdr.de>; Thu, 25 May 2023 17:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241787AbjEYPZ5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 May 2023 11:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241737AbjEYPZz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 May 2023 11:25:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B793E99
        for <cgroups@vger.kernel.org>; Thu, 25 May 2023 08:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685028311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fMrxhWgLyOUzKMB1Tal5g/FIIXS1y2NZ/71A12nEoZg=;
        b=RZqLRQIbG+ECn3iQXrIExaPkNFiYs7HaNZMdFpWgOftekITSrcTbCn3bFnF2x4FhhGF9lW
        M6Q4VKMQ0CrnMll9NtzVUpL8IBZ6hw3b8XbbhfSH7t8NSl+54MQPj/43JvGhTAvvsAIhmf
        jZrZOwyVRu9sVH5wez0oTkqkou5Rkeo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-XCMsCKYJOO6W5oEI60bWgw-1; Thu, 25 May 2023 11:25:08 -0400
X-MC-Unique: XCMsCKYJOO6W5oEI60bWgw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48370282CCAC;
        Thu, 25 May 2023 15:25:06 +0000 (UTC)
Received: from [10.22.34.46] (unknown [10.22.34.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 742B11121314;
        Thu, 25 May 2023 15:25:05 +0000 (UTC)
Message-ID: <8f56f60f-8dd3-d798-3d81-6ccbb185465d@redhat.com>
Date:   Thu, 25 May 2023 11:25:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] blk-cgroup: Flush stats before releasing blkcg_gq
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>, Linux-MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>
References: <20230524011935.719659-1-ming.lei@redhat.com>
 <CAJD7tkZkbro4H-QC=RJx_dfCdGQ5c=4NJhbFrcEmQSidaaMOmg@mail.gmail.com>
 <ZG14VnHl20lt9jLc@ovpn-8-17.pek2.redhat.com>
 <3ej42djuuzwx36yf2yeo5ggyrvogeaguos5jtve2bvuaejnwff@fak3yjwe2fbi>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <3ej42djuuzwx36yf2yeo5ggyrvogeaguos5jtve2bvuaejnwff@fak3yjwe2fbi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 5/25/23 10:11, Michal Koutný wrote:
> On Wed, May 24, 2023 at 10:37:10AM +0800, Ming Lei <ming.lei@redhat.com> wrote:
>>> I am not at all familiar with blkcg, but does calling
>>> cgroup_rstat_flush() in offline_css() fix the problem?
>> Except for offline, this list needs to be flushed after the associated disk
>> is deleted.
> Why the second flush trigger?
> a) To break another ref-dependency cycle (like on the blkcg side)?
> b) To avoid stale data upon device removal?
>
> (Because b) should be unnecessary, a future reader would flush when
> needed.)

Since the percpu blkg_iostat_set's that are linked in the lockless list 
will be freed if the corresponding blkcg_gq is freed, we need to flush 
the lockless list to avoid potential use-after-free in a future 
cgroup_rstat_flush*() call.

Cheers,
Longman

