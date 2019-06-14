Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD794688E
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2019 22:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfFNUC6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jun 2019 16:02:58 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39915 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfFNUC6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jun 2019 16:02:58 -0400
Received: by mail-qt1-f196.google.com with SMTP id i34so3910640qta.6;
        Fri, 14 Jun 2019 13:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XcuM7K9cI0UVePrxFlGBexaTFIUHFIVo5KkIzm6e+gw=;
        b=hLFC2FBQl6ExeriTXWpqg+lTQLNyx7oiqJlcJtW5p7dIVpNR/713tQHUmBcEmbF50g
         EM9hlT4xym5+VrGtWzQ3zMzigjQOpdKhkdgtmh6SoFGS9voFjFKXorSiHHiA8OUp0xZY
         q5IErmOUUZV06pBOmI23oJWEpQiiQ5Gcwpd66gYyLF58q0pXzUT1vIvNlQGDPk2SYPrY
         268F7qjTDcX6v1w53n7RS9r6Cab538jFbIO8QlgZQVkX63Mme8nOe6xDBYvzXZYHRyoY
         EbkWiwjsLghYr2OPfcQriM+zAFB6cMfj7Q28AJyD+ujDl3Vpu49wXOnOSFfjcG//wVvw
         9rAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=XcuM7K9cI0UVePrxFlGBexaTFIUHFIVo5KkIzm6e+gw=;
        b=dY7/MvoSAC/4kTA08s9AFHSm6ASUisN05M7u/xwQQxf5y9DmrTKBl6n5cZUJZu5hZp
         jkGVp+G3hKUCpwb44/hN5FHO0KNtv082SoSmKYy1kT5VmrK5b8xSQRm1a67BPwifg+uR
         cgFU8B51NI0JYvjpX7QGmES+QsLkTAbycYF3Oa5T5h5JFpMaAQlePOgX1MISzLlYUjMJ
         m7M8lwVT1G/NHbcI7YCDk3n+HDxFfaWjYWshBy3KHNRWm6fj8pnWm3z1hgIzMgG9Ycar
         gmGZH1Eq1i7JcAcisiLL1KsEiqGjtXb2yKCjrydLpR+KlGUP0zdF6sMgIWZUVu4vKVuI
         Y3TA==
X-Gm-Message-State: APjAAAVdJTHcoZwigWOgWCJZh4r4twoEBGtudeygEqmxqQke9l9r2P40
        MJ9pP93q4VJ7rtsoC1kxyRk=
X-Google-Smtp-Source: APXvYqyh4Ra8wjNBM8Atf0vg7dQRSKKzmRh5crQ9zIdXkJP4Xw4odpoGuXqurIf62VkSC6gvmR4NvQ==
X-Received: by 2002:ac8:264a:: with SMTP id v10mr50693866qtv.255.1560542577167;
        Fri, 14 Jun 2019 13:02:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::6bab])
        by smtp.gmail.com with ESMTPSA id p13sm1765815qkj.4.2019.06.14.13.02.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 13:02:55 -0700 (PDT)
Date:   Fri, 14 Jun 2019 13:02:53 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup fixes for v5.2-rc4
Message-ID: <20190614200253.GB657710@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

This pull request has unusually high density of tricky fixes.

* task_get_css() could deadlock when it races against a dying cgroup.

* cgroup.procs didn't list thread group leaders with live threads.
  This could mislead readers to think that a cgroup is empty when it's
  not.  Fixed by making PROCS iterator include dead tasks.  I made a
  couple mistakes making this change and this pull request contains a
  couple follow-up patches.

* When cpusets run out of online cpus, it updates cpusmasks of member
  tasks in bizarre ways.  Joel improved the behavior significantly.

Thanks.

The following changes since commit 9fb67d643f6f1892a08ee3a04ea54022d1060bb0:

  Merge tag 'pinctrl-v5.2-2' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl (2019-05-28 09:35:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.2-fixes

for you to fetch changes up to d477f8c202d1f0d4791ab1263ca7657bbe5cf79e:

  cpuset: restore sanity to cpuset_cpus_allowed_fallback() (2019-06-12 11:00:08 -0700)

----------------------------------------------------------------
Joel Savitz (1):
      cpuset: restore sanity to cpuset_cpus_allowed_fallback()

Odin Ugedal (1):
      docs cgroups: add another example size for hugetlb

Tejun Heo (6):
      cgroup: Use css_tryget() instead of css_tryget_online() in task_get_css()
      cgroup: Call cgroup_release() before __exit_signal()
      cgroup: Implement css_task_iter_skip()
      cgroup: Include dying leaders with live threads in PROCS iterations
      cgroup: css_task_iter_skip()'d iterators must be advanced before accessed
      cgroup: Fix css_task_iter_advance_css_set() cset skip condition

 Documentation/cgroup-v1/hugetlb.txt |  22 +++++---
 include/linux/cgroup-defs.h         |   1 +
 include/linux/cgroup.h              |  14 ++++-
 kernel/cgroup/cgroup.c              | 106 ++++++++++++++++++++++++++----------
 kernel/cgroup/cpuset.c              |  15 ++++-
 kernel/exit.c                       |   2 +-
 6 files changed, 117 insertions(+), 43 deletions(-)

-- 
tejun
