Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42BAB3421DC
	for <lists+cgroups@lfdr.de>; Fri, 19 Mar 2021 17:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhCSQ2R (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Mar 2021 12:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhCSQ2A (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Mar 2021 12:28:00 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2FCC06174A;
        Fri, 19 Mar 2021 09:27:59 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 7so3471885qka.7;
        Fri, 19 Mar 2021 09:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GB8fLktR1tASbymjnw9MkDMpjTuRuzJA8+s7LyK6qUQ=;
        b=eJed0rdQmwld1oV5DxS1T1YtkrbMaqJ1tOXo4HOxJxPS7I0t+1BK1131yQRBhY0c+0
         +a19lDqoVbwMkqJ82rQqePPUQ9PQsCtUDy8dYdAWEZ6ojU4Wja4Sa4dsigEXtLkusiAX
         GwgC6POaDS39VhIA0yTzLD0JhB8xhftzQA/wNElUk22lu3izcL2tBGh+Cnki9jK2xWQ7
         uhfknpBJPZZTt0x9RtA1Pmg8VO1WL63RdOe0FZCCxheqUERCc5UD+VlODkT+eU8ByBfJ
         EfFzXqR1JWhWqQx4m5oiK+OavkbxjJSsntwEFUP45GWG0Ec3ppbzWr26IleYojzHc/Q7
         B2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GB8fLktR1tASbymjnw9MkDMpjTuRuzJA8+s7LyK6qUQ=;
        b=IQ5yrghe/62o7RFuT+f8CDu85WL2Rp8Yo0/NKScERYt62IICDkK7us8QPJPKghftWj
         53vccPXRmKESZ1m4hc7mtsbPGJkKzTfascrvP2w/djnvf7+oyoBPQSpFCDMjDRxSi3Fd
         lzQmJ0t8tCv6o+pWWqqHjh1WA3tpOkvW4e6I5NTjxhqF8hqnMpurS5Yk7m0uErMPT4H5
         AwOtJDRQyi73784cjRsBHC/zNJ58C0oU8GdzCcKY+3tBQHaVsHp5n09uoBJmZLgiKSx8
         b+BZZeOERmzxoWlWeAWvvYoG70rEarhj3UxIVpAeyURPgyfqp20d/KpSostA0icmbDMt
         iPbQ==
X-Gm-Message-State: AOAM533sRmWLlNvVDAffGRuyu769Kp/VVm+pAznLHnQDYG37fYJ4Y1j7
        Z1vEKJLAsaCqhFp46VbL6cKd0yB2UydIrw==
X-Google-Smtp-Source: ABdhPJy/VCPTl8fX2bMyhhXNPffa662QTa4mLfvAb7DD5SAuVqVKrO+huQdgRCH/0ahCgaRobzmFdg==
X-Received: by 2002:a37:98f:: with SMTP id 137mr10025758qkj.357.1616171278841;
        Fri, 19 Mar 2021 09:27:58 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com ([2620:10d:c091:480::1:41da])
        by smtp.gmail.com with ESMTPSA id p8sm4119303qtu.8.2021.03.19.09.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 09:27:58 -0700 (PDT)
Date:   Fri, 19 Mar 2021 12:27:55 -0400
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
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
Subject: Re: [PATCH v10 0/3] Charge loop device i/o to issuing cgroup
Message-ID: <YFTRCwqMAhLtST17@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
References: <20210316153655.500806-1-schatzberg.dan@gmail.com>
 <7ca79335-026f-2511-2b58-0e9f32caa063@kernel.dk>
 <CALvZod6tvrZ_sj=BnM4baQepexwvOPREx3qe5ZJrmqftrqwBEA@mail.gmail.com>
 <8c32421c-4bd8-ec46-f1d0-25996956f4da@kernel.dk>
 <20210318164625.1018062b042e540bd83bb08e@linux-foundation.org>
 <CALvZod6FMQQC17Zsu9xoKs=dFWaJdMC2Qk3YiDPUUQHx8teLYg@mail.gmail.com>
 <YFTIepcb+qm/+/9d@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
 <CALvZod7TyCb1c9iPYmf4aGiCgcb9fboRDXiChaYDCBQHii+J7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7TyCb1c9iPYmf4aGiCgcb9fboRDXiChaYDCBQHii+J7A@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Mar 19, 2021 at 09:20:16AM -0700, Shakeel Butt wrote:
> One suggestion would be to make get_mem_cgroup_from_mm() more generic
> (i.e. handle !mm && active_memcg() case) and avoid
> get_mem_cgroup_from_current() as it might go away.

Yeah, that occurred to me as well. I'll take a stab at doing that.
