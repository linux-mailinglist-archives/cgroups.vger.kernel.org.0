Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAB21511E5
	for <lists+cgroups@lfdr.de>; Mon,  3 Feb 2020 22:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgBCVjE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Feb 2020 16:39:04 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60500 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726278AbgBCVjD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Feb 2020 16:39:03 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 013LaSxJ000557;
        Mon, 3 Feb 2020 13:38:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=z8vaPmr1J/X4HytSD9N8H1eOBNjqroXNsZTca+fabFA=;
 b=ZJ32gcKJsylxcLCrwNW61ytuECYC7DEFHmErJPEKKSaXnxS1cON0QgScjqlRGo3vx7Ge
 IIyCao3+H1z5TRsUEsnnAPjinlzUNf2hYZlkdrfFMSnRWz9JPhbdifN2E/lOiKUQ4cMC
 DsCdK7Avkdn+Dt9nYVTWu478gdlZox0zW7s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2xxm8yad45-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 03 Feb 2020 13:38:58 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 3 Feb 2020 13:38:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mj2Zo9ZviakQtyS1Jr5q/I2RkLqauK2947HAIuIaZK9i7cU3YAJai1sc5pQWFaC/DV+iQ9tP9fScNIBG62fjIHmfsePVIa4w9+M59dnLIPxC0Tko9WKaHvcwQTDnp35QnchzZPE1zorpJqS5JvEf82lYJr2LrY0joBT0LPLFzQuL2Azf1h7dRCqpoJKWSuaEVhC3BbTecF7urcS88c64LuNzqAYO9Xxrlqv2e2cYNH36IPgUhjBjrcFO4hYFm19PVjqTXjVr1RlChy73QOly5sKyNrq61aIM5780JsSdFsP3WmCHazHW08QScLgFqbz4p6ZbtSc7wcwTe9mRNIVs8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8vaPmr1J/X4HytSD9N8H1eOBNjqroXNsZTca+fabFA=;
 b=lTNYhZJLXHKOiWEhWAxPainUfzjsQBpKhWSkgSTj4LtEmvEIF/OlAuYIbNybY5VZlx1+aJHF9VTcASNr2jhMDGiA5KPbNJdRkSUOPrW+J/1xYzFcVsyNwZLnoxMEgJRPuxrHRrgcklzJT7v0XuW6v3dXxATs6esaLU7vHAbRYpo186wyjo4oJINhnkYToxBofWBVtEPxQDDvd9+mRz2QCCuO0bAhP11OTKUpDZayDl9bS6Cv5237PSCKy5nfzwdddhyoks6FTOK1BeFWf5uOeAhk/1pE35Tg3x9hjtouY6uxwCy/OdjXfj9VJfWqNBdG4Qdt+bIwr66zGcQmHokZjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8vaPmr1J/X4HytSD9N8H1eOBNjqroXNsZTca+fabFA=;
 b=SVQPYrnGz3eqv0qKmSV+29OOP26Gbrh0mJEfb84yT5WMAPcLGf1Br7yRdyXezB2wlpFrlQgSHbC+t7Q+4pzRaRxW2wFbdzT23p1T7yP2QblX7T3u2Hzb7cA4g1iPKqflWt6A3lTLRN8g19miqppKb8sOYpgU+Mz8eRImhRir+cI=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB3271.namprd15.prod.outlook.com (20.178.207.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Mon, 3 Feb 2020 21:38:54 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 21:38:53 +0000
Date:   Mon, 3 Feb 2020 13:38:47 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, <linux-mm@kvack.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH v2 1/3] mm: memcontrol: fix memory.low proportional
 distribution
Message-ID: <20200203213847.GC6781@xps.dhcp.thefacebook.com>
References: <20191219200718.15696-1-hannes@cmpxchg.org>
 <20191219200718.15696-2-hannes@cmpxchg.org>
 <20200130114929.GT24244@dhcp22.suse.cz>
 <20200203212136.GC6380@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203212136.GC6380@cmpxchg.org>
