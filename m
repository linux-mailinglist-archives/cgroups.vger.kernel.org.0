Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3607F379951
	for <lists+cgroups@lfdr.de>; Mon, 10 May 2021 23:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhEJVk7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 May 2021 17:40:59 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:31734 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232257AbhEJVk6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 May 2021 17:40:58 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14ALSWFo007899
        for <cgroups@vger.kernel.org>; Mon, 10 May 2021 14:39:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=71HFV7GsQpQqUewHfxftuY+zUqM6D++iHEd8zaXhil4=;
 b=l/ppOVuH+pB98LD6AUc2YMyXFfq3Sr7mxAPa/1lXKvlMMglhSyi3vGyh7pWDFQDejZCP
 0I7GswlgP16nX0sGR9W3DOGfvDFAqMzUq2WGtKmqhXawW+cmZQNAq9AzxcqV2mGdGFJI
 DhGaOzYcB90+MCqSCKgIxNsLe9D1bX3nXwg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38eu2ynfqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <cgroups@vger.kernel.org>; Mon, 10 May 2021 14:39:52 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 10 May 2021 14:39:52 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id A36A47206066; Mon, 10 May 2021 14:39:50 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, <cgroups@vger.kernel.org>
CC:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v2] cgroup: inline cgroup_task_freeze()
Date:   Mon, 10 May 2021 14:39:46 -0700
Message-ID: <20210510213946.1667103-1-guro@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: vQN_lIHc1BqUbN7M20iiBnpcDHe3GiTq
X-Proofpoint-GUID: vQN_lIHc1BqUbN7M20iiBnpcDHe3GiTq
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-10_12:2021-05-10,2021-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 phishscore=0 clxscore=1015
 mlxlogscore=461 mlxscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100147
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

v2: fix build

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
index e640fc78d731..8e0d7092afbb 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6267,7 +6267,8 @@ void cgroup_exit(struct task_struct *tsk)
 	cset->nr_tasks--;
=20
 	WARN_ON_ONCE(cgroup_task_frozen(tsk));
-	if (unlikely(cgroup_task_freeze(tsk)))
+	if (unlikely(!(tsk->flags & PF_KTHREAD) &&
+		     test_bit(CGRP_FREEZE, &task_dfl_cgroup(tsk)->flags)))
 		cgroup_update_frozen(task_dfl_cgroup(tsk));
=20
 	spin_unlock_irq(&css_set_lock);
--=20
2.30.2

