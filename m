Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755947652E9
	for <lists+cgroups@lfdr.de>; Thu, 27 Jul 2023 13:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjG0LuP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Jul 2023 07:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjG0LuP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Jul 2023 07:50:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8563D1FDA;
        Thu, 27 Jul 2023 04:50:14 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RBTZP0bKlzrRqV;
        Thu, 27 Jul 2023 19:49:17 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 19:50:11 +0800
Subject: Re: [PATCH] cgroup: minor cleanup for cgroup_local_stat_show()
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     Tejun Heo <tj@kernel.org>
CC:     <hannes@cmpxchg.org>, <lizefan.x@bytedance.com>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230723031932.3152951-1-linmiaohe@huawei.com>
 <ZMBERCXR27X_gRAt@slm.duckdns.org>
 <ec3df402-7681-3d0c-b9ce-d50eb7383b1e@huawei.com>
Message-ID: <719a19c4-3be5-2260-7349-b3f1bb774f4f@huawei.com>
Date:   Thu, 27 Jul 2023 19:50:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ec3df402-7681-3d0c-b9ce-d50eb7383b1e@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2023/7/26 9:06, Miaohe Lin wrote:
> On 2023/7/26 5:53, Tejun Heo wrote:
>> On Sun, Jul 23, 2023 at 11:19:32AM +0800, Miaohe Lin wrote:
>>> Make it under CONFIG_CGROUP_SCHED to rid of __maybe_unused annotation.
>>> Also put cgroup_tryget_css() inside CONFIG_CGROUP_SCHED as it's only
>>> called when CONFIG_CGROUP_SCHED. No functional change intended.
>>>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>
>> Patch doesn't apply to cgroup/for-6.6. Can you please respin?
> 
> Sure. Will resend the patch based on cgroup/for-6.6.

The commit "sched: add throttled time stat for throttled children" is still in the linux-next tree. So I think I have
to wait for it to be merged into cgroup tree first.

[1] https://lore.kernel.org/all/20230620183247.737942-2-joshdon@google.com/

Thanks.

> 
> Thanks.
> 
> 

