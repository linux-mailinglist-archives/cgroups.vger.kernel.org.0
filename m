Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD143B9A0A
	for <lists+cgroups@lfdr.de>; Fri,  2 Jul 2021 02:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbhGBA2v (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Jul 2021 20:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbhGBA2u (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Jul 2021 20:28:50 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9839DC061762
        for <cgroups@vger.kernel.org>; Thu,  1 Jul 2021 17:26:18 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id f30so15055318lfj.1
        for <cgroups@vger.kernel.org>; Thu, 01 Jul 2021 17:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ojivLqIxhJFrg2mkQVdvq8a38GP5yVcK9noWQjWXjQ=;
        b=Gop1h/wC4k56lKH6v1PD4hX8fLfZIhG0emVypz0FX1ztp1MRpep9OiBfP/xoy8jwSL
         lMtYD7BdrUyrOBX7z2ZKXQRrJbheI/TgmVnT3A6NBpVzDnAYUMEC2D/UE+ySyLKwbIuw
         I7HKssIjEStPfibkfy0Zr8vq1CNcrB3092+I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ojivLqIxhJFrg2mkQVdvq8a38GP5yVcK9noWQjWXjQ=;
        b=TVPgu3MyaQEuiRBhOdg0+UWdMYJQDFMsV0Ld9EpWLM5fDyPJeL7lV7BqoMqPSufem/
         uvKZAQdpWjv4MNpf7GloZ74uFV2bMSSSgPVgXgTUGImMuv64LUX7ysgs358+sYlJsNlX
         x6UubNbiMNRpag923yCnueQf5R2zdcVCEQeo7dzCpaN9vEFUzPCK3vnI1+YFLWM88M4z
         dJ3krDKIaOBf2hUaT73EPa77WckqxiFQ7gHMFnvgBiy5IofuXcW3LI9ae0IA5A0zDY4e
         aX187OhZFkyv+ndWMNyLapCopQbMp//UitHCHcGOBNHhgD6QVP6U9EK47bgSNxowxdBc
         uo8w==
X-Gm-Message-State: AOAM533yObEWKaMCrvCrKHGrWfBf5piZ1E+CgWTFQIb1L/VxOa3LfX9y
        LHAI+1ZcdOvet4aOReIUvd1c7lFLiP00dkF2KYc=
X-Google-Smtp-Source: ABdhPJxDh6knKwEwjbtUaupcadSeBmvykr1YUqireBiewlRAdM1LUsRiwQCwd4WEAaV5jbeU6lh6Qg==
X-Received: by 2002:ac2:4e98:: with SMTP id o24mr1686919lfr.604.1625185576734;
        Thu, 01 Jul 2021 17:26:16 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id q5sm111067lfb.277.2021.07.01.17.26.16
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 17:26:16 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id e3so2489123ljo.6
        for <cgroups@vger.kernel.org>; Thu, 01 Jul 2021 17:26:16 -0700 (PDT)
X-Received: by 2002:a2e:b553:: with SMTP id a19mr1574210ljn.507.1625185575823;
 Thu, 01 Jul 2021 17:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <YN4rzCdUR+/2LgaP@mtj.duckdns.org>
In-Reply-To: <YN4rzCdUR+/2LgaP@mtj.duckdns.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Jul 2021 17:25:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgcyjLGcoRho5iw7b3Yx+R05rXwyJmP_LhOqsHgjiZugQ@mail.gmail.com>
Message-ID: <CAHk-=wgcyjLGcoRho5iw7b3Yx+R05rXwyJmP_LhOqsHgjiZugQ@mail.gmail.com>
Subject: Re: [GIT PULL] cgroup changes for v5.14-rc1
To:     Tejun Heo <tj@kernel.org>
Cc:     Cgroups <cgroups@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 1, 2021 at 1:55 PM Tejun Heo <tj@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.14

I've pulled it, but let me vent about this history a bit.

Look at commit c2a11971549b ("Merge branch 'for-5.13-fixes' into for-5.14").

Now tell me how that commit explains why it exists.

Merge commits need commit messages too.

In particular, they need commit messages that *explain* why they exist
in the first place, not just a one-liner that says what it does (and
does so badly at that).

                    Linus
