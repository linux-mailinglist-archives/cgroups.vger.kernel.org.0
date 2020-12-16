Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004572DC781
	for <lists+cgroups@lfdr.de>; Wed, 16 Dec 2020 21:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgLPUDh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Dec 2020 15:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbgLPUDh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Dec 2020 15:03:37 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97967C061794
        for <cgroups@vger.kernel.org>; Wed, 16 Dec 2020 12:02:56 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id u18so51501993lfd.9
        for <cgroups@vger.kernel.org>; Wed, 16 Dec 2020 12:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+T1M0djTrVYMWMJ7UcJwx0tkQ79zd8SuUMW71DQVsS0=;
        b=q+DyxhaxnPb/nH8qJzxHDRUDbs6pwrBVZw6PzpLeFo3wtldBNCEn4e64bSK0nhLF5X
         QvBT/wceHb8MK7Fm6YtVe7alN3zuwE0T3jaFFX9VRfhZKifVX3CDGzSjGXXVAJJpXSLk
         BYqUA0lzyEkYCfA/0WuODCJH5mOGW4V8P0cbCJlM2NdsPkwY5ZpUVEVBumz8vq3xmZQm
         PQyEwimqMI9kswHp6aDK7UXpsBu5joatambFWqpECUHqscsjIaEKpGZiYFMen0Kf3XVW
         Q8YKf8+FVjWvyXB/rJ0RfDFFi19z72HtGBVwOT5yFzE5kLAsEpDIgG2ZzYj5KaG1wkfA
         IjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+T1M0djTrVYMWMJ7UcJwx0tkQ79zd8SuUMW71DQVsS0=;
        b=PWK6WKcvdXB3JBELW97b3xJA+Uh3QP/wqV46xq6Y0UGTnD2HUtC93CemBG+SOZYbNB
         7KVlIIl9KmGqdlXRWDdiJsAPIA2TEE4ucV399zUPqmyT6ks45AP+tqJk9PRxIBwS9Ho1
         d/7i+PyJjfo9OzTmuakh6luQpJh5RwCLqsen437/GEe1zErzS/tR6/TUzR0d6KZmjtkg
         jQkd5MMFMHixO3n2OubxMPfMyIGBRJmx8Mio531F9kSWjnkEHze5/bzS0lKnu8YXTCAk
         z6tceLBmn46IZhKSaW582UOTDTQtYPD3I3KdfBoUHYt9LsvgOCkrbW7zWsyoNVtVCZo/
         ph3g==
X-Gm-Message-State: AOAM531mZygZIk3SB1N+/uZBZyx8V0a1y3SDy1GQicMz44oh4sjS7dzN
        bUrsWMQAa5K8FhpNqhvvSsItE30Z/tgf9T8DOCoqhA==
X-Google-Smtp-Source: ABdhPJwIsp1KYDGfDYl/qLLsUR1dFSzUtaS6n+MO1KkOUvZ4UrkSMNj8fmCA+zqoeFpXCBoAmALBMZNzzSZUYt5+MhQ=
X-Received: by 2002:a19:4813:: with SMTP id v19mr14625283lfa.655.1608148974571;
 Wed, 16 Dec 2020 12:02:54 -0800 (PST)
MIME-Version: 1.0
References: <20201209205413.3391139-1-vipinsh@google.com> <X9E6eZaIFDhzrqWO@mtj.duckdns.org>
 <4f7b9c3f-200e-6127-1d94-91dd9c917921@de.ibm.com> <5f8d4cba-d3f-61c2-f97-fdb338fec9b8@google.com>
 <X9onUwvKovJeHpKR@mtj.duckdns.org>
In-Reply-To: <X9onUwvKovJeHpKR@mtj.duckdns.org>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Wed, 16 Dec 2020 12:02:37 -0800
Message-ID: <CAHVum0dS+QxWFSK+evxQtZDHkZZx9pr0m_jEDHc9ovd5jQcfaA@mail.gmail.com>
Subject: Re: [Patch v3 0/2] cgroup: KVM: New Encryption IDs cgroup controller
To:     Tejun Heo <tj@kernel.org>
Cc:     David Rientjes <rientjes@google.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh <brijesh.singh@amd.com>, Jon <jon.grimm@amd.com>,
        Eric <eric.vantassell@amd.com>, pbonzini@redhat.com,
        Sean Christopherson <seanjc@google.com>, lizefan@huawei.com,
        hannes@cmpxchg.org, Janosch Frank <frankja@linux.ibm.com>,
        corbet@lwn.net, joro@8bytes.org, vkuznets@redhat.com,
        wanpengli@tencent.com, Jim Mattson <jmattson@google.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Matt Gingell <gingell@google.com>,
        Dionna Glaze <dionnaglaze@google.com>, kvm@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Dec 9, 2020 at 12:59 PM Tejun Heo <tj@kernel.org> wrote:
> * I don't have an overall objection. In terms of behavior, the only thing
>   which stood out was input rejection depending on the current usage. The
>   preferred way of handling that is rejecting future allocations rather than
>   failing configuration as that makes it impossible e.g. to lower limit and
>   drain existing usages from outside the container.

Thanks. In next version of the patch I will remove rejection of max value
based on current usage.

On Wed, Dec 16, 2020 at 7:27 AM Tejun Heo <tj@kernel.org> wrote:
> On Thu, Dec 10, 2020 at 03:44:35PM -0800, David Rientjes wrote:
> > Concern with a single misc controller would be that any subsystem that
> > wants to use it has to exactly fit this support: current, max, stat,
> > nothing more.  The moment a controller needs some additional support, and
> > its controller is already implemented in previous kernel versionv as a
> > part of "misc," we face a problem.
>
> Yeah, that's a valid concern, but given the history, there doesn't seem to
> be much need beyond that for these use cases and the limited need seems
> inherent to the way the resources are defined and consumed. So yeah, it can
> either way.

I think a misc controller should be able support other "Resource Distribution
Models" mentioned in the cgroup v2 documentation besides limits. There might be
use cases in future which want to use weight, protection or allocation models.
If that happens it will be more difficult to support these different resources.
This will also mean the same hierarchy might get charged differently by the
same controller.

I like the idea of having a separate controller to keep the code simple and
easier for maintenance.

If you decide to have a separate misc controller please let me know what will
be the overall expectations and I can change my patch to reflect that,
otherwise I can send out a new patch with just removal of max input rejection.

My understanding with a "misc" controller is it will be something like
- cgroup v2
  cgroup/misc.encryption_ids.{sev, tdx, seid}.{stat, max, current}

- cgroup v1
  cgroup/misc/misc.encryption_ids.{sev, tdx, seid}.{stat, max, current}

Thanks
Vipin
