Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E57D409A08
	for <lists+cgroups@lfdr.de>; Mon, 13 Sep 2021 18:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240630AbhIMQxj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 12:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240613AbhIMQxi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Sep 2021 12:53:38 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DA0C061762
        for <cgroups@vger.kernel.org>; Mon, 13 Sep 2021 09:52:22 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id g1so10974535lfj.12
        for <cgroups@vger.kernel.org>; Mon, 13 Sep 2021 09:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h7Yl//dy5tlfXJpNjGw/RwytM2u2c4Gl1NK7VqTyQik=;
        b=KNPJ8GcEHSQYCyweuG+VxPhO+NQJEAV5rGoLEtdlZyPcGARXJQ4RTZmYrXPQfJq0v+
         JanZlPaQbOkPRxSWiNI7mgttz1ig7R1UWK98/qdxhmYcIdlNdL9m9uVRXNb+ON8CCUur
         Vi9ROjD9c/UG3PSZEYPWnZvIs+mpSkp1gAPlYOOV1lg1vbFVacUc2xpLTvh/AmsP+JgO
         4CrYqxGaCg/pOU8W4zn7fgOltRuocCUBGyxISE3mCIfbIKI1U3Q4O+bntohv6KwRgW+T
         qOJmtLwKuZdVpRejUHOK+0Qj6SFpB03AyU99MOkQ/8LtIFscGQ+9aG4sMtPZh+ra5Rex
         hqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h7Yl//dy5tlfXJpNjGw/RwytM2u2c4Gl1NK7VqTyQik=;
        b=CR5pID7cDi+sFPJtHcdq2Va74xAuQVdw9MtuzaByay+fE9BRAsMRDk/4DOX8n/t88R
         GO+G2ZDjqurLIwGFXI6x9nFoQfgf8FXX+L2zTF1SIWUUjuGFGQ4xqKqJ3LBHkVZB+bx2
         VdS+Etpn/6kfClupauVfA5ay9l+RoJqm4b/9/INtmxraYzoBjLK6Io0HeWXvNe/vrHJX
         A1V5i3+3hcggXXvsIDIAgq8w72PEju7xlpQUveOPbnIiH4EVn2cvKx+ZVnllK8SXSbOD
         aN19edIdPlE1i+GJlmupooX9Td3Odcpkv0APUZJP8erHhUsO/Lozb6gnA0ibYpEoTPzw
         xbKw==
X-Gm-Message-State: AOAM530zSc1AnxGawwee3GXuVIkWEo2zvWvevEXWI9s0+TPYLMdP5XRd
        k74zP+vTYRxqOSwy2rmjUriqr4UOCkjPMLYccbWH/Q==
X-Google-Smtp-Source: ABdhPJzCAM1ELjBbRxjqidCSeOp6uM/bwe4+ZcMAmINHRMWKcX6tqFGPCAcCIcI3Cvdy9FWpXQH7U/5uwggj7OdIvNY=
X-Received: by 2002:ac2:5c4b:: with SMTP id s11mr9909008lfp.368.1631551940275;
 Mon, 13 Sep 2021 09:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <50b83893065acaef2a9bc3f91c03812dc872f316.1631504710.git.brookxu@tencent.com>
In-Reply-To: <50b83893065acaef2a9bc3f91c03812dc872f316.1631504710.git.brookxu@tencent.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Mon, 13 Sep 2021 09:51:44 -0700
Message-ID: <CAHVum0dmTULvzD6dhr4Jzow-M1ATi-ubDkO5wQR=RQmWtt_78w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] misc_cgroup: introduce misc.events and misc_events.local
To:     brookxu <brookxu.cn@gmail.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mkoutny@suse.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Sep 12, 2021 at 10:01 PM brookxu <brookxu.cn@gmail.com> wrote:
>
> From: Chunguang Xu <brookxu@tencent.com>
>
> Introduce misc.events and misc.events.local to make it easier for

I thought Tejun only gave go ahead for misc.events and not for
misc.events.local.

> us to understand the pressure of resources. The main idea comes
> from mem_cgroup. Currently only the 'max' event is implemented,
> which indicates the times the resource exceeds the limit.
>

For future emails, please provide the links to previous discussions
like [1], [2],...

> @@ -36,6 +41,8 @@ enum misc_res_type {
>  struct misc_res {
>         unsigned long max;
>         atomic_long_t usage;
> +       atomic_long_t events[MISC_CG_EVENT_TYPES];

Since there is only one event type for now, my recommendation is to
not use the array and just use a single atomic_long_t.

>
> +static const char *const misc_event_name[] = {
> +       "max"
> +};
> +

We will not need it if you remove the array in struct misc_res.

Thanks
Vipin
