Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A53A3180B40
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2020 23:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgCJWOd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Mar 2020 18:14:33 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38485 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgCJWOd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Mar 2020 18:14:33 -0400
Received: by mail-lj1-f195.google.com with SMTP id w1so56170ljh.5
        for <cgroups@vger.kernel.org>; Tue, 10 Mar 2020 15:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A0DJ1QWaOzdShQUNy+Xq2LWv3cgxACTM1sGjd/lAyrQ=;
        b=PE12SCsWX0jtdXlLC7s8SBu/WbwEPg5yee5goR2A9E7eXbONG+zY2j3g8MU5gMY4cI
         gpQVYpf4gr8akr8301HuU4d0RZVExceNqTnoiuhQMQQ+S4LimrjudwbtXD7qVESq+I3Y
         YunNWg0f3xQ13/vVv6+VaMcob/DyVA/vCVF3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0DJ1QWaOzdShQUNy+Xq2LWv3cgxACTM1sGjd/lAyrQ=;
        b=tS1cB5sWkJeTvIdfb2g4OCyiYYYQ41z1WfTkJfoUfKUp3D2xiO4cJ7NVZKxRQknpnB
         S+q1l4Ba1f0+gABqxE9HNcAsoLGaHFLSUgq+AwVL0SBep6r9nuHJ69bwPt4NOwyj7odH
         nIXRWvkKYHsmip8ATUNBFyOmxRZSPO0eIHSchWeVIbCfT91846FeEqwrfZ+oeHIvJYJK
         a+JtMK/7f9QoyhvpO2pLF0Lm8HLpY8aVxl/rpI9OOUNcjeqF2W9hxJAKbRd+nzVBPfGy
         1F7cQilppw5CR+nzNQ8C8MVjnGkyoyia+YosNTmvE4Dfw/0ZS2txiB5O+zAJD2AZGpWX
         WUkQ==
X-Gm-Message-State: ANhLgQ2O3Z/IxwkeRkflQPfgdLs57R6AQoS8wt2G8gzt+qG+0nG7U9Rn
        PhRnETP0y992BIqJ1xGBcC/+thLdlQk=
X-Google-Smtp-Source: ADFU+vuwVjAr2XPjWYZntNyuiYd1CjBerLkY4bQKGGegkX09O3YZ5pM7sG2uYGs9kSGzQVpPzgcBfA==
X-Received: by 2002:a2e:9897:: with SMTP id b23mr187280ljj.97.1583878470984;
        Tue, 10 Mar 2020 15:14:30 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id m28sm7858016lfq.39.2020.03.10.15.14.29
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 15:14:30 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id s1so12305430lfd.3
        for <cgroups@vger.kernel.org>; Tue, 10 Mar 2020 15:14:29 -0700 (PDT)
X-Received: by 2002:ac2:5986:: with SMTP id w6mr161806lfn.30.1583878469474;
 Tue, 10 Mar 2020 15:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200310144107.GC79873@mtj.duckdns.org>
In-Reply-To: <20200310144107.GC79873@mtj.duckdns.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Mar 2020 15:14:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=5p6s_BmPAg5EF8Joe5d-6iAjQq6-Le7+xf5Gq-ZTfw@mail.gmail.com>
Message-ID: <CAHk-=wi=5p6s_BmPAg5EF8Joe5d-6iAjQq6-Le7+xf5Gq-ZTfw@mail.gmail.com>
Subject: Re: [GIT PULL] cgroup fixes for v5.6-rc5
To:     Tejun Heo <tj@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 10, 2020 at 7:41 AM Tejun Heo <tj@kernel.org> wrote:
>
> * Empty release_agent handling fix.

Pulled. However, I gagged a bit when I saw the code:

        if (!pathbuf || !agentbuf || !strlen(agentbuf))

yeah, I really hope that the compiler is smart enough to just optimize
that, but we shouldn't assume that the compiler is that smart.

The proper way to test for "empty string" is to just check the first
character for NUL:

        if (!pathbuf || !agentbuf || !*agentbuf)

which doesn't require the compiler to have a pattern for "oh, I can
test for a zero strlen without actually calling strlen".

Also, wouldn't it be nice to test for the empty string before you even
bother to kstrdup() it? Even before you

Finally, shouldn't we technically hold the release_agent_path_lock
while looking at it?

Small details, and I've taken the pull, but the lack of locking does
seem to be an actual (if perhaps fairly theoretical) bug, no?

                 Linus
