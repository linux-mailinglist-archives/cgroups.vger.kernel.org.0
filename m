Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB8739EB6F
	for <lists+cgroups@lfdr.de>; Tue,  8 Jun 2021 03:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhFHBdi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Jun 2021 21:33:38 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35200 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231321AbhFHBde (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Jun 2021 21:33:34 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1581U63Q029840
        for <cgroups@vger.kernel.org>; Mon, 7 Jun 2021 18:31:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=JbC745/nCoOIrQ4+JlQ/s2K41dkqCbW9cAP/+uGDj5E=;
 b=Htd5yLtPSPxG0bZ+mHT8kD2ZVBc3LLwhLSv+atuCp/wuLaSCNG15x4L5vxy6Udy/eZex
 lLHKR2/StGsDHSL4fwsAgg+cbloxwvDf/IfuYP+pjE/CvJUE5bIXX0OzenjaI3d8cYfG
 cCJt/aEXBzf0Jp0XX8hCi7G58/uKU/KRBaA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 391m0t40ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <cgroups@vger.kernel.org>; Mon, 07 Jun 2021 18:31:42 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 18:31:41 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 88F2A81D6D41; Mon,  7 Jun 2021 18:31:29 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v8 0/8] cgroup, blkcg: prevent dirty inodes to pin dying memory cgroups
Date:   Mon, 7 Jun 2021 18:31:15 -0700
Message-ID: <20210608013123.1088882-1-guro@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: anidJdcLbpk8cX2wagGUSkxrCi_kcFa5
X-Proofpoint-ORIG-GUID: anidJdcLbpk8cX2wagGUSkxrCi_kcFa5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-08_01:2021-06-04,2021-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 impostorscore=0 mlxscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=276 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106080007
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When an inode is getting dirty for the first time it's associated
with a wb structure (see __inode_attach_wb()). It can later be
switched to another wb (if e.g. some other cgroup is writing a lot of
data to the same inode), but otherwise stays attached to the original
wb until being reclaimed.

The problem is that the wb structure holds a reference to the original
memory and blkcg cgroups. So if an inode has been dirty once and later
is actively used in read-only mode, it has a good chance to pin down
the original memory and blkcg cgroups forewer. This is often the case wit=
h
services bringing data for other services, e.g. updating some rpm
packages.

In the real life it becomes a problem due to a large size of the memcg
structure, which can easily be 1000x larger than an inode. Also a
really large number of dying cgroups can raise different scalability
issues, e.g. making the memory reclaim costly and less effective.

To solve the problem inodes should be eventually detached from the
corresponding writeback structure. It's inefficient to do it after
every writeback completion. Instead it can be done whenever the
original memory cgroup is offlined and writeback structure is getting
killed. Scanning over a (potentially long) list of inodes and detach
them from the writeback structure can take quite some time. To avoid
scanning all inodes, attached inodes are kept on a new list (b_attached).
To make it less noticeable to a user, the scanning and switching is perfo=
rmed
from a work context.

Big thanks to Jan Kara, Dennis Zhou, Hillf Danton and Tejun Heo for their=
 ideas
and contribution to this patchset.

v8:
  - switch inodes to a nearest living ancestor wb instead of root wb
  - added two inodes switching fixes suggested by Jan Kara

v7:
  - shared locking for multiple inode switching
  - introduced inode_prepare_wbs_switch() helper
  - extended the pre-switch inode check for I_WILL_FREE
  - added comments here and there

v6:
  - extended and reused wbs switching functionality to switch inodes
    on cgwb cleanup
  - fixed offline_list handling
  - switched to the unbound_wq
  - other minor fixes

v5:
  - switch inodes to bdi->wb instead of zeroing inode->i_wb
  - split the single patch into two
  - only cgwbs maintain lists of attached inodes
  - added cond_resched()
  - fixed !CONFIG_CGROUP_WRITEBACK handling
  - extended list of prohibited inodes flag
  - other small fixes


Roman Gushchin (8):
  writeback, cgroup: do not switch inodes with I_WILL_FREE flag
  writeback, cgroup: add smp_mb() to cgroup_writeback_umount()
  writeback, cgroup: increment isw_nr_in_flight before grabbing an inode
  writeback, cgroup: switch to rcu_work API in inode_switch_wbs()
  writeback, cgroup: keep list of inodes attached to bdi_writeback
  writeback, cgroup: split out the functional part of
    inode_switch_wbs_work_fn()
  writeback, cgroup: support switching multiple inodes at once
  writeback, cgroup: release dying cgwbs by switching attached inodes

 fs/fs-writeback.c                | 323 +++++++++++++++++++++----------
 include/linux/backing-dev-defs.h |  20 +-
 include/linux/writeback.h        |   1 +
 mm/backing-dev.c                 |  69 ++++++-
 4 files changed, 312 insertions(+), 101 deletions(-)

--=20
2.31.1

