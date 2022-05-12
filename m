Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E4B5253F8
	for <lists+cgroups@lfdr.de>; Thu, 12 May 2022 19:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243771AbiELRo5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 May 2022 13:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240506AbiELRo4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 May 2022 13:44:56 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D61226C4DA;
        Thu, 12 May 2022 10:44:55 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id kk28so4928327qvb.3;
        Thu, 12 May 2022 10:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dZue0UTlrDAnzvGcVBrv1iRqhh3n5waeAxQ9q+USOtQ=;
        b=Gv57DeQaEkdbNb43vErQwHisTY4EFi4IlVkqhcDPwz4JFBCY9jBiRdWozh5IUzhq7A
         mhATukbX5S/Vep9q2cjMSTBodY6msqCyQG812EJxdTEkmxbRq0oC2HlkGLqHGG69l/YJ
         7bZRepQySnWLRfEx39e4Czs7jzog+f0osWVRGhxHuKTp5fDt+0shiQYSi5BbSfRmExNS
         6VkMPRNbMFoZrNC7pAcFUr/Y+tVuMOGYAGtn/Fr7pFoGglEnAumC11E9y0GrD1kh0wgZ
         cPOJU/pg3irF9pWmkQrlwF6JFtgydXSgSWDUa/SiFgyIp6lEBa6zqfFQRTVQF5hTrqEF
         ud5Q==
X-Gm-Message-State: AOAM530oVCQKXx2CqsNYL75GSmZPG0Adj+/2QKKowG+jBu66sUC1Y//a
        yw10Fp9/lWCDLlvxKm+iHMxe653swrrryQ==
X-Google-Smtp-Source: ABdhPJywll+nIbOZcCNCeFmLnIqwiQprWlxHUY6UCR89jqS67IVxJjUv50+ELL2s5a/gSS3T90c1ZA==
X-Received: by 2002:a05:6214:b11:b0:456:446e:a6c1 with SMTP id u17-20020a0562140b1100b00456446ea6c1mr888381qvj.28.1652377494352;
        Thu, 12 May 2022 10:44:54 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-013.fbsv.net. [2a03:2880:20ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id fu37-20020a05622a5da500b002f39b99f67bsm121960qtb.21.2022.05.12.10.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 10:44:54 -0700 (PDT)
Date:   Thu, 12 May 2022 10:44:52 -0700
From:   David Vernet <void@manifault.com>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     akpm@linux-foundation.org, tj@kernel.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com
Subject: Re: [PATCH v2 0/5] Fix bugs in memcontroller cgroup tests
Message-ID: <20220512174452.tr34tuh4k5jm6qjs@dev0025.ash9.facebook.com>
References: <20220423155619.3669555-1-void@manifault.com>
 <20220512170410.GA16096@blackbody.suse.cz>
 <20220512173018.3pqlfwfigbbkoh4u@dev0025.ash9.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220512173018.3pqlfwfigbbkoh4u@dev0025.ash9.facebook.com>
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

On Thu, May 12, 2022 at 10:30:18AM -0700, David Vernet wrote:
> Hi Michal,
> 
> On Thu, May 12, 2022 at 07:04:10PM +0200, Michal Koutný wrote:
> > Are the Roman's patches merged anywhere? (I ran into some issues when I
> > was rebasing your (David's) series on top of master.) I'd like to put
> > all sensible patches in one series or stack on existing branch (if
> > there's any).
> 
> Roman's patches are present on master on the linux-mm tree. See
> b7dbfd6553d..a131b1ed12c6.
> 
> > For possible v3 of this series, I did:
> >   - dropped the patch that allows non-zero memory.events:low for a sibling with
> >     memory.low=0 when mounted with memory_recursiveprot (the case needs more
> >     discussion),
> 
> Ack, and thanks for keeping us steered in the right direction here. I don't
> see this in the patch set you linked, but I agree this commit should be
> reverted and the reclaim logic instead fixed.
> 
> >   - added few more cleanups, convenience for debugging,
> 
> Are you referring to the FAIL() macro you added? I would love to Ack that,
> but unfortunately checkpatch.pl will probably yell at you for having a goto
> in that macro, per the point about avoiding macros that affect control flow
> [0].
> 
> I tried to do the same thing when sending out my patch set and had to
> revert it before sending it to upstream.
> 
> Thanks,
> David
> 
> [0] https://github.com/Werkov/linux/commit/a076339cc4825af2f22f58c1347a572b104b8221

Sorry, I meant to link this:

https://www.kernel.org/doc/html/latest/process/coding-style.html#macros-enums-and-rtl
