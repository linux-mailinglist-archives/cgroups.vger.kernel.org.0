Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31FA55C2B5
	for <lists+cgroups@lfdr.de>; Tue, 28 Jun 2022 14:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238888AbiF0QH7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Jun 2022 12:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239000AbiF0QHh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Jun 2022 12:07:37 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C5314D2A
        for <cgroups@vger.kernel.org>; Mon, 27 Jun 2022 09:07:36 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id w19-20020a17090a8a1300b001ec79064d8dso12945605pjn.2
        for <cgroups@vger.kernel.org>; Mon, 27 Jun 2022 09:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l0pibN8bjG0PnvfGdr94sagjrAjKQlwTKx4ke7hg5TE=;
        b=KXpJaULYCMOBvM0KZ+Y0QmYKcs5GsOT3UDoT12OxOmZTuofXiRwwGm/WgJTM1heXoI
         t1dv3k342OQnZ9iooXjd608cniWLl0qlDw2/EFrZO3JITiMUniSnoS9vRpsVYcQj8vN/
         I7nko6H+yxfXlWmj6BpVmIQCvWqpF55RTmiG3dExwV8krl6JWA8dxuz7o3cuKUtlCKLL
         AUH1GrHaKcLi0AxNkq1Q0RlPIztx9SDq4ccjZXK7Aa2jkpBZXbRVUSJ+/fIBfJxIB9bo
         wqHrvEDbll+Qw87/iH2rzRcMOLCQ34VpKyfcZXoB0fUgM3GYU80A2xB80LHN6E80KQa1
         5riQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l0pibN8bjG0PnvfGdr94sagjrAjKQlwTKx4ke7hg5TE=;
        b=TgoTEC0xZ+/b0YkvQKmUy2WJ1xdFn7Vquw6FJ+jUmRE6IZ/ewHELDojqyjqpfx4++g
         ngibKOj+busIIftkKrICvdIpawBdPPZ0gw5ZgX7GSuhU0h57qq4+nMZanrrsWe5AtL9f
         CW9Rr1vWtoopXXB42uMBHRexkEEjcLMOFfE+BEhvHTqNHSxMjV3ejPyXk2WOrJtT5gTC
         La4WLFVPE3Q66t/BsBkmg5swoGxkagCKHhNeD1kPzZl/biNlIPnKxewsXdhQ9M5s1ipQ
         6bduYSetpSFjV2O2dK56c3RdUvj1gEfv+0FWV2Mf4o6K86Zqz/yjHlT+UjrZsR7JE4CB
         Me/Q==
X-Gm-Message-State: AJIora8tdUTc5YtZqRR7opHb0Ix3b5ELCPAfCQdyicm0GCBCSy8gaZcj
        IzH/rdHP0P7BXFs6bypHRfQc/Q==
X-Google-Smtp-Source: AGRyM1uyfo5AfaNgmfF7G/qEE7dWnvzScXgctBWfKk3cum7fj6D7nx+TeglAS/qAbSPCsy6MAsmoPA==
X-Received: by 2002:a17:902:9f97:b0:16a:9b9:fb63 with SMTP id g23-20020a1709029f9700b0016a09b9fb63mr15547216plq.7.1656346056250;
        Mon, 27 Jun 2022 09:07:36 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id g17-20020aa78191000000b005254bd90f22sm7528584pfi.150.2022.06.27.09.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 09:07:35 -0700 (PDT)
Date:   Mon, 27 Jun 2022 16:07:32 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
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
        Oliver Upton <oupton@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v5 1/4] mm: add NR_SECONDARY_PAGETABLE to count secondary
 page table uses.
Message-ID: <YrnVxM/5KjVhkOnn@google.com>
References: <20220606222058.86688-1-yosryahmed@google.com>
 <20220606222058.86688-2-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606222058.86688-2-yosryahmed@google.com>
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

On Mon, Jun 06, 2022, Yosry Ahmed wrote:
> Add NR_SECONDARY_PAGETABLE stat to count secondary page table uses, e.g.
> KVM mmu. This provides more insights on the kernel memory used
> by a workload.

Please provide more justification for NR_SECONDARY_PAGETABLE in the changelog.
Specially, answer the questions that were asked in the previous version:

  1. Why not piggyback NR_PAGETABLE?
  2. Why a "generic" NR_SECONDARY_PAGETABLE instead of NR_VIRT_PAGETABLE?

It doesn't have to be super long, but provide enough info so that reviewers and
future readers don't need to go spelunking to understand the motivation for the
new counter type.

And it's probably worth an explicit Link to Marc's question that prompted the long
discussion in the previous version, that way if someone does want the gory details
they have a link readily available.

Link: https://lore.kernel.org/all/87ilqoi77b.wl-maz@kernel.org
