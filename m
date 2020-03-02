Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D130317607C
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2020 17:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgCBQyZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Mar 2020 11:54:25 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41792 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727366AbgCBQyY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Mar 2020 11:54:24 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 022GrV8p019763;
        Mon, 2 Mar 2020 08:53:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=6GrNg9i1YqRPzEEyPjUgEb5cDEPYnvaI57FJcWEvnSw=;
 b=ZNgnTEB+gN/WxsS6aWcUaQ1DeaaVCAqYC1JJBRl0UrNpSVOo2OyOJt3pt0KToDulRZyx
 DS51tZBEFYMx1dC15nn7+Kz1ciKyAT1t9GlsvZDmudYX7H5IDqK3Jp8cexgedz4b4juJ
 MDkDgqpOo22kF/1euNB7CaC/14Z1s66CSD0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2yfpnqrjuj-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 02 Mar 2020 08:53:37 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 2 Mar 2020 08:53:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQo0JljSDcQP+KCHad1iSo3X00hJmujnPBDp6Rytj/bBJFjEDuMqzzLK+zUzhtydzPiQwvus02YRXu7G0nBtHQtYeyFWfSyeJGB02ukpevt0l1dC9/B4JbHbUSCwxhfEe0WQMpsYO7B2BpDsWJRe4Xm2BmHkLs6Qsjy1NXoPbJY1IQSP777fl2rBs3QrCJdS2Qhz4RD8OAG+2HpgKek0A1sb+1dwCjnDaNBSxihya3swSyirNp0fDS+oDBlhomBTUBe/SJ3TlIecQkDHlnI4p8vAS51tw3DUBgNTZN6lM2yY2/xvQ9UDWwQAyoc4Trh3rF3gDqCJgk7ttYvDFFwaFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GrNg9i1YqRPzEEyPjUgEb5cDEPYnvaI57FJcWEvnSw=;
 b=WdKUdtWkkrJp/J5IXnVU4/T6qPMo1wgt7T9yUovBfVoChzvkFcg5vqE92dV2pHJ4o6RtQ7MuNgp+Q5f3qDk5MgvsdqTyhQRlut6uvrusyw0rkjkFVrZbClHRPQpjrhtOL/+jrkSFS7gdIrxG/y3QDCq/AhBRMbvZ8ASvfhWWkLVWqpcWv7V0kZcBMOpJ9agRsMtxOeGpX0MfweSIqxx5xigJieP+Kl77XEyVW1wja06vqa/uKVfAyTC17f5yTV07H7Z00LRGgzh4dF5EO/QamkMGHP/6pVHAt3fYwc9P/bdvLrAfAtjhpw7QmJ7enoC0Dny34GamyeMmb9KNIYWlcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GrNg9i1YqRPzEEyPjUgEb5cDEPYnvaI57FJcWEvnSw=;
 b=lGZ+GZtdaGGXcII/1E3OcFE9XMze4bCJtlMv3IV2JXe+S6yruLKgSYBjY+wX7Vr0j/k7HxVXkXhRyJp4CV8l62kqs9qk4o1AA0wqTyJ3OiQmPU74lD6gwetk0L5JX2J/0jFofGgcbMoGMgR1itTaa3Z02/EkyKRjdTuSm/PotzQ=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
 by BYAPR15MB2232.namprd15.prod.outlook.com (2603:10b6:a02:89::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Mon, 2 Mar
 2020 16:53:34 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:53:34 +0000
Date:   Mon, 2 Mar 2020 08:53:30 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Marco Ballesio <balejs@google.com>
CC:     <tj@kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizefan@huawei.com>,
        <hannes@cmpxchg.org>, <corbet@lwn.net>, <rjw@rjwysocki.net>,
        <pavel@ucw.cz>, <len.brown@intel.com>, <linux-doc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <minchan@google.com>,
        <surenb@google.com>, <dancol@google.com>
Subject: Re: [PATCH] cgroup-v1: freezer: optionally killable freezer
Message-ID: <20200302165330.GA505299@carbon.DHCP.thefacebook.com>
References: <20200219183231.50985-1-balejs@google.com>
 <20200229005131.GB9813@google.com>
 <20200229184300.GA484762@carbon.DHCP.thefacebook.com>
 <20200301162003.GA186618@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200301162003.GA186618@google.com>
X-ClientProxiedBy: MWHPR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:300:95::17) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:500::4:72a0) by MWHPR13CA0031.namprd13.prod.outlook.com (2603:10b6:300:95::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.5 via Frontend Transport; Mon, 2 Mar 2020 16:53:33 +0000
X-Originating-IP: [2620:10d:c090:500::4:72a0]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48ac0544-d49f-4d35-fb51-08d7beca3ed0
X-MS-TrafficTypeDiagnostic: BYAPR15MB2232:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2232A59EBBFBCFE995CB7E33BEE70@BYAPR15MB2232.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(199004)(189003)(7416002)(55016002)(7696005)(52116002)(9686003)(8936002)(6916009)(8676002)(66476007)(66556008)(66946007)(1076003)(5660300002)(81166006)(81156014)(478600001)(33656002)(316002)(4326008)(2906002)(86362001)(186003)(16526019)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2232;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: csD4XrqW/RGxmeo5K8/emgIp6107ESLRfYmbtcl4RKL5a2PsWYNzYUgeVOR9Txe44t0AAHx4UiJ9wlb46jQyqwK90O1o0YTMbNt5yDSTRPH0NVMQY2dxYQHfvcePraUBhIr16vTa8OdQQAVOMOpAGHOtGze+19BP/fQhhC4BnjIGtvaq9tqg1D4tJskjbpOTmx/XifdT5pBByjnAKsha/vt+73hKqGYz7K5WGN/+9QCHBB5vOS3rrtGyVAnJXfTthRMTM2Ld6DYZrNHI78BAgqFaDk+syI6c7Jok3UcB0bvI7WHUErOu9nbY7Cb4mZfeiK6/Zt6sRCg0lfIlZ/4KwaZu7mwEDubUzCevRCCYjzzMtYbA20HVXz8RIuVw+ylCrQ68QYViwaIN5AbWTlibOC3j17+qoBO3KDCr2p3XIJkZy24CS0t3sUgZadk+mTFi
X-MS-Exchange-AntiSpam-MessageData: UxWQtQESyzV+Soul0q+DbzRjU/D51xlL3MWkpqjTg9XzoUQd9UsyZB5mjPepQDnJenj+z3M69eRDW21dwUR24DC/LvPH8umiQ/4pAD4SLV34Zh4FZmbRugvPNHUZZe1gJXbTywtEU1n67Ol9ReiRjtDKTvQIinEv5abMw2aGCHzKXbxwqW0Ofm+pzMeFjpgo
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ac0544-d49f-4d35-fb51-08d7beca3ed0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 16:53:34.5767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXrepyIFuj/Fealv/vrkqipYhpTViRx8QxIvtxMYvIfE8Qdo70CaPgoCWhzrrKPb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2232
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-02_06:2020-03-02,2020-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 suspectscore=1 spamscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020115
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Mar 01, 2020 at 08:20:03AM -0800, Marco Ballesio wrote:
> On Sat, Feb 29, 2020 at 10:43:00AM -0800, Roman Gushchin wrote:
> > On Fri, Feb 28, 2020 at 04:51:31PM -0800, Marco Ballesio wrote:
> > > Hi all,
> > > 
> > > did anyone have time to look into my proposal and, in case, are there
> > > any suggestions, ideas or comments about it?
> > 
> > Hello, Marco!
> > 
> > I'm sorry, somehow I missed the original letter.
> > 
> > In general the cgroup v1 interface is considered frozen. Are there any particular
> > reasons why you want to extend the v1 freezer rather than use the v2 version of it?
> > 
> > You don't even need to fully convert to cgroup v2 in order to do it, some v1
> > controllers can still be used.
> > 
> > Thanks!
> > 
> > Roman
> 
> Hi Roman,
> 
> When compared with backports of v2 features and their dependency chains, this
> patch would be easier to carry in Android common. The potential is to have
> killability for frozen processes on hw currently in use.

I see...

The implementation looks good to me, but I really not sure if adding new control files
to cgroup v1 is a good idea at this point. Are there any plans in the Android world
to move forward to cgroup v2? If not, why not?
If there are any specific issues/dependencies, let's discuss and resolve them.

Thanks!

Roman
