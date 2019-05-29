Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 584892E708
	for <lists+cgroups@lfdr.de>; Wed, 29 May 2019 23:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfE2VGV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 May 2019 17:06:21 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41662 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfE2VGV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 May 2019 17:06:21 -0400
Received: by mail-qk1-f196.google.com with SMTP id m18so2453693qki.8
        for <cgroups@vger.kernel.org>; Wed, 29 May 2019 14:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=kDZhofxy6mufe3ksiaEz/xmHPiYjpnBL8G/C22N/e+4=;
        b=Dit7xG7bM1QDMHav6URFGcGdjxjlhT/gUPKBtE42oGWAdDT3YZbeZYtObRKdxM3Bzl
         948MWlm2R8M/jiQ3JTm865KfiiVxQdQ7I2jJeYjwXMGyprW/kwm+lxoQJENyx+w9chzp
         Q7J/+qlmpnu91qGcb7v5KcRxEtAGsWUnJo6l+DzaimKsyCV6YQT/jxCIjc+DPCUQSvLo
         NE+3Pkq6Zj97IW3rf0iK0hqngJK6sWRZ0C8UwndmSJUzEKnqqq22b3CGDW5W3WOGaYK4
         FisXuLDVkP4NSjcjBUz171btDOTsv3tl1Q/2+JLcOv67XlLuB2cvkgcxuHyfk5nAS2p2
         yZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=kDZhofxy6mufe3ksiaEz/xmHPiYjpnBL8G/C22N/e+4=;
        b=Af4QpUaiM9mZFir/YOzEd4iRxv6GhBtVzlOW3YEjNzzOYLuhMWPe9kws7aVR3M9How
         D6Wu6Dd7XL6pRw4fyUh8VhYnYag5+dawRZOExVYf6uipt/TeJ+TK5SBmsesx2gTmIYeq
         oArecsxGlSdvnaTWkpJjBAhwHrE4+tchIHwPQURqbrwWFUYLyPejasNTKOlKHgV0Lf6X
         lz5lR8hNP4q8nasYtdIlKhwOKpTar1E47HyqoBsyB8WFdOvEWOYnBt81cLlJqaAvr+cs
         FmS1/VCxvPdLMJ0o4CffkUaylaN+27FCMumRGG9UCdFLoY+9r8UisyEZcv3SWmPKzeSa
         Oj2g==
X-Gm-Message-State: APjAAAVEU5X2dyQ+1hEmMwKvweQ7SJ5gj5B5i5J0cR5tqLfW40GlnckY
        qqe/R0MpcJ1kRgNlkIHbxWI=
X-Google-Smtp-Source: APXvYqwJkpegnMhQjW+QQW841v8rVagC6Jn6IrcotmLN4smB41C542UQJIDCuIDgyKfrB3TFDcvRrw==
X-Received: by 2002:a05:620a:16c1:: with SMTP id a1mr12635399qkn.269.1559163980173;
        Wed, 29 May 2019 14:06:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:849f])
        by smtp.gmail.com with ESMTPSA id w48sm269662qtb.91.2019.05.29.14.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 14:06:19 -0700 (PDT)
Date:   Wed, 29 May 2019 14:06:17 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: [PATCH for-5.2-fixes] memcg: Don't loop on css_tryget_online()
 failure
Message-ID: <20190529210617.GP374014@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

A PF_EXITING task may stay associated with an offline css.
get_mem_cgroup_from_mm() may deadlock if mm->owner is in such state.
All similar logics in memcg are falling back to root memcg on
tryget_online failure and get_mem_cgroup_from_mm() can do the same.

A similar failure existed for task_get_css() and could be triggered
through BSD process accounting racing against memcg offlining.  See
18fa84a2db0e ("cgroup: Use css_tryget() instead of css_tryget_online()
in task_get_css()") for details.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 mm/memcontrol.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e50a2db5b4ff..be1fa89db198 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -918,23 +918,19 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 
 	if (mem_cgroup_disabled())
 		return NULL;
+	/*
+	 * Page cache insertions can happen without an actual mm context,
+	 * e.g. during disk probing on boot, loopback IO, acct() writes.
+	 */
+	if (unlikely(!mm))
+		return root_mem_cgroup;
 
 	rcu_read_lock();
-	do {
-		/*
-		 * Page cache insertions can happen withou an
-		 * actual mm context, e.g. during disk probing
-		 * on boot, loopback IO, acct() writes etc.
-		 */
-		if (unlikely(!mm))
-			memcg = root_mem_cgroup;
-		else {
-			memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
-			if (unlikely(!memcg))
-				memcg = root_mem_cgroup;
-		}
-	} while (!css_tryget_online(&memcg->css));
+	memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
+	if (!css_tryget_online(&memcg->css))
+		memcg = root_mem_cgroup;
 	rcu_read_unlock();
+
 	return memcg;
 }
 EXPORT_SYMBOL(get_mem_cgroup_from_mm);
