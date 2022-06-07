Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D22A53FFAA
	for <lists+cgroups@lfdr.de>; Tue,  7 Jun 2022 15:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiFGNHB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Jun 2022 09:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239390AbiFGNHB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Jun 2022 09:07:01 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F69B41D3;
        Tue,  7 Jun 2022 06:06:59 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LHVvT6BVJz1KB26;
        Tue,  7 Jun 2022 21:05:09 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 21:06:57 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 21:06:56 +0800
Subject: Re: [PATCH -next v5 0/3] support concurrent sync io for bfq on a
 specail occasion
From:   Yu Kuai <yukuai3@huawei.com>
To:     Jan Kara <jack@suse.cz>
CC:     <paolo.valente@linaro.org>, <tj@kernel.org>,
        <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20220428120837.3737765-1-yukuai3@huawei.com>
 <d50df657-d859-79cf-c292-412eaa383d2c@huawei.com>
 <61b67d5e-829c-8130-7bda-81615d654829@huawei.com>
 <81411289-e13c-20f5-df63-c059babca57a@huawei.com>
 <d5a90a08-1ac6-587a-e900-0436bd45543a@kernel.dk>
 <55919e29-1f22-e8aa-f3d2-08c57d9e1c22@huawei.com>
 <20220523085902.wmxoebyq3crerecr@quack3.lan>
 <25f6703e-9e10-75d9-a893-6df1e6b75254@kernel.dk>
 <20220523152516.7sr247i3bzwhr44w@quack3.lan>
 <21cd1c49-838a-7f03-ab13-9a4f2ac65979@huawei.com>
 <20220607095430.kac5jgzm2gvd7x3c@quack3.lan>
 <9a51c7b1-ba6c-0a56-85cf-5e602b9c6ec2@huawei.com>
Message-ID: <75ebf18b-0e21-3906-7862-6ca80b2f181d@huawei.com>
Date:   Tue, 7 Jun 2022 21:06:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9a51c7b1-ba6c-0a56-85cf-5e602b9c6ec2@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

