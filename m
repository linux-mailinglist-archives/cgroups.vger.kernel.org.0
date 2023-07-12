Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5031774FCEA
	for <lists+cgroups@lfdr.de>; Wed, 12 Jul 2023 04:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjGLCCq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jul 2023 22:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjGLCCq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jul 2023 22:02:46 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09417171C;
        Tue, 11 Jul 2023 19:02:44 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R11C34RJnztRLn;
        Wed, 12 Jul 2023 09:59:43 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 10:02:42 +0800
Subject: Re: [PATCH] cgroup: remove unneeded return value of
 cgroup_rm_cftypes_locked()
To:     Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
CC:     <hannes@cmpxchg.org>, <lizefan.x@bytedance.com>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230701073856.2095425-1-linmiaohe@huawei.com>
 <ZKxeke6SfBe37Jso@slm.duckdns.org>
 <27428e7d-e280-2f78-7856-056d4e174057@huawei.com>
 <ZK3MR5liSMSrlKVm@slm.duckdns.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b197a86c-93bb-879e-34dc-f03c4e4f824c@huawei.com>
Date:   Wed, 12 Jul 2023 10:02:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ZK3MR5liSMSrlKVm@slm.duckdns.org>
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

On 2023/7/12 5:40, Tejun Heo wrote:
> On Tue, Jul 11, 2023 at 11:00:58AM +0800, Miaohe Lin wrote:
>> On 2023/7/11 3:40, Tejun Heo wrote:
>>> On Sat, Jul 01, 2023 at 03:38:56PM +0800, Miaohe Lin wrote:
>>>> The return value of cgroup_rm_cftypes_locked() is always 0. So remove
>>>> it to simplify the code. No functional change intended.
>>>>
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>
>>> Applied to cgroup/for-6.6. Please feel free to follow up with the comment
>>> addition Michal suggested.
>>
>> Should I send a v2 patch or a separate patch? Both is fine to me.
> 
> Please send a separate patch.

I see. But since Michal is meant adding the reasoning to the commit message, it seems
a v2 patch is required. Or could you help modify the commit message? It should looks
like:

"
The return value of cgroup_rm_cftypes_locked() is always 0 and swallowing
errors on removal is fine because cgroup_addrm_files() won't fail at
removal. So remove return value to simplify the code. No functional
change intended.
"

Thanks a lot.



