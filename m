Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471292115B3
	for <lists+cgroups@lfdr.de>; Thu,  2 Jul 2020 00:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgGAWOu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jul 2020 18:14:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36375 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727004AbgGAWOu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jul 2020 18:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593641688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=glPotn+K1T613CjdKByq3iS5Ne25OlUyrCXDnz2IEJI=;
        b=h2UsJ/kzl2hlMn5H6dFCUGinFSCDzKMSDiN3kR8R0HGprdrE0tSmDVscrXvNbG6iSVFi2w
        pPImqykhqyeSoJxpdEoj2G80DRKvDcX2RPZBbLmpf3KbHosGeFPdOFwxvMafiPgJ9xyaeX
        onwS1+z1h3ie3rEkrUO48PCI/FSa4pA=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-0m-QKwMiNDyzONAFtUE_eQ-1; Wed, 01 Jul 2020 18:14:43 -0400
X-MC-Unique: 0m-QKwMiNDyzONAFtUE_eQ-1
Received: by mail-pg1-f197.google.com with SMTP id o15so19015765pgn.15
        for <cgroups@vger.kernel.org>; Wed, 01 Jul 2020 15:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=glPotn+K1T613CjdKByq3iS5Ne25OlUyrCXDnz2IEJI=;
        b=FqdD7FtreRVNe5tTDgCsRqRpwSBBwr/Pr6jYi0pZVCVFNrvuDzitymfLs0SGcMNvcw
         gE0gwxJRoO8ztipQjmWbmuVEKHeQ6BSl4b9hzK1Hx3Rl/UDnmoc9m5JAZ7udmdZcAvuZ
         LmClCHfAi1mJ4RT/Smq84PbO2VitPf+7yWkW0kvxU8J2/562ZXhr8pSCUA4Dla1KUJT/
         XeX3K5A6OOMhApLCynKSYF6RRnA+bgU9z2HNzuX5XmgClyZqDpbzAvuAqSGViCZStxTh
         IceN3QTHkztCCbYtIgXFT+EUbg6Fi3WMW6Rx9HyHJIDdSRk1qgsIR7QHQD5SxI5BT1ZP
         4ZTw==
X-Gm-Message-State: AOAM533i/PQ6DFl96LqyuZKk+2H1ijO6S7eXfxYxarVK1wC5yl7VDiYw
        AhPgYJp49x2uHzkaf6+oepTh2cS8BWv31sFQBTw87PVL7Y7NSPTGdbf0YuaNXpLg7AG+yXyR2Bx
        z1+CGJKP/A8A8gOAqwA==
X-Received: by 2002:a17:90a:c295:: with SMTP id f21mr17700633pjt.208.1593641681959;
        Wed, 01 Jul 2020 15:14:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPvPqACXXwd/bD0e/FXP/qE7VfvMYJ9AYKG238E3SOIkFKDcqV3tvp0NbqgZNbAots/y7ygA==
X-Received: by 2002:a17:90a:c295:: with SMTP id f21mr17700609pjt.208.1593641681705;
        Wed, 01 Jul 2020 15:14:41 -0700 (PDT)
Received: from localhost ([110.227.183.4])
        by smtp.gmail.com with ESMTPSA id i196sm6902130pgc.55.2020.07.01.15.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 15:14:41 -0700 (PDT)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org
Cc:     bhsharma@redhat.com, bhupesh.linux@gmail.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: [PATCH 0/2] arm64/kdump: Fix OOPS and OOM issues in kdump kernel
Date:   Thu,  2 Jul 2020 03:44:18 +0530
Message-Id: <1593641660-13254-1-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Prabhakar recently reported a kdump kernel boot failure on ThunderX2
arm64 plaforms (which I was able to reproduce on ampere arm64 machines
as well), (see [1]), which is seen when a corner case is hit on some
arm64 boards when kdump kernel runs with "cgroup_disable=memory" passed
to the kdump kernel (via bootargs) and the crashkernel was originally
allocated from either a ZONE_DMA32 memory or mixture of memory chunks
belonging to both ZONE_DMA and ZONE_DMA32 regions.

While [PATCH 1/2] fixes the OOPS inside mem_cgroup_get_nr_swap_pages()
function, [PATCH 2/2] fixes the OOM seen inside the kdump kernel by
allocating the crashkernel inside ZONE_DMA region only.

[1]. https://marc.info/?l=kexec&m=158954035710703&w=4

Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Reported-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>

Bhupesh Sharma (2):
  mm/memcontrol: Fix OOPS inside mem_cgroup_get_nr_swap_pages()
  arm64: Allocate crashkernel always in ZONE_DMA

 arch/arm64/mm/init.c | 16 ++++++++++++++--
 mm/memcontrol.c      |  9 ++++++++-
 2 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.7.4

