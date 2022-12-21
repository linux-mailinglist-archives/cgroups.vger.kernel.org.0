Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CC0652CD5
	for <lists+cgroups@lfdr.de>; Wed, 21 Dec 2022 07:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiLUGU1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Dec 2022 01:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiLUGUZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Dec 2022 01:20:25 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06ED71EC6A;
        Tue, 20 Dec 2022 22:20:25 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BL66hTq023832;
        Wed, 21 Dec 2022 06:20:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=bmZs5x1Uo0vIxNOpNufK8v9HsHBzoKzBVIakLqwAiFU=;
 b=hum+6+XmnsXTqdDSRzsYZmKoYTEYe7oMOOaQePpnNXk1EkNJ9zYfOtXtBrc5O0WPLJpH
 FgeTcclUWHyeAjj7ls4jDN/2j8kN5B/BoeDIauXR+oXF8hwLBQ7+3hjBZlGBkycxxbKY
 PWn996zcSTiWwryNWYshbt6yBUPIKJ+szAa+e2jVyJcqsV6NZEZH+ZxAmwXJw0hGEL05
 O2YuwkPtOdr5hy+AdquKUiRDtTUti6hMPT5N13ZG9fSUUngDLTUtjgcN5AKGySLEuLBl
 SEeGryXXUUnajvbJ4coOiOyK3HI9FPOFG09YFqSEwFgvzSxkcOMBANtRUs4jvPjEQC1B XA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mk39tb531-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 06:20:01 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BL6K0E8021281
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 06:20:00 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 20 Dec
 2022 22:19:57 -0800
Message-ID: <f4c63e18-9666-b1db-8474-ea32da9daccb@quicinc.com>
Date:   Wed, 21 Dec 2022 11:49:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] cgroup/cpuset: no need to explicitly init a global static
 variable
Content-Language: en-US
To:     Daniel Vacek <neelx@redhat.com>, Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221220151415.856093-1-neelx@redhat.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20221220151415.856093-1-neelx@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZESUfIjrA2TvwbOqH1XYbh1ZzuKkyAES
X-Proofpoint-GUID: ZESUfIjrA2TvwbOqH1XYbh1ZzuKkyAES
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_02,2022-12-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=963 spamscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212210046
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

On 12/20/2022 8:44 PM, Daniel Vacek wrote:
> cpuset_rwsem is a static variable. It's initialized at build time and so
> there's no need for explicit runtime init leaking one percpu int.
> 
> Signed-off-by: Daniel Vacek <neelx@redhat.com>
> ---
>   kernel/cgroup/cpuset.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index a29c0b13706bb..87fe410361b3d 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3281,8 +3281,6 @@ struct cgroup_subsys cpuset_cgrp_subsys = {
>   
>   int __init cpuset_init(void)
>   {
> -	BUG_ON(percpu_init_rwsem(&cpuset_rwsem));
> -
>   	BUG_ON(!alloc_cpumask_var(&top_cpuset.cpus_allowed, GFP_KERNEL));
>   	BUG_ON(!alloc_cpumask_var(&top_cpuset.effective_cpus, GFP_KERNEL));
>   	BUG_ON(!zalloc_cpumask_var(&top_cpuset.subparts_cpus, GFP_KERNEL));

Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
