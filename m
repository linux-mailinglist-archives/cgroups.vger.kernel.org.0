Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F270790895
	for <lists+cgroups@lfdr.de>; Sat,  2 Sep 2023 17:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjIBPqK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 2 Sep 2023 11:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbjIBPqJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 2 Sep 2023 11:46:09 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DC9E56
        for <cgroups@vger.kernel.org>; Sat,  2 Sep 2023 08:46:06 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bbbda48904so36131fa.2
        for <cgroups@vger.kernel.org>; Sat, 02 Sep 2023 08:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693669564; x=1694274364; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sTVrfuoyyUEeTTw7w2mP5y9qGCPLtPAJX6CEnNqN/W4=;
        b=VRunf5Wt819lE50sIZXPdmAK9Cch1N2BY29y30VkiTZ9vSb9xT371Wq4s63jovMaku
         zwlFKFZ8eBBQHUUZywGdiXouT5LueYXW0n7NvBL5JddiFe5A22/y1z9gkd40TaLNwFyN
         ToO6L1IqYiYCB7tYAtLCZ7Qb28lwGa2ShFgjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693669564; x=1694274364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sTVrfuoyyUEeTTw7w2mP5y9qGCPLtPAJX6CEnNqN/W4=;
        b=YA76/xpEC2b6DvPEOMr7p4FLB4UkStY1pJTZjhmQGMcKrsIqmooipgegCuchrR6ftu
         6BaWQJbEE0663VNsuC7vCH4dkW8lXv/gofh9uuo+WcJEUWFf8jq/0gCC2cVLBsI/UUNA
         bEDzGrDByHQCjX4oPiCqlLoUgYsXZzh4qy9ErT+QF1JdeTkZAG4pEcPuaEy7JrfvJPp9
         usFVu61fkeCmpkHXwbpgSVEXO1UJUhOnltLh8rbg8bntwyIr7aLXyhrU1olSckTmrcK9
         33HoOi+ASJ64W6etfDCVtxqcV5W51PxHQnyqBTkWETJ8KdqDEAdw70XB/py5s3qTP7iM
         q8Kg==
X-Gm-Message-State: AOJu0Ywi611plXhpzBaZyCABDQ9zTCvrExqG0m66C/Ifwo62YmXp/zuZ
        1yrAs+nF+VVKBG+217xBJB5lC9bZoqFq2O5qWCHl4g==
X-Google-Smtp-Source: AGHT+IFGAnVgu6gXsNVHmVm9VuoAiDVKbb7NsCdK87plC+mWFzQjw2e0pXplJUOW62z6zEbhOxzwbQ==
X-Received: by 2002:a2e:965a:0:b0:2bc:fe17:693c with SMTP id z26-20020a2e965a000000b002bcfe17693cmr3839983ljh.30.1693669564654;
        Sat, 02 Sep 2023 08:46:04 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id l21-20020a2e9095000000b002b9bf5b071bsm1195591ljg.20.2023.09.02.08.46.02
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Sep 2023 08:46:02 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5008faf4456so143931e87.3
        for <cgroups@vger.kernel.org>; Sat, 02 Sep 2023 08:46:02 -0700 (PDT)
X-Received: by 2002:a05:6512:3b2c:b0:500:9026:a290 with SMTP id
 f44-20020a0565123b2c00b005009026a290mr4608993lfv.9.1693669561847; Sat, 02 Sep
 2023 08:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <ZPMdTJ7zwrCkdMTu@debian> <ZPNX-jZAZbebizXA@slm.duckdns.org>
In-Reply-To: <ZPNX-jZAZbebizXA@slm.duckdns.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Sep 2023 08:45:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wha+VT3yC3BKS1046GpuH2JRPER+_MXVu_Z1V2K1Ja6Dw@mail.gmail.com>
Message-ID: <CAHk-=wha+VT3yC3BKS1046GpuH2JRPER+_MXVu_Z1V2K1Ja6Dw@mail.gmail.com>
Subject: Re: [PATCH cgroup/for-6.6-fixes] cgroup: Put cgroup_local_stat_show()
 inside CONFIG_CGROUP_SCHED
To:     Tejun Heo <tj@kernel.org>
Cc:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, 2 Sept 2023 at 08:42, Tejun Heo <tj@kernel.org> wrote:
>
> Sorry about that. This should fix it. Guess nobody is building linux-next w/
> !CONFIG_CGROUP_SCHED. I'll send the pull request to Linus soon.

I solved it slightly differently by moving the whole function around
rather than adding yet another #ifdef.

See 76be05d4fd6c ("cgroup: fix build when CGROUP_SCHED is not enabled")

                Linus
