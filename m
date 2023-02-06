Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1B768CA80
	for <lists+cgroups@lfdr.de>; Tue,  7 Feb 2023 00:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBFXZi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 18:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBFXZh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 18:25:37 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB33724484;
        Mon,  6 Feb 2023 15:25:36 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id t17so9586107pfj.0;
        Mon, 06 Feb 2023 15:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNyTUpgbSKzrwdLKzf32iJthR0x3bB6/K+FM9veAVxs=;
        b=FM7dnXdDgTi6Jr47ShxElcXjWHf8/UeXvO3sG8rOKcpJeNHNS3yZ2XMQ09gojvSZUS
         jMC4v/s3fIbXEZcN/hWXAinwIoADwF54gqpJzyAmLG/jbFAHMl9869uZNSn/EQ/c3cU/
         sSbheM93Ql1q1GVQvGm5T8KF3HjrEq/J8nYdjQhM5vzRpmxJChWw6ik0kM0HJ9yPYm5c
         kyLv7nW5pIeY74Pf81p5FQy9U5vEoHktgkH91nRhqZSmdrkaH8/x6bPrRvCzwgjpIw1M
         Wri0s5FTjjOgIiWOKdnX3XaJkImD65FY8TNru+AdsHrWWqYjwDJTotnvtTfaZDP4NWUu
         2NlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNyTUpgbSKzrwdLKzf32iJthR0x3bB6/K+FM9veAVxs=;
        b=BmQzU0IXPwI34VypDHTsemhKXSIfw6oh1PcvFr3O/6dKA/HJ6BlGeew675R+OwspqR
         Gmy/OQhrva2Y57lGFhdu8T5T4a5yHRPIk/1Trcn7DPqEjA3mIXvLmLAvVwcnDzYsy5uI
         Yv+FRCFg1ffMHzAZzKa0y5266R7NVA9a0aujwwKnC6b34aPPk4aFw7A/YCLjTPv2A+wu
         C+B/bnso5lP+Yw2PFfrT/NbxMA/hUDPjldnHxtMLURsHMI8v1xA87kfYnezeIC7NiXjV
         0ly4eQQAM/AfqfNsJrIua21ueO/iPGdgxPEBxF6rIBvVlWOsSuyuMf8qQ/WdGSJwIDP8
         +rEA==
X-Gm-Message-State: AO0yUKV/mRerLYKYkpbRq5ZfgqvGk3TxwPt2n6E1zNbVFQOf84kGfPW+
        77e40Z6Th6zYyN7InisNZyDmw93xkhM=
X-Google-Smtp-Source: AK7set+OLNZIETla8KPC9TCHUzFLdHiTMYTyvd0ctdu9+qHe6fVJvB2/KVw0/D/ECLFVYvUjoRV7kw==
X-Received: by 2002:a62:1c88:0:b0:593:893f:81d7 with SMTP id c130-20020a621c88000000b00593893f81d7mr800938pfc.16.1675725936087;
        Mon, 06 Feb 2023 15:25:36 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id b205-20020a621bd6000000b0058bc37f3d1csm7694842pfb.44.2023.02.06.15.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 15:25:35 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 6 Feb 2023 13:25:33 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jgg@nvidia.com, jhubbard@nvidia.com, tjmercier@google.com,
        hannes@cmpxchg.org, surenb@google.com, mkoutny@suse.com,
        daniel@ffwll.ch, "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Message-ID: <Y+GMbWWP/YhtJQqe@slm.duckdns.org>
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
 <c7b5e502d1a3b9b8f6e96cbf9ca553b143c327e0.1675669136.git-series.apopple@nvidia.com>
 <Y+Fttp1ozejoSQzl@slm.duckdns.org>
 <CAJD7tkb_Cr7rTTpKc1VBpS8h=n3Hu+nGiV8dkLH-NdC1bSG9mg@mail.gmail.com>
 <Y+GA6Y7SVhAW5Xm9@slm.duckdns.org>
 <CAJD7tka6SC1ho-dffV0bK_acoZd-5DQzBOy0xg3TkOFG1zAPMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tka6SC1ho-dffV0bK_acoZd-5DQzBOy0xg3TkOFG1zAPMg@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Feb 06, 2023 at 02:39:17PM -0800, Yosry Ahmed wrote:
> On Mon, Feb 6, 2023 at 2:36 PM Tejun Heo <tj@kernel.org> wrote:
> >
> > On Mon, Feb 06, 2023 at 02:32:10PM -0800, Yosry Ahmed wrote:
> > > I guess it boils down to which we want:
> > > (a) Limit the amount of memory processes in a cgroup can be pinned/locked.
> > > (b) Limit the amount of memory charged to a cgroup that can be pinned/locked.
> > >
> > > The proposal is doing (a), I suppose if this was part of memcg it
> > > would be (b), right?
> > >
> > > I am not saying it should be one or the other, I am just making sure
> > > my understanding is clear.
> >
> > I don't quite understand what the distinction would mean in practice. It's
> > just odd to put locked memory in a separate controller from interface POV.
> 
> Assume we have 2 cgroups, A and B. A process in cgroup A creates a
> tmpfs file and writes to it, so the memory is now charged to cgroup A.
> Now imagine a process in cgroup B tries to lock this memory.
> - With (a) the amount of locked memory will count toward's cgroup A's
> limit, because cgroup A is charged for the memory.
> - With (b) the amount of locked memory will count toward's cgroup B's
> limit, because a process in cgroup B is locking the memory.
> 
> I agree that it is confusing from an interface POV.

Oh yeah, that's confusing. I'd go with (a) for consistency with the rest of
memcg - locked memory should fit inside e.g. memory.max. The problem with
shared memory accounting exists for non-locked memory as well and prolly
best to handle the same way rather than handling differently.

Thanks.

-- 
tejun
