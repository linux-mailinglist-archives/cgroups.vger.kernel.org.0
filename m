Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1553D5200C7
	for <lists+cgroups@lfdr.de>; Mon,  9 May 2022 17:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238034AbiEIPOO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 May 2022 11:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238030AbiEIPOI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 May 2022 11:14:08 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B45428B87E
        for <cgroups@vger.kernel.org>; Mon,  9 May 2022 08:10:13 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id kl21so10630144qvb.9
        for <cgroups@vger.kernel.org>; Mon, 09 May 2022 08:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4MK5Z5duMa87oHfTgQRev3JJqnSTwXWH5fVcV34L7dM=;
        b=l+MeEY8PFGfskD3FsCOlvSab9XgG1oPg/iynQwlXTFrp/alh8KkZYehnFpakdk+2y6
         jKiO9k7kOkYPU29eqCecdB6DUs7C1PNR2Ev/yXH8aw2fNbvvy9l/YtVVbQahxBmKHV76
         m/29e1REy8tS9WU0KLk8b+3BVI/mNjWrTP6+evBbdVEgKqv6XW/bg6XuZXwtDZOlT/Hf
         fQDDLvknV+r9yrtTnJrM1LaVNhutiu1tHOYhsUCqSsvBfrOsnuazqm6H4R9vbMlZoy6J
         3FHixuJyOBVhZ7sr+23dJSEwCWrY0/paq2Z0MtQCeTzBTz5qsjpX6Mro80MNDaSvgMJT
         nGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4MK5Z5duMa87oHfTgQRev3JJqnSTwXWH5fVcV34L7dM=;
        b=4xDIwxlfrncfrldzV5JiQwmCn2uiSMMZ5pL1/urogR7yK2FJqPn4YvCeLFsymQ1Xx8
         Lg5fFrj+TOwiYiL03xAAy+BrkhPowymPUoULQkDboySrkxQn7LeCYQib9fZYNFH1HtFQ
         C+yeYnkewR2MYBdgDJRuneTyCk1sBxO7ag0OKGLIRSFixgyVFX9ZEk07ImFVMXTg+Hef
         ROewsox84aQkS/MAtwB7WMj82VNubBbI1gyfq1USwdJT3mo91OIZJFFb64nmI2ufAIk+
         uUhVLl/Kqi6BetAfdcC/aw/IKzBfBmR5ziEPWZ/F251Ddvxoy3DWeVUnJONK3U6fC3/b
         jo+g==
X-Gm-Message-State: AOAM530VmZSICi4xMBi+rH5LOYZTeDmF6yAfJSPudd5lSgVl2b7xxS7r
        33Ho4L9ffdwCRXGpf4S+LId9jF6/eJIguw==
X-Google-Smtp-Source: ABdhPJyrdOc5aCCIZRy/kHlzbTcozCuWKwx16OcowRT8isOJHxngJEvIX80+q3pDpiFPpK3GOzPE2A==
X-Received: by 2002:ad4:5504:0:b0:456:35e0:1968 with SMTP id az4-20020ad45504000000b0045635e01968mr13517316qvb.126.1652109012556;
        Mon, 09 May 2022 08:10:12 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:538c])
        by smtp.gmail.com with ESMTPSA id n1-20020ac81e01000000b002f39b99f679sm7883463qtl.19.2022.05.09.08.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 08:10:11 -0700 (PDT)
Date:   Mon, 9 May 2022 11:09:15 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     David Vernet <void@manifault.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        akpm@linux-foundation.org, tj@kernel.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, mhocko@kernel.org, shakeelb@google.com,
        kernel-team@fb.com, Richard Palethorpe <rpalethorpe@suse.com>
Subject: Re: [PATCH v2 2/5] cgroup: Account for memory_recursiveprot in
 test_memcg_low()
Message-ID: <Ynkum8DeJIAtGi9y@cmpxchg.org>
References: <20220423155619.3669555-1-void@manifault.com>
 <20220423155619.3669555-3-void@manifault.com>
 <20220427140928.GD9823@blackbody.suse.cz>
 <20220429010333.5rt2jwpiumnbuapf@dev0025.ash9.facebook.com>
 <20220429092620.GA23621@blackbody.suse.cz>
 <20220506164015.fsdsuv226nhllos5@dev0025.ash9.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220506164015.fsdsuv226nhllos5@dev0025.ash9.facebook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 06, 2022 at 09:40:15AM -0700, David Vernet wrote:
> Sorry for the delayed reply, Michal. I've been at LSFMM this week.
> 
> On Fri, Apr 29, 2022 at 11:26:20AM +0200, Michal Koutný wrote:
> > I still think that the behavior when there's no protection left for the
> > memory.low == 0 child, there should be no memory.low events (not just
> > uncounted but not happening) and test should not accept this (even
> > though it's the current behavior).
>
> That's fair. I think part of the problem here is that in general, the
> memcontroller itself is quite heuristic, so it's tough to write tests that
> provide useful coverage while also being sufficiently flexible to avoid
> flakiness and over-prescribing expected behavior. In this case I think it's
> probably correct that the memory.low == 0 child shouldn't inherit
> protection from its parent under any circumstances due to its siblings
> overcommitting the parent's protection, but I also wonder if it's really
> necessary to enforce that. If you look at how much memory A/B/E gets at the
> end of the reclaim, it's still far less than 1MB (though should it be 0?).
> I'd be curious to hear what Johannes thinks.

We need to distinguish between what the siblings declare and what they
consume.

My understanding of the issue you're raising, Michal, is that
protected siblings start with current > low, then get reclaimed
slightly too much and end up with current < low. This results in a
tiny bit of float that then gets assigned to the low=0 sibling; when
that sibling gets reclaimed regardless, it sees a low event. Correct
me if I missed a detail or nuance here.

But unused float going to siblings is intentional. This is documented
in point 3 in the comment above effective_protection(): if you use
less than you're legitimately claiming, the float goes to your
siblings. So the problem doesn't seem to be with low accounting and
event generation, but rather it's simply overreclaim.

It's conceivable to make reclaim more precise and then tighten up the
test. But right now, David's patch looks correct to me.
