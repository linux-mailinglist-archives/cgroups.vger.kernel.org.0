Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A6C36F49B
	for <lists+cgroups@lfdr.de>; Fri, 30 Apr 2021 05:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhD3Dqo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Apr 2021 23:46:44 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39530 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229590AbhD3Dqn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Apr 2021 23:46:43 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 13U3hZk7028016;
        Thu, 29 Apr 2021 20:45:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=yk7naFH/uiPWW4wIDzT3ehFQAMCmIto+rApOVpqNXo8=;
 b=bG4SFiknerBZnBlLjgQbTmMR9VGbZpflexiNtm6PKm99Aih897w0N54LyZAdJxST1tnT
 kdE7LW7AiK1+vOgQvNjlFlTLG1sF2JviKnf9nGnZAvnDYKHI69H9/SIR6UpJSTUz4MCR
 WOizl8DJGwDkD/j2KomQWhd1tafaBdC75V0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 387ppapm0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Apr 2021 20:45:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Apr 2021 20:45:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niOZTaYym5uKxss3ZA07y9bqvy4h1YvQR0WaaWFTSyIR+kztcZot2MBi3mRP1T2AIY+LRlWk9PDr8WCG75czNn66ZSTIhJoeC18cKy3REFfxI24Df7oC+Y2PLFeh74qt3Zg370v0fBhkU6pi+aavKI8UIgmBOPECzLKEnn7tOxl5yVwKt5RzL6KRBCyUHkd7Z3MbZIPv4PVSs0Jhzcu+1zqABRFBYBh/Mq7XFqZtn0kYEotAmF8+60xuXrCz4s1QK35LQX/ATjbtQvtz2dHN/gpMY9O3vqDqgwnYmaZxXg0zPPMoMla1bDSjZo/dDZShTu4wBb++GPVMIw6A1g3hxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yk7naFH/uiPWW4wIDzT3ehFQAMCmIto+rApOVpqNXo8=;
 b=ikaNc/lv118CzXasArFWwLR2nCRTtgd+OuSaWZcrt8xC3nuv1MDTdHuY5yY1xqZ1FTxtoMs+EDgYYKNKGM61EXNWQj9kznRaXRpjF4N0j532sbwj1rNideWvKjJOwPfhnbYvKmSzA6BXsbrz2hjNeiXGf4S9lA78vZ1GgCTzqTjEmckk8MVmOJfEQos1e8g7JEWTFaDbtW2ifnXHMVoQsrE0WALC5wE+DZ4otCrw1zv5CpANX1SCUwBSvFji4H66Mcor+Sg3Fd5TiSce8GYjc23MmKs2QmM2L3ohXJ5JBf3LN7kPHdBZtCdDdBztC5QO5bPXu9f9RWK74+ZVBfdyIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3352.namprd15.prod.outlook.com (2603:10b6:a03:111::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 30 Apr
 2021 03:45:48 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4087.035; Fri, 30 Apr 2021
 03:45:48 +0000
Date:   Thu, 29 Apr 2021 20:45:44 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 4/5] tests/cgroup: move cg_wait_for(),
 cg_prepare_for_wait()
Message-ID: <YIt9aOSG0RIFwv4+@carbon.dhcp.thefacebook.com>
References: <20210429120113.2238065-1-brauner@kernel.org>
 <20210429120113.2238065-4-brauner@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210429120113.2238065-4-brauner@kernel.org>
