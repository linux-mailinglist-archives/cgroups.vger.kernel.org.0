Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18ED732F688
	for <lists+cgroups@lfdr.de>; Sat,  6 Mar 2021 00:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhCEXVY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Mar 2021 18:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhCEXVG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 Mar 2021 18:21:06 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E6FC061760
        for <cgroups@vger.kernel.org>; Fri,  5 Mar 2021 15:21:06 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id z22so839564oop.0
        for <cgroups@vger.kernel.org>; Fri, 05 Mar 2021 15:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=r0cTPvXdPd9aXoIuTSiB+0BptUG2HNyX6VD0hnKItjg=;
        b=IbW9BqWseyXJunfwk6vypcVhPM+2f00lqu+yPIf3i41yBB3U5kG6VJwHyyyzipvUcp
         Jdclyo7xbJuBiOMrpb+Xx8T4Y8lg73KtuHhrAZcbWI8SKiUkS61MweoA31Psyv9zholn
         qSagH5RJmp3v8GEPtNkbIfOC2ukMr68AEhnOeuR+z9ftl9I/2ghIBnJxLPNhlEAh7+vk
         JSKIdRV1Pmp+08NC0NUfZ/EnxiirZfHnuEsdaiUqDTT6qqJPzWnBtUuDCT/s4UZn/TeD
         47KfBlUwFBGH+ZLQ47DM7ivUbE88YHaKoQXHKYxF5Kodqils0+P4mK4R1D5nnRjkLRRJ
         uqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=r0cTPvXdPd9aXoIuTSiB+0BptUG2HNyX6VD0hnKItjg=;
        b=s8nCpbbca9689bR1aqt0wyt1elDIonu+DuSzCHtAn0NAJG79/H9pHDs3ExQOIsOj20
         WheEpifrm4SOTU8Hobxmlv1T8IWm1JmErUS+732N3zngQKW8zJy6qTBb1w0tUM2aeTCW
         qKzjEx1IhMoidgslUHDNM6yYt0KrxhoUUpiY5ZdYfVci/2rW8fgX9/71rftRg6y/wy39
         NzaksHhA0ihReYW5NuXrLxzyciQrWxHSumtMv6qwA4KdNR0FsH+ni5LnjFqmi7Ohb7Fk
         X9xdw9ElsUMmhM0R588yoaHEwi0zQRAGjPnItVf75nkCEN4aEfMTgWx9cw1bVRgbHEq1
         DecQ==
X-Gm-Message-State: AOAM532AKGTfNnOQimwsZ2Kr6e+i9f842ZrES75B0ZqTEnfQ2dcZTQO0
        naZBtDLjH4yF91WZ4FXegTWm/A==
X-Google-Smtp-Source: ABdhPJyMn01Wil1haFmcAK+6+8fcnT0623GSoZtJmaRyLgGlXr9kwy3JOLmI4ArIAhR8ycFa8AgYWw==
X-Received: by 2002:a4a:8ed2:: with SMTP id c18mr9855324ool.66.1614986465301;
        Fri, 05 Mar 2021 15:21:05 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f193sm824054oig.8.2021.03.05.15.21.04
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 05 Mar 2021 15:21:04 -0800 (PST)
Date:   Fri, 5 Mar 2021 15:20:48 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Shakeel Butt <shakeelb@google.com>
cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] memcg: charge before adding to swapcache on swapin
In-Reply-To: <CALvZod5oPTj8r6vKXVGgtKoXVaRWbRX9S2mLVtSnyysqtzr_ng@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2103051519460.1856@eggly.anvils>
References: <20210305212639.775498-1-shakeelb@google.com> <CALvZod5oPTj8r6vKXVGgtKoXVaRWbRX9S2mLVtSnyysqtzr_ng@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 5 Mar 2021, Shakeel Butt wrote:
> On Fri, Mar 5, 2021 at 1:26 PM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > Currently the kernel adds the page, allocated for swapin, to the
> > swapcache before charging the page. This is fine but now we want a
> > per-memcg swapcache stat which is essential for folks who wants to
> > transparently migrate from cgroup v1's memsw to cgroup v2's memory and
> > swap counters. In addition charging a page before exposing it to other
> > parts of the kernel is a step in the right direction.
> >
> > To correctly maintain the per-memcg swapcache stat, this patch has
> > adopted to charge the page before adding it to swapcache. One
> > challenge in this option is the failure case of add_to_swap_cache() on
> > which we need to undo the mem_cgroup_charge(). Specifically undoing
> > mem_cgroup_uncharge_swap() is not simple.
> >
> > To resolve the issue, this patch introduces transaction like interface
> > to charge a page for swapin. The function mem_cgroup_charge_swapin_page()
> > initiates the charging of the page and mem_cgroup_finish_swapin_page()
> > completes the charging process. So, the kernel starts the charging
> > process of the page for swapin with mem_cgroup_charge_swapin_page(),
> > adds the page to the swapcache and on success completes the charging
> > process with mem_cgroup_finish_swapin_page().
> 
> And of course I forgot to update the commit message.
> 
> Andrew, please replace the third paragraph with the following para:
> 
> To resolve the issue, this patch decouples the charging for swapin pages from
> mem_cgroup_charge(). Two new functions are introduced,
> mem_cgroup_swapin_charge_page() for just charging the swapin page and
> mem_cgroup_swapin_uncharge_swap() for uncharging the swap slot once the
> page has been successfully added to the swapcache.

Lgtm
Hugh
