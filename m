Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC4F1C3DC4
	for <lists+cgroups@lfdr.de>; Mon,  4 May 2020 16:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgEDO5T (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 May 2020 10:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgEDO5T (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 May 2020 10:57:19 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15939C061A0E
        for <cgroups@vger.kernel.org>; Mon,  4 May 2020 07:57:19 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id g10so9967617lfj.13
        for <cgroups@vger.kernel.org>; Mon, 04 May 2020 07:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KXTeEx6IisqAOCmfPVwDlnFlnDkJiSAj9MRHccmyI/s=;
        b=f1O7lCLc9F+EoW79NTRjesPk5eQ7p4Q7MnxAp+szu+ekyG67HHuZaHvrobdUzOqBlb
         yxPAcF6Rs6WCFXCs4xqx5LEJ4GGkKVujqbgVq9W4LCfPYWNecwVz+m0SBfRVrXYINYKo
         yLmS5ygJkWMdj3uUMxFXDwwSobIvM4pzAw1+2UFB5+XOnVwN0y9pLSOq4yTLfyX4xxav
         1BzzHnHZ096oMNL+SaMPBB0D7qGRTnxD13SNoNHNIILeSzitLEO2SFfMC1sVuuY8RJT+
         UZ58sL0B1Mzmxy6NSJbmzTax5111MpmwldblyZhlWiaGY/fMAkXVTB5bSCMQ4i9oDf3B
         nGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KXTeEx6IisqAOCmfPVwDlnFlnDkJiSAj9MRHccmyI/s=;
        b=Pd2vtTw8Cz3mRLd+MeaXMaA/O5po3sDTJJDOEFuTF70BFoFiPUpAEnqdMKz7PEj2pu
         aOrFBocm77n8uraSnG6pBq36CIBL2VRDasqh8dJUW1bD+0uYVl68h+yZYSzwo26yYU7u
         smyNIgdECUNQbx8ApSRC21nGDjsqIF4fM9RJkhHYnmjQZmjx2bxPHf6qpsSZLfkCzrqS
         7ISMHdxakvzb012K0cBnM6XIsDGb8vnQ8GG7Q5SbXAKz7DhoHrM544zsAuMdIUjmaPFF
         EszXHvbc7AiTljACmQiPh6HiKUU7PuecsEMsF+86RagzGvT+NiLmw+lcMQSlvoh6kcI8
         u/SQ==
X-Gm-Message-State: AGi0PuZTCGNfzALez0gn5/Y3YjLFGCncOBS+H5KVXglPNLhQnSStm5y5
        tj/3ovUwZTE4ND1MEVEotTMCzRjB2jcG3RohaMcsuQ==
X-Google-Smtp-Source: APiQypLeWlS/2tJFxpoWroiqoFWA9TyTM5cYPxWBjGApMajaaMz7gQOa5MU4ttHNy7FkO2WJK1Rul1KNGmjOa5S7i08=
X-Received: by 2002:ac2:4466:: with SMTP id y6mr12025645lfl.125.1588604237015;
 Mon, 04 May 2020 07:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200430182712.237526-1-shakeelb@google.com> <20200504065600.GA22838@dhcp22.suse.cz>
 <CALvZod5Ao2PEFPEOckW6URBfxisp9nNpNeon1GuctuHehqk_6Q@mail.gmail.com> <939b6744-6556-2733-b83e-bf14e848dabd@I-love.SAKURA.ne.jp>
In-Reply-To: <939b6744-6556-2733-b83e-bf14e848dabd@I-love.SAKURA.ne.jp>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 4 May 2020 07:57:05 -0700
Message-ID: <CALvZod5T9pYG1xVHqNM=c68jgKPVXtKjuvV0DSAR+Ld_Mm1c4A@mail.gmail.com>
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 4, 2020 at 7:20 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2020/05/04 22:54, Shakeel Butt wrote:
> > It may not be a problem for an individual or small scale deployment
> > but when "sweep before tear down" is the part of the workflow for
> > thousands of machines cycling through hundreds of thousands of cgroups
> > then we can potentially flood the logs with not useful dumps and may
> > hide (or overflow) any useful information in the logs.
>
> I'm proposing a patch which allows configuring which OOM-related messages
> should be sent to consoles at
> https://lkml.kernel.org/r/20200424024239.63607-1-penguin-kernel@I-love.SAKURA.ne.jp .
> Will that approach help you?

From what I understand, that patch is specifically for controlling
messages to consoles. The messages will still be in logs, right?
