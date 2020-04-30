Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF691C09CC
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2020 23:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgD3Vzd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Apr 2020 17:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgD3Vzd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Apr 2020 17:55:33 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D253C08E859
        for <cgroups@vger.kernel.org>; Thu, 30 Apr 2020 14:55:33 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a32so1460790pje.5
        for <cgroups@vger.kernel.org>; Thu, 30 Apr 2020 14:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rYEprxh5hRkyIRk0SZJ1yYwJF2zaPFW1K1pdxuC7Zuc=;
        b=0YJweBxdqRGXk8CKADPYZT2TDMDjlejyhecZFIP6Pdqu2Rol0vua+RkjawOc6lW+4C
         uye8FqmbkqGQFahJuYyZ/sVkYDn8YKcognO7HZN5LGsmML6yIXlmeCxIkANnyZNQ1gTG
         /9xSR/dOm1broZSmXWyPapxeqpe3M9DwJQedEjQkHUFGZC4OxPB9a94qfaCo8FkfLTG2
         z4UdgSMg6xqZqbdaMkkKFbSj8MCsvkht1TJbHhLVLcwEjDr92euBMUJXifl8yCQybF3i
         0VWB+PK6QrXPrkeZTzbIW4Ds0P1gdgZDHzx3P27ENgTnRXQIqNtK/jjJtTG7opYmGATG
         kgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rYEprxh5hRkyIRk0SZJ1yYwJF2zaPFW1K1pdxuC7Zuc=;
        b=oa+7+Nd9k/31L/IM8oBjWeU6P5NdVUzIVEb6Q37e9c9D5Ays9ZxkBYZLRXiW2sT+He
         yziymMNuv96Xj+CkpRw/Wc/zqE8yj8qpCJntOFAc+sXobtHhZ7FN2ylrTR3SZab2fLvZ
         Neibtzsz4IR37RoCVwHixtiGsOWItVc9kJlnO9BfuWuiWoo3gK9w6J0Gt8uBdgYEYkZF
         Z/vwfQkaiR10YN2t8sCrIfupv7OLp7wOaTL8MTJiZPqZOcG8AyhkCZ68pY+p0+rJhyYk
         F8azSfPm3KEQMrK7QDw/S8hHvoKOWBz/2EunOJaEKjGuTpHgr/Xp1dM5WnGgIs7fu8YR
         vMfw==
X-Gm-Message-State: AGi0PuZDG9IEl5TPyD02PI7UTm9wi9gJXfz/ZcvYUVviRVmb/ugmTB/j
        LUYPgR5N2k2KkvUFOTSECWX4zQ==
X-Google-Smtp-Source: APiQypKZKsYx7E2CGdgFsbEsXPiGTeppVxcKMSgLFPw/aX5eOiEu/pEAX05ugbUD8BcvAoby192kSA==
X-Received: by 2002:a17:902:7b94:: with SMTP id w20mr1140125pll.8.1588283732465;
        Thu, 30 Apr 2020 14:55:32 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id i25sm601473pfo.196.2020.04.30.14.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 14:55:31 -0700 (PDT)
Subject: Re: [PATCHSET v2 block/for-5.8] iocost: improve use_delay and latency
 target handling
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org, newella@fb.com,
        josef@toxicpanda.com, asml.silence@gmail.com, ming.lei@redhat.com,
        bvanassche@acm.org
References: <20200413162758.97252-1-tj@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6ee6360e-1a35-874c-2263-6fb21da66591@kernel.dk>
Date:   Thu, 30 Apr 2020 15:55:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200413162758.97252-1-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/13/20 10:27 AM, Tejun Heo wrote:
> Changes from v1[1]
> 
> * Dropped 0002-block-add-request-io_data_len.patch and updated to use
>   rq->stats_sectors instead as suggested by Pavel Begunkov.
> 
> This patchset improves the following two iocost control behaviors.
> 
> * iocost was failing to punish heavy shared IO generators (file metadata, memory
>   reclaim) through use_delay mechanism - use_delay automatically decays which
>   works well for iolatency but doesn't match how iocost behaves. This led to
>   e.g. memory bombs which generate a lot of swap IOs to use over their allotted
>   amount. This is fixed by adding non-decaying use_delay mechanism.
> 
> * The same latency targets were being applied regardless of the IO sizes. While
>   this works fine for loose targets, it gets in the way when trying to tigthen
>   them - a latency target adequate for a 4k IO is too short for a 1 meg IO.
>   iocost now discounts the size portion of cost when testing whether a given IO
>   met or missed its latency target.
> 
> While at it, it also makes minor changse to iocost_monitor.py.
> 
> This patchset contains the following five patches.
> 
>  0001-blk-iocost-switch-to-fixed-non-auto-decaying-use_del.patch
>  0002-blk-iocost-account-for-IO-size-when-testing-latencie.patch
>  0003-iocost_monitor-exit-successfully-if-interval-is-zero.patch
>  0004-iocost_monitor-drop-string-wrap-around-numbers-when-.patch
> 
> and is also available in the following git branch.
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git iocost-delay-latency-v2
> 
> diffstat follows. Thanks.
> 
>  block/Kconfig                  |    1 
>  block/blk-cgroup.c             |    6 ++++
>  block/blk-iocost.c             |   56 +++++++++++++++++++++++++++++------------
>  include/linux/blk-cgroup.h     |   43 ++++++++++++++++++++++++-------
>  tools/cgroup/iocost_monitor.py |   48 +++++++++++++++++++----------------
>  5 files changed, 106 insertions(+), 48 deletions(-)

Applied, thanks Tejun.

-- 
Jens Axboe

