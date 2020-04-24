Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98FD1B7BEC
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2020 18:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgDXQnv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Apr 2020 12:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgDXQnv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Apr 2020 12:43:51 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A994FC09B046
        for <cgroups@vger.kernel.org>; Fri, 24 Apr 2020 09:43:50 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id x25so11254733wmc.0
        for <cgroups@vger.kernel.org>; Fri, 24 Apr 2020 09:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H68jxc60NCBa62+Fg4wVWPgLDcgA+0ooiSEDMATOMsI=;
        b=tlKi6OHWtdMwTXbTU5n6tNSfDV/jjq7GaCV01wT/RTuP89B+4GOBQGHSsGe+YAvlju
         rloxSUkLKeouoqO0pfGKcCY91zJ/eMlZ2IXEGHFT3zFHsMcpFpgGR9HNoLyIS/2CmTQP
         6JFSz98PVxiChKK4as9QzKu7Ijklv7Nmnu/Ru9G9NlkyBbxn7jIWMz5bjkDDtJa4yYDh
         8tEdyvRBHomAFpvdVULpjK4L1WMe6VuDazthv28D24pBDUbXyejjLBnbO8RVP0Vz20kz
         dd9iay2sNQSWBwY5zYpXkVvHogwDhk230eG9ujSbiBKRbYmDA1jBWoTVt0KaoURBnSz2
         0tFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H68jxc60NCBa62+Fg4wVWPgLDcgA+0ooiSEDMATOMsI=;
        b=jvyxmiyd3T1oyK5A8fGuCr8hPvp0yahEgXtS/mG4McIWHl5sNKmS7Shn2GsoVY1B8y
         cKnnys3X6QXPXD1m/FZrLX+85cFXG1v8K7d/AVETfsgxI8O9b4cDlo7791TSGjfGcGm9
         FwaaoRPKgzk2vgjxxzTCSVaA+2ettyEyxblUJG2oVv+J56heZ79EkoI4FOApT4jF88oT
         kBZgZI9q7042dT4nFDzdXMNRimrOyigOjjYvTwIaUaXTcdm1f2olUXkJpC+LUSTDD6nw
         ColTecOscn5xjQqp/Sm7FmAVxMT/uuTfmEV19v0HCB+UTGowUHASOd4ihzUSdCy0qjWV
         9tfw==
X-Gm-Message-State: AGi0PuZxvB0IiTULC3KpaAPQeHahBY54rXkeDc4szS8gAGIybIeJEdS7
        84SbOPEHVzefs5Wdd92hntM4OL7yJeS3boSSf2s=
X-Google-Smtp-Source: APiQypJcDNLVOuFIzQvUh34bMG7D+zUknyx+/7hXEIrG/1935qJsI7B0n6UbBLgsfIMeJ1HR7hnJCdii+jBsEntvvus=
X-Received: by 2002:a1c:9a16:: with SMTP id c22mr10669363wme.38.1587746629341;
 Fri, 24 Apr 2020 09:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAOWid-dSF0X3pa6ud2-ndYzJdohuOBewfcEZcG7pQ8q=fZh14g@mail.gmail.com>
 <20200424162557.GB99424@carbon.lan>
In-Reply-To: <20200424162557.GB99424@carbon.lan>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Fri, 24 Apr 2020 12:43:38 -0400
Message-ID: <CAOWid-f0dKfZ=bAzLzdt-wCx2C2orYs3RrKi1MrfjO2=jJVyyw@mail.gmail.com>
Subject: Re: Question about BPF_MAP_TYPE_CGROUP_STORAGE
To:     Roman Gushchin <guro@fb.com>
Cc:     cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Roman,

I am thinking of using the cgroup local storage as a way to implement
per cgroup configurations that other kernel subsystem (gpu driver, for
example) can have access to.  Is that ok or is that crazy?

Regards,
Kenny

On Fri, Apr 24, 2020 at 12:26 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Fri, Apr 24, 2020 at 12:17:55PM -0400, Kenny Ho wrote:
> > Hi,
> >
> > From the documentation, eBPF maps allow sharing of data between eBPF
> > kernel programs, kernel and user space applications.  Does that
> > applies to BPF_MAP_TYPE_CGROUP_STORAGE?  If so, what is the correct
> > way to access the cgroup storage from the linux kernel? I have been
> > reading the __cgroup_bpf_attach function and how the storage are
> > allocated and linked but I am not sure if I am on the right path.
>
> Hello, Kenny!
>
> Can you, please, elaborate a bit more on the problem, you're trying to solve?
> What's the goal of accessing the cgroup storage from the kernel?
>
> Certainly you can get a pointer to an attached buffer if you have
> a cgroup pointer. But what's next?
>
> Thanks!
