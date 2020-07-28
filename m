Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C82E230CEB
	for <lists+cgroups@lfdr.de>; Tue, 28 Jul 2020 17:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbgG1PEL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Jul 2020 11:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730518AbgG1PEK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Jul 2020 11:04:10 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85195C061794
        for <cgroups@vger.kernel.org>; Tue, 28 Jul 2020 08:04:10 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s16so6274487ljc.8
        for <cgroups@vger.kernel.org>; Tue, 28 Jul 2020 08:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y/P1RjJpCb35GTdXwmZama92miIfq20CiqjQcC8AgAQ=;
        b=r2hUeavOspQPDYUPCBYkcJ2t+SMHCVWUjhVCsn95Ke4mIVcywTVe3IycEi48ReFcwU
         kcAOO4zPa99rNHCsHrWLtD4PXhyPCUyPjdEP7NYt3nvm6ux90bPxF1FWXFiyakhvkdkO
         VnOh0VAy/vHFlRk7yxNZKDWh+hlim9Bu5/Ou/OLzZclgir2QQrrtAFl89Rm8azwsMtvy
         bjqK7LiMwhx43GT7gM6KUsyOcNHjLhKYiMBjFxnZga7trt3rZuSkz4MImI29UhrVr7tV
         BsLP4fsDZpp6Mz+5Zk0E9362Kt408Wx7KJyjNDFq8OmfFzxE+bdGWKGRvhP7xee39zg1
         a6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/P1RjJpCb35GTdXwmZama92miIfq20CiqjQcC8AgAQ=;
        b=OY40qOjTRbuow8FI1gyBQIQIfM07gQWpjZMU8CRz93LL/3Q/U3+c0Hwyr1JuRhpdek
         2TxknIndR+3Y/yYVHUmyyKLXrF8AxYDxE16SErsoMle0/RuB7g9EFJU0451lthPM9EpZ
         DiidpQrM5alfe/XuCn2dJ8XJCxwi0yofwEjMT3q9wyiud2rV+ZZDW95KtoP97fl4ezsc
         mtn5Flb0dp8s7bcvDT1iyQ8yI0uGjStJZ4EpkNZJKgEJkLpHQbMa93910lZzexnV0I6D
         49BIscF/JqqEra5AzzDkt1R6VxVqF13MSd6HUBn9/XQlG0o080kftGiY62h+9T1N3+jh
         QK4Q==
X-Gm-Message-State: AOAM5303qSprk2ERKnOljiYTRUxBZ+8Mpe7IxKHNusFl8fGEMB1ccv8O
        s3uD0huxtWsgbEru/SKU4AAeGHEiAhWb2y5FPn/BCg==
X-Google-Smtp-Source: ABdhPJyBtXIozdbRd6lEJqYK3D9Y3Dhz5EcMC+1cVuW0HGWZuwxdBZ1H2dci/1QsDlmowJpXZTB1/6V9w3F9GuQ7V0E=
X-Received: by 2002:a2e:9996:: with SMTP id w22mr13868230lji.446.1595948648596;
 Tue, 28 Jul 2020 08:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200728135210.379885-2-hannes@cmpxchg.org>
In-Reply-To: <20200728135210.379885-2-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 28 Jul 2020 08:03:56 -0700
Message-ID: <CALvZod6X1QNvxZB-5oUaY0CeZENz-K04bSnx95M4JpUcvKh0mQ@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: don't count limit-setting reclaim as
 memory pressure
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 28, 2020 at 6:53 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> When an outside process lowers one of the memory limits of a cgroup
> (or uses the force_empty knob in cgroup1), direct reclaim is performed
> in the context of the write(), in order to directly enforce the new
> limit and have it being met by the time the write() returns.
>
> Currently, this reclaim activity is accounted as memory pressure in
> the cgroup that the writer(!) belongs to. This is unexpected.

Indeed this is unexpected.

> It
> specifically causes problems for senpai
> (https://github.com/facebookincubator/senpai), which is an agent that
> routinely adjusts the memory limits and performs associated reclaim
> work in tens or even hundreds of cgroups running on the host. The
> cgroup that senpai is running in itself will report elevated levels of
> memory pressure, even though it itself is under no memory shortage or
> any sort of distress.
>
> Move the psi annotation from the central cgroup reclaim function to
> callsites in the allocation context, and thereby no longer count any
> limit-setting reclaim as memory pressure. If the newly set limit
> causes the workload inside the cgroup into direct reclaim, that of
> course will continue to count as memory pressure.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
