Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DD355D7CF
	for <lists+cgroups@lfdr.de>; Tue, 28 Jun 2022 15:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiF0Q3w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Jun 2022 12:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237015AbiF0Q3v (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Jun 2022 12:29:51 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7867EB4BE
        for <cgroups@vger.kernel.org>; Mon, 27 Jun 2022 09:29:50 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v65-20020a1cac44000000b003a03c76fa38so5203843wme.5
        for <cgroups@vger.kernel.org>; Mon, 27 Jun 2022 09:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kCgDBgQt6lsYAKDyUa0fPFsfL97zuKyIxwCybKNVm6o=;
        b=IuiG/blkJ7gXjOQhLgtlkFYoJRK5r8pgakqSWN1/zlxqf40s05Q2KxgVLRnXAzs+fg
         ulTgDq4Xa1IQ2RvaytKxJcvgFOnViaFiqQeqoT8bFMwQmOfmx5WYvBOMGbjbujaxBKq2
         ZxRw26go6NuTS6kLvJS34xZfj51gNbDxnvzESq7KPA+97DIORIk3qqV6wvZaFYlRyp37
         iYjN5F2Fx3qCzsMwgAJwoELntygw5WoMYjcgqI9vY49AS4kLGOtkbsV2NX3QusZYb24t
         UMBgY7EFeybOiOqeaEkIwXo3wZRzJbzLQJE66d9iQWRd6teu2XSLOdmiKZKg0XoS0prd
         qUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kCgDBgQt6lsYAKDyUa0fPFsfL97zuKyIxwCybKNVm6o=;
        b=5VERayAZ0zqtAb8w3DENdszoZ9M0Nj41ibMnla5pywhxwEDGaifG2U+wJFDr5t47a9
         Yi4Yy9tRct7McoK7+BJXdLPJEqOOHyGLUyIPjvAta7nTChgia+WLVXbbt+U+6dlE7a6m
         qLi0s5Fcmg3wGMwndQrVee+jFfvoJeJf/pdKdxoOa5apUfquTsFS0JzyYeqBhMQLmOwy
         rRhpnTPJQZF0kE63czg+sr7OgN5Z4bSFfmB7GChfUgy9PFAOKGKl+QYOetW9ugvdgPyl
         ampJ+WW5Wk7HEQRTVBtEmhKZzhuYiRW8HYHs6QrL2fGz3FvRdb2vXp21JQ0aTDBCTijv
         HIXQ==
X-Gm-Message-State: AJIora9AN1/pqAZybhFcJvRgub0q4rorlK+pdOZDLTVLxp23avi6+ZMb
        VluKItZRiucq1iGeB8QBF7B08HTEJO2n2zfn88lsyg==
X-Google-Smtp-Source: AGRyM1vrDRm9Dztps4OpWjfEHDZNDaLLcMTy/XMsmuqPQoMJ/tNBlVur8bjCqgfF0MDzD0AVg6RDeZvfzsVoc13BMio=
X-Received: by 2002:a05:600c:34cc:b0:39c:832c:bd92 with SMTP id
 d12-20020a05600c34cc00b0039c832cbd92mr16254989wmq.24.1656347388958; Mon, 27
 Jun 2022 09:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220606222058.86688-1-yosryahmed@google.com> <20220606222058.86688-4-yosryahmed@google.com>
 <YrnZVgq1E/u1nYm0@google.com>
In-Reply-To: <YrnZVgq1E/u1nYm0@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 27 Jun 2022 09:29:12 -0700
Message-ID: <CAJD7tkbkgruPRrfyaHGQcOgmNFCWRASaZB-a8igBScpasfC64g@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] KVM: x86/mmu: count KVM mmu usage in secondary
 pagetable stats.
To:     Sean Christopherson <seanjc@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Oliver Upton <oupton@google.com>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
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

On Mon, Jun 27, 2022 at 9:22 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Jun 06, 2022, Yosry Ahmed wrote:
> > Count the pages used by KVM mmu on x86 for in secondary pagetable stats.
>
> "for in" is funky.  And it's worth providing a brief explanation of what the
> secondary pagetable stats actually are.  "secondary" is confusingly close to
> "second level pagetables", e.g. might be misconstrued as KVM counters for the
> number of stage-2 / two-dimension paging page (TDP) tables.
>
> Code looks good, though it needs a rebased on kvm/queue.

Will rebase and modify the commit message accordingly, thanks!
