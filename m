Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3761863B1B6
	for <lists+cgroups@lfdr.de>; Mon, 28 Nov 2022 19:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiK1S4p (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Nov 2022 13:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiK1S4o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Nov 2022 13:56:44 -0500
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BA720189;
        Mon, 28 Nov 2022 10:56:43 -0800 (PST)
Received: by mail-pg1-f170.google.com with SMTP id q1so10744555pgl.11;
        Mon, 28 Nov 2022 10:56:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BwaKsqeU7zw2GpsWC3o6lPi5LiR5lRmtqs5NzZ/ZN+w=;
        b=Q/3ZG5CnVs4I7NTlnDvNAr+G7YvHseHQC2jD2nHEPSA7+AuoFHWjRWeDSsCMtnj3qI
         pA3qpjmXcodvWkl1RNhrzw1pyGlv+WUkGK5c4niAd121KBOtJW+q8k8nAGs+vaLAq3ng
         9mEZREHe7LNJEbXXayj8YxHF9xFmdkM/4BDJS3+WT91f7sV0L2cfHhVdQggoO8DD7cMI
         uXc/Ry4jQJf0WPSeNTdDAqV+IIGUaIW5fTan/1S6EnPEyafxJAMz0l0nonrBFvMBOXz5
         YScpiN/r4xxuga/XTF3n86+qTCoFTT7AzFmg95/hnlpx2062sKTurpCJfnn6bzjdBtNq
         2x8g==
X-Gm-Message-State: ANoB5plcMOfWJ4retyRif9z9fkvmqloZUxBSr3g+mY9jBI9/TMfx8+9A
        Gzsnz4aDtQ94iQei1n3pMs8e36bnNBLhGQ==
X-Google-Smtp-Source: AA0mqf5Rn9qNTBnCvcasKuwz9sOCdegVlUF57lbVmIDXAW73ENk6sv/g57T6z61BaaKU8g3lyF8Tyw==
X-Received: by 2002:a63:d43:0:b0:477:cc1f:3f97 with SMTP id 3-20020a630d43000000b00477cc1f3f97mr20019448pgn.331.1669661803122;
        Mon, 28 Nov 2022 10:56:43 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:95f2:baa2:773c:2cfe? ([2620:15c:211:201:95f2:baa2:773c:2cfe])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902680800b0018862bb3976sm9100538plk.308.2022.11.28.10.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 10:56:42 -0800 (PST)
Message-ID: <d08a0059-7c0b-d65f-d184-5b0cb75c08ed@acm.org>
Date:   Mon, 28 Nov 2022 10:56:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH-block] blk-cgroup: Use css_tryget() in
 blkcg_destroy_blkgs()
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>, Yi Zhang <yi.zhang@redhat.com>
References: <20221128033057.1279383-1-longman@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221128033057.1279383-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/27/22 19:30, Waiman Long wrote:
> Fixes: 951d1e94801f ("blk-cgroup: Flush stats at blkgs destruction path")

Has Jens' for-next branch perhaps been rebased? I see the following 
commit ID for that patch:

dae590a6c96c ("blk-cgroup: Flush stats at blkgs destruction path")

Thanks,

Bart.
