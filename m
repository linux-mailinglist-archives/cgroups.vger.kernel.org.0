Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBF263797B
	for <lists+cgroups@lfdr.de>; Thu, 24 Nov 2022 13:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiKXM63 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Nov 2022 07:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiKXM6V (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Nov 2022 07:58:21 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D479E979;
        Thu, 24 Nov 2022 04:58:14 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NHyhM6FWFz15Mb6;
        Thu, 24 Nov 2022 20:57:39 +0800 (CST)
Received: from [10.174.178.129] (10.174.178.129) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 24 Nov 2022 20:58:11 +0800
Subject: Re: [PATCH 08/11] blk-throttle: remove repeat check of elapsed time
 from last upgrade in throtl_hierarchy_can_downgrade
To:     Tejun Heo <tj@kernel.org>
CC:     <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221123060401.20392-1-shikemeng@huawei.com>
 <20221123060401.20392-9-shikemeng@huawei.com>
 <Y35mXymUTC1lx50j@slm.duckdns.org>
From:   Kemeng Shi <shikemeng@huawei.com>
Message-ID: <1f2bb84b-6c8b-aaf1-053a-46fe8c773767@huawei.com>
Date:   Thu, 24 Nov 2022 20:58:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <Y35mXymUTC1lx50j@slm.duckdns.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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



on 11/24/2022 2:28 AM, Tejun Heo wrote:
> On Wed, Nov 23, 2022 at 02:03:58PM +0800, Kemeng Shi wrote:
>>  static bool throtl_hierarchy_can_downgrade(struct throtl_grp *tg)
>>  {
>> +	if (time_before(now, tg->td->low_upgrade_time + td->throtl_slice))
>> +		return false;
> 
> Does this even build? Where is td defined?
Sorry for this mistake, CONFIG_BLK_DEV_THROTTLING_LOW seems not be set on
default. I will fix this and build with CONFIG_BLK_DEV_THROTTLING_LOW
set.

-- 
Best wishes
Kemeng Shi
