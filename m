Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0D5166712
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2020 20:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgBTTXM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Feb 2020 14:23:12 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40263 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbgBTTXM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Feb 2020 14:23:12 -0500
Received: by mail-ot1-f68.google.com with SMTP id i6so4746643otr.7
        for <cgroups@vger.kernel.org>; Thu, 20 Feb 2020 11:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bk1eIitMT2MS22kRJrkHf2a6nr5vMQhVA+AkCVP3xms=;
        b=aTmzlFn5tqMffO4aaSdqSmOjwnlwPlhLBMDWmHM5hEgVohGoR95LIESWPin+FgU3m5
         6SBKmIyXfz3mR7ZJGUztrCkEqttjywHypYPY01n74LbVdLtnW3lI3mGg/tCdRKylIrWc
         Jq7asmZQKCD4pm93CxVIrFT9tn3nfGJqSSm8Vsd6HIo/Kcxe7LRKiOXtJ1R+KmDSgYri
         yOJUHQv1/vVwu32bZ3WZIRFgjHFVUSuwrRUtJOBVFSUsAgNS/5PGnC2AW02w3iZZp4zg
         Ia0U7nlOur/8FVS0Sgvy3hruRsr6xz+P5Rcb6cHozsula5vu8Q6sy6WkorjtHYEKafsR
         OD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bk1eIitMT2MS22kRJrkHf2a6nr5vMQhVA+AkCVP3xms=;
        b=R7d6ybtyyfS7q70PnOH40kPcvWgrYSkBYzvORwr0h7Od9gcm37T9J3KopIUsQPhHHA
         NJ6WMBgeEme7qELi4nt5OCPuCIzVcjh3M4yPPzm+Z0KdeMg+aEvpn3QDKBmReFzxW/8d
         8GHKRNm/mNIajuW5qvB1Fc2yt0rPD34NoPFa5/bovckxHcjLiN5GakL4U5IhfZHBvD5R
         2cnugkLfhBa7A8yW0RT6n3YvA38OSeasaSfkrlzDbQo83fmbHstRaVQIdSJ9i1ZP2Oo8
         QSsuKpEhvzlkI9xF+AqcP8fAcjU0v9yNwhB68Uo3zdiNLtLX2TqdZgt2gPBOJL22Xrzd
         IPZA==
X-Gm-Message-State: APjAAAViuvcETXx4UtgilJPj5W4ZJPvyBRVRqbcMuYUp3xh0kjBQ0+Jd
        rjxN9+4Rk8jyPP2dONNZJWfAVoJ0qRjDmV4Xh+j8FQ==
X-Google-Smtp-Source: APXvYqzc0r7mnwBlUc3tSqHO71Kmj09WeY278uUEiCztDiRqODK1P9Hy8XAqcMq8l4Nh1mPh3JVbkAAfzAHEF3HNj0E=
X-Received: by 2002:a9d:7b4e:: with SMTP id f14mr24990667oto.355.1582226589659;
 Thu, 20 Feb 2020 11:23:09 -0800 (PST)
MIME-Version: 1.0
References: <20200211213128.73302-1-almasrymina@google.com>
 <20200211151906.637d1703e4756066583b89da@linux-foundation.org>
 <CAHS8izPUFQWq3PzhhRzp7u11173_-cmRkNuQWEswS51Xz6ZM0Q@mail.gmail.com> <20200219130648.83e6810848774c6fd649c445@linux-foundation.org>
In-Reply-To: <20200219130648.83e6810848774c6fd649c445@linux-foundation.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 20 Feb 2020 11:22:58 -0800
Message-ID: <CAHS8izN_FJektipBwiLsCO8ysMTM7k=CR_k3OV7+_y0ZbrGw+A@mail.gmail.com>
Subject: Re: [PATCH v12 1/9] hugetlb_cgroup: Add hugetlb_cgroup reservation counter
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, shuah <shuah@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 19, 2020 at 1:06 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 19 Feb 2020 11:05:41 -0800 Mina Almasry <almasrymina@google.com> wrote:
>
> > On Tue, Feb 11, 2020 at 3:19 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Tue, 11 Feb 2020 13:31:20 -0800 Mina Almasry <almasrymina@google.com> wrote:
> > >
> > > > These counters will track hugetlb reservations rather than hugetlb
> > > > memory faulted in. This patch only adds the counter, following patches
> > > > add the charging and uncharging of the counter.
> > >
> > > We're still pretty thin on review here, but as it's v12 and Mike
> > > appears to be signed up to look at this work, I'll add them to -next to
> > > help move things forward.
> > >
> >
> > Hi Andrew,
> >
> > Since the patches were merged into -next there have been build fixes
> > and test fixes and some review comments. Would you like me to submit
> > *new* patches to address these, or would you like me to squash the
> > fixes into my existing patch series and submit another iteration of
> > the patch series?
>
> What you did worked OK ;)
>
> Please check the end result next time I release a kernel.

Thanks Andrew! Things definitely moved along after the patchseries got
into -next :D

By my count I think all my patches outside of the tests patch have
been acked or reviewed. When you have a chance I have a couple of
questions:

1. For the non-tests patch, anything pending on those preventing
eventual submission to linus's tree?
2. For the tests patch, I only have a Tested-by from Sandipan. Is that
good enough? If the worst comes to worst and I don't get a review on
that patch I would rather (if possible) that 'tests' patch can be
dropped while I nag folks for a review, rather than block submission
of the entire patch series. I ask because it's been out for review for
some time and it's the one I got least discussion on so I'm not sure
I'll have a review by the time it's needed.

Thanks again!
