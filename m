Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768785253AD
	for <lists+cgroups@lfdr.de>; Thu, 12 May 2022 19:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357069AbiELRaX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 May 2022 13:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357066AbiELRaW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 May 2022 13:30:22 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12BD26BC86;
        Thu, 12 May 2022 10:30:21 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id 185so5300848qke.7;
        Thu, 12 May 2022 10:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HgIdbY+Ecvji+T/cCG5mM6Y68lgt4DMV4FLsZ7Ccutw=;
        b=PI5BvjW+wUOh+cofVePfmn9urJ++JL0uvuiqWLeBlbtM0l4Tu0EtCW5dnMhmEKEY7k
         RHoXpdOjR2UUYIebssXXenjCjNqDeaFY8wK4i98DhN5onokHAyB966x+o94XgzUZr7Sw
         qxu05Scph/SmFUi7t79glBVXz2AOMPadj/csgPDNuOFzdKz/ZpReObDN7JoEexv04mri
         wloqkDqT1KrnevwAPhG6p2X6Oxe0t6yPT69oSOGpeJMOeV+qjUlx3/4ity1zRrnvpcqD
         qdR6Rud+SL3c6ZizNDiU5e3OuzueXg0VK2MZdy4+sgWSxeU5f5P8mRXykgJXdVnHltqD
         gTbw==
X-Gm-Message-State: AOAM532Vg7ZX6nooPWB5X43kR3sR3nfezwAB7tMTjVVeKPFgS0Fmyt68
        8VDg2N0L/0NhH3HykiZT7OI=
X-Google-Smtp-Source: ABdhPJx6sw+zCIzg+CqDUHiaFwLzww+u+emudlIyVK/dv1n1pC2Ki/A0zrTYo+0UVea2Q6VQFp53vg==
X-Received: by 2002:a05:620a:993:b0:6a0:1dca:5a70 with SMTP id x19-20020a05620a099300b006a01dca5a70mr765762qkx.543.1652376620808;
        Thu, 12 May 2022 10:30:20 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-018.fbsv.net. [2a03:2880:20ff:12::face:b00c])
        by smtp.gmail.com with ESMTPSA id v22-20020a05620a441600b0069fc13ce1e7sm58975qkp.24.2022.05.12.10.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 10:30:20 -0700 (PDT)
Date:   Thu, 12 May 2022 10:30:18 -0700
From:   David Vernet <void@manifault.com>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     akpm@linux-foundation.org, tj@kernel.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com
Subject: Re: [PATCH v2 0/5] Fix bugs in memcontroller cgroup tests
Message-ID: <20220512173018.3pqlfwfigbbkoh4u@dev0025.ash9.facebook.com>
References: <20220423155619.3669555-1-void@manifault.com>
 <20220512170410.GA16096@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220512170410.GA16096@blackbody.suse.cz>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Michal,

On Thu, May 12, 2022 at 07:04:10PM +0200, Michal Koutný wrote:
> Are the Roman's patches merged anywhere? (I ran into some issues when I
> was rebasing your (David's) series on top of master.) I'd like to put
> all sensible patches in one series or stack on existing branch (if
> there's any).

Roman's patches are present on master on the linux-mm tree. See
b7dbfd6553d..a131b1ed12c6.

> For possible v3 of this series, I did:
>   - dropped the patch that allows non-zero memory.events:low for a sibling with
>     memory.low=0 when mounted with memory_recursiveprot (the case needs more
>     discussion),

Ack, and thanks for keeping us steered in the right direction here. I don't
see this in the patch set you linked, but I agree this commit should be
reverted and the reclaim logic instead fixed.

>   - added few more cleanups, convenience for debugging,

Are you referring to the FAIL() macro you added? I would love to Ack that,
but unfortunately checkpatch.pl will probably yell at you for having a goto
in that macro, per the point about avoiding macros that affect control flow
[0].

I tried to do the same thing when sending out my patch set and had to
revert it before sending it to upstream.

Thanks,
David

[0] https://github.com/Werkov/linux/commit/a076339cc4825af2f22f58c1347a572b104b8221
