Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9904A7C039A
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 20:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjJJSl3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Oct 2023 14:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbjJJSl1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Oct 2023 14:41:27 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F90F2
        for <cgroups@vger.kernel.org>; Tue, 10 Oct 2023 11:41:18 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c9bf22fe05so5968565ad.2
        for <cgroups@vger.kernel.org>; Tue, 10 Oct 2023 11:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696963277; x=1697568077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ijrsUTj+r62nW8Q1jCkejeshJ7JM+2vy3io9P9umRno=;
        b=YkQdlNQjQ5jm/mF/BTbVGjNbtTCblqI8c0yv69VLu+Vg5WnREhya70vsgqUiZjZwuv
         t+uEjQbq9c+Mz0oRmqaaR978vgpCwoclbBkX5A6rdzPjtix7ZM410sjAW/3R2m3yOceF
         +PRV5UBXwbf7YREwkhpLSxQkLcaGnp9IQXFaGUy1nWBXHbGhgdZg1U4O1z5fhcSa88/F
         wLE14+LQ0VTvZ71eYgGP/Y4Dq+lrSVVcJWW7hho3qcJS3thgys7D5k4WGLaf6oVVQBxP
         XXYohu9xwEuQAzGCdUdVZkNw/EctUptTjwCZ4REkzOx8PuaKDF7t5p1coaUgTI4kUhf7
         +GTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696963277; x=1697568077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijrsUTj+r62nW8Q1jCkejeshJ7JM+2vy3io9P9umRno=;
        b=vjgQnMbXPciuFN6XuzNUi2bK4RSajNSSVoJwlKVfu3aXXpgFTcHhCpWDVDylRa6vJi
         IHOAHDYzevKXARlsKP3J3VGDeOwy31hZoriCQR15G9zIsqnmddiQdAMMJhe88MIWFO1C
         hB56HOD9XxByj2FumfDm0llAt9hVfs4c4xuBKzVpg3G6J6mdePowDkgZvHHhUm+9FeIe
         +eNWyxkIPbzzlfK6rlDKES89StJ2P+wM+qrsLbMPLcfX3jGq2OJR2N0Uk1rHIHUWmXlS
         p0T92BeYcv0rj0j03FVvwiPh1mj/Aoz2a91/n1ix/wJm1FCX9hSpmlOUQhqxAQVmWSKV
         k17A==
X-Gm-Message-State: AOJu0Yx2dwiOisOm8DZ+IdJZlsiY8/83bN56i/9sPhUBB9gzsyHlxx/L
        G4Ewf6/bN+rdqII5HYLcG0Q=
X-Google-Smtp-Source: AGHT+IEtcEMdF1XUIaVm1G3tS8QDoJNv42CVuhjxt5JGhWEZtmRtPTOhT1sCzp4AqAaVEJIkwaXPoQ==
X-Received: by 2002:a17:902:f54e:b0:1b7:e49f:1d with SMTP id h14-20020a170902f54e00b001b7e49f001dmr21681539plf.62.1696963277362;
        Tue, 10 Oct 2023 11:41:17 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:cced])
        by smtp.gmail.com with ESMTPSA id d3-20020a170902c18300b001a5fccab02dsm12178474pld.177.2023.10.10.11.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 11:41:16 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 10 Oct 2023 08:41:15 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [Bug Report] EBUSY for cgroup rmdir after cgroup.procs empty
Message-ID: <ZSWay-22Gh9opIC_@slm.duckdns.org>
References: <CABdmKX3SOXpcK85a7cx3iXrwUj=i1yXqEz9i9zNkx8mB=ZXQ8A@mail.gmail.com>
 <CABdmKX0Grgp4F5GUjf76=ZhK+UxJwKaL2v-pM=phpdyrot+dNg@mail.gmail.com>
 <sgbmcjroeoi7ltt7432ajxj3nl6de4owm7gcg7d2dr2hsuncfi@r6tln7crkzyf>
 <CABdmKX3NQKB3h_CuYUYJahabj9fq+TSN=NAGdTaZqyd7r_A+yA@mail.gmail.com>
 <s2xtlyyyxu4rbv7gjyl7jbi5tt7lrz7qyr3axfeahsij443ahx@me6wx5gvyqni>
 <CABdmKX0Aiu7Run9YCYXVAX4o3-eP6nKcnzyWh_yuhVKVXTPQkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABdmKX0Aiu7Run9YCYXVAX4o3-eP6nKcnzyWh_yuhVKVXTPQkA@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Oct 10, 2023 at 10:14:26AM -0700, T.J. Mercier wrote:
> > BTW is there any fundamental reason the apps cannot use the
> > notifications via cgroup.events as recommended by Tejun?
> >
> This would require that we read both cgroup.procs and cgroup.events,
> since we'd still want to know which processes to signal. I assumed
> this would increase lock contention but there's no synchronization on
> cgroup_is_populated so it looks like not. I had already identified
> this as a workaround, but I'd prefer to depend on just one file to do
> everything.

I don't think we can guarantee that. There's a reason why we have
[!]populated events. Maybe we can find this particular situation better but
there isn't going to be a guarantee that a cgroup is removable if its
cgroup.procs file is seen empty.

Note that cgroup.events file is pollable. You can just poll the file and
then respond to them. I don't understand the part of having to read
cgroup.procs, which btw is an a lot more expensive operation. You said
"which processes to signal". If this is to kill all processes in the cgroup,
you can use cgroup.kill which sends signal atomically to all member tasks.

It feels like the use case is just trying to do things in an unsupported way
when there's no actual benefit to doing so. Is there something preventing
you guys from doing how it's supposed to be used?

Thanks.

-- 
tejun
