Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D616271AA
	for <lists+cgroups@lfdr.de>; Wed, 22 May 2019 23:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbfEVV34 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 May 2019 17:29:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46084 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729857AbfEVV3o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 May 2019 17:29:44 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4MLFSQA003983
        for <cgroups@vger.kernel.org>; Wed, 22 May 2019 14:29:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=THkyaL46U42CuIQO/bUMHkqiVtg4R96gtH4e/2sSFSE=;
 b=qKxa6dRDmhGboAf4t93kFw+cSCWjYrMDcCbxKQLXCH1zPD+OGhpMqESwgP3mNyUytAMu
 YR7TwU4WPFDXFEdLDT7MDYoZzwWf4VDTdbvxsg00Rq1epl12obXjfcTEd7liodvtUVOa
 9DvfQiWl6t5I0JjH7Ssid/iPvtC8DIyobEI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sn8b0sjdu-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <cgroups@vger.kernel.org>; Wed, 22 May 2019 14:29:43 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 22 May 2019 14:29:41 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 569AF1251A294; Wed, 22 May 2019 14:29:39 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        <netdev@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        <kernel-team@fb.com>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 0/4] cgroup bpf auto-detachment
Date:   Wed, 22 May 2019 14:29:28 -0700
Message-ID: <20190522212932.2646247-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-22_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=390 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905220148
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patchset implements a cgroup bpf auto-detachment functionality:
bpf programs are attached as soon as possible after removal of the
cgroup, without waiting for the release of all associated resources.

Patches 2 and 3 are required to implement a corresponding kselftest
in patch 4.

Roman Gushchin (4):
  bpf: decouple the lifetime of cgroup_bpf from cgroup itself
  selftests/bpf: convert test_cgrp2_attach2 example into kselftest
  selftests/bpf: enable all available cgroup v2 controllers
  selftests/bpf: add auto-detach test

 include/linux/bpf-cgroup.h                    |   8 +-
 include/linux/cgroup.h                        |  18 ++
 kernel/bpf/cgroup.c                           |  25 ++-
 kernel/cgroup/cgroup.c                        |  11 +-
 samples/bpf/Makefile                          |   2 -
 tools/testing/selftests/bpf/Makefile          |   4 +-
 tools/testing/selftests/bpf/cgroup_helpers.c  |  58 +++++++
 .../selftests/bpf/test_cgroup_attach.c        | 154 ++++++++++++++++--
 8 files changed, 253 insertions(+), 27 deletions(-)
 rename samples/bpf/test_cgrp2_attach2.c => tools/testing/selftests/bpf/test_cgroup_attach.c (78%)

-- 
2.20.1

