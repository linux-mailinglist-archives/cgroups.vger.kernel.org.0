Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9862A388D27
	for <lists+cgroups@lfdr.de>; Wed, 19 May 2021 13:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352136AbhESLp2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 May 2021 07:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbhESLp2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 May 2021 07:45:28 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0408CC06175F
        for <cgroups@vger.kernel.org>; Wed, 19 May 2021 04:44:08 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso11521812ote.1
        for <cgroups@vger.kernel.org>; Wed, 19 May 2021 04:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=KvQEt0Pbe3v9Z/6IbeJxPBUgmCm+xqGUBv92hphBoAs=;
        b=KMYlpNlJawOoZQ0mx8WQC9BeQdHxhNu+IsxGWLcMeAAlzLp0G7i1RZsY/s8sQbPxKk
         bSHbS/D3idx1OTwd0CIRoMdlcdlN4YXf9iGsHONkkiyI+5DSRmsFiakMAcatzFdzUyKp
         Qnw1xV/dWCGKs2o9a5r3nrtTGa7CV8ex/+Tu81qsRNk1miaRPS59GGeJT1eWv7b24ghE
         XCcW19WfGNAjCYP6RUi5Vjxi60DYJUUECjTA+lqZjaZ2boRDQM3mqiY1pyyYxiuw4Odg
         GzJ5etm2QP/gISftGDQQSQjohyfq2pI1MBvRv9jWNnv/rvB/aCIApyUKKCkXfFX3dfyr
         uKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=KvQEt0Pbe3v9Z/6IbeJxPBUgmCm+xqGUBv92hphBoAs=;
        b=Lj6mCmtT6mRcQPfugseriVJc8UpAWfDsjLTOf54PqhtbIfIiGWs6FWctfRlaY0kzRS
         lSrRRMqodlTLT+Vk3K0LRy6SmtP+3XxST4suQaYRd6e+9nVkxfnn9/dZvHxPIlF2+fk2
         mq4Alr4lF+6L3v9oxufU4N3JP3UDHxZqiw6Or+IpO78xBKcx51xCc1//YHr5baZSq0tz
         R0pj20iIwrDLkmr5ueSn8DLDtuvNSAiqZBM2V1WqE49tfuWAuI1Oy/L8BfaUXy9TwbcW
         aWgGuPUBKvuHbf0haJLFXuvRXlns4XkmIUr2to+wlWTo+t31vUz6DCW9SZS3ueK2OdsW
         V0zQ==
X-Gm-Message-State: AOAM532+biujWegXeU06V8UKP0pwbwsqDbvMNKp1fIKD9swHZEaWivnq
        /pSZSOunlVhhIP9XMPetXf89BJfUBQikQh9fqD0=
X-Google-Smtp-Source: ABdhPJzsq90iErWPu0ErB1vYn/Jjk+dgbA9u7AoYKOjnee1YYCru/u+xXPEWiTDexJd4Xy6EjyJjNSwGXjJbTg+ixGU=
X-Received: by 2002:a05:6830:1205:: with SMTP id r5mr8839995otp.359.1621424647414;
 Wed, 19 May 2021 04:44:07 -0700 (PDT)
MIME-Version: 1.0
From:   Glaive Neo <nglaive@gmail.com>
Date:   Wed, 19 May 2021 19:43:56 +0800
Message-ID: <CAELef9p42mQ5fvde3A7RSRZDNoDPP+VkR_3TJ5OPQYWsSQk07g@mail.gmail.com>
Subject: Fw: User-controllable memcg-unaccounted objects of time namespace
To:     Michal Hocko <mhocko@suse.com>
Cc:     "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "shenwenbo@zju.edu.cn" <shenwenbo@zju.edu.cn>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        "mhocko@kernel.org" <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

CC reply. Sorry for occupying your time. I was unaware that I had to
use plain text e-mail to make public mailing list accept it, and I
omitted these addresses to avoid rejecting notification.

Yutian Yang,
Zhejiang University


> -----Original Messages-----
> From: "Michal Hocko" <mhocko@suse.com>
> Sent Time: 2021-05-19 17:18:45 (Wednesday)
> To: "Yutian Yang" <ytyang@zju.edu.cn>
> Cc:
> Subject: Re: Fw: Re: Re: User-controllable memcg-unaccounted objects of t=
ime namespace
>
> Did you plan to post this reply to the mailing list with the whole
> original CC list?
>
> On Wed 19-05-21 16:56:27, Yutian Yang wrote:
> >
> >
> >
> > -----Original Messages-----
> > From: "Yutian Yang" <ytyang@zju.edu.cn>
> > Sent Time: 2021-05-18 19:29:40 (Tuesday)
> > To: "Michal Hocko" <mhocko@suse.com>
> > Cc: tglx@linutronix.de, "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.co=
m>, "shenwenbosmile@gmail.com" <shenwenbosmile@gmail.com>
> > Subject: Re: Re: User-controllable memcg-unaccounted objects of time na=
mespace
> >
> > Sorry for the delayed response. I believe our patches are necessary and=
 will answer your questions piece by piece.
