Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A1D3BA4A1
	for <lists+cgroups@lfdr.de>; Fri,  2 Jul 2021 22:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhGBUWK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Jul 2021 16:22:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36668 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229996AbhGBUWJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Jul 2021 16:22:09 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 162KC6Hw002499;
        Fri, 2 Jul 2021 20:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=TRgInt7NXvWcv4AjlAp0yqi8aGSlE0iQsPoM2X812HU=;
 b=G5xs11ZLllfc9YgvNGcSAvRou4DWErLSO5pKcr8ElOpwptkOgDkwjSxLc6dHyWQlBdr/
 UNfDwJuTA9WbkeGh9vJMJH+KzIjuI1hw0zbKD2OZBZ7k/++mHXRNhggESH7c7e9H4UIu
 7l50reOioiCwtuRztEMP4EP49/5mOeaj7WRX4ytgW+92B3l7bnLnTUlooc8KkmgcdH24
 6fR25eQu9vsHQNwFvZangBL+v3vsc6h0vxsJIF3iKIfBfkSC80NWL5gd9tLDZrQtc5mc
 QcMcdIU4DY+cy5rlttRQGtBbASwPtf36D+4mpz2y/Z4w3R8Wp75Z8X+hOlnCus8/yOcB 0A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39j3uj8mus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 20:19:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 162K9rtN101539;
        Fri, 2 Jul 2021 20:19:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by userp3030.oracle.com with ESMTP id 39dsc72qpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 20:19:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9NUTgmY0/1eaM5M/ft+LQOb4W2yazmUoGBWCxjyLwYXousOA4+xipkS0Hf+bYsx/wrIBAOQqWIF79FVwO/7eENSLPFEUKakdUJUFU5ldLlxHPyuicSuCvJUazdBWMj4N867nnZGQkhw0FbXkszlxngDLgJixt/iNNlNTQuilfj1k3M2RefowuAdLZHqSdImoUUQo0+3RLOOzkGyr6Pplk5LuHLVrGKfs+7SPbD6sHRYqze4RV9odgZq4RICR5nhTz01SvtgIBSvRIAtJyJUmKCDtqNS9VdDUkMBom7KNtx+P1Ea3i+7P94vDdibUNmVIlP5fMgQVpMLLfa+3Ivb4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRgInt7NXvWcv4AjlAp0yqi8aGSlE0iQsPoM2X812HU=;
 b=KusH+Ecb4pKehNTT2Ieu+xkLxzsxyoeD2x0uJ/P5XUvJ8H9mdSCtJRyfNleR+9nNnJoGbc3/vpz1fgaYvXPOWSbaHnAWcvV5o/AnPlNtvUs56Kb/RZEeSBiCEwAxJKJuD7zVpYR1AHrNPrt4paPHrarGAJYsRUhT0y+ywVuzvlG1xCllBU5Q+RlZXf2ZHd9bsglIga1RfHfwCBGupZpIJ0bMZ0pXXZ0EGWcgY0jZvyc5a//6rAzKx4jWjRPCf/HzNd7hWPwrlzaV19St90tlolyfXQ7aPK1HfLl4lHJU5CN0U6fL996ATX0AEbRE7WPkBJOvgPLquNZQIke1zuqXAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRgInt7NXvWcv4AjlAp0yqi8aGSlE0iQsPoM2X812HU=;
 b=s3vyYnG2meo9LEsypgjwVAH5Bkjdd7F7znXZvfgWk+Xqx/lMwwuX+NRrLmf7gqoMvVMH4leSvjtz2lK30N2ozX6XSBLKVQqITaa61Y9ZhFxrswkH8lTJGOePpZKYHdmbkHwjEQ5HWXLvDq+yfT1SjoJwQBazPk205h04ztN8a6A=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2966.namprd10.prod.outlook.com (2603:10b6:a03:8c::27)
 by BYAPR10MB2871.namprd10.prod.outlook.com (2603:10b6:a03:83::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Fri, 2 Jul
 2021 20:19:25 +0000
Received: from BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::9478:368e:93b4:6b48]) by BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::9478:368e:93b4:6b48%4]) with mapi id 15.20.4287.023; Fri, 2 Jul 2021
 20:19:24 +0000
Date:   Fri, 2 Jul 2021 16:19:20 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Hao Lee <haolee.swjtu@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Wei Wang <wvw@google.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, tj@kernel.org
Subject: Re: [Question] Do we need remote charging for cpu and cpuacct subsys?
Message-ID: <20210702201920.i4pacu2x76e6crbf@oracle.com>
References: <60decdb6.1c69fb81.6130e.7642@mx.google.com>
 <20210702200742.wuhdg4dhpolher3t@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702200742.wuhdg4dhpolher3t@oracle.com>
