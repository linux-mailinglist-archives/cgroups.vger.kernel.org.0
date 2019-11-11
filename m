Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16345F810C
	for <lists+cgroups@lfdr.de>; Mon, 11 Nov 2019 21:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfKKUWI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Nov 2019 15:22:08 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40954 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbfKKUWH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Nov 2019 15:22:07 -0500
Received: by mail-qt1-f194.google.com with SMTP id o49so17057268qta.7;
        Mon, 11 Nov 2019 12:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Xeq2lcRUVceDqmGyTHaj5d+0Pjk/GmEvYbMYOaMNQzg=;
        b=I+isjLS5f/apV9ftRVQ09plliCCSpaqV3/UG7fSAdpU4mXCS9TaslJ2OzYYcJa+j4n
         QSq2fKk559J9ZwzNBSmRcRWOqDKtJFMut2l4D4AysPeV4nNRjuINtm0bSDdbt9IW5WqH
         fk7DBoj1Gfk75bFq/L1incchih0DAFe4toGXAMySezDb4h0C8qnQ85GO/CZmhr7Xmn2Z
         YmkIWBnZ5XrTRzEhwYSUSYhKq4/mrelNXQJIAWahBjVhyaHz09RNaDbErBL8JsSE/2Fm
         nF7x3JxoNiQc4F8UFz+deld6cUww6o5u4xPk2EwGcjDPCXrN1kQZ4MIem70TJeY2ZEmj
         Rchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Xeq2lcRUVceDqmGyTHaj5d+0Pjk/GmEvYbMYOaMNQzg=;
        b=WDtNaI/JGyYRTR04uW+IxzxoiRZdJG01GReahRFuLYF7j6gvUDhNkkY7KrHZUw4PWn
         mVy7htEpiQKIpCCuFxg1TRsoTmTyAuzDah3t4HKfyv9KoQkNCIswL/m0ZRPBWRl+4sR9
         eBoDnlLV39VzxYxx/0mNgdpLUPYfNgTMbdZ/NqxQV1go4S1ABmk4P8uR4r3HATQIR7nd
         2t/w/3CfGg5lt577XD7OUr3KKr58RkUsPMcd9MxA15kpVA51KEU6C6MgR2zNEoeTLsdP
         Cam51SKpY6R3VEY+h7m5MEBiMBdTyvJm2nfRPRIjKHhW3q9rpKUU0i5DcZ9qIMprBSUd
         x2qQ==
X-Gm-Message-State: APjAAAVsje4oQLs74AzCHqmQiJUi97udJQ0yGmpO9lKH/z2vMk9t9EYb
        mo5411ZF8JwkSqM/TH49mIjHRaAG
X-Google-Smtp-Source: APXvYqwa00JjUN0TOeR6m2QaHZ1qxjWiq2WnqYCIB/Dud8d6Y2hjnVEpkXsiVWMbx5a69qCX7z3+Ng==
X-Received: by 2002:ac8:1084:: with SMTP id a4mr28347343qtj.114.1573503726517;
        Mon, 11 Nov 2019 12:22:06 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:d6e0])
        by smtp.gmail.com with ESMTPSA id n49sm9587576qtk.94.2019.11.11.12.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 12:22:05 -0800 (PST)
Date:   Mon, 11 Nov 2019 12:22:03 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup fixes for v5.4-rc7
Message-ID: <20191111202203.GC4163745@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Linus.

Sorry, I sat on this for too long.

There's an inadvertent preemption point in ptrace_stop() which was
reliably triggering for a test scenario significantly slowing it down.
This pull request contains Oleg's fix to remove the unwanted
preemption point.

Thanks.

The following changes since commit 9e208aa06c2109b45eec6be049a8e47034748c20:

  Merge tag 'xfs-5.4-fixes-3' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux (2019-10-10 11:47:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.4-fixes

for you to fetch changes up to 937c6b27c73e02cd4114f95f5c37ba2c29fadba1:

  cgroup: freezer: call cgroup_enter_frozen() with preemption disabled in ptrace_stop() (2019-10-11 08:39:57 -0700)

----------------------------------------------------------------
Oleg Nesterov (1):
      cgroup: freezer: call cgroup_enter_frozen() with preemption disabled in ptrace_stop()

 kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index c4da1ef56fdf..bcd46f547db3 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2205,8 +2205,8 @@ static void ptrace_stop(int exit_code, int why, int clear_code, kernel_siginfo_t
 		 */
 		preempt_disable();
 		read_unlock(&tasklist_lock);
-		preempt_enable_no_resched();
 		cgroup_enter_frozen();
+		preempt_enable_no_resched();
 		freezable_schedule();
 		cgroup_leave_frozen(true);
 	} else {

-- 
tejun
