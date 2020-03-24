Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD2E191970
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2020 19:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgCXStl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Mar 2020 14:49:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34010 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgCXStl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Mar 2020 14:49:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id 26so3199129wmk.1
        for <cgroups@vger.kernel.org>; Tue, 24 Mar 2020 11:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Bn2txemVnNW3tHUFGp2WOb1jH3UpeSV6hCDyIGrExc=;
        b=RNFkkhe84ZEGayHB8baD92NZqRNYMXvMXE6mRhmjiQa6+aEXFVM7MbYvmyJIdKpcyL
         P0Kt/3R2vW84P4s/9DAgLdNeg35C5fOZkjEhyT13/ZCUR+gG626E0DClz8eIGUTN4nKh
         kPtmyz2MZ8OtHGbxKYWz0+VZ3mQ3xF5qLTcUcbUjDvhp3hca4DAJ/qNdW2MiOi5eR3i0
         RLCdb2fIDqmg5ainr8H58LNrwP4j2Jnrr8FDHiGROvKA7RIu/LOsoSvLChS7sTz6LFpj
         ywjdBuh7EW9/2VFW49Duuk5GS0Htz5fgT9QzmpTW7cYC62W0m/UhGfP0tDnBfRz2EzUV
         K6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Bn2txemVnNW3tHUFGp2WOb1jH3UpeSV6hCDyIGrExc=;
        b=Jrc2lg/zbXs9aRbj4BK6k1xJOvMmK29RD1BHb8+FIbU6tW+V4IcFgArRoNb4O1emc0
         wKBlrJ6ZbepRp8f5u3Ej4/TfhQFqkUREvFyyQ0OYo3wJ9Ko0YCqX9D2YA4LDGAe6hcdV
         nwzr5eb5w+XaEpjoS8D209FaQwzjwsRb05eYK8KMeKfXh7+tfXmPoffkOMRS/+wRxEcP
         Ux2oDDudrIbapLl1WkvsAwCvP48hxjpr20oif352ZQ7Pd2RONnnC01fJEE4lEqowk3Qu
         9iLSKNTIgye4DNT6t0pO9bkxU+tt48hpNHnoPeM377M4nnRcqCUns1F0Y5q3ho6HVf15
         OcjQ==
X-Gm-Message-State: ANhLgQ0XlVJXrit4K1UocDJ7mDbTZ7E3ZM8dwfe/LsI6V1GByBa5H1bl
        8zo+OTEPLe/fpSxt2YzmTFtx398h4i8xTvmkcbM=
X-Google-Smtp-Source: ADFU+vty6Yk31S5LF9YuvRPGLvF8AD8PNX2XXzN0Pdgf/WbZp30NoFPvgvWxHl9AOuzF24qwOvjqBS8ND5KRrr4tzUk=
X-Received: by 2002:a7b:c386:: with SMTP id s6mr7501165wmj.104.1585075779201;
 Tue, 24 Mar 2020 11:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200226190152.16131-1-Kenny.Ho@amd.com> <CAOWid-eyMGZfOyfEQikwCmPnKxx6MnTm17pBvPeNpgKWi0xN-w@mail.gmail.com>
 <20200324184633.GH162390@mtj.duckdns.org>
In-Reply-To: <20200324184633.GH162390@mtj.duckdns.org>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Tue, 24 Mar 2020 14:49:27 -0400
Message-ID: <CAOWid-cS-5YkFBLACotkZZCH0RSjHH94_r3VFH8vEPOubzSpPA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] new cgroup controller for gpu/drm subsystem
To:     Tejun Heo <tj@kernel.org>
Cc:     Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Kuehling, Felix" <felix.kuehling@amd.com>,
        "Greathouse, Joseph" <joseph.greathouse@amd.com>, jsparks@cray.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun,

Can you elaborate more on what are the missing pieces?

Regards,
Kenny

On Tue, Mar 24, 2020 at 2:46 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Tue, Mar 17, 2020 at 12:03:20PM -0400, Kenny Ho wrote:
> > What's your thoughts on this latest series?
>
> My overall impression is that the feedbacks aren't being incorporated throughly
> / sufficiently.
>
> Thanks.
>
> --
> tejun
