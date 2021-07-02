Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048EB3BA48B
	for <lists+cgroups@lfdr.de>; Fri,  2 Jul 2021 22:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhGBUKe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Jul 2021 16:10:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13106 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230176AbhGBUKe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Jul 2021 16:10:34 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 162K1E03010968;
        Fri, 2 Jul 2021 20:07:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=b/pD1Och07MWekr/1nICfYdC3YRnv75biPh0Wx7DQM0=;
 b=S1t8f9bMYRp0Jm3k5JQUf5w2Mj9Q2Mxbf9t1zOR0nbQEi5JKmsJTFnJP/7TPjNDDVeAl
 vIhDNK1FP5shfgMMkXWoZ7KTeABSmdsZA3bxpjX3e0fw658ES8iuoB5l+nFEgxmYqe4t
 qOs0in/sS15e6yFWMNChmgfTHDfIgC+I+YToJg/8D34XOLEmvWMSOIavu0VVMNUkWHkb
 DYcNzjMYXilPWrTSH0WRlr4Q0OqLEj1WFDJ89m+uH6DKvfe0MpmOn8WweNqzTaDZJIeM
 Ih1rF15VGtqJfcnW/d6bjax6ZfXhp4PTMRXCfBOuIzh7u98DeaB98u2dtUkKYRovxcNR cA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39j3v58m0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 20:07:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 162K0DbE187399;
        Fri, 2 Jul 2021 20:07:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3020.oracle.com with ESMTP id 39ee13xakv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 20:07:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhzA1QgFWV56hkOFYA+t+6YXOHr3g1odOWGpvFYKn86SE0ThdvUR8An4SuDdU49OBcOYqaNmzWJQMl0OPf3Rilpfa7L3iy8qepCwpLtI8zd+VNW2aDmikPV38f2SqHOJNGaEORSmhG8bK63gjagyGewKLwnxPWyGMYJ6U2ra6yOSdItFveyNzqKbxu5z3hr2haYeBdMh56P/ukw7A8HQwGDRotIDQ459RAqBl8bzCX4T6/heGTVPbzuPMu3TV0x80Fnh/ob8v1Dg5vOD2xjP7FgxmTRT/sz2G9Pzl7WDT0x1vIkswZ4LbM4gijLRL66qNK/ny2Wupb3j85PTF5iHGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/pD1Och07MWekr/1nICfYdC3YRnv75biPh0Wx7DQM0=;
 b=ND4rxm/g4a+ZuDKtdna8nrtWFtpapDdc81tYAdhGQnmLH5xQwIsp85/ooDLgiOWB3Bvy3YQS+q2GpbOzOXYFPEiyHzklIrUCwZQp4W3IpYC17fEiE6bArvrrIq88x3gQ9nCci84Q7xmqvbU0OKOlEAAE1/WJqubMHpeYLg+ORSxZKelFHtsCIKgQRHnQ+lTWAD6ULURW/qIt1AJNBoDu0GeaqQmsUoQEwluXwiEKl0CNSb4IfBiHRqiwb5/17tp5ONs9h/8/0YoBZsY/B7WElS2+CUiDn/KRasj/R56wgtkZwW8CPf/2Lb0KkHvkU00g8sjsm9SvpaAeW32hZFs2kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/pD1Och07MWekr/1nICfYdC3YRnv75biPh0Wx7DQM0=;
 b=NIm5r+rhwnKVopcxKZXPToI33mLI7Dx2yuQtyHAli0NrofbhufQSDl+BsV63vhkhV2tCEfKzpe50nZ6MYHwQDwRqAQAwixwBjLWqBmgC0tmtdGQsIa1ivdiQm+jAnhpyvZYVeBCDOZ4IIIbv7+pmRl1BukJPUtMnHiLkUuI380I=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2966.namprd10.prod.outlook.com (2603:10b6:a03:8c::27)
 by BYAPR10MB3112.namprd10.prod.outlook.com (2603:10b6:a03:157::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Fri, 2 Jul
 2021 20:07:47 +0000
Received: from BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::9478:368e:93b4:6b48]) by BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::9478:368e:93b4:6b48%4]) with mapi id 15.20.4287.023; Fri, 2 Jul 2021
 20:07:47 +0000
