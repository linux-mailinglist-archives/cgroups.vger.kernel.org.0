Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69C7370799
	for <lists+cgroups@lfdr.de>; Sat,  1 May 2021 16:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhEAOm3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 1 May 2021 10:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhEAOm2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 1 May 2021 10:42:28 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071B1C06174A
        for <cgroups@vger.kernel.org>; Sat,  1 May 2021 07:41:37 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id x8so1093167qkl.2
        for <cgroups@vger.kernel.org>; Sat, 01 May 2021 07:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ugedal.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+9JnfpgxvBiyhUpVXmBLUzz03NBbrZEjK+KMYKJ2t20=;
        b=RnQunxucB260CYXVbm79inYUHgZ5kmjIdmnW3OLRGx5Q+i4uqZCiTmKRoKd0R0TXLV
         P6L8xkfjAcIlpz2bAmkNzp+L9/JpLVObdX27DZEcg1F9p+BCVj364+5+rces1tNfa5U/
         I8UPM+Ya3vSjP4F5N3Dqg4/XCVuoUSHmiQVqb8hXDcrR/amfimYOkdx3EefnQaOnVIxg
         tLbrEAHfJZ5LvRMFZJWULKFp+nASHLjP64VqxjGylJvIXlAdfGkU3WXhYQfXAfP8u3IQ
         Sezbjwgv+EJe6NEYmcNoE7zGIV6U/G2Hhz2dZ6geBBw85xFAQY5QdrVb4DWUSRrjsMrp
         0t5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+9JnfpgxvBiyhUpVXmBLUzz03NBbrZEjK+KMYKJ2t20=;
        b=rjObfwHvnwjWGloeGvMdmNwwpiotHnwqjMD8U2aG0BVnSDpYIWoOLsDTY9QzR4TRQN
         HW6QB1h0TicRba6X1pIoX8p5VDpF/L9W6wcMCjPhHANB00TmQCBH9fHjqV41WzdRmioK
         BOh/Gb9nJlDSCw4tKh2qIBfmmTkTFNVLQeylO4bKXLscHPc5JtXOKbCagL+v3gxYlfmQ
         xipc9K9XpP0O0RgSQcNej2SuSXta8whTJkCc3fnKJ0QWH9F5Fw9D9AuuvGwx7SaMqSCP
         mYq+VHhgv5978lMhtK2IVlP1W0pQ6LVkGhJY6SCAYumfv2QAtAFPrJibI3tbk73ur6FM
         l8OA==
X-Gm-Message-State: AOAM533QMJ57QuxHITYq9DNTKJpHb8NBUgJgcjV7cBr7JS/zbZZQvdF+
        P/Z5v/e0A31XF1XktJTJQWKrBEDJTTfOODxetlFvBw==
X-Google-Smtp-Source: ABdhPJyWgSHVKEXPER/7IfIcz98GlwMr0AgGhNvCqe19/dta7G7yZ+iD5nISVKSVlTChdgopDKP+A2OctJgI/Y5NmQc=
X-Received: by 2002:a37:e10e:: with SMTP id c14mr10319909qkm.209.1619880096227;
 Sat, 01 May 2021 07:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210425080902.11854-1-odin@uged.al> <20210425080902.11854-2-odin@uged.al>
 <20210427142611.GA22056@vingu-book> <CAFpoUr1KOvLSUoUac8MMTD+TREDWmDpeku950U=_p-oBDE4Avw@mail.gmail.com>
 <CAKfTPtCtt9V69AvkJTuMDRPJXGPboFsnSmwLM5RExnU2h5stSw@mail.gmail.com> <4ba77def-c7e9-326e-7b5c-cd491b063888@arm.com>
In-Reply-To: <4ba77def-c7e9-326e-7b5c-cd491b063888@arm.com>
From:   Odin Ugedal <odin@ugedal.com>
Date:   Sat, 1 May 2021 16:41:03 +0200
Message-ID: <CAFpoUr3vMQq8QYajXZsQ6zWQOncO5Q8-2gFWOJLFm-APUznuZA@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched/fair: Fix unfairness caused by missing load decay
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Odin Ugedal <odin@uged.al>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

> I think what I see on my Juno running the unfairness_missing_load_decay.sh script is
> in sync which what you discussed here:

Thanks for taking a look!

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 794c2cb945f8..7214e6e89820 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10854,6 +10854,8 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
>                         break;
>
>                 update_load_avg(cfs_rq, se, UPDATE_TG);
> +               if (!cfs_rq_is_decayed(cfs_rq))
> +                       list_add_leaf_cfs_rq(cfs_rq);
>         }
> }

This might however lead to "loss" at /slice/cg-2/sub and
slice/cg-1/sub in this particular case tho, since
propagate_entity_cfs_rq skips one cfs_rq
by taking the parent of the provided se. The loss in that case would
however not be equally big, but will still often contribute to some
unfairness.


Thanks
Odin
