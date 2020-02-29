Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB7B51748BE
	for <lists+cgroups@lfdr.de>; Sat, 29 Feb 2020 19:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgB2SoM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 29 Feb 2020 13:44:12 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56516 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727194AbgB2SoM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 29 Feb 2020 13:44:12 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01TIVHSZ028405;
        Sat, 29 Feb 2020 10:43:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=J+jPrk2kzt4C/MV7AgapNv9fM22p36mZR7nGr6Zb0rw=;
 b=ABuxQ+ufv/wrth11Ybfr9N459riaiArs7qbRmlBZmo2Y9jyUDSo+AJmyORpPxhS5YtbF
 oIQS+u1F/12RCXKBybvPpc2rCKxj2YrRhQsFFPJJjGSJf5tGrg2MwIFTtyJdRr8RdeSj
 yDvnOk7ldBC5UO7gvZVBrWoX6CeQYlqabDE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2yfphj152q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 29 Feb 2020 10:43:09 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sat, 29 Feb 2020 10:43:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALMnziPoNZW3Ks3MteEpf35A/SLNz3TYFCd961C9eWoqNtDIAcew+q+F9jFahGKbdpXOvQI/MHrljeaZY+tBNcbYeB+TGAIBeq8JJ+NbwcEx8iXAMJIwMjGmhM92YZBqtbsz0zh5QXxioLAYjuJXi/5CDxTih2aOgkjRC6Bwmq+4GTW1KEXQX4P+6PNJNfhf5OOgomYY1FmzlLV976BtOBWTykBy+cEq0brAi+YJLpfZxbqpD3bxMVRX4vSn8wjDeTXE1CPncu06SPl9ytAeaamnu+4sSl2QTT0roJGWt3civGsbqLPTSQcUF6GW+QOudnMHN+6O1po1ds8qFZAxYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+jPrk2kzt4C/MV7AgapNv9fM22p36mZR7nGr6Zb0rw=;
 b=eR6y/pbPyrMMY448Y7V0pkwOWQIQqn22zTlLN0Mwf1acZuY7jxcxqQ9B7VTB29SXAxNX+dwW1x/eik4TSMsvwkAU3zPGulUyn5soOqbFnAGxZVfRdg2ZbSNAUISGX3FJgHGGPHFIdHjsjT0uoEDS6Fgwa3KGhXbG+PCZUw/ozPrQAp1G7ILToVa6EEiqB3PzCx0AHR/cGedXwKIXNChn6Z0sI7KfDT795G36r8d/hQqKr0MdyWUtmzACc/0lREeFrXM01Fl2aNEnHZTe6xTLaUh2CU0j5n+MSWaqcbiC8dozRJJzjKmU86tWjBAeuWok58ovdTFH463x9553Jngo5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+jPrk2kzt4C/MV7AgapNv9fM22p36mZR7nGr6Zb0rw=;
 b=VdDY/5xKVbkOKEC1zoDii2KijFNCoAcYl9qqW4D9c+PSiiTcpjcfwEOr5Hsjz+u+JKqfEdTn5ldFKSLoDuj2pJRPXQPr7eK18g/s7zfzWxtzoYHmJ1OeWErcZCJWhl/Od5pZaJwWE1uHhflMxo/BQDSOHCChqZ3nugfiTd/4eoM=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
 by BYAPR15MB3509.namprd15.prod.outlook.com (2603:10b6:a03:108::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Sat, 29 Feb
 2020 18:43:05 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2772.018; Sat, 29 Feb 2020
 18:43:05 +0000
Date:   Sat, 29 Feb 2020 10:43:00 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Marco Ballesio <balejs@google.com>
CC:     <tj@kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizefan@huawei.com>,
        <hannes@cmpxchg.org>, <corbet@lwn.net>, <rjw@rjwysocki.net>,
        <pavel@ucw.cz>, <len.brown@intel.com>, <linux-doc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <minchan@google.com>,
        <surenb@google.com>, <dancol@google.com>
Subject: Re: [PATCH] cgroup-v1: freezer: optionally killable freezer
Message-ID: <20200229184300.GA484762@carbon.DHCP.thefacebook.com>
References: <20200219183231.50985-1-balejs@google.com>
 <20200229005131.GB9813@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229005131.GB9813@google.com>
X-ClientProxiedBy: MW2PR16CA0041.namprd16.prod.outlook.com
 (2603:10b6:907:1::18) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:2b89) by MW2PR16CA0041.namprd16.prod.outlook.com (2603:10b6:907:1::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend Transport; Sat, 29 Feb 2020 18:43:03 +0000
X-Originating-IP: [2620:10d:c090:400::5:2b89]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4287a62a-0737-4e79-7ee2-08d7bd473666
X-MS-TrafficTypeDiagnostic: BYAPR15MB3509:
X-Microsoft-Antispam-PRVS: <BYAPR15MB35097F1A0D43C50E1E986DDFBEE90@BYAPR15MB3509.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03283976A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(316002)(4326008)(8676002)(7416002)(478600001)(186003)(16526019)(81156014)(81166006)(2906002)(9686003)(33656002)(55016002)(6916009)(8936002)(1076003)(66946007)(86362001)(5660300002)(4744005)(6506007)(66476007)(52116002)(66556008)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3509;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EUOS7l0wXNG1Z9uA06INk7DTBziP5Pv3o2OJ0WyBlRGRLK8/oWcDn6rnduD7GjsZ2ZYDEBZzwpcELGMjd8IAltUA/KOJaG/zo+JnNfIaU1rNrNNGuV9tpPELegv/OBk38PUeTAnpBNnBDCrFybok9+XtmuDZvCEiNcvf2WWzgiHBkGqkY2kprRMiAG53oZo4UyOMhU9vEXepF40UhL/cUZtbjr4q6EqqljOvb11plxMXQOYzrFX5uVwn7VravB8jk+xdrTvkEsdAuxu4yxoWN4dPKlpGrXqWwWpneaquZLwwlkrMTl42zDtTq+OoJjUnlLoEwo/YteRyfbjjEnFI3u6itO3fMJbYUxTkj9op7+dS5lKLYLa5UHgnt7wHQjMod7GY5jzFdL+MuScaeuRlhNu6cZg1XmkDiiheoY/F+evmQpz48l51EvKflt7joCIm
X-MS-Exchange-AntiSpam-MessageData: /M1hrd69eo5H+5QsAmZSx2/E8RN1zu3eN+gZqrWH13z4fbIBHf8c7fgy7FFKl5AHztXOBFyHOt3qOXPo0FR5Jri34IEgaI81GX2LcWVFAQwyPaBIOJC9YtUMZLcPTNoGYdZbdHxO7yJlPJHIhp41840/SyoJ0egc2C3tBDWvHoRvlYqpNSkYfKhDytkWuknP
X-MS-Exchange-CrossTenant-Network-Message-Id: 4287a62a-0737-4e79-7ee2-08d7bd473666
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2020 18:43:05.3046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ze0IWvUkv1YL/z6NrjOyKm45ZdtljHg7FG+bzfWLMQdn0yZgpop5ZuQN5Xhz+5pH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3509
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-29_06:2020-02-28,2020-02-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=1 mlxscore=0 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002290143
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 28, 2020 at 04:51:31PM -0800, Marco Ballesio wrote:
> Hi all,
> 
> did anyone have time to look into my proposal and, in case, are there
> any suggestions, ideas or comments about it?

Hello, Marco!

I'm sorry, somehow I missed the original letter.

In general the cgroup v1 interface is considered frozen. Are there any particular
reasons why you want to extend the v1 freezer rather than use the v2 version of it?

You don't even need to fully convert to cgroup v2 in order to do it, some v1
controllers can still be used.

Thanks!

Roman
