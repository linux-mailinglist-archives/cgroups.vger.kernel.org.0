Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FDE3DB1BA
	for <lists+cgroups@lfdr.de>; Fri, 30 Jul 2021 05:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbhG3DHx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Jul 2021 23:07:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:25830 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230199AbhG3DHw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Jul 2021 23:07:52 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16U33VFT018309;
        Thu, 29 Jul 2021 20:07:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=54NPDS6lB4VPZ4bo5JGJQTtu3qHWneipWZYY8A8LkxI=;
 b=Tm0lOPz7orr9fWBuz7xeb5TE1pTWHrB2M/RTmikDu60rx0g6Ezjw2sR4mpmtvuSVWrJk
 3IfsKMMUQ+5KZNaF7FOZuOcI5QQ19ThYbf77x13Vjts2qacZWpmuIeUJdqJ/BALok13w
 yOdfLhNrExpu6Txalb1mOXLi39iu8SLqkpI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3a3a9r35f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Jul 2021 20:07:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 20:07:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbMigbb5CLOleRbIWqrxijHzKQmqo3p3S1xgiBhxTQLtIqkw6g4UTyqmp0rTVfMzkzlJgCXT5OIx8MsJxlhVwW0/sQLtQsy6/kSF+YPON6qc/YbNOaQHmKN6s1Esk85tudqvxwQIaybIjehKXrFNagArqOk+2JbfpRS5KKdWd1G9+IjV+LqEUHC4lChX5iQU+NjxHhdfJ7rnRRy4pMmro5cv4b9td84O2+EpcXW9x6/pUSq0jo3x24B7yNeOnPhOonin6zkubaFe8DunsTSH0lIQ3Dmy3itl7VvBnsksMGERxUsq74UPl436qOsPSvOJ8Ehg4jBwfFe5FzFJ+FQbPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54NPDS6lB4VPZ4bo5JGJQTtu3qHWneipWZYY8A8LkxI=;
 b=iaFdOMEp2e9+ncHtpaBEfxkI6DXNmpe7GJNiePUZQShDMkSCKhbXlyX9AT2y4E3LHRkUCRRmKKLEwltAroCNrz+uutN2DHuj5AP7EmOHHFTp1n2aVNvLrkC4CdlzROxV4OrvVTdTtiD0KnyH+wdOWDxhge5lRZSKZZKLsMJf3FR4Y9/6yfxroS1qfTxsIhCn64dbev9VkasKWyyTxa74k3iXRZEKHvUk5SCoDq+PoUp2JCp8f6K7zCFjGUz9HWiVf/H/ikjsbfINnA3yEyvXHrwxjZLVEcD5oaWvuHM4hQLh3fN7gufsObs0gUKoq2IIDqWK0jhDbFm0NhElPtdq9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4472.namprd15.prod.outlook.com (2603:10b6:a03:375::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Fri, 30 Jul
 2021 03:07:32 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7%6]) with mapi id 15.20.4352.034; Fri, 30 Jul 2021
 03:07:32 +0000
Date:   Thu, 29 Jul 2021 20:07:27 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <shakeelb@google.com>, <willy@infradead.org>, <alexs@kernel.org>,
        <richard.weiyang@gmail.com>, <songmuchun@bytedance.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>
Subject: Re: [PATCH 3/5] mm, memcg: save some atomic ops when flush is
 already true
Message-ID: <YQNs71JoXrxTnAA8@carbon.lan>
References: <20210729125755.16871-1-linmiaohe@huawei.com>
 <20210729125755.16871-4-linmiaohe@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210729125755.16871-4-linmiaohe@huawei.com>
