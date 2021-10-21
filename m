Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D2F435A00
	for <lists+cgroups@lfdr.de>; Thu, 21 Oct 2021 06:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhJUE3h (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Oct 2021 00:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhJUE3g (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Oct 2021 00:29:36 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C1AC06161C;
        Wed, 20 Oct 2021 21:27:21 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id g125so12250813oif.9;
        Wed, 20 Oct 2021 21:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p2FMynZOQufRpN0krg/fWL4lMAv54qnvK4coLS/EU4A=;
        b=AqSwHZhheu6j2y/Drfa4RgRI3nwNY2JKuGqCu+Xx++xkG4AObI86htgIpb57nuwjpN
         wu58Sl0HROuB1uMFrz9fZGGghx0tn61tA7J6/V4zbmEvfU8oqpJU9p+DvTzh0mhmiYbU
         auiGxnA2iTeL/UqkNEe20DJlf8dAnKOFjCQGqW080T8iYVdvoJRPZkHnrYJ8CoYNSdTL
         2XF+EoOs6rFjGodSO21/dQlXJbzIbNTr8Z+uzB82Sy7U32uTZbkS5ZdfAO45qrDVpnve
         3163bDwWERrIm+W++Z7OjZItL5Z8Uu6xdwvQhIs8adJ2LtA6w/h0+llXAs/D4ENlZbBS
         kvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p2FMynZOQufRpN0krg/fWL4lMAv54qnvK4coLS/EU4A=;
        b=erEjSZkLWxO5WZSi670DkZKNo63xIOL7BJ1BIb4AIkdFL0OQun17/uUuCoZMHA6QCl
         ROXfkQqMM7hVQ1QOwXGfT56S+SKjBsl1DvPSz/0Et67qvuFWriZekEBynwSdD3p/am+z
         mfMP91iJVfXN6Z2+TNwdsyXVls2iPfWI+z412Os+MF85/9hA7IiOObUfRH2jWKVhYQt1
         ROuDb5j74A0q693OxbxQ2L/rSkpA6Fu5QgVxnlNUnSOGmZBCk57huzojUuzA+Do5CQHu
         aEsJX2KAKa8lS892FcgD0HseAxJzzG6lxnF0DIPkRK4lTaj7F3AHoBqUMrLc1txADk14
         ndXg==
X-Gm-Message-State: AOAM53254u9LG+mZoUXhJTlalJjEgPSGCGenToCkCsyX++SzZivNhwWL
        /3ceBqNsrrzahthIOCb/tHvIri5TYKOIj+nry6YTB/IlnL8=
X-Google-Smtp-Source: ABdhPJxSoPGbHjks7D1ifeY43HZk+BwpZCvHxXYjxf0lakr0CAkF6qOoSL32lwbfSJnYQanWn6fe6IBYP+qtbvfb/oM=
X-Received: by 2002:a54:4381:: with SMTP id u1mr2404872oiv.49.1634790440469;
 Wed, 20 Oct 2021 21:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAEKhA2x1Qi3Ywaj9fzdsaChabqDSMe2m2441wReg_V=39_Cuhg@mail.gmail.com>
 <YW8EVVmrQpuiwyEC@slm.duckdns.org>
In-Reply-To: <YW8EVVmrQpuiwyEC@slm.duckdns.org>
From:   Youfu Zhang <zhangyoufu@gmail.com>
Date:   Thu, 21 Oct 2021 12:26:44 +0800
Message-ID: <CAEKhA2yENaRmCXaEYZFp_S55BnJxm51LwL7AbN24DZ7OpsUDag@mail.gmail.com>
Subject: Re: [BUG] blk-throttle panic on 32bit machine after startup
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> This doesn't reproduce on 5.14.

I can reproduce this bug on 5.14 i386.
I ran the reproducer (slightly modified, sr0 instead of loop0, 11:0
instead of 8:0) on Debian installer live CD.
https://cdimage.debian.org/cdimage/daily-builds/daily/current/i386/iso-cd/debian-testing-i386-netinst.iso
I posted a screen recording at https://youtu.be/ULdoHizTi0k. Please check.

Thanks.
