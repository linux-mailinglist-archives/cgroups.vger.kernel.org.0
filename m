Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A99379726
	for <lists+cgroups@lfdr.de>; Mon, 10 May 2021 20:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhEJSrM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 May 2021 14:47:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51372 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231577AbhEJSrL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 May 2021 14:47:11 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14AIUJx9004215
        for <cgroups@vger.kernel.org>; Mon, 10 May 2021 11:46:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=rWFLuxjlkCJpY+dUzioJAmlhNduAcTJxyvXk5dzyWIo=;
 b=ouzbLFe/3wo/rDw79rBNsSn8TgezE+cVrTlolHE5MX8NxiOlk7budplM3sBW5sdsFgQa
 xD+IQfa/4hFJd5E9Lbpyd2qKOg7QlhNFqbtDduufaw3Jae6qPK9QTp+Z/80a6NsCj2ZV
 PFs+OZ23qLio35ekaQxLn6bprQRS+6wOvXw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38eaaaq37q-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <cgroups@vger.kernel.org>; Mon, 10 May 2021 11:46:05 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 10 May 2021 11:46:03 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 510CA71F437F; Mon, 10 May 2021 11:46:01 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, <cgroups@vger.kernel.org>
CC:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH] cgroup: inline cgroup_task_freeze()
Date:   Mon, 10 May 2021 11:45:56 -0700
Message-ID: <20210510184556.946798-1-guro@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: SLqpzwmsl4I-gGMJyg-7Qm6nkuvpVxK4
X-Proofpoint-ORIG-GUID: SLqpzwmsl4I-gGMJyg-7Qm6nkuvpVxK4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-10_11:2021-05-10,2021-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=378
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105100125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

After the introduction of the cgroup.kill there is only one call site
of cgroup_task_freeze() left: cgroup_exit(). cgroup_task_freeze() is
currently taking rcu_read_lock() to read task's cgroup flags, but
because it's always called with css_set_lock locked, the rcu protection
is excessive.

Simplify the code by inlining cgroup_task_freeze().

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/cgroup.h | 18 ------------------
 kernel/cgroup/cgroup.c |  3 ++-
 2 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 4f2f79de083e..a72764287cb5 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -906,20 +906,6 @@ void cgroup_freeze(struct cgroup *cgrp, bool freeze)=
;
 void cgroup_freezer_migrate_task(struct task_struct *task, struct cgroup=
 *src,
 				 struct cgroup *dst);
=20
-static inline bool cgroup_task_freeze(struct task_struct *task)
-{
-	bool ret;
-
-	if (task->flags & PF_KTHREAD)
-		return false;
-
-	rcu_read_lock();
-	ret =3D test_bit(CGRP_FREEZE, &task_dfl_cgroup(task)->flags);
-	rcu_read_unlock();
-
-	return ret;
-}
-
 static inline bool cgroup_task_frozen(struct task_struct *task)
 {
 	return task->frozen;
@@ -929,10 +915,6 @@ static inline bool cgroup_task_frozen(struct task_st=
ruct *task)
=20
 static inline void cgroup_enter_frozen(void) { }
 static inline void cgroup_leave_frozen(bool always_leave) { }
-static inline bool cgroup_task_freeze(struct task_struct *task)
-{
-	return false;
-}
 static inline bool cgroup_task_frozen(struct task_struct *task)
 {
 	return false;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e640fc78d731..29be28e903ab 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6267,7 +6267,8 @@ void cgroup_exit(struct task_struct *tsk)
 	cset->nr_tasks--;
=20
 	WARN_ON_ONCE(cgroup_task_frozen(tsk));
-	if (unlikely(cgroup_task_freeze(tsk)))
+	if (unlikely(!(task->flags & PF_KTHREAD) &&
+		     test_bit(CGRP_FREEZE, &task_dfl_cgroup(task)->flags)))
 		cgroup_update_frozen(task_dfl_cgroup(tsk));
=20
 	spin_unlock_irq(&css_set_lock);
--=20
2.30.2

