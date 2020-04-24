Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195AB1B81A7
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2020 23:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgDXVdY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Apr 2020 17:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDXVdX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Apr 2020 17:33:23 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71424C09B049
        for <cgroups@vger.kernel.org>; Fri, 24 Apr 2020 14:33:23 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u127so12810681wmg.1
        for <cgroups@vger.kernel.org>; Fri, 24 Apr 2020 14:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7S3mw8T341U174np+tgitrZUzAws5XkQLS0dvJQ3qvk=;
        b=buJwg3IF5yBluBVQPFlDUBLmRpDWaFgg33SojIkJgano29lmjWTjObXsxa4xLBMoWh
         WyMThaQzw+qZZNWd0pJY+aVADU6RmMeR2+oWrRE4PTxAVNRVt6FxevPGz7r9JYpjGq7j
         MsuRpUvOeTbYn7Sceusg+zxVGC6KSiTzvYkO3VMgZ4KcToLlanOWvexzk/Dmu/tPiOhz
         qiSvCWAJGjl/B1OgHHSfYSq2kt5a9Pd2pmzjIm6N8li2D/5ilv2qNIcvbUysa71eiCF8
         tx/xDaMPZQo5QiC4b9dCLBx2TotLkLHTwLJpmW/4wh8b8+HwaEXc+V12PAV19l7rdKub
         fEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7S3mw8T341U174np+tgitrZUzAws5XkQLS0dvJQ3qvk=;
        b=CGckuHbDvQGIx+hPV6k4jciQVzCwWfwTMJT6MtQB4Z5eWUF8ogFhTJ6zKZgjdM5Z2O
         1euE9VWUHHZpEUbLwAmgCcj9vK1QR0527ek4BZInqq19wPwc1brbWx3jPGFBQamQek1N
         eHDzv3ssloMDseHG/Y3VKM58gS51EN9wbbXfVS8INdLzD74y02zttplDLtuMnMCpuZ/r
         100fmnmXT1pEjuycTqRDzppx7SJybN7W+kXkeM+h3/xcdLQzeU8tfZjmnudba9vn243n
         0dFW2XRG5za1nd+Yagu1DtG/R7543AFplW+z4YHQOylJ5fLIOaBiRBiykmEON4YGjuRZ
         G5mg==
X-Gm-Message-State: AGi0PuaObZVxZ1Q41rMMzDq6rJVizxLvZCMjIlM9+Qwf3pnPSkbG9QJE
        ewIvdn+NbCuAA+wgbmmvI3cVfq5y37bWSESwZ/WMv38KQW4=
X-Google-Smtp-Source: APiQypLSwCTNQW88O2pDwkYZO2UeTzY5bWG1abSMtJft7sU4z7BsRuTucfmlRsFrqa34QmWVcB0bgC6Io4scD1koTTs=
X-Received: by 2002:a05:600c:2157:: with SMTP id v23mr11591623wml.149.1587764002176;
 Fri, 24 Apr 2020 14:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAOWid-dSF0X3pa6ud2-ndYzJdohuOBewfcEZcG7pQ8q=fZh14g@mail.gmail.com>
 <20200424162557.GB99424@carbon.lan> <CAOWid-f0dKfZ=bAzLzdt-wCx2C2orYs3RrKi1MrfjO2=jJVyyw@mail.gmail.com>
 <20200424170754.GC99424@carbon.lan> <CAOWid-fw=jaxWTVLTESrPf9XPE3PMnrQkk7GZnaPSkqFN_3e_g@mail.gmail.com>
In-Reply-To: <CAOWid-fw=jaxWTVLTESrPf9XPE3PMnrQkk7GZnaPSkqFN_3e_g@mail.gmail.com>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Fri, 24 Apr 2020 17:33:11 -0400
Message-ID: <CAOWid-f6Kjds2sQ-auOPzixWaCa4twD6BQ+NbCipfU6remn1Hw@mail.gmail.com>
Subject: Re: Question about BPF_MAP_TYPE_CGROUP_STORAGE
To:     Roman Gushchin <guro@fb.com>
Cc:     cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Roman,

To be more specific, I have been looking at the bpf-cgroup
implementation of device cgroup and I cannot wrap my head around how
the bpf-cgroup implementation would be able to enforce "[a] child
cgroup can never receive a device access which is denied by its
parent."  I am either missing some understanding around device cgroup
or bpf cgroup or both.  Any pointer you can give me would be much
appreciated.

Regards,
Kenny

On Fri, Apr 24, 2020 at 1:28 PM Kenny Ho <y2kenny@gmail.com> wrote:
>
> Hi Roman,
>
> Um... I am not sure yet because I don't think I understand how
> bpf-cgroup actually works.  May be you can help?  For example, how
> does delegation work with bpf-cgroup?  What is the relationship
> between program(s) attachted to the parent cgroup and the children
> cgroups?  From what I understand, the attached eBPF prog will simply
> replace what was attached by the parent (so there is no relationship?)
>  Sequentially running attached program either from leaf to root or
> root to leaf is not a thing right?
>
> Regards,
> Kenny
>
> On Fri, Apr 24, 2020 at 1:08 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Fri, Apr 24, 2020 at 12:43:38PM -0400, Kenny Ho wrote:
> > > Hi Roman,
> > >
> > > I am thinking of using the cgroup local storage as a way to implement
> > > per cgroup configurations that other kernel subsystem (gpu driver, for
> > > example) can have access to.  Is that ok or is that crazy?
> >
> > If BPF is not involved at all, I'd say don't use it. Because beside providing
> > a generic BPF map interface (accessible from userspace and BPF), it's
> > just a page of memory "connected" to a cgroup.
> >
> > If BPF is involved, let's discuss it in more details.
> >
> > Thanks!
> >
> > >
> > > Regards,
> > > Kenny
> > >
> > > On Fri, Apr 24, 2020 at 12:26 PM Roman Gushchin <guro@fb.com> wrote:
> > > >
> > > > On Fri, Apr 24, 2020 at 12:17:55PM -0400, Kenny Ho wrote:
> > > > > Hi,
> > > > >
> > > > > From the documentation, eBPF maps allow sharing of data between eBPF
> > > > > kernel programs, kernel and user space applications.  Does that
> > > > > applies to BPF_MAP_TYPE_CGROUP_STORAGE?  If so, what is the correct
> > > > > way to access the cgroup storage from the linux kernel? I have been
> > > > > reading the __cgroup_bpf_attach function and how the storage are
> > > > > allocated and linked but I am not sure if I am on the right path.
> > > >
> > > > Hello, Kenny!
> > > >
> > > > Can you, please, elaborate a bit more on the problem, you're trying to solve?
> > > > What's the goal of accessing the cgroup storage from the kernel?
> > > >
> > > > Certainly you can get a pointer to an attached buffer if you have
> > > > a cgroup pointer. But what's next?
> > > >
> > > > Thanks!
