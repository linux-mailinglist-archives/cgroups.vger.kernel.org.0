Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1531BA7F2
	for <lists+cgroups@lfdr.de>; Mon, 27 Apr 2020 17:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgD0PZ3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Apr 2020 11:25:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41064 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726539AbgD0PZ2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Apr 2020 11:25:28 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03RFEGXw013591;
        Mon, 27 Apr 2020 08:25:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Ezbbos40caactUrIw62Vvg0Gqm6QkAM0zVUZyiv0MHM=;
 b=SgnZTEmx1qAsPuiMtKLR0x+qBNFvs3/Je6GgymkWp3A0/DUn/fQJUsxC8gZ8eAe5jeb8
 ww/Day/+rWYye/uT+5Qrgsnvn48yrUjPsVWKAnUNzQSJkxbAYr5sWZIJL6KrMgAG9dM7
 x3Ld9+Mh3gTAGHY/gjfRXAT7CC7WtTueJeE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30n54e8fgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 27 Apr 2020 08:25:26 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 27 Apr 2020 08:25:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dus0SqBAjodXwnPJmtvIXrjPhJslnkcnuSvJH3JWh5eydzY5ZIInB7JUIC6qJrtS/BzF+FfHtnfRPaOEqFxLzT11EzQakPU7W6UH25UmJqnb462AE8R9mANvX+djqm5QJayMBXKMzJKZ6wpFp4M4X7p3R+eJOtrmfgnAioNejnC987G7Y+EaM0yhpw0JvVjvRCqe4l/O8ELV6mHl+s9H2r4jdj1PpKVdXNq2zS7Q663aQvpPreM9itlqW0yQOojluoxA8AzjRZFX+EAlUNw2B7TNCHFR73thjN5fFKF7iEkAaLT21o63zU9SwXXHaDngZ7KuUc39c3YlEzFeo015TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ezbbos40caactUrIw62Vvg0Gqm6QkAM0zVUZyiv0MHM=;
 b=ChCw1fjdP4ATsCnOlWzGa77/X6ugWClBzzurR8bCNr3Rkq3zVWP4sPp7EvPELvZ/A3Ue5CCwBOuYOY6ye4ucGeDfvbtAyiGYsMbPaYqDeE3xp5fU/4B9FVzIL0qoGVInYfQNBp2J8rp+aQQFb1P2N++PiyllUSu0INQI7UBR4hEuqSpYJWZRy1uGfc8JdPEEdlPf3PfDJ1b/u9kPGcYBW/VYTd1sG0MmGIuLeRgepJOEwIjMJBkQ/gZ0O2eUJuHJlKjfB6P+zOgpU+dTs4s7SS90m3ppPPducBvm4Xqrnp+LPquDPR8uwCiGCAapZK/NidUFES7CLg2Obc5InJonNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ezbbos40caactUrIw62Vvg0Gqm6QkAM0zVUZyiv0MHM=;
 b=AklV6wHGDtTNukQZxgCDuWPpjPhdQrEkZUhdoWqg7XVwrZFKjSGFXjSK3SvJ7CGXXJVMOG+jiWmJ6/anZlPrQwNNGngftakNut5s5h9LeG28Au1a1B1m4zZ5tCIv53QnAp/WjcZyvPYHiWrmGBAbujhdPoC4c5VPNDobdlp+p0s=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3063.namprd15.prod.outlook.com (2603:10b6:a03:f6::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 15:25:24 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 15:25:24 +0000
Date:   Mon, 27 Apr 2020 08:25:20 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Kenny Ho <y2kenny@gmail.com>
CC:     <cgroups@vger.kernel.org>
Subject: Re: Question about BPF_MAP_TYPE_CGROUP_STORAGE
Message-ID: <20200427152520.GB114719@carbon.DHCP.thefacebook.com>
References: <CAOWid-dSF0X3pa6ud2-ndYzJdohuOBewfcEZcG7pQ8q=fZh14g@mail.gmail.com>
 <20200424162557.GB99424@carbon.lan>
 <CAOWid-f0dKfZ=bAzLzdt-wCx2C2orYs3RrKi1MrfjO2=jJVyyw@mail.gmail.com>
 <20200424170754.GC99424@carbon.lan>
 <CAOWid-fw=jaxWTVLTESrPf9XPE3PMnrQkk7GZnaPSkqFN_3e_g@mail.gmail.com>
 <CAOWid-f6Kjds2sQ-auOPzixWaCa4twD6BQ+NbCipfU6remn1Hw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOWid-f6Kjds2sQ-auOPzixWaCa4twD6BQ+NbCipfU6remn1Hw@mail.gmail.com>
X-ClientProxiedBy: CO2PR06CA0065.namprd06.prod.outlook.com
 (2603:10b6:104:3::23) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:bc6a) by CO2PR06CA0065.namprd06.prod.outlook.com (2603:10b6:104:3::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 15:25:23 +0000
X-Originating-IP: [2620:10d:c090:400::5:bc6a]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdc3dc4e-3688-4b3e-ce0d-08d7eabf34db
X-MS-TrafficTypeDiagnostic: BYAPR15MB3063:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3063F71B31CD97EF230B411DBEAF0@BYAPR15MB3063.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39860400002)(346002)(136003)(376002)(396003)(81156014)(8936002)(53546011)(5660300002)(33656002)(8676002)(9686003)(6506007)(55016002)(52116002)(2906002)(7696005)(66946007)(66476007)(7116003)(66556008)(86362001)(6916009)(16526019)(478600001)(186003)(316002)(4326008)(1076003);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /P4+JbY0S4s8FGwRXVUUv+3xCvtFE1UbVJRrfkP9/SYR77YeQZFvt5IyQXVMgGZIUKY74cVKgOLKXPedRdJEwYQ7fFnCOPSYDbozHFP2XD0qiND6xZ+0oHZ+XeH9WEF0N4HOYEQUfFM69cCxgwZ27f09XGixkH9gV91dQRL6CxoAXsXWWWYjMRbsOKxUBzaSlhbqZRkRowFBiVltlvzZJ2bnwGndnBqlcA3mkQsPErUdE8eEqzoXlrOT0fKSRJbXvbxuYpvQH0NbHga9FcFB+3HEs0bk0nOFyaPqXpyALyXNIdBuzEym6Tkqgl/Oi/piGxGkfkYw8O7I1r8bUKnFghCVJ7m9mUoVNbclIa8CAIDCePQWJS+8xiIu/EP946hLAZx8SHWaFGCm9jieEF2ueIERL3rRle2J/7AMkUia/ZYrN9v+33N/lVKMhq1dqB+B
X-MS-Exchange-AntiSpam-MessageData: 8auMlQwM4FQZVYS9OvVmGNqGohT51madDNFd65bIQouQey+5VNZjv+a6N8m1NJUgNooL4NShL2z4cqYCI8Le+cZ2F4pZkmsANNh57Uum7TZZohysPfW1eEubzKlMkepiUhKcvvF350OkR1tAH5eG1ps2bQ6QJMItx6/cSm03+daiAy8N/6fdN+3obt9nThRd4g/B4Y3vV/tOa/AI0AhYGw7+V2CWCQv/rovreTiIMdVLNB4sQ54tGu0w42t+dErxPaoc5afO37+XOmk1bYTYqtmDNsOJ7bOxNB4y1aRRX91fn+uc7l1FR0qnG+CBt/IxZwfFsJV++Y+KGzN0KvwT/d0kdhs95F744J+9lm/fxJchgHX3f4Nx89BSIk3w/moaQMkdKcv3ge7kQ2/dhL1MPZi78TP4PAyCeKoYxukoA8DhHC1E4cYao2GFdu2ky5J61mmnGI7Dv92VTswjgzXgmfljHZEntCdJdNeB82TANSNlxD3Jf2SQQieI4/y7BV0hdygxNMzpsG9YXbCb3sDvHBRrSphl9yarmsinF16I1DQ47U4tAMTNexGcPq/81PWSbSGNyl2BKf3pJby8pnWztA2A8MCfTb91bqvVgaAWHWnKRg0zw7AxK1AXOHhL91W5xkPqXhg40E+EbP/x9kAKpRBO7BdIvh+yBEHRvrAYzwOoakNIBkqbLnbA+i5OYkpMmYzv4Rj85d6Rfo0dicxVbfLx0otHunAdxRML1kq++PqsoWhSEum0MahOJk6b91hBGF7P/Nu3ZESe0WjEIkQla9005XoQ+2BHJojUqIohCqS133252yJOiUJ34fyXvEqB9Z0khtISHUql+74B9Iombw==
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc3dc4e-3688-4b3e-ce0d-08d7eabf34db
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 15:25:24.4377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSZ0c8C1VmnuhTDqoZB4wNnSMPS3ramTVTPaLXtU59XlpS+bQolHCYNuTLHcYc2Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3063
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-27_11:2020-04-27,2020-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 priorityscore=1501 suspectscore=1 spamscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004270127
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 24, 2020 at 05:33:11PM -0400, Kenny Ho wrote:
> Hi Roman,
> 
> To be more specific, I have been looking at the bpf-cgroup
> implementation of device cgroup and I cannot wrap my head around how
> the bpf-cgroup implementation would be able to enforce "[a] child
> cgroup can never receive a device access which is denied by its
> parent."  I am either missing some understanding around device cgroup
> or bpf cgroup or both.  Any pointer you can give me would be much
> appreciated.

