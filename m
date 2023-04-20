Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C856E9C21
	for <lists+cgroups@lfdr.de>; Thu, 20 Apr 2023 20:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjDTS4G (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Apr 2023 14:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjDTSzy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Apr 2023 14:55:54 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AED2735
        for <cgroups@vger.kernel.org>; Thu, 20 Apr 2023 11:55:52 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3e0965f70ecso895991cf.0
        for <cgroups@vger.kernel.org>; Thu, 20 Apr 2023 11:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682016952; x=1684608952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbCxu47aXqOZFjOgElAuAaCkhQzE3b3RJfWYjmehSCc=;
        b=oa5zJsQrq+PRcAacYKvPmJFEiT892k3KGbGwJQk5suWva6mPaVh1qqAA8IzY+Jj/hD
         VFBYO4okZJxeVSzysh4ToRnXR/6o5DYUVATkBJfNde9WKEOtWJJ8yy7sY1xXBfZGEY3q
         xOZ0jkjwyMWdnarfIh0L8R4nUzdGSyWIKSazjknGk1r11LI/2RO684ecfw7UrQTVXs/M
         GzaTUPkrFcjqNquKq6y2UAqISLWfsxVd028RdcSxBegIpsM6e0JAtRgxUzO7FY9aKxf+
         Lt1hLlXFBFqgRdkJ2/8j3ivRECJ5MYEvxha3Z2O262UcpC3xjQwUKeyV2yCazEbahUJf
         4cIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682016952; x=1684608952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbCxu47aXqOZFjOgElAuAaCkhQzE3b3RJfWYjmehSCc=;
        b=HUpbMTwII5BsOViT0zjhBCRZRGCbz/Nn2wuZZ8yzxdQ2rNQH0DqN89TIYVzb0RZgW2
         K8zLHUGyaf6maMyzDOiY5O3FVUdq83zoKDNMTsK7yonBpBUtN3eet3iskQy89YMSD+gb
         pdpEixP4NLWWvrmhjJmPGu+u8XKNCvKtA4E6D6hTuaanRWJvu6yT7a4Tfe2gF6pj1C+9
         K7DCPgkZxutTXvez2dhw2k2VxBqLBRWrIf139Qew+bcZWGFucPPMwG/3CIwiT32p85Li
         DLAdh5cDRajhBYmblQCvExG6v+e4eLoS4bizZdedXFFvVLRolJMiz07DBoMUl7tnCFJb
         z1Cg==
X-Gm-Message-State: AAQBX9eh272Ao2++a5X51NgenqyWKKpRn73cvCbAY4wIzVNcLlA+umKh
        bh465kRwUFkZUOUR8Q3wNuxPxtVcOv+BE4e4ADfZQw==
X-Google-Smtp-Source: AKy350YQ85co+lRTcuWRO1Vltk6Lkvqveeyi1jPBPoTaqbL7736XRkZW9Hessn4M1C1JBov0tCRU8RrPiXoZoB3KNYs=
X-Received: by 2002:ac8:5b10:0:b0:3ef:343b:fe7e with SMTP id
 m16-20020ac85b10000000b003ef343bfe7emr60397qtw.2.1682016952049; Thu, 20 Apr
 2023 11:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230403220337.443510-1-yosryahmed@google.com> <20230403220337.443510-3-yosryahmed@google.com>
In-Reply-To: <20230403220337.443510-3-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 20 Apr 2023 11:55:40 -0700
Message-ID: <CALvZod5mxE8RAtCEZkaq2fce-Od5MZtyPppn-ns0XzXHMcFm9g@mail.gmail.com>
Subject: Re: [PATCH mm-unstable RFC 2/5] memcg: flush stats non-atomically in mem_cgroup_wb_stats()
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 3, 2023 at 3:03=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> The previous patch moved the wb_over_bg_thresh()->mem_cgroup_wb_stats()
> code path in wb_writeback() outside the lock section. We no longer need
> to flush the stats atomically. Flush the stats non-atomically.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
