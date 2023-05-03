Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500C46F5133
	for <lists+cgroups@lfdr.de>; Wed,  3 May 2023 09:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjECHXt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 3 May 2023 03:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjECHXp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 3 May 2023 03:23:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEFC3C11
        for <cgroups@vger.kernel.org>; Wed,  3 May 2023 00:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683098576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IIZ/GCCJmx19uZ3mIOzJAELhL8g2Ju+C9RZzvBPp+14=;
        b=UlD8BqzR8DFk0puuZ5Ptlirl9D9/L/DVHBLKqcTnNFKDtMFfm0OEWH4T5GtMUCkvRBzQHh
        /S6TYuDVcPFEeU8nVxq5NL5ndbqUaZLq1x17aP/CyoAxuBgc6BGT0/wxl/pyPwTIxs/BK0
        TZ5JqXCGle5be3/PRNlx5cJe0CQXp9Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-bVEqMbNkOj6nXfqwYVdOFw-1; Wed, 03 May 2023 03:22:55 -0400
X-MC-Unique: bVEqMbNkOj6nXfqwYVdOFw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-306281812d6so1358565f8f.2
        for <cgroups@vger.kernel.org>; Wed, 03 May 2023 00:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683098574; x=1685690574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IIZ/GCCJmx19uZ3mIOzJAELhL8g2Ju+C9RZzvBPp+14=;
        b=fXaTV8LmXTsboDJUGHdRhnR2UBXImsTPT0vzp5OdRFgQN8gq56tSZQqD6IuV7GR3hN
         eUBP7u2ItPHalYwbghNXDjALx39IwXwDep2WNIkdqNAVXpDPLFsQ0YGrxo92B98npYDv
         iorAWs7vk6q9WtZC3+8XXX7GrVWkT53s0XEBb0nMKb3RzxkW4/Di5VDa3x7QLKvFEYgH
         b46A7pCCTuhGwZltQthkftSS2TTAor3p2i8jjPYyKAuS4cz2TuyTEo7z2+FGglqH2rOB
         Xa4X7nleOIE44l5cM3J2YDhmfFbifjYbqioTsad4kYnZ/DNT/ioYcL7R+UmkBOycRbbz
         lpMw==
X-Gm-Message-State: AC+VfDxINbQDSnPa7sWIcjx56t0NnhKrSq3SQRTI9I+pNdswOY9V9N7V
        43Kotfll+RXQ+M0VXGN/qOnFs6CLOwVkdLJzlXYRc8oHY0HVsBmU22XcjaeKf2jdwzFEm/eHD+U
        JvVKDDnbQwqKT1aOPiQ==
X-Received: by 2002:a05:6000:1191:b0:306:34f6:de8a with SMTP id g17-20020a056000119100b0030634f6de8amr3740022wrx.71.1683098573816;
        Wed, 03 May 2023 00:22:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ54zy8/SIcgpOp/BoRmdQDJsXfaF76CBFfxdPQZTW8HUw1yUuPWnpw6k9sR/S7c2WjN63x9jQ==
X-Received: by 2002:a05:6000:1191:b0:306:34f6:de8a with SMTP id g17-20020a056000119100b0030634f6de8amr3739998wrx.71.1683098573403;
        Wed, 03 May 2023 00:22:53 -0700 (PDT)
Received: from localhost.localdomain.com ([2a02:b127:8011:7489:32ac:78e2:be8c:a5fb])
        by smtp.gmail.com with ESMTPSA id k1-20020a7bc301000000b003eddc6aa5fasm947259wmj.39.2023.05.03.00.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 00:22:52 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v2 0/6] sched/deadline: cpuset: Rework DEADLINE bandwidth restoration
Date:   Wed,  3 May 2023 09:22:22 +0200
Message-Id: <20230503072228.115707-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Qais reported [1] that iterating over all tasks when rebuilding root
domains for finding out which ones are DEADLINE and need their bandwidth
correctly restored on such root domains can be a costly operation (10+
ms delays on suspend-resume). He proposed we skip rebuilding root
domains for certain operations, but that approach seemed arch specific
and possibly prone to errors, as paths that ultimately trigger a rebuild
might be quite convoluted (thanks Qais for spending time on this!).

This is v2 of an alternative approach (v1 at [3]) to fix the problem.

 01/06 - Rename functions deadline with DEADLINE accounting (cleanup
         suggested by Qais) - no functional change
 02/06 - Bring back cpuset_mutex (so that we have write access to cpusets
         from scheduler operations - and we also fix some problems
         associated to percpu_cpuset_rwsem)
 03/06 - Keep track of the number of DEADLINE tasks belonging to each cpuset
 04/06 - Use this information to only perform the costly iteration if
         DEADLINE tasks are actually present in the cpuset for which a
         corresponding root domain is being rebuilt
 05/06 - Create DL BW alloc, free & check overflow interface for bulk
         bandwidth allocation/removal - no functional change 
 06/06 - Fix bandwidth allocation handling for cgroup operation
         involving multiple tasks

With respect to the v1 posting [3]

 1 - rebase on top of Linus' tree as of today (865fdb08197e)
 2 - move patch 6 to position 4 - Qais

As the rebase needed some work, I decided to remove the tested and
reviewed bys. Please take another look, just in case I messed something
up.

This set is also available from

https://github.com/jlelli/linux.git deadline/rework-cpusets

Best,
Juri

1 - https://lore.kernel.org/lkml/20230206221428.2125324-1-qyousef@layalina.io/
2 - RFC https://lore.kernel.org/lkml/20230315121812.206079-1-juri.lelli@redhat.com/
3 - v1  https://lore.kernel.org/lkml/20230329125558.255239-1-juri.lelli@redhat.com/

Dietmar Eggemann (2):
  sched/deadline: Create DL BW alloc, free & check overflow interface
  cgroup/cpuset: Free DL BW in case can_attach() fails

Juri Lelli (4):
  cgroup/cpuset: Rename functions dealing with DEADLINE accounting
  sched/cpuset: Bring back cpuset_mutex
  sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets
  cgroup/cpuset: Iterate only if DEADLINE tasks are present

 include/linux/cpuset.h  |  12 +-
 include/linux/sched.h   |   4 +-
 kernel/cgroup/cgroup.c  |   4 +
 kernel/cgroup/cpuset.c  | 242 ++++++++++++++++++++++++++--------------
 kernel/sched/core.c     |  41 +++----
 kernel/sched/deadline.c |  67 ++++++++---
 kernel/sched/sched.h    |   2 +-
 7 files changed, 244 insertions(+), 128 deletions(-)

-- 
2.40.1

