Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D06B3EF2DB
	for <lists+cgroups@lfdr.de>; Tue, 17 Aug 2021 21:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhHQTqD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Aug 2021 15:46:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51734 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229640AbhHQTqC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Aug 2021 15:46:02 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HJj8lW005481;
        Tue, 17 Aug 2021 12:45:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=u0SQVVB/trLb/pW3zgaBGvbhvPEFJ/S9wGtYDmX4jRA=;
 b=HV5DcxG7VxrnM1IWeIk02uhU9+HdjCA2KAEyZsdn22Zhi3LToIvrWP5VzlGxMUfCKXyE
 8v2m4NfSDrLnSZv+UkVOcP+QvLXvBX8XDg7NSg33wgI7Gw+M4NHmKFOXBQChdq0h3Rgc
 rpGX87zv6mmYbnNAMvdmV8fbgmq5pr6Kt7U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aga68btmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 17 Aug 2021 12:45:23 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 12:45:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKvdYmsBnPtfl4MFGP9qp5ML3yQFGmLte1iOC/Ql8xKUb0EvpEW0ouHIvGAUBVHizprqs8vUTniFL9Tb/TXcXuk4ZIoBkXEDQ18owbvGdffAsxhO1ZcUsn/XSpSGl+HmlURRegDVC1J8TtK32VFYTQ8J2ARkUPgmNkIxE3fyvjMOBFz9ArQ2binNDqYkedCRxvLNW3PHdbbUCTzeNMvmIP+EY7+3Ger06roloZcy1fo1UHRYe0qSSAOxnMdmBA42WjiU4l2v2qSGF7QTI+PxALTT+NOhtBd22jr3Gfu244bFFVImT5LkbDsn3zkM8j8wBiVdG0aE6ylkKpHMJkLqDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0SQVVB/trLb/pW3zgaBGvbhvPEFJ/S9wGtYDmX4jRA=;
 b=P1muBaxQRO5kBGkGvRionIfwyTU1MJCsrZjndshyVkeV6OU2+XjhE9666BgtH3m1AQKvQZIUkzMhfsloCmZlDSo5/fRRuvZJOz8WawOc43g0/cRBM+PD11pKNJbX3w6tEwLgVAjMoRTX0kC8TvIgwoLVZgG6A22MdGtslIW4MzfAAtdgrDlXEiN7QmBA8q6AK5FQktHfIxE9EIQsOeDtdiPYVnOrFyM+rudoxxJtKUCXE3Ywu6GjTVqqKAiIzJjRPdSdxanO5xLQvIe8o1YTThHhltMbjOlLKH/dLuIGRSoc6fqM/G1vctRlsgIvgEBZN8+loUqJ95B6WcR183P5dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2392.namprd15.prod.outlook.com (2603:10b6:a02:8d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 19:45:20 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::75be:c42b:c0d2:2565]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::75be:c42b:c0d2:2565%5]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 19:45:20 +0000
Date:   Tue, 17 Aug 2021 12:45:18 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Leon Yang <lnyng@fb.com>, Chris Down <chris@chrisdown.name>,
        Michal Hocko <mhocko@suse.com>, <linux-mm@kvack.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH] mm: memcontrol: fix occasional OOMs due to proportional
 memory.low reclaim
