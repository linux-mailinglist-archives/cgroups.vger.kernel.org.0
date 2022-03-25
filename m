Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1EE4E6CC4
	for <lists+cgroups@lfdr.de>; Fri, 25 Mar 2022 04:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244677AbiCYDKD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Mar 2022 23:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiCYDKD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Mar 2022 23:10:03 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5151219C2E;
        Thu, 24 Mar 2022 20:08:29 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id r1so5255987qvr.12;
        Thu, 24 Mar 2022 20:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ybNnrZFvehO2sUrmgdaOmgMmA2BO+ZMqy7l4uheBs3w=;
        b=d+ONl8cm9H4sIOtGkMCPjNwc/0kPC9Xeh1De38kzAoHKpgEq0pRLnhYGQQceA5GN0I
         iAfkjzOWFtqcqV2eaKpyGvm0FVPlAUg4/NStnrqiE1dK3ONC3OHPOAxPajhhs4NkDjkj
         U2WnnZtAeHRyOsQIpWVTkKuSIqq4MUsCJDqajwAOXLT3RiEeSaZpFuYuM3XLFxJ7Nk9W
         fDfqe+v8mWKAw0cZvTEqtUryRbLofh/weFka/Izo3auYzot6RdOcGIqEozdp1JnWtlWK
         DSJbQ9l3FpEw8qbR0eWFgy3J1IC2NiMJy3kCAhNp3t94C8bowwUO9yJJq+1IKPJuB9g8
         M3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ybNnrZFvehO2sUrmgdaOmgMmA2BO+ZMqy7l4uheBs3w=;
        b=oK4Yot7MghxS1SxRuWIY7+WmSOGf/P7TNtNtGLAJP3LAEecYDtDaN1lrl3DZ00yEge
         o064ctyjFOrRmzHD8aPYZBU0FB+jI5rAEkNugexerF7xXnzitml/lFk+XXmELLordIW7
         9N7JNQOxDK3rucMIw/Kp5yxrxkIp/dZLHsiDgnrrjutDg+yOb9BFk8S8yMwFePyAv6kJ
         nvRxC/t0ksqYcFVQrSjP8+OdMWfSAMl+Sq6XVEb619r7gO3g55HxidYjAPkVoOHv2ljj
         AIfAtfa3+Lt0oURBHXFTC2QmV44P7CFm+36aZQD7bWryzK/MzQ2usKq+eqvXzM0zIh0X
         W4LQ==
X-Gm-Message-State: AOAM532SGyd2VjSNMXPJup9x03ouk9S/mUS1l3C8XWbmOeZBDNFFtNho
        OO7RxeF6ys0aGUXb7haVSH+NJoi/jEFnyxW8hMc=
X-Google-Smtp-Source: ABdhPJxsnPOesyWogaWyVJTt4mMq8tJelTDADS1Yx8hNRsCJLvPjsPVLoTW5e5D6Om/xI8Z2C/jvzamoPYNJudFS8ng=
X-Received: by 2002:a05:6214:2522:b0:441:404e:7317 with SMTP id
 gg2-20020a056214252200b00441404e7317mr6966072qvb.77.1648177708580; Thu, 24
 Mar 2022 20:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <1648113743-32622-1-git-send-email-zhaoyang.huang@unisoc.com>
 <Yjx/3yi7BfH7wLPz@chrisdown.name> <CAGWkznGLO7xpQK7E07dLv7ZfO53nx2fn54tVNw7-b46QnzKwkA@mail.gmail.com>
In-Reply-To: <CAGWkznGLO7xpQK7E07dLv7ZfO53nx2fn54tVNw7-b46QnzKwkA@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Fri, 25 Mar 2022 11:08:00 +0800
Message-ID: <CAGWkznGAmML4XB0t5jOZEoafQrFk=gXvP96Lmgh221Y22bUuyw@mail.gmail.com>
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

On Fri, Mar 25, 2022 at 11:02 AM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>
> On Thu, Mar 24, 2022 at 10:27 PM Chris Down <chris@chrisdown.name> wrote:
> >
> > I'm confused by the aims of this patch. We already have proportional reclaim
> > for memory.min and memory.low, and memory.high is already "proportional" by its
> > nature to drive memory back down behind the configured threshold.
> >
> > Could you please be more clear about what you're trying to achieve and in what
> > way the existing proportional reclaim mechanisms are insufficient for you?

sorry for the bad formatting of previous reply, resend it in new format

 What I am trying to solve is that, the memcg's protection judgment[1]
 is based on a set of fixed value on current design, while the real
 scan and reclaim number[2] is based on the proportional min/low on the
 real memory usage which you mentioned above. Fixed value setting has
 some constraints as
 1. It is an experienced value based on observation, which could be inaccurate.
 2. working load is various from scenarios.
 3. fixed value from [1] could be against the dynamic cgroup_size in [2].

 shrink_node_memcgs
[1] check if the memcg is protected based on fixed min/low value
     mem_cgroup_calculate_protection(target_memcg, memcg);
      if (mem_cgroup_below_min(memcg))
      ...
      else if (mem_cgroup_below_low(memcg))
      ...

[2] calculate the number of scan size proportionally
     shrink_lruvec
             get_scan_count
                    mem_cgroup_protection
                    scan = lruvec_size - lruvec_size * protection /
(cgroup_size + 1);
