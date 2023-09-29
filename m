Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035AD7B3660
	for <lists+cgroups@lfdr.de>; Fri, 29 Sep 2023 17:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjI2PIf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Sep 2023 11:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjI2PIe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Sep 2023 11:08:34 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096DC1B3
        for <cgroups@vger.kernel.org>; Fri, 29 Sep 2023 08:08:32 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-7740c8509c8so891483985a.3
        for <cgroups@vger.kernel.org>; Fri, 29 Sep 2023 08:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1696000111; x=1696604911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eIoMc56bIfBZy6/PdEQktEjOwAzqVOREk+ePKY8LOlo=;
        b=WaJN+sV5qzEK10CrLxzNdJpS2PkqLQfHjpAUbAmNRbBP1rRl3tpoNcI+8KWsyWXgoT
         IBJtyI7AP46HIBLMaGvgNQl43CmAjBGz1lPlYjXcuh4w6K+sJgRRryjxwyQCLDb9a/rZ
         aja7LzFm9LyQ16WMFYa3Y2mvSil9ej1ioS0Owg9/kAX04FMow8UezH/oyAPR+KUyXSyB
         ec6vEx6w317xztWJI5zyVngjzDPkoMbBrZV7UE6yfhdtjZbjZR1nDOBbdPn4cGV4Wxla
         IC3nfFN23j4B6OWTB8ofwpHqGobugE6oV/Jxl6ePFYFBPLyPjMv7gULJ0jvHOMB3Dwnf
         PO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696000111; x=1696604911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIoMc56bIfBZy6/PdEQktEjOwAzqVOREk+ePKY8LOlo=;
        b=QGyPtv5LdH8/q4mPKYnpeZ3qgWycrMl1wRDsJTDiO1P1CqUObzLEiDVpEt68Qb6CHX
         uLs84/rYgkL7gPFNLJNy3/cNRjyhyI8uXsxjnRZKTjeK67hxKIK1CY91NfcCZdcmuF1o
         QKVis1BkFYbYgAoOSb+U6y0xCTT6xbZJz/MFbEFPt8Zq71VwGgIx5AChIsu76EyZ6j11
         J356+47RymaP7yo5bVOd785WW04Dn/RqJLb6+Fqnn6IXFe9SQfj0Park+ZkAAcRv0tYg
         TAMS1gHGzTq3SNY5yxHN0/Co0QoQj57yrY2tb45Bwj7sTIIsaKWO3D60V5rBhdCZmhLR
         jPCw==
X-Gm-Message-State: AOJu0YyLushV4kOHhXdcP/L833NgzKcRmM/xgudlBOk+zZ3ws+YzoFtA
        v0AB5SCBrFlWDZQqtVq4uPEC2Q==
X-Google-Smtp-Source: AGHT+IHV/YhrWHzDQ207LDHTmLp/zJOODiEdUhE2mMsIH7bmfSsTIGwBXN4fFashJ84I4V1XDq3Rdg==
X-Received: by 2002:a05:620a:bc1:b0:76d:90c9:595b with SMTP id s1-20020a05620a0bc100b0076d90c9595bmr4744478qki.24.1696000111010;
        Fri, 29 Sep 2023 08:08:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:a683])
        by smtp.gmail.com with ESMTPSA id q21-20020ae9e415000000b00767177a5bebsm6959059qkc.56.2023.09.29.08.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 08:08:30 -0700 (PDT)
Date:   Fri, 29 Sep 2023 11:08:29 -0400
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
Message-ID: <20230929150829.GA16353@cmpxchg.org>
References: <20230928005723.1709119-1-nphamcs@gmail.com>
 <20230928005723.1709119-2-nphamcs@gmail.com>
 <CAJD7tkanr99d_Y=LefQTFsykyiO5oZpPUC=suD3P-L5eS=0SXA@mail.gmail.com>
 <CAKEwX=M=8KYqvBTz9z1csrsFUpGf2tgWj-oyu96dSpRjn3ZnUQ@mail.gmail.com>
 <CAKEwX=Npb4mwZ2ibJkmD5GyqXazr7PH8UGLu+YSDY8acf152Eg@mail.gmail.com>
 <CAJD7tkaeDBTHC3UM91O56yrp8oCU-UBO6i_5HJMjVBDQAw0ipQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkaeDBTHC3UM91O56yrp8oCU-UBO6i_5HJMjVBDQAw0ipQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 28, 2023 at 06:18:19PM -0700, Yosry Ahmed wrote:
> My concern is the scenario where the memory controller is mounted in
> cgroup v1, and cgroup v2 is mounted with memory_hugetlb_accounting.
> 
> In this case it seems like the current code will only check whether
> memory_hugetlb_accounting was set on cgroup v2 or not, disregarding
> the fact that cgroup v1 did not enable hugetlb accounting.
> 
> I obviously prefer that any features are also added to cgroup v1,
> because we still didn't make it to cgroup v2, especially when the
> infrastructure is shared. On the other hand, I am pretty sure the
> maintainers will not like what I am saying :)

I have a weak preference.

It's definitely a little weird that the v1 controller's behavior
changes based on the v2 mount flag. And that if you want it as an
otherwise exclusive v1 user, you'd have to mount a dummy v2.

But I also don't see a scenario where it would hurt, or where there
would be an unresolvable conflict between v1 and v2 in expressing
desired behavior, since the memory controller is exclusive to one.

While we could eliminate this quirk with a simple
!cgroup_subsys_on_dfl(memory_cgrp_subsys) inside the charge function,
it would seem almost punitive to add extra code just to take something
away that isn't really a problem and could be useful to some people.

If Tejun doesn't object, I'd say let's just keep implied v1 behavior.
