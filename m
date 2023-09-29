Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060747B390D
	for <lists+cgroups@lfdr.de>; Fri, 29 Sep 2023 19:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjI2Rm0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Sep 2023 13:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbjI2RmZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Sep 2023 13:42:25 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED6F1B0
        for <cgroups@vger.kernel.org>; Fri, 29 Sep 2023 10:42:22 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6c4e7951dddso5535102a34.1
        for <cgroups@vger.kernel.org>; Fri, 29 Sep 2023 10:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1696009342; x=1696614142; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=68RQMIL3JGNleZxOiCoTPvaR9s9H/zQLkKem3fLlu88=;
        b=L023O7TPbKyGZH7XkKEr0b6TA1gyPuqsGVHgy2y56RmAXGWTmJ6flfTK/vR9SwIR3U
         maU3h4aby7r/wXqXrApkgAJo2tb/OkLCEz7Tg3v4nrSGw00AgLD0jMqT3u9IPY/+PYfp
         MOXCqYIM7rzKVoYT5PWdEl9FnPRj/FLfYcgHOCtbh6hyWzD0fGrBCTDhtCRJRsdS4wD3
         ogKhzPRIvXfVSI6ejPtACbPRIwuk9RrsEqh4bUS45OmRC5AttG27kR57BxaN9G3VLKmd
         nIjh1ywEXoDZeTTH9vKhX81ZPboaKtqpYJJrKFjwkSNeeo9pkM7XKdUHYBV4yx0G/m27
         0P6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696009342; x=1696614142;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68RQMIL3JGNleZxOiCoTPvaR9s9H/zQLkKem3fLlu88=;
        b=R9lH0kRizyA7ioaUulqj3zvxHawhaEUxIo5N6El3Sbx3OOV4zqhm1l+WKLMdszumiY
         mjRRjyhnjZtPvDf1gNz2LteOnDXmh3/bUJ/UyPkD/nJVNFgFKKEE9XIwAohRnAwZWRKF
         6YVEoueMe7PfhlKF/gHVV9g9UpH1dn/b0tPlAhBWF6IFccX3qkEXp/R7tvztypUurK1L
         teh74OM6S0fiYb0vIo72vt7412ODH8eEcDqDoXgbvEWdrRpv24g/tPDk70jkH10C4Axz
         4mhif0Kh1gXK+hr1O15Oci4kppK4qfyQ54glk9fvoutN5OHk/8BEHgNUbFHb2FNz2MSp
         06EA==
X-Gm-Message-State: AOJu0Yx29Sk7dagCPvcquvaAUb+mWA7k/EmzEMro/BHgl1Kc/kNYupfv
        VlNN80exBom8l7NcjwhSNSJAUg==
X-Google-Smtp-Source: AGHT+IGyNmo17+iWn2ufBJg0OO9ZbA7uNNp+MMG6j43QotDJLGPGN7FO5yVqQx6ARbvw+dVe+LWDYw==
X-Received: by 2002:a05:6830:22d4:b0:6bd:603:797f with SMTP id q20-20020a05683022d400b006bd0603797fmr5130719otc.37.1696009342226;
        Fri, 29 Sep 2023 10:42:22 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:a683])
        by smtp.gmail.com with ESMTPSA id oj2-20020a056214440200b0065af4977ea3sm5680149qvb.24.2023.09.29.10.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:42:21 -0700 (PDT)
Date:   Fri, 29 Sep 2023 13:42:21 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        riel@surriel.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, muchun.song@linux.dev, tj@kernel.org,
        lizefan.x@bytedance.com, shuah@kernel.org, mike.kravetz@oracle.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hugetlb: memcg: account hugetlb-backed memory in
 memory controller
Message-ID: <20230929174221.GA19137@cmpxchg.org>
References: <20230928005723.1709119-1-nphamcs@gmail.com>
 <20230928005723.1709119-2-nphamcs@gmail.com>
 <CAJD7tkanr99d_Y=LefQTFsykyiO5oZpPUC=suD3P-L5eS=0SXA@mail.gmail.com>
 <CAKEwX=M=8KYqvBTz9z1csrsFUpGf2tgWj-oyu96dSpRjn3ZnUQ@mail.gmail.com>
 <CAKEwX=Npb4mwZ2ibJkmD5GyqXazr7PH8UGLu+YSDY8acf152Eg@mail.gmail.com>
 <CAJD7tkaeDBTHC3UM91O56yrp8oCU-UBO6i_5HJMjVBDQAw0ipQ@mail.gmail.com>
 <20230929150829.GA16353@cmpxchg.org>
 <CAJD7tkZ1NiMMvQhxGSGzsPqYfBpwzP6svPe17s2FTDoHY6jYWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZ1NiMMvQhxGSGzsPqYfBpwzP6svPe17s2FTDoHY6jYWQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 29, 2023 at 08:11:54AM -0700, Yosry Ahmed wrote:
> On Fri, Sep 29, 2023 at 8:08 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Thu, Sep 28, 2023 at 06:18:19PM -0700, Yosry Ahmed wrote:
> > > My concern is the scenario where the memory controller is mounted in
> > > cgroup v1, and cgroup v2 is mounted with memory_hugetlb_accounting.
> > >
> > > In this case it seems like the current code will only check whether
> > > memory_hugetlb_accounting was set on cgroup v2 or not, disregarding
> > > the fact that cgroup v1 did not enable hugetlb accounting.
> > >
> > > I obviously prefer that any features are also added to cgroup v1,
> > > because we still didn't make it to cgroup v2, especially when the
> > > infrastructure is shared. On the other hand, I am pretty sure the
> > > maintainers will not like what I am saying :)
> >
> > I have a weak preference.
> >
> > It's definitely a little weird that the v1 controller's behavior
> > changes based on the v2 mount flag. And that if you want it as an
> > otherwise exclusive v1 user, you'd have to mount a dummy v2.
> >
> > But I also don't see a scenario where it would hurt, or where there
> > would be an unresolvable conflict between v1 and v2 in expressing
> > desired behavior, since the memory controller is exclusive to one.
> >
> > While we could eliminate this quirk with a simple
> > !cgroup_subsys_on_dfl(memory_cgrp_subsys) inside the charge function,
> > it would seem almost punitive to add extra code just to take something
> > away that isn't really a problem and could be useful to some people.
> >
> > If Tejun doesn't object, I'd say let's just keep implied v1 behavior.
> 
> I agree that adding extra code to take a feature away from v1 is
> probably too much, but I also think relying on a v2 mount option is
> weird. Would it be too much to just have a v1-specific flag as well
> and use cgroup_subsys_on_dfl(memory_cgrp_subsys) to decide which flag
> to read?

Yeah, let's not preemptively add explicit new features to cgroup1.

Since we agree the incidental support is weird, let's filter hugetlb
charging on cgroup_subsys_on_dfl(memory_cgrp_subsys) after all. If
somebody wants this for v1 - and it doesn't sound like Google is even
in that category according to Frank - they should send a separate
patch and we can go through all the reasons why switching to v2 is not
an option for them.
