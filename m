Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E3D3D8220
	for <lists+cgroups@lfdr.de>; Tue, 27 Jul 2021 23:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhG0VwA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Jul 2021 17:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbhG0Vv7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Jul 2021 17:51:59 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C24C061764
        for <cgroups@vger.kernel.org>; Tue, 27 Jul 2021 14:51:56 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id d17so117849lfv.0
        for <cgroups@vger.kernel.org>; Tue, 27 Jul 2021 14:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LklRqbXMTEN/3IOARnfGCTnT/yEZVFwCJFDMkmvyYVo=;
        b=AbNu22X3Nmx8X2h+2ik7T5v6bU+CsbYIGQapGfDjCY/3r1jS9dwjHMGAsireZtJIzA
         W6vzg/MECVRzb0M3CzcIvMUeqvE7OFHKjzUu9Vc8EciMK4M22Lalr1SoxpUWAdaS0jas
         trp6Y9wm5/8rQ99XmOCezferLz9rqJpSR4qHfjYjK/VTc3I7BOoBPi0fzC9EwTD/nYHV
         8dAu/luh9QT3BGhD0+VcybrhasaOcPPohqRydoP5y/Vo5wWXp7PD1EhvztG+D5sonifC
         yAelkaCCnK3W8KrUX9cPBHBrruaxk+BOade7OJ7ssi7N40oIgkFN4GjiGFhdx1Vp7uI1
         EVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LklRqbXMTEN/3IOARnfGCTnT/yEZVFwCJFDMkmvyYVo=;
        b=j5kZFnMOp36TXQfxbYUvYbv86UAREGIAlOSXrteLTwA6UCAM7fp5SUowxwHF9+m08f
         nQx8/Jv63cOWLcv55k4f+ArbGlzI125YC6A0OGjMqdxVV+pdE1d/r3gw05jf3ZA7z0PU
         +0l76QnptrYbvNgNZ+eIoppgPTc2GSLXkB/FsxfGPazGMSH+JxYIlqjOuE12X+HZq7Sa
         7zuSlEDQKpJd94wUYs55oM7RkU9aJsww6qJljqDlUeC/qhQkRI6oExtuW5XEzQnno8QX
         fz2ilofT4OsQhmmLxkgMu1To5SzlCbsgYcmpHtG0pNQoNuSNoJHotY/rGRlzpOLWEVSn
         M9kg==
X-Gm-Message-State: AOAM530SE2Ga3VCBAQCFeO/tDjol5Q2hS9xnJ6yMExhX0rJgjkaGrlhS
        M+V8lhPf9c62izlKdFnLhqkt6xjzYt7srvarx+ix5g==
X-Google-Smtp-Source: ABdhPJyiTzH35Mq19nPcHN5BCC0dltSH+g1FJkcA9lyijpawno1XuHgUeOU54nM7g+YaoRlnu+709wB8lfa9Tl7tdvs=
X-Received: by 2002:a19:771c:: with SMTP id s28mr17640254lfc.358.1627422714605;
 Tue, 27 Jul 2021 14:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <6f21a0e0-bd36-b6be-1ffa-0dc86c06c470@virtuozzo.com>
 <cover.1627362057.git.vvs@virtuozzo.com> <5525bcbf-533e-da27-79b7-158686c64e13@virtuozzo.com>
In-Reply-To: <5525bcbf-533e-da27-79b7-158686c64e13@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 27 Jul 2021 14:51:43 -0700
Message-ID: <CALvZod5tfepT51EgUVX_Xq=2UykpGehNE5K3+K12OCwymi=-vQ@mail.gmail.com>
Subject: Re: [PATCH v7 05/10] memcg: enable accounting for new namesapces and
 struct nsproxy
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Serge Hallyn <serge@hallyn.com>,
        Andrei Vagin <avagin@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 26, 2021 at 10:33 PM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> Container admin can create new namespaces and force kernel to allocate
> up to several pages of memory for the namespaces and its associated
> structures.
> Net and uts namespaces have enabled accounting for such allocations.
> It makes sense to account for rest ones to restrict the host's memory
> consumption from inside the memcg-limited container.
>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
