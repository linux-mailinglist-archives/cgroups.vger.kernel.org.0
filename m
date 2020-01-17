Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2913A1411FF
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2020 20:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgAQT6q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Jan 2020 14:58:46 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:40386 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgAQT6q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Jan 2020 14:58:46 -0500
Received: by mail-qv1-f65.google.com with SMTP id dp13so11251256qvb.7;
        Fri, 17 Jan 2020 11:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sPdxpH8MyQUiW9CeltxFRckECiJJQpVH4BhIsZDdF38=;
        b=mByunD+oO3XP1Dvhlmwzm3IO5l5bbxtR7KUnDCY2fpWJT/NmUuwRdNyextOSNzsTbh
         p1gZ8nAYOytmy0hv1bgACpmjM4b3notpx/+JJTVlex00JnhTF7bGcNsjcI/THfBE3Qyo
         R4rAF4E7PF6FZQMtIJ8e8X575u4L5RanoVjGr8A+00GRsQpGRq2o9krqCew2n/JGLYeO
         20sgCShe0s/t7ZZUPjr96nhEyqh0hdnY/kK0QJKAQOo5qftObgn04Tn1AlWqtR34mnJ/
         6kM0MiKYxqsyaC8byA0bW/WnqYXKH9thF+JXmJSwOK4jmHgKVglXwUZpsMXZvfnjFqYl
         I4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=sPdxpH8MyQUiW9CeltxFRckECiJJQpVH4BhIsZDdF38=;
        b=IYhkWDGAhwbRFyS1Xian1Fyzn3XxNSwxGecPbHF8b9+1AWcTe8D2D0J+EcYQq7SR1f
         2prtmmOwbEXGpoTJ/+AdqiSjFZ/YtxbwZlOHHSZpEw2CPNKvwp9Sp5chdymZ2T9e4a5Y
         JXXmwx+cyf0qz5tlU0J5CwAVFFEQuTZhILUZm1b6RXo8KdAM2SMNxiI97wauxIO9yIin
         xZqNXrB2CBjgo8Y8fSnv5GJhc/PPQlCXtnxIS8Qb4tcWf+9SayiPrwq6fosWO9UiZHSy
         ibLtgpHZG/jMiHcOwMxJ1VQYaJWrTtPl5BIusWjPuhUi1dgAF7qfBTgWgYpNRczhTg1I
         KSsg==
X-Gm-Message-State: APjAAAVJtavOy52k0WPiXZGjVECF5ugkx1skvlnSB3aRLM3gEwu5Km/2
        PLdhssCZQSyuA5plTuHhxis=
X-Google-Smtp-Source: APXvYqwb1bIBNMAR7yyfIfiMyf1BL/izMlEY5A/e6C9eCoL5eWd9sjR3mW0GtMaIPVo8m9Ng/U0+8Q==
X-Received: by 2002:ad4:40c7:: with SMTP id x7mr9621275qvp.176.1579291124730;
        Fri, 17 Jan 2020 11:58:44 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:7d10])
        by smtp.gmail.com with ESMTPSA id t38sm13757528qta.78.2020.01.17.11.58.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jan 2020 11:58:44 -0800 (PST)
Date:   Fri, 17 Jan 2020 11:58:42 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>, kernel-team@fb.com
Subject: [PATCH cgroup/for-5.6] iocost: Fix iocost_monitor.py due to helper
 type mismatch
Message-ID: <20200117195842.GL2677547@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From 9ea37e24d4a95dd934a0600d65caa25e409705bb Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Fri, 17 Jan 2020 11:54:35 -0800

iocost_monitor.py broke with recent versions of drgn due to helper
being stricter about types.  Fix it so that it uses the correct type.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Omar Sandoval <osandov@fb.com>
---
Applied to cgroup/for-5.6.

 tools/cgroup/iocost_monitor.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/cgroup/iocost_monitor.py b/tools/cgroup/iocost_monitor.py
index f79b23582a1d..7427a5ee761b 100644
--- a/tools/cgroup/iocost_monitor.py
+++ b/tools/cgroup/iocost_monitor.py
@@ -72,7 +72,7 @@ autop_names = {
         name = BlkgIterator.blkcg_name(blkcg)
         path = parent_path + '/' + name if parent_path else name
         blkg = drgn.Object(prog, 'struct blkcg_gq',
-                           address=radix_tree_lookup(blkcg.blkg_tree, q_id))
+                           address=radix_tree_lookup(blkcg.blkg_tree.address_of_(), q_id))
         if not blkg.address_:
             return
 
@@ -228,7 +228,7 @@ q_id = None
 root_iocg = None
 ioc = None
 
-for i, ptr in radix_tree_for_each(blkcg_root.blkg_tree):
+for i, ptr in radix_tree_for_each(blkcg_root.blkg_tree.address_of_()):
     blkg = drgn.Object(prog, 'struct blkcg_gq', address=ptr)
     try:
         if devname == blkg.q.kobj.parent.name.string_().decode('utf-8'):
-- 
2.17.1

