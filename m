Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F85B354B34
	for <lists+cgroups@lfdr.de>; Tue,  6 Apr 2021 05:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239996AbhDFDXV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Apr 2021 23:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbhDFDXV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Apr 2021 23:23:21 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211A3C061574;
        Mon,  5 Apr 2021 20:23:14 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 185so9100880ybf.3;
        Mon, 05 Apr 2021 20:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xyUOqQqREwsmvr/dLosqt/ckIIZfER6FkNAdfyxy9uY=;
        b=t5E2hut5WjKDzvQgOPwKuWQEq9EGSvzfR4OC4bI5V7kIwUyaF3zmDBhabi5rJR82dg
         AnGwqHeGRP6h3UESEig0+hJQB2IBOmiRAmBgURVaoyk9vQ0O+woNrdMk1LV+16lPeea9
         ddoNDVZmu9CcAZMMK2ApcYu/kApWdEpBz5/sCv9FDAU/SHYE3FAlPSazpvvjzTTuA1EL
         xnupfEfwm7VYjfIRK0SYocYabKzWKVNtQlgnuLJNQTgozntliBKA4h8F1xT+wBcDd9HJ
         tnLb9D7qBtuLEFYr8XYbWepN3ak3DdRi/t+G/Ye5MQ4cl/lwY5UPsDjFasIKY1QxCrua
         5yZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xyUOqQqREwsmvr/dLosqt/ckIIZfER6FkNAdfyxy9uY=;
        b=k62D7rngSctpHmswl7V4oKhicWgLiVSCvLUp7xNXwmEPOI13MJvukLO+fJOGuF+1Gg
         ctdPU2aQYXBoaAAIgzcXciLcwavYWpykUVAzy0/dY2TA2qRJ/JyUPNHZm3V9NDMCvqSl
         ZR1F5jMhU/ILk7fCmLeF4gCWOM4dXDyt108RGLTcO8s2r5mukxFlK1ppIZdzF31GSya4
         dSyfQR3iAIsIc9/jMUx99COyUwH8IF13iP0JTJ30MZUB3+mrSwXlpA6Rko42vvHI8btR
         /eh7czErjq+IRkhpb+l5bPzHLbdztGRFWQSjx0IUGIkDp/0unAk7ULplHHPrMy0b/6f4
         nBtA==
X-Gm-Message-State: AOAM530vg3v+cJdFFqncHBTIyKxiiGlFMyvn85Q1YrW0Ht9WEXFLAmp+
        r/pArvdbVJoR+QY8LuFCV2qSzNHezjklH2CIcMU=
X-Google-Smtp-Source: ABdhPJwvn+9Sqt3YJDnBD6ITBf4KlJ8hnzi2asfm8VH645X8R3lzJQEeiZnNvEqxwztwH9Us5YonBxjhBrBHABgLnkQ=
X-Received: by 2002:a25:238a:: with SMTP id j132mr17675039ybj.117.1617679393333;
 Mon, 05 Apr 2021 20:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210402191638.3249835-1-schatzberg.dan@gmail.com> <20210402191638.3249835-4-schatzberg.dan@gmail.com>
In-Reply-To: <20210402191638.3249835-4-schatzberg.dan@gmail.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 6 Apr 2021 11:23:01 +0800
Message-ID: <CACVXFVPR+OLtPc6G-PTHNm+ro6LpzcHxxuCoFTcWHb6fmyRbKQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] loop: Charge i/o to mem and blk cg
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Apr 3, 2021 at 3:18 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
>
> The current code only associates with the existing blkcg when aio is
> used to access the backing file. This patch covers all types of i/o to
> the backing file and also associates the memcg so if the backing file is
> on tmpfs, memory is charged appropriately.
>
> This patch also exports cgroup_get_e_css and int_active_memcg so it
> can be used by the loop module.
>
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming Lei
