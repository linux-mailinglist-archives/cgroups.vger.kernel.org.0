Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D573A70FB
	for <lists+cgroups@lfdr.de>; Mon, 14 Jun 2021 23:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbhFNVGv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Jun 2021 17:06:51 -0400
Received: from mail-il1-f171.google.com ([209.85.166.171]:33521 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhFNVGv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Jun 2021 17:06:51 -0400
Received: by mail-il1-f171.google.com with SMTP id z1so13490209ils.0;
        Mon, 14 Jun 2021 14:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VJNQ58fPboxZ6jLtS5aQ6QCEiZ6o7j6B3BgLz2sHkSM=;
        b=jytBZoPzlATDFMDIFjt7KaYNYb/uYZCnhJ7EWRXHvrQL+Ii3byJsNKC6frIvaHdRXk
         oJwTaBTgUnuNRDmW3Up2IaEgEqWxBBHo9tYAofgt3D5l3qC+rvpwejcjd5D5PbZdBZC9
         6XcP6JxaC+mGGgPAplTn/Fejv/Pxv9qf0MZ9miinWTKxHo6VjPwZzTNj7y41YarKjvqU
         H0XF86RFYkZnNiDNWHOSWsPF6NT8LZIA7rEosPk9jIt2kRY7n7r4NvLoa91vqVLSNRsr
         JWEFzmz+clsUDhUk7IcyOsJX0sIzszmHUKUQPRg08bJGeGqghAiysXRWYuy33rBvlbp2
         l1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VJNQ58fPboxZ6jLtS5aQ6QCEiZ6o7j6B3BgLz2sHkSM=;
        b=GpC9/vmjOqscu2qUcRYM/N9jceBX428Z6iCmj2M8jhiCvJolyWUi5gUpkpzxfdKUEf
         Dq3V1ZWkD6xzXQ5lEYzgsphJ9je/HnAH852mgx7GrNDZUaz5F+rFkgL20z74wB7NhIV0
         +vemTs2/y76yVr85Acogu2jqXh031A8vbDiZ/gESOpPVybie2XcrrabKJikRTnhFFSoi
         3KX/MG4DGRNRb6fK7HdCtxtuFSZxdnpO6u1wyj2xtQzUvwanZ259Z2CNhw8V+uNJ4I08
         pk9fM3JMqOU1k9ZktdoSUM4ysKCLK0xYUNDMrixgSQMx2pQEmukyYLuGzKO3qrONqwtL
         dUMA==
X-Gm-Message-State: AOAM531wXgcPlpKCFWKpaDQBXMSpaLpq9aSwzylzJ48l/lGbURuN7Hc7
        g7nkmd3W1Gqat4Ub/kr0UfcsJFwA6299IfCo640=
X-Google-Smtp-Source: ABdhPJzwvda5SXMbfHUHexiSMnbxUgDHhxs6BEet88P/7VmPx2rqwkwdXBT9dK/yVsp2iFjPmpdQ0V5QiHKMhGxReHo=
X-Received: by 2002:a05:6e02:de7:: with SMTP id m7mr14686188ilj.70.1623704628103;
 Mon, 14 Jun 2021 14:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210611030737.1984343-1-kolyshkin@gmail.com> <20210611030737.1984343-2-kolyshkin@gmail.com>
 <8735tlbbml.fsf@meer.lwn.net>
In-Reply-To: <8735tlbbml.fsf@meer.lwn.net>
From:   Kirill Kolyshkin <kolyshkin@gmail.com>
Date:   Mon, 14 Jun 2021 14:03:37 -0700
Message-ID: <CAGmPdrzudz1xS_NaQASbNMbV-uPOq=d9VfBfYNBafEaP8YesGw@mail.gmail.com>
Subject: Re: [PATCH 1/3] docs: block/bfq: describe per-device weight
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, tj@kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Jun 13, 2021 at 4:14 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Kir Kolyshkin <kolyshkin@gmail.com> writes:
>
> This work looks generally good, but...
>
> > The functionality of setting per-device weight for BFQ was added
> > in v5.4 (commit 795fe54c2a828099), but the documentation was never
> > updated.
> >
> > While at it, improve formatting a bit.
> >
> > Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
> > ---
> >  Documentation/block/bfq-iosched.rst | 38 ++++++++++++++++++++---------
> >  1 file changed, 27 insertions(+), 11 deletions(-)
> >
> > diff --git a/Documentation/block/bfq-iosched.rst b/Documentation/block/bfq-iosched.rst
> > index 66c5a4e54130..7200152c461e 100644
> > --- a/Documentation/block/bfq-iosched.rst
> > +++ b/Documentation/block/bfq-iosched.rst
> > @@ -553,20 +553,36 @@ throughput sustainable with bfq, because updating the blkio.bfq.*
> >  stats is rather costly, especially for some of the stats enabled by
> >  CONFIG_BFQ_CGROUP_DEBUG.
> >
> > -Parameters to set
> > ------------------
> > +Parameters
> > +----------
> >
> > -For each group, there is only the following parameter to set.
> > +For each group, the following parameters cat be set:
>
> Could we please not introduce new typos while fixing other stuff?

Are you a dog person? :)

Thanks for catching this, corrected patch sent.
