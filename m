Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50C5529964
	for <lists+cgroups@lfdr.de>; Tue, 17 May 2022 08:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiEQGQJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 May 2022 02:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiEQGQI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 May 2022 02:16:08 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2760377F6;
        Mon, 16 May 2022 23:16:05 -0700 (PDT)
Received: from kwepemi100018.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L2Qln5BPLzGpnN;
        Tue, 17 May 2022 14:13:09 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100018.china.huawei.com (7.221.188.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 14:16:03 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 14:16:02 +0800
Subject: Re: [PATCH -next] block: fix io hung of setting throttle limit
 frequently
To:     Tejun Heo <tj@kernel.org>
CC:     Zhang Wensheng <zhangwensheng5@huawei.com>,
        "ming.lei@redhat.com >> Ming Lei" <ming.lei@redhat.com>,
        <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>
References: <20220516014429.33723-1-zhangwensheng5@huawei.com>
 <YoKmCOAzwzw3Lz7g@slm.duckdns.org>
 <ca251645-8d52-7a93-6ac2-579d97922a9e@huawei.com>
 <YoMiJIUehq1UyzgQ@slm.duckdns.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <8abf8186-c5c3-47c1-7acd-9116f127fd03@huawei.com>
Date:   Tue, 17 May 2022 14:16:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YoMiJIUehq1UyzgQ@slm.duckdns.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ÔÚ 2022/05/17 12:18, Tejun Heo Ð´µÀ:
> On Tue, May 17, 2022 at 11:12:28AM +0800, yukuai (C) wrote:
>> Ming added a condition in tg_with_in_bps_limit():
>> -       if (bps_limit == U64_MAX) {
>> +       /* no need to throttle if this bio's bytes have been accounted */
>> +       if (bps_limit == U64_MAX || bio_flagged(bio, BIO_THROTTLED)) {
>>
>> Which will let the first throttled bio to be issued immediately once
>> the config if updated.
>>
>> Do you think this behaviour is OK? If so, we can do the same for
>> tg_with_in_iops_limit.
> 
> So, the current behavior is that if the user is being silly, it will get
> slower and slower. The new behavior would be that if the user is being
> silly, it can issue IOs faster and faster, which creates a perverse
> incentive to be silly.
Yes,

I just found that Ming's patch introduce a new problem:

If multiple bios are throttled, then they will be issued one by one with
corresponding time. However, after Ming's patch, all throttled bios will
be issued immediately once the waiting time of first bio is reached. And
such behaviour is definitely a problem...

> 
> Probably the right thing to do is probably something like translating the
> existing budget in light of the new configuration so that config change
> neither gives or takes away the budget which has already accumulated. That
> said, are you guys seeing this becoming an issue in practice?

Agreed, the solution sounds reasonable. And this problem is found during
test, which issue a large io and in the meantime updating config with
random value.

Thanks,
Kuai
> 
> Thanks.
> 
