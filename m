Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1CF43D830E
	for <lists+cgroups@lfdr.de>; Wed, 28 Jul 2021 00:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhG0WdR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Jul 2021 18:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbhG0WdQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Jul 2021 18:33:16 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1709C061757
        for <cgroups@vger.kernel.org>; Tue, 27 Jul 2021 15:33:14 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id h14so179021lfv.7
        for <cgroups@vger.kernel.org>; Tue, 27 Jul 2021 15:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1yVpnPDg8qZ7QPNZ+sfyroUAmvgOf5UoKJwBpXAopX0=;
        b=OVCobrnJ9+14bQ5fvgtof3vhnIr4IT+0De+FCovxI2+3wi6Zl8VVVHPuEHpvZBYC3H
         O/PsQdOtJCBsopByBERz/BrgdkP/0bvKhrcaeCI+IkyYjM6nKaxnJ92cAOehFMFyRhnS
         4j4U4dBe26WhX7BBdXBHd8afriot7wv+rG8kUS2E5itT1uNH07WjlP/7cdRbflQrj9xT
         zTa/flnhPm41oD2H68OH4/RmfYKQuR6kVeS9U0qV9hODFBYHa/tQPv0liv9K5zUXCy8A
         e3XI9UEyyTUQoKdDpu+TFLWBSzIS8RpkRDBkzt+bOKLDkE3NVY32PQ+/kxG5UobsaEPe
         xn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1yVpnPDg8qZ7QPNZ+sfyroUAmvgOf5UoKJwBpXAopX0=;
        b=lrV04HjIe8WduIn/dEeEXvKexHWQjIscX0aZHAw8qu2wFAxR7L15jmvOoYG/X4JKWg
         /Iox5Q4hvBrWFUl6huQO1tw5UcB29PAv24hWs5lB8+l2v2Y56T+l4wcJR6EXJJJHKknI
         0WMB/xSe+UE2t1ev9WVbPaOQUZCujpparYV45sumQhBkdq9gFm2IWJMZXdX3BxUyX0ut
         ox75w7UYFC8Au8my5QBDq8KwOKm7A/gWuaYEVX2VXG1Zv6tn0ccooQkgRo5v0nG/Xalq
         TXsdtujetOk4FT/jU3rmCRnOoAdXyEFsMci7nQf33OaF/D9OJZXpJV9gyZuJcEXNRMYu
         Z2og==
X-Gm-Message-State: AOAM530yPetmO2rXNgkLBmvLRa8Jx3ckvBnDc+fKKv6N6jG3nShZ9fX2
        x0DYJAYIITM2MfQNdGXHCjPW38Lf7PY90vDwxmBBoQ==
X-Google-Smtp-Source: ABdhPJyMHuBAUGf6ynhlMX/YL6/3vFZ9PSZWYkO3rzjh75CV5+X6Tls0KzSSs8LkEJ98WOUitKvga4miydT5M7KdyOU=
X-Received: by 2002:a19:dc50:: with SMTP id f16mr17867859lfj.347.1627425193113;
 Tue, 27 Jul 2021 15:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <6f21a0e0-bd36-b6be-1ffa-0dc86c06c470@virtuozzo.com>
 <cover.1627362057.git.vvs@virtuozzo.com> <d6507b06-4df6-78f8-6c54-3ae86e3b5339@virtuozzo.com>
In-Reply-To: <d6507b06-4df6-78f8-6c54-3ae86e3b5339@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 27 Jul 2021 15:33:01 -0700
Message-ID: <CALvZod7w1ab+EDfYBU50KBg2JkB88ijanCakUiTLdWFZ8Hc0oQ@mail.gmail.com>
Subject: Re: [PATCH v7 06/10] memcg: enable accounting of ipc resources
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Yutian Yang <nglaive@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 26, 2021 at 10:33 PM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> When user creates IPC objects it forces kernel to allocate memory for
> these long-living objects.
>
> It makes sense to account them to restrict the host's memory consumption
> from inside the memcg-limited container.
>
> This patch enables accounting for IPC shared memory segments, messages
> semaphores and semaphore's undo lists.
>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
