Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077F7400AD8
	for <lists+cgroups@lfdr.de>; Sat,  4 Sep 2021 13:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbhIDKmB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 4 Sep 2021 06:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbhIDKmA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 4 Sep 2021 06:42:00 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D692C061575;
        Sat,  4 Sep 2021 03:40:58 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id jg16so3204247ejc.1;
        Sat, 04 Sep 2021 03:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7+4MmuaT7rzL8mD6S0mX3jwc0NJwjLstDiX92Mhzqd4=;
        b=PmmreLIE6KPwSpV+eJRLKMgW3Z30UIoOJXn2XWGN5zOeZCiFFCbe72Se9ehgrpy4QD
         NSUwp6ElCXnxyH3HMiP/c7mvFVBX0VxpM+vAZ6tzeeNkIYoa9IZZ/6Oa9bkdQcsx16zA
         c3mq2QFsv+7/sMkbzVjO4BjRpMFFTTbjpdXp2iHK5z628+Mtl8+rVvWvWcoEE/qcJLz7
         3k424wbk3KYmigidxMfjdlkW1VCzH1CQmEiX3kY44zePy+dMwzYrLWU2Lcly/QHNUfvN
         OayFV6GeBgs9vriO3vIkYddgKANYIoBqD9OawdPifLI/DOQHSp7UbVhE81giyoFbYeJg
         0NEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7+4MmuaT7rzL8mD6S0mX3jwc0NJwjLstDiX92Mhzqd4=;
        b=qwt9IeSIX1mElQnaF2dBfkBgh4XphnPtbEQ3gyOvzabpf1jzFQoockp/TVIFmxudRg
         z2dypKv14h16u7HAu/y9UHDehiqa3YAJCJraJukZbEJBM5esocMorQzM039rRcWbPvIJ
         b/+0uCZS/WqYdsgoqmgQq3/colOrrYVXwO/rwM8D7fYWBXNtXtBO+4jRIV+YsppMGpJ3
         iSMiyseGwRo5kZFgSFBaOhXU70o6TAbs26TfVHG6dzkfScOmLAC0wIrnWtvjrVRY+5vf
         iR8yTvJq7yvKHuCK3xTjxUG1dtAd5uZxJCJus/9jyg3r4X4njvZPGzQyg8yBDw/ZS4Mz
         2bKg==
X-Gm-Message-State: AOAM5318wrTQyDFuUsJTqiXQ5n+ckGbM/COoOb2khWVQ3u5hgM7N66J0
        PM1w/bWpRHe0zI7v6QD3thZIhXCHCoeh5kU2Tyk=
X-Google-Smtp-Source: ABdhPJyahrFLnFDakX63r0MkI/mkLOknN1ylIObQIHUEgYibjw/8s8A3iMEGFYePNa0Jnxfh9cvJkqyWF9X/VTnTZBM=
X-Received: by 2002:a17:906:9388:: with SMTP id l8mr3621379ejx.307.1630752056967;
 Sat, 04 Sep 2021 03:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <1629417219-74853-1-git-send-email-wang.yong12@zte.com.cn>
 <YR+Rc9HC6OqlEq4I@dhcp22.suse.cz> <CAOH5QeCfwF0hX3XpoThEtwnddtOFEU9Jtp0Hoj+Q37D4Q6HC0Q@mail.gmail.com>
 <YR/NRJEhPKRQ1r22@dhcp22.suse.cz> <CAOH5QeDUUqrMnuws6cnBDU_oub4cK6KsHeX39p7Eikr4Bcjcnw@mail.gmail.com>
 <YSzh31BasoxUQXAu@dhcp22.suse.cz>
In-Reply-To: <YSzh31BasoxUQXAu@dhcp22.suse.cz>
From:   yong w <yongw.pur@gmail.com>
Date:   Sat, 4 Sep 2021 18:41:00 +0800
Message-ID: <CAOH5QeBrxpddmTL40ryajjCJZ4WHJsaubYKBvaeikikn1JmJ9Q@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Add configuration to control whether vmpressure
 notifier is enabled
To:     Michal Hocko <mhocko@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, alexs@kernel.org,
        Wei Yang <richard.weiyang@gmail.com>, Hui Su <sh_def@163.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        wang.yong12@zte.com.cn, Cgroups <cgroups@vger.kernel.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, yang.yang29@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Michal Hocko <mhocko@suse.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8830=E6=97=A5=
=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=889:49=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun 22-08-21 17:46:08, yong w wrote:
> > > All those reasons should be a part of the changelog.
> > >....
> > > I am not sure these are sufficient justifications but that is somethi=
ng
> > > to discuss. And hence it should be a part of the changelog.
> > >
> > OK, These reasons will be added to the patch notesin later versions.
> >
> > > > 3. In the case where the user does not need vmpressure,  vmpressure
> > > > calculation is additional overhead.
> > >
> > > You should quantify that and argue why that overhead cannot be furthe=
r
> > > reduced without config/boot time knobs.
> > >
> > The test results of the previously used PFT tool may not be obvious.
> > Is there a better way to quantify it?
>
> This is a question for you to answer I am afraid. You want to add a
> configuration option and (as explained) that is not free of cost from
> the maintenance POV. There must a very good reason to do that.
Sorry for the late reply.The previous email mentions some reasons.
and several tools were used to test, but the data did not meet the expectat=
ions.
I'll try other test methods later.

> > > > In some special scenes with tight memory, vmpressure will be execut=
ed
> > > > frequently.we use "likely" and "inline"
> > > > to improve the performance of the kernel, why not reduce some
> > > > unnecessary calculations?
> > >
> > > I am all for improving the code. Is it possible to do it by other mea=
ns?
> > > E.g. reduce a potential overhead when there no events registered?
> > Yes, the method you mentioned may be feasible, but it does not conflict
> > with this patch.
>
> It is not in conflict but runtime overhead reduction without more burden
> on the configurability is usually a preferred approach.
I agree with you.I had an idea that we use global variables to identify whe=
ther
there is event registration,however, global variables need to be
protected with locks.
I feel that there is little room for optimization in the code.

Thanks.
