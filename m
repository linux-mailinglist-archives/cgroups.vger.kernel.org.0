Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090856CC981
	for <lists+cgroups@lfdr.de>; Tue, 28 Mar 2023 19:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjC1RnL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Mar 2023 13:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjC1RnH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Mar 2023 13:43:07 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED52A5D2
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 10:43:01 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eg48so52845007edb.13
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 10:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680025379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YG+UIQYgxqGHyxX9M5F8H7BPrKcU2ibGbTNwGE2wMMA=;
        b=lUUqF6Gya0c4F6EmNxmKWP3J//Rfc+fMUR5PY0DlyVsha/TGEgRjN4mCOT1l6A8IiY
         n7xFgRU2eUNmyXHQduREl8GSVPQMGcc7AZS0+Yez2IHxxhB1Uh8xq5g8Caq0YNkYnsGy
         SJ5p88YcGM+O0E4pTE0ozZEm/wN++qhR9hFCmUIAikpRO3S9cwjnvwjA4/KEwZ1DdN94
         tcIp0SZS/C/QVh3Q8pNXwF0lOeoF8rHc+vz0WJ1G8dYJJF9qtD5/DcKJlm3B1G+5jlRk
         1GAWOqe5Ff4znRwZqdRMVPIyWXptPQmx152n8P8iGBLIVlpm9mLKaGq+4+SvyxzWPYLi
         W/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680025379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YG+UIQYgxqGHyxX9M5F8H7BPrKcU2ibGbTNwGE2wMMA=;
        b=jnh2SseFYx38ktJcZIo2ZMwXlfQZfJRAkCDS/s/J9OwKLL0m8azD/BqaMSXNBK/SNp
         hBWi0GWqd1cWB4t70+VytPPGV/pCnpEqlzV1z9tp7RgJhcKYMaccKWfQ0aSzn6cCJs1w
         lqJ4Iwr6gGK+rTfVzPkK3RVzwOXCLPzWgBIyNIMg19jdVSO15WROkVLxX5jK+PQx9SnE
         81Ech7wurguOXNCwewIcrRcye0rHq8KITm2RYE6vQS2GjT4LfOK6n4V2YJoDMpe31XYu
         K/eGacr9WXetGFPK/7R3fIw8ebxUtNcMt0/PN1y564MG1OdElAIqd0+ATR3CgNuS/1q3
         bB3A==
X-Gm-Message-State: AAQBX9fJ5451U5I/mQLK9b9qqqwbc9Fyc4dkxAI/3sdhW3EyKtpifyo+
        9Hzc+h8kmq4NmPXjklRp+r+XZg==
X-Google-Smtp-Source: AKy350akeYx8oU/FGVNmJIEWdKG3qETomY6DnhcwhKi0pJVbzha8m5e4mfxmESwKm4v0+8LDxhs04g==
X-Received: by 2002:aa7:d053:0:b0:4fa:e129:31cf with SMTP id n19-20020aa7d053000000b004fae12931cfmr17134270edo.23.1680025379828;
        Tue, 28 Mar 2023 10:42:59 -0700 (PDT)
Received: from localhost ([2a02:8070:6387:ab20:5139:4abd:1194:8f0e])
        by smtp.gmail.com with ESMTPSA id g20-20020a50d5d4000000b004fd29e87535sm7296869edj.14.2023.03.28.10.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:42:59 -0700 (PDT)
Date:   Tue, 28 Mar 2023 13:42:58 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v1 2/9] memcg: rename mem_cgroup_flush_stats_"delayed" to
 "ratelimited"
Message-ID: <ZCMnIvfFwRbcmhf0@cmpxchg.org>
References: <20230328061638.203420-1-yosryahmed@google.com>
 <20230328061638.203420-3-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328061638.203420-3-yosryahmed@google.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 28, 2023 at 06:16:31AM +0000, Yosry Ahmed wrote:
> mem_cgroup_flush_stats_delayed() suggests his is using a delayed_work,
> but this is actually sometimes flushing directly from the callsite.
> 
> What it's doing is ratelimited calls. A better name would be
> mem_cgroup_flush_stats_ratelimited().
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