So as I wrote in the previous e-mail, if a program is attached
to a parent cgroup, it's effectively attached to all children cgroups.
So if something is prohibited on the parent level, it's also
prohibited on the child level.

If there is an additional program attached to the child cgroup, both
programs will be executed one by one, and only if both will grant the access,
it will be allowed.

The only exception is if the override mode is used and the program
on the child level is executed instead of the parent's program.

Overall, I'd suggest you to look at kselftests and examples provided
with the kernel: you can find examples of how different attach flags
are used and how it works all together.

Thanks!


> 
> Regards,
> Kenny
> 
> On Fri, Apr 24, 2020 at 1:28 PM Kenny Ho <y2kenny@gmail.com> wrote:
> >
> > Hi Roman,
> >
> > Um... I am not sure yet because I don't think I understand how
> > bpf-cgroup actually works.  May be you can help?  For example, how
> > does delegation work with bpf-cgroup?  What is the relationship
> > between program(s) attachted to the parent cgroup and the children
> > cgroups?  From what I understand, the attached eBPF prog will simply
> > replace what was attached by the parent (so there is no relationship?)
> >  Sequentially running attached program either from leaf to root or
> > root to leaf is not a thing right?
> >
> > Regards,
> > Kenny
> >
> > On Fri, Apr 24, 2020 at 1:08 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Fri, Apr 24, 2020 at 12:43:38PM -0400, Kenny Ho wrote:
> > > > Hi Roman,
> > > >
> > > > I am thinking of using the cgroup local storage as a way to implement
> > > > per cgroup configurations that other kernel subsystem (gpu driver, for
> > > > example) can have access to.  Is that ok or is that crazy?
> > >
> > > If BPF is not involved at all, I'd say don't use it. Because beside providing
> > > a generic BPF map interface (accessible from userspace and BPF), it's
> > > just a page of memory "connected" to a cgroup.
> > >
> > > If BPF is involved, let's discuss it in more details.
> > >
> > > Thanks!
> > >
> > > >
> > > > Regards,
> > > > Kenny
> > > >
> > > > On Fri, Apr 24, 2020 at 12:26 PM Roman Gushchin <guro@fb.com> wrote:
> > > > >
> > > > > On Fri, Apr 24, 2020 at 12:17:55PM -0400, Kenny Ho wrote:
> > > > > > Hi,
> > > > > >
> > > > > > From the documentation, eBPF maps allow sharing of data between eBPF
> > > > > > kernel programs, kernel and user space applications.  Does that
> > > > > > applies to BPF_MAP_TYPE_CGROUP_STORAGE?  If so, what is the correct
> > > > > > way to access the cgroup storage from the linux kernel? I have been
> > > > > > reading the __cgroup_bpf_attach function and how the storage are
> > > > > > allocated and linked but I am not sure if I am on the right path.
> > > > >
> > > > > Hello, Kenny!
> > > > >
> > > > > Can you, please, elaborate a bit more on the problem, you're trying to solve?
> > > > > What's the goal of accessing the cgroup storage from the kernel?
> > > > >
> > > > > Certainly you can get a pointer to an attached buffer if you have
> > > > > a cgroup pointer. But what's next?
> > > > >
> > > > > Thanks!
