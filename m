Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49F67B8DAE
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 21:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjJDTwq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Oct 2023 15:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjJDTwq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Oct 2023 15:52:46 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D65A6
        for <cgroups@vger.kernel.org>; Wed,  4 Oct 2023 12:52:42 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-533d6a8d6b6so281670a12.2
        for <cgroups@vger.kernel.org>; Wed, 04 Oct 2023 12:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696449161; x=1697053961; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JXynpgCTKK8jZhLw1V8+I4O8oGJ7CDr8iiRthCZh7tg=;
        b=hS6Xa0yhjX06Bz8TOcWBQ5CZ92JuGHnvO7a4qFvRqSkp4+5eh7cUlBdSeWzOXnwEFo
         N1jJWhghxYrLQss1oDUYrzoyX4rmfCZQp4eT9JpJqcs/gKQDrih5W8ObWnBpM4le6A93
         ttOwEoQnYp4DFK29n+8G5PI1nxnnII2UjiUCGPUjRLmD+nS0Bg59LyaFCkIdYvB0HwMU
         IGS4u0AqoCZs18Ln5w3YJJ0i86hZcMmOfUQhiS6WKLewtWC+2Ra07CvdlrLBkC+wvxIK
         sRggnr3CNuZJ4c0Goxjb+XW+CIBMGiTOt2RqNY6yAUGQb/JShNWxUyKTeYG5LvaBPnVi
         VTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696449161; x=1697053961;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JXynpgCTKK8jZhLw1V8+I4O8oGJ7CDr8iiRthCZh7tg=;
        b=CvlnbpgOLv+QHDGJsVZlR6uL8zzM4rbncNAdpFWGNcLpn7+lKQfUm2pz5s/kjTeNSM
         7Mq08oqcF4jJbZ1CSWqmrl6DqIV+qWFmGDwLQEmuSMVnDP8f4j1M++78f1lx17ziAqbm
         g/YN9LHhvC7gu0kLiuMKN2nc/9A4qnS3+a+0XmQGY9V+FcftWFNSz+sLVG4W9s2j+ZiB
         CP+NtyJgy/cEV0cdj+q/FjgMiFNM12kY3NdkL1Vu8PVsv9N/7BRxK028yYY5KGP2ePFB
         n+c3OVThM1tqroH+HJ18mOQ1U3kUjSRGp5Xz/cs95RF6wYeXHQeh7ZVmuCa7bA24dGwP
         3pMQ==
X-Gm-Message-State: AOJu0YxfIccxffxmLK1M97h59pyD9qoGbtF3zCWTwiJq0WyNoXokfcIZ
        OCbPoK5VYxsRKssMYL3j7AAI7/qO2MTI/tjj2mVZR2lP1h4=
X-Google-Smtp-Source: AGHT+IFLNPY0oKS1hCge+OrfPpfmeUDIBBjzut0w9qh79GDtWA/JJoc/qJeBIZ9lXmGv+jv8TdoL5/oX2vLuFW2jHqI=
X-Received: by 2002:aa7:d757:0:b0:530:8d55:9c6f with SMTP id
 a23-20020aa7d757000000b005308d559c6fmr2850874eds.2.1696449160518; Wed, 04 Oct
 2023 12:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAOv3p80vCV1_FeynQ_sZhzYbif_-4k4odZHex9NbhzuZ204gLg@mail.gmail.com>
 <ruokbytamh5n456ufqteijolzper3jhhhitjtwrhrguz3svkf2@ddszugmaypvz>
In-Reply-To: <ruokbytamh5n456ufqteijolzper3jhhhitjtwrhrguz3svkf2@ddszugmaypvz>
From:   Felip Moll <lipixx@gmail.com>
Date:   Wed, 4 Oct 2023 21:52:28 +0200
Message-ID: <CAOv3p83SCJEEK2Obh4s=-WPoqAuktYeAQxPF8E-c2QJD7pwtdQ@mail.gmail.com>
Subject: Re: VSZ from cgroup interfaces
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Michal,
Thanks for your reply :)

> Virtual memory is a per-process resource (if you consider it a resource
> at all and if I understood what you mean by vsz).

Well, I understand it is a per-process resource as any other field you
can check in /sys/fs/cgroup/../memory.stat.
The concept I assume for VSZ is the same as read in VmSize field from
/proc/self/status, the virtual memory address space size of the
process.

> It is not well defined what would it mean if you summed up VSZ of all processes in a cgroup
> (vsz of one process is not exclusive to another process's vsz).

Can you develop on why you say vsz of one process is not exclusive to
another's vsz?
Technically, the sum of all VSZ would give an estimation of how much
memory a set of processes might try to use. I think that's the same
idea of VSZ for a single process but just for a set of processes.
This could be useful to detect memleaks on a program before they
happen when you see a huge VSZ.

> So my answer is that doesn't make sense to account VSZ via cgroups.

By the same rule, why does it make sense then to account for VSZ via /proc?

Thanks
Felip
