Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AF1580322
	for <lists+cgroups@lfdr.de>; Mon, 25 Jul 2022 18:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbiGYQwW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Jul 2022 12:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbiGYQwV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Jul 2022 12:52:21 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEDA1D0E2
        for <cgroups@vger.kernel.org>; Mon, 25 Jul 2022 09:52:19 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id mz20so8851735qvb.0
        for <cgroups@vger.kernel.org>; Mon, 25 Jul 2022 09:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j0BaZSzqD5eIgwyip/HS4aDnwW9Jp806htc77k2W+9I=;
        b=YrRC8+DcvcJ+j3/daDEZUkXI7wwrYxc1PEjLb5WJCKV4hOP1uHTC/ifMwxGxMiDkfx
         /A82VqK1LTw9pVhvRXWQeyXrrPJ2ZvCuG5iWP7cY8NmWkKUfWofwwTglQWitP4sLRpre
         NB5VpzmQIT0yR8C+q/8SpRe6N4qEXuOmhz9/zyJDdIRw6IQfETk2K2RZNRdauaalnISk
         ecXU6u6eJyO8O/HQW59YX4MJEK3q8L7+iGwgT+B0Xfmvz2s9vSCXiUlMoZjDizM7CmZj
         Pva3rt58bJXcA2sOVprKVekCrokJioAdbUfKQmHTFPMiKttfucAsODDHed2z6c5VspUe
         9oNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j0BaZSzqD5eIgwyip/HS4aDnwW9Jp806htc77k2W+9I=;
        b=U6PrbP2N8D+rujiLLgkCFN2h4cXLr+KLNSNaHWSd9YVoNauvPTEMQkDB9Z4sS1eWJJ
         iOkBnsUx6SUuJQt+AFRYC6a9C6eejso2ix8DKQ2doF2UXe+5dwkTxM2gSXodBNN7+8P7
         IEQ66L+OVUGyerz4ASfqtd/lhqcXKyhkAnVcZ0ObTtTBo8ql1Af3k/DRX8hfKgJkPI2g
         +Xsfssi/VffSbJhPzhZjRnXSKmUEtwk2xcYsI1NYXYEYu2rrgcoy3QzTCEBb74k97+LL
         q1+/4lPLAeWvUb0RpvxzJrUmWzKp6wqsnDuUyLLbqCtoQdRPswAmvR4bAYPqbReD+zx8
         8m2w==
X-Gm-Message-State: AJIora+rsLscpZvH1ZYP6Uqyfy4KAO4NQolDaGsUttJULigjy+btqF5g
        /TaptuyPKwh+hpJBkUiyE3H4+g==
X-Google-Smtp-Source: AGRyM1uv3LFH6aM79vzCkplcfzTZ3m25YJ7ns1XG6o8aG/GGTPTrtN6PwrSDI9Hn7ptl4H/XTiIloQ==
X-Received: by 2002:ad4:5de4:0:b0:474:2384:a0e9 with SMTP id jn4-20020ad45de4000000b004742384a0e9mr11516834qvb.79.1658767938522;
        Mon, 25 Jul 2022 09:52:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:994f])
        by smtp.gmail.com with ESMTPSA id u20-20020ac858d4000000b00304f3e320f2sm7915678qta.4.2022.07.25.09.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 09:52:18 -0700 (PDT)
Date:   Mon, 25 Jul 2022 12:52:17 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        tj@kernel.org, corbet@lwn.net, akpm@linux-foundation.org,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 8/9] sched/psi: add kernel cmdline parameter
 psi_inner_cgroup
Message-ID: <Yt7KQc0nnOypB2b2@cmpxchg.org>
References: <20220721040439.2651-1-zhouchengming@bytedance.com>
 <20220721040439.2651-9-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721040439.2651-9-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 21, 2022 at 12:04:38PM +0800, Chengming Zhou wrote:
> PSI accounts stalls for each cgroup separately and aggregates it
> at each level of the hierarchy. This may case non-negligible overhead
> for some workloads when under deep level of the hierarchy.
> 
> commit 3958e2d0c34e ("cgroup: make per-cgroup pressure stall tracking configurable")
> make PSI to skip per-cgroup stall accounting, only account system-wide
> to avoid this each level overhead.
> 
> For our use case, we also want leaf cgroup PSI accounted for userspace
> adjustment on that cgroup, apart from only system-wide management.

I hear the overhead argument. But skipping accounting in intermediate
levels is a bit odd and unprecedented in the cgroup interface. Once we
do this, it's conceivable people would like to do the same thing for
other stats and accounting, like for instance memory.stat.

Tejun, what are your thoughts on this?
