Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67C6486F62
	for <lists+cgroups@lfdr.de>; Fri,  7 Jan 2022 02:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344216AbiAGBEt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Jan 2022 20:04:49 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17330 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236544AbiAGBEt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Jan 2022 20:04:49 -0500
Received: from kwepemi100007.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JVQ2l2KF4z920b;
        Fri,  7 Jan 2022 09:03:43 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100007.china.huawei.com (7.221.188.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 09:04:46 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 09:04:45 +0800
Subject: Re: [PATCH 4/4] block, bfq: update pos_root for idle bfq_queue in
 bfq_bfqq_move()
To:     Jan Kara <jack@suse.cz>
CC:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <fchecconi@gmail.com>, <avanzini.arianna@gmail.com>,
        <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20211221032135.878550-1-yukuai3@huawei.com>
 <20211221032135.878550-5-yukuai3@huawei.com>
 <20211221115001.GD24748@quack2.suse.cz>
 <6ca1e924-47fa-b94e-598c-69a9549eb68e@huawei.com>
 <20211222141722.GC685@quack2.suse.cz>
 <9743fc5a-f3f0-a23a-5d21-0c04c90e90e1@huawei.com>
 <5b42943f-4a8e-c4ec-05da-57e36cc14113@huawei.com>
 <20220103153732.pcfsmadzlqqroxcj@quack3>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <44c41001-c072-8e13-77e3-c19b8c12ab41@huawei.com>
Date:   Fri, 7 Jan 2022 09:04:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220103153732.pcfsmadzlqqroxcj@quack3>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

在 2022/01/03 23:37, Jan Kara 写道:
> OK, thanks for following up on this. So do I understand you correctly that
> the problem with empty bfqq being in pos_tree does not exist in current
> upstream kernel?

Yes, I had this patch removed in v2 patchset.

Thanks,
Kuai
