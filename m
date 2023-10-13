Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC51A7C8F8F
	for <lists+cgroups@lfdr.de>; Fri, 13 Oct 2023 23:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjJMVvl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Oct 2023 17:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJMVvk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Oct 2023 17:51:40 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0032FBF
        for <cgroups@vger.kernel.org>; Fri, 13 Oct 2023 14:51:38 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-775751c35d4so162327685a.0
        for <cgroups@vger.kernel.org>; Fri, 13 Oct 2023 14:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697233897; x=1697838697; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cyy9YIX2I3x3QCpL532Lfca+iWPr3umdGP+7RW66dQM=;
        b=nSarddLCrg0YSLVPTAw7yRrdix4NtOqcjctrxVmYoqxnK7/KtPob7mNwQmvweISc78
         4sHH91meLJXkm8+gieMYA6UIkzb6YOdbhrrPLLgyniDu+U173fI+9+BNuF5UV0tZTEJ9
         KEKo4xeTD+hNNlU5avp8zb/a/0EmXPO1XkoIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697233897; x=1697838697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyy9YIX2I3x3QCpL532Lfca+iWPr3umdGP+7RW66dQM=;
        b=YEle2aen7Avq6DYrudbAKc2AyRf4EV7sDKGHZ1XP1hsT7h6sYZtKm3x8u69XqhZ9KW
         rESY+yD0iQBVBSiMC1YUEcqiAXtZlnEZc4zLsV/90sSCIRz7KP1B6rZ0f7pRAd1giMWY
         NLFU5GdjooOnPqPMbhHy9Lh8pbK4yYxdICByuAkg3NTQNyi8ms5p0zcJaK8kPUMPhkiv
         Fu8HQvGGVj3mYfz2ErJAVr+lwOoRbiuyN48a2tDdxHh11gndcREyaKS0KDiYSSlsqoRU
         65PAWnbBb5we+ELxB5q1W/Ffj6GvU7TuHtw0S1Ww/oyCc/AKvz+eTaoMwGwCyKxqnDtP
         y21g==
X-Gm-Message-State: AOJu0Yy42DivZEV5f/acB7wD5fxhWXrQ5jajeApXIUayV8XDonePVn3p
        af75FQsP3clQFgquE5ERm206IDfvWXgeF+ywDDM=
X-Google-Smtp-Source: AGHT+IH9/1soGSE4Vvk8p8fyzzgrOzI3z0am40qlM6Tv+1MgaFcI6BAzsWutUPlm22sMyZEtua6e5g==
X-Received: by 2002:a05:620a:2886:b0:76d:f544:3426 with SMTP id j6-20020a05620a288600b0076df5443426mr32803772qkp.28.1697233897592;
        Fri, 13 Oct 2023 14:51:37 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id i23-20020a05620a075700b0076ef004f659sm981454qki.1.2023.10.13.14.51.36
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 14:51:36 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-419768e69dfso41561cf.0
        for <cgroups@vger.kernel.org>; Fri, 13 Oct 2023 14:51:36 -0700 (PDT)
X-Received: by 2002:a05:622a:760d:b0:40d:eb06:d3cc with SMTP id
 kg13-20020a05622a760d00b0040deb06d3ccmr9844qtb.7.1697233896288; Fri, 13 Oct
 2023 14:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230928015858.1809934-1-linan666@huaweicloud.com>
 <CACGdZY+JV+PdiC_cspQiScm=SJ0kijdufeTrc8wkrQC3ZJx3qQ@mail.gmail.com>
 <4ace01e8-6815-29d0-70ce-4632818ca701@huaweicloud.com> <20231005162417.GA32420@redhat.com>
 <0a8f34aa-ced9-e613-3e5f-b5e53a3ef3d9@huaweicloud.com> <20231007151607.GA24726@redhat.com>
 <21843836-7265-f903-a7d5-e77b07dd5a71@huaweicloud.com> <20231008113602.GB24726@redhat.com>
In-Reply-To: <20231008113602.GB24726@redhat.com>
From:   Khazhy Kumykov <khazhy@chromium.org>
Date:   Fri, 13 Oct 2023 14:51:22 -0700
X-Gmail-Original-Message-ID: <CACGdZY+OOr4Q5ajM0za2babr34YztE7zjRyPXHgh_A64zvoBOw@mail.gmail.com>
Message-ID: <CACGdZY+OOr4Q5ajM0za2babr34YztE7zjRyPXHgh_A64zvoBOw@mail.gmail.com>
Subject: Re: [PATCH] blk-throttle: Calculate allowed value only when the
 throttle is enabled
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>,
        Li Nan <linan666@huaweicloud.com>, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Looking at the generic mul_u64_u64_div_u64 impl, it doesn't handle
overflow of the final result either, as far as I can tell. So while on
x86 we get a DE, on non-x86 we just get the wrong result.

(Aside: after 8d6bbaada2e0 ("blk-throttle: prevent overflow while
calculating wait time"), setting a very-high bps_limit would probably
also cause this crash, no?)

Would it be possible to have a "check_mul_u64_u64_div_u64_overflow()",
where if the result doesn't fit in u64, we indicate (and let the
caller choose what to do? Here we should just return U64_MAX)?

Absent that, maybe we can take inspiration from the generic
mul_u64_u64_div_u64? (Forgive the paste)

 static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
 {
+       /* Final result probably won't fit in u64 */
+       if (ilog2(bps_limit) + ilog2(jiffy_elapsed) - ilog2(HZ) > 62)
+               return U64_MAX;
        return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64)HZ);
 }
