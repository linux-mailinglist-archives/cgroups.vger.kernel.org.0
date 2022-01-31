Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B2A4A4D07
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 18:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243579AbiAaRVl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 12:21:41 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:4430 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243562AbiAaRVk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 12:21:40 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20VGnMu4019487;
        Mon, 31 Jan 2022 09:21:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=JpVtCV9IOqxzDBEiavCiENiaFtF7Sl4yZqdD0/YEnNI=;
 b=oKKnWppMlaketjaoAuwIQalrtgzpdp6Jmiw1BOYvqhS6llUry640BzpL3cH/ucfKDcYi
 nOQlJRFF9MRZrXeembrXK9eCkA24n9piZZTvlv1sDF5plH9MAsiLVDcuKZMtjBK9NYC5
 Bt+YP89/ly0BS1sbA6TTlA2/dlgkzAdGiQA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dxer3t2ba-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 31 Jan 2022 09:21:39 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 09:21:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5XnjNSBoM8y1SxKZxhy8l8rQ2Ejc+dQWe04CE60n6XyQsjo/P83++Qir4RqVNokmA4WcAtomoTtvkbe3jF0EFZNaDbUjSTvEOcDCrYF8QTp1Nqol3KODJkMWalpOpxscbzbO0qAXbmlt9NbKSSFp+LhjNvaV9A7RmYpNT1ctsqTN44AIn5VCoNTvImaG6ibl40qHyaPDMieoisyEFsH7Ay5iC0ba764cFb0wTgzo/JhvAhTf+L/y5A8pF/pqcOjTPLYnAFrskUPfEmMhQWy52+WhuCYo4T0M12FZoqUBYPnN/lrs7S2Zi0EumzdhHrFqkPxwEUlC0hJ8Iq/jJy9EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpVtCV9IOqxzDBEiavCiENiaFtF7Sl4yZqdD0/YEnNI=;
 b=VKZq6L/NABSK23ulWsVizF1vrFfnzU/Tgixx0vgmqdaxbxI7mrmnazoyJctBzca97N+atuo3OUhs+YUE6L4GFHKMZaoj8qha68DAZdBnzi4OVP8CDoPDFu7cgWGLlLeEBXmHG+I29sEOMbikedtiW/xe9LQBKJQJEpEC88U1lvpIZNXbhS4v4un7LCE7CQ4pdc2dsCIOHMioXGCLdwp91tdxww0Elq2ZwGEB7nl41ApzrrQtocOvhmMEurM4+gjOM7cSMDjg8f/v/VzR+U//aOkdF7q5gdW+TBcAiGaeNeCsGHpLbaXXlJRUXQylb8v3ArKarYY5cZLBYnFp4SQRlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BN7PR15MB2322.namprd15.prod.outlook.com (2603:10b6:406:90::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22; Mon, 31 Jan
 2022 17:21:06 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2%3]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 17:21:06 +0000
Date:   Mon, 31 Jan 2022 09:21:03 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Alexander Egorenkov <egorenar@linux.ibm.com>
CC:     <cgroups@vger.kernel.org>
Subject: Re: LTP test suite triggers LOCKDEP_CIRCULAR on linux-next
Message-ID: <Yfgaf885yDFPtjJH@carbon.dhcp.thefacebook.com>
References: <87mtjzslv7.fsf@oc8242746057.ibm.com>
 <YeI78TMjU12qRmQ8@carbon.dhcp.thefacebook.com>
 <YfgWAuzAo2WDyPH+@carbon.dhcp.thefacebook.com>
 <87r18nj01l.fsf@oc8242746057.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87r18nj01l.fsf@oc8242746057.ibm.com>
