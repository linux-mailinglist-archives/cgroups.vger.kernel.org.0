Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298071B7CBA
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2020 19:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgDXR2f (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Apr 2020 13:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgDXR2e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Apr 2020 13:28:34 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE00C09B047
        for <cgroups@vger.kernel.org>; Fri, 24 Apr 2020 10:28:21 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k1so11881508wrx.4
        for <cgroups@vger.kernel.org>; Fri, 24 Apr 2020 10:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lOJjvTeknd9q+St0KOOombUF0u+c2MUeVsDvX2ufelg=;
        b=nqplw7mgBaPUfEj5oal2LRLt6imErNyt3vHO1mwM6uZswgsI0uy9/KHjjKOOiCKZgA
         UZ75MKY6c5tK52paVgE8dcoxN7YCRDFLfZglIfSuue+KoHs4pPdLVP//ijqYQ42UYmdh
         FzqjZrL4kVa7AF5SWIF5QVrLXFyIyBsUeJqEBYYAqnbgdJ5cCHiaGfO0JXQCrYJboOXL
         qkPVzlXV0PMeXK6kf+bBpjt3PCn0gOQNq4YNmSCvCdX3c9DQQLP88HmcU49LuJJjmE6f
         3UrR9WdnYmzemO/c97qk055/+7K5YS6SdSfqyPDPJBRjwgcmc/3SfSJ4hkEu3xGw3OdV
         EjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lOJjvTeknd9q+St0KOOombUF0u+c2MUeVsDvX2ufelg=;
        b=gY0efmqGsMrZDbHO1GDVvxvbeOJ257jk63eLKNr1riOHQZybwgTv700MIqlhgKb3G9
         I0zwjIoE65DHjf1iRhf+SLIz5IQgvtlKxkoAOpYgOqi8pEdNCuMvMTR2YLPnMXMEFNNo
         S8yP8QXTZh44NrQ1yhC6jcXAvJVAT/4TjZhRmnokNLGL1bUlZe2khY3WDc0FAacL6XQ5
         7jgZlyZH669wqAlqMFDjL16xMH0KtuZVydEV+jfdxY5ZAIEkOtNW8Z+7rwb4DI4pGyec
         1Pu0O31iUH9gpg7bo2iMB/9/UKqacHLGdOqO6VvoFamsmjlsIrHCPDBENS85m+28Bks7
         /P8g==
X-Gm-Message-State: AGi0Puaa+7sz4BpUhQG2WFYQac9qINklLo5KSutFVTbCV6An9QSoCGUX
        n+aXbJ+LN7kfSCjmIh5JgqZsALTNCrmaWuOG4+Q=
X-Google-Smtp-Source: APiQypJXkenZrqApKDCaDIxcyidpYgX4k8Tf03MMuVCNfHrYpM0CEPWljxaAAO+Jk5QW+CA76opgli4V+jbp92OjcJY=
X-Received: by 2002:a5d:634f:: with SMTP id b15mr11774051wrw.46.1587749300525;
 Fri, 24 Apr 2020 10:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAOWid-dSF0X3pa6ud2-ndYzJdohuOBewfcEZcG7pQ8q=fZh14g@mail.gmail.com>
 <20200424162557.GB99424@carbon.lan> <CAOWid-f0dKfZ=bAzLzdt-wCx2C2orYs3RrKi1MrfjO2=jJVyyw@mail.gmail.com>
 <20200424170754.GC99424@carbon.lan>
In-Reply-To: <20200424170754.GC99424@carbon.lan>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Fri, 24 Apr 2020 13:28:09 -0400
Message-ID: <CAOWid-fw=jaxWTVLTESrPf9XPE3PMnrQkk7GZnaPSkqFN_3e_g@mail.gmail.com>
Subject: Re: Question about BPF_MAP_TYPE_CGROUP_STORAGE
To:     Roman Gushchin <guro@fb.com>
Cc:     cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Roman,

Um... I am not sure yet because I don't think I understand how
bpf-cgroup actually works.  May be you can help?  For example, how
does delegation work with bpf-cgroup?  What is the relationship
between program(s) attachted to the parent cgroup and the children
cgroups?  From what I understand, the attached eBPF prog will simply
replace what was attached by the parent (so there is no relationship?)
 Sequentially running attached program either from leaf to root or
root to leaf is not a thing right?

Regards,
Kenny

On Fri, Apr 24, 2020 at 1:08 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Fri, Apr 24, 2020 at 12:43:38PM -0400, Kenny Ho wrote:
> > Hi Roman,
> >
> > I am thinking of using the cgroup local storage as a way to implement
> > per cgroup configurations that other kernel subsystem (gpu driver, for
> > example) can have access to.  Is that ok or is that crazy?
>
> If BPF is not involved at all, I'd say don't use it. Because beside providing
> a generic BPF map interface (accessible from userspace and BPF), it's
> just a page of memory "connected" to a cgroup.
>
> If BPF is involved, let's discuss it in more details.
>
> Thanks!
>
> >
> > Regards,
> > Kenny
> >
> > On Fri, Apr 24, 2020 at 12:26 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Fri, Apr 24, 2020 at 12:17:55PM -0400, Kenny Ho wrote:
> > > > Hi,
> > > >
> > > > From the documentation, eBPF maps allow sharing of data between eBPF
> > > > kernel programs, kernel and user space applications.  Does that
> > > > applies to BPF_MAP_TYPE_CGROUP_STORAGE?  If so, what is the correct
> > > > way to access the cgroup storage from the linux kernel? I have been
> > > > reading the __cgroup_bpf_attach function and how the storage are
> > > > allocated and linked but I am not sure if I am on the right path.
> > >
> > > Hello, Kenny!
> > >
> > > Can you, please, elaborate a bit more on the problem, you're trying to solve?
> > > What's the goal of accessing the cgroup storage from the kernel?
> > >
> > > Certainly you can get a pointer to an attached buffer if you have
> > > a cgroup pointer. But what's next?
> > >
> > > Thanks!
