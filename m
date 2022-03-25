Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DD04E6CBB
	for <lists+cgroups@lfdr.de>; Fri, 25 Mar 2022 04:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353674AbiCYDEw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Mar 2022 23:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346585AbiCYDEu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Mar 2022 23:04:50 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1260E11C2B;
        Thu, 24 Mar 2022 20:03:17 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id t7so5531321qta.10;
        Thu, 24 Mar 2022 20:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HXw7xeLeRy4CF/DJ1L3E3FO28dCYqTRXx8i65wk03SM=;
        b=i3tLANoBQ65aqlcXFlYzSLX4QHJwH8thr4YSc0xJn+rmAD4/12eYEQVAiAtkKdKfze
         cTUtDDsSOP5Lf9bfqK3clzmDl8TQ3irN4H7Gq7VuN+T7vdJODwzFKzLmsbqVJ26t5aky
         dchNbp6g6YKqxdvVCeVUnqw8EJnsvKx0YeP8dJcCc+WPHPmXVlAMvwVB4Z2Ctokdtu/f
         XqDRH51/5X2MfyFn3yUiyutjkNjKxV5O6GHCdNXemO+YzWmBoOGEnJeUAOr3rcA/cRyJ
         +JfrZBTtvFJ2QMZlnR888eNq2R9NnKEjJMOsB7IyiTwvVLJpNBYO2e89eBSdyJP1/G28
         gwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HXw7xeLeRy4CF/DJ1L3E3FO28dCYqTRXx8i65wk03SM=;
        b=WgfjzVgNPbxC+fpwIzRme7umT7d7SWgxw1d+fsbmSJNeyMFgj+S1EZtQs1sciS5qmk
         qm3gw8iP3T1noZ9PUJKANefUKV/ggYL/AfxWPorKCxObEVrHuskTy75GjKrL8rEjpVLP
         wDiLyNgTRRPe3hpa/cgahD9ihUHJfITz5CzMN8ZEK9Sgf6Gb/7uN591B3gKJUuiPM3UQ
         ALTnQTHy4/0iBCHuhLl1ual+8756E8mhJnuT6iWbK0YRO2/JgzDUDci/HPEnhCZChozs
         TGp07qcffg/BIoCcRsdJpoA+p4tppCArDK4dvlL+xRmirqhnuClG+g/4F1NI9GS5Uw1A
         vUYA==
X-Gm-Message-State: AOAM532L4+KvX80ZduwtKxA9VAA1FyW5jZGpIfvWY6vIz6mkyaYb5YA0
        ivCNDUEauzV3oLyxcEiY4DzvKJmqROb58apZ7HCl8C5yLZMWQA==
X-Google-Smtp-Source: ABdhPJw907iLkGFK8p2URCYxMUvLznXTHPYNJweXr/u0MpCZebXcD/6xdFnHoL4YaZ4ZwoVe8Ek8/HrqJld7ZcyopYY=
X-Received: by 2002:a05:622a:1999:b0:2e2:2928:db7d with SMTP id
 u25-20020a05622a199900b002e22928db7dmr7588777qtc.160.1648177396226; Thu, 24
 Mar 2022 20:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <1648113743-32622-1-git-send-email-zhaoyang.huang@unisoc.com> <Yjx/3yi7BfH7wLPz@chrisdown.name>
In-Reply-To: <Yjx/3yi7BfH7wLPz@chrisdown.name>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Fri, 25 Mar 2022 11:02:48 +0800
Message-ID: <CAGWkznGLO7xpQK7E07dLv7ZfO53nx2fn54tVNw7-b46QnzKwkA@mail.gmail.com>
Subject: Re: [RFC PATCH] cgroup: introduce proportional protection on memcg
To:     Chris Down <chris@chrisdown.name>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        ke wang <ke.wang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 24, 2022 at 10:27 PM Chris Down <chris@chrisdown.name> wrote:
>
> I'm confused by the aims of this patch. We already have proportional reclaim
> for memory.min and memory.low, and memory.high is already "proportional" by its
> nature to drive memory back down behind the configured threshold.
>
> Could you please be more clear about what you're trying to achieve and in what
> way the existing proportional reclaim mechanisms are insufficient for you?
What I am trying to solve is that, the memcg's protection judgment[1]
is based on a set of fixed value on current design, while the real
scan and reclaim number[2] is based on the proportional min/low on the
real memory usage which you mentioned above. Fixed value setting has
some constraints as
1. It is an experienced value based on observation, which could be inaccurate.
2. working load is various from scenarios.
3. fixed value from [1] could be against the dynamic cgroup_size in [2].

shrink_node_memcgs
     mem_cgroup_calculate_protection(target_memcg, memcg);          \
     if (mem_cgroup_below_min(memcg))
             \    ===> [1] check if the memcg is protected based on
fixed min/low value
     ...
                                        /
     else if (mem_cgroup_below_low(memcg))                                     /
     ...

     shrink_lruvec
            get_scan_count
                                              \
                   mem_cgroup_protection
                                         \ ===> [2] calculate the
number of scan size proportionally
                   scan = lruvec_size - lruvec_size * protection /
(cgroup_size + 1);        /
