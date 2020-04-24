Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F741B7C64
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2020 19:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgDXRIQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Apr 2020 13:08:16 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58372 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727089AbgDXRIQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Apr 2020 13:08:16 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03OH0NSG012419;
        Fri, 24 Apr 2020 10:08:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=v+ZCaE+m/dAwGQ2MapWJPmqh1Ww3PT189gWuPzQuHWo=;
 b=pE176y8b99figdIgGuGYTeWbYNtYIYbpfJ67E9RNPPGwJhInN77t+/Nl0WZ+PhIv7eQD
 zjDQfZXNJwinc9Ah/CvnfsZLjDoPbz6L1+f1CFwelmlXmcXnWnrVJo7L5sovE9Lykbld
 YeEc2TOkl4FZc7uH/HzGLXsVFgyeHK9qAZg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30jtc5x831-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 24 Apr 2020 10:08:14 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 24 Apr 2020 10:08:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aG7ICErjNfxJbTqlF7VuBYIMlzXxMx/KLcYDWSa3TvXSizVEXM8PZzShSrQ9j6Oc3L5u3GYPbVbZsBoscZ0Qe9CSapiID1KNLWqL7YE7HlU6uOYTT4kIgjjcsQhsNv7OZ4IX4HIM+y6w6pZDdK5tXTKns3VFT+VTcMEEpSifQIt2EcG1pY34W4axeitt2PZMdZmDgpRCYFcOJPsONqDHnlYvq/90D82S48twyXBb1O2vssQ5iLZHFsI/kLiML5dxm1O8cnVwyIHw3bsM8EhmW232i51fU8hAp4zGNccSneeFEtuSJ4LxZZ+Yl9ZVSZYhTMgsrDevSw4gDCmBqpSLsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+ZCaE+m/dAwGQ2MapWJPmqh1Ww3PT189gWuPzQuHWo=;
 b=VyuNoUXqZ4CHbbFwuXL4eCLBOpzR2YQayFxGRz9UOmZj3LB+mlyDM3yqDHdQrKWaLNm2y5kdy3fL1EsZLzj+qCb/6sf/5kM5J0hLQjNMCErjWsUAzKYgzQzuHqOZAq6Q7XCRR/Zc+ZjIxZnWOkkdHKXmQF6cKGiWS+M4Op8loFvz3f7WFiECLtmP/SUl1RMaFwibSD2nA+WMJheXCVNFhAxeN924NTMi6oCyMWfSDC7l6k/U45FVepy6o2BKb2xVa9Yqqe6Q3kUXI/BX61ot+T3FkYQJR67H6f6umQKuduII7onpSoHbWTaypShT1YZSwvFzlLvtjBw76qhCLZgsgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+ZCaE+m/dAwGQ2MapWJPmqh1Ww3PT189gWuPzQuHWo=;
 b=SXERQEBEqAHGetNWTYQQtYPZiD64z7qvY2iMC54v10jnK9+Vx7wsyZGQSxyXQeAsdalXgzI3lcnw5b1HbaJ9uK2+OCGXtWfWlPFIBcrh5BZsdlX2Lk+X5yb4QQeJd3TUNW4PiwxN5ohyMAb5UjH/eWecqN1pYSbSNDPvkOELuGo=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3191.namprd15.prod.outlook.com (2603:10b6:a03:107::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Fri, 24 Apr
 2020 17:07:58 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 17:07:58 +0000
Date:   Fri, 24 Apr 2020 10:07:54 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Kenny Ho <y2kenny@gmail.com>
CC:     <cgroups@vger.kernel.org>
Subject: Re: Question about BPF_MAP_TYPE_CGROUP_STORAGE
Message-ID: <20200424170754.GC99424@carbon.lan>
References: <CAOWid-dSF0X3pa6ud2-ndYzJdohuOBewfcEZcG7pQ8q=fZh14g@mail.gmail.com>
 <20200424162557.GB99424@carbon.lan>
 <CAOWid-f0dKfZ=bAzLzdt-wCx2C2orYs3RrKi1MrfjO2=jJVyyw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOWid-f0dKfZ=bAzLzdt-wCx2C2orYs3RrKi1MrfjO2=jJVyyw@mail.gmail.com>
X-ClientProxiedBy: MWHPR01CA0039.prod.exchangelabs.com (2603:10b6:300:101::25)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:58c7) by MWHPR01CA0039.prod.exchangelabs.com (2603:10b6:300:101::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Fri, 24 Apr 2020 17:07:57 +0000
X-Originating-IP: [2620:10d:c090:400::5:58c7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44da0945-c88c-4a70-d84c-08d7e8720996
X-MS-TrafficTypeDiagnostic: BYAPR15MB3191:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3191752AFF85B06AFD5916FCBED00@BYAPR15MB3191.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(346002)(376002)(396003)(366004)(81156014)(4326008)(316002)(5660300002)(6666004)(66946007)(8936002)(8676002)(6916009)(8886007)(33656002)(66556008)(2906002)(86362001)(16526019)(66476007)(186003)(9686003)(1076003)(52116002)(7696005)(53546011)(6506007)(36756003)(7116003)(55016002)(478600001);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8GfEIq9GHQ5tFNzmBq+kLKFiOlZcY+Uj6G48b7c+REsIrmYEHdSxCO+xJEQDOWNGiEzg9LXfC8Qra6daoMeJToU7hDt2eOxDl3/DG93QsEu67gNRAF5IbnN5nvJM6Qdt+eHgLptwtLVbqn0K16fB3hkHZ4xEHiVxagP6JUpi5ml+UpgLH2PDnaqttYyXKSJLhiWQ5/x4NJ6twSMlepJa4LL1k5MxNqUn0qafbJr6WSYqYd8HBuWXauej9DGHfWSAEwKoMw5CYrRSLiCB0GoNkvoyfeGr1I/gqtYSF+UvbU96v8YX1Yu+C6Kl8wW6g9awhdnuUf6gUDV+BznEgysPHivAtDywcslNjHbw6oKI40FYrr9qPukh6721gE5khJZmO0jTrez9PlgZRj/eNvvsYp2gWfvI7hV/dY8obt+npoAL6wTgVEI5jNgIhNLhuK1I
X-MS-Exchange-AntiSpam-MessageData: gB6i90esL6S5+Cq6H1y+UUNHpXxlL6tdXOJgbhQVjqWefMg/CE4GV08W7SiYs9k6dkY6rWSfHcw5Mqj/KMLTlbPo4AIGBbC/saifREd9Kdh7i6WTls3I1IAj9zlXGWmWkFnkkkEazIpJeRbLdsFwQH8P77MLEIQpa24QXc30ouBPRq8JEzgXdN0K5gOowprP
X-MS-Exchange-CrossTenant-Network-Message-Id: 44da0945-c88c-4a70-d84c-08d7e8720996
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 17:07:58.1920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICzVRAuVRR6FvQzBISFFqcl52RsbTUmSPp1xswvBnL414tS8nL/22RU27N6OX2YF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3191
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_08:2020-04-24,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0 suspectscore=1
 bulkscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240133
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 24, 2020 at 12:43:38PM -0400, Kenny Ho wrote:
> Hi Roman,
> 
> I am thinking of using the cgroup local storage as a way to implement
> per cgroup configurations that other kernel subsystem (gpu driver, for
> example) can have access to.  Is that ok or is that crazy?

If BPF is not involved at all, I'd say don't use it. Because beside providing
a generic BPF map interface (accessible from userspace and BPF), it's
just a page of memory "connected" to a cgroup.

If BPF is involved, let's discuss it in more details.

Thanks!

> 
> Regards,
> Kenny
> 
> On Fri, Apr 24, 2020 at 12:26 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Fri, Apr 24, 2020 at 12:17:55PM -0400, Kenny Ho wrote:
> > > Hi,
> > >
> > > From the documentation, eBPF maps allow sharing of data between eBPF
> > > kernel programs, kernel and user space applications.  Does that
> > > applies to BPF_MAP_TYPE_CGROUP_STORAGE?  If so, what is the correct
> > > way to access the cgroup storage from the linux kernel? I have been
> > > reading the __cgroup_bpf_attach function and how the storage are
> > > allocated and linked but I am not sure if I am on the right path.
> >
> > Hello, Kenny!
> >
> > Can you, please, elaborate a bit more on the problem, you're trying to solve?
> > What's the goal of accessing the cgroup storage from the kernel?
> >
> > Certainly you can get a pointer to an attached buffer if you have
> > a cgroup pointer. But what's next?
> >
> > Thanks!
