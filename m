Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9045F7708
	for <lists+cgroups@lfdr.de>; Mon, 11 Nov 2019 15:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfKKOuD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Nov 2019 09:50:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35619 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfKKOuC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Nov 2019 09:50:02 -0500
Received: by mail-wr1-f65.google.com with SMTP id s5so3855116wrw.2
        for <cgroups@vger.kernel.org>; Mon, 11 Nov 2019 06:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=OPnJSf+FsDJ4AK8qgreISZQp/qVRV4crg89KAbDdM7k=;
        b=C7l91imCRxRt/iXdRWLRpgFZp+d1cU9X9RIrPYVByasB726nYNdqnnPU+D6mL5YSmC
         ihwV7cizd9tDvrMcKaNzoVQxPLyM5LDI4eAZPTQ7r8KNQ960vI4xRHHlXIeCnT9flJgn
         DPgoxIo/FKx56KEMNcFDpRr7eoWz9x+qywUn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=OPnJSf+FsDJ4AK8qgreISZQp/qVRV4crg89KAbDdM7k=;
        b=eZ8oQ0BxXrMlfTXo1w4T5fBicSNwN60AqfEuah4umcNmaxhUGC8OyVGpMjhqIV22hj
         lIgV5+eb0q5meTMuzgmc+HVxwfSl+5FkdSFfFHBlLYtvNXcpEo24AjQjpJx944cx/LBE
         IiRrK5ZbghlPgLX3vBzRkVlnpxL24qy1GXSgTX6TK3aJBjcEr3Xz9/SjQxGAga4LKZEX
         4JbKQcKlKOYKdcSrLtZdFFDLQ5jWCAqylmU5OOML9zpBfcn9TdaBN4o8hJn+0sgvqHJ0
         t0whAuU6J4lSZfxUP5ME5Mlvetfw4YNmb2XzllhtXKzSZcq1DrINIT0PnIQ8Iw7+qjJ/
         xilA==
X-Gm-Message-State: APjAAAWEjE5zHvOXgvECWjrqtmWIh4CROnt1yACD/GvJVb0cUTXp7Mlr
        ssS9QBCZlXp2/UNV21W+fyiAyw==
X-Google-Smtp-Source: APXvYqyMEx/gVsnYP8FYoS2VkeNr+PnO77nToZQSvqb1cbjd5mh9ksLHjNCNdtTLT41TUSF6rICRFw==
X-Received: by 2002:adf:e387:: with SMTP id e7mr15450742wrm.180.1573483800231;
        Mon, 11 Nov 2019 06:50:00 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:3e35])
        by smtp.gmail.com with ESMTPSA id w17sm8434824wrt.45.2019.11.11.06.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 06:49:59 -0800 (PST)
Date:   Mon, 11 Nov 2019 14:49:58 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: [PATCH] docs: cgroup: mm: Document why inactive_X + active_X may not
 equal X
Message-ID: <20191111144958.GA11914@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This has confused a significant number of people using cgroups inside
Facebook, and some of those outside as well judging by posts like
this[0] (although it's not a problem unique to cgroup v2). If shmem
handling in particular becomes more coherent at some point in the future
-- although that seems unlikely now -- we can change the wording here.

[0]: https://unix.stackexchange.com/q/525092/10762

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: kernel-team@fb.com
---
 Documentation/admin-guide/cgroup-v2.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 0704552ed94f..0636bcb60b5a 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1289,7 +1289,12 @@ PAGE_SIZE multiple when read back.
 	  inactive_anon, active_anon, inactive_file, active_file, unevictable
 		Amount of memory, swap-backed and filesystem-backed,
 		on the internal memory management lists used by the
-		page reclaim algorithm
+		page reclaim algorithm.
+
+		As these represent internal list state (eg. shmem pages are on anon
+		memory management lists), inactive_foo + active_foo may not be equal to
+		the value for the foo counter, since the foo counter is type-based, not
+		list-based.
 
 	  slab_reclaimable
 		Part of "slab" that might be reclaimed, such as
-- 
2.24.0

