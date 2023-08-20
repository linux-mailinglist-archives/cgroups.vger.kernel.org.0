Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDEF781C84
	for <lists+cgroups@lfdr.de>; Sun, 20 Aug 2023 07:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjHTF46 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 20 Aug 2023 01:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjHTF44 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 20 Aug 2023 01:56:56 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E8B24C34
        for <cgroups@vger.kernel.org>; Sat, 19 Aug 2023 22:15:25 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-407db3e9669so166571cf.1
        for <cgroups@vger.kernel.org>; Sat, 19 Aug 2023 22:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692508524; x=1693113324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHzkhq/2CNg7lFMLeaog/UrvW1UqZ1CtPUmwbLqtOso=;
        b=nrQiyjOjJgcaUd2bk6SQdWj5LUoQRiQaNvV3OXquVrONrch9Wsbd6GIbPFmmNEDNyB
         29owdNMnZkMOs9CZbup2nYnf6BB+WZq+G0JsrFFj4u+ZZY142ePVUn2zyprs6B+dZxnZ
         K81VlDP+tLe+QLce0rYfnTKWFi6pmJq61kqfwBs0We34X0KJJdMSBeJA2zPHPReDhI13
         2Provo2k/OOGfiUny7nal9athlK4IcTcBWLf3C0BOx7s6erKTG+PVzRpIZTZPJlqLppA
         x+oyDUjXk43LQTeqPoRWboN4p6Bi/3/2tv5ZQPt8lwGOpRvUDK7JvThsVsCHwEcOuvrP
         EG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692508524; x=1693113324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHzkhq/2CNg7lFMLeaog/UrvW1UqZ1CtPUmwbLqtOso=;
        b=YEm3OzfTSNiQqYRU2UqZaaSrd+Yn17DcvJKGjVuihpTc9kuetsCOtyk6R9RhnkEkeC
         +zwqY0IN59wNvjD46/sfG8wpI1254QbtbKzhUFfKnoJWJyYviF62elSIAMNZqvOKDIi/
         ANCtR7WhTufvy4BkZyuqarycFq8jGaBCzWbMxDyvqeza8wTOYMU52bqWNQxWEmRKwtOS
         vlXQ0QW1jXqiHoEGviP6MSQ3Fx2Uq11hVZIpMtmkGS8Hv3UY5Ghzm3jA0R6jGK+flA9P
         UQXzmKOOpGfeh9GWIcY4eQ8fdKo1wvjQFyS69uhaJvM03Qbcyh1TS7S9Ajh8psHHrJGm
         SxvA==
X-Gm-Message-State: AOJu0YyzrSXzMMJfty61s/v2jlRBPQ9XLAfDd/Ioc/FwNeTxwL6WdDUO
        PclH7PSK8h8wv7Al34Sv5pf5H0MDsNFUvNVeZ0rnnA==
X-Google-Smtp-Source: AGHT+IEyrJJN3bqcxrncMer3K59w5lfuTjhtm8IRRVSw00c59ETlftXN80uaZzSCoeXAbSChVJPhFhBqeOvM8vvWJTk=
X-Received: by 2002:a05:622a:1316:b0:403:aa88:cf7e with SMTP id
 v22-20020a05622a131600b00403aa88cf7emr359610qtk.29.1692508524018; Sat, 19 Aug
 2023 22:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230819081302.1217098-1-lujialin4@huawei.com>
In-Reply-To: <20230819081302.1217098-1-lujialin4@huawei.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 19 Aug 2023 22:15:12 -0700
Message-ID: <CALvZod6AmsQb+srO5JjMQH0xFx_Ybu=KxdrX+i+f7BzbK1DUiA@mail.gmail.com>
Subject: Re: [PATCH] memcg: Removed duplication detection for mem_cgroup_uncharge_swap
To:     Lu Jialin <lujialin4@huawei.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Aug 19, 2023 at 1:14=E2=80=AFAM Lu Jialin <lujialin4@huawei.com> wr=
ote:
>
> __mem_cgroup_uncharge_swap is only called in mem_cgroup_uncharge_swap,
> if mem cgroup is disabled, __mem_cgroup_uncharge_swap cannot be called.
> Therefore, there is no need to judge whether mem_cgroup is disabled or
> not.
>
> Signed-off-by: Lu Jialin <lujialin4@huawei.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
