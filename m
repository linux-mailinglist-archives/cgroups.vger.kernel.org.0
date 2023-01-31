Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B718D683922
	for <lists+cgroups@lfdr.de>; Tue, 31 Jan 2023 23:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjAaWR3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Jan 2023 17:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjAaWR2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Jan 2023 17:17:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB45460BA;
        Tue, 31 Jan 2023 14:17:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 119C1B81EB5;
        Tue, 31 Jan 2023 22:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072CBC433EF;
        Tue, 31 Jan 2023 22:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675203444;
        bh=PJSvYLHcRpS9dbzIMih0FP+oXT/wdW6kY7rfhEtLzKA=;
        h=From:To:Cc:Subject:Date:From;
        b=Ygi679fQSEyO7ZcNdesDQOCNvrDlqqi9yDKz0+2k+46LCplrJWbu3qpXPqlXlDrJG
         QY8NBhs15zL+jPwDO0nUDIOp+boS9DL3iHtCvLm7tMJhdw90KfyR/OJVb/HPVsrGtU
         8Ple7yv1+7V3P84CupQNlbh4jk5O+fFai9HoF0qEUQaaG0e94OfCG9D5GxC9d4SIGu
         lxHe3tEjzeARnmfifNmlcwkk7chXl4elUZsJg25f9dmss5Ec/GM7zWMdwjQaTM7LxJ
         ORI4ojxwz/tDR6G3fmco+u6Nf+tOIZ9mLTlzAnjoRVSwU/SzfAnJ5aK7vzthufb2A8
         F/6OV29psiVEQ==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: [PATCH 0/2] Fix broken cpuset affinity handling on heterogeneous systems
Date:   Tue, 31 Jan 2023 22:17:17 +0000
Message-Id: <20230131221719.3176-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi folks,

These two patches fix a couple of CPU affinity issues involving cpusets
on heterogeneous systems. A concrete example of this is running 32-bit
tasks on recent arm64 SoCs, where some of the cores are only capable of
64-bit execution.

The first patch (from Peter) fixes a regression introduced during the
recent merge window which is causing test failures in Android where the
problematic patches have been backported. The second patch fixes a
longer-standing issue, which I noticed while testing fixes for the
initial regression.

Ideally, both of these would land together, but fixing the regression
for 6.2 is my main concern.

Anyway, I don't think either Peter or I would call ourselves cpuset
experts (far from it!), so please have a look.

Cheers,

Will

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org

--->8

Peter Zijlstra (1):
  cpuset: Fix cpuset_cpus_allowed() to not filter offline CPUs

Will Deacon (1):
  cpuset: Call set_cpus_allowed_ptr() with appropriate mask for task

 kernel/cgroup/cpuset.c | 57 +++++++++++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 12 deletions(-)

-- 
2.39.1.456.gfc5497dd1b-goog

