Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4D43A0768
	for <lists+cgroups@lfdr.de>; Wed,  9 Jun 2021 01:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbhFHXGx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Jun 2021 19:06:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:2380 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235209AbhFHXGw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Jun 2021 19:06:52 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 158N4vOL005727
        for <cgroups@vger.kernel.org>; Tue, 8 Jun 2021 16:04:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=mfav6jzNKGWoxXgqLsimDL5+HxKJWmRmET2uHflSm9w=;
 b=OjqfaN2Os6DxSL7HmOn4jDtij1QwyZYPxFDhWgbljrVVB85ZPP7F2i1BRuaLZ7Rrp80u
 F9+mfkNCMARlB+MSC3rh4vz7UjDseYvOEtUZKn8LwPjakhCg/wlUY8oB9jdWmd3tnEb2
 i0qc72fz4JnRtBJRCP8a4Pp2Nog77WtweDM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3929n4bkmp-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <cgroups@vger.kernel.org>; Tue, 08 Jun 2021 16:04:58 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 16:04:51 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 3519582542C9; Tue,  8 Jun 2021 16:02:28 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v9 2/8] writeback, cgroup: add smp_mb() to cgroup_writeback_umount()
Date:   Tue, 8 Jun 2021 16:02:19 -0700
Message-ID: <20210608230225.2078447-3-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210608230225.2078447-1-guro@fb.com>
References: <20210608230225.2078447-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: s2A2XhBG683BErkYAHyKWoCh2zlz3_Id
X-Proofpoint-ORIG-GUID: s2A2XhBG683BErkYAHyKWoCh2zlz3_Id
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-08_17:2021-06-04,2021-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=704 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106080146
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

A full memory barrier is required between clearing SB_ACTIVE flag
in generic_shutdown_super() and checking isw_nr_in_flight in
cgroup_writeback_umount(), otherwise a new switch operation might
be scheduled after atomic_read(&isw_nr_in_flight) returned 0.
This would result in a non-flushed isw_wq, and a potential crash.

The problem hasn't yet been seen in the real life and was discovered
by Jan Kara by looking into the code.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 7d2891d7ac12..b6fc13a4962d 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1000,6 +1000,12 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_i=
d, unsigned long nr,
  */
 void cgroup_writeback_umount(void)
 {
+	/*
+	 * SB_ACTIVE should be reliably cleared before checking
+	 * isw_nr_in_flight, see generic_shutdown_super().
+	 */
+	smp_mb();
+
 	if (atomic_read(&isw_nr_in_flight)) {
 		/*
 		 * Use rcu_barrier() to wait for all pending callbacks to
--=20
2.31.1

