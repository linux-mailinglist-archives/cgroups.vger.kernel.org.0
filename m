Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DD360DC8D
	for <lists+cgroups@lfdr.de>; Wed, 26 Oct 2022 09:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJZHwY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Oct 2022 03:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbiJZHwQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Oct 2022 03:52:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D99B2777;
        Wed, 26 Oct 2022 00:51:44 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29Q791Dk028237;
        Wed, 26 Oct 2022 07:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=pQJixVHnlAul0yFSM31Yvmc1HRdeg37EuUqq5B4xUPM=;
 b=GQYEuDNQIv8Lujd9toSQ/YuG+1uJiI1etr3dbEemHsirIHqfQoYLUM+pIIy268TijR72
 EC9+nX5knhijqlrD7U1RDJXM8X0R2pb7mwqlxSy8x0oSPyLlxuE2KPeyhSoNT7CP8sAg
 mGKOEAIlpJ1h4kiC1j2EuXqY1T9HQIRawX8Z9Eh7mio1WY6A1GCGBlyCJTna0kR+SzAM
 ocsdLdypbrKb9xQDhYXI05h2sFek3poR1c4WQcjt99mWQktdOqN632YrtlyeDGliC8pW
 0e/RVqgZm4ham6jAMf1ACkfCq/B3zWjuElOJEB6WDntv7TQ0eQWpAc941ZHxfcTHfKqA YA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3keydmtgd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 07:51:26 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29Q79JxO029696;
        Wed, 26 Oct 2022 07:51:18 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3keydmtg37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 07:51:18 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29Q7aTX5009020;
        Wed, 26 Oct 2022 07:49:56 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 3kc859n2pb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 07:49:56 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29Q7iduQ50004356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 07:44:39 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA255AE04D;
        Wed, 26 Oct 2022 07:49:53 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 123C5AE045;
        Wed, 26 Oct 2022 07:49:50 +0000 (GMT)
Received: from [9.43.91.80] (unknown [9.43.91.80])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 Oct 2022 07:49:49 +0000 (GMT)
Message-ID: <dc453287-015d-fd1c-fe7f-6ee45772d6aa@linux.ibm.com>
Date:   Wed, 26 Oct 2022 13:19:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] mm/vmscan: respect cpuset policy during page demotion
To:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>, ying.huang@intel.com,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        tim.c.chen@intel.com, fengwei.yin@intel.com
References: <20221026074343.6517-1-feng.tang@intel.com>
Content-Language: en-US
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <20221026074343.6517-1-feng.tang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oic6vwOK7L-beMlcPWN6oX-I5j3-i7wh
X-Proofpoint-ORIG-GUID: D6IPzMStnBp-wErhFNd0KS8OsdtP2c3z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_03,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210260041
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/26/22 1:13 PM, Feng Tang wrote:
> In page reclaim path, memory could be demoted from faster memory tier
> to slower memory tier. Currently, there is no check about cpuset's
> memory policy, that even if the target demotion node is not allowd
> by cpuset, the demotion will still happen, which breaks the cpuset
> semantics.
> 
> So add cpuset policy check in the demotion path and skip demotion
> if the demotion targets are not allowed by cpuset.
> 

What about the vma policy or the task memory policy? Shouldn't we respect
those memory policy restrictions while demoting the page? 

-aneesh
