Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E823E86F3
	for <lists+cgroups@lfdr.de>; Wed, 11 Aug 2021 02:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbhHKAEP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Aug 2021 20:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbhHKAEP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Aug 2021 20:04:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F732C061765;
        Tue, 10 Aug 2021 17:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=oEMWLoJ15XGTU1uDxOZTCeL7G0nFB55u5+5nltWOW/w=; b=mow1pUdqDHxWhPTLIo9hCoo34w
        SAo9lQlbuzaQI5wjDic//GPlEVhLzWGU8B4EEG0FiwKpS+p+uha7f4sqhOv4yx9ocWp1Lf7SVSwwp
        hlv3Ijmyap8sBxBmDMHSGwD63dy+Rk7sY5Bv9HqWr6jjno4AxFlDKZWoYxCLfF9mphlOHp56H23az
        //tRCYlw9XLhGeCYNLAEs3qL3GSQqO8zqQixzAsRgbu1z5AcTDzb11PpEEFgKVwAdpUB+g/35Ayvj
        CV/QW18zmB7KrBpnq3zl4y/1jhT1S1OaGvr33ceh5JryBCowDnEdbNRt+fVAJW3SRyFVa+uNmyMxL
        97Bfe2Wg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDbio-0054h5-I1; Wed, 11 Aug 2021 00:03:50 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: [PATCH] cgroup: cgroup-v1: clean up kernel-doc notation
Date:   Tue, 10 Aug 2021 17:03:49 -0700
Message-Id: <20210811000349.32645-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Fix kernel-doc warnings found in cgroup-v1.c:

kernel/cgroup/cgroup-v1.c:55: warning: No description found for return value of 'cgroup_attach_task_all'
kernel/cgroup/cgroup-v1.c:94: warning: expecting prototype for cgroup_trasnsfer_tasks(). Prototype was for cgroup_transfer_tasks() instead
cgroup-v1.c:96: warning: No description found for return value of 'cgroup_transfer_tasks'
kernel/cgroup/cgroup-v1.c:687: warning: No description found for return value of 'cgroupstats_build'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org
---
 kernel/cgroup/cgroup-v1.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- linux-next-20210809.orig/kernel/cgroup/cgroup-v1.c
+++ linux-next-20210809/kernel/cgroup/cgroup-v1.c
@@ -50,6 +50,8 @@ bool cgroup1_ssid_disabled(int ssid)
  * cgroup_attach_task_all - attach task 'tsk' to all cgroups of task 'from'
  * @from: attach to all cgroups of a given task
  * @tsk: the task to be attached
+ *
+ * Return: %0 on success or a negative errno code on failure
  */
 int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
 {
@@ -80,7 +82,7 @@ int cgroup_attach_task_all(struct task_s
 EXPORT_SYMBOL_GPL(cgroup_attach_task_all);
 
 /**
- * cgroup_trasnsfer_tasks - move tasks from one cgroup to another
+ * cgroup_transfer_tasks - move tasks from one cgroup to another
  * @to: cgroup to which the tasks will be moved
  * @from: cgroup in which the tasks currently reside
  *
@@ -89,6 +91,8 @@ EXPORT_SYMBOL_GPL(cgroup_attach_task_all
  * is guaranteed to be either visible in the source cgroup after the
  * parent's migration is complete or put into the target cgroup.  No task
  * can slip out of migration through forking.
+ *
+ * Return: %0 on success or a negative errno code on failure
  */
 int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 {
@@ -682,6 +686,8 @@ int proc_cgroupstats_show(struct seq_fil
  *
  * Build and fill cgroupstats so that taskstats can export it to user
  * space.
+ *
+ * Return: %0 on success or a negative errno code on failure
  */
 int cgroupstats_build(struct cgroupstats *stats, struct dentry *dentry)
 {