X-ClientProxiedBy: CO2PR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:104:1::32) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb9eb7ef-7928-4874-10c1-08d9e4de10bd
X-MS-TrafficTypeDiagnostic: BN7PR15MB2322:EE_
X-Microsoft-Antispam-PRVS: <BN7PR15MB2322255FF6CBEDDA8551FF50BE259@BN7PR15MB2322.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ya4NDjv+EHsngdiodTGSgJEjyA6jcx26ZHCk26Ah8xerubNEUghkv8/0jAZoGrRjjWr7/992Wg2/r9kJQNkGv1U9t9wwmnwh2ijKMyujuqXejOMuFBXMO/SNQgvJu9uVHEUT1oV6nAiwx520L56JSWbUfQ+riN4BtP6JeFqaBab3npH0tSmMi+SfxAasJX8d30Y/RBOg3CT7rwa3Dataf8AAeqMVk8gtJD/IA6Kvk7ktSWn12jZ62Kfcxt4knYpsPv90I+/CD66sogkM8BiDkjXPVwrF7atCS1BqzFs1mL8DC4P8Swlu/P7VJKUJUMpyWOP5/tiycykvkrFYvpX5H2hU+h4pOG2HLFhcEbRjO5zEz1iTvxUTMDGCg9rQbjzgLpMR/CzqtoIX6FHMdUtSVdMDWDk0BZsBx6KHCxjXAbEdjfF7D5rNhIKMnVLCziiB9RCFCdQnmrVtBXSn+ntBB9XpKgyxssvyGSI70ddGNk3d9SCm5Kp+Y0CzXzf74lAEdrVSMkacBGqh7jbRY5xK+lunybeg7lCLFywi6jkg4NA16a53s1Oc5p59FbNDaFKKf/ZoCFHe48y1ur0BzN2xVgrq0JpAQzM8mdGNHvK7B1zKeNV4Qs3MZoAauIfP5aEEWBOEcjNoqnrAXCW3uCaQ6DbPIJjav09QUeLk33iSGBXYmTxg6ySmb5P62whctQeoYG6VQCvRJxrAoc9LnHt4zQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(38100700002)(186003)(6916009)(66476007)(66556008)(83380400001)(66946007)(9686003)(4326008)(6506007)(6512007)(6666004)(508600001)(86362001)(4744005)(2906002)(52116002)(8676002)(8936002)(6486002)(5660300002)(120234004)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tTlw205542L5PqBW7kJxUA828MHbfv8twdixM+crz+1hNTJjV+8+rqbjCP5o?=
 =?us-ascii?Q?Xaqt2rxWUB9KyCrQQk5WISW0MxaTdLXmq0BZpMof/m/KFfKYHyqvE+qRMAZh?=
 =?us-ascii?Q?XvH4UXhWn0Scr1rFtf2pbOdj1jfpDyG70iSNwuIdY13E0B3OtUb8RTKYhYrx?=
 =?us-ascii?Q?wLLgTu1/1v1kY62d6u2DlbXXfEQ6I4nqHWeJrsCg3QTOmW5CJHxROsxpsoXi?=
 =?us-ascii?Q?Y/jM2dFz2fdKMMWYUjj5am/pbo//aHLF600T4xmBSRIhf4ZpU1v1+hUH1qLy?=
 =?us-ascii?Q?n4Pyh4I9/OZ8BYvAw0+MmDG7Ti5TPZFmYPer0Fp/DA3OU3G6Ri9k+C/lLY0g?=
 =?us-ascii?Q?ts67+Pzfhyz9RHFzeX6NAQzHyaALHkPDG7boszN01kWRJA6fLvXbXQRad8hE?=
 =?us-ascii?Q?w9meILsaxGrLiFhA4wp4zz5URv12KAxnbGFF2sxBJ0Cb2sdCSN5RLJ1o08uY?=
 =?us-ascii?Q?3Zxq9zdYg4DSLYPu/1cJb0xQhUZTiju7qT0u2nWuhIGuwSee06sYl5Qwf7hN?=
 =?us-ascii?Q?27X4YSnOoHStlzRqBDu2pvWBDwxMDjY5LPpVX32uwDkRNSIwujS6anM+XpEo?=
 =?us-ascii?Q?Unq0DoZZpF1SNCLWz9/gkmBDRA6L+Vy+9m25VnI5L3Rb0cctoAA+bNSN5bi1?=
 =?us-ascii?Q?5sL4o58DldkYLk9w2zt/8njOScEFrZFLYRQ2hwiRPeaUwU5YXGTSKVR94+Im?=
 =?us-ascii?Q?qmJH6rIhktVH52aKqSigYVZnRnOmFxhhDIHbXB1adBlg9mJeSkHcOdsYScjK?=
 =?us-ascii?Q?/Y4PI7oIZKDDDu/IjW5Cl4vZ5E/+DrODzx5syO1E+sGYKYM+ayR/lBebfW/U?=
 =?us-ascii?Q?jbFqx92YvZ9sfwb9tlCDrGldflY8eajA2nUTLf41PQ8eX7CTl6ph8vBBfqVJ?=
 =?us-ascii?Q?V/CI1oA0yFnBzxNY+iZMR87/bqcGtHIKZ8V3qDClk1i85xBpZxHCrwb6EEvo?=
 =?us-ascii?Q?EsvtZyXpU9zslhPS5t7QI28qpYJ/cvBXHZNrPjFySy8E4sgSFOwJ3dXbFhyC?=
 =?us-ascii?Q?zfM9xcMX/tAb7xnLLSFiX4jvvh/roRuecY9KI/bt98p1kmFQc1qJgS5vQtqo?=
 =?us-ascii?Q?umADpMvQb0CGj4/p/kS+ZmufCVfPRAMTwzFQ6mLcjCw/1Ffotn5I9pk1yjHD?=
 =?us-ascii?Q?A8+pXZ2mkub4VtBzUu02EM7V1AyJhgnjLJExw+13EBLfE3NP8czyhbtEvGQk?=
 =?us-ascii?Q?DE8ixshUhyWLIkWEIZADlBqkJHLvoSlG5CxRRmqivhM3mTE+vgIb2aFvhmlj?=
 =?us-ascii?Q?sjov0j7opfYdXr1kgNVYV/k1GX7urvxfhtDKZfUyk6urw75xprFyD2GKL8HQ?=
 =?us-ascii?Q?NPncQ2fEi6BKb3liD4JYC/QNEm94JbKZhWVKCglawjU9jg8zYOxq+dAGHtlb?=
 =?us-ascii?Q?5eoUtzT0VMJ8i8D3GEiyHeTmfcvsclDAias2bujxHyoYE60LF7GEMO/AQ2LV?=
 =?us-ascii?Q?ARNNc+5kMNKorteC1LPlgqT3trHx5rgXagdd1arlTXb4zqltMUSlNDmq1ZtT?=
 =?us-ascii?Q?1vM2Lidwd2XXdxO2S73h53cVtj9SPZIoOfPSGIg8S7YAm6Qxu33al0NxoLbu?=
 =?us-ascii?Q?6cZJhlmg6rYeI00PG7gos3LhqvsxDbcDMKw4Wy89?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9eb7ef-7928-4874-10c1-08d9e4de10bd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 17:21:06.5115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2BzvgWyU6dCEGIg9Js7AJDXCRpk5fJuiA0OWVfXa7S3ef/gEwpa0/mNYvlF+doSY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2322
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: FQSr2IStWmqVR25mT8hYO2Wk6Lns1AFi
X-Proofpoint-ORIG-GUID: FQSr2IStWmqVR25mT8hYO2Wk6Lns1AFi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_07,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 mlxlogscore=818 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310113
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 31, 2022 at 06:19:02PM +0100, Alexander Egorenkov wrote:
> Hi Roman,
> 
> 
> Roman Gushchin <guro@fb.com> writes:
> 
> > On Fri, Jan 14, 2022 at 07:13:53PM -0800, Roman Gushchin wrote:
> >> On Thu, Jan 13, 2022 at 04:20:44PM +0100, Alexander Egorenkov wrote:
> >> 
> >> Hi Alexander!
> >> 
> >> Can you, please, check if the following patch is fixing the problem for you?
> >> 
> >> Thanks a lot in advance!
> >
> > Friendly ping.
> >
> > Thanks!
> 
> I'm very sorry for late response,
> we just noticed your mails :(
> We installed your patch and today's CI run will use it for testing on
> s390 arch.
> I will have reports tomorrow.
> 
> Thanks for prompt response!

Perfect, thank you so much!
