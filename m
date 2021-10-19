Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC7C433CEE
	for <lists+cgroups@lfdr.de>; Tue, 19 Oct 2021 19:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhJSRF3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Oct 2021 13:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhJSRF2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Oct 2021 13:05:28 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DB9C06161C;
        Tue, 19 Oct 2021 10:03:16 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id v20so14101036plo.7;
        Tue, 19 Oct 2021 10:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cb9GiFttJIShHLaHyamc/d4toGTaUJ3k9crbveF7gg0=;
        b=BOmxdUfCMIyD2fZr8/EH5QtzCVoYpqEgfRrF3aH/hGloS6T1vl6Tdvj6YFM6KkUavy
         RiUXbbMRJjlY/7JW6N+rgYfOaijFtrV2a2N5RWQjGjYI85VTkaXw4F6dEJMh/rwPnErE
         9QvDSK3qqn5jZQmbFWAY01uZ8ra8GZSHVmcG88sibvQ4RKTsqXh8NXIegJhSOCJ96AsF
         Vno+Bp3O5ZCNCbjIws4ckNImT7MTuDSOuciaJjDvQf91B2i9lFqT1X4AItb1f1dlFh6m
         cHO+YPJKuZP4eSgU0q6J694zr7qbycHQ+3esEoDmKGhX7LfHVRQP9bFkEsGD61GBLbS7
         QdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=cb9GiFttJIShHLaHyamc/d4toGTaUJ3k9crbveF7gg0=;
        b=ETgsbm93EFGKz6m3nPxdnQ2muuEV+HZi4u2PS3aCExetrPgc7NvAV3GLy5fjuEjSGe
         Vv7CLTLvdK5MMpcQ7JZ3C+SFzc0c/5I3GmZYTkYpXgYl+fGPTCHdd1fdmyPcXiOSb5z7
         u4D7Q62CzVxQLvv9Z2mNvUQaE0Sdp1Mhjbabh0hRRtH1WZi4couG4P1Nqhwgp+l2qoEd
         NQuBVbx6ehJCwRnFstVG1j7tc52Xxyn+Gd86zPJic7CZCNFM/qHv2of5un8Sh/72j/MI
         HzYPCcSjovZUrDdLaQ5esC36mGUcRIzLSMPoH1J/wsBwN6WHrpO45TlwUy8++mRgSKYd
         mbuw==
X-Gm-Message-State: AOAM531HOi9HqoaVYQ+jcVOteokmCez2h6DIDuW4JAkHhGmIUB8g12CQ
        4Qes99WWhvZlNpB7m8BJVYQ=
X-Google-Smtp-Source: ABdhPJz66mdTpBEd9DTd8aqGMXjA5dOYLLbqdtqrA/PRHKQ6nTHF2vOhfbwm/tGwEIFakJGrtN1MaQ==
X-Received: by 2002:a17:90a:e64a:: with SMTP id ep10mr1219201pjb.124.1634662995400;
        Tue, 19 Oct 2021 10:03:15 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id c9sm15935346pgq.58.2021.10.19.10.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 10:03:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 19 Oct 2021 07:03:13 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, paolo.valente@linaro.org,
        avanzini.arianna@gmail.com, fchecconi@gmail.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v3 -next 2/2] blk-cgroup: synchoronize blkg creation
 against policy deactivation
Message-ID: <YW76UThK20WaCWO6@slm.duckdns.org>
References: <20211019024132.432458-1-yukuai3@huawei.com>
 <20211019024132.432458-3-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019024132.432458-3-yukuai3@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

Some nitpicks.

On Tue, Oct 19, 2021 at 10:41:32AM +0800, Yu Kuai wrote:
...
> Because blkcg_deactivate_policy() require queue to be freezed, thus grab
                                    ^                   ^        ^
                                    requires            frozen   we can grab

> q_usage_counter to synchoronize blkg_conf_prep() against
> blkcg_deactivate_policy().
...
> +	/*
> +	 * blkcg_deactivate_policy() require queue to be freezed, thus grab
> +	 * q_usage_counter to prevent concurrent with blkcg_deactivate_policy().
> +	 */

Same here.

Looks good otherwise. Please feel free to add

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
