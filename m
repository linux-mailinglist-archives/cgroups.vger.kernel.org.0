Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C0050C995
	for <lists+cgroups@lfdr.de>; Sat, 23 Apr 2022 13:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbiDWLdi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Apr 2022 07:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiDWLdh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 23 Apr 2022 07:33:37 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D244219C2F;
        Sat, 23 Apr 2022 04:30:40 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id d19so7596880qko.3;
        Sat, 23 Apr 2022 04:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v+hm7gQVZ3AvhLOPtEZQpwUGWPY5yjYTJl2KFpAuyRI=;
        b=CmVP1UEeOajeakz/bqm6hWkTeRu/K/B2XMFZL2i+OoBmJ+KJe/HXPYI40QNwBf6Jd9
         omMkoNod4T8krrRtfnzcK+JiBCBDn/QU+rgeFgSt9so0nclwGjzwF9P7itAIhwF/U1lD
         x6Ip34psnCYsfad0CSaU0k8fx8N9JkpJwvsXxTJc9+DoVn4WvC9M0cRcNvJbIKzJjv9c
         YrVzjmZv80iU3abtXQTFm7OorhBb4dp0M3QYTkGjmUpbHyt0s/BZPBDy/F0kJupBDHz3
         MgBRXU5noElJ1C+5L1MGqufv1y2j359PP1oZRCCfypIvRAIqIiOqm2ECZwEAYz3CM3pc
         O43w==
X-Gm-Message-State: AOAM532zZKUelYj6o7bqwMeQ+RLsCQIS3pQEALIGdeMM+tUg439VJg1B
        Q1GmW5yw64mkUjDY6eE7PGA=
X-Google-Smtp-Source: ABdhPJyL5qHhE+Rq8ng4FXgO46xS2udtOcYBgNIw2VO/z6o0ZNxbHjowlCxBnPGa+DV/Djz80tXa1A==
X-Received: by 2002:a37:b141:0:b0:69b:ea55:b20e with SMTP id a62-20020a37b141000000b0069bea55b20emr5354820qkf.316.1650713439772;
        Sat, 23 Apr 2022 04:30:39 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-010.fbsv.net. [2a03:2880:20ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id 2-20020a05620a06c200b0069ea498aec7sm2199801qky.16.2022.04.23.04.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 04:30:39 -0700 (PDT)
Date:   Sat, 23 Apr 2022 04:30:37 -0700
From:   David Vernet <void@manifault.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     akpm@linux-foundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com
Subject: Re: [PATCH 1/5] cgroups: Refactor children cgroups in memcg tests
Message-ID: <20220423113037.gnfysktiuzmfnpmp@dev0025.ash9.facebook.com>
References: <20220422155728.3055914-1-void@manifault.com>
 <20220422155728.3055914-2-void@manifault.com>
 <YmM0b+3thMZaXVDb@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmM0b+3thMZaXVDb@carbon>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 22, 2022 at 04:04:15PM -0700, Roman Gushchin wrote:
>

Thanks for the reviews on this patchset, Roman. FYI I think Andrew already
merged these patches to the -mm tree. I'll send out a follow-on patch that
fixes everything you pointed out, both here and on the other patches in the
set.

> On Fri, Apr 22, 2022 at 08:57:25AM -0700, David Vernet wrote:
> > In test_memcg_min() and test_memcg_low(), there is an array of four sibling
> > cgroups. All but one of these sibling groups does a 50MB allocation, and
> > the group that does no allocation is the third of four in the array.  This
> > is not a problem per se, but makes it a bit tricky to do some assertions in
> > test_memcg_low(), as we want to make assertions on the siblings based on
> > whether or not they performed allocations. Having a static index before
> > which all groups have performed an allocation makes this cleaner.
> > 
> > This patch therefore reorders the sibling groups so that the group that
> > performs no allocations is the last in the array.
> 
> It makes the comment explaining the test just above the test_memcg_min()
> function obsolete. Please, fix it too.

Thanks for catching that. I'll fix the comment both in test_memcg_min() and
test_memcg_low() when I send out that follow-on patch.
