Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96A9372146
	for <lists+cgroups@lfdr.de>; Tue, 23 Jul 2019 23:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391989AbfGWVHs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Jul 2019 17:07:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46326 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391988AbfGWVHs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Jul 2019 17:07:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id c73so19738570pfb.13
        for <cgroups@vger.kernel.org>; Tue, 23 Jul 2019 14:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=eXdJyX/5y1/FGa+5JWyiUL+IHdXyD6YsS6A0RC/riP0=;
        b=krorYgFC8c4EEHktVPMM8Uc7p10JFe0m3Uh5Z7ygeHlBHaZoO9KsDsqrGfKaOQ5n45
         Uu4t0n4z/SGQkouCaz5dv002xNN8r2wM56rDbp6+ZTVvamypB6MVSsqNBUzlCunbD8JI
         DmdBacuJcpJxjt2ybAFvHIpYgMHnUYIG12DWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eXdJyX/5y1/FGa+5JWyiUL+IHdXyD6YsS6A0RC/riP0=;
        b=XN4dYzR1DrhIe86PqKp2T1Xq8r4vkE617TlbLTTyB4OcLlaKSfGtkK2FQjDMhgam/X
         Oep7kqvfU0GF1ayF1I4ls24nxtm0gwo2bmTkJspygnIasxZkdGHvrQh/W6hrx1GYBkTp
         YN0nyt6Snfbu9NLFhpS5wCdmc1VG0RQfYsnu/HWMpHX09vbGOfw3D1JHa0foH8LP01B3
         +w+MPQSPYiS05GP4J2xH9BeZy6a1rzx1QpuAbdBWZAIq99lrBvRguOXoJQc+VnQJ9B6K
         Xtm0S+ugJfBOeb548x7bv++pw8y/2SKrp8dwJF/404W8BZ8fP2G1QdOs7eYIPCJGS5hS
         ckDw==
X-Gm-Message-State: APjAAAURU5CnVYdv1FEge8iZHBN7i0doPNO+n96gt31HFxe+Nq300UV4
        0mKLfohnKahAiZs00tlZr7KWvA==
X-Google-Smtp-Source: APXvYqx+RlfYYF9BsUFYetL+eK6XXW+0RaA14tPNlGA5LsYqVrZUzX7sAKiZK0j2exSKPYRkMQRd9Q==
X-Received: by 2002:a63:c008:: with SMTP id h8mr75676650pgg.427.1563916066868;
        Tue, 23 Jul 2019 14:07:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:48f4])
        by smtp.gmail.com with ESMTPSA id l31sm69890987pgm.63.2019.07.23.14.07.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 14:07:46 -0700 (PDT)
Date:   Tue, 23 Jul 2019 17:07:37 -0400
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: [PATCH] cgroup: kselftest: Relax fs_spec checks
Message-ID: <20190723210737.GA487@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On my laptop most memcg kselftests were being skipped because it claimed
cgroup v2 hierarchy wasn't mounted, but this isn't correct. Instead, it
seems current systemd HEAD mounts it with the name "cgroup2" instead of
"cgroup":

    % grep cgroup /proc/mounts
    cgroup2 /sys/fs/cgroup cgroup2 rw,nosuid,nodev,noexec,relatime,nsdelegate 0 0

I can't think of a reason to need to check fs_spec explicitly
since it's arbitrary, so we can just rely on fs_vfstype.

After these changes, `make TARGETS=cgroup kselftest` actually runs the
cgroup v2 tests in more cases.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: kernel-team@fb.com
---
 tools/testing/selftests/cgroup/cgroup_util.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 4c223266299a..bdb69599c4bd 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -191,8 +191,7 @@ int cg_find_unified_root(char *root, size_t len)
 		strtok(NULL, delim);
 		strtok(NULL, delim);
 
-		if (strcmp(fs, "cgroup") == 0 &&
-		    strcmp(type, "cgroup2") == 0) {
+		if (strcmp(type, "cgroup2") == 0) {
 			strncpy(root, mount, len);
 			return 0;
 		}
-- 
2.22.0

