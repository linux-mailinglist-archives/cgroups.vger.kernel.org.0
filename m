Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E8833FB3F
	for <lists+cgroups@lfdr.de>; Wed, 17 Mar 2021 23:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhCQWbS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Mar 2021 18:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhCQWaw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Mar 2021 18:30:52 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9585FC06175F
        for <cgroups@vger.kernel.org>; Wed, 17 Mar 2021 15:30:50 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id x16so238679iob.1
        for <cgroups@vger.kernel.org>; Wed, 17 Mar 2021 15:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B1Pn4DbFEch76dQ9ia9lLBjd1nNH8Pqwys+so0gPrt0=;
        b=lNbRHp6l0oM2+Xq1AOXCruM08fOp6OY0+sGgqz70SCTkv4se0odGZQPG+2axOFqFHe
         gBMmrJfpnSZ6ewa5+etGicUlX6aWCCHLXvxkhAfui38IGfPcdWIVG/2vuIThlZe1/5j7
         pxqp0mj3hZDp5XwfNY+dK2+YK1nlugwQMLaDmYvF0ZlXPcqkq9/8UKBHyjRs4OUxnMUI
         Her8syokr+HbPWZDRXobrQg0l9k0AOkKvi+yPIpnFzY8HPLuQKqeeoHWzZV9WGuL/PAE
         cCqR255GknGuZO8aVj4J8LBWYTifQKdU526zmqrvtB1GyY5NPrRMNB45NBZi3r1tu57l
         8nZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B1Pn4DbFEch76dQ9ia9lLBjd1nNH8Pqwys+so0gPrt0=;
        b=tuq2UtzBZV/ApDjLoseIefrPBKzNPhvtP6vfTEqidFFtfkPR+Ce9VhBGGbJSjkpdSQ
         pA73AmfbSJCl0OPaCYI9WeOTIG4Pwp4KKtgsa1OU1LpljQe+CHm4JP64EHbDGQgAO4nw
         X385xq1W8FpUAbCTC359/7f6yBQ7t6wNhtFBj2XCzXW6P9WCT9FriUmIJAHpUkYAyvIN
         Vb/GRCsmcETQArB+TdlYrGmg6f96nLjPdZuYR+8HF5PdIWZTeY1pMggnnMHs6WM1HeSm
         j3WPqODwXc9+ynY40MmF18Qk9E59f6nQ644g8IGDFzqLGK8nnz3+ToHj39RjdwL+hbuQ
         KcCA==
X-Gm-Message-State: AOAM533oYJ/fcEXi38dj8F7F6cNW7Dmy/EeioSLQ/A81qQEFU39nyF4g
        xdIQtCFBOGDUy0XGFzZnNzUPVQ==
X-Google-Smtp-Source: ABdhPJxQ0yBKvSv4QklWxvE86SugGD3/A4r53dNvEqsYePMtqr6ULNLPFEjf3fTnY7saMoyBr0sxVA==
X-Received: by 2002:a6b:d80d:: with SMTP id y13mr8384632iob.75.1616020249934;
        Wed, 17 Mar 2021 15:30:49 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j3sm170380ila.58.2021.03.17.15.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 15:30:49 -0700 (PDT)
Subject: Re: [PATCH v10 0/3] Charge loop device i/o to issuing cgroup
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
References: <20210316153655.500806-1-schatzberg.dan@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7ca79335-026f-2511-2b58-0e9f32caa063@kernel.dk>
Date:   Wed, 17 Mar 2021 16:30:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210316153655.500806-1-schatzberg.dan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 3/16/21 9:36 AM, Dan Schatzberg wrote:
> No major changes, just rebasing and resubmitting

Applied for 5.13, thanks.

-- 
Jens Axboe

