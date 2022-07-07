Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A427C56AEAF
	for <lists+cgroups@lfdr.de>; Fri,  8 Jul 2022 00:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbiGGWl0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Jul 2022 18:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbiGGWl0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Jul 2022 18:41:26 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FA727CF5;
        Thu,  7 Jul 2022 15:41:24 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id os14so4603789ejb.4;
        Thu, 07 Jul 2022 15:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x0hTg3svlPkX7yjZEejAqipfWlRrXxPxf4EQelGBTvo=;
        b=JjLDLcNl//HbIrbRbWAfVo8D/EHxetYwwUclgU4IpzJTW1aVvb76jqCKqg3pQTeotv
         uI+pfXcAlpsxTDhK2XQU/X0vIHaOXSJoKWs9rkTxjxYJ9wiOflV/IzcsJSUlO04l7cjS
         uDSH6tP2pdODKwl8VBAPJ715+J05mEiLpIH5b5kK+VQoCEQfpNJ0Wgyh9SG3orG3Hx+P
         enbo2ru4HaAYtaJKwPwZTV8Jc0rTwxb1Y6qPZDBw7LzK7qLy0N+3fslDNlZWbTnvnTyi
         x2LlCTlGHuTrJscVe/nGn5oSQABB6NQTA2FMSsEn5XXQ1rUyE9gMoiUWHUSGTufjkeXo
         DxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x0hTg3svlPkX7yjZEejAqipfWlRrXxPxf4EQelGBTvo=;
        b=4AWGY3OKSs6+kGVhaDTY95q8MLPbtPfS9S/xMHhkUxai5Yg5bPRTDAAmyHSQ0mbBwJ
         WLxb1eHKhWjPT5eTxIxLjMA+CejRoayhogacyntnB5QJOBkYB66HHXo7XsEp8OoxmmSP
         Gp6ByYDNQoAMfHkfJqpy2DX0ftH/JZE9GgQxsJvmpnqSLnDhdAPd607y2Q+qc8Z37t55
         dhhpE3sbBn4qD/v0Gz/PyRSV6xgrDlCj9ZgNjmgJwdH0Th9O090vsKQJ3Sf3p+xnJGCZ
         IWSG4kOby0EeE35B063h6gxrCKtKgTuUgyNkIlQVJX2GSdGUbP+XzxcYjdYDCScFsKdQ
         0uoQ==
X-Gm-Message-State: AJIora/pDjJPNE1uQBSBWhwq1jSD7yr+A/DioFKao+JIhbCzdMxOaPg7
        ENfibBtaHlD3yNJez03hf9nuloIsUACHMYZXG2s=
X-Google-Smtp-Source: AGRyM1s0deLui/79j5hjBtPHHhjWJfeoyGA22i+D5HMSMsSL5RUY87JhVevlzB1bvYW08banAks08/NbPsWpeOf/OlM=
X-Received: by 2002:a17:906:8444:b0:72a:7dda:5d71 with SMTP id
 e4-20020a170906844400b0072a7dda5d71mr425919ejy.94.1657233683381; Thu, 07 Jul
 2022 15:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220702033521.64630-1-roman.gushchin@linux.dev>
 <CALvZod7TGhWtcRD6HeEx90T2+Rod-yamq9i+WbEQUKwNFTi-1A@mail.gmail.com>
 <YsBmoqEBCa7ra7w2@castle> <YsMCMveSdiYX/2eH@dhcp22.suse.cz>
 <YsSj6rZmUkR8amT2@castle> <CALOAHbAb9DT6ihyxTm-4FCUiqiAzRSUHJw9erc+JTKVT9p8tow@mail.gmail.com>
 <YsUBQsTjVuXvt1Wr@castle> <CALOAHbDjRzySCHeMVHtVDe=Ji+qh=n0pT4CwiAM5Pahi2-QNCQ@mail.gmail.com>
 <YsUH7pgBVnWSkC1q@castle>
In-Reply-To: <YsUH7pgBVnWSkC1q@castle>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 7 Jul 2022 15:41:11 -0700
Message-ID: <CAADnVQ+qqeAVvtDYox4xj85Qxt79EV1Hn+HDEMuzHrwZv14X4Q@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: do not miss MEMCG_MAX events for enforced allocations
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Yafang Shao <laoar.shao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 5, 2022 at 9:24 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> Anyway, here is the patch for reparenting bpf maps:
> https://github.com/rgushchin/linux/commit/f57df8bb35770507a4624fe52216b6c14f39c50c
>
> I gonna post it to bpf@ after some testing.

Please do. It looks good.
It needs #ifdef CONFIG_MEMCG_KMEM
because get_obj_cgroup_from_current() is undefined otherwise.
Ideally just adding a static inline to a .h ?

and
if (map->objcg)
   memcg = get_mem_cgroup_from_objcg(map->objcg);

or !NULL check inside get_mem_cgroup_from_objcg()
which would be better.
