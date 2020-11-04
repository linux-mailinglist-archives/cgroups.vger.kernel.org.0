Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D612A70C8
	for <lists+cgroups@lfdr.de>; Wed,  4 Nov 2020 23:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgKDWrJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Nov 2020 17:47:09 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:26564 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726996AbgKDWrJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Nov 2020 17:47:09 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A4Ml1Gh015995;
        Wed, 4 Nov 2020 14:47:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=i6hIhBbaplErdssUdp2AQT9+surBNka9EcYDoCuFP4M=;
 b=NgH/bpVxgY9Twb6BSxSYi4JIJUuXO2QKcFMhKuHVMtqkl/EZ1tVde1aD7aNO4/EfsScm
 hb+hz5NTt0e8d/2nB1KsoePOlfRu94r7Yr5VPV9PiEN8bAvIKs8E/V4cuxR4e9zED64E
 wxiGmrG3TGda31g+3rvUXJ1bEflK0ze/FB8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34kd6j7k4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 04 Nov 2020 14:47:02 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 4 Nov 2020 14:46:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNU6BHRrZWR5CjmDhtKX62kHVSJJpqPV2BxF85cRgtNhdvewb0Ist8Fubst6uO0AOMj1oDZTAwZES18HBA6ankhwIIyYxIXpYwCUUHzd13o5QmKzUCc7D9OKRYLN46ZOCuTCVVh/j4uiWpFMeg2OPW+Ut4DHQdUj+GqjDHV/EmB4G9W5BVbKgbjJYcm8KK/PC2X6gSiow99kFRH6o/USJtcN/kzIrCiYYvdfPycFIvfGWBUA7K0fYdEp7T3KlO+if1wPIXFtanvBzpWy3+NMvejjd0kW+s6PII+b7pajX36gOnA/306CTfF2QZihilcOfBD+d8q/HjUf6L8r8Ixmbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6hIhBbaplErdssUdp2AQT9+surBNka9EcYDoCuFP4M=;
 b=FOd7Sl4cmVW1xsvQRzwT9fAj2i2WsGQNcXkAdWtqSR1HrhgfiIx3N3+WRiLqa85/QIbvMwVSlE6qgchTWUgbUVsSo7tnbYXWi2BMFI+wq4icuoVZFzSjXaii+A5fi3CqbKPimkLHNov081COAlh62o/YMFWNFIPVUA+zxEKZB3EvPjDDCvLBpSNL6BwWjSbWSBkN3MwTIXniJHj/lROVXKYpTMQffAVLqJLKXG1p/HEurc/HvFd9dx4gwFOcYQHXGV67hqlTGW06FINXUk46gZ+DW6faat9Fo3yc+xZT7LH8IPk9Pt23XosrjmgbfHt5QD21gs515x8jUr/My7vFYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6hIhBbaplErdssUdp2AQT9+surBNka9EcYDoCuFP4M=;
 b=Dt4vTToEgdwxYUPsaA4N67Le5i+Yf9/SZIPgDH3Wbz50cAIEzIwq/nS3np/YSSIdoKhDhCf38ovuKHDR3fpzB+ZQXhSuvAp/fZq85zF0i9Vdhh+bNZ+JuMuY6yJUsFOd9uMC6Bf7qUdc548yHABzA3ZBXZBM+Uo4FucCvsOr/6Y=
