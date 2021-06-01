Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB7C3975B9
	for <lists+cgroups@lfdr.de>; Tue,  1 Jun 2021 16:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbhFAOrK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Jun 2021 10:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbhFAOrK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Jun 2021 10:47:10 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECEBC061574
        for <cgroups@vger.kernel.org>; Tue,  1 Jun 2021 07:45:28 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l11-20020a05600c4f0bb029017a7cd488f5so2105167wmq.0
        for <cgroups@vger.kernel.org>; Tue, 01 Jun 2021 07:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=38OJXjf9apU3psNdgfiCp5ABcftQyKat/l3MsHmkX8Y=;
        b=UQ3kqRg6KLoUWQ3nlWkbFWXvc+pq1x7GyJUmyfTz8pzxAqM6/C+fUQCP4mpRpej3nc
         DVWQl8jdJXGSWCePj4rWYdSiLZTlgTiQedHeNTUEUAmWEoGZ/jSqfEWVeksFUMlvj99e
         1Mpl/9WfbjTWMfyifeHRUjGknkITJjxkXmKY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=38OJXjf9apU3psNdgfiCp5ABcftQyKat/l3MsHmkX8Y=;
        b=Vt0Px65Q5cQu94yOsqNt6Cxy6DDbm6IPUT1l2D65KsOLz2c6iTFEs6LkA4Oh+Bf1JE
         XLg5YpmlHJiS8RAT8fT/bfwOuftffw8RSssfcJear1t1aeolNv0svGoHe4Vin6NpuXkc
         sgPQ00enp/awXN5DCiky8jyB86f/nMv/58dlv6p4n1FpRdxXf+CeLOvLYdn8GTAhbd0m
         SZm83LEdCnFIA+HR3SyLNiGyhlaAiosDznXkrKQETUt2fiTlh0zDCP8LlOmaOp+MAfnk
         XiTi4a6mFH/HOo8ABfptZ2nXy5c/n3JJQAGnoxJOyeRqimVqBCRCAwsNkEG+ihHFvrbh
         AVJQ==
X-Gm-Message-State: AOAM530LRsASL/KqvxNiB8O/BIpe6VhOmbDndbWXyxt524Eyst8gfhus
        jphatK4EW1W9vMuHToWuASZeGA==
X-Google-Smtp-Source: ABdhPJwrubYzbvKu9FqeNKSWy7Y87aXjCj1xwgbkZA4cGLEMSpMP0MFon25js4snpWaQjuFLxSlpVg==
X-Received: by 2002:a1c:4482:: with SMTP id r124mr304068wma.42.1622558727436;
        Tue, 01 Jun 2021 07:45:27 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:a819])
        by smtp.gmail.com with ESMTPSA id u3sm3909643wre.76.2021.06.01.07.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 07:45:26 -0700 (PDT)
Date:   Tue, 1 Jun 2021 15:45:26 +0100
From:   Chris Down <chris@chrisdown.name>
To:     yulei zhang <yulei.kernel@gmail.com>
Cc:     Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <christian@brauner.io>,
        Cgroups <cgroups@vger.kernel.org>, benbjiang@tencent.com,
        Wanpeng Li <kernellwp@gmail.com>,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Linux MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: Re: [RFC 0/7] Introduce memory allocation speed throttle in memcg
Message-ID: <YLZIBpJFkKNBCg2X@chrisdown.name>
References: <cover.1622043596.git.yuleixzhang@tencent.com>
 <CALvZod4SoCS6ym8ELTxWd6UwzUp8m_UUdw7oApAhW2WRq0BXqw@mail.gmail.com>
 <CACZOiM3VhYyzCTx4FbW=FF8WB=X46xaV53abqOVL+eHQOs8Reg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACZOiM3VhYyzCTx4FbW=FF8WB=X46xaV53abqOVL+eHQOs8Reg@mail.gmail.com>
User-Agent: Mutt/2.0.7 (481f3800) (2021-05-04)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

yulei zhang writes:
>Yep, dynamically adjust the memory.high limits can ease the memory pressure
>and postpone the global reclaim, but it can easily trigger the oom in
>the cgroups,

To go further on Shakeel's point, which I agree with, memory.high should 
_never_ result in memcg OOM. Even if the limit is breached dramatically, we 
don't OOM the cgroup. If you have a demonstration of memory.high resulting in 
cgroup-level OOM kills in recent kernels, then that needs to be provided. :-)
