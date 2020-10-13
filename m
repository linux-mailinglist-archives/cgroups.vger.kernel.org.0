Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DBF28CFD1
	for <lists+cgroups@lfdr.de>; Tue, 13 Oct 2020 16:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388242AbgJMOHI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Oct 2020 10:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388196AbgJMOHI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Oct 2020 10:07:08 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D9BC0613D0;
        Tue, 13 Oct 2020 07:07:07 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id de3so43854qvb.5;
        Tue, 13 Oct 2020 07:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=zlJunIPW8Wajc0MiN91i37/1o2rvLQm/+3y/Aoom9SU=;
        b=nsZug78+5p7pGKmm3DsDTOBfTQHjEv5AvUhIvb5ixEWe/iSqrf6Z/zZyayKI+2iRPK
         MVbDBepFDBAfZ+kDIDXs6LK/CkLLlbfCZDSX6IM6CZFBfDhiodhl3Z4t4yxLo8A9Hph+
         g+5rw80BsqfDOzW+U7wZmFf4Nmt2BWUktKEB3i1KpzXeLmuIQl/C5FKk0U8hMtwRqvIG
         UuLcG4GpzbkDTL8oXHK7Rpv1nEj4RuAmOJ/m6iLK6zLGUb66NgsZeTi60cv6ZrRWSPiq
         pY5j1LdT9TQhVMD8iOzG3VA+S3JpRe29B3PBLx+UR4TpFULac0bkFMMs6W3JvOkz7Uoh
         LCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=zlJunIPW8Wajc0MiN91i37/1o2rvLQm/+3y/Aoom9SU=;
        b=lsFN5iPAIFChYEaJyHEMJXy/Bh7Xd71W2LFItXVvbT0F6sw9nufSBY6JGUISDmj+4N
         5xEJVqe2xSpibygQcmuYyO7PCuGwVfHqOkcBxk+l4hA6CmJW/clbydSSaPE6nvQ1W/0+
         bRE0wFioUj8FizEOU0WfmmKD15Dmtfp1FILlu3zMcdlA+eTYtSdy3Vwv3H/uFpPKLPEZ
         A+eZtGzploH/6tVhYoQifX0aLSSTgKig/yvjQBrvMTqplc0bD69uTRe5KgU/qsxpIyud
         PMEaIDNuj05o4eAz8/tO/L2iyQucu2mMwhWkK5VlZKQtGePIGKysB5OYHhR/HsnncGoD
         lJBA==
X-Gm-Message-State: AOAM530KRAu1B257HUe8S9OxRKgyU/DdZIHSU3D51JBlZK2XkvE7k0yJ
        7RYdLDSW0MTyvpxoSdyWDzI=
X-Google-Smtp-Source: ABdhPJzDNQiUNhFKePXipvWMwQCDi4CxW+qZGiarrZgLj8CrGxdwMuvHGb0Lvc6pUxy5898u1VzCzA==
X-Received: by 2002:a05:6214:152:: with SMTP id x18mr74300qvs.41.1602598026311;
        Tue, 13 Oct 2020 07:07:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:d88e])
        by smtp.gmail.com with ESMTPSA id e4sm12149790qkb.4.2020.10.13.07.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 07:07:05 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 13 Oct 2020 10:07:03 -0400
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] cgroup changes for v5.10-rc1
Message-ID: <20201013140703.GA3845@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Linus.

Two minor changes. One makes cgroup interface files ignore 0 sized writes
rather than triggering -EINVAL on them. The other change is a cleanup which
doesn't cause any behavior changes.

Thanks.

The following changes since commit 02de58b24d2e1b2cf947d57205bd2221d897193c:

  Merge tag 'devicetree-fixes-for-5.9-3' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux (2020-09-29 17:56:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.10

for you to fetch changes up to 65026da59cda16baf6c3e98b74ec439f366e468f:

  cgroup: Zero sized write should be no-op (2020-09-30 13:52:06 -0400)

----------------------------------------------------------------
Jouni Roivas (1):
      cgroup: Zero sized write should be no-op

Wei Yang (1):
      cgroup: remove redundant kernfs_activate in cgroup_setup_root()

 kernel/cgroup/cgroup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
tejun
