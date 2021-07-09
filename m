Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6101C3C26B4
	for <lists+cgroups@lfdr.de>; Fri,  9 Jul 2021 17:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhGIPU4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 9 Jul 2021 11:20:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48424 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232345AbhGIPUv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 9 Jul 2021 11:20:51 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 169FGpra032716;
        Fri, 9 Jul 2021 15:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=otqpN61pViFGHMc2ANP/EZDomhNwidHWFEwCBXECaPs=;
 b=xr4GBFVdfMDdwtnPhatONZaOOkeGeXJrDaWuKq7GUr2xD5EcN/fYjALRP/8JQiB/Csph
 cTABRGgBGZgI7OF9Z/pf7oT4Eg1aiBNnoF220mLQk6kEiWuGXvapLHmtzIaPN20HDU+x
 Zpmmzdcxp3UooFd+APJuVAbLpvjgWZQOdew6Emgy/UCaH93ySZk7FY2wq4w6oqyRwbTa
 r2IGupwBuaY+gs4hlDi/rOeiy4Hooa9ZlvDORFpIVatJhPIEGULBdrqkZhANLUaDwq9M
 KFC9iFGMj7kVjluRz0SiUQQWTZGPF5uVRah7shGuIU0U+KQn38AhegZJKRnW3xQQ4StC WA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39pkn48ngr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 15:18:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 169FGI9V114669;
        Fri, 9 Jul 2021 15:18:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by userp3030.oracle.com with ESMTP id 39jd1aajsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 15:18:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBSPmMX8Q/KXWMXyvEoqeBqw8WMoiGJfy6LZlHqaKmEh2JRaF9xyjdCJpAPFAoQK/0V1HcWRfdAu98iOZ1S7lE7VAub6GPZ++kROzVlmi0BOq5Ez2YwmEewmvvjXJQYFr98HX/3HoyQ/w3ceB4cRUc6wTQFg8MZZ+9NIOPX692xU1kh2fKcAX7UKn6/UhPp+FAkfn8WmDVWIXOdMT0Wy9HzGWQzq8UoAbz9jftHndNqoiR1v98dC/aycBV/E8zWJkHGaDtNh7v6iJ3P3ZnK1DCUcVXWHuV6Nb+5yaCHlihQETstgw4A7V3NQs5tnVxFbs0AdUdj/W67kFKA9SY1RXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otqpN61pViFGHMc2ANP/EZDomhNwidHWFEwCBXECaPs=;
 b=ixSY8qOlCXjQ+55RKK2cNJRCN5FKuxPOZtaj2SY8wOhtNRrM/9AcaanIh73DsOXYFt6dJ/G+SAPLLW1mwzOKzAvy83p8kABhPdLOFyNwCAdqK8r6RW1Pf6bZWmavzEKAgDDKtQyFDlhGdTrjT7D9GXXAXLbRE2+pYHxDI+66kokYlk6zlYcAJfzdFF7meEAfcuuhD4yN1AmCE7YkFByZgKV7Ce4IWEtfHtSB0qdvsZ33uKI3TopoTfqFsmu2RCFb/TM6S+REm4ZstfquuCGXYWPNWq5tomcx8TPt7mgIsu/9TqXZF5jmWOhEYIu4I7701kHG/zgZdwIM9m+rnknVdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otqpN61pViFGHMc2ANP/EZDomhNwidHWFEwCBXECaPs=;
 b=PSca18f2tFoIAyZNkbCnYiwuLN5mivGbMn2tyAjQXqvAmp+Rsyj7xGozCA5qHAi0z98in/hg+1mGZvYhTQ+oaCGx7PdiENRki2VXupnZs8v81ync84jNc3mIALraGsMOT/BBC/PQ93rRJ18XLrKrKl7RhrzZSE+zM+QMcSi5Ml4=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2966.namprd10.prod.outlook.com (2603:10b6:a03:8c::27)
 by SJ0PR10MB4525.namprd10.prod.outlook.com (2603:10b6:a03:2db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Fri, 9 Jul
 2021 15:18:01 +0000
Received: from BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::9478:368e:93b4:6b48]) by BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::9478:368e:93b4:6b48%4]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 15:18:01 +0000
Date:   Fri, 9 Jul 2021 11:17:56 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, tj@kernel.org
Subject: Re: [Question] Do we need remote charging for cpu and cpuacct subsys?
Message-ID: <20210709151756.u3su4vleiowd5tky@oracle.com>
References: <60decdb6.1c69fb81.6130e.7642@mx.google.com>
 <20210702200742.wuhdg4dhpolher3t@oracle.com>
 <CA+PpKPmN2E5zCjP3mkurNA2GANtLCUmoPG+_4mUq3E8cxOhuhQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+PpKPmN2E5zCjP3mkurNA2GANtLCUmoPG+_4mUq3E8cxOhuhQ@mail.gmail.com>
