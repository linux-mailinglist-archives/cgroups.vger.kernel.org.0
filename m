Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DD55A5B57
	for <lists+cgroups@lfdr.de>; Tue, 30 Aug 2022 08:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiH3GAI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Aug 2022 02:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiH3GAH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 Aug 2022 02:00:07 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE4312D15;
        Mon, 29 Aug 2022 23:00:06 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id v5so3891834plo.9;
        Mon, 29 Aug 2022 23:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc;
        bh=qUSrr+Dj5JEyxXLU0zu9XCionGxLBWlgtmoR99MFjhQ=;
        b=FjZ0kPOazz55wM/uQwXnHAUHofevmUyS/fY5Hz9pws04EQKglg986u+lddR1MBRc9G
         JhOVc1ONM6hZeGw2sGMV8DtQCGEPaPSGYJlAE3j2M9fRp2J3R53+q3V4/ZLUfQk904XT
         0BA1sw4kr4vqPw4k02HrQD6uldwsF7nVrYd7e9NMkOr/e3zEC67KEAKtT44+xc9mUIxc
         glCfCRac7UFvijpundB+UUlCZwIAuNLfu+MRin/B7JuwhHAhnEu/5Wptuq9lmQfCdfH6
         nEv5wN1UV6Opd14YB/YIvNr9vvUZobL0C6Ozo8qY6k0eQ/7g/2n7LwYub6AXvivgh11d
         BiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=qUSrr+Dj5JEyxXLU0zu9XCionGxLBWlgtmoR99MFjhQ=;
        b=FtKh+XgdM+fXLunjgGvilnUcUkjvG5utlUZ7l/SJcSqorXvKuve9dCxgCyJofG72mW
         ze2iI3z/n14ut9mpkIsE9km5nH5vp9a/PBwPCmFVSMEGW0KaWbczzya7pgz6jFv0NodU
         0artty4eWR2ofuFz36wN19gOfWAjLGfSBxgdLxJ/Ag6xgWkoyw50sAZS4u60tPB6E/6q
         98JzJQkApOj5rNOmKFrRzxdB74ZixE5QlgcPueqYKzRTqqZMSO4ZcuO2Ju74rpPMX+so
         1A0mofxio6UsDUEie+6MvlqNE1dIGlA+ifL5ftm3nvyd908+U5LI/0K1LeZBrMNzT3m2
         VD3w==
X-Gm-Message-State: ACgBeo3uWdg5lj6vfUcLNanUlkQZUUFBRjwqXlDkT7ME5/zCB1avga7d
        YYYWI/wTLzrDpVHeXs/3co/ot3Gn0eyJkeGb
X-Google-Smtp-Source: AA6agR7u8R5s81ZyEwFILcQ8nuubO4ELAAl2cmAH/jIWx5Fgy9PdSMUWnnBoi4vl8ZQNbastjgKbZA==
X-Received: by 2002:a17:90a:d149:b0:1fb:6dfb:1fb8 with SMTP id t9-20020a17090ad14900b001fb6dfb1fb8mr21573583pjw.25.1661839205472;
        Mon, 29 Aug 2022 23:00:05 -0700 (PDT)
Received: from KASONG-MB0.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id m24-20020a17090b069800b001fd962747d4sm5311546pjz.30.2022.08.29.23.00.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Aug 2022 23:00:04 -0700 (PDT)
From:   Kairui Song <ryncsn@gmail.com>
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: [PATCH 0/2] mm: memcontrol: cleanup and optimize for accounting params
Date:   Tue, 30 Aug 2022 13:59:47 +0800
Message-Id: <20220830055949.12640-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

Patch 1/2 changes the behavior of kmem accounting a bit, making
it either globally enabled or globally disabled by boot params and
no longer affected by the creation of the first non-root cgroup.
This might be a bit arguable though.

Patch 2/2 optimizes some hot paths by making cgroup_memory_noswap a
static key, benchmark shows swap paths now have a ~4% lower overhead.

Kairui Song (2):
  mm: memcontrol: remove mem_cgroup_kmem_disabled
  mm: memcontrol: make cgroup_memory_noswap a static key

 include/linux/memcontrol.h |  8 +------
 mm/memcontrol.c            | 45 +++++++++++++++++++++++---------------
 mm/percpu.c                |  2 +-
 mm/slab_common.c           |  2 +-
 4 files changed, 30 insertions(+), 27 deletions(-)

-- 
2.35.2

