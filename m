Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 586591A2A2A
	for <lists+cgroups@lfdr.de>; Wed,  8 Apr 2020 22:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbgDHUPH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Apr 2020 16:15:07 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34808 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730331AbgDHUPG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Apr 2020 16:15:06 -0400
Received: by mail-qk1-f196.google.com with SMTP id i186so1708434qke.1;
        Wed, 08 Apr 2020 13:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+BQj1JBsSqI5aXq/pqViTsj/4QvWCDvVD92VTzp4arE=;
        b=qKboPNy2/dnjhxkRbRhKQPht9hywFpKyf4i8CXsAR9zg0nhM5XrScSCIvpHz7F0eji
         41v6ZqceIMREH0c+nwCHi/waR3Ax0Z7sTe6ayepIgXW86yw+orBD/g82g9KzmM/mt7Yj
         m0ZW8Z3YolR7v0+IcLE06O2273fnL6vM0Hx/8bihQL47lmFAqRRjUELts2RQ99MA9z0/
         bIcqmVBOHyjQcf56HDHd/4w3zJzm29ZiAxwDKFbiPTJCKLXgWyTAraN3q7jQekCPAror
         cvCUcZxY2v+v7Vi4wuY70fic7qGswgC1yMzn9eLdmP4ah89UPOUE/XZU96WuffzSkn9E
         tn9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=+BQj1JBsSqI5aXq/pqViTsj/4QvWCDvVD92VTzp4arE=;
        b=CHWv0VuXLcqPAx/sQsStGLMvkh+ddP6aVK9iR9G/isMcnWWKXhwdPQ0jIODyjJPy/t
         F40JefQWFSWXwnxZH56XDwNybPgYeAIgM9BE65uZk0dSf79ft6HEFgfr9OEyClWzG2Uw
         0PrSpaCHrh2okAO4hUbbECyl8vFw9I822jfH4J1ifv/95We9XvAgc2do7LtlaSD6S0E4
         o0PIOU7C5vCJpSMXCQP+Sv4vPHZD9mJdihd2K+58ajXUVzn48fUwvjdIGllK2yPgjdCH
         gR3HZhA11m8RaumyD9kXNXxhLmga9MRxgPdrZniAVUIIZJpN5UUtDpRaRjbFpaTrL4Jf
         5SpA==
X-Gm-Message-State: AGi0PubOur88+VrWAZF8T+SDtZtvgurMsjFASBjdlg8tpbXx0Mro/se5
        TzP6ziBv0gfEg0FxC8vfLls=
X-Google-Smtp-Source: APiQypJSKn0E6p5g9aODEGUakCg+0fdp0wYkfpYJVtzATTSKzyku2CbfjyLqyEwrUo39mE8s2Qx5VA==
X-Received: by 2002:a37:a5c2:: with SMTP id o185mr9299768qke.219.1586376904902;
        Wed, 08 Apr 2020 13:15:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::36b2])
        by smtp.gmail.com with ESMTPSA id v33sm10416277qtd.88.2020.04.08.13.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 13:15:04 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@vger.kernel.org, cgroups@vger.kernel.org,
        newella@fb.com, josef@toxicpanda.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/5] iocost_monitor: drop string wrap around numbers when outputting json
Date:   Wed,  8 Apr 2020 16:14:50 -0400
Message-Id: <20200408201450.3959560-6-tj@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200408201450.3959560-1-tj@kernel.org>
References: <20200408201450.3959560-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Wrapping numbers in strings is used by some to work around bit-width issues in
some enviroments. The problem isn't innate to json and the workaround seems to
cause more integration problems than help. Let's drop the string wrapping.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/cgroup/iocost_monitor.py | 42 +++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/tools/cgroup/iocost_monitor.py b/tools/cgroup/iocost_monitor.py
index eb2363b868c5..188b3379b9a1 100644
--- a/tools/cgroup/iocost_monitor.py
+++ b/tools/cgroup/iocost_monitor.py
@@ -113,14 +113,14 @@ autop_names = {
 
     def dict(self, now):
         return { 'device'               : devname,
-                 'timestamp'            : str(now),
-                 'enabled'              : str(int(self.enabled)),
-                 'running'              : str(int(self.running)),
-                 'period_ms'            : str(self.period_ms),
-                 'period_at'            : str(self.period_at),
-                 'period_vtime_at'      : str(self.vperiod_at),
-                 'busy_level'           : str(self.busy_level),
-                 'vrate_pct'            : str(self.vrate_pct), }
+                 'timestamp'            : now,
+                 'enabled'              : self.enabled,
+                 'running'              : self.running,
+                 'period_ms'            : self.period_ms,
+                 'period_at'            : self.period_at,
+                 'period_vtime_at'      : self.vperiod_at,
+                 'busy_level'           : self.busy_level,
+                 'vrate_pct'            : self.vrate_pct, }
 
     def table_preamble_str(self):
         state = ('RUN' if self.running else 'IDLE') if self.enabled else 'OFF'
@@ -175,19 +175,19 @@ autop_names = {
 
     def dict(self, now, path):
         out = { 'cgroup'                : path,
-                'timestamp'             : str(now),
-                'is_active'             : str(int(self.is_active)),
-                'weight'                : str(self.weight),
-                'weight_active'         : str(self.active),
-                'weight_inuse'          : str(self.inuse),
-                'hweight_active_pct'    : str(self.hwa_pct),
-                'hweight_inuse_pct'     : str(self.hwi_pct),
-                'inflight_pct'          : str(self.inflight_pct),
-                'debt_ms'               : str(self.debt_ms),
-                'use_delay'             : str(self.use_delay),
-                'delay_ms'              : str(self.delay_ms),
-                'usage_pct'             : str(self.usage),
-                'address'               : str(hex(self.address)) }
+                'timestamp'             : now,
+                'is_active'             : self.is_active,
+                'weight'                : self.weight,
+                'weight_active'         : self.active,
+                'weight_inuse'          : self.inuse,
+                'hweight_active_pct'    : self.hwa_pct,
+                'hweight_inuse_pct'     : self.hwi_pct,
+                'inflight_pct'          : self.inflight_pct,
+                'debt_ms'               : self.debt_ms,
+                'use_delay'             : self.use_delay,
+                'delay_ms'              : self.delay_ms,
+                'usage_pct'             : self.usage,
+                'address'               : self.address }
         for i in range(len(self.usages)):
             out[f'usage_pct_{i}'] = str(self.usages[i])
         return out
-- 
2.25.1

