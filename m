Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4AF1BA7CC
	for <lists+cgroups@lfdr.de>; Mon, 27 Apr 2020 17:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgD0PUv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Apr 2020 11:20:51 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62260 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbgD0PUv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Apr 2020 11:20:51 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03RFEsB8028039;
        Mon, 27 Apr 2020 08:20:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=AmDKr1yCIvW7G552LfBtEcZ6U+MPyKsjwKVOozHfuNc=;
 b=HXcyGXAI2rVJ34M7Tum7MGXfU0BFbTBYaIINf7f8VmNOdkf/6om1BfyXy2uUuibf0cIW
 ORWXPMJPUJRleGc7PqVoLv21D9sxqJUBBXTMgONydU3NUgYH6sWd5JS9/j9l22cd3M5k
 zELD+ySXQXc/cAYis8APNGjm4wEZGoblH1M= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30nq53k6fw-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 27 Apr 2020 08:20:49 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 27 Apr 2020 08:20:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H//bWzAT4QLGZhvrNQCoelgwBEkjkhEWZeaw4NFa6FjMTRwMFY6zA0BhB2jxxNc/3+pyluIzOOM+O9+CAK7dzpdiGM5eMoZOIoPboNhGYo51CKJljhHbXtRl+X0UWHJtKZEpqvHeZi+Xdn7LwFkz4yK0b1kb2zhH8weZwiPnfKx1DL3XDGLu2+h0XV6omlo3oGrAmpOeNoPqNEhY33sJFmbSm0DaB0trzwJDWKPXW149aLxGREJ8ANgd43v38L0YeJnZWZ2lUxqlLWRTlo6vgVltP8RL9taTiThfBuyxYpda/B6s+kXUZYjfPoylTmCB48xaQzYd4/dZZf9ICe0nUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmDKr1yCIvW7G552LfBtEcZ6U+MPyKsjwKVOozHfuNc=;
 b=MfjQru6mzu9A1ud7Rv6QLQJTYyB2B0nSoqTlzwKLHo0k4pGoWbdIBF80T//6ZuKNUjJEfrGHNovE+l9i/+FWSAAVLrs4f6vRSLY5C+qZhUUk2RcCOfWImocmzMsTbpXdBMfWGviwV+01qIrRIULJ1KGN7uJnqN4GZRrs25ca79bd9ms6Tk54D24cIkXhiG6x6uKkhLLUpfG8zfOu78mWq8epytYCXxJo4kazz7xMgpGfzEfmJMu3YDegks3HRvF8ybdk3r8UeB5E9Fh48GjlxxihDky/T7yXxmLTvfL51mq88hRiexU86Hdl7nMOdv0dMy4r3dRuCWYDl7K2STGtyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmDKr1yCIvW7G552LfBtEcZ6U+MPyKsjwKVOozHfuNc=;
 b=IYJjkvcsc8ovGhH1aSTnCb3XcLAtZYCHMLXfYsQ2f7dRyBCk4fVnyHhZSswH3J+msrbH3iurx9IaixqrMlIJumzGYeZK0aOVY7VgeG0ziiLZS9uoCAa/ONPYtHNhzd8LzZyIxjQV5CcQAcbQIWfuVuj8Y9jetrLozx3fmVJxSOo=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2264.namprd15.prod.outlook.com (2603:10b6:a02:8a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 15:20:27 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 15:20:27 +0000
Date:   Mon, 27 Apr 2020 08:20:22 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Kenny Ho <y2kenny@gmail.com>
CC:     <cgroups@vger.kernel.org>
Subject: Re: Question about BPF_MAP_TYPE_CGROUP_STORAGE
Message-ID: <20200427152022.GA114719@carbon.DHCP.thefacebook.com>
References: <CAOWid-dSF0X3pa6ud2-ndYzJdohuOBewfcEZcG7pQ8q=fZh14g@mail.gmail.com>
 <20200424162557.GB99424@carbon.lan>
 <CAOWid-f0dKfZ=bAzLzdt-wCx2C2orYs3RrKi1MrfjO2=jJVyyw@mail.gmail.com>
 <20200424170754.GC99424@carbon.lan>
 <CAOWid-fw=jaxWTVLTESrPf9XPE3PMnrQkk7GZnaPSkqFN_3e_g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOWid-fw=jaxWTVLTESrPf9XPE3PMnrQkk7GZnaPSkqFN_3e_g@mail.gmail.com>
X-ClientProxiedBy: CO2PR05CA0087.namprd05.prod.outlook.com
 (2603:10b6:104:1::13) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:52ea) by CO2PR05CA0087.namprd05.prod.outlook.com (2603:10b6:104:1::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.7 via Frontend Transport; Mon, 27 Apr 2020 15:20:25 +0000
X-Originating-IP: [2620:10d:c090:400::5:52ea]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33ca4808-b636-4bb7-0cb7-08d7eabe8348
X-MS-TrafficTypeDiagnostic: BYAPR15MB2264:
X-Microsoft-Antispam-PRVS: <BYAPR15MB226406B0587FE2E8CA7A03C4BEAF0@BYAPR15MB2264.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(366004)(376002)(396003)(346002)(86362001)(8936002)(7696005)(186003)(16526019)(6916009)(6666004)(66946007)(2906002)(52116002)(55016002)(9686003)(4326008)(33656002)(1076003)(8676002)(5660300002)(478600001)(81156014)(6506007)(53546011)(7116003)(66476007)(66556008)(316002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ecq2gsdppZKv3IVDWY3qzOjlr/r/Ne59lDhuji4dqqnLw0hD5MVRi8G4lqlFqKAXEoo/K62KXAhzDYgSTIOcf7J/dPZLnbINpavFewa09zoTzfHnqylfsZ7hGfcl3EI6d+VRIKdfp1DXSrtC5tC6CzlMI9ntSSb2mNY86r5Yn+bVOUON3UFNYZDsWZM6l5HDmjmUiy5A9l7vwbRrHlfayT7b2RcDVVe/604caqxchhQ/306we8KtOXE7MafqTIkETdeS0fd8Rh22xZoDnbzWlkcMQGJDW8Ws3p2Qxj8oUhyA7kbJlkk+di8AaN2dwtZ82S3QIsI/cWuA1+8nc/dCfM6j4NBaj8Pnf5x73nIp2Rwhp6eAkbT2sbHppyUDqlJkesl8l+1UYnh/c4KbdL772yapbhz2OkZYY67nVoBLUVWdmaKGTBBU3L2RVxbnlCi
X-MS-Exchange-AntiSpam-MessageData: Nf777PUEpJyu6Ld3ZNQ0iYuR0qGKQXEHgFoYFKNNVqxc7paXryyhzNMNV3jHzPNBjdRsVJUPDuSEZq9MTG9zO3xEwwn4dBVAGDuHdl81SaAuHUJHqfYwp8rUkY3HJCyEJYvKWqh+lZcWPr3x89/HW4xFA0fULtbBgbcSvDAJYevRW0V1c4wNXSBtx53WEYgts3XbWumaeLEBSkPuhwmgr8jizuXvCr8GDvJZFqwT1H1E73cWPj+6Ni1ADJO5abY37CbfSkId2ys8OjWa3nfAY8+6f20Z+VNEktPYaRii50o7rw+7cTg6Smq6RRXjXgCZ6F8ZI3TjtukWZnY+G14vPRJnqW9y2UbxatmYIY9iILADWGcsA6yXPLaBiEeduwQxq0mYmgI/knUbAGe6NpfbrSVX+QGFRCorr0W76j3Arjy0HXlgwbGK+kSGtOyPSjxT71sp0fy3JODKOnRXQOkZX/760+cenqvCn/RHY57L+5ePif7WaHtHlky226/vWm5NTPTlJTqrOnUkZolaomd9yWqMXbIvNRph+CCGYEFjJUARuIwjhWYM953tSO6a+iOCOxqB2ZH+yb+dqjP7oFb463he5ImdmqWnSwi3u/TLj3NdQwAqUBvQTXvq+5LFIXfUU1FK025/z/+XoGo8k0t6ZrmFpydJLnfPsf7v3zkUeb9yg49BYkHv/fwpPJy8InEYMC7ktoX+ee3Vq2rr4ltk1zHvHo7TKLCUgYkQOkAOWWxpVzp2GUbKdl0ZhWoNZQwvDeBMuzm+mcIs88Sm16TNYT78uDXKHAqMxc+9YvnXWmzzGzQ/Ihc/n+XnxzgmfxEU0AnNY6DwEGItf4cXC7ijJQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ca4808-b636-4bb7-0cb7-08d7eabe8348
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 15:20:27.0993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9pAgSEtqykPsTH6nNCRzV8aa2F+ZxxiHejIM/Ds2zsYi4fVwX++7IyUb4v+lQgx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2264
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-27_11:2020-04-27,2020-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 suspectscore=1 impostorscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004270127
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 24, 2020 at 01:28:09PM -0400, Kenny Ho wrote:
> Hi Roman,
> 
> Um... I am not sure yet because I don't think I understand how
> bpf-cgroup actually works.  May be you can help?  For example, how
> does delegation work with bpf-cgroup?  What is the relationship
> between program(s) attachted to the parent cgroup and the children
> cgroups?  From what I understand, the attached eBPF prog will simply
> replace what was attached by the parent (so there is no relationship?)
>  Sequentially running attached program either from leaf to root or
> root to leaf is not a thing right?

Hi Kenny!

Basically an attached program runs for every process belonging to this
and all descendant cgroups. There are three modes of attachment:
basic, multi and override, which determine how programs are executed if
they are attached on multiple levels. There was a development around new
bpk_link based API (I'm not sure if it has been merged upstream already).

Thanks!


> 
> Regards,
> Kenny
> 
> On Fri, Apr 24, 2020 at 1:08 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Fri, Apr 24, 2020 at 12:43:38PM -0400, Kenny Ho wrote:
> > > Hi Roman,
> > >
> > > I am thinking of using the cgroup local storage as a way to implement
> > > per cgroup configurations that other kernel subsystem (gpu driver, for
> > > example) can have access to.  Is that ok or is that crazy?
> >
> > If BPF is not involved at all, I'd say don't use it. Because beside providing
> > a generic BPF map interface (accessible from userspace and BPF), it's
> > just a page of memory "connected" to a cgroup.
> >
> > If BPF is involved, let's discuss it in more details.
> >
> > Thanks!
> >
> > >
> > > Regards,
> > > Kenny
> > >
> > > On Fri, Apr 24, 2020 at 12:26 PM Roman Gushchin <guro@fb.com> wrote:
> > > >
> > > > On Fri, Apr 24, 2020 at 12:17:55PM -0400, Kenny Ho wrote:
> > > > > Hi,
> > > > >
> > > > > From the documentation, eBPF maps allow sharing of data between eBPF
> > > > > kernel programs, kernel and user space applications.  Does that
> > > > > applies to BPF_MAP_TYPE_CGROUP_STORAGE?  If so, what is the correct
> > > > > way to access the cgroup storage from the linux kernel? I have been
> > > > > reading the __cgroup_bpf_attach function and how the storage are
> > > > > allocated and linked but I am not sure if I am on the right path.
> > > >
> > > > Hello, Kenny!
> > > >
> > > > Can you, please, elaborate a bit more on the problem, you're trying to solve?
> > > > What's the goal of accessing the cgroup storage from the kernel?
> > > >
> > > > Certainly you can get a pointer to an attached buffer if you have
> > > > a cgroup pointer. But what's next?
> > > >
> > > > Thanks!
