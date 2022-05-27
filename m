Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DABE535F33
	for <lists+cgroups@lfdr.de>; Fri, 27 May 2022 13:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243831AbiE0LW0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 May 2022 07:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238981AbiE0LWY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 May 2022 07:22:24 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E7D50465
        for <cgroups@vger.kernel.org>; Fri, 27 May 2022 04:22:23 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p22so6354498lfo.10
        for <cgroups@vger.kernel.org>; Fri, 27 May 2022 04:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=M9FMFJI/J357AWjNf6HATXScadCdwguWFNkt78waWBM=;
        b=jszfjOQNBQQfrZfE+0swQ56OEuaHDyAFud8w34hVHZ4i2a96xQYsNynHMPG3M9WCuc
         XVSVrO8jxlh9H2s8cH8A7faJbQvBhS7XPpObKbIpBzA2dQc7yoFGid5yp9+BkT8BucBc
         TuHu3H4LtY/YvjxlrO+mUNrIUZGauALFsbTdiZta86lN+HJkhNQGwe6TXURRyUzOLo8U
         CRpuBgSEgKdvndEVNZktniGlwUIvnAEBCsvi+FYDPJ99aHMt24PNfTpDJlbKx8PVXj2V
         P9eOIDmmFVYy14CeIGoIS5f+dABhHFLXdMXDC3+LSEHgZjk0YUnk6QVpcB1Y2T7kHDxF
         74rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M9FMFJI/J357AWjNf6HATXScadCdwguWFNkt78waWBM=;
        b=osRkipxQf1lSvBzAV3xIL4O2g1CG3AjR/dKDPwKlYwFMKFKMoy1x6vNmFPOpLHovi4
         goZHfunznTHjNj/8dMI87c7B7phRRS5XQ8VE/kJMVgwxPhpfhA63QJcmusZzQEgU23Nf
         O2H2ar7hwBpOSg/qY1LGpr+NzID0BejedXuWtimTrvo6/DwMbCQNbKeJ6G05WWwyCtYR
         fdKgmk/iSfuOnnURFKahm7YKfQKx04TyyBGyq24oq2AQBQPXRoZYGScEL8wIWt5vefj/
         wSE63wfZU0R1dhhj03hI/Uf7IR6fd23g457gs/gUrX6jS4GBFlUYWMrHhgjMDYGlbmRQ
         oS+w==
X-Gm-Message-State: AOAM5328O0xlfO9yrRx1Bt5aMajtWICf5XoAJDrp/tMx703VT+HYLtep
        7Nns7IatzhW+tbA28zvIy/HWDw==
X-Google-Smtp-Source: ABdhPJzXSWul0Xw0R6vghoqxINMieUX81VKIXihsObaBJo0iEMCc2kFyY+9a0Qk1NMNZRNjEKdfesw==
X-Received: by 2002:a05:6512:4020:b0:478:96b3:92e3 with SMTP id br32-20020a056512402000b0047896b392e3mr11320235lfb.276.1653650541488;
        Fri, 27 May 2022 04:22:21 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id x27-20020a2e585b000000b0024f3d1dae80sm975997ljd.8.2022.05.27.04.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 04:22:21 -0700 (PDT)
Message-ID: <d4e81087-d057-4edb-5df0-47d99a1c72d9@openvz.org>
Date:   Fri, 27 May 2022 14:22:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] XArray: handle XA_FLAGS_ACCOUNT in xas_split_alloc
Content-Language: en-US
To:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     kernel@openvz.org, LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
References: <348dc099-737d-94ba-55ad-2db285084c73@openvz.org>
 <YpAnqqY/c3Y5ZkPG@casper.infradead.org>
 <CALvZod7iyO5Ti5xhzq36UjDFNAmfEyPk1MQv_t4kUHKuPCeNng@mail.gmail.com>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <CALvZod7iyO5Ti5xhzq36UjDFNAmfEyPk1MQv_t4kUHKuPCeNng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/27/22 04:40, Shakeel Butt wrote:
> On Thu, May 26, 2022 at 6:21 PM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Wed, May 25, 2022 at 11:26:37AM +0300, Vasily Averin wrote:
>>> Commit 7b785645e8f1 ("mm: fix page cache convergence regression")
>>> added support of new XA_FLAGS_ACCOUNT flag into all Xarray allocation
>>> functions. Later commit 8fc75643c5e1 ("XArray: add xas_split")
>>> introduced xas_split_alloc() but missed about XA_FLAGS_ACCOUNT
>>> processing.
>>
>> Thanks, Vasily.
>>
>> Johannes, Shakeel, is this right?  I don't fully understand the accounting
>> stuff.
>>
> 
> If called from __filemap_add_folio() then this is correct.
> 
> However from split_huge_page_to_list(), we can not use the memcg from
> current as that codepath is called from reclaim which can be triggered
> by processes of other memcgs.
Btw, Shakeel, Johannes,
I would like to understand, when Xarray should use XA_FLAGS_ACCOUNT ?

From my point of view, this should be useless:
a) if Xarray stores some index (idr?) - his memory is quite small,
and his accounting can be ignored.
b) if Xarray stores some accounted - the size of the corresponding Xarray
infrastructure is usually significantly smaller than the size of the stored object,
sо his accounting can be skipped too.
c) if Xarray stores some non-accounted objects - it makes no sense to account 
corresponding Xarray infrastructure. In case of necessary it makes much more sense
to enable accounting for stored objects (and return to case b).

Am I missed something important perhaps?

I looked for the description of 7b785645e8f1, but o be honest I'm still not sure
that I understand correctly why XA_FLAGS_ACCOUNT flag solved the described problem.

Could you please explain this in more details?

Was it because the non-accounted Xarray kept a reference to the stored object
and thus prevents it from being reclaimed?

If so, was it some special case, or should it affect all such cases,
and my b) statement above is not correct?

Thank you,
	Vasily Averin