Authentication-Results: 163.com; dkim=none (message not signed)
 header.d=none;163.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2214.namprd15.prod.outlook.com (2603:10b6:a02:8d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Wed, 4 Nov
 2020 22:46:27 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 22:46:27 +0000
Date:   Wed, 4 Nov 2020 14:46:22 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Hui Su <sh_def@163.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/memcontrol: replace '== root_mem_cgroup' with
 mem_cgroup_is_root
Message-ID: <20201104224622.GE1938922@carbon.dhcp.thefacebook.com>
References: <20201104151457.GA108301@rlk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104151457.GA108301@rlk>
X-Originating-IP: [2620:10d:c090:400::5:806c]
X-ClientProxiedBy: CO2PR04CA0116.namprd04.prod.outlook.com
 (2603:10b6:104:7::18) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:806c) by CO2PR04CA0116.namprd04.prod.outlook.com (2603:10b6:104:7::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 4 Nov 2020 22:46:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03a2e75f-5d37-4482-de91-08d8811376f4
X-MS-TrafficTypeDiagnostic: BYAPR15MB2214:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2214839F377EDB15E0E1B77FBEEF0@BYAPR15MB2214.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1MRNTsv26SoykT8IYf0XAw6Em5ZRG4C6QctxA2xPCUp0QJwl2DP2S0wtP73xLA8vFU6pGTP6ejNL/21/Eq7geEyPKAYPVQa9w/YI3TFp12oPlFjTCVBF3hrj3vfLpbMs9CGPwItSL+FMB1fCmEqwxMzKmHiTfsSX4v7aujOTYgqxh8Vc8a8fMP5UCHb3FqNzrj4FRCS/TsAQvjTneoZxZ6vUEwpeXwpb3TCJLhfj9TzXwcLCshYcwZ0ExIMicGnxHI4MFlLLkNgP7DzNmjVKKOgCpU+CZC2FiGLEj5+nF4dypjkH6IJCIVyaANCjx2WQ5tIRzR4sxpk0eosj4NsqHj+I90e3S2Oz24q/hdFzL/0OlOtebCrNWSQ+29a5vr8u4JgRIIUsxIq+xA+A2easeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(136003)(39860400002)(366004)(6506007)(86362001)(6916009)(316002)(52116002)(7696005)(966005)(4744005)(2906002)(55016002)(9686003)(33656002)(1076003)(8936002)(66946007)(66556008)(66476007)(478600001)(4326008)(16526019)(83380400001)(186003)(8676002)(6666004)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Z4yDPEV9orJSwqOjwcUY9kFXdU0BfoE1kFg46R0hY//D3xIYiNzqB/1S1Ua055fxKYChghr9HeOUutb17w9Sd78AfmAz/4K9cg8cmNUz87AqURwIiQQxWQtkbvzCfcTLViBAH8Qyz/QGdioB8UDUc7RHN6AUYimerFXEUWEO0Q5B5gIgWvPYqtpGqnQ5h2K48qODMa3eeLZ/UmuUL3NuUUZQhbxdM+BBFP9opRryw0sLUiV8SOTUqo3mPSV4tj1zEVabhl8gpS+AUOXxBT2a/oYvvPpDTccNcnryfKlVqrLfAed3X3RwOSqORU5P63Ij9Io2ce5tUWO1Lc6N0H11BHKXFk/xs5UllZWGCX5qz2HxYwFheJAZHXMhEWzpwqQJz59A3HID0mqejmYEXw3G/OaWaBEFZdPOi4wpoBn44SZ8n0H3PWQVZbLbA2L6I6mpS5aUX5GgL33CGUAb+KCCsnddVSoAesdCvhc0WJOu0mBcl+8miGkZYUVdw7hqostkLiyYPZbYtIhRDtdCxz17cH5N1x7Ikj1P3xQXTw4ndRa9mOdoQq0fuGmVGgLQH0nc/tbLenmlTqrM5PgRBdbRI+Fb1yeUiGyN43tKVyV3FzwCCdAH6lFjkdCFab7vK93/qZ+B98t3Xdj0lHDUXDRTBo7+mJHUDfNQGF7zILlcO0H4jt3Z7xhckqq07RCLxU1K
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a2e75f-5d37-4482-de91-08d8811376f4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 22:46:27.4865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkKz6zI+OkQ+reW/jlhHAoWaXw5HjOn4PqqmVG97WYVS7SOH37Y5b6aQPyd4CW7m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2214
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-04_15:2020-11-04,2020-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 mlxscore=0 mlxlogscore=822 adultscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040163
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 04, 2020 at 11:14:57PM +0800, Hui Su wrote:
> We have supplied the inline func: mem_cgroup_is_root().
> So we may use mem_cgroup_is_root() instead of using
> 'memcg == root_mem_cgroup' or 'memcg != root_mem_cgroup'
> directly, which is more readable.

Most of these comparisons will go away soon:
https://lkml.org/lkml/2020/10/21/612 (this is
an rfc version, I'll send an updated version soon).

Thanks!
