Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD28A1BAB20
	for <lists+cgroups@lfdr.de>; Mon, 27 Apr 2020 19:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgD0RYo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Apr 2020 13:24:44 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27810 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726315AbgD0RYm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Apr 2020 13:24:42 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03RHOL0Z008492;
        Mon, 27 Apr 2020 10:24:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=GZ9GjamGT+A0A+SJhZXVkvpA+FGAIwEm1X+n/+7paQ0=;
 b=TCciwyKFyZMzT4+Eq4sazZg8gyQ+9vwxHjYTKSzWp4AmQUy7E9/nm/GALnbEUk10MmKZ
 GvDywdOra8XVimWVNdNc4arPAi9CgN3BX79umvH7/5hSOGWTR4PJGIkeXMdgPKyc6Avo
 61gQBm4NnfZ4gWMKhI+vERI8WGP7doc12xw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30mjqn55mm-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 27 Apr 2020 10:24:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 27 Apr 2020 10:24:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfTYXm2w4Qa5l/RRJVHaqy4uldRyJ44VYsZUwoj0s6OMn1H4V5oC0PTzJ79L07byBeSoRAW6sNx+KwEg3ZynqUm7+pte4VcETm7th9Wn92Qqb4zqWZpN7CPOLYDA5XYGZYH1jnvlYAtZRx3AjR72kdZcEs1f8P5/zZeKIlrwYMJfp4AxyP7gvrO9SRyykOrcCrs7ZV3eWugVJ9ajXqXhX6y8OprDEigjEJwQL9XoSf/IuVNevkPlp7JjIrz8BQtI+TC74fe8I/SKujV1qMKYeeqRQKMRNJ19Za3Mag66vZ44eVWYLjeaiqXvNXNscrY9hexdkN5yNiKYtjNF+oZONg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gIlpWB4No8dxSMwkkUhV0bsKH8iSUF+NgmE3bfR/uY=;
 b=NoHXRxm0Gn4sZBSEXoH4pQJLoKO4P014utNMRQb14SpwHPWPRhCDWwwCAaK432xOAzeYhoudgBu1SK7UPi0kbAKAxgu8LqB9XaNpLL8ew1j79ruT4igji6OgDKjo6LIVe1mz9YKqwiw1agSJIqYm5CpP1tqQXXRwoCyqDzsFi9mlkjZbNl2lDn+I21bNfckUQiWDF6J2nRqRkroMapPDrVCNYs+HFF3WXpiRGHVNfIBhbFRs6JOYeyEs0iVmrNjuoNuvPCaRu/ufqYvZLS2N6mV/6bOTia1esbyKPmHBe7ARGjQM3ZNnly/QZEFbudh4O2XlAedYTHDOJnCF+oEiWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gIlpWB4No8dxSMwkkUhV0bsKH8iSUF+NgmE3bfR/uY=;
 b=TemQQlP10HZATr6CSH/csr4rxTb9xPx80gTHSM6FWB1Grtk7FFhUa1mmp8+ECPjT79FBgzwjxL1AVpQWnTZ3875QKF0z/wCAFyDLo8aO1yMaNqX63ZcGHlj4s2FqYD1OIzIhLjwMnkZrEVEnuo5V93enMWp4ThxfPl8JiyB5ij8=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2872.namprd15.prod.outlook.com (2603:10b6:a03:b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 17:24:26 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 17:24:26 +0000
Date:   Mon, 27 Apr 2020 10:24:21 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Yang Yingliang <yangyingliang@huawei.com>, <tj@kernel.org>,
        <lizefan@huawei.com>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <linux-mm@kvack.org>, <guro@cmpxchg.org>
Subject: Re: memleak in cgroup
Message-ID: <20200427172421.GA122591@carbon.DHCP.thefacebook.com>
References: <6e4d5208-ba26-93ed-c600-4776fc620456@huawei.com>
 <34dfdb52-6efd-7b11-07c8-9461a13b3aa4@huawei.com>
 <20200427171304.GC29022@cmpxchg.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200427171304.GC29022@cmpxchg.org>
X-ClientProxiedBy: MWHPR19CA0075.namprd19.prod.outlook.com
 (2603:10b6:320:1f::13) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:90e0) by MWHPR19CA0075.namprd19.prod.outlook.com (2603:10b6:320:1f::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 17:24:25 +0000
X-Originating-IP: [2620:10d:c090:400::5:90e0]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 688fbeef-d988-48fe-52cc-08d7eacfd5a1
X-MS-TrafficTypeDiagnostic: BYAPR15MB2872:
X-Microsoft-Antispam-PRVS: <BYAPR15MB28725F0FD9CE501B024C1129BEAF0@BYAPR15MB2872.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(39860400002)(366004)(396003)(376002)(136003)(66946007)(478600001)(86362001)(66556008)(6916009)(186003)(16526019)(5660300002)(6506007)(316002)(53546011)(66476007)(6666004)(3480700007)(8676002)(52116002)(7696005)(55016002)(2906002)(7116003)(33656002)(1076003)(4326008)(8936002)(9686003)(81156014);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H9ZKxph5U/2XcW7OtxoPshwE3wHm6bBBxdk1xA205rtcT+HKkjIpFjbkhR2DgDF7Oe4YqBI7SOgAR1atXo1htEkGzf6e1bhjanYnH5kMiIh5I+wAq4bGOIjVho+W24VdjYMDnb8+vTBT5jnKtNc7OGt7AX5Ni8QXVhc5n/CZq01s9KYvRT/M3lFMbJbjaZUgDS0kdmzRmtar+A4JK0TZSBmIAOG358iOOMHJ+lchWWlqSzcURlWOJfcSxKpQ1QTaMvtiPgQkX8MWAjpodRa1EE+SmpUCpuJ2WDh/vLZKuEf+xnvG4HSm6bbEZXhF1mlqHLkMi3Gv1MDYxkOV2c25uI8dhADBHLO0tXq/fo3Wld/hfw9DnhJaE3SHsD4tiYeq8MypyGrMVOAL/IBdIUI+fybWkuM7XW34/1DG0U3op4I8BiV2loRd86qjtQ5PQBly
X-MS-Exchange-AntiSpam-MessageData: 3Q9ZDGx1sf78FyeYrbTgz1unG1Xf8ZGp4dndCTVsb83SXbKuDhDno6uFW0fIeWwBGL5hW8r1RHC6LXyYhaqm1VTzQG1kdHj2Wlfi++ja8aQ7vTyhA4YhF36kMpETHwfC8u7nj7e5MNHfRd6Gi2AfBCvfPfaqtDsh9sIBh2Jyuv6hhTVSK3hyoypPCvrq+R/6Jg85jysu5W0Sec6BMXgk/29Q4dVqvnoPXt3QzXmWa6IZrpvxOef2hFCLVW1D3zb6uCBCe+E860KezGK536NQqbqSazQzyhqPMKwAw4pFIN8T32sjabJlfh93M8AWDQ0CxNdfCX4VhKavlenkPQ71ZTzrysOvULQ4v0IrSbWKPXgIBkIw6Bx19HLyEo2nduRwjKGffqHIhoreCsyMavvnPAYhBGvOpUFev5oADn9nJtbT/GeAK2tW1k2Sm8SIU79Qb4kNKhGynRkCwDV9+IeiQYUFI7VIczv33BpFxKh7Cp7wGdEV6Sl0uEnnSh0I7848upc5rgiB1zQh6aTUTM/9/ioR87xnkCnJXJkAO7biFz0tmqf34TgQ12d4QVqvIeKUNzMoZ7F9Ji2jcUc2UpFpgl9hhPTTzZLCzgtga+D4QjZWhulmmf/FsU92WaIR40oOBOpTe9i59b0uJpr7foWTrbQQYJ3eeKwZVQmUi+plJqEnGFq644zK/xFo0VOTc3ytedSpJqqqsJSamTCnlqKiwjtVqIzMWpQXs1bbVPzDTQiLA9/E6g9zicim8esZobELPis5XqHKjCzlg6F0r7XkMNKgnmw5TqfUu4eZ7DWx/hab5HdC/Flfv5oxgbCYu9TRHPRX/ShTgAAvM98FVDojwQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 688fbeef-d988-48fe-52cc-08d7eacfd5a1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 17:24:26.0623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVV3d9UgIVhTo4B14aZZiGdA1IDfsb47JFZfLeyHzHVeg4D/RVIvdjxU3e+jpDSN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2872
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-27_12:2020-04-27,2020-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1011
 mlxlogscore=923 spamscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=5 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004270143
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 27, 2020 at 01:13:04PM -0400, Johannes Weiner wrote:
> +cc Roman who has been looking the most at this area
> 
> On Mon, Apr 27, 2020 at 03:48:13PM +0800, Yang Yingliang wrote:
> > +cc linux-mm@kvack.org <mailto:linux-mm@kvack.org>
> > 
> > On 2020/4/26 19:21, Yang Yingliang wrote:
> > > Hi,
> > > 
> > > When I doing the follow test in kernel-5.7-rc2, I found mem-free is
> > > decreased
> > > 
> > > #!/bin/sh
> > > cd /sys/fs/cgroup/memory/
> > > 
> > > for((i=0;i<45;i++))
> > > do
> > >         for((j=0;j<60000;j++))
> > >         do
> > >                 mkdir /sys/fs/cgroup/memory/yyl-cg$j
> > >         done
> > >         sleep 1
> > >         ls /sys/fs/cgroup/memory/ | grep yyl | xargs rmdir
> > > done
> 
> Should be easy enough to reproduce, thanks for the report. I'll try to
> take a look later this week, unless Roman beats me to it.
> 
> Is this a new observation in 5.7-rc2?
> 
> Can you provide /sys/fs/cgroup/unified/cgroup.stat after the test?

I'm actually trying to reproduce it now, but so far haven't found any issues.

Yang, can you, please, attach the config you're using?

And also confirm that you're giving the system some time before looking
at the memory statistics? Reclaim of internal cgroup structure is a complex
process which might take some time to finish.

Is dmesg also clean?

Thanks!
