Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36D363797F
	for <lists+cgroups@lfdr.de>; Thu, 24 Nov 2022 13:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiKXM64 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Nov 2022 07:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiKXM6z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Nov 2022 07:58:55 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795447CB94;
        Thu, 24 Nov 2022 04:58:54 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NHyj75XmDzRpG4;
        Thu, 24 Nov 2022 20:58:19 +0800 (CST)
Received: from [10.174.178.129] (10.174.178.129) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 24 Nov 2022 20:58:50 +0800
Subject: Re: [PATCH 09/11] blk-throttle: remove unnecessary check for
 validation of limit index
To:     Tejun Heo <tj@kernel.org>
CC:     <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221123060401.20392-1-shikemeng@huawei.com>
 <20221123060401.20392-10-shikemeng@huawei.com>
 <Y35nG1CguzXf0GX8@slm.duckdns.org>
From:   Kemeng Shi <shikemeng@huawei.com>
Message-ID: <95ff6d32-7f4e-8ae3-8c95-4ce8ff111330@huawei.com>
Date:   Thu, 24 Nov 2022 20:58:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <Y35nG1CguzXf0GX8@slm.duckdns.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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



on 11/24/2022 2:31 AM, Tejun Heo wrote:
> On Wed, Nov 23, 2022 at 02:03:59PM +0800, Kemeng Shi wrote:
>> We always keep limit index valid as following:
>> Max limit is always valid and low limit can only be invalidated in
>> blk_throtl_update_limit_valid. Each time low limit may become invalid
>> after blk_throtl_update_limit_valid is called, we will check and make
>> sure current limit index is valid.
>>
>> It's reasonable to always keep limit index valid, so we can remove this
>> check.
> 
> It's not obvious to me that it's correct and I'm not sure what we're gaining
> by removing this while risking subtle breakages.
I will remove this patch in next version.

-- 
Best wishes
Kemeng Shi
