Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3087244E2E4
	for <lists+cgroups@lfdr.de>; Fri, 12 Nov 2021 09:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbhKLIPz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Nov 2021 03:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhKLIPy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Nov 2021 03:15:54 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF18C061767
        for <cgroups@vger.kernel.org>; Fri, 12 Nov 2021 00:13:04 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id m9so10247053iop.0
        for <cgroups@vger.kernel.org>; Fri, 12 Nov 2021 00:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e5kPBmCOcmFspVqwDgZJWVPQZeOyM/KG0MhndtiqdEc=;
        b=U2FZQm5zQOY88IbxrwbNkiPdB3B/wQ4eXF7J3PAIDxN9GQZbCs8E1k0ZwSlv1ScR1j
         fbH1eYVxb8RqPksQXmoIdAhf0TADb6wnzQbfxUkclgDCuwbx93P6i10BmRulValid+Aq
         L/mbamz5BrE87AlBoENcHa/+FU3neQPWrwjd5Ta7kkLSTkoOGZvpVRnYJrUrysuzUWA1
         Zr1kZDqhWI/U1TQVRTwv/5Nexd8+4+6Bf7s0Xyv7VFQoia//aN7mxMAoQ64UJ5eA2A78
         xBNVLp6eSz+Hlv9qn6b7uOxai7YvHPpzrEWvIVWekPZ2WSLlI5oeCPMQWI6FyaFFI8Hv
         BkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e5kPBmCOcmFspVqwDgZJWVPQZeOyM/KG0MhndtiqdEc=;
        b=4gcRLT+U6JsTa0Xki8dDRwnC2D+SqecrHVJLVkKD0QtZzoiHQhl/EazEUUrXFrDAgr
         OxxQDqgHftexk5RBILerr1JqNX2jyt0XF6d3wx4iiB6q7W5r5xyj8CGmvKsqSFlw8hHq
         ZuDsBJSPkIY9Y3bnSM60qn7JZHz1ZjR3GFob+YeHXhC0GJTdxfiYKw0D5AsJ3/2mZ06v
         KprJFnM+bpi1rsJWMPDGco9jYCqCOmOnsIOC2+wz0Pjt0BZ8+aOyhWt10QIFO3fKsvzL
         IXQDDEjRLtj6vZubkAKzjLLkcymE6VTwx98Yn2PUEAFMjVcDz/DS+hazHZ81M5qbIdXy
         vxmw==
X-Gm-Message-State: AOAM53202RI6n8GO5Vk1o6OoGAxHPa8WI/pnV2CXxKWxFXXFTGXqDdtA
        GAh1QB6dxkaqiuU7HtQt4b+EAuYDzxQEMZen2GTflw==
X-Google-Smtp-Source: ABdhPJxxu2EwTDfJW3RZ3EEsLoo2kzpp7LljPIydmIgrLb5iGOm5dsWKK84Si92pfv/ljn1w5pwars4Ly5H418qcYXY=
X-Received: by 2002:a05:6602:1d0:: with SMTP id w16mr9038879iot.140.1636704783771;
 Fri, 12 Nov 2021 00:13:03 -0800 (PST)
MIME-Version: 1.0
References: <20211111234203.1824138-1-almasrymina@google.com>
 <20211111234203.1824138-3-almasrymina@google.com> <YY4dHPu/bcVdoJ4R@dhcp22.suse.cz>
In-Reply-To: <YY4dHPu/bcVdoJ4R@dhcp22.suse.cz>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 12 Nov 2021 00:12:52 -0800
Message-ID: <CAHS8izNMTcctY7NLL9+qQN8+WVztJod2TfBHp85NqOCvHsjFwQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mm/oom: handle remote ooms
To:     Michal Hocko <mhocko@suse.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>, riel@surriel.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Nov 11, 2021 at 11:52 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 11-11-21 15:42:01, Mina Almasry wrote:
> > On remote ooms (OOMs due to remote charging), the oom-killer will attempt
> > to find a task to kill in the memcg under oom, if the oom-killer
> > is unable to find one, the oom-killer should simply return ENOMEM to the
> > allocating process.
>
> This really begs for some justification.
>

I'm thinking (and I can add to the commit message in v4) that we have
2 reasonable options when the oom-killer gets invoked and finds
nothing to kill: (1) return ENOMEM, (2) kill the allocating task. I'm
thinking returning ENOMEM allows the application to gracefully handle
the failure to remote charge and continue operation.

For example, in the network service use case that I mentioned in the
RFC proposal, it's beneficial for the network service to get an ENOMEM
and continue to service network requests for other clients running on
the machine, rather than get oom-killed when hitting the remote memcg
limit. But, this is not a hard requirement, the network service could
fork a process that does the remote charging to guard against the
remote charge bringing down the entire process.

> > If we're in pagefault path and we're unable to return ENOMEM to the
> > allocating process, we instead kill the allocating process.
>
> Why do you handle those differently?
>

I'm thinking (possibly incorrectly) it's beneficial to return ENOMEM
to the allocating task rather than killing it. I would love to return
ENOMEM in both these cases, but I can't return ENOMEM in the fault
path. The behavior I see is that the oom-killer gets invoked over and
over again looking to find something to kill and continually failing
to find something to kill and the pagefault never gets handled.

I could, however, kill the allocating task whether it's in the
pagefault path or not; it's not a hard requirement that I return
ENOMEM. If this is what you'd like to see in v4, please let me know,
but I do see some value in allowing some callers to gracefully handle
the ENOMEM.

> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Theodore Ts'o <tytso@mit.edu>
> > Cc: Greg Thelen <gthelen@google.com>
> > Cc: Shakeel Butt <shakeelb@google.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Hugh Dickins <hughd@google.com>
> > CC: Roman Gushchin <guro@fb.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> > Cc: Muchun Song <songmuchun@bytedance.com>
> > Cc: riel@surriel.com
> > Cc: linux-mm@kvack.org
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: cgroups@vger.kernel.org
> --
> Michal Hocko
> SUSE Labs
