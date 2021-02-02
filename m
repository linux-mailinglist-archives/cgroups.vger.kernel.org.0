Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4064830CFAC
	for <lists+cgroups@lfdr.de>; Wed,  3 Feb 2021 00:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbhBBXIy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Feb 2021 18:08:54 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55254 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236266AbhBBXIw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 Feb 2021 18:08:52 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 112N2gU1015608;
        Tue, 2 Feb 2021 15:08:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=TrlPo0eFafeFIQd4fPweXXFigvYNrR/l1TowLCAzMco=;
 b=DCJffGsgDmJguBrses2VkFJP1x3+0ff7pDl3GvpLHXHRh4ESGWIFWoezd3RTJKU+gCrJ
 VQyA4aBF4jaXZo3gZWr7EQ4/tCZLtyLFcpLtPXmGu0bj8s2HQ9StpqqTq5EOy60s2Myr
 TN69Br7pimgxM9K30SLxqmAX3CxpjbwwP/4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36drdbx9xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Feb 2021 15:08:00 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 2 Feb 2021 15:07:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MS56heoHwRyVPrbKr/iUaCKv0iHZ5Mc+ZXj3OkHL97V/9a41Zy5LOgfNUiiPA2vIb3oDaZyIumMJwMTekMnUNzjASfFHSHU+mXa2/I1HJCdReptPrg4qx9OzHAhZh7mMgfgqjhDajjjU2DPo3ee97Jp5Xyj1+gav1xEaphLl3gbzjwf3kjpC5v72RnBeKINUoiKTTSUwhEB+xFQ+CrJpsQ4IJskTsSRmlv10HRAJeVVA9sIi8gHc10ov5Usx8BPSe8ib9UI15d2YUE8eVOBknFRQ8BQytNy0PjucreAmH+jj15A0syGvKN+ss2EFbn5dQC4WNpvyNS62ExeR84G9Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrlPo0eFafeFIQd4fPweXXFigvYNrR/l1TowLCAzMco=;
 b=P/KGT+oEuk3J2xvOhmcSUahR0mjirbNnAMvMzxZlmYvnXE1fPXqYnrWVOcFhwbJgRBM/Jox6yL3Pit5NKDJ0VvroemaDHKggrsVTrFRuDk+M/Jq4OvN2ixqJ9OOcixqlwA+y2JaY0UZCz1PllWt52obmziySqvmRzBBZJrgtM1un3VzrLlZxDYrAUjiuxdvPc03QcibALi6vZy4mtTVejuBMz0gPW2v9vqkOtbty7l5VBzK+WNsCnNT6GwDSDvp+dLeXosQR5vmssUncV8VmVjIqkqkAFiSrBIrA/tFg8iX/dGqO6Hx+JU5lQsDCiUZ8j2NBUlPjJtkuHJclYOMdHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrlPo0eFafeFIQd4fPweXXFigvYNrR/l1TowLCAzMco=;
 b=kfvVAkpqqWcXbgwcr5uWlOcq1BZbqKTfKLuqWcZv0irSCmXiqqXDpkDOpNVtAhpiCnb40eBAGW00lS6nE/HtXGrrU6G24mE5Eclh8PAiCiCfe/qgh46z1psOWFJXvlcduPXzoZDahtmnb8YHttHVt44upFUxRyMtcz3/DNkuDK0=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2216.namprd15.prod.outlook.com (2603:10b6:a02:8b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Tue, 2 Feb
 2021 23:07:52 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3805.028; Tue, 2 Feb 2021
 23:07:52 +0000
Date:   Tue, 2 Feb 2021 15:07:47 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        <linux-mm@kvack.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH 1/7] mm: memcontrol: fix cpuhotplug statistics flushing
Message-ID: <20210202230747.GA1812008@carbon.dhcp.thefacebook.com>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
 <20210202184746.119084-2-hannes@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202184746.119084-2-hannes@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:7ae2]
