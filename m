Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9A1421531
	for <lists+cgroups@lfdr.de>; Mon,  4 Oct 2021 19:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbhJDRfk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Oct 2021 13:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbhJDRfj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Oct 2021 13:35:39 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F40FC061746
        for <cgroups@vger.kernel.org>; Mon,  4 Oct 2021 10:33:50 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id m3so73908858lfu.2
        for <cgroups@vger.kernel.org>; Mon, 04 Oct 2021 10:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UrVxeLwTCLFfP0PNaChfaLyqpPbEUwJEsqImRyts7cM=;
        b=Vynspl7ipG69pEGw9eanD/OkuejKlf5+QISqvuW+GCjSqk9IjptTCbOAeTIRM2DyCo
         PN3iv2aY2mjNTvCPwo15nbbxY6onJJ1fWST+/Hs9+I4UppLkZtjEWpS9nMhjgz0Yn1xv
         UC1MmecKku1nVx9VZWWwjEJyXHuTxkX/yJ7ktyvWm8W/lYynLC58lGFue8oKvkAWqlPm
         Iv5C7g9CDh6kzOyfALYZHl5QJdnaD6KSw5CYXb6QA2NQLBEyeKGl5eq3p13uIZPYAGhb
         3Ma96eTzm6YCju0ycFznX1m5qTHuhIVTFiysRao0591z9aWAIrj5MHynEAFb7L5CunuE
         AmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UrVxeLwTCLFfP0PNaChfaLyqpPbEUwJEsqImRyts7cM=;
        b=EBnGIv/DxlMuZf3Oh7JpckC6RFCyq+wguzBcon7Z2Y4lcczXCT07CqHHkiTq7YIjHp
         ox2sZ4+op7gTqO34xdl4RA8TL0+h7Y0gR3R7mwp0jZiqEvYfBhbHa/8UWtTjhbskIXWP
         nIQDw1Utr7eg4/NmDNm+jjBhUqiVH30xQEOtKspmIR8AfSBgbMvPxsZo+nNtGgFNT4FL
         N8eXzeinOK3kpTaB0zF4A0ja8pBRxRGe+4U59RUX02dw6+s1l/GWHT1FfQBEMIFtTtRt
         Ta5x3Irb2vYZuApwOwc6dmO20medHpmuDnerKDGSxn6HMbbENmph7fWrZLJpQEordVA0
         C5aA==
X-Gm-Message-State: AOAM532v/R9Psi/wT4/1TUlnPLi6xR070mfW6adTDIYlrBsG5RmHxcxy
        3gI7asUT1dzhLwrhEiQsINKxdAEp0N2y6vkSZfkYeA==
X-Google-Smtp-Source: ABdhPJzMwzQrEAJz5oL09+rjZLCN37zpBoFGfEbwtUYbcW/aVrnHJP1hE2F9t1jFHVIvxDIxdCoEFPqJHSmdFav4XgQ=
X-Received: by 2002:a05:6512:2398:: with SMTP id c24mr3652901lfv.298.1633368828277;
 Mon, 04 Oct 2021 10:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210617090941.340135-1-lee.jones@linaro.org> <YMs08Ij8PZ/gemLL@slm.duckdns.org>
 <YMs5ssb50B208Aad@dell> <CAJuCfpHvRuapSMa2KMdF4_-8fKdqtx_gYVKyw5dYT6XjfRrDfg@mail.gmail.com>
 <YVsuw+UBZDY6Rkzd@slm.duckdns.org> <CAJuCfpHprdJWpR_HPSVm6DFEOJj4RWmWC10=ZdGYF_JFAvV+_g@mail.gmail.com>
 <CALAqxLV-tOgBMAWd36sg+bh3s0XXqKWD+P-CYgVXf7Won4auAA@mail.gmail.com>
In-Reply-To: <CALAqxLV-tOgBMAWd36sg+bh3s0XXqKWD+P-CYgVXf7Won4auAA@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 4 Oct 2021 10:33:36 -0700
Message-ID: <CALAqxLUE6D9aUgXQqFJ=qp3f2b6BCjHjP=Je+bo-sdX_qON+-Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] cgroup-v1: Grant CAP_SYS_NICE holders permission to
 move tasks between cgroups
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        Wei Wang <wvw@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 4, 2021 at 10:23 AM John Stultz <john.stultz@linaro.org> wrote:
> We sort of went in a big circle of creating a config time option w/
> CAP_SYS_NICE, then a new CAP_CGROUP_MIGRATE then switching to
> CAP_SYS_RESOURCE and then back to CAP_CGROUP_MIGRATE, and when that
> was panned I gave up and we kept the small patch in the Android tree
> that uses CAP_SYS_NICE.
>
> Links to previous attempts & discussion:
> v1: https://lore.kernel.org/lkml/1475556090-6278-1-git-send-email-john.stultz@linaro.org/#t
> v2: https://lore.kernel.org/lkml/1476743724-9104-1-git-send-email-john.stultz@linaro.org/
> v4: https://lore.kernel.org/lkml/1478647728-30357-1-git-send-email-john.stultz@linaro.org/
> v5: https://lore.kernel.org/lkml/1481593143-18756-1-git-send-email-john.stultz@linaro.org/

Whoops I missed one more before I gave up (CAP_CGROUP):
v6: https://lore.kernel.org/lkml/1481949827-23613-1-git-send-email-john.stultz@linaro.org/#t