Date:   Fri, 2 Jul 2021 16:07:42 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, tj@kernel.org
Subject: Re: [Question] Do we need remote charging for cpu and cpuacct subsys?
Message-ID: <20210702200742.wuhdg4dhpolher3t@oracle.com>
References: <60decdb6.1c69fb81.6130e.7642@mx.google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60decdb6.1c69fb81.6130e.7642@mx.google.com>
X-Originating-IP: [98.229.125.203]
X-ClientProxiedBy: MN2PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:208:fc::33) To BYAPR10MB2966.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from oracle.com (98.229.125.203) by MN2PR02CA0020.namprd02.prod.outlook.com (2603:10b6:208:fc::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21 via Frontend Transport; Fri, 2 Jul 2021 20:07:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d46bc7ed-c7b4-4c7e-8ddd-08d93d950f4e
X-MS-TrafficTypeDiagnostic: BYAPR10MB3112:
X-Microsoft-Antispam-PRVS: <BYAPR10MB311251E4D8E068FA017B9B10D91F9@BYAPR10MB3112.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bcBGFaMIFoGvkvnrEamTk4lA4nMspB8/iyfbWfPz5K8U4oU20AM55DDjbpqlhJdLDOzjcYZopikVuAtjSJ2NIzV5oZyUSms+lZUQZMUJEkD0v/+NW/Qh+DhlQ2Iy5wyzipJSVej+aY4DtXhkyLU76zNxrEUYOQA9oUqeZXWhozJEFtNNmM/2CpLE+Stk78e7iZSRiS0IWpeeN65ZAZ8AUbSYQPvzEzdeJZg6U9fRXjpm1Vvi+lClcI8AxYsdu9OYQ4Zw1Ivgoz6hN8l/rof3CFTyv7v7UH4lqOeZgKaKAQNcbsmhbRiPvPq4x8PSdbFORkfgPFIgrb4PF+7yHHXNhNEHggtTr5JzPuotNTk2AxjCMDktzxdYtVoAVKmWh0l0uJG72b+A8EdzG5iYBBHJ1djMSBjsik0qZ0PoA59sfjWgSYqAE/Tn+1oTA66D+sVUdhTXqK5WoOoRoMaoD3lnARPlUBgndBwRrlte/vQ4/XptGa2xlZGn91kBcjSJbv8ASWEX5fWJutHAtrKle2WlpIx9dleKel4CZblrumbJ2XzRBLW8jht3sRdHUKBgN+MAZ6TFdC0P69yPnencKbh2u23Tvmg0csBT6efmReuOwYOiMNifsSC7bF8hvTjNy9tRZX/R/ynsgUrODav4MB7D79yj4WtCPdXFbpTQh8nfoUjBwpmcd7A8MfmwxEYeM8PoRmxgyH9XrV6uBmGr2boqbdIBrRbU/dE/B9Qqw6FMKBTu3JEPSJQZZfq9FR5hEo33s/tsgzcm6w9jViwl8gLNE9+pYA6htSp9WSQVdqL7kUh9041MZIahb/BrTur1damVcB1RrB/DduevxCkQ47YFaiW9qV9E4M00Z2MJpG/ZqNI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2966.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(39860400002)(376002)(7696005)(8676002)(52116002)(316002)(2616005)(4326008)(6916009)(16526019)(8936002)(55016002)(66556008)(478600001)(186003)(956004)(26005)(966005)(86362001)(83380400001)(5660300002)(2906002)(6666004)(38350700002)(36756003)(8886007)(1076003)(66946007)(66476007)(38100700002)(87590200002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c6zA6LBTzYdVSbUKq7IlXf3QkgTuhFhCDVfl8Uh9Aj4TvfPAXyb9Ifu4dPjv?=
 =?us-ascii?Q?WIHuvkpruwHc1/jsmWQPleET03TQ4mSTb5f6jRmtgLn34Y7d8w9b+/Cyjsjc?=
 =?us-ascii?Q?96bbgpXRnpvdCrVn+ykuhSDZxhpnyw+amV9VaV3FN0XF9Snjptv2xNAQYZFy?=
 =?us-ascii?Q?y43cZAzx5ez7khVmutH7wjrFENvjywWRCRva93zoBj+LUqwxYyL0Ym50RczN?=
 =?us-ascii?Q?FKHofpZz5WOqVAxpV587duib3EYQPAw7OwoEOZPlyCdfEOx8mT4uBU3iyqZ4?=
 =?us-ascii?Q?joAsHW0jeguWdoOR/mMX3zFV9chxMcj42T4xW6v+Z2pE5VI6avGXtBzekrcN?=
 =?us-ascii?Q?kxLCkXClZegvQ846Xs7l11q4xnPnxrBc3dFxTYzG4Ckm7hs7ype8A5hK4acQ?=
 =?us-ascii?Q?CtfAa7lMErb+6S1va8eeVQRb5rbVtbrwiHIaZtl8mdODPcDblLDMpHRX12fF?=
 =?us-ascii?Q?dBkLI8EW17FFnRTrDAkJxxRFmOEIYrAmo+Rf5Q5ut2aE77BNNWr6IFxRffHw?=
 =?us-ascii?Q?bMZgx6M3auNEF3mv/h6PqqfOQMwhAc30rZy2v4DO+Q7eAW4oxfMybEV9T2eI?=
 =?us-ascii?Q?1PkuZF3iexaA33j6dU+bSeRP55rzHsAi2k0WBCKZjl1tjg48F68n07mOOjlw?=
 =?us-ascii?Q?di+662+E42W1++PTJWNXoTi/x8ViAMMWir0rl8SuX5SD1HSE73MsmiEHxWzv?=
 =?us-ascii?Q?hSUfCRcz1ARf6NmStG4wUMVH3nN5vpcvWIruM6oRyKFUBSl8LqPgK0NNkyrC?=
 =?us-ascii?Q?gJTw/jlhC4rNeAbv/vS4DU/LEE4Os8ZpuFduqin7B/aEh/B93cbk7M6KrATh?=
 =?us-ascii?Q?9mOTsLD/cJOQTSd9o5Pxypj453or94WHnaDucdOfQ8Qrne+IyIA9+6RdbHHp?=
 =?us-ascii?Q?f/Y4hwJfFgRRB08Hkau/Eq0L9bzkbk/fmNQMdN8650nLXoDTInalXPaqJfVJ?=
 =?us-ascii?Q?Veg4CoDrmIkQqwA+kbi9Qm2ZEHEe2NQrzvar8YZLcRNmQg0NWivOurrtCiPy?=
 =?us-ascii?Q?uYoJG86Ytqh3fGM4tpb5bWCKjEBT93UCjvUDlStUjLFA6pXj+NGlvtc1J6HV?=
 =?us-ascii?Q?gySgqBlLXbKywfMNvDEPKQaIf2YUSFkUVSN1neurRet7O4RJFxtLNxmXdhMh?=
 =?us-ascii?Q?40GNCQOOigYxhk/XuHzVigj3GCdQxhRW9jIboN/lzPznGd2zRyl3JM+uUbjr?=
 =?us-ascii?Q?JyljZauvQGo7y9GfNK7i131C6fvmg+G+jS7mQ8Ea0uJYKswd5Fvz+HoOO6sP?=
 =?us-ascii?Q?AuHIdZmvrZoIdXHaARwIefMC98fHXBqQfpNcAhUPG1J+NB8FXEjs4T0JOkeB?=
 =?us-ascii?Q?BN1XPTj4op/z++/5jFERgeoC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d46bc7ed-c7b4-4c7e-8ddd-08d93d950f4e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2966.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2021 20:07:47.1270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojQUEzWfpRHeIDXNMqitX/s8MFKuTokB67WYVlUWxJ/yX4ffvSJ5cELncrSwXqncBgR/9c/UYoyQiupgCQeRPH3BpGrZ4rqOpE9GiCFoMnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3112
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10033 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107020102
X-Proofpoint-ORIG-GUID: Ykki_50vufYbUmVeg6slFyuzb0H6NbDt
X-Proofpoint-GUID: Ykki_50vufYbUmVeg6slFyuzb0H6NbDt
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Jul 02, 2021 at 08:26:27AM -0000, Hao Lee wrote:
> memcg currently has a remote charging mechanism that can charge usage to other
> memcg instead of the one the task belongs to.
> 
> In our environment, we need to account the cpu usage consumed by some kworkers
> to a specific cgroup. Thus, we want to introduce a remote-charging mechanism to
> cpu and cpuacct subsys in our kernel.

I also want to see this upstream, and am actually working on it right
now, have been for some time.

So far, this is needed to properly account multithreaded padata jobs,
memory reclaim, and net rx.  Android folks have raised this issue in the
past too, though I'm not aware of the specific kthreads that are giving
them problems.

So naturally, I'm curious about your use case and how it may be
different from these others.  What kworkers would you like to account?

> I want to know if the community has a plan to do this?
> What will the community approach look like?

There has been discussion about this here,

   https://lore.kernel.org/lkml/20200219214112.4kt573kyzbvmbvn3@ca-dmjordan1.us.oracle.com/

more recently here,

   https://lore.kernel.org/lkml/YGxjwKbec68sCcqo@slm.duckdns.org/

and we may talk about it at LPC:

   https://www.linuxplumbersconf.org/event/11/page/104-accepted-microconferences#cont-perform

> I think we need to move the active_memcg to a separated active_cgroup struct,
> and the latter will contain active_memcg, active_tg, and active_cpuacct.

I'm not seeing how that could work for cases that don't know the cgroup
when the remote charging period begins.  The only one I'm aware of
that's like that is net rx, where the work to process packets has to
start before their ultimate destination, and therefore cgroup, is known.

thanks,
Daniel
