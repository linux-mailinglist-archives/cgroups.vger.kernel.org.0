Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBB86CF9A5
	for <lists+cgroups@lfdr.de>; Thu, 30 Mar 2023 05:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjC3Doi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Mar 2023 23:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjC3Dog (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Mar 2023 23:44:36 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE6A4C27
        for <cgroups@vger.kernel.org>; Wed, 29 Mar 2023 20:44:10 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id ix20so16905017plb.3
        for <cgroups@vger.kernel.org>; Wed, 29 Mar 2023 20:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680147850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQ0aOCOIHslwWeAUgUUQoRMNFdlJZ0p6oA7JcNsWsx0=;
        b=L+8iXJz7z6DpLY76k9YnkTN+Ng1+Vo9mPB+jC9SB7IjpmO3LMz4Hr/y+fOU2kxrSt+
         FUo2gaKnDsMwgrl42/7xi6Yh+80sOsLnGQJlkHW+UPYCjEkmPHWYkKn8ogJI9VoOckZJ
         yrZpbVrjX6iGVQySm59jzoash/p2C9KrcCptCZc0zcHSuynZrzsdJC3UkneRyzFsHpvK
         u1IyUNlALDXTxlvVbFCXDRHn4hJ9weygOneNpN82Hl3Ctb2woSJG/q263FQVbML4agrV
         +xxlKgb39kkYVwtYjxa+462WbzaSUeTkMecADWk1CVDYOUOHJms1FgGXJ0vQBnFwn6nH
         fU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680147850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VQ0aOCOIHslwWeAUgUUQoRMNFdlJZ0p6oA7JcNsWsx0=;
        b=PttNW+sCm3m4UvkRodrug+j2pnz2efgihX9+dbg5KzbTZxs3bS5F0z0dhfnL55zE1b
         BApdqrPVPodrJDeMOf9yWK+QVoZzrGuOlXT5RIxp+7f8Zj9y9uwh+TfEDuyi7dX8vYmd
         6gkLEe3VSEZW15dhnvjzfHAlLXBS2hdm7GuBA+Lb0BJqbANePmmnzlC8U+c+wTgWzGPr
         Jd/Mg6OWviWFkUJf/a6k/xF3CR6qiBVA8lGQu4jZpuWYJEuChN29Oc7WPcCESaOWR/gx
         rpgNAZvn1aWuDvcQkryFn9jSzePKRqHlkdj0/DN/BRRrnFa/cfZMN4xdctCzorBI6sZp
         iZSA==
X-Gm-Message-State: AAQBX9cXT9KuPLvjbjmE1nw99u5L2m/Eiedq6SzY7n+9jaUmwaBDmZ++
        4WxI0DE9N71SblztLK/ny9sd7g==
X-Google-Smtp-Source: AKy350Z63ysXJoqKJpB8+YQ5aWuV3WL23nvBAF0x7DJEpZqwC1lwwLrpwPzEy54KNMXvONssKjh52Q==
X-Received: by 2002:a17:90b:3c49:b0:23d:19c6:84b7 with SMTP id pm9-20020a17090b3c4900b0023d19c684b7mr23435439pjb.16.1680147849708;
        Wed, 29 Mar 2023 20:44:09 -0700 (PDT)
Received: from [10.254.134.232] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id i19-20020a17090adc1300b0023a8d3a0a6fsm2137129pjv.44.2023.03.29.20.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 20:44:08 -0700 (PDT)
Message-ID: <1a858cce-4d87-5e0a-9274-52cffde7dea6@bytedance.com>
Date:   Thu, 30 Mar 2023 11:44:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [External] Re: [PATCH] blk-throttle: Fix io statistics for cgroup
 v1
To:     Tejun Heo <tj@kernel.org>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230328142309.73413-1-hanjinke.666@bytedance.com>
 <ZCSJaBO8i5jQFC10@slm.duckdns.org>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <ZCSJaBO8i5jQFC10@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2023/3/30 上午2:54, Tejun Heo 写道:
> On Tue, Mar 28, 2023 at 10:23:09PM +0800, Jinke Han wrote:
>> From: Jinke Han <hanjinke.666@bytedance.com>
>>
>> Now the io statistics of cgroup v1 are no longer accurate. Although
>> in the long run it's best that rstat is a good implementation of
>> cgroup v1 io statistics. But before that, we'd better fix this issue.
> 
> Can you please expand on how the stats are wrong on v1 and how the patch
> fixes it?
> 
> Thanks.
> 
Now blkio.throttle.io_serviced and blkio.throttle.io_serviced become the 
only stable io stats interface of cgroup v1, and these statistics are 
done in the blk-throttle code. But the current code only counts the bios 
that are actually throttled. When the user does not add the throttle 
limit, the io stats for cgroup v1 has nothing. I fix it according to the 
statistical method of v2, and made it count all ios accurately.

Thanks.