X-ClientProxiedBy: MWHPR12CA0060.namprd12.prod.outlook.com
 (2603:10b6:300:103::22) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:166a) by MWHPR12CA0060.namprd12.prod.outlook.com (2603:10b6:300:103::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Fri, 30 Jul 2021 03:07:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7bece4d-f77c-41d6-392e-08d953072c1e
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4472:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4472589F429C8863BCBC7DFABEEC9@SJ0PR15MB4472.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HR7cawqF7XEeq7/QweUYsqlB15nK+QMGpHwsy+2A9M1mP/1PDZZ3V0UENzqT8Xjgu72BY9pnK0ZRbybeFXSkcWwWUPWU1IlHgGl5V2fCuqG0EaWwxHS0pnts9jYMPpPkBjOeBN3XS0ebpT0xS9xSXAmHuoi+kPkemdwTEUTSvS/YT6vJGWBbCUABayto6Fe21CYSVBPk1Es4VQvMPuhZC0laYhkxWwQ0xSOnOltFgFT9X20r4xg9JIwKFedsADjZKfJWOYhTOQygiDv4LhxdFmSrTTgX9aK6mJsxgTH5T0vK+LUqbDgZQdbmoxRdvAwOcpKJtYcI8ZTDumo4k0+KIsLTlD+28YiZDFfvhMi7LWeLl9JFn8+fIRA8pCSJYwPTAW66pj5GW76qah9IOBpVVchazHvxEzhzNxHkEf4NYxZmGcqFAsEnFGFx7OWMaGH1folaLD3TJUu24uDCZaRH6DmB8STehXj+AG4kzytlBT8I4mVPZKzHBOhSrYh0dASWTBQ6iMXpargzIUAt6c8MT6oBoHWuVm0KELbr/LkA6N0AjHABAxXfmZOE+QngSfTK64gF1UAjlpK7XrYmsCtjX5tWBkdZpDwu5XyWX9JDwRCfh/hiRmo1XUlpr0bUWlSL2iLKE9yZSEg8xE4uTxl+ZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(86362001)(6506007)(316002)(6916009)(558084003)(5660300002)(6666004)(186003)(2906002)(55016002)(9686003)(478600001)(66476007)(4326008)(7696005)(52116002)(8936002)(38100700002)(66946007)(66556008)(7416002)(8676002)(8886007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KgQs4gQE9YFYqIm6i32x/5cffsZFAWZrtf8J5irE0b9+ajnbwpBsIChr0cOu?=
 =?us-ascii?Q?1Q2mRFM54pIC8KkP+W0aMRG6csAg71NraCeKz2b//jDSG/hCDhF3DqPWQKN+?=
 =?us-ascii?Q?GeJ7xTM8uGICGptCVreg3BUzWqvxf2pii8wLhKTpE3GfqCTmHlkGvEd0IXf2?=
 =?us-ascii?Q?hFHP8sIrepLLPm7ATcLVmDr3GVKNP512jigEfn/IOTt+DhwqRn+6idyyn3oQ?=
 =?us-ascii?Q?fUSynXga4BCa1yqdLw0L0t+FEArZLAndMx21M4LryQOXYLEgOo10a4g1Bhz9?=
 =?us-ascii?Q?Yd8WR5V3orkUs3hcmsbtCtApLMofeNMZjjQsyY2sf3iYpPC0W4O5dSoWhiY8?=
 =?us-ascii?Q?Z6YYKsQDNS217YYG41mMohEPGFFG9+lCBCKAsVcE12Ezx8GlkOowBd63PH2p?=
 =?us-ascii?Q?aaDOnRsT6RPk6lYPeICzF503aG78IiOK6sEyAgm4IWP22exnYdUsXTv8NPaw?=
 =?us-ascii?Q?HeJE93Hy+psdawYZC4v0TeyDrFLYuf26Oe0Tp9SM2aJkVm6t0S/M8nnzCC8z?=
 =?us-ascii?Q?/agSexBOwusEAUcrFArUoAUjAhWqA1sbxorWTWIpeSZnepnJiuBWaKPA5bpk?=
 =?us-ascii?Q?4pVT+58Kfug/9GH1vTSejLFofFcyWo+oJthu8d4Oc0jkbPyPV2Z4WXSbmWLN?=
 =?us-ascii?Q?DlJ1OMxMZvMLlbv9un4yr4AF8W2Sb9r/KA6XZPbk0iqiirMJyvDgW7X22J9/?=
 =?us-ascii?Q?V/al+31OX5d0gN5r9058OjWBHTCnvOhgLnD0c56NNT8XRHmpbV0tG7i7pRwg?=
 =?us-ascii?Q?4fkIWNeQCKBuN9DbrGwJgusw0BGDPM6EMr5U4bXVQvGJyy8dtT2ck4B9XnqH?=
 =?us-ascii?Q?bshvNM2/g2bmUtKoIu1fesphD2hl13gc3Y6w65Y39K4R9iDVJO77h5BtwusQ?=
 =?us-ascii?Q?MMZSu5vaG3hBOyBFwWpcKdupFRFIArTtKpBBhkCkoc3sQsB7AQCh0sjn99rw?=
 =?us-ascii?Q?H8ahKrRcVcGAuVgx/Db52BS8G8mj0rFmYsX+7UotwGj9FVT3wu+6CoiTziu2?=
 =?us-ascii?Q?kaDpOVutdh7HuRcunQuNLBN/apd7rTvyznPVdE3mQNq5feV1AZ53ZlqfOw34?=
 =?us-ascii?Q?XZkuE/BPAYjEH1+R232cX51zHdfmVfCSBNdl7W83jZrKGZx0u/HEbPk170M0?=
 =?us-ascii?Q?13dxwU2n/2uzyymVBdqcH60LarMCQszV8v6vpa81mG3F6HXWzXER13RV48b2?=
 =?us-ascii?Q?UNUPAyZxEzRtWP/1QsC1dsjk2+cMADI00OycxT0JzPNQSxWVeHIBcK+14ZQ9?=
 =?us-ascii?Q?lZlA5hCeNOWDeoS4NitGHHlGO7lYkVVq4LMmsDqBwa2VaDYg6UUW6DYhlySr?=
 =?us-ascii?Q?bJXPJCpbE9j1H3sbV46q4PzNjwTJjlf9X/lpPINKge7bew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7bece4d-f77c-41d6-392e-08d953072c1e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 03:07:32.1069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYPIFnRpB82fgtyaaU0CRWlwoiDyXPxiYflxxWgLwLb0/GzB6gQx0jqJHgNo5M/E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4472
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: hBBE5eT0Z9ZVDj-cFplQssiBlVFQH3Yh
X-Proofpoint-ORIG-GUID: hBBE5eT0Z9ZVDj-cFplQssiBlVFQH3Yh
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_20:2021-07-29,2021-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=582
 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107300017
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 29, 2021 at 08:57:53PM +0800, Miaohe Lin wrote:
> Add 'else' to save some atomic ops in obj_stock_flush_required() when
> flush is already true. No functional change intended here.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Roman Gushchin <guro@fb.com>
