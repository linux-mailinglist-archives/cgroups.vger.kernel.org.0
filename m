Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAEF841640C
	for <lists+cgroups@lfdr.de>; Thu, 23 Sep 2021 19:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242578AbhIWRN6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Sep 2021 13:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242548AbhIWRNz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Sep 2021 13:13:55 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EBAC061757
        for <cgroups@vger.kernel.org>; Thu, 23 Sep 2021 10:12:23 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g41so28796369lfv.1
        for <cgroups@vger.kernel.org>; Thu, 23 Sep 2021 10:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i/CxnIoh9vGI3IXe2n3zSyhD1ELxDhirk2SHmfQlOLQ=;
        b=RMG/Scp8QfSxAZON5Uq51XOAc0XNXVcBG2GnnrniXglTgraSBvZ9RTKockwhPH4mGf
         WeyPErky+FsOoPedYN2c7qDYCZw5WhZNubXkskDS/lKdYEHUbPqNnam84t6nOFdacy7a
         Ly9YiJwUacU0hCuahpkwUe3ElAzj5gwsY1c2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i/CxnIoh9vGI3IXe2n3zSyhD1ELxDhirk2SHmfQlOLQ=;
        b=KV/cSWZ0rgq8YkCPjLdFi8pAQQPkZ/9mfhuvsWb43nDvzmxXGtgReOQUWCrxSj0iSD
         QLkCFA4wtjffYXAyE9lrHDlBWqb+XMiCYTuCtGxUEwr3v4B+pnkpwpilE0lDuP13TfDc
         ZE5YcMWvivoIbrwBw6sjR2jhWrpNmcBUchjmi6AoFcFRvvX9xGopb9VKdObbE1gNYmlO
         Ae1YCuHg7T/fpSjkblQSPux5nGMLbMBUvR7fm2SLKjWGROQUFieIEOLA9V7bilKxTtTY
         ONQtaGISyFsq3DJd/RB3QcDKQp3wILyPB2Sy8WSdCYnVwkWG19bgswDtmhoTq7dpeI2l
         uFsA==
X-Gm-Message-State: AOAM531ncShcHHz7esD1HdAakUyMCB4sfrykofX9lxkMYCykm64/5d+J
        DILNehwYPD3fzpFbUpEiiE4rza187FThf2DJ8jk=
X-Google-Smtp-Source: ABdhPJw2UcjNloDmr67/zw+18Itwf08R8Sy7pbHcEedZ10kg3MQfnFUWv3k7bxdjjSRvfqgSK/xMcw==
X-Received: by 2002:a05:6512:208e:: with SMTP id t14mr5192135lfr.107.1632417141417;
        Thu, 23 Sep 2021 10:12:21 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id n19sm651440ljc.11.2021.09.23.10.12.17
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 10:12:18 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id y28so28644820lfb.0
        for <cgroups@vger.kernel.org>; Thu, 23 Sep 2021 10:12:17 -0700 (PDT)
X-Received: by 2002:a05:6512:3d29:: with SMTP id d41mr5080713lfv.474.1632417137194;
 Thu, 23 Sep 2021 10:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210922224906.676151-1-shakeelb@google.com>
In-Reply-To: <20210922224906.676151-1-shakeelb@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Sep 2021 10:12:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=whgL6H0fYt9o2qOVwExZJy_nmZ9=_hTcBUKf=YHXDJVxQ@mail.gmail.com>
Message-ID: <CAHk-=whgL6H0fYt9o2qOVwExZJy_nmZ9=_hTcBUKf=YHXDJVxQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: flush lruvec stats in the refault
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Michael Larabel <michael@michaellarabel.com>,
        Feng Tang <feng.tang@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 22, 2021 at 3:50 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> From the above result, it seems like the option-2 not only solves the
> regression but also improves the performance for at least these
> benchmarks.
>
> Feng Tang (intel) ran the aim7 benchmark with these two options and
> confirms that option-1 reduces the regression but option-2 removes the
> regression.
>
> Michael Larabel (phoronix) ran multiple benchmarks with these options
> and reported the results at [3] and it shows for most benchmarks
> option-2 removes the regression introduced by the commit aa48e47e3906
> ("memcg: infrastructure to flush memcg stats").

Ok, I've applied this just to close the issue.

If somebody comes up with more data and the delayed flushing or
something is problematic, we'll revisit, but this looks all sane to me
and fixes the regression.

Thanks,
              Linus
