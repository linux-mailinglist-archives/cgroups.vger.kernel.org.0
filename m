Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344501BCBF7
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2020 21:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgD1TBQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Apr 2020 15:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728795AbgD1S0l (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Apr 2020 14:26:41 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C43C03C1AB
        for <cgroups@vger.kernel.org>; Tue, 28 Apr 2020 11:26:40 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id r26so4016819wmh.0
        for <cgroups@vger.kernel.org>; Tue, 28 Apr 2020 11:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=UefID2OlDLM7XATtSz3mUqUNERRjSOJzh4SyUlDrdHk=;
        b=fv22xKHyOHTuLkg2qiGirsFBU8GgmId83+5knRJI3ydB77UUfZnOQLl2IPJwBd8Cn0
         XAFIqD+eY3wN8GeHQaKHks5K+pqC/P5KTWCZ8yKyOkcZ0KE8nLyWPaTNSXSx/A5phVBN
         4nvE4lcoWNruCSqXzVJoTXE3Sb9SMDUe6yi7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=UefID2OlDLM7XATtSz3mUqUNERRjSOJzh4SyUlDrdHk=;
        b=DieGJFii7qXnDZZLZCFRib8MftN3qqUjFf37ZqsONM2gMNHYOIQAehsfSctOAkHJ+s
         neYzC8iIY2jwBsML+XyRvu5cBP1/NhXzJBKuNPz06RUShi24ahMnTt3E7+gkylNINUrT
         cXJgucvHTqxqldauh24p3xq48bcsCzfOyXEvohengYtT8e1zTkmwGBy9hcaUcRjqZvFG
         MnMRLnwigYeI+bfjVQuc51THZcikrMDH3qk7dGipJbDvMhVwhScGOuoS6Sivpw/5lC6l
         lK5MxyHIYGq3+msGvhkSYL310VnYBCXmrXk1R6x51d//K7vVnoM1y4tTAgf/IsF5ni67
         da5w==
X-Gm-Message-State: AGi0PuZczBKog2p9rsVoOL/6RPpRq43SM37vx1lhm1XWRcVBhRv5/vdK
        gmOrd6ZvJtFgL0yeRHdGkMf9xQ==
X-Google-Smtp-Source: APiQypLHoWk0qTwfpysUzM0q8vA2b+q+WLZCal3lFGsR0gVIyDEiREhK+8Cbm3Rdke/9HeCCnL2MFw==
X-Received: by 2002:a1c:7415:: with SMTP id p21mr5807501wmc.93.1588098398739;
        Tue, 28 Apr 2020 11:26:38 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:56e1:adff:fe3f:49ed])
        by smtp.gmail.com with ESMTPSA id q187sm4316031wma.41.2020.04.28.11.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 11:26:37 -0700 (PDT)
Date:   Tue, 28 Apr 2020 19:26:37 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mm: memcontrol: memory.{low,min} reclaim fix & cleanup
Message-ID: <cover.1588092152.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This series contains a fix for a edge case in my earlier protection
calculation patches, and a patch to make the area overall a little more
robust to hopefully help avoid this in future.

Chris Down (1):
  mm, memcg: Decouple e{low,min} state mutations from protection checks

Yafang Shao (1):
  mm: memcontrol: memory.low reclaim fix & cleanup

 include/linux/memcontrol.h | 48 +++++++++++++++++++++++++++++---------
 mm/memcontrol.c            | 43 ++++++++++++++++------------------
 mm/vmscan.c                | 17 ++++----------
 3 files changed, 61 insertions(+), 47 deletions(-)

--
2.26.2

