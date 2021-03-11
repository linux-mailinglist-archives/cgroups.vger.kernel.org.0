Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B706C3370E3
	for <lists+cgroups@lfdr.de>; Thu, 11 Mar 2021 12:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhCKLK7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 11 Mar 2021 06:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbhCKLK1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 11 Mar 2021 06:10:27 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42702C061574;
        Thu, 11 Mar 2021 03:10:27 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id f12so804908qtq.4;
        Thu, 11 Mar 2021 03:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4FDhkUkdj8fWqlipDBp6WuM7/UyISTb34fe+zJutuhk=;
        b=P849DNFgS5nte6HYXGD6ebAhhBZ3CyFnv9N3Sr2OhrHYwPjZon8k1Uf09nEsePPWI0
         H9dmyx+EEhFA/GBdul8L0iS9ImrDHwqzKxTUxo7LNAZ4EBKimkA8s4dQS0umgEhbgttx
         jRTxH4Wng6J+VJxQ4lnEAxHZe3iMCaQMx9n22CblexjSVPeCf+1Nl4XSIsdSbNdMbWdx
         i5ZhN1Ux4/9F8jxSWEX+T5YsVD+Y/92mIsKAy2YM0NsJSyw4CDCt1snVu0JcpbWQsBOc
         wvKxY6zBFQwDQAV1K40PCqBou18XW6/Fmbt1sZ4xYK0NirvYCvAJ0nxsL+CcWem4M5TY
         F93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=4FDhkUkdj8fWqlipDBp6WuM7/UyISTb34fe+zJutuhk=;
        b=LZe8mrbt3dxu9TItngECZrR/KjoiYm3guq2QYb7u376he988e/AzfeXvHPfYcKhSJY
         gUfKJK1nrWRJWMi8v7Vv68s9E+nP3EtW7NDHGHbs0FRz3Ya1qaurGO8H5EvNy1eL8IX/
         DzPaUkUNFT4k6Iz5vVkbnCk4wZf3wzedrgJrrWLtyphfJya4Ay7sR7px+d1Gvknb581Q
         8dnM7L8SkidZYXXm0F0MJ+NlGYNhfIT5vEDbEcLMjTwxVy3fTL84lpTonwQdN/wqbx6L
         ynZdhGL/8SM7P6OOwX/TiAU6YATVhBFLGS/kYNccvIhQJ/DBcojO4zlBLMggmKItecUi
         9GKA==
X-Gm-Message-State: AOAM530blBrq87pkPABsZHGkI4GzzcOI3bG486VBXX8kl0OVQY6CGbBF
        0x7cLjvbSZPPw0noHumKO1k=
X-Google-Smtp-Source: ABdhPJzAmUcpvcKbe7oVuT3jh2pvL8XEzD3mV8sjVbg+GAQtSR/Ff9hDTjoyaSog8q0e8a30rdRYew==
X-Received: by 2002:ac8:4314:: with SMTP id z20mr6848730qtm.127.1615461026174;
        Thu, 11 Mar 2021 03:10:26 -0800 (PST)
Received: from localhost (2603-7000-9602-8233-06d4-c4ff-fe48-9d05.res6.spectrum.com. [2603:7000:9602:8233:6d4:c4ff:fe48:9d05])
        by smtp.gmail.com with ESMTPSA id p7sm1673704qkc.75.2021.03.11.03.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 03:10:25 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 11 Mar 2021 06:10:25 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH] cgroup-v2: Add taskstats counters in cgroup.stat
Message-ID: <YEn6od+CCVjNZIS9@slm.duckdns.org>
References: <20210311061752.310831-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311061752.310831-1-zhouchengming@bytedance.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 11, 2021 at 02:17:52PM +0800, Chengming Zhou wrote:
> We have the netlink CGROUPSTATS_CMD_GET interface to get taskstats
> of the cgroup on v1, but haven't the equivalent interface on v2,
> making it difficult to calculate the per-cgroup cpu load in cadvisor
> or implement the cgroup proc interface in lxcfs, like /proc/loadavg.

So, this is what the PSI metrics are for and we've been using it for that
for quite a while now. I'd much prefer not adding something duplicate (and
incomplete).

Thanks.

-- 
tejun
