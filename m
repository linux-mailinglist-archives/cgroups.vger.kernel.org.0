Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26A9C18095B
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2020 21:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgCJUmK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Mar 2020 16:42:10 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37397 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbgCJUmJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Mar 2020 16:42:09 -0400
Received: by mail-ot1-f67.google.com with SMTP id b3so14603923otp.4
        for <cgroups@vger.kernel.org>; Tue, 10 Mar 2020 13:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/deQQvgAa+oP9j87xo/rUZaCa5U0Y9db6yvuNAirEL0=;
        b=Ai8FMPZwPDU7dLeUmmQ5IrGiGriK5BF4c8C/goY7nt9A9p0gwe5maK+FI7+io4/LeT
         TH75Po6PkJ8cLhul21gKVq5bWmL9bTskL2/wNLmg/UhfqLGQmIZTlDwwzbG4bhIx/8Wv
         nl67KGQquy1o2acEsx4cOKOda/SY8w9A9rZBy4UxDDi2XSDeodDuMiMmGE448FGGfIHQ
         US1d67PAbkslxP0i5Ev6LK+9hnyhEL4jnDxjpu/dzCkvxOA6VRtuB0PUXr6qtk9lROVD
         NYYE3TiPoonSAGo6CIxmgX00jAcsnM1upezPCYcMpmmNna94s8ehKfcP/zP+lB6K5b1w
         sjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/deQQvgAa+oP9j87xo/rUZaCa5U0Y9db6yvuNAirEL0=;
        b=HrpfsoMZdfBBo1onTvbXEbCZywzznHiFaLffuPA7IHEqkcQ9d04uNroHrsaQ2auknD
         Oh18/bivUitpEueUWInADsnm4ZDRToIpYrB7t4DTDHoAbhsZJxoLdO81U6/EKebL/JXD
         VRexsCGyg3vHr+XKBoQVWIWFsZ2tizA6F2nmALUcBAoH6NSrn5v2eXiyOtSZYyYresk9
         mHwcb384U4tZQdaCjzpx61sk8l1Jk21jARWnmBRHjzxAfI1LSHYXbvTsLVtFKYdqhiTY
         HRqQKpOQyztOycKGOCz3HkReuJvI+jbhxzS8nUygyp12bC9KEWzux/3LwUoq+vG1opHK
         0TOQ==
X-Gm-Message-State: ANhLgQ2232tq/zpLKPrGH9YFrPjU2mJWj1er1Isi0YRBqSjzdUtZUiRe
        RNsRdfh6XJ7QnGcsvF+k2CvBs35yCyWvJe9Cg36rHg==
X-Google-Smtp-Source: ADFU+vtGvITp2sg+JZTjjfj9Q4pfx+/tRU62/dj4Jx5MF0ePB3TZaCSIkHsvrMO5+nTGln9aZv0pNAz+jfn/4+0y8w0=
X-Received: by 2002:a05:6830:118c:: with SMTP id u12mr17412267otq.124.1583872928122;
 Tue, 10 Mar 2020 13:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod62gypsxCYOpGsR6SWwp7roh8eEEKvZ8WNFtjB0bH=okg@mail.gmail.com>
 <C17G1V88F2XD.EQFO8E8QX1YO@dlxu-fedora-R90QNFJV>
In-Reply-To: <C17G1V88F2XD.EQFO8E8QX1YO@dlxu-fedora-R90QNFJV>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 10 Mar 2020 13:41:57 -0700
Message-ID: <CALvZod6mcoKTqi=OvyHQLbm1LszijDV-traf4Rx9oXmLSZe-Gg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] kernfs: kvmalloc xattr value instead of kmalloc
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Cgroups <cgroups@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 10, 2020 at 1:40 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Hi Shakeel,
>
> On Tue Mar 10, 2020 at 12:40 PM, Shakeel Butt wrote:
> > Hi Daniel,
> >
> >
> > On Thu, Mar 5, 2020 at 1:16 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > >
> > > It's not really necessary to have contiguous physical memory for xattr
> > > values. We no longer need to worry about higher order allocations
> > > failing with kvmalloc, especially because the xattr size limit is at
> > > 64K.
> > >
> > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> >
> >
> > The patch looks fine to me. However the commit message is too cryptic
> > i.e. hard to get the motivation behind the change.
> >
>
> Thanks for taking a look. The real reason I did it was because Tejun
> said so :).
>
> Tejun, is there a larger reason?
>

I understand the reason. I am just suggesting to rephrase it to be more clear.
