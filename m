Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9111C2E69D7
	for <lists+cgroups@lfdr.de>; Mon, 28 Dec 2020 18:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgL1Rqu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Dec 2020 12:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbgL1Rqt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Dec 2020 12:46:49 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B83C061796;
        Mon, 28 Dec 2020 09:46:08 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id d14so9369396qkc.13;
        Mon, 28 Dec 2020 09:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=VbG+zWmEgZSccqMOdqNiSByvxNCbGh0yLNOk1f1Ikbg=;
        b=CJ5P1bSSL+8ExHCZ5JT4yd04Na/kEdSxzFPpPKJjoxZM1eUJxput5Ox5G37ptu+TEU
         q2LCCopmGNJPTYJZONTtPUeM3NkAlnRnM+sgzpBOdN1tBFh5cWNBACH20yIoLIPVdejv
         52SUA6Y0rGtkfFKWqzFMWyRfXsBtGYfXfIOcrj6W/NsCfAfsI+Qw78rcElhFoewWe5Rr
         /Mi9JOrvAtPFVy3o6y3pbIPwWgcQ92RaSb7gINmTIS9XpOK1K1HfiJ9lF5mGXkHAA32H
         HqNQYSuSK6732j45nCcjOi2AWUVZaADif9sLLnMwz3V3vIlLh3VJ6JbMZFg4FwZoSvGE
         jYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=VbG+zWmEgZSccqMOdqNiSByvxNCbGh0yLNOk1f1Ikbg=;
        b=MgZ4f3OWeygklWz7gl8E1ZaomiuVMMBLkTIEnNfldJReF53rlie4TEOjUkwQQi0SHb
         dX18fSgz1dEZ84Ids6gV6I5Fz2mrrGzLV9WnaHZNwNluEKlBQCiU3197fm3shgWmwt8p
         xhMKEDmmfEu310BnlB39sKs7ZM71w1YNrnx4HDdTfSTimYU8wHutPTRMdccHNTD5iUfG
         vtWAH1M1rpRUGMUyWZELuIAHE3YbsWxqFnjwrX9zBqOiFSFvmCZfPyS6sgHsOxOZlnz+
         kG8wGP63gGV/XYizE9+Q9BUyc/5yJKAvetg8QeGV0MmFg7cLwEM6fjcIFoSSWAAdeXHj
         3CLQ==
X-Gm-Message-State: AOAM531BpIXWq1ZukwtPJzHwS3Wxad7WapgloJHq4JJKMjhMD2RuXlx6
        i6ZhSwmXUNk6e+QELWd927g=
X-Google-Smtp-Source: ABdhPJxC2vPNG/AA5oTc38D/0KIJ2WSoPxSEi2CsbVJm/V9KjXs2gXNPe788Mb5zqJclTpUjaKtKiQ==
X-Received: by 2002:a37:6713:: with SMTP id b19mr43343979qkc.493.1609177568049;
        Mon, 28 Dec 2020 09:46:08 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id o30sm23051571qtd.24.2020.12.28.09.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 09:46:07 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 28 Dec 2020 12:45:28 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup changes for v5.11-rc1
Message-ID: <X+oZuAwO1/GcBeqy@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Linus.

These three patches were scheduled for the merge window but I forgot to send
them out. Sorry about that. None of them are significant and they fit well
in a fix pull request too - two are cosmetic and one fixes a memory leak in
the mount option parsing path.

Thanks and happy holidays!

The following changes since commit 127c501a03d5db8b833e953728d3bcf53c8832a9:

  Merge tag '5.10-rc5-smb3-fixes' of git://git.samba.org/sfrench/cifs-2.6 (2020-11-24 15:33:18 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.11

for you to fetch changes up to 2d18e54dd8662442ef5898c6bdadeaf90b3cebbc:

  cgroup: Fix memory leak when parsing multiple source parameters (2020-12-16 10:10:32 -0500)

----------------------------------------------------------------
Bhaskar Chowdhury (1):
      kernel: cgroup: Mundane spelling fixes throughout the file

Hui Su (1):
      cgroup/cgroup.c: replace 'of->kn->priv' with of_cft()

Qinglang Miao (1):
      cgroup: Fix memory leak when parsing multiple source parameters

 kernel/cgroup/cgroup-v1.c |  2 ++
 kernel/cgroup/cgroup.c    | 30 +++++++++++++++---------------
 2 files changed, 17 insertions(+), 15 deletions(-)

-- 
tejun