X-Originating-IP: [2620:10d:c090:400::5:4471]
X-ClientProxiedBy: MW4PR03CA0170.namprd03.prod.outlook.com
 (2603:10b6:303:8d::25) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:4471) by MW4PR03CA0170.namprd03.prod.outlook.com (2603:10b6:303:8d::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.28 via Frontend Transport; Fri, 30 Apr 2021 03:45:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e4eadc4-049b-483b-85d7-08d90b8a7115
X-MS-TrafficTypeDiagnostic: BYAPR15MB3352:
X-Microsoft-Antispam-PRVS: <BYAPR15MB33524C61173B94C2829DA610BE5E9@BYAPR15MB3352.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XDltKEDlq1YSnNSr10BnfD7z2GI70W5rXzerBtAF9nCc7uhZOwwz2nb3icYH7SePCdYWYUszCKUmLylWYdYzn57MYQP3dHDMz7qrKDvD6RkjAUdA0Dbfy5Q7A1k0PC/88Drcze68i5ij2RRXqozB+Rgm8aoO88A4yDxHoEp/3PBWiWyZwn4btHL4XtYQxlk6431v4JMm+07aTG3B1tqMIL0YEanYRysvxJbtrhCnR64aT9DSPG17iku8KKHTqRopmpvkZtnayDoa4q/TbLefDaVqVqE656/59P78NAGzQPov4fdVA/jDqqbwgE3YVMVo82XwgPSvv/Ww363Gr7eqRrLwG9GnssSe9FIS0jWGbj20Nih5aqk8EmjVQ/3TqfHIhE1QY5zC4uQNSbaXj0cfcBdCgeGKXMIVpSKAH1X3XbMTusqd4c3Wnxmh49nBftjQLL4NuPtvDLac3sJ7jy/bdBa41sa3mE8lGSQs4Ymk8lZEj6UNRpJLOtO7UJLIC5LyFsrcrPVIvXqZWSXTfm7HSd52HcZN19rUCTN86xyFd4/1k/a1ZDllK6u6Vtd4W1lm9l0YyF2qm21/S2viaDP0Cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(66556008)(55016002)(8676002)(66476007)(6506007)(66946007)(86362001)(8936002)(54906003)(16526019)(38100700002)(316002)(52116002)(2906002)(7696005)(6916009)(4744005)(5660300002)(4326008)(9686003)(6666004)(478600001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?yIDzeL6E4peZAcd8/Qc7IqZvXgFAMMwy+LOi3K2JYLqTvddGbM//17ZNKoW0?=
 =?us-ascii?Q?427nE/kXCU1JILBXXeqmNPeBa/Xch32kDr5281QAytGdWZztvn2/99pzrGAn?=
 =?us-ascii?Q?rpsO9HuK3PiRt9OeECiNaewVNEX1F+zHn3wqbDisHMHb1co/8P+FYdUEI8Mh?=
 =?us-ascii?Q?TFYpwPIcNQtH5l9CeoRvoKJOfOZko1Ez1Vbq5VTFOIHziGgizLyWh1xIJQbN?=
 =?us-ascii?Q?WCGLlfgDXskzn1SnZgn+DDiJnSyUA5UhI9is7Z1Lp/9Yory/Va+5dTZgXw73?=
 =?us-ascii?Q?8dJefJfgh6IZk+mrFdiRDvBbOISxXCgUuymzEeeTTLhD+bYIyH75Bz3tirT0?=
 =?us-ascii?Q?bo7sdB8Mpwp93WVm+EXaMXVb8yc058dsG4waKwoelmmBuYFiK9ytGMWT2Iu+?=
 =?us-ascii?Q?IABc5S/nt5ojMSARRVCVrKkIVucId8kCDygQiMLmvqitvtKy5OjrQMbCDV8D?=
 =?us-ascii?Q?fqY6KYNA0oNoJZP9APBdypk8m2tLCyySgUDA2eWzDMRuHvf7jI6fUzsKfcBM?=
 =?us-ascii?Q?0eA1TxYWWm6LWwfCjw840lNpPI0iZN11fDEwEg9G8guD0gxZwyqW7eyakthv?=
 =?us-ascii?Q?1+CAtECpuOhRhnuazO9ojgUsnJxos3m6yoH5cxNyscSz64qD4jyyw5ugppWc?=
 =?us-ascii?Q?jNZUTV8JSB61iNvsPpeXg0S2vhtWYubjSw0/xWZjkELmHw7r1FrqU2PV5+JD?=
 =?us-ascii?Q?HJNLb1RdPnbCsK0Pss5KRR1Vmo64hSXnnR7YqvzTBQHO1VeyKI3516eLW1sI?=
 =?us-ascii?Q?2V/aeMwTKtNeHLYGJkVCbCR9x2P1pl2gtzFx7LWCkdzBnO8ZiotgAAU8NLol?=
 =?us-ascii?Q?u8bwtwv/6DNo7snJJNjvtMUvqFx50388ehffOSD1S1eYHyEZAIqX/9L9A8WA?=
 =?us-ascii?Q?IxneCew+2ZJYPSv2a/l28iORHPQHJPfnR78ISMYK9dWjpyR4WR2xBtIHFCZ7?=
 =?us-ascii?Q?tIsDCNVMTroWuIWBlsD+5snVITYz7FsQjilBN1CqzRhI6+GM6dFhx+yxE42u?=
 =?us-ascii?Q?tBe0MkFEjWyC1rePe+dPjcOsWJPEMuoRI78BxVB77UUAjgqp2PXV8Fq4WT4D?=
 =?us-ascii?Q?+s75bgLu1y9lyJZ28qiWdmduEGMgRrV5n/v/xJKzO2h8JY2rVZngILn+MB1V?=
 =?us-ascii?Q?BRjX93pXLsCMT1xDDZ+y9bS37UCkIwvnxnDTyH1AnCqvxCHzjSfHqbKl/euN?=
 =?us-ascii?Q?sv87OWwDKRtP8NpVuy+2JPK1PPVCTlySwawBaHgJvwB5641FoLSTxV5ABX4U?=
 =?us-ascii?Q?/j54UDDQ/pztdZ8Lm80SZy9pJQhZRGfP71y9rgfVtEKUpjGyyCAZc2F2/LpK?=
 =?us-ascii?Q?siAVnR580on9COUsmWXtkaQuwLVOy44zdridmF3xLXkM4Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4eadc4-049b-483b-85d7-08d90b8a7115
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 03:45:48.2452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NIn/h3u8sb/Od8PZVShIgKJIyaPlEJlNLX9/qvyuzrZQLnsvKm9FSHntUhpfCeA+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3352
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 1mf8IXi1kIIgttQ7ewo6ccYAJt0KzhI1
X-Proofpoint-ORIG-GUID: 1mf8IXi1kIIgttQ7ewo6ccYAJt0KzhI1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-30_02:2021-04-28,2021-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 priorityscore=1501 mlxlogscore=816 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104300022
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 29, 2021 at 02:01:12PM +0200, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> as they will be used by the tests for cgroup killing.
> 
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: cgroups@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
