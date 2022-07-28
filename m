Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437D85844F8
	for <lists+cgroups@lfdr.de>; Thu, 28 Jul 2022 19:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiG1R0O (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Jul 2022 13:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbiG1R0I (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Jul 2022 13:26:08 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB3D12D1D;
        Thu, 28 Jul 2022 10:26:07 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id c3so2456772pfb.13;
        Thu, 28 Jul 2022 10:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc;
        bh=yPjjAlHvkDbffFb+wNaNKaLJK2amB18Tv3U4RxiGxog=;
        b=ejdELvaM315ArBoL4nBGJKiTx05RJpFOTrByKL0vtASdXa4d3m9POeYXVINfmdTV3Q
         bgp0vNy+cRh4ZauFeqHTGWaUfJwD0cfZGRNbdiY16zWcAn9QbdmrIbjWGiqUP/VNLDW0
         SYSkW2RT7FuEEIEgPGYQySBWnwjHrM+pkSUp8sm9UuAYl7KdjmNxst0wTF1W6eyRhHc/
         iOdEygDMIi7uGGHfRzBu8/KVrkh0hSL+gtvUf1IqpY/YsBdItP84W/40tzv8ejvtpvOX
         WTukcr84KeTz+8ZF6+t/tYSB+5S6UqWC+1PmlgGkqLno1Nq8oQGsZB6yQg5vLHGPYtJ9
         WizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc;
        bh=yPjjAlHvkDbffFb+wNaNKaLJK2amB18Tv3U4RxiGxog=;
        b=Dl7KgorMOfdivh0j6fvVVR8uF7rUACmNiFpQGRbwpERu/HWa5s1rxZHO9WV1QfmOox
         p1fHGFEk8RQG8Yfhic9EDS6SW+ZTcCiho0fkOMn3AZNkPszmjkYvH+ucEkVpBaeV1uiN
         R2zg6WSyyeNaxVamvKB2cAWYJqFBFQc/DhxyHAcgzzc2wSXbZepA7vjMtSw+vo/Cif3r
         gLkmZzgOX4Wyi3xdJEb2W+/87PPx0k30lDRh3uCcUKZZJ9wUMC9pbVWFWTdCScxNpmEh
         Gyi8GWci5sd9VinUdMKb/8ARNBmZ8jC9RhKuKXHYH7ZPH1YgsrliETMmBpYoSBsWKoUc
         oqig==
X-Gm-Message-State: AJIora9COYyw/EkY99x3r/l4Gze/jH6mLRXm+bpOfNGCwoNFCplpGLlX
        EHgm4BcS2qdLm3i6T+LOGRI=
X-Google-Smtp-Source: AGRyM1uy/NMK3Xo/sOiP6IlnS3FGumPYGCCPVQATvURXvdtWvP8ma2XFFEeB3n9jgi1ApjbEWfa3DQ==
X-Received: by 2002:a62:3086:0:b0:52b:fd6c:a49d with SMTP id w128-20020a623086000000b0052bfd6ca49dmr18083324pfw.26.1659029167041;
        Thu, 28 Jul 2022 10:26:07 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x5-20020aa79a45000000b0052b4f4c6a8fsm1003917pfj.209.2022.07.28.10.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 10:26:06 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 28 Jul 2022 07:26:05 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cgroup: Skip subtree root in
 cgroup_update_dfl_csses()
Message-ID: <YuLGrXyXj6a2yigJ@slm.duckdns.org>
References: <20220728005815.1715522-1-longman@redhat.com>
 <20220728005815.1715522-2-longman@redhat.com>
 <20220728144426.GA26631@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220728144426.GA26631@blackbody.suse.cz>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 28, 2022 at 04:44:26PM +0200, Michal Koutný wrote:
> On Wed, Jul 27, 2022 at 08:58:15PM -0400, Waiman Long <longman@redhat.com> wrote:
> > The cgroup_update_dfl_csses() function updates css associations when a
> > cgroup's subtree_control file is modified. Any changes made to a cgroup's
> > subtree_control file, however, will only affect its descendants but not
> > the cgroup itself. 
> 
> I find this correct.
> 
> > So there is no point in migrating csses associated with that cgroup.
> > We can skip them instead.
> 
> Alone it's not such a big win but it componds with the recent Tejun's
> threadgroup_rwsem elision.

The chance is that if you're writing to a cgroup's subtree_control, that
cgroup is gonna be empty. The only case I can think of that this would make
a difference is w/ threaded cgroups, but it does make sense.

Thanks.

-- 
tejun
