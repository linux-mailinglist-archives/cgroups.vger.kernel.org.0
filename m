Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2B61BC702
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2020 19:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgD1Rqz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Apr 2020 13:46:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48600 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727074AbgD1Rqy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Apr 2020 13:46:54 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03SHeqGe008492;
        Tue, 28 Apr 2020 10:45:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=19VCB1U7MfltrLcG2fRJbhVIWCe9VJtdiRq/m/MQcFk=;
 b=Zc35tzDOkgJIhNLBgPiidyBt8SRoV5/gX2sWBNqD3loA+eAiD84j3DesSIWvjXGc/im6
 gvd/KV05+mmwCB4kwZeHsmkOSJ3Lhiqs5Hfvd+cMi5YNwgMUrQblNFOgZ6aXoQyRhpmg
 jpB39i0NqEqpp8aTF9QbW++qGKG0MNGejgw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30n57q8gur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 28 Apr 2020 10:45:45 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 28 Apr 2020 10:45:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEKIJ/LJ1BfOCMod77IlDvCdzyWbBxKyMbb279YRZf8j3QLRNRy5kVkVp33+pSYGT2QCclgUjtq1nLFpToPI/ekRriuCtfwyZCKMPvwNAXkAXLksnbZfnCa6f+nFvirWn2qvLWCwMsqgBZFpKI9sor45/0LtJXWUC5fOTmjahp1APZQdFPVmZ+XqI66KbgVMHtMWEdYv5UAJvfO9oaaq2Yju6v4E18kVyt/N7os59Z4l8aYX23KimCjfVjUBU+nUBn43bvC2VnUrxjTYVobXV4Yq0uP5QVSVnwUj+eeGl7zif2mJPm2BRR7IOnxYLjfpPcyB3I0SnHQJ5U7cUSq5pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzQu7Uku13xgVHfcVqPVs/ZKDW2m8DxVCYxXRsM3q98=;
 b=Ys4qYHeJcWEk6RyIVvtoEyzlGSRt4Ljsu9n9d2hVvjqgP+1Z8F9hO81uTbIf+I4K+Ua8fm5EK14trYL4GF8mg6CtJiWyUgd9PQBaNFtFxgJY6Jk+mYXUO+STYDeuhKAEtkaR6EOTkeVTmWyW0ALV7s/BXnLQexuarAhCp7ApqcIgpDJfGwoKIFu/U4WZsmp7bOVyRsHP9vCLYbIcYWdncgHYzW9myiBeKjFFQbwe5jT6jN4eSTO3lC9UBdOKTJwWUWnJNFJFg8/XeCDMEy7Wp+EQltHYtCz5bP0gKlERl2+vvkJjt2q68bBG22kTibc4LA+pd0Na2zddAc2j7PaC2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzQu7Uku13xgVHfcVqPVs/ZKDW2m8DxVCYxXRsM3q98=;
 b=gO/S3PjqK34q9eTAJyYzgfv8Yep0sRRXD3wYFUfcMWfn+ecum4CJp/+6sjtjms9+jjI47PGZ497pWT0ahdmFWY1dXprKu4f8uxvLUWshT3A3SvHpbwCYY/IyNC8dlquWC/9NiCC0pNLPu2uTIad7cApCh5PD6+jKrRJ/R2I+BiM=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2919.namprd15.prod.outlook.com (2603:10b6:a03:b1::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 17:45:42 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 17:45:42 +0000
Date:   Tue, 28 Apr 2020 10:45:37 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>, <tj@kernel.org>,
        <lizefan@huawei.com>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <linux-mm@kvack.org>, <guro@cmpxchg.org>
Subject: Re: memleak in cgroup
Message-ID: <20200428174537.GB158422@carbon.dhcp.thefacebook.com>
References: <6e4d5208-ba26-93ed-c600-4776fc620456@huawei.com>
 <34dfdb52-6efd-7b11-07c8-9461a13b3aa4@huawei.com>
 <20200427171304.GC29022@cmpxchg.org>
 <20200427172421.GA122591@carbon.DHCP.thefacebook.com>
 <abc222e3-7038-fa4e-f18d-70ba20f11568@huawei.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abc222e3-7038-fa4e-f18d-70ba20f11568@huawei.com>
X-ClientProxiedBy: MWHPR19CA0004.namprd19.prod.outlook.com
 (2603:10b6:300:d4::14) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:b801) by MWHPR19CA0004.namprd19.prod.outlook.com (2603:10b6:300:d4::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Tue, 28 Apr 2020 17:45:40 +0000
X-Originating-IP: [2620:10d:c090:400::5:b801]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ba87849-fce2-4756-6c48-08d7eb9bf890
X-MS-TrafficTypeDiagnostic: BYAPR15MB2919:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2919A51823A6F559AA697B4FBEAC0@BYAPR15MB2919.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(366004)(346002)(136003)(376002)(396003)(1076003)(16526019)(7116003)(6666004)(8936002)(33656002)(55016002)(8676002)(478600001)(6506007)(66476007)(6916009)(86362001)(7696005)(52116002)(9686003)(66556008)(316002)(2906002)(4326008)(186003)(3480700007)(66946007)(5660300002)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: njcWPtB8Zbf1HOAN1G5MVpPMNFLMkkITixkMkMEKcxwfDFgOejqaJ0lS1Av71YTE8xVZdE3wFNYpOzYiZJFratFkYECr9M892nm9CqrE13C5v4dzoXrHdrKfewK0TV958M20K2u/KJKVvGvv7wAIPCv5bq3v9YowCJA1CnBRAwSNmFdaGf2cuG3XiewO9HADWalnHyzSgKMCjsM3ChiqzGMadbp9BxKKJA9DN6nI+NQ9RA0cO8oh0bo7oiFFfJc90YB/gj+axhnNLgATA6Cb/o4dhsuoTdSrL/83kneq7oSa6wooIDDdSKg/zE/+OR4aOEcIC/cXWHWtwlHSl4V/x7tJqQ/i/voR78nQOxRTQ2HgulAZwt32ulKDAd06eDlW1f5qNT7VGSwuZjenKTGlM9lDydLVlgy4HYUHX+SrT0V7lGoNSRSGUbpDYa62Qh8Gpi1K/H71rlYu3vrdZocBmCvqLEw8HMenufsC3h87G60vs87bWC0Gus3O59VhaqQgmPudkV8Fn9SgLerwvrtfHg==
X-MS-Exchange-AntiSpam-MessageData: ybU87e00UCSkmBMRBfNzdDTurcqH+44+OcUhetwkX83NEKSG1piV1iPaJIjePQVuRXQNS3ysTeO5Y500tljEqpIFH/hec4CTsjRfETsJ6bw3SJm6lodW9Q33qOebuYSWn204cXnFs+p6i0cL+9CPsbvEIoTYMyh55I8j9Xi7p7+i4bEJU9cspEnFRUdgZqpIZbVe46CSZOfc+32ffFOew4UqUebHDnKYboudkrwNvfte+abv4puKSnu4slIgB9d2cFjQxHlCav1XOmQfj/uCwEjNt98fgaHwWVA6ll7Pnmo2Hqnh0UwSizeYVvCR/AK5LLaeBFLHtPFK81R9LIsbkw2IEEHhjZYehhDMINa08+AzSHMvnornF9pobR1t30HjY1ROfINpY8S/gI0sRdYN/q9BbHoesoka/u+GroCoqD5173FRcrbSJSdKoG6sMBgd0STkpONDKzvyjZ0Zc3n+RQ3cUbrYXC39k73o7Ma6VMKFvUC9KLx/7ApQi/qai2HEhMGihe6VgR9/JGOGtjh0jn4r8kp+oq5LDF/0bGLebelhLh7BcH8lGHnggZuw1jhUrGhZMxa0TzbUjy6HfNPNeGnY8X85jCM8UqdbVEyrNHviQ7ZCxpx9JptAKU8w2/m1duaNIyXA1crfBbVroDHa8lUWpRoFMJqioT4KIC+KfgSKEuWICDBuia4JCtPgoW7FctbUU2iltsDxjvCF6T1Wcsl+5gpe5ykIGYWnJKckBSRDiK+zj3gAZWulcD2ia2dNtggsbjmddcwjL9rMlkjLTPbfazsJkMkT5SSgqf0hmmrQIYgYytZV15kJx/QTnasKvbOU5LhvOI3kGRYD6DDn6Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba87849-fce2-4756-6c48-08d7eb9bf890
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 17:45:42.1095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5k7NKonQfGCg2BLLc7ZyiHmfKIuyyyePSNTAsawOYwkx2MoGVqcnJh7mfJZRj5Ch
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2919
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-28_12:2020-04-28,2020-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004280141
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 28, 2020 at 05:10:33PM +0800, Yang Yingliang wrote:
> Hi,
> 
> On 2020/4/28 1:24, Roman Gushchin wrote:
> > On Mon, Apr 27, 2020 at 01:13:04PM -0400, Johannes Weiner wrote:
> > > +cc Roman who has been looking the most at this area
> > > 
> > > On Mon, Apr 27, 2020 at 03:48:13PM +0800, Yang Yingliang wrote:
> > > > +cc linux-mm@kvack.org <mailto:linux-mm@kvack.org>
> > > > 
> > > > On 2020/4/26 19:21, Yang Yingliang wrote:
> > > > > Hi,
> > > > > 
> > > > > When I doing the follow test in kernel-5.7-rc2, I found mem-free is
> > > > > decreased
> > > > > 
> > > > > #!/bin/sh
> > > > > cd /sys/fs/cgroup/memory/
> > > > > 
> > > > > for((i=0;i<45;i++))
> > > > > do
> > > > >          for((j=0;j<60000;j++))
> > > > >          do
> > > > >                  mkdir /sys/fs/cgroup/memory/yyl-cg$j
> > > > >          done
> > > > >          sleep 1
> > > > >          ls /sys/fs/cgroup/memory/ | grep yyl | xargs rmdir
> > > > > done
> > > Should be easy enough to reproduce, thanks for the report. I'll try to
> > > take a look later this week, unless Roman beats me to it.
> > > 
> > > Is this a new observation in 5.7-rc2?
> > > 
> > > Can you provide /sys/fs/cgroup/unified/cgroup.stat after the test?
> I re-tested in 5.7-rc3, it has same problem and the
> /sys/fs/cgroup/unified/cgroup.stat afther test is:
> 
> nr_descendants 50
> nr_dying_descendants 0
> 
> > I'm actually trying to reproduce it now, but so far haven't found any issues.
> > 
> > Yang, can you, please, attach the config you're using?
> > 
> > And also confirm that you're giving the system some time before looking
> > at the memory statistics? Reclaim of internal cgroup structure is a complex
> > process which might take some time to finish.
> > 
> > Is dmesg also clean?
> config and dmesg are attached.

Interesting...

I've tried hard to reproduce, but haven't managed to get anything so far.
You've a huge machine with a non-trivial hardware setup (e.g. those cpuset warnings
in dmesg), so there must be something special about it. Could be anything:
percpu, rcu, some incorrectly handled ENOMEM case.

I've several questions, which might help the investigation:
1) Is there any known good revision, which doesn't leak?
2) Can you, please, check that all those cgroups were actually created? I mean
   if some mkdir calls returned an error, it could be a huge hint for us
   where to look.
3) Can you, please, dump /proc/slabinfo before and after the experiment?
4) Can you, please, repeat the experiment creating cgroups in /sys/fs/cgroup/unified
   instead of /sys/fs/cgroup/memory ?
5) If you're familiar with bcc tools (https://github.com/iovisor/bcc), can you, please,
   run memleak.py during the experiment?

Thank you!
