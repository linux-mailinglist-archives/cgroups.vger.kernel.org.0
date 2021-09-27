Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95587419820
	for <lists+cgroups@lfdr.de>; Mon, 27 Sep 2021 17:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbhI0Po5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Sep 2021 11:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbhI0Po4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Sep 2021 11:44:56 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED74C061575;
        Mon, 27 Sep 2021 08:43:18 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v18so35805915edc.11;
        Mon, 27 Sep 2021 08:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qlcc/wRWjVCOzhNQn26TjPzzhllhlD0uZ0dcQsuvCOI=;
        b=Lghy197Op89Rz0QE1V1paJ2AHKVKbUHzvBosZt1g8cXNl6MJHK/V6ghe98wvxn63o/
         QLFPsjs2Mpgd2/ucdkJCvIpCb7tOi6ANPHQhn+Q1WQ3Eg7KjVHjdV2VQf1v3Npw37rMT
         q+d0a0jEsyDpdCoZ4DYaBU2FXVCjOI594qb1W28eeDT+KLiD0l2TTubBJhPClZYoUkv0
         ISc8vfyS/oLmUOEoRzsJbMpRNO1rH5XkT2MomxVAQIVrtiAsPP7AxytwknXsXSyqSCTp
         iXLaOBDiqnxtr+93ZrB4eBoZMqhaTFy683byNwuqRZdHmvsn4a+dNmf1ZHYXER0zA/z1
         EiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qlcc/wRWjVCOzhNQn26TjPzzhllhlD0uZ0dcQsuvCOI=;
        b=NM/F0PQ3Zs/1t2TbdCiT9g45Gh7gfVSCvcwjAWaSAUSSFIaE1OfSaytjM9uN5tpTEh
         IL8IOxCuJiRSpxmyUKZgriZuW+J22fdWESKWDVR2KtMt5sfyb9Rei5jMq9TgaHl99ahb
         7A8RKTCjCgWIoCJpmclXz8MRjmKXVno9XftBDaPRccq4prBit5WGIxDjLGg+9k+wt8Tr
         Z30O07ZXWvt/AJV6oM05XFNNDTdt5cQYOoIwIMRWcWrWlMxn/TGPIqJYEByGHgFNfutL
         zZY0KFgfBkNtH1IWlJGw3hkoXLsJk+LIH372IYu7/Qj6L+5PjnZANYVksO/mqVMZXh6D
         LXSA==
X-Gm-Message-State: AOAM531MQGXIuhqd9vB/Hz/gM2oIwetSKjggs2pGHdoUvp0NZgrDmbZJ
        HDmAHlE15C96yrWZP7XXqGlsZ6Af1xoWqMD0HLNxfR0n7nOI3jxKd7Y=
X-Google-Smtp-Source: ABdhPJyKUgNX6q8A9OFWfs8aafkwaSLkZiwFkY1IcplIO/jcXHLp97dpI7QrIEK7XayH//+TkEPo9I4yELzE/91anMY=
X-Received: by 2002:a17:906:7848:: with SMTP id p8mr785872ejm.212.1632757396643;
 Mon, 27 Sep 2021 08:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <1632491065-10785-1-git-send-email-wang.yong12@zte.com.cn> <YU3ciRm7L2p9lJo6@dhcp22.suse.cz>
In-Reply-To: <YU3ciRm7L2p9lJo6@dhcp22.suse.cz>
From:   yong w <yongw.pur@gmail.com>
Date:   Mon, 27 Sep 2021 23:43:04 +0800
Message-ID: <CAOH5QeBA7+W3Pc6z50mExv_3Zoh+v_4wrxweiRBsnsXN66gOmg@mail.gmail.com>
Subject: Re: [PATCH v3] vmpressure: wake up work only when there is
 registration event
To:     Michal Hocko <mhocko@suse.com>
Cc:     Tejun Heo <tj@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        wang.yong12@zte.com.cn, Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, yang.yang29@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> Your data still doesn't make any sense. I have asked about that in the
> previous submission and you haven't really clarified anything. How come
> your task-clock has almost doubled. You are likely not not comparing
> apples to apples or something weird is going on.
>
> This patch is not going to fly without a sensible data and analysis of
> that data.
I see. I'll try to test the optimization again.
Thanks a lot!
