Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CC376AA41
	for <lists+cgroups@lfdr.de>; Tue,  1 Aug 2023 09:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjHAHsP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Aug 2023 03:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjHAHsO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Aug 2023 03:48:14 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A033E48;
        Tue,  1 Aug 2023 00:48:13 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RFRvw6VZWzNmP2;
        Tue,  1 Aug 2023 15:44:44 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 15:48:09 +0800
Subject: Re: [PATCH] cgroup: minor cleanup for cgroup_local_stat_show()
To:     Tejun Heo <tj@kernel.org>
CC:     <hannes@cmpxchg.org>, <lizefan.x@bytedance.com>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230723031932.3152951-1-linmiaohe@huawei.com>
 <ZMBERCXR27X_gRAt@slm.duckdns.org>
 <ec3df402-7681-3d0c-b9ce-d50eb7383b1e@huawei.com>
 <719a19c4-3be5-2260-7349-b3f1bb774f4f@huawei.com>
 <ZMhIFUsxEtA_B781@slm.duckdns.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3ec1f5d9-4887-4583-a973-92298a9bc924@huawei.com>
Date:   Tue, 1 Aug 2023 15:48:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ZMhIFUsxEtA_B781@slm.duckdns.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2023/8/1 7:47, Tejun Heo wrote:
> On Thu, Jul 27, 2023 at 07:50:11PM +0800, Miaohe Lin wrote:
>> On 2023/7/26 9:06, Miaohe Lin wrote:
>>> On 2023/7/26 5:53, Tejun Heo wrote:
>>>> On Sun, Jul 23, 2023 at 11:19:32AM +0800, Miaohe Lin wrote:
>>>>> Make it under CONFIG_CGROUP_SCHED to rid of __maybe_unused annotation.
>>>>> Also put cgroup_tryget_css() inside CONFIG_CGROUP_SCHED as it's only
>>>>> called when CONFIG_CGROUP_SCHED. No functional change intended.
>>>>>
>>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>>
>>>> Patch doesn't apply to cgroup/for-6.6. Can you please respin?
>>>
>>> Sure. Will resend the patch based on cgroup/for-6.6.
>>
>> The commit "sched: add throttled time stat for throttled children" is still in the linux-next tree. So I think I have
>> to wait for it to be merged into cgroup tree first.
> 
> You can just send the patch against cgroup/for-6.6 branch. We can sort out
> the merge conflicts later.

Do you mean send the patch against cgroup/for-6.6 branch assuming commit "sched: add throttled time stat for throttled children"
has been merged into cgroup/for-6.6 branch? It seems the current code in that branch is fine itself.

Thanks for your advice.


