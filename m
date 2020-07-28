Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA71E230D0F
	for <lists+cgroups@lfdr.de>; Tue, 28 Jul 2020 17:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbgG1PH1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Jul 2020 11:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730687AbgG1PHX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Jul 2020 11:07:23 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAA5C0619D2
        for <cgroups@vger.kernel.org>; Tue, 28 Jul 2020 08:07:22 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id j22so5294269lfm.2
        for <cgroups@vger.kernel.org>; Tue, 28 Jul 2020 08:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MqKK7cF3q5e7l52iOkJoCa4f73ZLky3ZxfyYCXCSh3Y=;
        b=fOFXTXHHi/1EGMPH8IGLT8Q44caG1seCiZf4b2tdKys5AN6daPLz58LLMJX2ebJ/cc
         AQWC5c4ocJTpnfJFPSoc9f2APOdbHKeBKRbmx26YbLYcFgcQ4x8dhAWpuF+7u2iPFY1y
         hcTYR5Ha1vBv1AOWloZ+DogIi8d6LX27zvjrDSpvIvCtx8hdJDz/dP15WzCSY/sO3Cnr
         +E4ZT8HUyUEWOz8342hH7kQ4UBQzZQ8DX3y2lVOe3wKTNsIC83j0ioCKaKTmjKmgg2ZL
         /voZUK3EQaTO8pYbpQ6KZXZttUyFTwVzu9WJ7YQxGnR/PgyJd7V01NwF5FUNLNdykiPk
         41Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MqKK7cF3q5e7l52iOkJoCa4f73ZLky3ZxfyYCXCSh3Y=;
        b=bx8YslbL/PkQmha9SqhSX692pplMTx/7XcWiXw+gvsJ0Cf1wj/k+LGykRsLVCntGw5
         CWDk/LsHOBMMJ8qxyal4b47aa8z9SFRkih0AnDkj1UJS9v7Lm65GlfZhO/i5Seshg833
         QT15+AVDJ628gE/cNdHv4qmPMu7b6uO9ExMWeW7wUvqF6TrRn0jQtuEW8522GRiK/S7b
         r5uJAH52Ihx3GcNA/6C07PbgoF2ZOEnvgejLc/jZFIunLjxCtWaPjxIuKWlicEgVFh1F
         iInessbYF9OILSkkWhBrqTP8nYxIC5l/5oN4cJGdTU8xqapxlb5bhyKOSm8ZGFxlZiAP
         /wXQ==
X-Gm-Message-State: AOAM532YIo2+7Us15h1JILFAZrqTCkDInG3o5orMpn4kixE3QLnaqxOa
        0DSjW0BXUQ8byzecoB6PWHHXoTXJIp2qYY0XeXncPw==
X-Google-Smtp-Source: ABdhPJwIh3m74SedjEVVOSC5JheogTUjYarQ9WQzCix4/nEg36/t3dfTMvCQXXbABOOu0en98FtXPHRAOIdXI5/E5V8=
X-Received: by 2002:a19:c68b:: with SMTP id w133mr14432710lff.189.1595948841057;
 Tue, 28 Jul 2020 08:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200728135210.379885-1-hannes@cmpxchg.org>
In-Reply-To: <20200728135210.379885-1-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 28 Jul 2020 08:07:09 -0700
Message-ID: <CALvZod6nFiUvcCViwwiHY9x5xw=JCYM_NUOQCkLMeLD8-JNCaw@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: restore proper dirty throttling when
 memory.high changes
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
> Commit 8c8c383c04f6 ("mm: memcontrol: try harder to set a new
> memory.high") inadvertently removed a callback to recalculate the
> writeback cache size in light of a newly configured memory.high limit.
>
> Without letting the writeback cache know about a potentially heavily
> reduced limit, it may permit too many dirty pages, which can cause
> unnecessary reclaim latencies or even avoidable OOM situations.
>
> This was spotted while reading the code, it hasn't knowingly caused
> any problems in practice so far.
>
> Fixes: 8c8c383c04f6 ("mm: memcontrol: try harder to set a new memory.high")
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
