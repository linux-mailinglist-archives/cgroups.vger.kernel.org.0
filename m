Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1075BCA21
	for <lists+cgroups@lfdr.de>; Mon, 19 Sep 2022 12:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiISK6N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Sep 2022 06:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiISK5g (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Sep 2022 06:57:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E771262C;
        Mon, 19 Sep 2022 03:54:50 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JAWg09027711;
        Mon, 19 Sep 2022 10:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RcMmOlpnS4AWnqNiIpy8ZOmV53hTUnYc4Fvlx4MH3BU=;
 b=IgzlouolRenhn2zc65LTb3I0tABPSChqtEq8wvqMI9rFrUBfr3U9GFbloG0eA42KcVdq
 DSW+XCM6mWWwgSpj/leIu/+aPmr4Kgvp4sRr0GpmWY4XB9PRM/JZwlk9aywJXzWrzybK
 kBC73hVz3YQ4S+uS67290jgtf11T8aRbjAdGzMK8nMYlgj1gMXnIF+QBeV5VYDOLpeeO
 Z6A90mR8+xvhAtxQ21rF9oW3TKGTOKYOn8dxnEENAobJECx3Z/iBce3e/lFCRb67/hwp
 01WCuEWBGYvcu+Kn/CPw+xJZYsQvFWpim0Yxb98uoQZqdIktMH6eTlJ1sQ/CIwR9NRBN 0g== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jn6qkuybp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 10:54:36 +0000
Received: from nasanex01c.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28JAnZXK030764
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 10:49:35 GMT
Received: from [10.216.9.124] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 19 Sep
 2022 03:49:33 -0700
Message-ID: <22ef7722-2f60-688d-4cf0-f59f0272a293@quicinc.com>
Date:   Mon, 19 Sep 2022 16:19:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH -next] cgroup: simplify code in cgroup_apply_control
Content-Language: en-US
To:     <williamsukatube@163.com>, <tj@kernel.org>,
        <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220917084039.3177-1-williamsukatube@163.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20220917084039.3177-1-williamsukatube@163.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QjoM6nAAElov_lVg4QOT4_5IgEKDQH9q
X-Proofpoint-GUID: QjoM6nAAElov_lVg4QOT4_5IgEKDQH9q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 clxscore=1011 impostorscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190072
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

On 9/17/2022 2:10 PM, williamsukatube@163.com wrote:
> From: William Dean <williamsukatube@163.com>
> 
> It could directly return 'cgroup_update_dfl_csses' to simplify code.
> 
> Signed-off-by: William Dean <williamsukatube@163.com>
> ---
>   kernel/cgroup/cgroup.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index e4bb5d57f4d1..1958f8bd93d6 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -3292,11 +3292,7 @@ static int cgroup_apply_control(struct cgroup *cgrp)
>   	 * making the following cgroup_update_dfl_csses() properly update
>   	 * css associations of all tasks in the subtree.
>   	 */
> -	ret = cgroup_update_dfl_csses(cgrp);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return cgroup_update_dfl_csses(cgrp);
>   }
> 
>   /**
> --
> 2.25.1
> 

LGTM.

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