X-ClientProxiedBy: MN2PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:208:236::7) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
MIME-Version: 1.0
Received: from xps.dhcp.thefacebook.com (2620:10d:c091:480::a012) by MN2PR05CA0038.namprd05.prod.outlook.com (2603:10b6:208:236::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.11 via Frontend Transport; Mon, 3 Feb 2020 21:38:51 +0000
X-Originating-IP: [2620:10d:c091:480::a012]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac127476-1506-4da9-7091-08d7a8f17739
X-MS-TrafficTypeDiagnostic: BYAPR15MB3271:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB32717DCB538BE6CB4BF7D761BE000@BYAPR15MB3271.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(199004)(189003)(55016002)(33656002)(4326008)(86362001)(66476007)(9686003)(81166006)(66556008)(81156014)(2906002)(8676002)(498600001)(6506007)(8936002)(7696005)(52116002)(66946007)(966005)(16526019)(6666004)(6916009)(54906003)(5660300002)(1076003)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3271;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M8plOMuwYcDyRIeMo0wwtLrs9UAYMu+22K9VJi7JxM4YHXjeBlU/hdeyTSFvLFmgVA9D6wQ/zy0PojKQhKvjctYG0w18Xe0jy4IowZ3S77KCZsLlZFBz1dJQxUCP/jisJRH1nYcHX3DwZbEf2RMNf+ZwKBrfiJtT/MpDHbbbw2HpqYC8yx+g2KeJTqjZ8Rx0060d3IwzpXJROUEC+Na/JBH4f4TSjcKnFLgYBA/K3v5qmHzLkBIZTcOPG3XG7OiI8g9FhyQ7N3kFO/ytqXsGjOc4+r6Z3e/i5HWKWkZ3huqEpv1qYwhunaIW7e9Pzs0deewI9bEtlldiTPoxxqSgBf5I5wwEEzzoS4wHB/A2vDfMVJxR4eXxayq8hniyiXDQFbmhTTLzAst8WjStUTI6Vz9v6VBGoiEaePo79xQsctn7KtTF7GI9VRl+A+/bMzCTHIEFooosxVkI6ZOdBxXl3IGLjcehKpPRO5+tKFj0vkEd7V2fxcT9D7Ki+XFw44+jSE/n501rxuZVUmCHZxIu7g==
X-MS-Exchange-AntiSpam-MessageData: y+1OgJ/HnihKPzlqR0988tR6RJ6eiSCgOrMtSLZ3D5wLYfYPE1izxDXxpr9ggbhOTrvj2BZlsu8t9szbENbuNXTJgkR99Phz19/aBk9Wpui7IPLDpjf0Tjkr7aHoA1qSMGw3dMgpAqonMomj60EbrUVFAF4sG1kmC2XbUxhqR8c=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac127476-1506-4da9-7091-08d7a8f17739
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 21:38:53.8871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87JvDyJNFQj2RGdRZD5JES4ip1OVaNRLPT19jShiCtab1CJE9Nu8RCGlplKYmnfK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3271
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-03_07:2020-02-02,2020-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 spamscore=0 suspectscore=2 mlxscore=0 mlxlogscore=858 lowpriorityscore=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2002030155
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Feb 03, 2020 at 04:21:36PM -0500, Johannes Weiner wrote:
> On Thu, Jan 30, 2020 at 12:49:29PM +0100, Michal Hocko wrote:
> > On Thu 19-12-19 15:07:16, Johannes Weiner wrote:
> > > When memory.low is overcommitted - i.e. the children claim more
> > > protection than their shared ancestor grants them - the allowance is
> > > distributed in proportion to how much each sibling uses their own
> > > declared protection:
> > 
> > Has there ever been any actual explanation why do we care about
> > overcommitted protection? I have got back to email threads when
> > the effective hierarchical protection has been proposed.
> > http://lkml.kernel.org/r/20180320223353.5673-1-guro@fb.com talks about
> > some "leaf memory cgroups are more valuable than others" which sounds ok
> > but it doesn't explain why children have to overcommit parent in the
> > first place. Do we have any other documentation to explain the usecase?
> 
> I don't think we properly documented it, no. Maybe Roman can elaborate
> on that a bit more since he added it.

There is simple no way to prevent it. Cgroup v2 UI allows to set any values,
and they are never changed automatically on e.g. parent's value change.

So the system has to perform reasonably for all possible configurations.

Before introducing of effective protections it was way too defensive:
it was super easy to disable the protection by exceeding the protection
value on some level. So it wasn't possible to rely on it in production.

So disabling the protection in case of over-commitment isn't a good option
too.

Thanks!
