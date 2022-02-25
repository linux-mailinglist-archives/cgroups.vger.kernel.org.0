Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18A44C4BA6
	for <lists+cgroups@lfdr.de>; Fri, 25 Feb 2022 18:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238057AbiBYRJI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Feb 2022 12:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237751AbiBYRJH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Feb 2022 12:09:07 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0F017B8A3
        for <cgroups@vger.kernel.org>; Fri, 25 Feb 2022 09:08:34 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id y11so5211334pfa.6
        for <cgroups@vger.kernel.org>; Fri, 25 Feb 2022 09:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JKBFp/+QmdkMl3W2CNCuhdgLoZgTOVOm62o/vgJZi/w=;
        b=HvtTf0aOv5iPGo064vKxcuLQ17FFIg+BoA294KV6ssoXN0UKe1Irs+22XOPAWWqtGE
         4iEfPdX03oAOFR9M7UMcq6Yfzj85bvEYotaIp6nft1LKgTj/QgVYoNRtIVQvi271iVY2
         qfVuvMzoZfV/R9IegCaNbraeZ222UG0SN6Bco9sAgTRz0lbWGhbXqMhUjGJkeB+SNUG3
         re3NDnnS1q0E3NnRZiZJS+swJy/YLm8Xo9UGKX1PXWmp+eEZbhrQZkQM8Inh3BZpIrkq
         YFN2ixSSHfssooXM+6HvJY/i1VNwO4802U2JuKTiozHH0MGmg7/JrsyEpL0ztObKX3TN
         hG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JKBFp/+QmdkMl3W2CNCuhdgLoZgTOVOm62o/vgJZi/w=;
        b=w6tX1kenZ3aGKuj+B6l0aqVWGkrszLgOdEWkSC9XwslEn3XtB6uzSCF7IDUEaKKd9h
         Zg4GDVi7DUcX1U5HNeVWrUtFPIhAHls96REWGiB9KNj80z0VUaIWzB1opXR29MkvzoH6
         jYs3P0+6HgEiJO6viKgMbbaD//N0Oan7wnYBalHAzI7tzsrclVn1GR9ZJeUtxBNiWNRk
         oGGGCHtnvlk+s45CW7Q/qnsOHAKjPmqusILRNPmSKRCm6ruAyMLJNp7LveadKQfTCHId
         l6xj7p82vJBEZdqknoiNNLYIUPN4FXWGJYReA3bkUUlP0IEVICc4BUKM3vm42A8FoCc4
         htDQ==
X-Gm-Message-State: AOAM532sw7xE9IPHkhTAaeLz9elERuFnnGfubS4CU3fQomqLIKfAP+Ob
        xmQYGFaxpOEZB0YoGERXxkiPO0h7NPMyOI34NOMACw==
X-Google-Smtp-Source: ABdhPJxzgWYZohgTKo1QuNgSvTB1IKvNJ0LcuNCD5Cweh5M4YQGTb/OCuCn/4I2TOwzs8n9FitLqFD21bp88y9lVFwM=
X-Received: by 2002:a63:5148:0:b0:373:c8d7:f23f with SMTP id
 r8-20020a635148000000b00373c8d7f23fmr6837953pgl.509.1645808913778; Fri, 25
 Feb 2022 09:08:33 -0800 (PST)
MIME-Version: 1.0
References: <20220221182540.380526-1-bigeasy@linutronix.de>
 <20220221182540.380526-4-bigeasy@linutronix.de> <CALvZod7DfxHp+_NenW+NY81WN_Li4kEx4rDodb2vKhpC==sd5g@mail.gmail.com>
 <YhjzE/8LgbULbj/C@linutronix.de>
In-Reply-To: <YhjzE/8LgbULbj/C@linutronix.de>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 25 Feb 2022 09:08:22 -0800
Message-ID: <CALvZod48Tp7i_BbA4Um57m989iuFU5kSvbzLhSOUt23_CiWmjw@mail.gmail.com>
Subject: Re: [PATCH] mm/memcg: Add missing counter index which are not update
 in interrupt.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>, Roman Gushchin <guro@fb.com>
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

On Fri, Feb 25, 2022 at 7:17 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> Shakeel Butt reported that I missed a few counters which are not updated
> in-interrupt context and therefore disabling preemption is fine.
>
> Please fold into:
>      "Protect per-CPU counter by disabling preemption on PREEMPT_RT"
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks. For the folded patch:

Reviewed-by: Shakeel Butt <shakeelb@google.com>
