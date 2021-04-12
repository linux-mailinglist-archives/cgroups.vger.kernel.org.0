Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881C235C820
	for <lists+cgroups@lfdr.de>; Mon, 12 Apr 2021 16:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242083AbhDLOEG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Apr 2021 10:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242081AbhDLOEG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Apr 2021 10:04:06 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E621FC06174A
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 07:03:47 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id n138so21629469lfa.3
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 07:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wOKg8etxKl6YU4OPpm5oIEWuzY94vpojhhr8xmBl7+Y=;
        b=V5ll4uIP+zT1lm6DYY43H7k9LdxpTRg3xHNiausluEsx6vKF5oCOVESII5zB8hXmBz
         lLlw2WxfZ9cjqayt0wf2jk2rpQCrq3cwjESyVEGFSCMvzjaaVp5iQC1cMaoWLjpdQPqd
         9kiXTv/S8Hg5m7H2mSTrboWfW7xnyUrxF/ZXLfHYiJaqu3P14g/OBlcusSBEO6RUHvD4
         m6wYFi3jTQFyq2KEXVZXvd4di+U/43o2PnS/bVsqO/1yEJmBp/rAHNiuNZ1u3qMWti/Q
         HAPW3k72DPHLl0Gvf+k8ahbsXU95uf1COrhoj77lfWCOA8vBsxGUcGoVXKKQDNUV03aA
         XEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wOKg8etxKl6YU4OPpm5oIEWuzY94vpojhhr8xmBl7+Y=;
        b=glxZadSwW5k/F13zUVyMVThzVI78btENl7CC6ceWHJ5U7SAcl03LGzpc0/0mXXHeXH
         gjRsh66KCG4q3Bv961ZGoBq+s0mKrO3X3YQA4WQEPZajQ/UA5Qrsodt1SEezJH/clfS7
         9k196yo5WvTTZ+l6Gnrb1ECCltMJy+Crmb/y0yJTySSGpM2xXmpx2QjzSFeQBLYVbMTU
         qaJjsgFLwM/yqqRbPSoMMCrZDqZBvRRXgkBGvX3/67nklHz+zq8Hmbh6FSBYxScNVFEQ
         5eL7egw5Zj1TrHG2TUhx+khPo1/DXnIlwJTRZGUxej8efiTp9aAs/+mAGvaNXM2W8VlG
         S/RQ==
X-Gm-Message-State: AOAM533Yfa30Z522rUEQNkAMVQZ8y6bJhdZa/KikA6Y6FZ0xmCqSLFEb
        zJTpmEwumo5ODTSp4xZeQbufcP5MCbzgaDz9rHwrsQ==
X-Google-Smtp-Source: ABdhPJzjxbOCYQHIKvDCo79/k+jyp289C97iVhgm1Ap38B4NQDVl+WIplqpqt7aDu1eWkrGHCT7omEnFTkjsMqBgmZ0=
X-Received: by 2002:a19:f710:: with SMTP id z16mr19494926lfe.549.1618236226169;
 Mon, 12 Apr 2021 07:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617642417.git.tim.c.chen@linux.intel.com>
 <YGwlGrHtDJPQF7UG@dhcp22.suse.cz> <c615a610-eb4b-7e1e-16d1-4bc12938b08a@linux.intel.com>
 <YG7ugXZZ9BcXyGGk@dhcp22.suse.cz>
In-Reply-To: <YG7ugXZZ9BcXyGGk@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 12 Apr 2021 07:03:34 -0700
Message-ID: <CALvZod7y08qE0Zw0TB+1y28w19cRyccNXRC=Cy6bazW1HAXLZQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/11] Manage the top tier memory in a tiered memory
To:     Michal Hocko <mhocko@suse.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 8, 2021 at 4:52 AM Michal Hocko <mhocko@suse.com> wrote:
>
[...]
>
> What I am trying to say (and I have brought that up when demotion has been
> discussed at LSFMM) is that the implementation shouldn't be PMEM aware.
> The specific technology shouldn't be imprinted into the interface.
> Fundamentally you are trying to balance memory among NUMA nodes as we do
> not have other abstraction to use. So rather than talking about top,
> secondary, nth tier we have different NUMA nodes with different
> characteristics and you want to express your "priorities" for them.
>

I am also inclined towards NUMA based approach. It makes the solution
more general and even existing systems with multiple numa nodes and
DRAM can take advantage of this approach (if it makes sense).
