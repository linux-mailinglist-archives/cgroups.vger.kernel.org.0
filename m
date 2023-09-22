Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A479C7ABA20
	for <lists+cgroups@lfdr.de>; Fri, 22 Sep 2023 21:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbjIVSAL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Sep 2023 14:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbjIVR7e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Sep 2023 13:59:34 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5AE2698
        for <cgroups@vger.kernel.org>; Fri, 22 Sep 2023 10:57:44 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59c09bcf078so35353477b3.1
        for <cgroups@vger.kernel.org>; Fri, 22 Sep 2023 10:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695405463; x=1696010263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TWhlillKWVcEeVnrDyY8Q3IYayRPjR5OTdgTyF2A4S0=;
        b=KF/mZ9HKfn/WA0ZSf/lvAI/cCURUB5ub3z+0/CTXUMMlv+Tym0E4kqnaDycqPdIVzb
         Kzg/IyiwSilA9xiMNMXhEaf+Kti6bcrddodaJbrRYcALEiKJ3xPGVRNUoqKJYPL4sYe+
         8Wtdixfgwt4qHlbh6c/3jWY/1I7VWb1ERxPLo1zWs9CbxsCjzms5SodHdiLP7iVmDfTa
         0AC4QxCBiILwumu7weq3dLnxncip3+YMFKTLF7xZWLTjX+ENJzxRzUeuh63VRg5/Ei0Q
         lc/zIx8N+5pNxfFH2zacDEz/Ckqwji3fKULiTVnh46f5a0yC9ObEn6wTgdjff5datgEt
         mGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405463; x=1696010263;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TWhlillKWVcEeVnrDyY8Q3IYayRPjR5OTdgTyF2A4S0=;
        b=qb+1T1+fu/YwtkSfKFF12l7QvF/zL/p9AIHaU1g5tBQLr+9MRRsp44bM6thZsFcmbV
         9vV3SidQwQTrtpdgOv62Gdd4REpq1bvVXpo5RmzzM/ku/dGoIn+UBl34OUVP9lG8VMAE
         Z0wk8NqmeZqwYr8z1zjhUuZeE9EMNfa1H5uKI9jk60//wIBbg8yT7HteY9lOEdQQQujU
         FMfUO5+nK+Jwn67PGrxo0yMJQTxb8VVTsKYgg1cg/5OwIcuIsvig0hpcSN23qEz7uscq
         M8JC8CZNEuaeUvWul9eAfCgv7SB90MVqBJooexrlHCKS0LcMQbtZPZ/xihuBfdXYhxs1
         JRtg==
X-Gm-Message-State: AOJu0YzZu1NdbAoXWAWNxdGHY2ifoxp9GoZv9J0OXyjTQF+m+gYKrGYW
        +wqIJqCjMonVFp3GzWcu3s+ovJrQbXVSFFWK
X-Google-Smtp-Source: AGHT+IHEaQf18bKeGdlnoKYY1mRA3LamvJr+H7xbuexfhbmBx44hNVCD9XA/gUtzgCmW8MrZ2JYiKVQxx+nJcwLq
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a0d:ec49:0:b0:59b:d857:8317 with SMTP
 id r9-20020a0dec49000000b0059bd8578317mr6978ywn.2.1695405463484; Fri, 22 Sep
 2023 10:57:43 -0700 (PDT)
Date:   Fri, 22 Sep 2023 17:57:38 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922175741.635002-1-yosryahmed@google.com>
Subject: [PATCH v2 0/2] mm: memcg: fix tracking of pending stats updates values
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

While working on adjacent code [1], I realized that the values passed
into memcg_rstat_updated() to keep track of the magnitude of pending
updates is consistent. It is mostly in pages, but sometimes it can be in
bytes or KBs. Fix that.

Patch 1 reworks memcg_page_state_unit() so that we can reuse it in patch
2 to check and normalize the units of state updates.

[1]https://lore.kernel.org/lkml/20230921081057.3440885-1-yosryahmed@google.com/

v1 -> v2:
- Rebased on top of mm-unstable.

Yosry Ahmed (2):
  mm: memcg: refactor page state unit helpers
  mm: memcg: normalize the value passed into memcg_rstat_updated()

 mm/memcontrol.c | 64 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 13 deletions(-)

-- 
2.42.0.515.g380fc7ccd1-goog

