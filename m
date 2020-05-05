Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45ECA1C50A0
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2020 10:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgEEImM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 May 2020 04:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbgEEImM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 May 2020 04:42:12 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D1CC061A0F;
        Tue,  5 May 2020 01:42:12 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h12so921450pjz.1;
        Tue, 05 May 2020 01:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3Y0v2e1Lb5wtzzcdYvvYnMyMMtu+m1Dmqf+0QoZUhSA=;
        b=W8I+ypz+cgycacfqwemetGRj30vIPDplypv2/Xw57pculAjHckI9bGny/k3mNTwZSw
         mWH6WTxtwICdRj5L6uZO4Ldj3URk8KnAGufc8LmnraYmECPwDY+K5xkPJ2MOFth3h7Pu
         NoJpF3Mg1ycdxynBawfjuBzhVfLqsMoeYA697UtPbu928uNV+lREnMfVTogtTXyZCGqz
         3rDrKnQbd8Ugaf+vPfa3bOHr4iVK19wF39eyEes0GzcOqz/H2DLBfjVkvPb7a/ASr0/i
         4Axs85+ravwposSptCnI0lJITCWWR+uCwK2ridpnaWSCpSsaxraQ0c/VXCWJmIj1UuOC
         Qqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3Y0v2e1Lb5wtzzcdYvvYnMyMMtu+m1Dmqf+0QoZUhSA=;
        b=ITaCyTAmzqy8j649j9nKvm+9k9ZTC9Yr22avn6vWt59RGrFwDocEYCXY25tbuCvLDm
         ELx/ksvrmPpe3lvUm3+D74nEOTBxWZBqdGAeEelfCzmUlDkvSBp8ABLuTNOrDBA3yONj
         vsOkI+69bAEBD6Ve22okk8ECxA4KmPQnGjCaHS4y1MlI7RvAOttZIKYvr7bFswyr8SBo
         sJ8ALIbsSddo+XoZeafPvuwUHDg57T5gljVU1SjiW7/7PGoPXyMhGsQSsWmVAinIM+wf
         Zi2r3bYq+3Zx0rl+VIaNX9g5MAm03j6ZUxqzWjMBnU+bcWmzyy8KCeE374LQLYhn9ID8
         RjTw==
X-Gm-Message-State: AGi0PuanD59MJvWIEWT4VSShNguwDd8+qw92VZvfwFgnksLLZ8aufOmC
        0neXtikZ6fMwjcDWC3udJ9c=
X-Google-Smtp-Source: APiQypJe86ksUq/JAGwIY1F0YkpbSYUnxzodqwNL6d+yuiHFDb2CMphwQrg9xwf5ognUlD3wIGaeUQ==
X-Received: by 2002:a17:902:b114:: with SMTP id q20mr1885097plr.120.1588668131523;
        Tue, 05 May 2020 01:42:11 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id p190sm1443802pfp.207.2020.05.05.01.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 01:42:10 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, hannes@cmpxchg.org, chris@chrisdown.name,
        guro@fb.com, linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 0/2] mm: memcontrol: memory.{low,min} reclaim fix & cleanup 
Date:   Tue,  5 May 2020 04:41:25 -0400
Message-Id: <20200505084127.12923-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.18.1
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This series contains a fix for a edge case in my earlier protection
calculation patches, and a patch to make the area overall a little more
robust to hopefully help avoid this in future.

[chris@chrisdown.name: commit log above]

Changes since v2: commit log improved by Michal.

Chris Down (1):
  mm, memcg: Decouple e{low,min} state mutations from protection checks

Yafang Shao (1):
  mm, memcg: Avoid stale protection values when cgroup is above
    protection

 include/linux/memcontrol.h | 85 ++++++++++++++++++++++++++++++++------
 mm/memcontrol.c            | 36 +++++++---------
 mm/vmscan.c                | 20 +++------
 3 files changed, 93 insertions(+), 48 deletions(-)

-- 
2.18.2

