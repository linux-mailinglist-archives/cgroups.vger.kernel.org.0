Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B62F409C7F
	for <lists+cgroups@lfdr.de>; Mon, 13 Sep 2021 20:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240006AbhIMSqf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 14:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236927AbhIMSqf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Sep 2021 14:46:35 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDD9C061574;
        Mon, 13 Sep 2021 11:45:19 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id g14so9712977pfm.1;
        Mon, 13 Sep 2021 11:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YWQhTVi3cs3JhEQkXnoGLByH48od8NQU5b4m5WXkDH8=;
        b=ajImzOPzIfdLH/DVFsbWet7ZSb4LKXdqbbLvOKr39wNgttg3S9EUsZh2Rhpg+Z1pAl
         O/qjf5fIPJ/GlnGp8VI95IZYWODrwbOiJAll9AUY9Z/mBaae9oApuuqBMBzmeqJ2TaJM
         8Am5CkD+Nnzn2Ap9p7owSLLz00FZVNRxUhKzhT6lJ4LuYI4dzOcynuUi0uQAaF4WgDS0
         pY4rrBTCTgrhDFuPE5JdAcMsfRVEuurYBEVXBxaydbgJuCKsgSmCaN2Wa4iHgAvnB0IE
         BHp/92Ogv//OqKQ1Ds3Wb8TUQMLhISBbltyE+D77K/yT9yjrionF6VAtBYdygTUSXsF4
         MxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=YWQhTVi3cs3JhEQkXnoGLByH48od8NQU5b4m5WXkDH8=;
        b=yKlM+HbNv40f9veXSDYDVaFTlEr8FK/36Xefbd1jtU8FYwelk12pu0iT6CCjC3Vbv4
         jch1Y/JdRmPi4Opd1F4wNFaDGJtOumlqn1oV+rTcltgGdqposI8RGR1PR3PWYioCe4qr
         1z2nvYTA5q8C+AqFq345kp3C46To70ZWLZGzEd1XiKuAsXx9jEouVtF6nfaS55o3J4mT
         UCuQotxFtKKcmnSEFzWdC3aAbMEFAZYn6mxVeZ13ywN0GPRCLyeVFKBP5n2wv1Uph0Df
         LS5O5BSWOMT8qEUEmZiwx5E9AapsTR6NiKQ/KWT+Vj/JAyuCKynEyXodTEM5m10tVNzU
         BuZA==
X-Gm-Message-State: AOAM533GOQeOHDBwUMdUWtY/eq3SDn2FooOSAlNDnO9donXQSHNaJQnq
        PX47emIVoFdC+WDo4gVaTXA=
X-Google-Smtp-Source: ABdhPJw0J4Mf8RIXJ2qtm0XN2cHnWMvkOwsMq1Xx3Mq2kd3HQG4/0iKC71yjg8lqMsqyXNMt8UGf9w==
X-Received: by 2002:a63:3503:: with SMTP id c3mr12077422pga.393.1631558718525;
        Mon, 13 Sep 2021 11:45:18 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id x24sm7867469pfr.131.2021.09.13.11.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:45:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Sep 2021 08:45:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <llong@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Juri Lelli <juri.lelli@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cgroup: Fix incorrect warning from
 cgroup_apply_control_disable()
Message-ID: <YT+cPPyDPimHibSC@slm.duckdns.org>
References: <20210910024256.7615-1-longman@redhat.com>
 <YT+TA6ItnF9xM3cR@slm.duckdns.org>
 <125c4202-68d1-1a4e-03d6-2b18f0794ba4@redhat.com>
 <dbb1a221-b3d2-5086-e47b-8a2c764d60ad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbb1a221-b3d2-5086-e47b-8a2c764d60ad@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 13, 2021 at 02:43:44PM -0400, Waiman Long wrote:
> > The problem with percpu_ref_is_dying() is the fact that it becomes true
> > after percpu_ref_exit() is called in css_free_rwork_fn() which has an
> > RCU delay. If you want to catch the fact that kill_css() has been
> > called, we can check the CSS_DYING flag which is set in kill_css() by
> > commit 33c35aa481786 ("cgroup: Prevent kill_css() from being called more
> > than once"). Will that be an acceptable alternative?
> 
> Something like
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 881ce1470beb..851e54800ad8 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -3140,6 +3140,9 @@ static void cgroup_apply_control_disable(struct cgroup
> *cg
>                         if (!css)
>                                 continue;
> 
> +                       if (css->flags & CSS_DYING)
> +                               continue;
> +

So, I don't think this would be correct. It is assumed that there are no
dying csses when control reaches this point. The right fix is making sure
that remount path clears up dying csses before calling into this path.

Thanks.

-- 
tejun
