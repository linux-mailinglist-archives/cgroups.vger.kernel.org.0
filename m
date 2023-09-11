Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BDF79B361
	for <lists+cgroups@lfdr.de>; Tue, 12 Sep 2023 02:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358584AbjIKW0H (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Sep 2023 18:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244410AbjIKUYj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Sep 2023 16:24:39 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CAE185;
        Mon, 11 Sep 2023 13:24:35 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68fb85afef4so1397986b3a.1;
        Mon, 11 Sep 2023 13:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694463875; x=1695068675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=teqXbckacJlPukkv2EFTdTd3A90eXZl+lHL7XzD31Z4=;
        b=DpHY+9vxUaEI1Fad0tiIOzAyr/aptpRy9NijKgVkqLrFb1xQEx7GrBafGOfgVJXH9m
         yDLjnGpm5+OVPTEVBZqh8KMhLeczjGF4vXJ7yCK8pSe6+z6ltjSFevu8+tzlyNGymPeC
         vlWOUGzjsrdT6KPv00in7cGpDHELyMxr80pqaA643YDy9KPnek7VKG4WsSCtwPMyQAmQ
         BAJnl9ALyV6zFmkATx7VhmUdK3JjtnAeiMjPejypMkvnphZNyDoUfrJixEyhLarjNUHa
         dKcrHOMSUuD890STU9dINFvTI74jm7xxPrt6RCt5rFWTf39n5Vu60bws/TuKqYRkwTEi
         TfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694463875; x=1695068675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=teqXbckacJlPukkv2EFTdTd3A90eXZl+lHL7XzD31Z4=;
        b=kmmefLoKCxf0F2xTXyoOFzr+eNhTnBeKcRk1HVZDsPd9LAFyTbipMY+pohM2sNV+qg
         0et+y3i/dTY9NXi5lC+XUCQiNFlFr+V3I3bOm0cgMMKfOS50NvY71L5IV1Csnz4e3wsQ
         oZ3usAnLZDxR4ReWlwG02fUJEjQ8DnUBjhdmNAN1yG+sjnHcKXzRb2QZcnr51XWikuO1
         TWBV60cJwT4ted5fNGz68MtSYE8A6ZrDAVirbG9cIO1ORpCdeeazr+RUOfqwyJKQCpDg
         Lglq8uHV8XdKIJ62O//kSxhIK8yCM2VQLZxDBWFruuNMP4jPtgpUypj3QwEb5zE7Ne/a
         j2ng==
X-Gm-Message-State: AOJu0Yyb1EKvcs4k3EqBYFbBhvGAJTyy2TiLqWXbfC/zZTl3ztbLZ6k0
        btgHbY7mPPXxaVyUGRmsE/k=
X-Google-Smtp-Source: AGHT+IEBRnXd6b8j/Nv48oLvoPxniTYksbyjMvpIJWYHWLSkhedNoxT2y5sLmouRcDFQzxebagKgog==
X-Received: by 2002:a05:6a00:1acb:b0:68a:2272:23e9 with SMTP id f11-20020a056a001acb00b0068a227223e9mr10368917pfv.17.1694463875075;
        Mon, 11 Sep 2023 13:24:35 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id w26-20020aa7859a000000b006873aa079aasm6209347pfn.171.2023.09.11.13.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 13:24:34 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 11 Sep 2023 10:24:33 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH bpf-next 0/5] bpf, cgroup: Enable cgroup_array map on
 cgroup1
Message-ID: <ZP93gUwf_nLzDvM5@mtj.duckdns.org>
References: <20230903142800.3870-1-laoar.shao@gmail.com>
 <qv2xdcsvb4brjsc7qx6ncxrudwusogdo4itzv4bx2perfjymwl@in7zaeymjiie>
 <CALOAHbB-PF1LjSAxoCdePN6Va4D+ufkeDmq8s3b0AGtfX5E-cQ@mail.gmail.com>
 <CAADnVQL+6PsRbNMo=8kJpgw1OTbdLG9epsup0q7La5Ffqj6g6A@mail.gmail.com>
 <CALOAHbBhOL9w+rnh_xkgZZBhxMpbrmLZWhm1X+ZeDLfxxt8Nrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbBhOL9w+rnh_xkgZZBhxMpbrmLZWhm1X+ZeDLfxxt8Nrw@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Sep 10, 2023 at 11:17:48AM +0800, Yafang Shao wrote:
> To acquire the cgroup_id, we can resort to open coding, as exemplified below:
> 
>     task = bpf_get_current_task_btf();
>     cgroups = task->cgroups;
>     cgroup = cgroups->subsys[cpu_cgrp_id]->cgroup;
>     key = cgroup->kn->id;

You can't hardcode it to a specific controller tree like that. You either
stick with fd based interface or need also add something to identify the
specifc cgroup1 tree.

Thanks.

-- 
tejun
