Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A112C6DB2F9
	for <lists+cgroups@lfdr.de>; Fri,  7 Apr 2023 20:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjDGSo6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 Apr 2023 14:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDGSo5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 7 Apr 2023 14:44:57 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D9EB75D
        for <cgroups@vger.kernel.org>; Fri,  7 Apr 2023 11:44:55 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-517a80b48ffso245a12.0
        for <cgroups@vger.kernel.org>; Fri, 07 Apr 2023 11:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680893095; x=1683485095;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kzuwp9uE5sEsN7zJHJeiz67QAe8Oc4s0UD0YCNSdM5U=;
        b=O3+MoV6cDmmkPk7W8AJ/froinsO6LnGDj+Z5hsCYMGsWXJkNFNjt/nsjhnZg8+4tI0
         QIrEe1yOg43xQeckg1TGUnwXZa1/PnaY1t00UhDiWa2jXuLWvjMXFEgXly1N1Yt7aE6V
         jf8xC6fLILmQ374PFSo9Kn02mz10UvYv67tQrJMg+nXNykneGweIkXs6t3v7qLeY3kjX
         ILL22YyeQZft7KFN/VKBwR+h326O/A3Pr5c3Fjb0XJVRtQXMKvlvS5/2PBKuhFNg/RsT
         wi1sm10f2dlsbhbFwvZYnDisSUWfifJO1EY/WMx7nLmjkthQbgK1MmDA6byqNJB7BhcA
         YZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680893095; x=1683485095;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kzuwp9uE5sEsN7zJHJeiz67QAe8Oc4s0UD0YCNSdM5U=;
        b=Ca3EQEv02RHpIYFVCEZa2JVWreb9YrlfZxn/7JYG6AyrCMDiTn7r26/x6yQ0qyfpOw
         0Alhb6nAqFYVg9fhF4qPg/NPq6mN4j+7XRbarUNutVQrNh4iXEo94cai1i+ME1UwELtD
         PBBKGdc0gEnMS7/oyLqKZHg6ubH1fPvyB04JRSqfxkaX1WXT9kqT1cGkGGd/Zhp0t4ao
         MKiXCqdwVrk3XrYyZWwCWZDHWCU+ONr24VrG/5fiue1lQdS3Mpb4QoSt/n5L9gFo8A1F
         NHzX8wX3BZB2tsGnu8f89C7xsMNFnZUSAXKJIBE6WWogMGSgZtrpy2rr9iDEJ2DuZFPF
         PEOQ==
X-Gm-Message-State: AAQBX9fEW2VjoPkcPZDT9h4m1btW+ogLo9QSpKGaQjZzqatrWvX5wE08
        ZF0SEjrgCthG5lifnCF5FmR4UA==
X-Google-Smtp-Source: AKy350bwH8Ljb3Bjuavft3K3wZtMIN9MYDZhfXWWkH7inyw2OO+U4jkptlydYjV02OqHE2017JEwIA==
X-Received: by 2002:a05:6a00:414a:b0:627:fe88:a2e with SMTP id bv10-20020a056a00414a00b00627fe880a2emr3687157pfb.0.1680893094614;
        Fri, 07 Apr 2023 11:44:54 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id r20-20020a62e414000000b0058d92d6e4ddsm3381979pfh.5.2023.04.07.11.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 11:44:54 -0700 (PDT)
Message-ID: <1416b648-188f-873a-08b3-c8e8494ab1a7@kernel.dk>
Date:   Fri, 7 Apr 2023 12:44:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 0/3] blk-cgroup: some cleanup
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Chengming Zhou <zhouchengming@bytedance.com>, tj@kernel.org
Cc:     paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230406145050.49914-1-zhouchengming@bytedance.com>
 <cab869b1-1cba-5698-55eb-a93d0596c869@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cab869b1-1cba-5698-55eb-a93d0596c869@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/7/23 12:41 PM, Bart Van Assche wrote:
> On 4/6/23 07:50, Chengming Zhou wrote:
>> These are some cleanup patches of blk-cgroup. Thanks for review.
> 
> With these patches applied, my kernel test VM crashes during boot. The following crash disappears if I revert these patches:
> 
> BUG: KASAN: null-ptr-deref in bio_associate_blkg_from_css+0x83/0x240

Would be useful in the report to know where that is, as it doesn't include
the code output.

-- 
Jens Axboe


