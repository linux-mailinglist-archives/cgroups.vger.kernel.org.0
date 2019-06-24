Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8A9850BB9
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2019 15:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbfFXNTU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Jun 2019 09:19:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56550 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbfFXNTU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Jun 2019 09:19:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5ODJ0OZ165441;
        Mon, 24 Jun 2019 13:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=ukvKF+6EKxDXdy5ac54CpdKSb/Bhckv8wOpEKFESCAM=;
 b=vvlJpET5e6JvyJItbtElAh6WSetiZEWvxA0/vz8Wm6tLKblUgPAH1LfmuV/0C7gnNkfE
 W7aXr38ZrRtNftmcnyHRH4CFCPJ14s6Hd6z2IzC9UNU3cy07BN/GC2H2puwc/MsCxfJW
 W05/ZVcYrG89DeEM2QgiJiHkwJYcvxbG7ZP2iOthlBNsuSYJtcmbEevUTpOkRda9nrQs
 wBMHk5Aa3Ono2Jacli6oMPzj3e1pnw4Rcab5MjLp5efCJqHpc+JJUuxIv1EuhhpPxVlV
 77VVEGYOI0ERicT2QPPpzhINNbQsYs698b4dI3StAopkgRqZ2AxyIPHFJTRiILPQEe4a mQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2t9cyq6a9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 13:19:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5ODIgSQ164409;
        Mon, 24 Jun 2019 13:19:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2t9p6tk0yg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 13:19:16 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5ODJFrk009331;
        Mon, 24 Jun 2019 13:19:15 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 06:19:14 -0700
Date:   Mon, 24 Jun 2019 16:19:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     guro@fb.com
Cc:     cgroups@vger.kernel.org
Subject: [bug report] cgroup: re-use the parent pointer in
 cgroup_destroy_locked()
Message-ID: <20190624131909.GA32073@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=269
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=313 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240109
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Roman Gushchin,

This is a semi-automatic email about new static checker warnings.

The patch 5a621e6c958e: "cgroup: re-use the parent pointer in 
cgroup_destroy_locked()" from Aug 2, 2017, leads to the following 
Smatch complaint:

    kernel/cgroup/cgroup.c:5531 cgroup_destroy_locked()
    error: we previously assumed 'parent' could be null (see line 5515)

kernel/cgroup/cgroup.c
  5514	
  5515		if (parent && cgroup_is_threaded(cgrp))
                    ^^^^^^
Apparently this check has been around for 2 years and we've never Oopsed
so it can probably be deleted.

  5516			parent->nr_threaded_children--;
  5517	
  5518		spin_lock_irq(&css_set_lock);
  5519		for (tcgrp = cgroup_parent(cgrp); tcgrp; tcgrp = cgroup_parent(tcgrp)) {
  5520			tcgrp->nr_descendants--;
  5521			tcgrp->nr_dying_descendants++;
  5522			/*
  5523			 * If the dying cgroup is frozen, decrease frozen descendants
  5524			 * counters of ancestor cgroups.
  5525			 */
  5526			if (test_bit(CGRP_FROZEN, &cgrp->flags))
  5527				tcgrp->freezer.nr_frozen_descendants--;
  5528		}
  5529		spin_unlock_irq(&css_set_lock);
  5530	
  5531		cgroup1_check_for_release(parent);
                                          ^^^^^^
If "parent" were NULL it would Oops here.

  5532	
  5533		cgroup_bpf_offline(cgrp);

regards,
dan carpenter
