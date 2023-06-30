Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A2B74452D
	for <lists+cgroups@lfdr.de>; Sat,  1 Jul 2023 01:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjF3XXW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Jun 2023 19:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjF3XXU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Jun 2023 19:23:20 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E896246BD
        for <cgroups@vger.kernel.org>; Fri, 30 Jun 2023 16:22:42 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fba5a8af2cso25365445e9.3
        for <cgroups@vger.kernel.org>; Fri, 30 Jun 2023 16:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1688167360; x=1690759360;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VK1/OtAJXK8/kraYa6/U+8C0ZuqhuzcqNzn9O4FJGas=;
        b=JIyBKNtRrCvh1/J0Aia88RunCnBe34DcvcRR/xqkto9DKiP0CoJsMe9AEsMrcocQXa
         KXzU0xeE8Ynn4vsjVq6S/1cSMppdCM5vHTv6cycRYhKMbtS8osvCknVpybopDo8HlGmS
         2aY3f2gRBCcrD1RClb7o73Cvr+nsmVkDEnhIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688167360; x=1690759360;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VK1/OtAJXK8/kraYa6/U+8C0ZuqhuzcqNzn9O4FJGas=;
        b=fBRYkIUqwkoevuYfbGlbnPnvdWH6x6CFisIaiTOIPhni25LaQ6f+si2RGNOGREualf
         8hpgnsurzuz4PmjMn3lvIl0s6CIAaIzYf3HWyAKC5x9dAVec03F7g40uHncRVaIvuNEt
         /Lh9/ISEyhRqGokMPPuOG0rcgk5XkqbAPdZp+muRDe5QIYzz7rMhceemseOu03583olo
         scTFpBHlRp84V41dZhC9xOcqwIOgVa5Dvvj+Pn5IljDeJENLgY4NX1icWBW1BcwoAQTd
         e7xTzljlvAYJSdhInVeMvAMh5T3YhZ+S12/S0Nsb/wrW21a7cAkd7sMgsQczUvO/fP4O
         R1Mg==
X-Gm-Message-State: AC+VfDwjBDiTsFQqywLT3Vjoj5dPZyialax7YGZ7g1spxybriVXlASXW
        rZ0F8kulrNwGWzoxkFEOrDyaRVMmNofeHjTtNV7LW9RbpAGeHg9XYT8=
X-Google-Smtp-Source: ACHHUZ6SNvsiIRzbKttRMIOu9i80rwHHJPSkwI+4sREgWXjA5v7EnjfhxpCc0WUYy7+esb0YOLV26PhKyYmeg8Pfgl4=
X-Received: by 2002:a05:600c:221a:b0:3f4:a09f:1877 with SMTP id
 z26-20020a05600c221a00b003f4a09f1877mr2789670wml.23.1688167360268; Fri, 30
 Jun 2023 16:22:40 -0700 (PDT)
MIME-Version: 1.0
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Fri, 30 Jun 2023 16:22:28 -0700
Message-ID: <CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com>
Subject: Expensive memory.stat + cpu.stat reads
To:     cgroups@vger.kernel.org
Cc:     Linux MM <linux-mm@kvack.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

We're seeing CPU load issues with cgroup stats retrieval. I made a
public gist with all the details, including the repro code (which
unfortunately requires heavily loaded hardware) and some flamegraphs:

* https://gist.github.com/bobrik/5ba58fb75a48620a1965026ad30a0a13

I'll repeat the gist of that gist here. Our repro has the following
output after a warm-up run:

completed:  5.17s [manual / mem-stat + cpu-stat]
completed:  5.59s [manual / cpu-stat + mem-stat]
completed:  0.52s [manual / mem-stat]
completed:  0.04s [manual / cpu-stat]

The first two lines do effectively the following:

for _ in $(seq 1 1000); do cat /sys/fs/cgroup/system.slice/memory.stat
/sys/fs/cgroup/system.slice/cpu.stat > /dev/null

The latter two are the same thing, but via two loops:

for _ in $(seq 1 1000); do cat /sys/fs/cgroup/system.slice/cpu.stat >
/dev/null; done
for _ in $(seq 1 1000); do cat /sys/fs/cgroup/system.slice/memory.stat
> /dev/null; done

As you might've noticed from the output, splitting the loop into two
makes the code run 10x faster. This isn't great, because most
monitoring software likes to get all stats for one service before
reading the stats for the next one, which maps to the slow and
expensive way of doing this.

We're running Linux v6.1 (the output is from v6.1.25) with no patches
that touch the cgroup or mm subsystems, so you can assume vanilla
kernel.

From the flamegraph it just looks like rstat flushing takes longer. I
used the following flags on an AMD EPYC 7642 system (our usual pick
cpu-clock was blaming spinlock irqrestore, which was questionable):

perf -e cycles -g --call-graph fp -F 999 -- /tmp/repro

Naturally, there are two questions that arise:

* Is this expected (I guess not, but good to be sure)?
* What can we do to make this better?

I am happy to try out patches or to do some tracing to help understand
this better.
