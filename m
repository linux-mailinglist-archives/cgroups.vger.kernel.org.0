Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7417F59D254
	for <lists+cgroups@lfdr.de>; Tue, 23 Aug 2022 09:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240440AbiHWHfN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Aug 2022 03:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240147AbiHWHfL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Aug 2022 03:35:11 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA4763F33;
        Tue, 23 Aug 2022 00:35:10 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27N5PS1d019134;
        Tue, 23 Aug 2022 07:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3d/ElBXcPYxKWyW49KyvVjAnEwq+qBCx+4YLXDcWY5k=;
 b=SaDJhOAG/4gQ0onXSxFKM92KFD5cJU3jtNBuWjvn4DFo87n6AM77r46kFw39bsFSQ8ai
 E9JDHh31e8YzMtCepEro/qOb88neXAtYAFOMXm/0HsZfPRfaVtWc++ztIcqpXiALHp1e
 5QS8NFLtCCDILYcwluQnJERkJb5r9pcWJy85KRzM4qTt3JAsnUGdrAZCf+Vz/UZZlRRz
 sVljtmbkPISxsK+7XtLLznl2zglxSGhhTsoPjtfiBco/CXBoeH2kwA24cM88YK4pfE+J
 +A1DiBli75rgxkwScHDJiEpNu527ye6an99ivw2sABtOa1iDw+eU7O9AIFPtca+c3+DU 3A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j4je3sp2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 07:34:47 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27N7YkHc030663
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 07:34:46 GMT
Received: from [10.216.34.138] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 23 Aug
 2022 00:34:39 -0700
Message-ID: <45e18c45-1c09-863a-65a0-3ae03ba4f859@quicinc.com>
Date:   Tue, 23 Aug 2022 13:03:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/1] cgroup: Fix race condition at rebind_subsystems()
Content-Language: en-US
To:     Jing-Ting Wu <Jing-Ting.Wu@mediatek.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <Jonathan.JMChen@mediatek.com>, <Lixiong.Liu@mediatek.com>,
        <wsd_upstream@mediatek.com>, <Wenju.Xu@mediatek.com>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
References: <20220823054148.29346-1-Jing-Ting.Wu@mediatek.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20220823054148.29346-1-Jing-Ting.Wu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9J5LNFkzL4ueqBV8-ngLYs_wAa--4W4Q
X-Proofpoint-GUID: 9J5LNFkzL4ueqBV8-ngLYs_wAa--4W4Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_03,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 clxscore=1011 spamscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208230028
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 8/23/2022 11:11 AM, Jing-Ting Wu wrote:
> Root cause:
> The rebind_subsystems() is no lock held when move css object from A
> list to B list,then let B's head be treated as css node at
> list_for_each_entry_rcu().
> 
> Solution:
> Add grace period before invalidating the removed rstat_css_node.
> 
> Reported-by: Jing-Ting Wu <jing-ting.wu@mediatek.com>
> Suggested-by: Michal Koutný <mkoutny@suse.com>
> Signed-off-by: Jing-Ting Wu <jing-ting.wu@mediatek.com>
> Tested-by: Jing-Ting Wu <jing-ting.wu@mediatek.com>
> Link: https://lore.kernel.org/linux-arm-kernel/d8f0bc5e2fb6ed259f9334c83279b4c011283c41.camel@mediatek.com/T/
> ---
>   kernel/cgroup/cgroup.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index ffaccd6373f1..0d0c959966ed 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -1820,6 +1820,7 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
>   
>   		if (ss->css_rstat_flush) {
>   			list_del_rcu(&css->rstat_css_node);
> +			synchronize_rcu();
>   			list_add_rcu(&css->rstat_css_node,
>   				     &dcgrp->rstat_css_list);
>   		}

Good catch.

Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