Message-ID: <YRwRzjOexeXbkirV@carbon.dhcp.thefacebook.com>
References: <20210817180506.220056-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210817180506.220056-1-hannes@cmpxchg.org>
X-ClientProxiedBy: BYAPR01CA0070.prod.exchangelabs.com (2603:10b6:a03:94::47)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:2462) by BYAPR01CA0070.prod.exchangelabs.com (2603:10b6:a03:94::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 17 Aug 2021 19:45:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd56c24e-e80f-4953-0544-08d961b78bda
X-MS-TrafficTypeDiagnostic: BYAPR15MB2392:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB239234499A99FD3C4E815601BEFE9@BYAPR15MB2392.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /89w8cCPaat7Zwk1XBcZVfbm6ShODLX3zu2iTmPkaZKqKRYqrPSR4HPEF3vcn6caehrBir+KU61b4BbZANAwN6e4w/oG0lGqLsPR1eVcx9NBhiOtGyCxnedrb9tyHZKqUKoDjKjuH3FxqbMCTcELs3RpQIChoNqSz7x4wknyU0+JkXgcJOptfjBzLnC5eEThN2qi1clP34x7yKgC0VN0ibQWthabSrRSGPR6I8zTUdMB5QwC144MlloOJBGhBFJcWbZGAFg5QK8kqK+oLIjlYmvpOwTIkg0LRYW47eOBgHj0odR6yAx8JPFOwYcHIRmoqYtEcMM1Kj3YbnFSd9LT3VTUXd4joLBh7Ir7q39zKgIOlfD9Nqs6A+OebG1X1YT4aCu5hrqNo2NCPtdVH0HWaR6H5YYM3FdrmdNxO1OmP708TyFTExeG646v1QpxYahYo1zMmjpZthVgmOPZ4xXPqb67DYArpYWzLr4YayM1cp92/a6QGgUb2DJLfdMH3B8dlKQw+mqFpdAqSfcZv44ivxncdczWtnV9uLaTtWWTFjCj48gHYqU5prz+5J57hmqiQ/i7XC6PeS89M52IKJmMETetVlBq0id3R1dwbPB2kHrouZfwF33XcExGz5papyls/4QUrWqlkiXPBgRf4THJlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(66476007)(66556008)(2906002)(6506007)(66946007)(86362001)(7696005)(52116002)(8936002)(186003)(6916009)(8676002)(5660300002)(54906003)(9686003)(316002)(4326008)(55016002)(38100700002)(478600001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u/jopvuXaQscAGsv0JgAl6xE81mQSExYsgakxBD+bzMocKkB/vHvokIcbTYV?=
 =?us-ascii?Q?TnmMEzwu94WAg4Ah5neYZZ4yFkLR+XxMImAVQ9UmnotPxlrl95DyaAJDYiCk?=
 =?us-ascii?Q?qaF4UyWgqKiKOqSCHmVN8I5aUZe+KFxHICQ9DD3vQfiHeItcPvYVLIn0petw?=
 =?us-ascii?Q?BbS1aEA93AHu8/vE0RycJlBRPk/dj9dW55BBNbD09pB1jttZDE49gWTWKgts?=
 =?us-ascii?Q?xugZrG2GaLzC8T5HpVVJd7Zka+4X6jREd7F8km1lIh/PKFU2NB8xGct0/gtW?=
 =?us-ascii?Q?ESin8A38ozZhFZN7EBg4eCu+8QVgFLGLAVUCwBEZWAprUsHs4oelZxS4Bx5S?=
 =?us-ascii?Q?+tXd7OSfLoPe/UfGc2HLGmGpC67p22WbikxkgzR1/RMVEV/yJF/D8yKNPUfy?=
 =?us-ascii?Q?o0nyMCQdSO7TD+nqHSym90kg6N/w11+PkV6Vs0aOOS5w0qwnIhAzEZ23mH7D?=
 =?us-ascii?Q?ujOypofrULThkHvQCtuwdAxsUhCq9MxHFZjvDgaUymugpfGdU4AFSar1bAuw?=
 =?us-ascii?Q?kEgD4xVshLA4ziX0Ilq3ZMHqWRNANfXMrFKfQAqxMBJz7pJXqxOA4ertAeEz?=
 =?us-ascii?Q?AKY3lO7nhClok3fa9SQxCz0gE3aXyOzdWN9rbfD9Jw3FvE38Pkna4RGn0mrz?=
 =?us-ascii?Q?yS0eN5uAjkNJrqWNMLGN4XrnY/bzSnLDCoF0F+buSNuY/b7+m5PEFvnCNELE?=
 =?us-ascii?Q?asG0dLfoNkAsqioSyffjU1nph3s+89rWBAt+W/j+BdjJQDo4XE7l5eQRxSvf?=
 =?us-ascii?Q?yYfHShWODADM5HE/od0gq7/b2FnhqY5UK2FoMzacLuammZ0vFZ+FRx2R29pj?=
 =?us-ascii?Q?F2btqg3DCmzjNqEZ/zoVytjwW59LNXSR3UbKO361xR1fBxvRN+yUxxxYjd54?=
 =?us-ascii?Q?SKArvIUR5FBO+IAWshpb0/ySnc/wfWuQEhS60cpDveaMydhctp7BAeuU/cxE?=
 =?us-ascii?Q?BXP7g6/ZEnz3X7w2z/4ahOUA139zefpzehoYXbSfBBaSfrCjAR5RTkDIDV7O?=
 =?us-ascii?Q?4LFa7ib9y7VP1QcqNT3VXvra+ooDLH3y4RokCTKJQQFeE1ABfDAbVgr/LmiE?=
 =?us-ascii?Q?FYOmoJLSkBae9ZzKBEsJu7NP7c+xnm4WbWg7fLWzin+G58gkYvmJeIF8sEwK?=
 =?us-ascii?Q?Ly9riyRG10tcYnsannGphhnTzTpRyIu9Tcne3worb3MFX5n4KgTPvUB/reL0?=
 =?us-ascii?Q?VYS505jLlsI0+fh/GkOR+vGHNQkatnsvj3aIbeok4vWaZFZWGDpdJl0Ecz9D?=
 =?us-ascii?Q?I3aN+qDXGfRcg70xj6tln+51wPz6Ap0Uzpbq4SdaRm5wwQUU6qwrdTwJyPOT?=
 =?us-ascii?Q?ACMfUzb5pVN905Qxr3Q8aPg3fkiOCXq550xZPrdb6SfDsg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd56c24e-e80f-4953-0544-08d961b78bda
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 19:45:20.4845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yB9yoB+IsqJvco792qXri3ZWCHfzWhSx3mDSAZQtFWTn5j2vbETQPqkg6Wf2jKiz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2392
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: z5uLjykdvd6iQOJhcPVVjntwh-FTPLKL
X-Proofpoint-ORIG-GUID: z5uLjykdvd6iQOJhcPVVjntwh-FTPLKL
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-17_06:2021-08-17,2021-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108170124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 17, 2021 at 02:05:06PM -0400, Johannes Weiner wrote:
> We've noticed occasional OOM killing when memory.low settings are in
> effect for cgroups. This is unexpected and undesirable as memory.low
> is supposed to express non-OOMing memory priorities between cgroups.
> 
> The reason for this is proportional memory.low reclaim. When cgroups
> are below their memory.low threshold, reclaim passes them over in the
> first round, and then retries if it couldn't find pages anywhere else.
> But when cgroups are slighly above their memory.low setting, page scan
> force is scaled down and diminished in proportion to the overage, to
> the point where it can cause reclaim to fail as well - only in that
> case we currently don't retry, and instead trigger OOM.
> 
> To fix this, hook proportional reclaim into the same retry logic we
> have in place for when cgroups are skipped entirely. This way if
> reclaim fails and some cgroups were scanned with dimished pressure,
> we'll try another full-force cycle before giving up and OOMing.
> 
> Reported-by: Leon Yang <lnyng@fb.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Roman Gushchin <guro@fb.com>

I guess it's a stable material, so maybe adding:
Fixes: 9783aa9917f8 ("mm, memcg: proportional memory.{low,min} reclaim")

?


Thanks!
