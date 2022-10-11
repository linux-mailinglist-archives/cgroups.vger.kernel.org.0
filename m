Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC75C5FA996
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 03:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJKBEz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Oct 2022 21:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJKBEw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Oct 2022 21:04:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D653206B;
        Mon, 10 Oct 2022 18:04:50 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mmcs34dN2zVhpb;
        Tue, 11 Oct 2022 09:00:23 +0800 (CST)
Received: from [10.174.178.129] (10.174.178.129) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 09:04:47 +0800
Subject: Re: [PATCH 1/4] blk-cgroup: Remove unnecessary blk_ioprio_exit in
 blkcg_init_queue
To:     Christoph Hellwig <hch@infradead.org>
CC:     <tj@kernel.org>, <axboe@kernel.dk>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221010023859.11896-1-shikemeng@huawei.com>
 <20221010023859.11896-2-shikemeng@huawei.com>
 <Y0PLwj/l/l4QPpTC@infradead.org>
From:   Kemeng Shi <shikemeng@huawei.com>
Message-ID: <79030a54-aaeb-4115-03a9-d8f69b63b919@huawei.com>
Date:   Tue, 11 Oct 2022 09:04:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <Y0PLwj/l/l4QPpTC@infradead.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



on 10/10/2022 3:37 PM, Christoph Hellwig wrote:
> On Mon, Oct 10, 2022 at 10:38:56AM +0800, Kemeng Shi wrote:
>> Function blk_ioprio_init only alloc blkg_policy_data which will be freed
>> in blkg_destroy_all, so no blk_ioprio_exit is called when blk_throtl_init
>> is failed in blkcg_init_queue. Also blk_ioprio_exit is not called in
>> blkcg_exit_queue for the same reason. Just remove blk_ioprio_exit to
>> keep behavior consistent.
> 
> This code looks very different in current mainline.
Thanks for review. I will remove this patch and make new patches based on
mainline code.
-- 
Best wishes
Kemeng Shi
