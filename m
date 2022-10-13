Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA97A5FDC46
	for <lists+cgroups@lfdr.de>; Thu, 13 Oct 2022 16:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiJMOTn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Oct 2022 10:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJMOTm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Oct 2022 10:19:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1086E1176;
        Thu, 13 Oct 2022 07:19:36 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29DCmDDs019560;
        Thu, 13 Oct 2022 14:19:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aJUHKCeMONPiBv7qlHCAOXHfax7cF/SDLjjQwEaq4Y4=;
 b=Uvxx1SCL3EKf+l5Vo465umT20Yj4c9oRV3x0jIijFiDbAlwgUghlkz9289dK5xAdzm9B
 AaJ0VYAk6OWzIH5dBBoYozkkpMZ5mQbmqunjJxtBRC+QFBeyRbNCqMZl0VItAFg1erwF
 9DQ0nyQ0ums405O8ZHev43ddIrcPyENONUNiqOFq0aqgBlNr6Oos/P1Az4f9f7AZj9hQ
 RODm19kEeYouHIaybgFcjEdnVyTVPeIsyU0PzH2OYE/JdNFI1AQEgXKw0wHkZbJoOnUY
 qbDXcQR9erXKL6IDM3EGykQJLUCvQb0cWqa8akkgzQIvjulsVGuwCmp1zSZHK+xxnjb3 ng== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k6fpsrm65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 14:19:28 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29DEJSpL023015
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 14:19:28 GMT
Received: from [10.216.35.42] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 13 Oct
 2022 07:19:25 -0700
Message-ID: <9662bcef-f901-fac6-1dff-dc2a2da216fe@quicinc.com>
Date:   Thu, 13 Oct 2022 19:49:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] blk-cgroup: Fix typo in comment
Content-Language: en-US
To:     Kemeng Shi <shikemeng@huawei.com>, <tj@kernel.org>,
        <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221013141659.24032-1-shikemeng@huawei.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20221013141659.24032-1-shikemeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZL7xVFvJtL-SnHbmHImiKG9L5Y5jg5M7
X-Proofpoint-GUID: ZL7xVFvJtL-SnHbmHImiKG9L5Y5jg5M7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_08,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210130085
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

On 10/13/2022 7:46 PM, Kemeng Shi wrote:
> Replace assocating with associating.
> Replace intiailized with initialized.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> ---
> Changes in v2:
>   -based on current mainline code
>   -add acked-by
> 
>   block/blk-cgroup.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 6a5c849ee061..4c4bc874bd95 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -577,7 +577,7 @@ EXPORT_SYMBOL_GPL(blkcg_print_blkgs);
>    * @pd: policy private data of interest
>    * @v: value to print
>    *
> - * Print @v to @sf for the device assocaited with @pd.
> + * Print @v to @sf for the device associated with @pd.
>    */
>   u64 __blkg_prfill_u64(struct seq_file *sf, struct blkg_policy_data *pd, u64 v)
>   {
> @@ -765,7 +765,7 @@ EXPORT_SYMBOL_GPL(blkg_conf_prep);
>   
>   /**
>    * blkg_conf_finish - finish up per-blkg config update
> - * @ctx: blkg_conf_ctx intiailized by blkg_conf_prep()
> + * @ctx: blkg_conf_ctx initialized by blkg_conf_prep()
>    *
>    * Finish up after per-blkg config update.  This function must be paired
>    * with blkg_conf_prep().


LGTM.
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
