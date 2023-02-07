Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DFD68DE76
	for <lists+cgroups@lfdr.de>; Tue,  7 Feb 2023 18:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjBGRFo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Feb 2023 12:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjBGRFm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Feb 2023 12:05:42 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B423D936
        for <cgroups@vger.kernel.org>; Tue,  7 Feb 2023 09:05:38 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id j17so4016980ioa.9
        for <cgroups@vger.kernel.org>; Tue, 07 Feb 2023 09:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RVqRghfkJYuM2PO4hknX+k72h52RQ4rzy+E+T+6Adgk=;
        b=NrJ1K2UoJ7Rjni9tW6A0bOtgmmUrFQgp/gxeUvvugNQ779Tmwsvw5KYFn9fyaEzNI2
         /5G3kPoaS3H1IpYLMjHsrXUlf/64rBtMzO6PBpX5X0DGSV02+wINR6dB4vVaXy45K41f
         XNWxuGObC9U+oBPPi4D9GjlGrfjBdbY/vkPRO8HuBhCuU5uC8S5SDH27CWFzuysxygw7
         RNXTxobeIhbufFscikOA/5TWQSQPVjJfvpiqfsSdwBcBNivb7pG1aclHAeZw9s/OSTFB
         nydAWL8A6IzFP+jEPVNi8grdst9njJIFvsLR2YuL8FPMKspueF6CAze9GhUwyc6+9ZeH
         zprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RVqRghfkJYuM2PO4hknX+k72h52RQ4rzy+E+T+6Adgk=;
        b=Ootjv+C6p3dQCFCeRKjyKqe4LB+LcRUXNJ6qYKWXF0sS2fxXhhq+Ooev2uUpMyt8lZ
         9ItaupwCEkymIF98QysWaMTgDPQ7XGsiglG20RafpClPuHRbrzMK25SW3sTumfTu1970
         l02N7WDwDBx+fchnvQbNHUV3AAzYeZC3xJ6XYKvm6TputqYxjkuSYLTH0bchhBjgOAxx
         Vl7678lpbbKfn/UUWlQIEbH+puZUUs2lsLw9mHgmpqyxrgNzMeaThZwO9O2oCEk3vmu/
         2StBE5wDM8GrXcDU6/spV8WKEGCGqNeuSTaLT/xcHSoOailABc7ETLP4oaTSi7lw0nhR
         Na0w==
X-Gm-Message-State: AO0yUKV5umzYRUHHnhmpe7GepIklFc/PvZ5ffyP/hbg362ni8iEdg4YD
        tCqwe0M66a2OIjpGgJVvjYboQw==
X-Google-Smtp-Source: AK7set+xmdmUOHgOUZAwmkd+Yvp0LrH9xa5eKR3kv5ts8SsjojKhLGP0LY4aV6GLlDuu29ezIkGDJA==
X-Received: by 2002:a6b:1545:0:b0:718:2903:780f with SMTP id 66-20020a6b1545000000b007182903780fmr3019564iov.2.1675789537640;
        Tue, 07 Feb 2023 09:05:37 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id j1-20020a02cb01000000b0039e98b2fe5dsm4605239jap.179.2023.02.07.09.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 09:05:37 -0800 (PST)
Message-ID: <53816439-6473-1c4f-2134-02cd1c46cfe8@kernel.dk>
Date:   Tue, 7 Feb 2023 10:05:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 09/19] io_uring: convert to use vm_account
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, tjmercier@google.com, hannes@cmpxchg.org,
        surenb@google.com, mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
 <44e6ead48bc53789191b22b0e140aeb82459e75f.1675669136.git-series.apopple@nvidia.com>
 <52d41a7e-1407-e74f-9206-6dd583b7b6b5@kernel.dk> <87k00unusm.fsf@nvidia.com>
 <eff3cc48-7279-2fbf-fdbd-f35eff2124d0@kernel.dk>
 <Y+JmdMJhPEGN0Zw+@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y+JmdMJhPEGN0Zw+@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/7/23 7:55?AM, Jason Gunthorpe wrote:
> On Tue, Feb 07, 2023 at 07:28:56AM -0700, Jens Axboe wrote:
> 
>> Outside of that, we're now doubling the amount of memory associated with
>> tracking this. That isn't necessarily a showstopper, but it is not
>> ideal. I didn't take a look at the other conversions (again, because
>> they were not sent to me), but seems like the task_struct and flags
>> could just be passed in as they may very well be known to many/most
>> callers?
> 
> For places doing the mm accounting type it cannot use the task struct
> as the underlying mm can be replaced and keep the task, IIRC.
> 
> We just had a bug in VFIO related to this..
> 
> If we could go back from the mm to the task (even a from a destroyed
> mm though) that might work to reduce storage?

Then maybe just nest them:

struct small_one {
	struct mm_struct *mm;
	struct user_struct *user;
};

struct big_one {
	struct small_one foo;
	struct task_struct *task;
	enum vm_account_flags flags;
};

and have the real helpers deal with small_one, and wrappers around that
taking big_one that just passes in the missing bits. Then users that
don't need the extra bits can just use the right API.

-- 
Jens Axboe

