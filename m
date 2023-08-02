Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC9B76D9B6
	for <lists+cgroups@lfdr.de>; Wed,  2 Aug 2023 23:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbjHBVjs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Aug 2023 17:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbjHBVjr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Aug 2023 17:39:47 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC46726AF;
        Wed,  2 Aug 2023 14:39:44 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bc34b32785so2559375ad.3;
        Wed, 02 Aug 2023 14:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691012384; x=1691617184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dg1csT6sQap9Rjj/9a7I+zdOC12NSKIzfI8UlxG6Z6s=;
        b=D5od+G8Q5l6okpcSGorDH8rVDi8dKCBthkqpfYBIBJlUCMIh9J5CpRVct3JKaQvA1B
         IOL7SasPOzvfL8/mSWNYFSsfFCQWNM5JxkOGVwAatzOmGjXIBKMplWnSyh0G8xhrJ2BM
         luNIHpVg2gOIh/cf9EmBsozBHMIWBgjLI8ckR675XgH16xGIs4qLRva01KuoNNRPl4kZ
         oOcthTE0Bt20SOx7bSL00SsleLB3chZI++TfTdJDvk80Z475KNWTj+/NlOOKhwdz6wo5
         yYKiBWxas6X63T8Vks8qHaljufFTCxBvS8BmXseG1AXraZZ6CUv8U3WDqygStNlRZWxa
         Z8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691012384; x=1691617184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dg1csT6sQap9Rjj/9a7I+zdOC12NSKIzfI8UlxG6Z6s=;
        b=INJv5mVVo3QZ6kfZCSyR1VsMj/MxF+CH7K0N710VUQ4Y7vau9UCzTclVKxab4ii3JK
         /cyxy8gnQdmGaTQYwGW0MhSa3/2kgEknoYXRf+Mw+AwyjU8wmJ2mS2KjflduK75wn9gO
         dqLJAvvol+kkdDz30RTaSfAfCfxMegMc+5Ew7+i6xK8d3irXmSNnLzl97QOQpbgouCpD
         lX6nJoU0mab7FKbKox2v3tUzroB943C45JStVvzOGCiyAUHcbok5HvxIbD3/n0VY1a9W
         TZL9MLVO3lT7YjnXxxusNZmgd2MONLzdl9aY/665lunOqTOwEYXD+zHIpxh8uzM4zx3A
         Cmcg==
X-Gm-Message-State: ABy/qLbpWAn9Etgw6wGvC3f7RqIzcfzyO/WDoxd7vv/0Z1M9Fs19mGOw
        GNfP47+LsnAZ735Sru372Wk=
X-Google-Smtp-Source: APBJJlFJDCjDYsyfzWyMCiBMOkJ6rBp4oH7PlOzBbLdMFCR3Ufc/nU/ktZy/7IyhCRN25QEJJQI2cQ==
X-Received: by 2002:a17:902:e841:b0:1bb:ee1b:3cdf with SMTP id t1-20020a170902e84100b001bbee1b3cdfmr16535575plg.67.1691012383533;
        Wed, 02 Aug 2023 14:39:43 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9d5d])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709028d8b00b001bb99e188fcsm12850055plo.194.2023.08.02.14.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 14:39:43 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 2 Aug 2023 11:39:41 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, mkoutny@suse.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] cgroup/rstat: record the cumulative
 per-cpu time of cgroup and its descendants
Message-ID: <ZMrNHf2tg8AZ2F0z@slm.duckdns.org>
References: <20230717093612.40846-1-jiahao.os@bytedance.com>
 <ZLWb-LsBD041hMvr@slm.duckdns.org>
 <2655026d-6ae4-c14c-95b0-4177eefa434f@bytedance.com>
 <ZLcJ1nH8KzWzoQWj@slm.duckdns.org>
 <b4424767-dce7-08a9-3759-43cc9dfa4273@bytedance.com>
 <3d2b68bf-9f40-c779-dcfd-4cf9939edecc@bytedance.com>
 <ZMKs_GpHEW6Pfusj@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMKs_GpHEW6Pfusj@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Jul 27, 2023 at 07:44:28AM -1000, Tejun Heo wrote:
> Oh yeah, I do. I'm just thinking whether we also want to expose that in the
> cgroupfs. We are currently not showing anything per-cpu and the output
> formatting gets nasty with a huge number of CPUs, so maybe that's not going
> to work out all that well. Anyways, I'll get back to you next week.

I couldn't come up with an answer. Let's go ahead with adding the field but
can you please do the followings?

* Name it to something like subtree_bstat instead of cumul_bstat. The
  counters are all cumulative.

* Are you sure the upward propagation logic is correct? It's calculating
  global delta and then propagating to the per-cpu delta of the parent. Is
  that correct because the two delta calculations always end up the same?

* Please add a comment explaining that the field is not currently used
  outside of being read from bpf / drgn and what not and that we're still
  trying to determine how to expose that in the cgroupfs interface.

Thanks.

-- 
tejun
