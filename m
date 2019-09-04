Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C94ABA9279
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2019 21:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfIDTqC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Sep 2019 15:46:02 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43945 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfIDTqC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Sep 2019 15:46:02 -0400
Received: by mail-qt1-f196.google.com with SMTP id l22so13599370qtp.10;
        Wed, 04 Sep 2019 12:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=PXmGfQo6neOlWgmykljZagbJmoHVSlvd5lTMWMsizwM=;
        b=QCZLciyop0aVFo7y3eUWYwt/dAOgH9EHQhPsURPxfFrz963UhondyfnfVJlm5Irs0p
         5SQHRH6fK7+gJHEIPCtM6fkDwAxAREkPGiiev0r3QCLM4aGH4PFydtMEw5T+1dm9B4Gh
         PMPBoOUkKrisr6T/O7sRUGxemAeW+Fnsqb27SoTJUkCnpcdmU4kYbysvqhe5Jlk5EuZu
         MIhCKiKHM7FYt91Ji8jdBoJTVuY1SdyTRsa6Hfyo2P1J21BaXOlpNJvO6aaOA2Osda1G
         rbhVIz380w3pu+qKBZCUNTdf/IzfHFgQaEhvrxeOf+Z4NBKswArkr+tRU6ziV5xi8b2Z
         ntfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=PXmGfQo6neOlWgmykljZagbJmoHVSlvd5lTMWMsizwM=;
        b=YGt4+5K7P8HkUODtZoyLIeefAyqmz91F+8TQm0pIsCairO3Ux2LTJQJCp/NBwPxMO6
         CeAJtZe7Rjl+eFmHSbJsWB/0URN4AAfpVj9c+1HUNwFMy3Fj64k5AIhoXM5ZaFYZVv5g
         ZY6y3ZS+Uyo70YQfoUNhw/oxQawkBHCxCTg/YJd3vf3axSI73dwICC3oJbtlNpJoZhh3
         p02M0BLiI8Ksmf3nSeduSSfglYgvC0kAygeW9Nh+7iSwVdaewZ1x1CdLUJ6EFAZfUyL3
         tTyU773mimIg2a7XKR0FtSB49wpG4ZtCei8XD+rorFyX+YU0Uz8Dyqet6xwqurFxZp9u
         HYIg==
X-Gm-Message-State: APjAAAWvfyznn5xAMeNhQ9CWyvfwqzmo5qGULm87btzYsr7B5iitmpMU
        eCzgZaXBb9hDKw+oVOvy1es=
X-Google-Smtp-Source: APXvYqzXHLxXvhP5kmx3bfAyp/4yIyN8kWaynGS9RpObYYtOCt6bYibi+Z2TbwTgtPNmSzEJeaLIhA==
X-Received: by 2002:ac8:67d4:: with SMTP id r20mr40317147qtp.215.1567626360346;
        Wed, 04 Sep 2019 12:46:00 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:33b1])
        by smtp.gmail.com with ESMTPSA id n12sm2818589qkk.78.2019.09.04.12.45.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 12:45:59 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@vger.kernel.org, cgroups@vger.kernel.org,
        newella@fb.com
Subject: [PATCHSET block/for-next] blk-iocost: Implement absolute debt handling
Date:   Wed,  4 Sep 2019 12:45:51 -0700
Message-Id: <20190904194556.2984857-1-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently, when a given cgroup doesn't have enough budget, a forced or
merged bio will advance the cgroup's vtime by the cost calculated
according to the hierarchical weight at the time of issue.  Once vtime
is advanced, how the cgroup's weight changes doesn't matter.  It has
to wait until global vtime catches up with the cgroup's.

This means that the cost is calculated based on the hweight at the
time of issuing but may later be paid at the wrong hweight.  This, for
example, can lead to a scenario like the following.

1. A cgroup with a very low hweight runs out of budget.

2. A storm of swap-out happens on it.  All of them are scaled
   according to the current low hweight and charged to vtime pushing
   it to a far future.

3. All other cgroups go idle and now the above cgroup has access to
   the whole device.  However, because vtime is already wound using
   the past low hweight, what its current hweight is doesn't matter
   until global vtime catches up to the local vtime.

4. As a result, either vrate gets ramped up extremely or the IOs stall
   while the underlying device is idle.

This patchset fixes the behavior by accounting the cost of forced or
merged bios in absolute vtime rather than cgroup-relative.  This
allows the cgroup to pay back the debt with whatever actual budget it
has each period removing the hweight discrepancy.

Note that !forced bios' costs are already accounted in absolute vtime.
This patchset puts forced charges on the same ground.

This patchset contains the following five patches and is on top of the
current linux-block.git for-next 35e7ae82f62b ("Merge branch
'for-5.4/block' into for-next").

 0001-blk-iocost-Account-force-charged-overage-in-absolute.patch
 0002-blk-iocost-Don-t-let-merges-push-vtime-into-the-futu.patch
 0003-iocost_monitor-Always-use-strings-for-json-values.patch
 0004-iocost_monitor-Report-more-info-with-higher-accuracy.patch
 0005-iocost_monitor-Report-debt.patch

0001-0002 implement absolute debt handling.  0003-0005 improve the
monitoring script and add debt reporting.

This patchset is also available in the following git branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git iocost-vdebt

diffstat follows.  Thanks.

 block/blk-iocost.c             |   93 +++++++++++++++++++++++++++++++++--------
 tools/cgroup/iocost_monitor.py |   61 ++++++++++++++------------
 2 files changed, 110 insertions(+), 44 deletions(-)

--
tejun

