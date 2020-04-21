Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EC41B29BE
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 16:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgDUObA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Apr 2020 10:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbgDUObA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Apr 2020 10:31:00 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B440FC061A10;
        Tue, 21 Apr 2020 07:30:59 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id x1so11139888ejd.8;
        Tue, 21 Apr 2020 07:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=nJKmwmL8pJeyEkXSJcr3CbIoVGjTvKtRz5mLqOZGiFM=;
        b=WhnkTtco3iWRQt6NFjmoYU9L1wfydDjHO2SvHJp+KDB2RgB3AgDTsA/GTLnu1lFqV7
         Zoar8hUYXl22NCEiW9OLuM6g4ZpigIq1k+fGakrItDCr5csRuT2nTq1tEN3hY7sASA35
         QQDYwD+W2cemygxtTq+6p/8bXUFvSmPUfcupMcYEwTpMhQMNzTQKHHByFvZRAmiqakCI
         3nNqBUs4DTRYabiA4O8RSJ9HKYGKFg7nV29Xh9rD/6dok3gjVqn9/YhDbSI/6Vem0yGA
         5XhMVFY2DWrsc/BVBKYRoQ/BeFZWODboD3lFpwKsITVIq1BAFrAdIhgyM9kmZWWBdP+g
         R0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=nJKmwmL8pJeyEkXSJcr3CbIoVGjTvKtRz5mLqOZGiFM=;
        b=Nvk9w+4E5xzesvvPiND8i+cM+OJXfc7Tts2giQx2IxajKPGmi3VggXFxtpXJ5q8P1n
         DG+T1wfm+3zo4p6rvZagLCMMDaekITF1zFWHiCFFea7jtumO3QMcf2r+kG2QKG+GOASr
         7Gzq0PpgxJzkdyXH6+5KBA907DfE4+EY4Xq3J7xkD7s4Il/22lSKaklzNwu7STLnxybD
         iGJ/KqotjLN2slWmCOtBnrvVYbGTvB7OwJfhI3MOKB5gzzE2zkuMSrJuSq53x/RKdamB
         FEKWm2mHKsSzJTwtv2YOYMgNxUPvsMPoxtd9IXSplN7hzYTDTFive23/bGRm1ALb4N8L
         jigw==
X-Gm-Message-State: AGi0Pua5g55Ss6e1Rg6+k4PUnFmX7g9DW70HRZR7FztS8Oyikd/7Vhx4
        8xWgvGMwmsyHz7NZZPn3cHj+hEBb2z6gwJCXdCc=
X-Google-Smtp-Source: APiQypLvKjlIrLLDZw7H9NUfR5+MQ7F35cXfQad0lKg6B/PUGcGli1jOCM/Qn1qXml6rqBmbydwxEzLoYlAyc6lbVGk=
X-Received: by 2002:a17:906:1fd6:: with SMTP id e22mr21913379ejt.150.1587479458385;
 Tue, 21 Apr 2020 07:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgNAkhL0zCj11LS9vfae872YVeRsxdz20sZWuXdi+UjH21=0g@mail.gmail.com>
 <20200410104132.294639-1-christian@brauner.io> <b7550fcd-ba12-e64a-3228-e6668b31a8a7@gmail.com>
In-Reply-To: <b7550fcd-ba12-e64a-3228-e6668b31a8a7@gmail.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Tue, 21 Apr 2020 16:30:46 +0200
Message-ID: <CAKgNAkhQr+sKGAu+KcxPEsuwG3kjQOyzVW7E1yM9cMtSZrhW9A@mail.gmail.com>
Subject: Re: [PATCH] clone.2: Document CLONE_INTO_CGROUP
To:     Christian Brauner <christian@brauner.io>
Cc:     "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Christian,

Ping!

Cheers,

Michael

On Fri, 10 Apr 2020 at 22:18, Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> Hi Christian,
>
> Thank you for writing this!
>
> On 4/10/20 12:41 PM, Christian Brauner wrote:
> > From: Christian Brauner <christian.brauner@ubuntu.com>
> >
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> >  man2/clone.2 | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/man2/clone.2 b/man2/clone.2
> > index 39cec4c86..8d9aa9f99 100644
> > --- a/man2/clone.2
> > +++ b/man2/clone.2
> > @@ -197,6 +197,7 @@ struct clone_args {
> >      u64 tls;          /* Location of new TLS */
> >      u64 set_tid;      /* Pointer to a \fIpid_t\fP array */
> >      u64 set_tid_size; /* Number of elements in \fIset_tid\fP */
> > +    u64 cgroup;       /* Target cgroup file descriptor for the child process */
> >  };
> >  .EE
> >  .in
> > @@ -448,6 +449,25 @@ Specifying this flag together with
> >  .B CLONE_SIGHAND
> >  is nonsensical and disallowed.
> >  .TP
> > +.BR CLONE_INTO_CGROUP " (since Linux 5.7)"
> > +.\" commit ef2c41cf38a7559bbf91af42d5b6a4429db8fc68
> > +By default, the child process will belong to the same cgroup as its parent.
>
> s/belong to/be placed in/
>
> s/cgroup/version 2 cgroup/
>
> > +If this flag is specified the child process will be created in a
> > +different cgroup than its parent.
> > +
> > +When using
> > +.RB clone3 ()
> > +the target cgroup can be specified by setting the
> > +.I cl_args.cgroup
> > +member to the file descriptor of the target cgroup. The cgroup file
>
> We need to say something about how this file descriptor is
> obtained. Is it by opening a directory in the v2 cgroup hierarchy?
> With what flags? O_RDONLY? or is O_PATH also possible? Yes, these
> are some rhetorical questions (I read your nice commit message);
> these things need to be explicit in the manual page though.
>
> Also, your commit message mentions a nice list of use cases.
> I think it would be well worth capturing those in a paragraph
> in the manual page text.
>
> > +descriptor must refer to a cgroup in a cgroup v2 hierarchy
> > +(see
> > +.BR cgroup (2)).
>
> s/cgroup/cgroups/
> s/2/7/
>
> > +
> > +Note that all usual cgroup v2 process migration restrictions apply. See
> > +.BR cgroup (2)
>
> s/cgroup/cgroups/
> s/2/7/
>
> Thanks,
>
> Michael
>
> --
> Michael Kerrisk
> Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> Linux/UNIX System Programming Training: http://man7.org/training/



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
