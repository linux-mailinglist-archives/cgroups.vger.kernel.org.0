Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAA011379DD
	for <lists+cgroups@lfdr.de>; Fri, 10 Jan 2020 23:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbgAJWur (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Jan 2020 17:50:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36166 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgAJWur (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Jan 2020 17:50:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so3309949wru.3
        for <cgroups@vger.kernel.org>; Fri, 10 Jan 2020 14:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wAsz+fPA/LefXU9M972dsXIs0ZvQeOeZzv6isccMES4=;
        b=KUy2quGOzP4NtmFgtPD9Adynmo8ZCnwcV45PB9JrTH/XC/g91jQ8Mvm3Q+8aBgYzh0
         v+Jlmjt2kaQXH1PrIE05moyL2kTq0VbvZCYGzUW/gtwd9q4PnK0DhQpkRHzDtJw5Af5o
         eVXwvqlA6DBNAnfXQFkzC2fxwkYx2DEHLE004qTuAfXYhqVxEEykoQGavmNemZdMngcw
         QJzCUTjU7SVT+a9ajTR3caZqFS8Jeq3DrqVaTXflm3MlvMdIO1VetHDLeNQYbe1eFUGu
         0IqyvvKKBW23yNF+XUy4GuPBaz4stg6PMB2I5xBXULWFZEk3zNphPLEfIpYXeH33bqwL
         ur4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wAsz+fPA/LefXU9M972dsXIs0ZvQeOeZzv6isccMES4=;
        b=Jk0rPGuHlgxIZ8k+KjA4Q0qYOY9eK8OpN1TQmlyVSsIVo8yk7Ln9NqZrnClxvLx4LW
         dMsN7vnlPG2vQZkmtMipBECUsLmD8wkBrk9Fa1Tu6s8gGWwsE3lm5jsDubNdbRDr/xqC
         BeuvblgUVVXNPrItpUWzMTeZsmThX6C0uz7yvtQNfyDeb9CChF/NF1X0isT6z+fuaMDo
         96RfhzopnbAZnsPd8kX+lzEVg+jt2Blk03EVWexk4P//ZJt04rqayBYlRLS+wAoeENxJ
         sQB7sq4JcV2lk6uAvkcQzCu26mLpIVk/TQS0z1jxjYYCsaajNNljs7T59OE6mSzfex19
         ygqw==
X-Gm-Message-State: APjAAAUXhRGdIz0DOoYBSDdlnaJaFO3UQ2Ut7I4gc6LXvFGimb9r3zFG
        qJl6nSZegnXCIBNopbZogL7yu4lTY4YGbPRP/Yup9g==
X-Google-Smtp-Source: APXvYqxhNh+VQHcou6Nk5BaDf3FlcVsqD6oNdtcsP7XglJyesW0hNwTag/9kKmi4M/Q+FhTCxeDMBiNAgy4e1jvqm6A=
X-Received: by 2002:adf:cf06:: with SMTP id o6mr5568901wrj.349.1578696644397;
 Fri, 10 Jan 2020 14:50:44 -0800 (PST)
MIME-Version: 1.0
References: <20190529003601.GN374014@devbig004.ftw2.facebook.com>
 <e45d974b-5eff-f781-291f-ddf5e9679e4c@gmail.com> <20190530183556.GR374014@devbig004.ftw2.facebook.com>
 <20190530183637.GS374014@devbig004.ftw2.facebook.com> <20190530183700.GT374014@devbig004.ftw2.facebook.com>
 <20190607170952.GE30727@blackbody.suse.cz> <20190611185742.GH3341036@devbig004.ftw2.facebook.com>
 <CAJuCfpGkAsmp5B=fNz38fLE8pYaMCG=uLDSSBFByNOtWD20zVQ@mail.gmail.com>
 <20200110215648.GC2677547@devbig004.ftw2.facebook.com> <CAJuCfpHPRfV5KDM74JtDepdUJ2G+-3-A3XV+Fzr3Lkbj9nR-Cg@mail.gmail.com>
 <20200110221553.GD2677547@devbig004.ftw2.facebook.com>
In-Reply-To: <20200110221553.GD2677547@devbig004.ftw2.facebook.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 10 Jan 2020 14:50:33 -0800
Message-ID: <CAJuCfpEpkX2-hDQ18qstr=1zndxVbHxH8=WE82fK4khUGAw6FQ@mail.gmail.com>
Subject: Re: [PATCH 3/3 cgroup/for-5.2-fixes] cgroup: Include dying leaders
 with live threads in PROCS iterations
To:     Tejun Heo <tj@kernel.org>
Cc:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Topi Miettinen <toiwoton@gmail.com>,
        Li Zefan <lizefan@huawei.com>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        security@debian.org, Security Officers <security@kernel.org>,
        Lennart Poettering <lennart@poettering.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        james.hsu@mediatek.com, linger.lee@mediatek.com,
        Tom Cherry <tomcherry@google.com>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 10, 2020 at 2:15 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Fri, Jan 10, 2020 at 02:14:19PM -0800, Suren Baghdasaryan wrote:
> > > Yeah, the current behavior isn't quite consistent with the
> > > documentation and what we prolly wanna do is allowing destroying a
> > > cgroup with only dead processes in it.  That said, the correct (or at
> > > least workable) signal which indicates that a cgroup is ready for
> > > removal is cgroup.events::populated being zero, which is a poll(2)able
> > > event.
> >
> > Unfortunately it would not be workable for us as it's only available
> > for cgroup v2 controllers.
> > I can think of other ways to fix it in the userspace but there might
> > be other cgroup API users which are be broken after this change. I
> > would prefer to fix it in the kernel if at all possible rather than
> > chasing all possible users.
>
> Yeah, the right thing to do is allowing destruction of cgroups w/ only
> dead processes in it.

Thanks for confirmation. I'll see if I can figure this out.

>
> --
> tejun
