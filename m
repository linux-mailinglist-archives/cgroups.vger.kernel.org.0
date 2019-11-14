Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47191FD12C
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2019 23:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKNWyM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Nov 2019 17:54:12 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44993 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfKNWyM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Nov 2019 17:54:12 -0500
Received: by mail-qk1-f194.google.com with SMTP id m16so6539154qki.11;
        Thu, 14 Nov 2019 14:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XRuK6d7TnHtLQBOfr1sWZbQMCgbijX/fPo8dKPOxUls=;
        b=hNHpsL9SI8tkmXRDnJ6SofChw4EGguY7Ld+bMb4T6laRexKpu3RuJzK0JBK27sIkns
         oP8bU+fX4FNl8grxlbg30jPD6X3Oi7kMqGRN9nvULSiW8PZCTVwjAyfefaISq4Po5MBw
         gR/IYgZUI3ENRxoTml7vlWhMJtbir4YEDVxKtkrAr+hR9SJIZWXqFRAFpZ/0TIxd1xeq
         N27Q4dHVhRxWeBTW4JVFqruSgofTf5hvUL0dC8uNFtFe6JViTTR4jBhQZNojXfUmqzDf
         oSoqnt+Xc09OazjqQyJA6dQNNZ5FXWs6MeXDvr7KPOpQoZXwXmuHCnLx3knuTyutLIim
         PbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XRuK6d7TnHtLQBOfr1sWZbQMCgbijX/fPo8dKPOxUls=;
        b=jJ9epHQ6VRGJF+vuZ6DfAN7bUp7UUDvTQoYI9Cv4ss1bf4f8cIFZ5LVd434A5tj009
         E51SjQFZjXyX8rclWAlm0oGe323vWpQULvOv0dGN9w5LJbkhB3L7bMibcM/7GJwRGdpq
         01jfHOTSwHzS+EyRCWBwT8wOegv1EY6ZHmEmXVY23SNF/SXILC/VXbeLnaNVtf0RNPE0
         LLwQ5XVq3jGjW0PzafsESgFKT3CmMrqDWZBWXuIpBfSU43Zx2sc35t1GrkUD1GYlkz7j
         eex6b5Y7e8L8kwxGmAZcwJxS3mWVh+c8q0cAVxV74y91gsm7LA+Isl8Wtq4qs4DRuiL3
         OzTw==
X-Gm-Message-State: APjAAAU3rJdVVxRuzjawTFvwpowQqlx4HFI06P1SjRoF4J+/Bi40bRaV
        DCD90XU/bAyeLTg4xJi+hf4=
X-Google-Smtp-Source: APXvYqyjgTD34TCZL6vSolXShECU4mRhrBb+CbMWDjGy5CEeF+hg9j2Lin8TabfMQIhLsPbQz10RFg==
X-Received: by 2002:a37:6442:: with SMTP id y63mr9788888qkb.264.1573772050641;
        Thu, 14 Nov 2019 14:54:10 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:69f2])
        by smtp.gmail.com with ESMTPSA id t11sm3991609qtj.15.2019.11.14.14.54.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 14:54:10 -0800 (PST)
Date:   Thu, 14 Nov 2019 14:54:08 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     cgroups@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        namhyung@kernel.org, open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, lizefan@huawei.com,
        hannes@cmpxchg.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kafai@fb.com,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH cgroup/for-5.5] cgroup: fix incorrect WARN_ON_ONCE() in
 cgroup_setup_root()
Message-ID: <20191114225408.GO4163745@devbig004.ftw2.facebook.com>
References: <CA+G9fYviReoG+gq=Jm8yQOMd01j2opae5p+VTGGMK7aLn0xWgw@mail.gmail.com>
 <20191114224213.GN4163745@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114224213.GN4163745@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Never mind.  I just failed to see the warning on x86_32.  The warning
is spurious and fixed with the following commit.  Applied to
cgroup/for-5.5.

Thanks.

------ 8< ------
From d7495343228f30d8206e92dccfd1c41adcfa142d Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Thu, 14 Nov 2019 14:46:51 -0800

743210386c03 ("cgroup: use cgrp->kn->id as the cgroup ID") added WARN
which triggers if cgroup_id(root_cgrp) is not 1.  This is fine on
64bit ino archs but on 32bit archs cgroup ID is ((gen << 32) | ino)
and gen starts at 1, so the root id is 0x1_0000_0001 instead of 1
always triggering the WARN.

What we wanna make sure is that the ino part is 1.  Fix it.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Fixes: 743210386c03 ("cgroup: use cgrp->kn->id as the cgroup ID")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c12dcf7dc432..53098c1d45e2 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1966,7 +1966,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 		goto exit_root_id;
 	}
 	root_cgrp->kn = root->kf_root->kn;
-	WARN_ON_ONCE(cgroup_id(root_cgrp) != 1);
+	WARN_ON_ONCE(cgroup_ino(root_cgrp) != 1);
 	root_cgrp->ancestor_ids[0] = cgroup_id(root_cgrp);
 
 	ret = css_populate_dir(&root_cgrp->self);
-- 
2.17.1

