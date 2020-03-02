Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBB81762A8
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2020 19:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgCBS3J (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Mar 2020 13:29:09 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21358 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727126AbgCBS3J (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Mar 2020 13:29:09 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 022IRcju010785;
        Mon, 2 Mar 2020 10:27:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=mKd9uf1AgIDe5RNlalxdwF40OJYaXAH05DlEkFeGAsY=;
 b=ixoPNZXaA2QRyu0yDpo4myO+kTuLHe6Qy/5WZdgzJ3L6eZ7ntd8hPWelws79Ec4QXFuC
 5Lfsei94Ek3d7AoRTEkv3xOgA9+jpR2tDjDWk5JJ2/oVk8jJNcLCNgMzF/26tlXmXYGU
 /XF2w1e7SJfNmKhVa6rm/0MYShtDz0Cs1rU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yg8dcx5mh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 02 Mar 2020 10:27:39 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 2 Mar 2020 10:27:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NACMwikrOJhuUhxFH3fuqmPgD3is5ybLN5t/gUEns6yhc6I1YvVJJ3NDcmt6NKw2yOA10pvgSZxGXw4/NaezzrGTDTiMWHIaIxNFok83DCMVctD3G3mSItEMDrSHWzuY2eadXup/1TF5ljJxM92VGQl3o/zj6u7PkYT8uMlDIkIEjJU9EOKRaKI1rrj3aLldriwoI+WYPhLd9oKhIdCaA8RhXdLzhwm3HeCPj6YwFtnog3hM0FvvMDFYykir+a/xJKhQauocgIRiBeH2prNy/UHwOOvOeJOVufkI1xtLHBBHNl27BY/0whH+wj3YLxKuDE8Tiu01eRLY1wvZlntYWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKd9uf1AgIDe5RNlalxdwF40OJYaXAH05DlEkFeGAsY=;
 b=LZTToLfSl6eyKX1T3hySuoAFHyM6/iQKeQgpa2alv2LrJL+klb42GbfUmgHFPvLz0OlACrimRVJx+dbY0NTWAltLK6Lpig6YZ75Zk8gEPKSjBjbvAr2KWBRoCrp+hi/9w0MkghU2PjWM6/2HDiXUuzNm+UuwW+lOzoEzyk7lfiJVcnSA2M674CtQY3uFRdHWa6fPqiPzbarAU/3Z3EfXhQmNOzcxq95iY8Y7kfH6PujYJzCRvcXqzLbeQYs9VoJiZsLxyYkYFwEBKDgsN+vGW5OT98AeTzvEwp23vROH7BqQ84U8s812KA/XWxyCAq7DMOad6jeqS1kyGqmSUKSJug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKd9uf1AgIDe5RNlalxdwF40OJYaXAH05DlEkFeGAsY=;
 b=CUzk0WsDAo7GnQn8y7+gAjXpowmapBWEl1tCXmtuwo9JWvMQNtnvQnD5XSG3SOTI1QtsLNopdqHaRXtekksRjslvmG9ep90/bmsA14umZrxE3iiouMoc0O/GupIe7q+f1oxyS0q0NLuuZhqCq0ZOX+8bVfJS5sjOTnhhQEI3w/s=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
 by BYAPR15MB3400.namprd15.prod.outlook.com (2603:10b6:a03:10f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Mon, 2 Mar
 2020 18:27:13 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 18:27:13 +0000
Date:   Mon, 2 Mar 2020 10:27:09 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Suren Baghdasaryan <surenb@google.com>
CC:     Marco Ballesio <balejs@google.com>, Tejun Heo <tj@kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, <rjw@rjwysocki.net>,
        <pavel@ucw.cz>, <len.brown@intel.com>, <linux-doc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Minchan Kim <minchan@google.com>,
        Daniel Colascione <dancol@google.com>
Subject: Re: [PATCH] cgroup-v1: freezer: optionally killable freezer
Message-ID: <20200302182709.GA527458@carbon.dhcp.thefacebook.com>
References: <20200219183231.50985-1-balejs@google.com>
 <20200229005131.GB9813@google.com>
 <20200229184300.GA484762@carbon.DHCP.thefacebook.com>
 <20200301162003.GA186618@google.com>
 <20200302165330.GA505299@carbon.DHCP.thefacebook.com>
 <CAJuCfpEk4gz9YKVuRBW4E-Up_LSGWCSpyJft4y+rOjyPSa08Zg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpEk4gz9YKVuRBW4E-Up_LSGWCSpyJft4y+rOjyPSa08Zg@mail.gmail.com>
X-ClientProxiedBy: MWHPR15CA0060.namprd15.prod.outlook.com
 (2603:10b6:301:4c::22) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:500::4:ec0b) by MWHPR15CA0060.namprd15.prod.outlook.com (2603:10b6:301:4c::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend Transport; Mon, 2 Mar 2020 18:27:12 +0000
X-Originating-IP: [2620:10d:c090:500::4:ec0b]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b6f2347-1f75-46f1-c3b0-08d7bed75419
X-MS-TrafficTypeDiagnostic: BYAPR15MB3400:
X-Microsoft-Antispam-PRVS: <BYAPR15MB34007914546F0B9E0C4DFF9EBEE70@BYAPR15MB3400.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(366004)(39860400002)(346002)(189003)(199004)(478600001)(316002)(86362001)(8936002)(81166006)(81156014)(8676002)(6916009)(2906002)(186003)(16526019)(7416002)(55016002)(33656002)(6666004)(54906003)(9686003)(53546011)(52116002)(1076003)(66946007)(66556008)(4326008)(5660300002)(6506007)(7696005)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3400;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S3PDV9iqBsRCNy4XkFSj4hmP8nSGnLmiPkeFZroxDMVRLsKakxBBvJxuv6SiYuzqt3sNRU6cWnHfzaTWlmI+OXbvq0ODcNcaT4L+R91MzFbCY4mJEQfsnFujnTxNOIcmVqK1zIuzcPNf6n8sIj06EtkGpmu91Rw4MOnNGcGKp92gytr2yhc+MCG1P/A1kTAwwgPpHgbQqa1aby8L8+JMbdNUQdJIb0J5fySMKbArw+zzvexdckZXeAkSnY3DvmRTTRASSGltqzLjhgMie30pu3+WjfZfHqQTZuKoSw6RphX4lORNcqSIUXN9naDR2omnCLC7k8AINsuSCF/34tOqd9WnlamAsAyJ4bFiiNLTu6pkj6eJoOplp0McaznaXvlwzWZYSsEP8PgUiNKZhW+QRyCQ/deNoLXMOO3mMenkrmOHucPt5pdCMMz5gr6YNiZG
X-MS-Exchange-AntiSpam-MessageData: nyWtIdFZR1Q6KSkuJEhWKBfN4N0T7msTlM6UwVJ8Nh/Dk8gGwwH04y5ybUT/QMsuxROH9gDZO0w5B+amHSQYwdK2W1B5/19RNOYcZnnvefqMid3jmcqWTp4egwF68k++ro+/I6HLIjgy+2qnPmOsDw8NTg7Luqxv4JEX8JvX9vWl7670T1dsFxT3zXYLVxqR
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6f2347-1f75-46f1-c3b0-08d7bed75419
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 18:27:13.6813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4X55bSbnXoc2TIE72leb+iSeEeNIXfGURPReCaAz1K3KrEy8g6imwwvNzLJik1P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3400
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-02_07:2020-03-02,2020-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=1 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020121
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Mar 02, 2020 at 09:46:36AM -0800, Suren Baghdasaryan wrote:
> On Mon, Mar 2, 2020 at 8:53 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Sun, Mar 01, 2020 at 08:20:03AM -0800, Marco Ballesio wrote:
> > > On Sat, Feb 29, 2020 at 10:43:00AM -0800, Roman Gushchin wrote:
> > > > On Fri, Feb 28, 2020 at 04:51:31PM -0800, Marco Ballesio wrote:
> > > > > Hi all,
> > > > >
> > > > > did anyone have time to look into my proposal and, in case, are there
> > > > > any suggestions, ideas or comments about it?
> > > >
> > > > Hello, Marco!
> > > >
> > > > I'm sorry, somehow I missed the original letter.
> > > >
> > > > In general the cgroup v1 interface is considered frozen. Are there any particular
> > > > reasons why you want to extend the v1 freezer rather than use the v2 version of it?
> > > >
> > > > You don't even need to fully convert to cgroup v2 in order to do it, some v1
> > > > controllers can still be used.
> > > >
> > > > Thanks!
> > > >
> > > > Roman
> > >
> > > Hi Roman,
> > >
> > > When compared with backports of v2 features and their dependency chains, this
> > > patch would be easier to carry in Android common. The potential is to have
> > > killability for frozen processes on hw currently in use.
> >
> 
> Hi Roman,
> 
> > I see...
> >
> > The implementation looks good to me, but I really not sure if adding new control files
> > to cgroup v1 is a good idea at this point. Are there any plans in the Android world
> > to move forward to cgroup v2? If not, why not?
> 
> There are plans to prototype that and gradually move from cgroups v1
> to v2 at least for some cgroup controllers (the ones that can use
> unified hierarchy). Creating an additional per-process cgroup v2
> hierarchy only for freezer would be a high price to pay today. In the
> future when we migrate some controllers to v2 the price will be
> amortized and we will probably be able to do that.

I see... Thanks for the explanation, Suren!

Overall the idea of extending the frozen v1 interface looks dubious to me.
Especially if it's only required during the transition to v2.

But of course the decision is on maintainers.

Thanks!
