Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78ED53A2E22
	for <lists+cgroups@lfdr.de>; Thu, 10 Jun 2021 16:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhFJO3U (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Jun 2021 10:29:20 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:35429 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhFJO3T (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Jun 2021 10:29:19 -0400
Received: by mail-io1-f49.google.com with SMTP id d9so27203770ioo.2;
        Thu, 10 Jun 2021 07:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=YYyA+u2JrqmC9amIVXsT8BB5KdG2CQQsjkKxF0Ahoms=;
        b=dssxtbkSR9bCMY/1rfIRMRk1bu9I0aZD611EoRiJJlUeBPt50BdypNazxvdeuaM5+p
         XG2rykNMHVnJfDPHmFTF1RUHwjeXDcY6rdfLwbAH2Ob48Fl9DqwCM9ur0EHnskj0OSzW
         SBNMAt+XXHV2zqfUBTlI/aRRv3MLm7FDd/uTUSvtlMYWntF5c/q1oW2RL63T8UxgU6/9
         yRi6bx6jxwddTXg/exchgebgpfqFFDoI5EHT66y3UUdJiJc1m/fpNBEKHRreVZ119kTC
         nn8OWUOdVRyPKA9kZv0a7XORSD98YTo/VFm5LTze4UGfyMnH090KBytCJJJpNjkshgC0
         FOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=YYyA+u2JrqmC9amIVXsT8BB5KdG2CQQsjkKxF0Ahoms=;
        b=GV1cScXxa3ULqkP6cBsarKzf/dHpT2uYe+VdgBw5AHay+YglwZQp9I/NajDGwkKdkD
         HQqFkTwE10hGdOdiSBJZVDWdsUnla3/EQCQv1yB/wNRrqIWOU7fsPppIZjmHNEDIvnlQ
         H3w961d2AG/S7kSvtqDFyaLXzJl/x9cHC6X/YUoIA4C2F3W1LP5VLtJuDp73hcX3saKE
         Q6YJl7UAEE7AqFDoaH0NSLQOLw39qon/GQEY/fsw4smW80KLSIWRcU3dyQoZianq08o8
         nR8WXaFLVccSLTFPwwOtdechrV+LtrZ86edYe4SSuYieARwiOOacYzILf+KpJLzdxOpN
         ns3A==
X-Gm-Message-State: AOAM530aoF45Lv5oGgpBW46opYEOPsv9qOHNT+S/7EzmIy+tYSygDeKl
        C8zIZ7ykxmCqUFxq7YRi7xUzZwIPUGlKEw==
X-Google-Smtp-Source: ABdhPJxVBG1F/aIpEqMFdjnrOuXnhSCzlG0TOzkCufIT3N8u79qpz7zaHOdIBW31Zf6XpWwCV0L3PA==
X-Received: by 2002:a02:a815:: with SMTP id f21mr4931178jaj.118.1623335167618;
        Thu, 10 Jun 2021 07:26:07 -0700 (PDT)
Received: from localhost ([199.192.137.73])
        by smtp.gmail.com with ESMTPSA id r14sm1951382iod.41.2021.06.10.07.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 07:26:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 10 Jun 2021 10:26:06 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup fixes for v5.13-rc5
Message-ID: <YMIg/rC1TQwEbabA@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Linus.

This is a high priority but low risk fix for a cgroup1 bug where rename(2)
can change a cgroup's name to something which can break parsing of
/proc/PID/cgroup.

Thanks.

The following changes since commit 08b2b6fdf6b26032f025084ce2893924a0cdb4a2:

  cgroup: fix spelling mistakes (2021-05-24 12:45:26 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.13-fixes

for you to fetch changes up to b7e24eb1caa5f8da20d405d262dba67943aedc42:

  cgroup1: don't allow '\n' in renaming (2021-06-10 09:58:50 -0400)

----------------------------------------------------------------
Alexander Kuznetsov (1):
      cgroup1: don't allow '\n' in renaming

 kernel/cgroup/cgroup-v1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 8190b6bfc978..1f274d7fc934 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -820,6 +820,10 @@ static int cgroup1_rename(struct kernfs_node *kn, struct kernfs_node *new_parent
 	struct cgroup *cgrp = kn->priv;
 	int ret;
 
+	/* do not accept '\n' to prevent making /proc/<pid>/cgroup unparsable */
+	if (strchr(new_name_str, '\n'))
+		return -EINVAL;
+
 	if (kernfs_type(kn) != KERNFS_DIR)
 		return -ENOTDIR;
 	if (kn->parent != new_parent)