X-Originating-IP: [98.229.125.203]
X-ClientProxiedBy: BL1PR13CA0182.namprd13.prod.outlook.com
 (2603:10b6:208:2be::7) To BYAPR10MB2966.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from oracle.com (98.229.125.203) by BL1PR13CA0182.namprd13.prod.outlook.com (2603:10b6:208:2be::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.8 via Frontend Transport; Fri, 2 Jul 2021 20:19:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6987c11-9f10-48fe-635f-08d93d96af15
X-MS-TrafficTypeDiagnostic: BYAPR10MB2871:
X-Microsoft-Antispam-PRVS: <BYAPR10MB28711B903E0AEF151E4BE044D91F9@BYAPR10MB2871.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wf+Gw/Cbx4CBYWM5aFXvq89mVdGURoHYvEq3WNetvTYyE049ghyUxyoPowRmNcmHb5AWVQ4qASP4KPuKYS+g40zUesM+/WFYVl9cOUUKrR/r5JICyB37aH0LqozjYi4bGkg6c1QHq+C/EK+4l5OFdQ9+KOmFNBJ9/uCB4drkXhWMy9qAMusOuhMHROJ8ASAb3AjP+0lC0e055R05y8YaVXvSTnSMVg4FPM9d+Xjk+9NXUDn7dat2gffMpPkjAyDoKI+keu4W9vmZrT1g9yCVdVkROM0eFFqyLbgpEkZnfQ3qaZ81ayRxVoWzGLGgzcY+Ut8Oz7LvVsKFl8MgGzXvylY6LbbvptO5FVtutx45hUiSwcCyJ55AvfrzeSXJljmO0IfW/xUnFY9f46det1f4X0/sndqJ+Mv+W1UF6XNvH7pJkHopUwCYn9XsVF1VoSe2WFdsFF43KfeBfEay20dIWXP8xibN+OhpXR/MGIczq9mT5xFn/ReRqAePfJdMHfcvmevzAdarb44/mCubOUGwI6sMmMLTihTbyoPhrWefJ4cKW8ugjxt3TacJlS9S3MBIdpj7ETPyQzH6vLNyE9vmO4/BWljuWcW1AB/EIv/aUTZd2DmOxEso9XZhXT7nYYDT8jKabTMh8oi0AsdGX+WlrSlmIxOtSS/qIyPid0YUe0X3UOSt5mq6WoH0FXwafAUQgFBpy9PCbtnQelalz2Vkujiq0mbTnTTcMfBP9nvQ2wuaKiFypm2e2Mj9z7dxGTDFGBG4cxRoUtV1x/XlXPASNPwc4+qKA6MtaWjdzjm3u/kd30C3vRHYF+c8O+2d743p4q+tUsBpoXoa4SmybFN+aRdhDVywDCzZWY0gzy4kHyo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2966.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(39860400002)(366004)(396003)(346002)(83380400001)(55016002)(956004)(2616005)(316002)(8886007)(966005)(36756003)(7696005)(38100700002)(26005)(38350700002)(186003)(16526019)(8936002)(5660300002)(110136005)(8676002)(86362001)(2906002)(4326008)(66946007)(52116002)(478600001)(66476007)(66556008)(1076003)(87590200002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1vtQKk8i5ium2OVunppVSP7OsO0vYcxA487kbRuuUMn8G70/0mEql5xa2CZT?=
 =?us-ascii?Q?iBo7ixxfT1rMik5iCgepnarH9ebaDxzF6EQlgrpDY3bDuY34N9QWb/sVyQsn?=
 =?us-ascii?Q?F32ZZRd3fFpt0aKa4BXRefgW46ElGhe+bVcGd2B38ORta4HwWXHdELXk/jSx?=
 =?us-ascii?Q?Q6FGKn07RJ8674DoYj5yWdizIOp4v/siT0Zvbl/hxHTruBDwaSeF5l7R7oqt?=
 =?us-ascii?Q?KHFa3SNHMxc97RXmAfDp8vp8JjhJpMP9mtXOlETaIr9IX11iMHph97uvRkC/?=
 =?us-ascii?Q?ktdT20A6jCWHDOlWzb0QMEa+7LC1JESKcUI8v2bT3ohfkNnilfYTwND8Sjqd?=
 =?us-ascii?Q?e9lXsG7qL4pGde63EhWHLvprSMcqggL06i9/WUp6mcLWubyLJsJ+3ydJpNmt?=
 =?us-ascii?Q?VQILSQrHvMoPnxmt8shxnfKWpLMGuJp6ZIxbJFdl9C3PeMjcLzP1G76yg20+?=
 =?us-ascii?Q?b3uFtkJKrfGyv/WqHb6vc2IC+BN9HlaQHuGGl83pGV50Dqq670JqQRctbF03?=
 =?us-ascii?Q?/VZiqMxi63jGeB37fFCI5ViwP7SAiFX/8+d7iSCwHS+8qC6tLsPdk+2IhdZZ?=
 =?us-ascii?Q?GF+yirwWzQ4XwUtvOtbYnKJ4Z3QUeIEglQMNS6uqZpxoGqKcOqN7uywNm/hF?=
 =?us-ascii?Q?LvvT7n7nz+XuUkLhEra/1h2y3H+KnR5GzfmP3u1Dje+f/IpXnhK6SCNAGvrj?=
 =?us-ascii?Q?HmnLS0DEy+tk2XAa6ByaJytj/k2yG4f5sBdg7EzUqYo7cScyZQFJrjcJcmjL?=
 =?us-ascii?Q?7+81utX28H5m17yCVyXcLjqqX1WIMlvQ1QdBIColM4ImXSCtKaTYlzmU8K2A?=
 =?us-ascii?Q?Ls6PJI5//5h2K5RmWvbXX1gzpqHGgXCL1AQfornm6SIdhD5v/W++A4fCAKdI?=
 =?us-ascii?Q?VmFkNSyOl22TNu5eG3r1zKyrh8y+H+EWqmEcljYnSnkO9NwAjrX0mHFk1+nt?=
 =?us-ascii?Q?/pmLt9SV3MnsTzTrNd5PVpF9QCiS/QnkzPZf/bpP78s6n38mmzYL1pWbSN/U?=
 =?us-ascii?Q?tmBU2brYgzZ0jNE1lk+EC6QF30xYDSKaVhMKvWHt1LWf7WLZo4Yre/kHwWFd?=
 =?us-ascii?Q?StrQYoTouNdmEIEXN17FTUJgiRTGsbtT7iLNChCdlezSq9BAX+KYQq4boiRD?=
 =?us-ascii?Q?d/TIVZbZSh9sKBCEIiPPPey1175X5XAvlbBxce3OIoOayZBlgtS01n9S7+4L?=
 =?us-ascii?Q?FzD+M31Yd3o1AKOAKphDl+aDdZfHkfa6bS8iw40oUa2rhJ+waqQkEDkJrUFl?=
 =?us-ascii?Q?Xc0s3+adl645+/WK0fxxe7anuJY0Plrx95k4FWEOcduj2dw0mEsekHIep6SZ?=
 =?us-ascii?Q?31w+3MFw9JyI8/zmTDhU+sG5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6987c11-9f10-48fe-635f-08d93d96af15
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2966.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2021 20:19:24.3118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WaYGWsQJzbf5rqWvjYjCMSJC/1O5CHY57JWce9e6lFrB6Bg9VBZ5evRm+p1eJzxt6N4+Sf7nECFgh+qpIiQOicAieiU49nE21mCa9sdyqYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2871
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10033 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107020103
X-Proofpoint-GUID: c5WRDNbHL2O9NULJLB5fJmCqgQNY-N_H
X-Proofpoint-ORIG-GUID: c5WRDNbHL2O9NULJLB5fJmCqgQNY-N_H
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

+ Android folks

On Fri, Jul 02, 2021 at 04:07:42PM -0400, Daniel Jordan wrote:
> Hello,
> 
> On Fri, Jul 02, 2021 at 08:26:27AM -0000, Hao Lee wrote:
> > memcg currently has a remote charging mechanism that can charge usage to other
> > memcg instead of the one the task belongs to.
> > 
> > In our environment, we need to account the cpu usage consumed by some kworkers
> > to a specific cgroup. Thus, we want to introduce a remote-charging mechanism to
> > cpu and cpuacct subsys in our kernel.
> 
> I also want to see this upstream, and am actually working on it right
> now, have been for some time.
> 
> So far, this is needed to properly account multithreaded padata jobs,
> memory reclaim, and net rx.  Android folks have raised this issue in the
> past too, though I'm not aware of the specific kthreads that are giving
> them problems.

Pavan, Wei, do you have any details about this?

> So naturally, I'm curious about your use case and how it may be
> different from these others.  What kworkers would you like to account?
> 
> > I want to know if the community has a plan to do this?
> > What will the community approach look like?
> 
> There has been discussion about this here,
> 
>    https://lore.kernel.org/lkml/20200219214112.4kt573kyzbvmbvn3@ca-dmjordan1.us.oracle.com/
> 
> more recently here,
> 
>    https://lore.kernel.org/lkml/YGxjwKbec68sCcqo@slm.duckdns.org/
> 
> and we may talk about it at LPC:
> 
>    https://www.linuxplumbersconf.org/event/11/page/104-accepted-microconferences#cont-perform
> 
> > I think we need to move the active_memcg to a separated active_cgroup struct,
> > and the latter will contain active_memcg, active_tg, and active_cpuacct.
> 
> I'm not seeing how that could work for cases that don't know the cgroup
> when the remote charging period begins.  The only one I'm aware of
> that's like that is net rx, where the work to process packets has to
> start before their ultimate destination, and therefore cgroup, is known.
> 
> thanks,
> Daniel
