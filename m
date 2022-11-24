Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19FC6377DF
	for <lists+cgroups@lfdr.de>; Thu, 24 Nov 2022 12:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiKXLrU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Nov 2022 06:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiKXLrT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Nov 2022 06:47:19 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813E8AFE60;
        Thu, 24 Nov 2022 03:47:18 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NHx6W4vrMzmW7g;
        Thu, 24 Nov 2022 19:46:43 +0800 (CST)
Received: from [10.174.178.129] (10.174.178.129) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 24 Nov 2022 19:47:16 +0800
Subject: Re: [PATCH 01/11] blk-throttle: Limit whole system if root group is
 configured when on the default hierarchy
To:     Tejun Heo <tj@kernel.org>
CC:     <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221123060401.20392-1-shikemeng@huawei.com>
 <20221123060401.20392-2-shikemeng@huawei.com>
 <Y35UVRg0tTfsTdrB@slm.duckdns.org>
From:   Kemeng Shi <shikemeng@huawei.com>
Message-ID: <2c477253-eb89-260f-adde-5850d749b000@huawei.com>
Date:   Thu, 24 Nov 2022 19:47:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <Y35UVRg0tTfsTdrB@slm.duckdns.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



on 11/24/2022 1:11 AM, Tejun Heo wrote:
> On Wed, Nov 23, 2022 at 02:03:51PM +0800, Kemeng Shi wrote:
>> Quoted from comment in throtl_pd_init: "If on the default hierarchy, we
>> switch to properly hierarchical behavior where limits on a given
>> throtl_grp are applied to the whole subtree rather than just the group
>> itself. e.g. If 16M read_bps limit is set on the root group, the whole
>> system can' exceed 16M for the device."
> 
> On the default hierarchy (cgroup2), the throttle interface files don't exist
> in the root cgroup. In general, cgroup doesn't wanna be in the business of
> restricting resources at the system level.
Hi, Tejun. Thanks for review. If restricting is not needed anymore, the stale
comment "e.g. If 16M read_bps limit is set on the root group, the whole system
can' exceed 16M for the device." may better be remove. I will remove this
in next version.


-- 
Best wishes
Kemeng Shi