X-ClientProxiedBy: CO1PR15CA0108.namprd15.prod.outlook.com
 (2603:10b6:101:21::28) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:7ae2) by CO1PR15CA0108.namprd15.prod.outlook.com (2603:10b6:101:21::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Tue, 2 Feb 2021 23:07:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13ca1b00-c001-403e-18d3-08d8c7cf5ddc
X-MS-TrafficTypeDiagnostic: BYAPR15MB2216:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2216B802C17B76CD154CC66EBEB59@BYAPR15MB2216.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SkF+4qgJTd4TyMPotYHDo3RT2tVmSLQykIccmo+wk69nj/+eFpXsFWN5i0GizLQbGE1jfocP9WjwrqKNHQTEzNQQQRUR+SiHufIg9SJk+bXWmHAiOv7u9ElhipqSC+Fv4hUGEgLfqcrsIM/fwjw9yoxtqStTspS3Pux6BOH/qwz38C7MZO4OP9jVT70AD6+UKk8ZUWzy2sOA5g2/Nx5Ort6zIrjh8U7GiB4h3JcSUIQ1aTUWrbHtUIj6rCEra2xMm8WGq9UDR+l+SaRZ7ud2+Pij/VPbpm+QWbhDSo8gr+cy3AL8V+TAno5piVvzHQMV4Gtq63h1agYj1Qf6B8wS0AmNOVbXC0n3hgdhU75DGbW934pbRxtSAkWLqAImJiyWyuWgO81t/GBReSAaRSumU8DVsZB9ERGK7zzF+NlAkDWpePlfzwmsiUfapKo+Jw8qvrpE5Olk569bohxEkYkulj+g72M/Hg8mQPUMq509Qg+FeWoUYpEcAt1OmmxiFidwrDGrV7WfHD74sr/7ygXtsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(376002)(366004)(39860400002)(7696005)(6506007)(52116002)(5660300002)(66556008)(66476007)(4744005)(478600001)(16526019)(33656002)(1076003)(316002)(66946007)(8936002)(4326008)(9686003)(6666004)(8676002)(186003)(86362001)(55016002)(6916009)(54906003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xgufFMk7g4pf3IoVYYduq+dXX0MmWYT+PaVhbM3rGjSJZkG6Ubru/4es0pJm?=
 =?us-ascii?Q?q1jRLN2dMHu9UMSZBMk+3LfS+f1ZhCy6FStSX3DNqiQkNBrPXGEBruq7B41V?=
 =?us-ascii?Q?BYgM5DBdRBEP/V0dlvoFZn+S5/R2WiJkHNhHpoRsoMrmkW9V2+/Y0Zb5lsfc?=
 =?us-ascii?Q?EnBh9gJk3GmHUhEc3AlkBQYhu1nEkHB9+hNEJ24c+Yy1sDc1A8ryJWuEZiD6?=
 =?us-ascii?Q?K5B0Ol49p0u55BOuJpnBADrdsyWcMN7LL+r81/QHu7oB2hYqdQEGDYkOCBhW?=
 =?us-ascii?Q?aWy99K1eO+XdjYNTPoBci3+a7LYg63p6quxnFcxzxUzBm/kTCdqlvgPnTCBj?=
 =?us-ascii?Q?HjbLEj4seuGMJpa7g4X7kJ8OcnoCEj7Rm0mC4fzrx3oBGWcJAdhfbE0ajvwz?=
 =?us-ascii?Q?2/jaQIh1pOHP6wJR9RtpIchNXqJzOKOGzM3gWblSUqZfdJwvRYVDAnWaVW2P?=
 =?us-ascii?Q?N+qFBQ7CKEbxZ6u843Tj/1NR5/WgWO7UzDl8xkistiI74koKuCQcOa4e19be?=
 =?us-ascii?Q?Mfhp8+tXmG06xEEP0zkKsg5hQuvLs/+Y9iH7aDM8RFdlAb0DrB5Bp1/rF0L6?=
 =?us-ascii?Q?Hmh1hxQMkFy/4bdwsgKiPL/DQ6zH+KD03mqqdzbOiPxQzwLmVlJ4UD8yT0f5?=
 =?us-ascii?Q?QSxqBzA3HSys4YBWRALu7TTrn+P5urznRU5e588mgcppBEAGEfjm81rgbz9h?=
 =?us-ascii?Q?bNK9UBGoQqEgDXjYS1gkBeQaPvxpfRKzCJsGPxFsKBSUuHCcyw3kyJY0R70L?=
 =?us-ascii?Q?d/AAfznaBHrsb9of6md2k4gpL8actPI4q4Z4QzFCqPUUzx8SV51hFgqVpFs6?=
 =?us-ascii?Q?AezWeqExe91sy6QtPY6uNIPWpZ7aKqVJoZSBn3Bg4M+yckfR0wj0dcM7ekSQ?=
 =?us-ascii?Q?4BL9+kdem8vs8ggvl4X2twGl84oG7NOptbIyK+GeyTS8P2hhBJCzbEq2TtzE?=
 =?us-ascii?Q?xf8BnVlcMpL1eu25ZDgBTz0fG5fHjJF0WcVa5/a+nLkh1BHH8ZbWBJM6iHSd?=
 =?us-ascii?Q?wCrtunxZu7nt7jFYwDXb3V6TAvmsp49VSRWk72ZC0IsEoaNrHioYgt0lC47w?=
 =?us-ascii?Q?IyVYCNoC6NuWPKJDiSu7Cy0buHPiNMhE3SRAsIGMBfY6uZwUW8c=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ca1b00-c001-403e-18d3-08d8c7cf5ddc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 23:07:52.2746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wtjIM1QcP5cL3ZvVDyXsgtig8FxgkZM+xbJGZqgKGByTNhlg53zqj6jBjGquvgF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2216
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-02_13:2021-02-02,2021-02-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 adultscore=0 impostorscore=0 mlxscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=889 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102020146
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 02, 2021 at 01:47:40PM -0500, Johannes Weiner wrote:
> The memcg hotunplug callback erroneously flushes counts on the local
> CPU, not the counts of the CPU going away; those counts will be lost.
> 
> Flush the CPU that is actually going away.
> 
> Also simplify the code a bit by using mod_memcg_state() and
> count_memcg_events() instead of open-coding the upward flush - this is
> comparable to how vmstat.c handles hotunplug flushing.

To the whole series: it's really nice to have an accurate stats at
non-leaf levels. Just as an illustration: if there are 32 CPUs and
1000 sub-cgroups (which is an absolutely realistic number, because
often there are many dying generations of each cgroup), the error
margin is 3.9GB. It makes all numbers pretty much random and all
possible tests extremely flaky.

> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

To this patch:

Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!
