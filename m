Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E09F1C07CD
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2020 22:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgD3UXo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Apr 2020 16:23:44 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40450 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726488AbgD3UXn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Apr 2020 16:23:43 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03UKILa9024351;
        Thu, 30 Apr 2020 13:23:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=RCCXWDjVRlwpddUB4DfuXqXk65Tcvr+BQrgC6dU4n3Y=;
 b=DRHrq5ZeTcX9SCKsKRJolng7HMcc8vMJqdritvpAE4Iyvz36N8e2C6vBX+SixpmGqp/T
 0N3h1E+H6RkdJDhIYEka6xP9tWeeMK9/ri1lkv1bRuxGqPw68D5elzVf5rlx5sLE+1Li
 XBoJFG8uUTvTo16YKWayP8uFfL5e8ZADTdE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 30q6y12c0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 30 Apr 2020 13:23:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 30 Apr 2020 13:23:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZKoI9RO4x3HaAg/NjVucBcwv4rIztWJunKbDaqeGOUocl9EKRImIyHHpBqHrlUSw7mOxzlhW6vkCOv8Y6297DV8iNYI8X1uXzoxBh+jpQ8L7aQKeMHVxYWabwEqb3ymFgpEmzbiC1Zlcx8wWauEVnyQLBnjMO44c+6sTnh1HMyMfiuGzZqbnQLKIv2gyEXF+Igb+GrB28cbXfCYr/qDVdvtlGnn046WK0X7M3QjM3/MrXei+2dBrJJ1GodlnqUXM19OVMiWKSH9J66xFX89iuh3jsd4FyU26/A7KG38C1GIn/z/LnS4NVTsfADT9E7PdZULZvjCuruCVhCIwD3uzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCCXWDjVRlwpddUB4DfuXqXk65Tcvr+BQrgC6dU4n3Y=;
 b=PUmqHPpynU5iK7OmiY+5GFMYqUS/QtWvlkbwmGyMcyRileP8Ssnk77FcDdxR658xzCAtgi4zLUWFIIOqiIQPydbdU8W8azAvFcBlToCiavnYa/hk0pZBTXU76nT95Nk+93k3BPhGmtURiUIaASoUilK64Nrqo+e4oS7gxZ2PB5v43nCDjzNFGHr36MzhaSfF6Omm53FLjlWhUrVjcye8zziI1ZiYrU+1N1B/HMon6U5hRUxeNc7qI48rs3IIFiZFo+LpTJKPzjMECBn2BYLNkybYJouU0eJJV3+PGrcb6DKeKoMNcYigI+POUguP1tbpFhDRnXswFpWwvWyv50oXNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCCXWDjVRlwpddUB4DfuXqXk65Tcvr+BQrgC6dU4n3Y=;
 b=el021WNRoYt4oU9x6jdtZmIKUSwZCUJRGK5G8Af46n9hsXTc8NmVj4bkx1KWtdFY/KUzx3afaR+pffbFNbrwFt+gjtdHQGfejdKVx57GIZA08hKLlx/EqxucCbTWPC8AqT8N4vNvyhwQTOnMGJS4etKzIdgQ3C3WOiXRT22cKIU=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3461.namprd15.prod.outlook.com (2603:10b6:a03:109::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 20:23:24 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2937.028; Thu, 30 Apr 2020
 20:23:23 +0000
Date:   Thu, 30 Apr 2020 13:23:19 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
Message-ID: <20200430202319.GF339283@carbon.dhcp.thefacebook.com>
References: <20200430182712.237526-1-shakeelb@google.com>
 <20200430190610.GD339283@carbon.dhcp.thefacebook.com>
 <20200430193049.GB2436@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430193049.GB2436@cmpxchg.org>
X-ClientProxiedBy: MWHPR14CA0008.namprd14.prod.outlook.com
 (2603:10b6:300:ae::18) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:f631) by MWHPR14CA0008.namprd14.prod.outlook.com (2603:10b6:300:ae::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Thu, 30 Apr 2020 20:23:22 +0000
X-Originating-IP: [2620:10d:c090:400::5:f631]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac81bdc7-6756-458d-1aa7-08d7ed4454f8
X-MS-TrafficTypeDiagnostic: BYAPR15MB3461:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3461E7DB05EA67D8DEEF2479BEAA0@BYAPR15MB3461.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4J9UBUm7edt6Fbh9lykJ6258YEnEB0o6e1HqsPj6I4CEiqT17AVipQOYMciHMwzzxUl4Wk+psglXD3y7JLyuo/RgVFzpkVNO4lzMiG8q/2c5kE3eoHnwsVRjiXYWQ55OXUUpgtOEngS7aUgNe2mLFufoKVfn5pw5zMpnhbGuaGAXXAex8HeTJBXEmNapg3373XYYreuaS8dsUEVBs7jlFEXUcF3inmIL1UwvX660kWWdOO0SIQz87PfmdDO6gY/1VHRR6km+pIzNfbTauoc+vyE5POixv2I0jiHkjCiWv9hfSvBGjhctzfePA0FD9U2122pbjKo2wJZTAOPuncnbEAj/aUJpTQwfv+6DInmEfykFCHMhapZNGoLKgEkClReg97iemhkFz/zrGnEqA+9tFVEm2nTKV4D9O2r4oKW8lwQT4OfPh/mp8DoR0xlwA9Cg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(346002)(396003)(136003)(366004)(33656002)(186003)(66556008)(66476007)(16526019)(66946007)(86362001)(2906002)(6506007)(6916009)(7696005)(52116002)(4326008)(1076003)(54906003)(478600001)(8936002)(6666004)(316002)(8676002)(55016002)(5660300002)(9686003)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: CAsk9/6Bqi+OXEEOmyZkkLINa7YEKwZ6hlhBMW9TEBoOqxaT+YZ1i86LNYikZ80TN1/xUOV4QwaMRiSLo+9fYZDp/FUkCwsMQXz9fHcOEhPkqI6rx840Tq7oSL2CRL7X1BCACs0gKuXWm7qjyMh3u36aL+j49Wb7B68EApx+eFhapcBHGAOubtIkd/WERzUTfFvQ+sQRK57NZ6S+0Jk0LvYbCtNoTddUj/ji5bIVh+DlBuHwJKffu74BC/o2eVj41CRndl7A4GfgzJrLnfLNkSRRkNFVV6bIrkvsCz/mqPAAeP54jLmSGkj7MhoqaxKR+MeT43VO97q7DhnyM2nZd8Xxhxeyye0+On959LQ8zyTGOB4GvBBrXkNciwzYqyBNJHpG+un0wXHfChghgoNb2lQYvVGsIvp3W1WjHM0e/4bRXDCKhtIfGI6csaRowK/7Qfv3UIQhncJ5VrKSd9+GEI+j5XhesxVHDSldfStE6TL+rh0/UWwtq4PbBWcljqjP3gHMoEIib/aSkWwurfbr3NRO6Hi9icW/0UHsNuPAfhKMan535Hj2EoZf1qpJlfZLo5l0th5p5LympuQr7nmt2g3oYZHFpEjf4Fkmtt8D6repe0NNQOgOH3G2GsUczj0F3z0WyVJjeAA9G4QQOG47dHZWc18nzKBELKh13jQMSDySI+q1pCPmw4SZSm7GFmEcQ53sPPEfnpJw5qAFH0nCarKEdYTyg52kn3kt831N39+6ZbHn7VFvQAx1FZvpx+apw3AKgRylA8q/+K517wgv77kjQOSuWTwq+NjLxQ8Tq0/MBOG2OzQtNOEZ2yMmRm0xBrYQiz9/i0HISmn4idaj0Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: ac81bdc7-6756-458d-1aa7-08d7ed4454f8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 20:23:23.7158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUPIB6mUrNwZHAnsSVjy7PyI4JuADWmuw+XbguQip8pAEPTdbHOKtqpFnRYdNjV/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3461
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_12:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 suspectscore=1
 lowpriorityscore=0 bulkscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300152
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 30, 2020 at 03:30:49PM -0400, Johannes Weiner wrote:
> On Thu, Apr 30, 2020 at 12:06:10PM -0700, Roman Gushchin wrote:
> > On Thu, Apr 30, 2020 at 11:27:12AM -0700, Shakeel Butt wrote:
> > > @@ -6106,7 +6107,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
> > >  		}
> > >  
> > >  		memcg_memory_event(memcg, MEMCG_OOM);
> > > -		if (!mem_cgroup_out_of_memory(memcg, GFP_KERNEL, 0))
> > > +		if (!mem_cgroup_out_of_memory(memcg, GFP_KERNEL, 0, true))
> > 
> > I wonder if we can handle it automatically from the oom_killer side?
> > We can suppress warnings if oc->memcg is set and the cgroup scanning
> > showed that there are no belonging processes?
> 
> Note that we do remote charging for certain consumers, where memory
> gets charged from the outside of the cgroup.
> 
> We would want to know if these cause OOMs on an empty cgroup, rather
> than force-charge the allocations quietly.
> 

Yeah, good point.