X-ClientProxiedBy: MN2PR20CA0054.namprd20.prod.outlook.com
 (2603:10b6:208:235::23) To BYAPR10MB2966.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from oracle.com (98.229.125.203) by MN2PR20CA0054.namprd20.prod.outlook.com (2603:10b6:208:235::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Fri, 9 Jul 2021 15:18:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dec62b34-90bc-4a7e-80f9-08d942ecbdaf
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4525:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB45256F790D138B2C1A4C4446D9189@SJ0PR10MB4525.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lrMXLkenWrQQxdKAsQ2msJqiMIPPTzl7F+VMfMJqjiSuEZnSbbuq0ksaTanaZUAwvXDzbtcY3sGWlmPYlHTy061iveBB6YE0XFwKQfpCMry3xRI5DzWk3cECI0heNOIcNTIyD1GB1SClc0AtGIzQnKVQGmwjqh/skScWi569nI9CEGXGN61me1IzoRaDDbZG7pxYO1Nn0cRmtdRzlg97X1TN9D8YB/9rQve5eOc8SVX+sXkdbx4QH4N0VRoGR69OsiQyEfZjxYzGP57c3QKM2ONsx74cDdt0H/zbFdIAJ1hbT4izjA6xZ+3mGKeBPYGXWvgVefa5H4meBct+vwSml3jsvkK9Zv1j2UnPWVpwq2UAUj4hqsk5gklF/5pFm5JMOkBMbTZ8lyvx5U57tx0yOFN0ApVOWO3X47qHmm22u2KFFCQY4DmKy4/ix2dbA7eLvuJqCLvO31k65sdhFbYLtSlBqsjSNlSJEgFBNA90uwB5+OKqrODRNtihO3kmYSypoBv6j7XjOikXpED+JLEE107/1Q+U9y/nnTntvcSgq+6F8ncCtb5YBNq1akzOt3MnvPQjWa6TJ5E6RDNRoO781Bfty4zTpJXSuRXDOejuVbnr/8yBlkn6+LME9cJWlwkFoJohcRmD2vOQdC11sUdAdwLXZJvpzDij9keg3bGUIUdHr85E5OiLfYnbA/B1BEQN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2966.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(396003)(136003)(376002)(366004)(478600001)(55016002)(8676002)(4326008)(66556008)(8886007)(2616005)(26005)(5660300002)(66946007)(38100700002)(52116002)(8936002)(1076003)(38350700002)(6916009)(6666004)(66476007)(316002)(7696005)(83380400001)(186003)(53546011)(2906002)(86362001)(36756003)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4tAumTEjNyUaeXfmHdj87rrlsMQQHtdZT95tDnKoIwpR7xrOCaoFqg2SiWZj?=
 =?us-ascii?Q?pk+XCRj9bmDA29jVqqstqF0JXkgnjVrq+Rsciumw6nL2OAgjPq2A1AgUdtod?=
 =?us-ascii?Q?J3YP3G0WFZHCxGEaPcXP1l9vd4znbk/vUKOYjhXR6MNHLcYioIGL8VAIWQpj?=
 =?us-ascii?Q?b8c78zaVLzX+qanaTedjcVBj8BGXLCF0NVSx/sIfCQBgTaiqjBGSlun6HaS4?=
 =?us-ascii?Q?JnywBOga2E9WIRjJW+8uVjqrHXMxzfJ8PMWmFGqyOPNk4TX1Ne1o7a118Z5E?=
 =?us-ascii?Q?m0N62qzJ1ayLGFWhIfINus8QyvqLUUCRW3JMF/0mCWhsw/YnXe+ovj3VMpQh?=
 =?us-ascii?Q?5fq5sQrlgmje64wI7lba1FUA90ABXgUnLA9fXDIaK6ATKuifI2RG5c8jctrt?=
 =?us-ascii?Q?8jK1zyh9Cs66hYheUG1nwnlr3widT8nJWDX/7+urB5XKu3KBjl5wqAhgfuPC?=
 =?us-ascii?Q?oHU6xFKnPig4X1pccVYSME/HyB//hLco+P5nPf5HvDfpLxejiJTDgVO2XELp?=
 =?us-ascii?Q?AMTXO0OLhL9P24CDd66LOaxzhZqQjIvsEM40z30YMGfOkyd5plHz7p4VVFE4?=
 =?us-ascii?Q?Lj5rZMOM6i6pV/Z45qaz+KL7XKkkY+Pt5V6Z/LqiL5s0oOYjhyuBOcxFBEip?=
 =?us-ascii?Q?dNK99iAoBjUU9z1M+zddAqL07A/mtS4SXAUfW0kQgl6TP7co88vGoSQdR0QE?=
 =?us-ascii?Q?Jxn2771S6PXFAvevkx5tQ34YcwU5T+VhFIXI1ixD6Q4dSByFLzYlpMPgXpF+?=
 =?us-ascii?Q?HG3sYAnNUBzXC2QR5Eg7F6u7HJ1w+HPlN1EFPobyo3XYgcZEjrEZoUvsK7v0?=
 =?us-ascii?Q?1/cJ0QuYn09OUa4I9sa+DTPLyqPk6gF5RIvxxYhdDOxOTRjTFFrdGownNGCA?=
 =?us-ascii?Q?pPkYbYcq/Tkow+nyqo3fAHY82SeHVoZTv3n+BEcoSBPhBS+pS2xI/onan23R?=
 =?us-ascii?Q?himVws+/MUacFy4VepUcPleBmGRG5YkRnVqWWTSUOCuCdJLok+K75at1zDNg?=
 =?us-ascii?Q?h9Ur1wkQdm0UOC26fViSlKmao9WImPocWr03otzNmxw/Z5NCVoq9QoHWwoFW?=
 =?us-ascii?Q?ztzsyWZFeSMHJTi7Su5Yo3Vfk5eHeVQvObeUM/y6VJXl0cY1fSKdL2Dl4zVP?=
 =?us-ascii?Q?hIvA7NDJSrXvXnyrMQ70qT8qaTHOofp/WETMkTva8COet5UalqzPmW/ws3Zx?=
 =?us-ascii?Q?iCOCR1T4LlbXvqx7UAzX1gMRTDXgS7lTdAoipMtmX6PT2qD/bskxYOvoEK8Z?=
 =?us-ascii?Q?kBgbBmfsIIBp6OBjriopyZ8bca083mFvhYhRMspbU7lFPJWGUxNOYzKEzZDs?=
 =?us-ascii?Q?Et8c99WC6UdT1K3H9NQ3GwiO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dec62b34-90bc-4a7e-80f9-08d942ecbdaf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2966.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2021 15:18:01.3089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAtNoZeOQsaFLC4UabsS5SC0HWW7vBdDCuflt+7NZW1nKqp85hVleGmJVT7SSFru/8FZdJRyS+8z+WeXfK+/2q1Gz6yTtLGGV3ZKY6l3Ztg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4525
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10039 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107090077
X-Proofpoint-GUID: wGsLkvzWOdzqyuv4Qm74kekh7t016pve
X-Proofpoint-ORIG-GUID: wGsLkvzWOdzqyuv4Qm74kekh7t016pve
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

[only replying now b/c I was out most of this week]

On Sun, Jul 04, 2021 at 12:18:22AM +0800, Hao Lee wrote:
> On Sat, Jul 3, 2021 at 4:07 AM Daniel Jordan <daniel.m.jordan@oracle.com> wrote:
> > So naturally, I'm curious about your use case and how it may be
> > different from these others. What kworkers would you like to account?
> 
> Thanks. We use a workqueue to perform asynchronous reclaim for cgroups.
> The kworker may consume lots of CPU cycles if the cgroup memory pressure
> is extremely high, so we want to charge the cpu usage to the related
> cgroup for which the kworker works. Otherwise, the reclaim kworker will
> steal cpu time from the system level, which breaks the resource isolation.

Ok, that helps.

> I also have a question here. Are the back-charging and remote charging
> the same thing?

Basically yes.

> > The only one I'm aware of
> > that's like that is net rx, where the work to process packets has to
> > start before their ultimate destination, and therefore cgroup, is known.
> 
> Sorry. Is this a typo?  It seems the word "known" should be "unknown"...

What I'm saying is, the work to process packets starts when the cgroup
is unknown.
