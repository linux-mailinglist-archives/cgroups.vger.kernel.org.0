Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4EC69E5F8
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 18:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbjBUR10 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 12:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbjBUR1X (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 12:27:23 -0500
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595C82F783;
        Tue, 21 Feb 2023 09:27:14 -0800 (PST)
Received: by mail-pl1-f182.google.com with SMTP id bh1so5832983plb.11;
        Tue, 21 Feb 2023 09:27:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0s3W4yEjy/qMzlPpLjsQNo1D3zcbdTGIukQ9oB3kUhw=;
        b=BXT007ou1rCMWPFabIKurFPeRgGL8DGjQ9jUKn2cdhJRx1Vq4VpPEf3qk6lPQINo6m
         Ld8Dy7cNjFU8tEj060kU7cuusu2IMzNBGqPCnyim07d4lzAP61bkG/g5R5SdoHSHtKA7
         EUVjLFEEEB8Y3BWwsbyxsQoxCJPQky5Czs3DfvS5P9+GaZisqmsU4jefF+W04QJl4gOp
         L3cB0bciSWh4j7G6mPGuNZpVXH0xWUwVHf8lkDdpU2bQGMYLRv4hwIk8FDfEWVj45JyK
         PKdwm4zpidqHAwaNxz6bDfeNtzbu+tAVbUPS2/R5zSFR69SJOAZKJn5Q7IQdmkxV/MsK
         ddbg==
X-Gm-Message-State: AO0yUKXTPhADGP/1xThWxEecWvUfxTNK6TG2uZZqJ72bIWAHDWJJhKvd
        XoExCPtPGcPEMNX2vH7yQgV/kXMfcPM=
X-Google-Smtp-Source: AK7set/KbW3QmbPYt/aN+FB9IwVtksBA1hObQbi6EK0KaeukmqU0ynwIYXwcxu1uvWtgX3t0Azwz5A==
X-Received: by 2002:a17:902:e84b:b0:19a:84db:76ed with SMTP id t11-20020a170902e84b00b0019a84db76edmr9283784plg.15.1677000433499;
        Tue, 21 Feb 2023 09:27:13 -0800 (PST)
Received: from ?IPV6:2620:0:1000:2514:6f67:63f5:599a:2f4c? ([2620:0:1000:2514:6f67:63f5:599a:2f4c])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902bf4200b00199136ded1dsm10165292pls.112.2023.02.21.09.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 09:27:12 -0800 (PST)
Message-ID: <dfb154c1-ab01-ef67-f23d-bd840ff0c2fe@acm.org>
Date:   Tue, 21 Feb 2023 09:27:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] blk-ioprio: Introduce promote-to-rt policy
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>, linux-block@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, houtao1@huawei.com
References: <20230220135428.2632906-1-houtao@huaweicloud.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230220135428.2632906-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/20/23 05:54, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
