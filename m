Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC28E228923
	for <lists+cgroups@lfdr.de>; Tue, 21 Jul 2020 21:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbgGUT3J (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Jul 2020 15:29:09 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44270 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729497AbgGUT3H (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Jul 2020 15:29:07 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06LJPbr6019531;
        Tue, 21 Jul 2020 12:28:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=wP1rcjYzY+zqZYZFuAG3LTgRFambuN6uLhhtU+vtj4I=;
 b=VM+WdZ4/ST0cS//LaJSBiPRq+tuMT7nC4iSJMudUo9gbglQPtUYGrdbuA9L3oLwPK1CU
 d1biamqBYRrMbMT93/7IkQ7RyW5mUUFnWUdJj8CK45wrqwQEIawa9OLnp8fPeKT8iynr
 EBMsiVvy/VK5xltiznlKfRuK+QkSrkiNgCc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32bxkmnnda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Jul 2020 12:28:09 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 21 Jul 2020 12:28:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmYVUmJsjU4ceeRLg5qvSznE6iuayeqHVmJzf4aJSlRDCLT3K4jPkqRI+ezWGT3BbGMxQlf91Vol2fS2xlAHz5wCjmgWXZwTLAT7+OGZftjqHR53Bm/KmBQaO9bEeuz0NIMxEVkqZcDu06rBjNl74/Y/6w5HsDQl5BZ2AC+EvrUB3jYNE85Xb6S4OmjvdVOENmJkKr0dubb6N5FIwjCHJSwbuRND4jlyQWLs1ufrK1Filgew+OyFzi/AVkguPYurSpLaLd1xCU89zqjEksBF0z4ruEaUdeKmBExyE4fzCy2TrM7QPrMdLbcxIKR7OrxpbtkDyeqF/dTCEV7fPfhlEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wP1rcjYzY+zqZYZFuAG3LTgRFambuN6uLhhtU+vtj4I=;
 b=aRS5xTXvc/vl/HsWl8u31DIwvKFx8KwY92PatnhLFWv3a5gdpX2nZ76t4MCuoHZusdz1GtXyBOy7qXdCD7hHVfCYkALP7B7CK3IKplSQ3v/tGqqirTmEYNmJx6Y+y/G1ccf0Caukf1R7owYhmq8wOvSfj2z9cZGz9bf1PGdty7kccZOrxNqwBiXNNQoZU5Sp3oD2XktdTnjiwWfO8sN2vgGZbasBmF7sgz4Uwq0Qdmt3Hno5Xlck+lZ3P/UwwEDaDbYbGqYBhpxeO2JnPqd722w4/qT31CRXXZu23NtSxWYsOCDY02esp6cG7acSWGJMlsuFHgMsqTCe65tO19O5kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wP1rcjYzY+zqZYZFuAG3LTgRFambuN6uLhhtU+vtj4I=;
 b=MzzVj7DR93dYn4CLbscftImopNAZ1T5aJlJbOZ9NL2mvxFbAEADD8B9XYEamgFR5oRtMf190rFsaNo03H51oU72E9gwO2AFqsgGp0mVAnyD/fB9gB01s/D6QKd9OFwXVVgRKOl+LxlDMtPjQd+DnaJZVrk09eWHs9Uv7EyLMSR8=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2437.namprd15.prod.outlook.com (2603:10b6:a02:8d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Tue, 21 Jul
 2020 19:27:52 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3195.026; Tue, 21 Jul 2020
 19:27:52 +0000
Date:   Tue, 21 Jul 2020 12:27:49 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>, jingrui <jingrui@huawei.com>,
        "tj@kernel.org" <tj@kernel.org>, Lizefan <lizefan@huawei.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        caihaomin <caihaomin@huawei.com>,
        "Weiwei (N)" <wick.wei@huawei.com>, <guro@cmpxchg.org>
Subject: Re: PROBLEM: cgroup cost too much memory when transfer small files
 to tmpfs
Message-ID: <20200721192749.GB8266@carbon.DHCP.thefacebook.com>
References: <2E04DD7753BE0E4ABABF0B664610AD6F2620CAF7@dggeml528-mbx.china.huawei.com>
 <20200721174126.GA271870@cmpxchg.org>
 <20200721184959.GA8266@carbon.DHCP.thefacebook.com>
 <CALvZod6-sTBMzvo0ER+RkQ_OM7B4=PKUC-T9gXmQiB8mznunBg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6-sTBMzvo0ER+RkQ_OM7B4=PKUC-T9gXmQiB8mznunBg@mail.gmail.com>
X-ClientProxiedBy: BY5PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::30) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:cfe6) by BY5PR03CA0020.namprd03.prod.outlook.com (2603:10b6:a03:1e0::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.20 via Frontend Transport; Tue, 21 Jul 2020 19:27:51 +0000
X-Originating-IP: [2620:10d:c090:400::5:cfe6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 429319ea-a792-49ca-d219-08d82dac2935
X-MS-TrafficTypeDiagnostic: BYAPR15MB2437:
X-Microsoft-Antispam-PRVS: <BYAPR15MB24378CF76CAD76BE04C2741DBE780@BYAPR15MB2437.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kM8lyAyc5JleK+ruo5zwQknznlQI6VZzMHlNcKdhYzaE6ejy1c2OtX9OQvbCpDFXUtpJM97J5gc917a6AxQPxZyK2lu8rRVU8tXjgMeAJ08WiPnAfkV08gNZ2nLKaFthhQBhf2D7xEkiza5HerJzClI41NNOpvBwHgRwvNWmKmiyuF2II7w+niI5tJPujxu0vaD02sUASQ+9XbCHQ9K9M7/NzQas2P2y6xfUdEaU3D9+/UdRZZE2gqsWXXMkwwjrBVcS/wZDXBgC6+RsrnWZQQoPfWfNxXVv0TCeezupF8Gy5sj2FrTP+azY/YmnHmuF3dsLPCxojITmn5mnb+gRI5SCCiEiV5BReMtHPIHgFDjpNzBhdv0Y2e4J0eh3eW/8q6Yw2t5LmTvC297VTEQ0J8RAUiSjTvGyRIlXflde+z9TsrgoKEbh5+o03L6QEV5t0ldxgj10WthNwe8OA9ASuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(366004)(136003)(39850400004)(396003)(8936002)(2906002)(966005)(1076003)(83380400001)(66946007)(66476007)(66556008)(6916009)(8676002)(7416002)(7696005)(52116002)(316002)(54906003)(5660300002)(53546011)(6506007)(55016002)(33656002)(9686003)(478600001)(86362001)(16526019)(186003)(4326008)(17423001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: XI0PogqPasmp/ADYHIL3i0F+wPxQ1bAWS4uuS2F0PDz+GZLpDxlsLoBp5W9fX0XDClhy06dSOF6ZFM/ltbaE192LgSMXQB9r+cHyXG17a7W6CD1gJHoWkfMyUNs+qJ1qWe8JFH82RTQIIj4gwYNCD2xMP4JQMIKyD0qerVmKwOjvHA48j3+0HFcAErqQLoa7QAZuXHonVOqCyyMfTomyMANsB8UF4QS38DoFZyhSG49i1RyiMGj7+p1iGCXAU1cFYWM+YAOrbGmpYQZ5uKlBk8RNu5MBecQ5Wu0CjINtcgNwZu1J+stOcs9YsNFaynCgsHLGfRdXgY0+ktli8LHytouQnIQeUlU/HD4skZanlsl7J+cr8w9KxuQSHKwfvui6rqXQ35m0WKCo8kCh4DGrKGGrWbMYHu7X7vMRstIAgkm/ipX9T7cSzSi/3oWdBaWZW70xf6Aom23TRYLW5OpQWMrc2dCb1tbsf4azQwBED7qt4Xpjfs3fxCehRdtcFGUz6egEGnv3RHWFc4wTtq4O3Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 429319ea-a792-49ca-d219-08d82dac2935
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 19:27:52.3722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: plms/on4ozgAkEcIvyYtwpy2iOkUqov3JR2cB4G0TuV4LcMrtGoTt1Qtm7LCKP3K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2437
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_14:2020-07-21,2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 adultscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007210128
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 21, 2020 at 12:12:58PM -0700, Shakeel Butt wrote:
> On Tue, Jul 21, 2020 at 11:51 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Tue, Jul 21, 2020 at 01:41:26PM -0400, Johannes Weiner wrote:
> > > On Tue, Jul 21, 2020 at 11:19:52AM +0000, jingrui wrote:
> > > > Cc: Johannes Weiner <hannes@cmpxchg.org> ; Michal Hocko <mhocko@kernel.org>; Vladimir Davydov <vdavydov.dev@gmail.com>
> > > >
> > > > Thanks.
> > > >
> > > > ---
> > > > PROBLEM: cgroup cost too much memory when transfer small files to tmpfs.
> > > >
> > > > keywords: cgroup PERCPU/memory cost too much.
> > > >
> > > > description:
> > > >
> > > > We send small files from node-A to node-B tmpfs /tmp directory using sftp. On
> > > > node-B the systemd configured with pam on like below.
> > > >
> > > > cat /etc/pam.d/password-auth | grep systemd
> > > > -session     optional      pam_systemd.so
> > > >
> > > > So when transfer a file, a systemd session is created, that means a cgroup is
> > > > created, then file saved at /tmp will associated with a cgroup object. After
> > > > file transferred, session and cgroup-dir will be removed, but the file in /tmp
> > > > still associated with the cgroup object. The PERCPU memory in cgroup/css object
> > > > cost a lot(about 0.5MB/per-cgroup-object) on 200/cpus machine.
> > >
> > > CC Roman who had a patch series to free all this extended (percpu)
> > > memory upon cgroup deletion:
> > >
> > > https://lore.kernel.org/patchwork/cover/1050508/
> > >
> > > It looks like it never got merged for some reason.
> >
> > The mentioned patchset can make the problem less noticeable, but can't solve it completely.
> > It has never been merged, because the dying cgroup problem was mostly solved by other methods:
> > slab memory reparenting and various reclaim fixes. So there was no more reason to complicate
> > the code to release the memcg memory early.
> >
> > The overhead of creating and destroying a new memory cgroup for a transfer of a small
> > file will be noticeable anyway. So IMO the solution is to use a single cgroup for all
> > transfers. I don't know if systemd supports such mode out of the box, but it shouldn't
> > be hard to add it.
> >
> > But also I wonder if we need a special tmpfs mount option, something like "noaccount".
> > Not only for this specific case, but also for the case when tmpfs is extensively
> > shared between multiple cgroups or if it's used to pass some data from one cgroup
> > to another, or if we care about the performance more than about the accounting;
> > in other words for cases where the accounting makes more harm than good.
> >
> 
> Internally we actually have an tmpfs mount option "memcg=" which
> charges all the memory of the tmpfs files on that mount to the given
> memcg and the motivation is the shared tmpfs files between multiple
> cgroups. One concrete use-case is the shared memory used for
> communication between the application and the user space network
> driver [1]. The "memcg=root" can be used as a "noaccount" option.

It sounds like a good idea to me. I'm slightly worried about possible
security implications of allowing to pass a custom cgroup, but I guess
we can start with supporting the root cgroup only.

Thanks!
