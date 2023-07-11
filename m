Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E416074E495
	for <lists+cgroups@lfdr.de>; Tue, 11 Jul 2023 04:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjGKC67 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jul 2023 22:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjGKC66 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jul 2023 22:58:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D449E7C;
        Mon, 10 Jul 2023 19:58:52 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R0QVH1Q4LztR8t;
        Tue, 11 Jul 2023 10:55:51 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 10:58:48 +0800
Subject: Re: [PATCH] cgroup: remove unneeded return value of
 cgroup_rm_cftypes_locked()
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
CC:     <tj@kernel.org>, <hannes@cmpxchg.org>, <lizefan.x@bytedance.com>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230701073856.2095425-1-linmiaohe@huawei.com>
 <ue4duahv6scnn64zgduuhiyq2gh33w7x5ftdffw3uqcn4ahyd2@txxtxf2fkzp2>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <7d3323ab-f796-6846-ab08-5d48734595e1@huawei.com>
Date:   Tue, 11 Jul 2023 10:58:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ue4duahv6scnn64zgduuhiyq2gh33w7x5ftdffw3uqcn4ahyd2@txxtxf2fkzp2>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2023/7/10 23:46, Michal Koutný wrote:
> Hi.
> 
> On Sat, Jul 01, 2023 at 03:38:56PM +0800, Miaohe Lin <linmiaohe@huawei.com> wrote:
>> The return value of cgroup_rm_cftypes_locked() is always 0. So remove
>> it to simplify the code. No functional change intended.
> 
> I'd add a comment that it builds upon cgroup_addrm_files()'s:

Do you mean something like below:

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index b0d98542eea2..2c02f319a7d4 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4320,6 +4320,7 @@ static int cgroup_init_cftypes(struct cgroup_subsys *ss, struct cftype *cfts)
        return ret;
 }

+/* It builds upon cgroup_addrm_files()'s. */
 static void cgroup_rm_cftypes_locked(struct cftype *cfts)
 {
        lockdep_assert_held(&cgroup_mutex);


>> For removals, this function never fails.
> 
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  kernel/cgroup/cgroup.c | 9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> Reviewed-by: Michal Koutný <mkoutny@suse.com>

Thanks for review and suggestion.

