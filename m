Return-Path: <cgroups+bounces-3208-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 369C090B3AC
	for <lists+cgroups@lfdr.de>; Mon, 17 Jun 2024 17:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E5F1F27F9F
	for <lists+cgroups@lfdr.de>; Mon, 17 Jun 2024 15:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7708158860;
	Mon, 17 Jun 2024 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsV8PZXq"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353C01581F6
	for <cgroups@vger.kernel.org>; Mon, 17 Jun 2024 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718634814; cv=none; b=eb8D1/ksmrHHsXpOZbu4TVgTquNhJWAwA9wLGIXIec32xEYm9Fs7iaE//qDdXq2J0x7Fv2ixwV+DMT0T9GaEOhiH2SJh0Q1kez3v4ylrsqPkl1F/l5E5E0NsZqsR2lD53WiTskmXrkE4QXHYphi1p8JIKi2bDe7PD1OUbuWvv08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718634814; c=relaxed/simple;
	bh=VVdPT0zhOnDZj54ExP3eeuDO1+QqbjER3mmQ14+l2CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpnE3GRmsZYi68H+nWbzvkqOX1A8EBjQWWvEr6u+pztV+9UvsPZvOhv5qLieEuvwp/9b9t+zoFBA7t4UgBTfGSDm6N2841jik/+8ZDXEwgE+exTYw+Ud0yVYYdUogKp0tSYcePA3AoafERtg//ipB3Z8qr+hiwewgFN2SKYovfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OsV8PZXq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718634812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PnsNsu2RrWRa2K/ICM7BETSyEtLXHtQAN+oXcTQb7So=;
	b=OsV8PZXqtGn9BO8uporEDDUIno+PiIc9epAYBtvp1cyRUvNxs0UxXQWJgusAT9vuneYHLE
	f1A3Yla6R9xj2lmR2OKsunsWc8+QVl6Kb/oRrcUEZlAF/LkxoHW4Vh/4xHImfL1+vlkQ6J
	V9sORXHF9feaySMEETDiefZMy07XVJ0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-2pzZU8xdM0ag7qUG7e7jvg-1; Mon,
 17 Jun 2024 10:33:28 -0400
X-MC-Unique: 2pzZU8xdM0ag7qUG7e7jvg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CEA319560BE;
	Mon, 17 Jun 2024 14:33:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.89])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CB7281956087;
	Mon, 17 Jun 2024 14:33:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 17 Jun 2024 16:31:55 +0200 (CEST)
Date: Mon, 17 Jun 2024 16:31:52 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] cgroup: avoid the unnecessary list_add(dying_tasks) in
 cgroup_exit()
Message-ID: <20240617143152.GA10404@redhat.com>
References: <20240617143129.GA10395@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617143129.GA10395@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

cgroup_exit() needs to do this only if the exiting task is a leader and it
is not the last live thread.  The patch doesn't use delay_group_leader(),
atomic_read(signal->live) matches the code css_task_iter_advance() more.

cgroup_release() can now check list_empty(task->cg_list) before it takes
css_set_lock and calls ss_set_skip_task_iters().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/cgroup/cgroup.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e32b6972c478..0cbee8118c95 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6686,8 +6686,10 @@ void cgroup_exit(struct task_struct *tsk)
 	WARN_ON_ONCE(list_empty(&tsk->cg_list));
 	cset = task_css_set(tsk);
 	css_set_move_task(tsk, cset, NULL, false);
-	list_add_tail(&tsk->cg_list, &cset->dying_tasks);
 	cset->nr_tasks--;
+	/* matches the signal->live check in css_task_iter_advance() */
+	if (thread_group_leader(tsk) && atomic_read(&tsk->signal->live))
+		list_add_tail(&tsk->cg_list, &cset->dying_tasks);
 
 	if (dl_task(tsk))
 		dec_dl_tasks_cs(tsk);
@@ -6714,10 +6716,12 @@ void cgroup_release(struct task_struct *task)
 		ss->release(task);
 	} while_each_subsys_mask();
 
-	spin_lock_irq(&css_set_lock);
-	css_set_skip_task_iters(task_css_set(task), task);
-	list_del_init(&task->cg_list);
-	spin_unlock_irq(&css_set_lock);
+	if (!list_empty(&task->cg_list)) {
+		spin_lock_irq(&css_set_lock);
+		css_set_skip_task_iters(task_css_set(task), task);
+		list_del_init(&task->cg_list);
+		spin_unlock_irq(&css_set_lock);
+	}
 }
 
 void cgroup_free(struct task_struct *task)
-- 
2.25.1.362.g51ebf55



