Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B334968F304
	for <lists+cgroups@lfdr.de>; Wed,  8 Feb 2023 17:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBHQSD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Feb 2023 11:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBHQSC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Feb 2023 11:18:02 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CAD10FD;
        Wed,  8 Feb 2023 08:17:50 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id ay1so13436913pfb.7;
        Wed, 08 Feb 2023 08:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tzqq5s709T6l/w+9pi74lxvpe8BbE2WIdW1BUQhpDbQ=;
        b=noT7JHKssXq5HEmHAxZXC82FcLwo5xxQtOr1L4ExZ113d77QoohSj2CtErhGNEPtNd
         DmtzNw8zA34e6E8miyKkEx44kh6DySdQBGI/sfJoVSWoh3ZT6J2LfEVc2A9CFTscmziJ
         x3UJauD26xL2f6CCeEOAjHeSy4ja/vBftnMF+2osuOJjr/S7tqbZbEPlMEOdx4zl13IM
         BT05bjXcVILKBEJtE8WA7bJ7DzeL7Xp992kAjhLFuJ2Uden55LIMRM3meXYvwx8LmF8v
         be44fgwHbzaZo8IeeFceI70f3HPCYFsMzdE8Nj2GelKZHOXurCHDdi8vSb/LDY1zAOPq
         Zazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tzqq5s709T6l/w+9pi74lxvpe8BbE2WIdW1BUQhpDbQ=;
        b=cdfCrmaWkMM7uEhMXlWDkFHv6qYn/9bOvL6zvv4B9UBJKTyaciQFgaQ+ibhRqnrARl
         NBsW10HCQkxr/ZhTXXXSAFReZ5bleUm//o14cEYrPba03q7txspApu3xNYQ45R/fX6Ps
         qyCnLnJOSFBlSRn0V9ckaUyqTpdUDj+tAG1Qpa3tAd/UavQWDufy37xYNwqDmHvqvS+k
         g2xqo6afAN7HAzU0OOkZb7fm0G5BwHzhI4v7XUvtT1BBeOaBRWtMBKQ1y2bZIslrswap
         yoZkUIx7ZyZ8At0EQAAUVK+u3xuOU2wNoxO+vaSTZ3ZBpT+HPaGLz4CFT5SGxCBuPrxK
         aMpw==
X-Gm-Message-State: AO0yUKXOk4b2LUdUCnSn24EN2W1384/hE08uPPZ8YDWBQN5Pg7FFa77b
        5gAHfmV61bMj2+Tw/13PlRc=
X-Google-Smtp-Source: AK7set/8u8YZTzLDbOVqmCRq2fyR6KeVccW7laagNbwPWfKBO5yOmaNZEbg697DLNVa/Au+w8hgTew==
X-Received: by 2002:a62:1792:0:b0:592:705a:5a5e with SMTP id 140-20020a621792000000b00592705a5a5emr6712838pfx.9.1675873069577;
        Wed, 08 Feb 2023 08:17:49 -0800 (PST)
Received: from KASONG-MB0.tencent.com ([115.171.40.195])
        by smtp.gmail.com with ESMTPSA id s21-20020a056a00195500b0059252afc069sm11445485pfk.64.2023.02.08.08.17.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Feb 2023 08:17:48 -0800 (PST)
From:   Kairui Song <ryncsn@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kairui Song <ryncsn@gmail.com>
Subject: [PATCH 0/2] sched/psi: Optimize PSI iteration
Date:   Thu,  9 Feb 2023 00:16:52 +0800
Message-Id: <20230208161654.99556-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi all,

Patch 1/2 simplify cgroup_psi, I didn't see a measurable performance
change with this.

Patch 2/2 removed the cache, I just noticed it have the same hierarchy
as the cgroup it's in, so I wondered if it worth adding a cache just for
simplifying the branch, and if we can balance the branch simplification
and minimize the memory footprint in another way, it seems this is
doable.

After the two patches, I see a measurable performance gain
using mmtests/perfpipe:

(AVG of 100 test, ops/sec, the higher the better)
KVM guest on a i7-9700:
        psi=0         root cgroup   5 levels of cgroup
Before: 59221         55352         47821
After:  60100         56036         50884

KVM guest on a Ryzen 9 5900HX:
        psi=0         root cgroup   5 levels of cgroup
Before: 144566        138919        128888
After:  145812        139580        133514

Kairui Song (2):
  sched/psi: simplify cgroup psi retrieving
  sched/psi: iterate through cgroups directly

 include/linux/psi.h       |  2 +-
 include/linux/psi_types.h |  1 -
 kernel/cgroup/cgroup.c    |  7 +++++-
 kernel/sched/psi.c        | 45 ++++++++++++++++++++++++++++-----------
 4 files changed, 39 insertions(+), 16 deletions(-)

-- 
2.39.1

