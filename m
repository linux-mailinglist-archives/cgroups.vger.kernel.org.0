Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0525F159F
	for <lists+cgroups@lfdr.de>; Sat,  1 Oct 2022 00:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiI3WAz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Sep 2022 18:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiI3WAx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Sep 2022 18:00:53 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F117DDAF32;
        Fri, 30 Sep 2022 15:00:48 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id bi53so2940657vkb.12;
        Fri, 30 Sep 2022 15:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date;
        bh=msbEtVn2XnPhkP1nh+HeVtH130znwtC+tV5GCPNIfiI=;
        b=JuT8PZMwI+cog5yqJIKmEDK9vgvcMw+jb0WaZ0auwmYV/Db1Q1AMNAynltuC4tEicO
         u36dDJel+DVg0RurCLUchPWR//yz8gbuwz+r+L8jEOITkv8Fb1z6jfv5M4kkJt/uZUPk
         ZYpqe4htpjO2DrZmiMsx/UBuGbwGsyFYI1amBup610De9zatozGqH//KKfY9oQuBn3Rc
         gDvIL/5o9wzsJI0WAAXFNYJvhzh3cYkHYyM2iPgbus6is+qB4ZJxFSANYNeJzHm+b8AH
         2WQWCCZiA1MqQ8UX+8zisnskeMFlB9QzlJaH7FpteCTh7WsnhikVECX8Z4AGvqR0NmLX
         5THg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=msbEtVn2XnPhkP1nh+HeVtH130znwtC+tV5GCPNIfiI=;
        b=MeqGP8fjibZuABcmm21QCCFVXmtAIkH2P4j+sOPVsorW2EaEj7VyLAy4+DKisCP5tG
         pTrjOqoGKTRpyUpeG6Qg5HqM/PdagrxTJRWeKei4VC7Fsj54sriSAP+xr2mDMzDnpglS
         WbG25TGPfKXOzAD9yEYzuRRuXCV3Ck3fa+q2OLtCkE0eQebrd/6+j9Y9WqcKGm3p/NML
         7aF7yDqvvYiEzfWWKoPGvuE4Ir2P84e1ESQb8dGov+5f5wMGoPFuPjOR0BscfEcwdgg3
         pS5Z8fyYmuE2xVCTmmksi0oIXnhdaLs5UqZuilIhaHuPrrhOEj/i92Sq4YRJUCT6xOMz
         8sZg==
X-Gm-Message-State: ACrzQf3p2jt1eCNk6joEB4B8gDwCcUxLENSAZa6JY+am3XOeYnsBZV9R
        +9rH1A3kcXNCbu66rrvq6pY=
X-Google-Smtp-Source: AMsMyM7loK4eWzDlO0FFnLUyJFQzzAvwCTAsjrHehbUFEzKKjmOtCwdsNwy9SvsBiYUSkFCnaISfaw==
X-Received: by 2002:a05:6122:a10:b0:3a2:a64e:358b with SMTP id 16-20020a0561220a1000b003a2a64e358bmr5497846vkn.21.1664575248022;
        Fri, 30 Sep 2022 15:00:48 -0700 (PDT)
Received: from [127.0.0.1] ([187.68.192.86])
        by smtp.gmail.com with ESMTPSA id m12-20020a0561020ecc00b00397c028db51sm2154035vst.21.2022.09.30.15.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 15:00:47 -0700 (PDT)
Date:   Fri, 30 Sep 2022 19:00:42 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <olsajiri@gmail.com>
CC:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        cgroups <cgroups@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] perf stat: Support old kernels for bperf cgroup counting
User-Agent: K-9 Mail for Android
In-Reply-To: <CAM9d7cjKaZvWQUwGwoTLNzAgHS7ndL_V_5+O+WqMUvuHJ7cWNg@mail.gmail.com>
References: <CAM9d7cjQ20a01YoZi=o-_7HT6TzR0TZgtpscKNvRrMq2yqV1Og@mail.gmail.com> <20220922041435.709119-1-namhyung@kernel.org> <YzdjHenrJpooKMjv@krava> <CAM9d7cjKaZvWQUwGwoTLNzAgHS7ndL_V_5+O+WqMUvuHJ7cWNg@mail.gmail.com>
Message-ID: <88915C51-33CD-49A4-A9E0-F5F5ECDEA0C7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On September 30, 2022 6:56:40 PM GMT-03:00, Namhyung Kim <namhyung@kernel=
=2Eorg> wrote:
>Hi Jiri,
>
>On Fri, Sep 30, 2022 at 2:44 PM Jiri Olsa <olsajiri@gmail=2Ecom> wrote:
>>
>> On Wed, Sep 21, 2022 at 09:14:35PM -0700, Namhyung Kim wrote:
>> > The recent change in the cgroup will break the backward compatiblity =
in
>> > the BPF program=2E  It should support both old and new kernels using =
BPF
>> > CO-RE technique=2E
>> >
>> > Like the task_struct->__state handling in the offcpu analysis, we can
>> > check the field name in the cgroup struct=2E
>> >
>> > Signed-off-by: Namhyung Kim <namhyung@kernel=2Eorg>
>> > ---
>> > Arnaldo, I think this should go through the cgroup tree since it depe=
nds
>> > on the earlier change there=2E  I don't think it'd conflict with othe=
r
>> > perf changes but please let me know if you see any trouble, thanks!
>>
>> could you please paste the cgroup tree link?
>
>Do you mean this?
>
>  https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/tj/cgroup=2Egit
>


Which branch and cset in that tree does you perf skel depends on?

- Arnaldo=20
>Thanks,=2E
>Namhyung
