Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FE14EE9DB
	for <lists+cgroups@lfdr.de>; Fri,  1 Apr 2022 10:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244434AbiDAIlm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Apr 2022 04:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiDAIll (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Apr 2022 04:41:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0E84AE2E;
        Fri,  1 Apr 2022 01:39:51 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2318BD9T007910;
        Fri, 1 Apr 2022 08:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=G5ux5PrsqjCTdlNQQ3/bauu6+cMr/v2RVE88yklbG+E=;
 b=Qnyfejn1aUQcBYsQhL85YqKJSbN56nBITnvu9+GgL94Qa/kNf4DYzoNNM3W1GMsS/qmi
 VejqjlbGKw+W3HaXb+j8d9eYn7Fj01jAjbnJEZjTirOTsUNbrn+29S4Fv9ftx6smO+Fr
 Ujsm0Tb9gaB6XhsyeKOSU+SOC9rJu1VvbyCENboE4ZUHuOpmQY+2dPcveCREuVb1szdC
 0fIHTSvR9y46SQ5K6Jvhl+FgUYG61lyYCLAgir8Xj3TXV7t3oZp2wGiVcro6TK0dhGEE
 uEhEZI6lcGqbfnFbSLynbzcmOMHECGyNOyHxM1RqsRSYoZWc3EKVBoR4orIWS3sr5rKA bA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f58a4jyc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 08:39:41 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2318a6YB023665;
        Fri, 1 Apr 2022 08:39:40 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f58a4jyb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 08:39:40 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2318T1bY030174;
        Fri, 1 Apr 2022 08:39:38 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3f1tf8tn5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 08:39:37 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2318dZ5O46268794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Apr 2022 08:39:35 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C50411C04A;
        Fri,  1 Apr 2022 08:39:35 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56E1B11C05E;
        Fri,  1 Apr 2022 08:39:27 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.211.58.125])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri,  1 Apr 2022 08:39:26 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Fri, 01 Apr 2022 14:09:25 +0530
From:   Vaibhav Jain <vaibhav@linux.ibm.com>
To:     Yosry Ahmed <yosryahmed@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
In-Reply-To: <20220331084151.2600229-1-yosryahmed@google.com>
References: <20220331084151.2600229-1-yosryahmed@google.com>
Date:   Fri, 01 Apr 2022 14:09:25 +0530
Message-ID: <874k3d6vuq.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fYnMBbHf2fqcpAFgRl4OOAvzPxfRlFzw
X-Proofpoint-GUID: mFsW9vQ_hD_8f3vLjzxT3jZrMrJO2cNt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-01_03,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=718
 clxscore=1011 spamscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010037
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Yosry Ahmed <yosryahmed@google.com> writes:
> From: Shakeel Butt <shakeelb@google.com>
>
> Introduce an memcg interface to trigger memory reclaim on a memory cgroup.
<snip>

> +
> +	while (nr_reclaimed < nr_to_reclaim) {
> +		unsigned long reclaimed;
> +
> +		if (signal_pending(current))
> +			break;
> +
> +		reclaimed = try_to_free_mem_cgroup_pages(memcg,
> +						nr_to_reclaim - nr_reclaimed,
> +						GFP_KERNEL, true);
> +
> +		if (!reclaimed && !nr_retries--)
> +			break;
> +
> +		nr_reclaimed += reclaimed;

I think there should be a cond_resched() in this loop before
try_to_free_mem_cgroup_pages() to have better chances of reclaim
succeding early.

<snip>

-- 
Cheers
~ Vaibhav
