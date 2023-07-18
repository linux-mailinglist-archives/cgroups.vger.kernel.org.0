Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A1B758780
	for <lists+cgroups@lfdr.de>; Tue, 18 Jul 2023 23:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjGRVxb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 Jul 2023 17:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGRVxa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 Jul 2023 17:53:30 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BFA198D;
        Tue, 18 Jul 2023 14:53:29 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b8b318c5a7so48863515ad.3;
        Tue, 18 Jul 2023 14:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689717209; x=1692309209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSi1Ye4tnidz3swlAKJl5aSHuZF44JYEhatv2BKTlOQ=;
        b=SZ0tTu6wpG2yNC7ys9W1/E8S7xaA6eRzb41+qynFT6suIRQZeKbOi/JHgHB2znyz8z
         sUXssVqsuJP79/tRbGRSdAxYoaLQyXa6sNibrztdE7BEm/gXgZlwo7jGSTxBQtgBSoNw
         P4GAbZI5hNvN10ddluCGqgqbmEB5PMDz4Hp1Vj9REZzygM2MS72ejDUlmt+iG5AyPuI/
         AG+lCdH0/6kVacWDcXfg62XMDmnOA+SE8ABAWGn9ktSCp5k8m5BvLQs5h4qRVA/ecBvP
         xY1uHKVfNHWnUQ1SkV7uDA8afxAbyaeycd4JwPnApcmgJjFSv4xHlIM9djPegdDlI8G3
         kQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717209; x=1692309209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSi1Ye4tnidz3swlAKJl5aSHuZF44JYEhatv2BKTlOQ=;
        b=JjPj7yX1EpbwodrMlcWhUYt/NiP/VphX5LV9A+KBHY/c+lkqy9bxzCpwswa5qYgmbO
         FU9tBrmAjrBfyzDMd8HMaQyZhG8C7gI3t0zXpgz1LeZbGdVFRqcdOsJM6bYqVUZhePot
         KTUK/eT+/zqMFAMpJKzEiCiTINLa1ntZf7oa4boCTbbEJb9O/FB/023mA4t2c/sf9DOz
         m39OmECpJuU28DucekbxOqMvIY3zVCdWFBbaEtIZZzilbffb9y/wEajsK6PYOqSqDWH/
         cRrfbL1D4a0L4GC+segu6C9/seTbefb+v+fHG9/csl08goxthuIi/8isll5Qnzr8/cnH
         DNUw==
X-Gm-Message-State: ABy/qLZGXCb65wIFiL2ZwBKKRFp+Vatx4FcQVJsT67kjjdZE2ExMtBcm
        QdwAt70XX5O6Q39HKzJNhdU=
X-Google-Smtp-Source: APBJJlFDubl46qLGjElNRyd43o2ozFLnEgGSoc65gpvHAIJMaXhgd6Sy50PIiZ8T02wR0h102on01w==
X-Received: by 2002:a17:902:a409:b0:1b9:be2e:2b40 with SMTP id p9-20020a170902a40900b001b9be2e2b40mr13780928plq.50.1689717208786;
        Tue, 18 Jul 2023 14:53:28 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:fbd8])
        by smtp.gmail.com with ESMTPSA id jf6-20020a170903268600b001b8918da8d1sm2366011plb.80.2023.07.18.14.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 14:53:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 18 Jul 2023 11:53:26 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, mkoutny@suse.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] cgroup/rstat: record the cumulative
 per-cpu time of cgroup and its descendants
Message-ID: <ZLcJ1nH8KzWzoQWj@slm.duckdns.org>
References: <20230717093612.40846-1-jiahao.os@bytedance.com>
 <ZLWb-LsBD041hMvr@slm.duckdns.org>
 <2655026d-6ae4-c14c-95b0-4177eefa434f@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2655026d-6ae4-c14c-95b0-4177eefa434f@bytedance.com>
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

On Tue, Jul 18, 2023 at 06:08:50PM +0800, Hao Jia wrote:
> https://github.com/jiaozhouxiaojia/cgv2-stat-percpu_test/tree/main

Isn't that just adding the same numbers twice and verifying that? Maybe I'm
misunderstanding you. Here's a simpler case:

  # cd /sys/fs/cgroup
  # mkdir -p asdf/test0
  # grep usage_usec asdf/test0/cpu.stat
  usage_usec 0
  # echo $$ > asdf/test0/cgroup.procs
  # stress -c 1 & sleep 1; kill %%
  [1] 122329
  stress: info: [122329] dispatching hogs: 1 cpu, 0 io, 0 vm, 0 hdd
  # grep usage_usec asdf/test0/cpu.stat
  usage_usec 1000956
  [1]+  Terminated              stress -c 1
  # grep usage_usec asdf/cpu.stat
  usage_usec 1002548
  # echo $$ > /sys/fs/cgroup/cgroup.procs
  # rmdir asdf/test0
  # grep usage_usec asdf/cpu.stat
  usage_usec 1006338

So, we run `stress -c 1` for 1 second in the asdf/test0 cgroup and
asdf/cpu.stat correctly reports the cumulative usage. After removing
asdf/test0 cgroup, asdf's usage_usec is still there. What's missing here?
What are you adding?

Thanks.

-- 
tejun