在 2022/06/07 19:51, Yu Kuai 写道:
> 在 2022/06/07 17:54, Jan Kara 写道:
>> On Tue 07-06-22 11:10:27, Yu Kuai wrote:
>>> 在 2022/05/23 23:25, Jan Kara 写道:
>>>> Hum, for me all emails from Huawei I've received even today fail the 
>>>> DKIM
>>>> check. After some more digging there is interesting inconsistency in 
>>>> DMARC
>>>> configuration for huawei.com domain. There is DMARC record for 
>>>> huawei.com
>>>> like:
>>>>
>>>> huawei.com.        600    IN    TXT    
>>>> "v=DMARC1;p=none;rua=mailto:dmarc@edm.huawei.com"
>>>>
>>>> which means no DKIM is required but _dmarc.huawei.com has:
>>>>
>>>> _dmarc.huawei.com.    600    IN    TXT    
>>>> "v=DMARC1;p=quarantine;ruf=mailto:dmarc@huawei.com;rua=mailto:dmarc@huawei.com" 
>>>>
>>>>
>>>> which says that DKIM is required. I guess this inconsistency may be the
>>>> reason why there are problems with DKIM validation for senders from
>>>> huawei.com. Yu Kuai, can you perhaps take this to your IT support to 
>>>> fix
>>>> this? Either make sure huawei.com emails get properly signed with 
>>>> DKIM or
>>>> remove the 'quarantine' record from _dmarc.huawei.com. Thanks!
>>>>
>>>>                                 Honza
>>>>
>>> Hi, Jan and Jens
>>>
>>> I just got response from our IT support:
>>>
>>> 'fo' is not set in our dmarc configuration(default is 0), which means
>>> SPF and DKIM verify both failed so that emails will end up in spam.
>>>
>>> It right that DKIM verify is failed because there is no signed key,
>>> however, our IT support are curious how SPF verify faild.
>>>
>>> Can you guys please take a look at ip address of sender? So our IT
>>> support can take a look if they miss it from SPF records.
>>
>> So SPF is what makes me receive direct emails from you. For example on 
>> this
>> email I can see:
>>
>> Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
>>          [185.176.79.56])
>>          (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 
>> (128/128
>>          bits))
>>          (No client certificate requested)
>>          by smtp-in2.suse.de (Postfix) with ESMTPS id 4LHFjN2L0dzZfj
>>          for <jack@suse.cz>; Tue,  7 Jun 2022 03:10:32 +0000 (UTC)
>> ...
>> Authentication-Results: smtp-in2.suse.de;
>>          dkim=none;
>>          dmarc=pass (policy=quarantine) header.from=huawei.com;
>>          spf=pass (smtp-in2.suse.de: domain of yukuai3@huawei.com 
>> designates
>>          185.176.79.56 as permitted sender) 
>> smtp.mailfrom=yukuai3@huawei.com
>>
>> So indeed frasgout.his.huawei.com is correct outgoing server which makes
>> smtp-in2.suse.de believe the email despite missing DKIM signature. But 
>> the
>> problem starts when you send email to a mailing list. Let me take for
>> example your email from June 2 with Message-ID
>> <20220602082129.2805890-1-yukuai3@huawei.com>, subject "[PATCH -next]
>> mm/filemap: fix that first page is not mark accessed in filemap_read()".
>> There the mailing list server forwards the email so we have:
>>
>> Received: from smtp-in2.suse.de ([192.168.254.78])
>>          (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 
>> bits))
>>          by dovecot-director2.suse.de with LMTPS
>>          id 8MC5NfVvmGIPLwAApTUePA
>>          (envelope-from <linux-fsdevel-owner@vger.kernel.org>)
>>          for <jack@imap.suse.de>; Thu, 02 Jun 2022 08:08:21 +0000
>> Received: from out1.vger.email (out1.vger.email 
>> [IPv6:2620:137:e000::1:20])
>>          by smtp-in2.suse.de (Postfix) with ESMTP id 4LDJYK5bf0zZg5
>>          for <jack@suse.cz>; Thu,  2 Jun 2022 08:08:21 +0000 (UTC)
>> Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
>>          id S232063AbiFBIIM (ORCPT <rfc822;jack@suse.cz>);
>>          Thu, 2 Jun 2022 04:08:12 -0400
>> Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
>>          lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by
>>          vger.kernel.org
>>          with ESMTP id S232062AbiFBIIL (ORCPT
>>          <rfc822;linux-fsdevel@vger.kernel.org>);
>>          Thu, 2 Jun 2022 04:08:11 -0400
>> Received: from szxga02-in.huawei.com (szxga02-in.huawei.com 
>> [45.249.212.188])
>>          by lindbergh.monkeyblade.net (Postfix) with ESMTPS id
>>          75DDB25FE;
>>          Thu,  2 Jun 2022 01:08:08 -0700 (PDT)
>>
>> and thus smtp-in2.suse.de complains:
>>
>> Authentication-Results: smtp-in2.suse.de;
>>          dkim=none;
>>          dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM"
>>          header.from=huawei.com (policy=quarantine);
>>          spf=pass (smtp-in2.suse.de: domain of
>>          linux-fsdevel-owner@vger.kernel.org designates 
>> 2620:137:e000::1:20 as
>>          permitted sender) 
>> smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
>>
>> Because now we've got email with "From" header from huawei.com domain 
>> from
>> a vger mail server which was forwarding it. So SPF has no chance to match
>> (in fact SPF did pass for the Return-Path header which points to
>> vger.kernel.org but DMARC defines that if "From" and "Return-Path" do not
>> match, additional validation is needed - this is the "SPF not aligned
>> (relaxed)" message above). And missing DKIM (the additional validation
>> method) sends the email to spam.
> 
> Thanks a lot for your analysis, afaics, in order to fix the
> problem, either your mail server change the configuration to set
> alignment mode to "relaxed" instead of "strict", or our mail server
> add correct DKIM signature for emails.
> 
> I'll contact with our IT support and try to add DKIM signature.
> 
> Thanks,
> Kuai

Hi, Jan

Our IT support is worried that add DKIM signature will degrade
performance, may I ask that how is your mail server configuation? policy
is quarantine or none, and dkim signature is supportted or not.

Thanks,
Kuai

