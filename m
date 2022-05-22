Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E72B53015F
	for <lists+cgroups@lfdr.de>; Sun, 22 May 2022 08:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242857AbiEVGuP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 22 May 2022 02:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242764AbiEVGuO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 22 May 2022 02:50:14 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E4C366A2
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 23:50:12 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i187so18162544ybg.6
        for <cgroups@vger.kernel.org>; Sat, 21 May 2022 23:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xBwtB9T65QzhNPtQZ0QXYA7XAPyjsJvSWqKsiu1+O3c=;
        b=1tl+DtjUID/Yit6XMR1sy4CgTCo7HJWlhuAjY9JG40KKnRyzU6DDTBO7B8l8eQHvs5
         HCM1hEkHgCiX8lbuD66I4Wg6aom5XMll2U7YYcjZ8YFM9a1TDI+HJflEKyxUunm8Lx5t
         2DN0t8GjjEE5K2TKo4NqLvLu6Dqrx8grDcdVi34AwfAju6scjTPeKVdb0NuAEAZ9oDAh
         CqTsDqWcF3ZoMr7K1uQmsMtv5yVqDCA+QZsfWMEPE9pcfKpzks4o+OoxvCn8OjO9fHY+
         u+6D2zwnTQKV7bZYNGgg6da2F230kRqfS2eXe9sPxUX9yJLUnrjbvXDNsYzkpHqJeN0V
         kKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xBwtB9T65QzhNPtQZ0QXYA7XAPyjsJvSWqKsiu1+O3c=;
        b=5KBpfkdKzjZ7wwPpto3B3PZFbqaDz2iCEXIqlp7U76sNb11bvo5NNghu+uIxYDb52G
         3tEjvU2qmDCqt4gSxUg+vlDiD7dDN5i+AoLZhhR1015w2o4XmSWwiD5xOkn5hAfczt6i
         07NVws5ERHc9g/kxD0XgggEMenuPEYae3FbefvmBF8igv6nJWx9g3y7TYp7r6uEw7GgP
         Tym1Rkom/C1DooEITJj6jhAzz94sd/hn5mjG+A6zCqESwTBI3zsSn6gpwMaFVwfQ1Ryq
         o8RHkOw//Jl7YDykXf4ZJ7Z8QWdrJNkaDvT7d1ze0OUqgzU+9/Dio0CaUHi9k2glKOXc
         OqRA==
X-Gm-Message-State: AOAM530PBKqNZX8Y3F/Ahdklf/6kE8OcWaBLPzpnbf2FOWxAOWinnKJL
        RtxJ+SLcdlOZAaTnwvOt9ePhSIaOTjjBpsrzLzOBog==
X-Google-Smtp-Source: ABdhPJxG7bFPCW5S+Nizupv0nufUjwDo2jXDHFEk/7XVc3m5J4NbnaL1ymOAP0Uw17amoGe2vIpChAn7wQbK1KbLxrY=
X-Received: by 2002:a25:3452:0:b0:64e:1776:ce90 with SMTP id
 b79-20020a253452000000b0064e1776ce90mr16686330yba.261.1653202212242; Sat, 21
 May 2022 23:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <Yn6aL3cO7VdrmHHp@carbon> <46bbde64-7290-cabb-8fef-6f4a30263d8c@openvz.org>
In-Reply-To: <46bbde64-7290-cabb-8fef-6f4a30263d8c@openvz.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sun, 22 May 2022 14:49:36 +0800
Message-ID: <CAMZfGtUg65D2KemysdhcQM3-gnz+c_tahzJ=WzBUcY451WBv4Q@mail.gmail.com>
Subject: Re: [PATCH mm v2 8/9] memcg: enable accounting for allocations in alloc_fair_sched_group
To:     Vasily Averin <vvs@openvz.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, May 22, 2022 at 12:39 AM Vasily Averin <vvs@openvz.org> wrote:
>
> Creating of each new cpu cgroup allocates two 512-bytes kernel objects
> per CPU. This is especially important for cgroups shared parent memory
> cgroup. In this scenario, on nodes with multiple processors, these
> allocations become one of the main memory consumers.
>
> Memory allocated during new cpu cgroup creation:
> common part:    ~11Kb   +  318 bytes percpu
> cpu cgroup:     ~2.5Kb  + 1036 bytes percpu
>
> Accounting for this memory helps to avoid misuse inside memcg-limited
> contianers.
>
> Signed-off-by: Vasily Averin <vvs@openvz.org>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
