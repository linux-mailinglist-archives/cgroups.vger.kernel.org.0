Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40C83BA973
	for <lists+cgroups@lfdr.de>; Sat,  3 Jul 2021 18:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhGCQXK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 3 Jul 2021 12:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhGCQXK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 3 Jul 2021 12:23:10 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6318CC061762;
        Sat,  3 Jul 2021 09:20:35 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h2so17593883edt.3;
        Sat, 03 Jul 2021 09:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1fwH/bw6YM2VK2ZtZ+qfS4I4lbDV6J5Z7VDXRCzZF+8=;
        b=kjom6xz7C8co4aNRq3MLNCpCMu8G68k59CdktcehnAQmR/Hcb85++xJt7nxZC60RZO
         RS5hUu8jzwKfthYPb1XR7t2+H/49WiYqU0UxIIP50cdZzl/D2ISQmNO22d+u0RSqPHzP
         HP+J8431QOFBmlNCNy/XkPMg3hqVqSRi51ZJbpdEm6gCjkMsXSBnyolRceavcIqh73ZS
         vU/DCTjfSEmvztJ4DEEuq9zARLU6MpQ4d/QEQEic2LJ5/xbJgd5njXMAJRvkKKsie48W
         tH28MCMX0cFMm9NDlDU05S2Yy84KBuU79Y++ZSJ6/JW3QCaX86mhStPVg4gARRTOrT1V
         piGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1fwH/bw6YM2VK2ZtZ+qfS4I4lbDV6J5Z7VDXRCzZF+8=;
        b=MtUMy2FdjmE5mE+fBVTDj9F2YOCqwdH2HSFckyiyIyVGxISe9tx2FvZ7IL98jHsUGh
         vUM3VLkutigGZqkV8Ux++Gd4vqO9lNuBUXGl6rsjYxLk5qB2U/o9zRqPClOVVmaH2CeD
         yPAujGXE7QUsGrf1hRCpyqGBy3R9CGMMI1aGNCdMJAC2ku1Nat296Th7Yx+Dn4EpCgMu
         RO0GOBc5xm9uJtRxcp9L+te0LkZRcfoKNOkYpbvgDDiQJd3LRnctL53tnVqNOvTtCcBw
         p7UEEq+ioOtYQkU4iv6ryhuyWp40/6tUCu+hv7ns9V8s0KdVaMfpM82OaHgEULeWkQpd
         zVAw==
X-Gm-Message-State: AOAM532PatCzC0xkaujXVooVzKBrwWeap5Og+Of5ZqrN8JSfqB4UAEag
        G/2CGIUzw+ITw7LJjm4T+2wArgfw7LRWrX/ywUE=
X-Google-Smtp-Source: ABdhPJzPOPW3EqpRtjT2JSNDs7F2atl1lP9Aq1DUPe62mCaTGmPy5cgHkV7cQP7J0uuUOTIELAqyzK7Yo2ncZ4j2yoU=
X-Received: by 2002:a05:6402:2154:: with SMTP id bq20mr3310642edb.111.1625329233993;
 Sat, 03 Jul 2021 09:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <60decdb6.1c69fb81.6130e.7642@mx.google.com> <YN+Sne76dhKBzV/R@mtj.duckdns.org>
In-Reply-To: <YN+Sne76dhKBzV/R@mtj.duckdns.org>
From:   Hao Lee <haolee.swjtu@gmail.com>
Date:   Sun, 4 Jul 2021 00:20:19 +0800
Message-ID: <CA+PpKPkau-b0df5i4kpJ_RTXW1Fje4Ms0T2hGJCOE31u+BU7zg@mail.gmail.com>
Subject: Re: [Question] Do we need remote charging for cpu and cpuacct subsys?
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jul 3, 2021 at 6:26 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Jul 02, 2021 at 08:26:27AM -0000, Hao Lee wrote:
> > memcg currently has a remote charging mechanism that can charge usage to other
> > memcg instead of the one the task belongs to.
> >
> > In our environment, we need to account the cpu usage consumed by some kworkers
> > to a specific cgroup. Thus, we want to introduce a remote-charging mechanism to
> > cpu and cpuacct subsys in our kernel.
> >
> > I want to know if the community has a plan to do this?
> > What will the community approach look like?
>
> Yeah, we need sth like this to account for cpu cycles spent in commont path
> but caused by specific cgroups - e.g. memory reclaim, net packet rx and so
> on. There were some mentions of needing somthing like that but haven't been
> any patchsets or concrete efforts that I know of.

Thanks for this reply. I am interested in this area because this feature
would be very useful in our containerized environment. I will track related
discussions and want to do some work related to remote charging.

>
> Thanks.
>
> --
> tejun
