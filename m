Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DBE62D3A5
	for <lists+cgroups@lfdr.de>; Thu, 17 Nov 2022 07:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiKQGya (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Nov 2022 01:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiKQGya (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Nov 2022 01:54:30 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577AA5B588
        for <cgroups@vger.kernel.org>; Wed, 16 Nov 2022 22:54:29 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AH5oK82031822;
        Thu, 17 Nov 2022 06:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=pp1;
 bh=Hk/EAP4iIsWuxnIHQZ7PaULbopZTcRAEqmsstFZ1L/s=;
 b=Az7KE5xNl8WbNkwdBspdwxRIkcG41yLwAf2RVkIEOY49150X+b3MDDlRz2HWdA/3R0i0
 WzOxcHsi9Bywe89p8Nr32Nn3ZPVCjmkYEqV5x9QnR7+LDdYSoXRDhBoF8qkAwSCTWIxY
 8zNlKFfdKnJKXLMyKpxpi05AL6CaxWZRCuv6MuK09uSkZ5GaL9/W2o6nTq/adHwjczA/
 RjvR9x+j2uHnJMeiD+fLzCjuV+/VNcyEDyIniyk/KENGyKWHYVmlty2FqGKkj67jq4Q/
 CRPZjr/4jxq1LMsN+vEf7PrR6nmJEqPOBGIcMXmV7GSZsiTJIpHSR0htcv/mlZ0SoD9e fA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kwf5phsyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 06:54:23 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AH6pLBb019653;
        Thu, 17 Nov 2022 06:54:22 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03dal.us.ibm.com with ESMTP id 3kt34a77b7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 06:54:22 +0000
Received: from smtpav01.dal12v.mail.ibm.com ([9.208.128.133])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AH6sQgO13173362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 06:54:26 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51FC058058;
        Thu, 17 Nov 2022 06:54:21 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A643858057;
        Thu, 17 Nov 2022 06:54:19 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.109.205.170])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 17 Nov 2022 06:54:19 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org
Subject: cgroup v1 and balance_dirty_pages
Date:   Thu, 17 Nov 2022 12:24:13 +0530
Message-ID: <87wn7uf4ve.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lYEYWSYqK6ebQPJyRwSsjUIsXGF5FPsf
X-Proofpoint-ORIG-GUID: lYEYWSYqK6ebQPJyRwSsjUIsXGF5FPsf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 malwarescore=0 bulkscore=0
 priorityscore=1501 mlxscore=1 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 mlxlogscore=188 spamscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170048
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Hi,

Currently, we don't pause in balance_dirty_pages with cgroup v1 when we
have task dirtying too many pages w.r.t to memory limit in the memcg.
This is because with cgroup v1 all the limits are checked against global
available resources. So on a system with a large amount of memory, a
cgroup with a smaller limit can easily hit OOM if the task within the
cgroup continuously dirty pages.

Shouldn't we throttle the task based on the memcg limits in this case?
commit 9badce000e2c ("cgroup, writeback: don't enable cgroup writeback
on traditional hierarchies") indicates we run into issues with enabling
cgroup writeback with v1. But we still can keep the global writeback
domain, but check the throtling needs against memcg limits in
balance_dirty_pages()?

-aneesh
