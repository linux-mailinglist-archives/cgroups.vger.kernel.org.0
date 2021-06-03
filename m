Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E7839A1F0
	for <lists+cgroups@lfdr.de>; Thu,  3 Jun 2021 15:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhFCNPA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Jun 2021 09:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhFCNPA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Jun 2021 09:15:00 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C5CC061756
        for <cgroups@vger.kernel.org>; Thu,  3 Jun 2021 06:13:15 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id i68so2242949qke.3
        for <cgroups@vger.kernel.org>; Thu, 03 Jun 2021 06:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CBnvtPJLdU3kbekuheh4qc6OMIUkdKF2nOgchdFq6rc=;
        b=YydysQuJcuB2zxLOLbU7aPah7Lb9RIs2OcRo39zEyZjr57DV83DYJnlesShXVJ/QiQ
         OE6cEKWBwFj9wQk7+c5zcnkWBG54Kkxqbl0M6gEgwbP9dS/rvWFPp4cub55w8/YvXPJ4
         ZFERiNBM+Cd4rd+RFXXpgR98D4/TL67NEbVKyJ7BLxl8fkqjOVGC9YvpCzEnyREsUAnS
         bf0nyIKcT8C8/5soIFtGyBGiTRiG2Xgvl7Y2a20N9wXoTizrqKcrnvflGNSAUbTT4s/8
         dL3l5XRaR6DQt5pW+i0CaDjUpMTGsww5MQnDP1M6A+xnZIp6AK3AxMIRKWCDgTRszgzh
         7H0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CBnvtPJLdU3kbekuheh4qc6OMIUkdKF2nOgchdFq6rc=;
        b=BYyiIkKM3JXCB6ww0OIvoFRriihAON5S69/jQjqNBtaaIKdx26CKs02jXgWtek9fPA
         6072WdY/m3gADc0yAYAfeQm7n2LT6GTQqyoRqBTQxnQDPa+nlCHZZV3YcPhjD+houNXF
         P7w63beatTqp+zPdX2gBiyCscHSK5V//RY6Leh04h0SskqqL+a1scKDU4P90su2RRcau
         53oRSSfDmOev09bK2wM8fRrcFqwrZNCcp3TQsvIPZTF4eGNzIVK5cdf07iAY1sWUQFkN
         gG83ZrVidpbIKqnhsBo74hKAPngf7/85hzIqCDaQ7CbpBz5w363ShounQQVoWasS6ZN8
         QIqQ==
X-Gm-Message-State: AOAM532jmSuGUFkBZupSsAHCpYfT0rv815NIc2/jvJilxVaNoSa32yCb
        H7Rsiv7+hhz+DC5b/bR8VXNdFBzfm/r/9OzpTfky2g==
X-Google-Smtp-Source: ABdhPJy3fg1eAKeZKx3roYQlvpzvGEXbvbyAsV6pgVkJRFM2NKaW6ztQcywMc9i70oYtHcwhz5ThuxN3kRbAY9Jf8wE=
X-Received: by 2002:a37:8b47:: with SMTP id n68mr4054613qkd.209.1622725994875;
 Thu, 03 Jun 2021 06:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210603113847.163512-1-odin@uged.al> <CAKfTPtAK3gEqChUmoUXo7KLqPAFo=shH4Yi=QLjrwpuu6Ow6-Q@mail.gmail.com>
In-Reply-To: <CAKfTPtAK3gEqChUmoUXo7KLqPAFo=shH4Yi=QLjrwpuu6Ow6-Q@mail.gmail.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Thu, 3 Jun 2021 15:12:35 +0200
Message-ID: <CAFpoUr2HBexs5784nU7hyDSs0eNiEut=-4wWcnpMtSVtFeaLLA@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Correctly insert cfs_rq's to list on unthrottle
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Odin Ugedal <odin@uged.al>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

> Out of curiosity, why did you decide to use
> cfs_rq->tg_load_avg_contrib instead of !cfs_rq_is_decayed(cfs_rq)
> which is used to delete the cfs_rq from the list when updating blocked
> load ?

Well, the main reason was that it is currently (without the other in
flight patches) not safe to just use "cfs_rq_is_decayed" directly,
since that could result in
a situation where tg_load_avg_contrib!=0 while
cfs_rq_is_decayed()==true. I guess we can use cfs_rq_is_decayed() if
you prefer that,
and all the other PELT patches are merged. (This was initially why I
thought a new field was a simpler and more elegant solution to make
sure we book-keep correctly,
but when the PELT stuff is fixed properly, that should be no real
issue as long it works as we expect).

I was also thinking about the cfs_rq->nr_running part; is there a
chance of a situation where a cfs_rq->nr_running==1 and it has no
load, resulting in it being decayed and
removed from the list in "__update_blocked_fair"? I have not looked
properly at it, but just wondering if that is actually possible..


Also, out of curiosity, are there some implications of a situation
where tg_load_avg_contrib=0 while *_load!=0, or would that not cause
fairness issues?

Thanks
Odin
