Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE647C7AA9
	for <lists+cgroups@lfdr.de>; Fri, 13 Oct 2023 01:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbjJLX4C (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Oct 2023 19:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbjJLX4B (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Oct 2023 19:56:01 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A006B8;
        Thu, 12 Oct 2023 16:55:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Vu0.XgP_1697154955;
Received: from 192.168.31.58(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vu0.XgP_1697154955)
          by smtp.aliyun-inc.com;
          Fri, 13 Oct 2023 07:55:56 +0800
Message-ID: <a6c1a1d7-870a-32ce-0ae1-44c2f5f15dbb@linux.alibaba.com>
Date:   Fri, 13 Oct 2023 07:55:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] writeback, cgroup: switch inodes with dirty timestamps to
 release dying cgwbs
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     guro@fb.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, jack@suse.cz,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org,
        joseph.qi@linux.alibaba.com
References: <20231011084228.77615-1-jefflexu@linux.alibaba.com>
 <ZSgtW0wGZZ3N3oKl@slm.duckdns.org>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <ZSgtW0wGZZ3N3oKl@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 10/13/23 1:31 AM, Tejun Heo wrote:
> On Wed, Oct 11, 2023 at 04:42:28PM +0800, Jingbo Xu wrote:
>> The cgwb cleanup routine will try to release the dying cgwb by switching
>> the attached inodes.  It fetches the attached inodes from wb->b_attached
>> list, omitting the fact that inodes only with dirty timestamps reside in
>> wb->b_dirty_time list, which is the case when lazytime is enabled.  This
>> causes enormous zombie memory cgroup when lazytime is enabled, as inodes
>> with dirty timestamps can not be switched to a live cgwb for a long time.
>>
>> It is reasonable not to switch cgwb for inodes with dirty data, as
>> otherwise it may break the bandwidth restrictions.  However since the
>> writeback of inode metadata is not accounted, let's also switch inodes
>> with dirty timestamps to avoid zombie memory and block cgroups when
>> laztytime is enabled.
>>
>> Fixs: c22d70a162d3 ("writeback, cgroup: release dying cgwbs by switching attached inodes")
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> 
> The patch looks fine to me.
> 
> ...
>> +	restart = isw_prepare_wbs_switch(isw, &wb->b_attached, &nr);
>> +	if (!restart)
>> +		restart = isw_prepare_wbs_switch(isw, &wb->b_dirty_time, &nr);
> 
> But can you add a comment explaining why we're also migrating b_dirty_time?

Will add the comment in the next version.  Thanks.


-- 
Thanks,
Jingbo
