Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206F342148E
	for <lists+cgroups@lfdr.de>; Mon,  4 Oct 2021 18:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237820AbhJDQ7J (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Oct 2021 12:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237816AbhJDQ7I (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Oct 2021 12:59:08 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75018C061746
        for <cgroups@vger.kernel.org>; Mon,  4 Oct 2021 09:57:19 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id z5so39288956ybj.2
        for <cgroups@vger.kernel.org>; Mon, 04 Oct 2021 09:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=25uBBIA1tJtjRBCrl2+9kZTZSoh3JSnwsuWmdRiH3hw=;
        b=sMaFKtZMy7Lb9v6s8A+fwAAgVLAYKBFj8zIFXbpoSpe+u1jxti9e3ls2YLh1M81V2e
         DxUta+jM+Eq0qo+mwhMsFbOi8O0IYr9vy0WFpgx4Gu3hmdkHsV1Wa4rNGtVUs3m4yzPX
         G8UX9dKhmcywIZr+XjuRX9/jicCUTq5Hdl+vvxm/Ca01CcyAQukkssL9md+12MIz0Q+S
         rb9jFkGZXowUv6BulYMFgzJpx6X8AU8hJv1Ipj7MQPom24gfewwUnA0oN0xOe9LIHimZ
         fSen5G5BLL0QMQ1/taR3zAaqEWn80368BNU4vX87L3ru4KNPekwk5BsLaF6H7H1rKsWs
         xRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=25uBBIA1tJtjRBCrl2+9kZTZSoh3JSnwsuWmdRiH3hw=;
        b=ow84SQqKPHhA6lwrtO3gJW857izLbGjyKCW6aQQQgrXGRfJjEScFnjco3ZKnKbteff
         8P+QYw43M/LP1rCelWigsH35Vd4ujOcEMDQ/vUkib0BLt35DPhJyq+wNV81FTRgpXuF4
         FJ08Ks1vLc7Ig5MHdm470KI79kpL1VbPRGo+MXRUlhvT7HvTBFO++Juh2+BZgGV8mm/t
         wvZKxq7XfzsxNwwDxc/4/kYRZJYrT/I8G2iUCHGB6yy30IT0qes68QuuvMlf1CxgsiqM
         YH9iWy1AFobgd+A8xDBc0bzMK9K7a3P916uURkLF4W0Qs44jtsmb1sqRHBmpQfFf4VNy
         +AqA==
X-Gm-Message-State: AOAM532Oscg86XZtnGtRnTKl+SWXvCdl2OpGjoJca63ZBNn1PAd01SAs
        Oa2LqhKQSYhfEaFw13Uao+qQl1iOeaSpLskxnVUmKw==
X-Google-Smtp-Source: ABdhPJzdbqAc9X4N6Bvy/Z1U+lNQQW8XeC7ZckqW+eVDjfVecolfqXv6w996lV2cxq+C2JJEp6ikL7VHTXtomNz0gr4=
X-Received: by 2002:a05:6902:124f:: with SMTP id t15mr17915053ybu.161.1633366638338;
 Mon, 04 Oct 2021 09:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210617090941.340135-1-lee.jones@linaro.org> <YMs08Ij8PZ/gemLL@slm.duckdns.org>
 <YMs5ssb50B208Aad@dell> <CAJuCfpHvRuapSMa2KMdF4_-8fKdqtx_gYVKyw5dYT6XjfRrDfg@mail.gmail.com>
 <YVsuw+UBZDY6Rkzd@slm.duckdns.org>
In-Reply-To: <YVsuw+UBZDY6Rkzd@slm.duckdns.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 4 Oct 2021 09:57:07 -0700
Message-ID: <CAJuCfpHprdJWpR_HPSVm6DFEOJj4RWmWC10=ZdGYF_JFAvV+_g@mail.gmail.com>
Subject: Re: [PATCH 1/1] cgroup-v1: Grant CAP_SYS_NICE holders permission to
 move tasks between cgroups
To:     Tejun Heo <tj@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        Wei Wang <wvw@google.com>, John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 4, 2021 at 9:41 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Thu, Sep 30, 2021 at 02:20:53PM -0700, Suren Baghdasaryan wrote:
> > Some of the controllers are moving to cgroup v2 but not all of them
> > are there yet. For example, there are still some issues with moving
> > the cpu controller to v2 which I believe were discussed during Android
> > Microconference at LPC 2021.
>
> Care to provide a summary?

Unfortunately I could not be present at LPC this year but Wei I
believe was the presenter (CC'ing him).
Wei, could you please summarize the issues with moving the cpu
controller to cgroups v2?
Also CC'ing John, who I believe tried to upstream this patch before.
Thanks,
Suren.


>
> Thanks.
>
> --
> tejun
