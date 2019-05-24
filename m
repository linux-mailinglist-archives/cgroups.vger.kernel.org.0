Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C96842A1D4
	for <lists+cgroups@lfdr.de>; Sat, 25 May 2019 01:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfEXXwX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 May 2019 19:52:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51184 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726125AbfEXXwO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 May 2019 19:52:14 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4ONnDGX006988
        for <cgroups@vger.kernel.org>; Fri, 24 May 2019 16:52:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=XDz+gmj/EBFqZGWRU3jYaIrBb6wF338CvPmYvlgJN2I=;
 b=mv80gHPIWaroUzxkE2SCC1qEQelrZ/H4Chtait3Z/WfTyBoiNBkUGpFAmbr54Bfjk22P
 FLHd4zHolOU9WCSs6wBkPlks1gxF17SNszVMCxVC1pIDDWE/GY4W/4v3kAPxhTgEdOlY
 wP2Og9eLcbW3Ah18O3A+G3tZ20mJDUquOJU= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2spmmws6tv-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <cgroups@vger.kernel.org>; Fri, 24 May 2019 16:52:14 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 24 May 2019 16:52:11 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 3A7771267AEB3; Fri, 24 May 2019 16:51:57 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Alexei Starovoitov <ast@kernel.org>, <bpf@vger.kernel.org>
CC:     Daniel Borkmann <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <cgroups@vger.kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Yonghong Song <yhs@fb.com>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v4 bpf-next 0/4] cgroup bpf auto-detachment
Date:   Fri, 24 May 2019 16:51:52 -0700
Message-ID: <20190524235156.4076591-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-24_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=744 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905240162
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patchset implements a cgroup bpf auto-detachment functionality:
bpf programs are detached as soon as possible after removal of the
cgroup, without waiting for the release of all associated resources.

Patches 2 and 3 are required to implement a corresponding kselftest
in patch 4.

v4:
  1) release cgroup bpf data using a workqueue
  2) add test_cgroup_attach to .gitignore

v3:
  1) some minor changes and typo fixes

v2:
  1) removed a bogus check in patch 4
  2) moved buf[len] = 0 in patch 2


Roman Gushchin (4):
  bpf: decouple the lifetime of cgroup_bpf from cgroup itself
  selftests/bpf: convert test_cgrp2_attach2 example into kselftest
  selftests/bpf: enable all available cgroup v2 controllers
  selftests/bpf: add auto-detach test

 include/linux/bpf-cgroup.h                    |  11 +-
 include/linux/cgroup.h                        |  18 +++
 kernel/bpf/cgroup.c                           |  41 ++++-
 kernel/cgroup/cgroup.c                        |  11 +-
 samples/bpf/Makefile                          |   2 -
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |   4 +-
 tools/testing/selftests/bpf/cgroup_helpers.c  |  57 +++++++
 .../selftests/bpf/test_cgroup_attach.c        | 146 ++++++++++++++++--
 9 files changed, 262 insertions(+), 29 deletions(-)
 rename samples/bpf/test_cgrp2_attach2.c => tools/testing/selftests/bpf/test_cgroup_attach.c (79%)

-- 
2.21.0

