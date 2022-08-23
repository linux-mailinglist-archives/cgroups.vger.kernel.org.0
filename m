Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D1259E4E7
	for <lists+cgroups@lfdr.de>; Tue, 23 Aug 2022 16:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242011AbiHWOHa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Aug 2022 10:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242039AbiHWOHL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Aug 2022 10:07:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88DE252CBF
        for <cgroups@vger.kernel.org>; Tue, 23 Aug 2022 04:18:30 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27NB0D6M000488;
        Tue, 23 Aug 2022 11:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DfKDKQJKl89x86Q5/XAwie+DWZgdFcgm0KsDDChz1D4=;
 b=H14arlBl3NbU9+h7eFhtPqdzY9Q+E3zrZ+eblwDHDsX6xudabBmqmBpVPlti09+8lDq+
 t4MtiuZVDl9oHo7ZXiZUjRsWSszDKyrka4tpnZFqC5A9w+Q0H0sCJK8ZYME46vh4DRz4
 vJXz0UzdefVIRqR7O1be1f6Kz3uLcD0HGk0p7aM+IxWVtWZhIte++mGYG3f1te0U62ii
 QoUsl5YO52h6AVTPWs5GJeu3Z3cPi6Con1dq80uyvCZbZGNS56LW4AMVUnnY8VnTe7NA
 NVKMK4ONegKbp2SnYJusBFe3NMP8P8BQnDeqB/uPNTgAXaNa+621B40vDsH7ax3hknMv 8w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j4phb2874-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 11:17:36 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27NBHYMK030872
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 11:17:34 GMT
Received: from [10.216.34.138] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 23 Aug
 2022 04:17:31 -0700
Message-ID: <681dfbc9-627f-6a09-76e2-b35a920fbe7b@quicinc.com>
Date:   Tue, 23 Aug 2022 16:47:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] cgroup: simplify cleanup in cgroup_css_set_fork()
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>,
        <cgroups@vger.kernel.org>
CC:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20220823091147.846082-1-brauner@kernel.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20220823091147.846082-1-brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gA3LUF8xkbenASu9AHjj0VDLn_cqmJCO
X-Proofpoint-ORIG-GUID: gA3LUF8xkbenASu9AHjj0VDLn_cqmJCO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_04,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 clxscore=1011 mlxscore=0 suspectscore=0 mlxlogscore=681 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208230044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

On 8/23/2022 2:41 PM, Christian Brauner wrote:
> The call that initializes kargs->cset is find_css_set() and it is the
> last call in cgroup_css_set_fork(). If find_css_set() fails kargs->cset
> is NULL and we go to the cleanup path where we check that kargs->cset is
> non-NULL and if it is we call put_css_set(kargs->cset). But it'll always
> be NULL so put_css_set(kargs->cset) is never hit. Remove it.
> 
> Fixes: ef2c41cf38a7 ("clone3: allow spawning processes into cgroups")
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
>   kernel/cgroup/cgroup.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index ffaccd6373f1..2ba516205057 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -6247,8 +6247,6 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
>   	if (dst_cgrp)
>   		cgroup_put(dst_cgrp);
>   	put_css_set(cset);
> -	if (kargs->cset)
> -		put_css_set(kargs->cset);
>   	return ret;
>   }
>   

LGTM.

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

> 
> base-commit: 1c23f9e627a7b412978b4e852793c5e3c3efc555
