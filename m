Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09774DE52F
	for <lists+cgroups@lfdr.de>; Sat, 19 Mar 2022 03:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiCSCgU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Mar 2022 22:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiCSCgT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Mar 2022 22:36:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BFB2BB7CD;
        Fri, 18 Mar 2022 19:34:56 -0700 (PDT)
Received: from kwepemi100021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KL4gT15LCzfYqy;
        Sat, 19 Mar 2022 10:33:25 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100021.china.huawei.com (7.221.188.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 19 Mar 2022 10:34:54 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 19 Mar 2022 10:34:54 +0800
Subject: Re: [PATCH -next 00/11] support concurrent sync io for bfq on a
 specail occasion
To:     Paolo Valente <paolo.valente@linaro.org>
CC:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, <cgroups@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220305091205.4188398-1-yukuai3@huawei.com>
 <e299180e-cdbd-0837-8478-5e397ac8166b@huawei.com>
 <11fda851-a552-97ea-d083-d0288c17ba53@huawei.com>
 <1AE1457D-AAE1-4A13-8593-451E9396028A@linaro.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <3325eb4b-5513-694f-df59-364cb1c86eb5@huawei.com>
Date:   Sat, 19 Mar 2022 10:34:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1AE1457D-AAE1-4A13-8593-451E9396028A@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

在 2022/03/18 20:38, Paolo Valente 写道:
> Hi,
> could you please add pointers to the thread(s) where we have already revised this series (if we have). I don't see any reference to that in this cover letter.

Hi,

Ok, sorry for that, following is the previours threads.

This is a new patchset after RFC
- Fix some term in commit messages and comments
- Add some cleanup patches

New RFC: use a new solution, and it has little relevance to
previous versions.
https://lore.kernel.org/lkml/20211127101132.486806-1-yukuai3@huawei.com/T/
- as suggested by Paolo, count root group into
'num_groups_with_pending_reqs' instead of handling root group
separately.
- Change the patchset title
- New changes about when to modify 'num_groups_with_pending_reqs'

Orignal v4:
https://lore.kernel.org/lkml/20211014014556.3597008-2-yukuai3@huawei.com/t/
  - fix a compile warning when CONFIG_BLK_CGROUP is not enabled.

Orignal v3:
https://www.spinics.net/lists/linux-block/msg74836.html
  - Instead of tracking each queue in root group, tracking root group
  directly just like non-root group does.
  - remove patch 3,4 from these series.

Orignal v2:
https://lore.kernel.org/lkml/20210806020826.1407257-1-yukuai3@huawei.com/
- as suggested by Paolo, add support to track if root_group have any
  pending requests, and use that to handle the situation when only one
  group is activated while root group doesn't have any pending requests.
  - modify commit message in patch 2