> >
> > For the practicality of our concerns, we have confirmed that repeatedly=
 creating new namespaces could lead to breaking memcg limit. Although the n=
umber of namespaces could be limited by per-user quota (e.g., max_time_name=
spaces), depending on per-user quota to limit memory usage is unsafe and im=
practical as users may have their own considerations when setting these lim=
its. In fact, limitation on memory usage is more foundamental than limitati=
on on various kernel objects. I believe this is also the reason why the fd =
tables and pipe buffers have been accounted by memcg even if they are also =
under per-user quota's limitation. The same reason applies to limitation of=
 pid cgroups. Moreover, both net and uts namespaces are properly accounted =
while the others are not, which shows inconsistencies.
> >
> > For other unaccounted allocations (proc_alloc_inum, vvar_page and likel=
y others), we have not reached them yet as our detecting tool reported many=
 results which require much manual effort to go through. To me, it seems th=
at these allocations also need patches.
> >
> > Lastly, our work is based on a detecting tool and we only report missin=
g-charging sites that are manually confirmed to be triggerable from syscall=
s. The results that are obviously unexploitable like uncharged ldt_struct, =
which is allocated per process, are also filtered out. We would like to con=
tinuously contribute to memcg and we are planning to submit more patches in=
 the future.
> >
> > Thanks!
> >
> > Yutian Yang,
> > Zhejiang University
> >
> >
> > > -----Original Messages-----
> > > From: "Michal Hocko" <mhocko@suse.com>
> > > Sent Time: 2021-04-16 14:29:52 (Friday)
> > > To: "Yutian Yang" <ytyang@zju.edu.cn>
> > > Cc: tglx@linutronix.de, "shenwenbo@zju.edu.cn" <shenwenbo@zju.edu.cn>=
, "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>
> > > Subject: Re: User-controllable memcg-unaccounted objects of time name=
space
> > >
> > > Thank you for this and other reports which are trying to track memcg
> > > unaccounted objects. I have few remarks/questions.
> > >
> > >
> > > On Thu 15-04-21 21:29:57, Yutian Yang wrote:
> > > > Hi, our team has found bugs in time namespace module on Linux kerne=
l v5.10.19, which leads to user-controllable memcg-unaccounted objects.
> > > > They are caused by the code snippets listed below:
> > > >
> > > > /*--------------- kernel/time/namespace.c --------------------*/
> > > > ......
> > > > 91ns =3D kmalloc(sizeof(*ns), GFP_KERNEL);
> > > > 92if (!ns)
> > > > 93goto fail_dec;
> > > > ......
> > > > /*----------------------------- end -------------------------------=
*/
> > > >
> > > >
> > > > The code at line 91 could be triggered by syscall clone if
> > > > CLONE_NEWTIME flag is set in the parameter. A user could repeatedly
> > > > make the clone syscall and trigger the bugs to occupy more and
> > > > more unaccounted memory. In fact, time namespaces objects could be
> > > > allocated by users and are also controllable by users. As a result,
> > > > they need to be accounted and we suggest the following patch:
> > >
> > > Is this a practical concern? I am not really deeply familiar with
> > > namespaces but isn't there any cap on how many of them can be created=
 by
> > > user? If not, isn't that contained by the pid cgroup controller? If e=
ven
> > > that is not the case, care to explain why?
> > >
> > > You are referring to struct time_namespace above (that is 88B) but I =
can
> > > see there are other unaccounted allocations (proc_alloc_inum, vvar_pa=
ge
> > > and likely others) so why the above is more important than those?
> > >
> > > Btw. a similar feedback applies to other reports similar to this one.=
 I
> > > assume you have some sort of tool to explore those potential run away=
s
> > > and that is really great but it would be really helpful and highly
> > > appreciated to analyze those reports and try to provide some sort of
> > > risk assessment.
> > >
> > > Thanks!
> > > --
> > > Michal Hocko
> > > SUSE Labs
>
> --
> Michal Hocko
> SUSE Labs
