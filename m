Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC1D4BBD0B
	for <lists+cgroups@lfdr.de>; Fri, 18 Feb 2022 17:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbiBRQKH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Feb 2022 11:10:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiBRQKH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Feb 2022 11:10:07 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4392F105AAA
        for <cgroups@vger.kernel.org>; Fri, 18 Feb 2022 08:09:50 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o2so6412029lfd.1
        for <cgroups@vger.kernel.org>; Fri, 18 Feb 2022 08:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8gUAABA3j3f1FRh38YxGuqY86VzPDifyEVw8iwRRkpw=;
        b=cyWkAO0iWWXZ5RX3hmvLYfEnD4qtbZcgGTUs/I4Eg1grFIrrB5/Wd595bPPNN8gV75
         4uLVzqdO6mgrPtNahiDzECg+2hz2mpA/jll0Uz1e9vE3/dEfS2cHeJ7a6ELdiCq72hDx
         gBhiBpg+mRkGjwza4EY6K7UOBZ7+u69+V0AUR9zA02dO0T0bJB2yvtXHpZGOfELslWYp
         Jqzrp1aTYcHK5wKyzEHcIraox5zejrYEfvGtu64Lluf3xQcg3piCrWRqWf56z/DTi0f8
         VKyGAm8RBs2yYcH8wVnBOGwrQZiC8x90T/EmeljJ9eCVe24yF5+2EKiUZuBwMHqhtcB/
         TQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8gUAABA3j3f1FRh38YxGuqY86VzPDifyEVw8iwRRkpw=;
        b=QOs0DZcYoeMzi8pZPtadJ0VahlOdAvxy6WhvadCtPtAxZ7ubZhLwyX7eVmK5ORMqIm
         CwISVTGbKdM3sEfE66HXsoOOTaK44mNxU6fWvaEdwEbWQBg5ROQevJDoql8DN6NdejEY
         EZRinKPUQ7O5sK7kPDc71voXpIFHwkbVuOUdVBH4uAoOPMiaJt098FfS75SK8QR67j5y
         JPBBb3c6TalVRXT9FQ8BThjc7o5NGTLykglVRyk3n5Xei1tGJTb7XHRfaV1SZpGTPIOQ
         0uIxfd3DLhA6inthZxJCs/rDjuXjXhM85x2ttyNKyVnYn5F4vXZuFzt7LODwXNFxwgmx
         i1Pw==
X-Gm-Message-State: AOAM532sK4Q+phZW9d1jStZz1zbZjegsmHo0I/DH4a7obY9OZLLLaXCD
        9F2Mk0MDS4LNM0mmmORykVTOclbmsr2eeBcNDsduAg==
X-Google-Smtp-Source: ABdhPJxC+0P6mzNCudfOUmF2+1/m+DdL2qJoJkzkh8QVFxs+1WMA6P8RW8xTZO0FEIIgGs78tI0REqWRCuF2q1wdq30=
X-Received: by 2002:a05:6512:388d:b0:443:6066:2c8d with SMTP id
 n13-20020a056512388d00b0044360662c8dmr5730000lft.184.1645200588394; Fri, 18
 Feb 2022 08:09:48 -0800 (PST)
MIME-Version: 1.0
References: <20220217094802.3644569-1-bigeasy@linutronix.de> <20220217094802.3644569-2-bigeasy@linutronix.de>
In-Reply-To: <20220217094802.3644569-2-bigeasy@linutronix.de>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 18 Feb 2022 08:09:36 -0800
Message-ID: <CALvZod5FdXwim6ftgBqQRiXw6exv-Jj9ey+awkVDC1F8YTOBMQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] mm/memcg: Revert ("mm/memcg: optimize user context
 object stock access")
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>
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
> From: Michal Hocko <mhocko@suse.com>
>
> The optimisation is based on a micro benchmark where local_irq_save() is
> more expensive than a preempt_disable(). There is no evidence that it is
> visible in a real-world workload and there are CPUs where the opposite is
> true (local_irq_save() is cheaper than preempt_disable()).
>
> Based on micro benchmarks, the optimisation makes sense on PREEMPT_NONE
> where preempt_disable() is optimized away. There is no improvement with
> PREEMPT_DYNAMIC since the preemption counter is always available.
>
> The optimization makes also the PREEMPT_RT integration more complicated
> since most of the assumption are not true on PREEMPT_RT.
>
> Revert the optimisation since it complicates the PREEMPT_RT integration
> and the improvement is hardly visible.
>
> [ bigeasy: Patch body around Michal's diff ]
>
> Link: https://lore.kernel.org/all/YgOGkXXCrD%2F1k+p4@dhcp22.suse.cz
> Link: https://lkml.kernel.org/r/YdX+INO9gQje6d0S@linutronix.de
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Acked-by: Roman Gushchin <guro@fb.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
