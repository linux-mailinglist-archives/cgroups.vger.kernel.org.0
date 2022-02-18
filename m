Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6D24BBFAC
	for <lists+cgroups@lfdr.de>; Fri, 18 Feb 2022 19:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbiBRSkc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Feb 2022 13:40:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237396AbiBRSkb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Feb 2022 13:40:31 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB992A072E
        for <cgroups@vger.kernel.org>; Fri, 18 Feb 2022 10:40:15 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id u20so7105675lff.2
        for <cgroups@vger.kernel.org>; Fri, 18 Feb 2022 10:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JG7CBAmO1pjbLUUkaVNCRR+CekFRKgJLo0xYPxAI1lw=;
        b=P/EPFiUa21gKmNj7gaOV4hyboq1mh+5Kwu1Zzsh/B+dv3dHVY/RAViisL/ZO3ek6yK
         QDakcXkEH72XrDe7zvdXxjOijB4CbhWy4rm+hFVdoaJGMxDEZsXAKE4h1RVoW5QNmzUx
         xWKNe3jLE5H0KVn7YdrxL5nDSOAeAc9HS5/+QnUU85/JFkQz4WD4wUJbV55sdOYrb/Fn
         kRX1jgJNzMVN1nygaY40Y4N6V5OqaRnKM8myWEhGQZSvP4ZejRmOWnIzB6LCwPihIEPY
         w/mgMpYfQAkrK+ebvEaBYKIsG/66BdH7WrBc8sr9OtPhTJybesZ8RAnqOTLP01OM4dr8
         fl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JG7CBAmO1pjbLUUkaVNCRR+CekFRKgJLo0xYPxAI1lw=;
        b=JxZdbZAYRJxxLR+K+LDraarG0Xee4ONEiQlANGjDAIWWkDjZw69P/w6B43LTf4ndyK
         nTONENalOtWswCcTfvyBSmx5XCAZ5Flj7q11Dv1t4Y2OMQ5kpvQucAfNoHz2DGFVGAOE
         Zb0DDW4A3a5fu25F0rTu2K+XnQpGX0eHjcarNKRSJHgKSuVq8iYmf1A2CvI/AcNvqqKL
         +/jpZKlWpmOwq2Hm9y5cjfHvDa4+mPSU7pzZkZ/VkZWSsggiRc7BGNHKtbp5UZ9HWXCF
         js2YqrjGOJuykLt03oGgHaz6TYFoYLz0mEP6+CqqcQENztvtFZlDs+DKGcbuicAmzYjN
         ofoA==
X-Gm-Message-State: AOAM533y8iYMNgX8cCGh5KsI/7xaU+9J0Lf3ITwv2KwLiojFVWDyIEqj
        qEAoMTwYRO0JxqqG2dhup7fw2bqn8+ey70B28tC1pR/S6aU=
X-Google-Smtp-Source: ABdhPJx9PZ6JxhsrPBmRnz4aiPMRblHlFiegZ4TwoHa84jB+WzSk9gnsC70uTF2ZIwKDHAfRBz2De62SX3bJBAwtvxU=
X-Received: by 2002:a05:6512:3131:b0:443:3f0f:754b with SMTP id
 p17-20020a056512313100b004433f0f754bmr6245792lfd.494.1645209613255; Fri, 18
 Feb 2022 10:40:13 -0800 (PST)
MIME-Version: 1.0
References: <20220217094802.3644569-1-bigeasy@linutronix.de> <20220217094802.3644569-5-bigeasy@linutronix.de>
In-Reply-To: <20220217094802.3644569-5-bigeasy@linutronix.de>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 18 Feb 2022 10:40:01 -0800
Message-ID: <CALvZod7PTwJp3eFgXiG1Qb8fJZviFZRBZ1OehV+85pwNdwcHYQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] mm/memcg: Opencode the inner part of
 obj_cgroup_uncharge_pages() in drain_obj_stock()
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 17, 2022 at 1:48 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> From: Johannes Weiner <hannes@cmpxchg.org>
>
> Provide the inner part of refill_stock() as __refill_stock() without
> disabling interrupts. This eases the integration of local_lock_t where
> recursive locking must be avoided.
> Open code obj_cgroup_uncharge_pages() in drain_obj_stock() and use
> __refill_stock(). The caller of drain_obj_stock() already disables
> interrupts.
>
> [bigeasy: Patch body around Johannes' diff ]
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
