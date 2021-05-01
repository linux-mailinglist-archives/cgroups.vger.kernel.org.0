Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE1437050C
	for <lists+cgroups@lfdr.de>; Sat,  1 May 2021 04:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhEACtX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Apr 2021 22:49:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62864 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230298AbhEACtW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Apr 2021 22:49:22 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1412fPg4009220;
        Fri, 30 Apr 2021 19:48:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=C/sFAij332rEaFy6Rcoz4n2CUwTUauOehHTG9fPYGiA=;
 b=WyJKnOK7ICEAjadulBhL68LjpqhSFxsRYb3NGkOQ0PLdNCAJ+K0p261ruDfaHld1g9Dq
 Qn3xKlUmdGURq2YQsNcR5cQt4gzThO2isEY2bl9joIbOEWvU9M7p0EDucAagZMDhmHXY
 BC8ySPiNa5JXWp4VYntBjRyLqvAqGqDJYVU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 387uduuhy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 30 Apr 2021 19:48:27 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 30 Apr 2021 19:48:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bx4bXFCe7jY3yyqhhEd84yvqvidS68IqZj1WJ8Rtms13LOhd8VXGBDaS848uz0KQ5Q2y6f23kp/m/c0qIl/OY5+pOPfrXKlgC50T8HTG3i2k5MJdLoUYkpfm4rcVfWkmH/BEMmyQq0qg81JYd9AZZLJn3Dp3s3naYeAS13WtddCGWe841wF7wQa7i055s+pde0C2phZNTn8Tuejd21Pdf6wnKHwlbnwAb5Mkw+TIDkyvjqv7xHhQP44grZbVhrgdLeyyApJBicUSfllRrwaiNUiHHlGwXt/JP6EAChJeKebqqp//IDbHicAq73B0ZTruLgN6YJJcPpwiUovQJ+ps1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/sFAij332rEaFy6Rcoz4n2CUwTUauOehHTG9fPYGiA=;
 b=NA5TPLrC/NuDtNNARP9hnJRixFw1ztIcmT5PMbqSSbA9LPxChEDGKh8MaWJKZ8k8WprR2X9y8Y9O+ofJKelcwk7Lob4uLpNy/crRXIwuou9tiXER9Zq2E3PgpoP6MVzF2QnE+o0prbEKpnJSDTPLTthoHHRP19A1R8RurZpWZ8OtAU67WCgDK2H5N6Q4te7I/rQMWb6oYUxiW1tVnKky/XlXzSgyTHprWh+wKYNQQOFyp1xgrx/B5uPAYEo38FIDOgO8jicr+0Uy80Wintykx7BTZe5ztRBMDepXwNYCr/Xr8PFnH/oj/N8p5iH10djOkhzbbpQyHUEfeVU9174uQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: ubuntu.com; dkim=none (message not signed)
 header.d=none;ubuntu.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2664.namprd15.prod.outlook.com (2603:10b6:a03:15a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Sat, 1 May
 2021 02:48:24 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4087.035; Sat, 1 May 2021
 02:48:24 +0000
Date:   Fri, 30 Apr 2021 19:48:19 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
CC:     Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, <cgroups@vger.kernel.org>
Subject: Re: [PATCH 2/5] docs/cgroup: add entry for cgroup.kill
Message-ID: <YIzBc5IgiaIFykc5@carbon.dhcp.thefacebook.com>
References: <20210429120113.2238065-1-brauner@kernel.org>
 <20210429120113.2238065-2-brauner@kernel.org>
 <YIt32/aQJfkw53ic@carbon.dhcp.thefacebook.com>
 <20210430065036.uinuugxw6dhdqytc@wittgenstein>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210430065036.uinuugxw6dhdqytc@wittgenstein>
X-Originating-IP: [2620:10d:c090:400::5:ffce]
X-ClientProxiedBy: MW4PR04CA0112.namprd04.prod.outlook.com
 (2603:10b6:303:83::27) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ffce) by MW4PR04CA0112.namprd04.prod.outlook.com (2603:10b6:303:83::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.29 via Frontend Transport; Sat, 1 May 2021 02:48:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8afb0bdf-a803-4439-e4df-08d90c4b9686
X-MS-TrafficTypeDiagnostic: BYAPR15MB2664:
X-Microsoft-Antispam-PRVS: <BYAPR15MB26647293B189A1051801E81EBE5D9@BYAPR15MB2664.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NZOEwIc/QL4iyWML+lN3DgLdXAv0RfJGteSkRNd9sf/ddgmXbawO9O4RfTAatK6c73pvVjZ0GRGWRGj/Dz8bEYG1QADSUQtxFsMqRLiztqwNKekQp1SGoOXuOTdHfs6kr6r3+1SaGiTuKg3Tm51GAQ8n0b88UQsK0EtBXhHd46ptI+RQaqBWQepk1VuT/AL0RgDSs+O0OWu9iK0TJOBKt6PIrlRkPyi4H3MMBE/Q7X/ZPXF8qMA4vqdPLomctk67qLAl3LwueAyaVBigbKpCuQlANI2822j6mKQqNWvAdunZisS2nGY6Gqodnuc+PLjeJSYD8f7QBeio1GVzmtUq7G/It1E41jkBhB0Q9UhEameF0EbYq/aCUS1x8e0Rbkg0zFni+QIWMIiBdzNcDHmf24vKxQ3bKSt8f2K4v62stLVpE2ZNF7U/7fAkiP+ENsXQSnXEZ2cE7wmXSZX9fqXeHuGAi/aE99/qsiEyYL0sw5cqM6jDbPRf6Thiw3j6wIYWZw0Vn6293mu48MtXMOn7eZsuyL5CjOEoyBUvS92NoVUm/bvaCFXmiMJAEWhu6NV/lsPXl5q6otJvy+JYXNiWfjYiNLTt/x8l6rzyvEEiVRU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(38100700002)(8936002)(2906002)(5660300002)(7696005)(6506007)(55016002)(4326008)(66556008)(66946007)(54906003)(316002)(6666004)(186003)(52116002)(9686003)(86362001)(478600001)(66476007)(8676002)(16526019)(6916009)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2Z3vnSFXLTI2MoKDn4e75ARtHAjRK72UAm3Y5oeB0se9oQ6eI/b6naPU0dh7?=
 =?us-ascii?Q?IbKOyvN9muOFmL2+xlMZxPA9WDJm8GmQiSum4Rqgyu6u0ibMdqKLqmSUM+YJ?=
 =?us-ascii?Q?LtqkSXPwrN6nTqqvMg3mN5N/XlJLULUDw8L33xgHLr5WyfmJiPhhTrHrP9xd?=
 =?us-ascii?Q?igLP1ns6FSuZCiOuUUKEM22KVS8g1Aarbx7bTiDzXeltrJBJVowrJDuDC70g?=
 =?us-ascii?Q?+aQD7ccu+XpwafDeCErn+MbZgGIeZxDAW8EpSLvQ5aarqKCMm2Bz7g+RxjCJ?=
 =?us-ascii?Q?7GpU/DMc4MBkAncRTm7EdXwqkK67+rhkqDgb+hgFpZ80Dc2QZAh5bQuhNBil?=
 =?us-ascii?Q?Iz/xn/7bAgCrc9mYSPMs0HXRF8SPxAC+4bM+FF+pmUSyTbOM6cMZlhiL0JXo?=
 =?us-ascii?Q?tGqCxchzYxQiREkTkHtdPGSPvUYYzQi8QHNJpBIODB4/PQG1oSc78I6r1WGu?=
 =?us-ascii?Q?T2DUb21ehi6LOEacPyt/s+UHjL4rTvQGUaV5xfwQqrqaV+9u02DvWpSdW6Q0?=
 =?us-ascii?Q?EURb2VnLQSFyPJ81q+lhYtvnUp6HXkPxt6jZPgBWfkmPsu2pYSu+goENfIFn?=
 =?us-ascii?Q?X+LbFScjOnOIrFdFyrFkMHXR68+HeLSd3Kf+43xL7hktA18qg2XZw4Z2ocGn?=
 =?us-ascii?Q?qVcWMvWt3ibhaI4RsdXZTk5tWMYzIEXaenexBji60F8DwbF5bn/Dcq2ktprj?=
 =?us-ascii?Q?tu/gHgs1Ko2wWQIbdEyoukBfss062uRIGfCfX+rYAC0Kjr4bdSdbJkmm6k9U?=
 =?us-ascii?Q?nhS0bCloMCbT6Qdww5avEd4uKwURVzMUELMrrVd7JeIq6UaG35vDCiIYA4XA?=
 =?us-ascii?Q?gy8D5awteZsuKcyque9CwL9uVdWHWlDK735RuWwMgbmcbGFjAfasPOPA9iay?=
 =?us-ascii?Q?HiebrwsltW6dgTzNyZ0vT9OMWIcAuPCOxflKPDP3q88ja5lZPFhdgLC+pyqG?=
 =?us-ascii?Q?Qjqza04UPk4NFwxAZo/3f/gXdjMcy5AtPVZ3opZEVumcUrd+a6+YBsNZ1z4y?=
 =?us-ascii?Q?+0Exyyxdl24vDcJwM/5xNaC2t8ZKkQ5hkHBFffsEx9aIOqoWJ5RxnqEWGbpr?=
 =?us-ascii?Q?sf9LiySowbmgFEAZpKqIOwIx6TnPp7WkWCt/6mwEqCtHMG5yBPu98ZaEQoMr?=
 =?us-ascii?Q?c1eQZLPRHUPxcs+bOolRir1Fi5V2LHniLVvB9skkuPt323UrnpSKcyuH7oNr?=
 =?us-ascii?Q?jQGh/hAjxTgSzuPeZgKN9kDM8yTftCaI5+8u9HGK/wOw/9vaBAQWRu91Skgo?=
 =?us-ascii?Q?++7z4wbIRUUemBPmObfCLkGht/6aChrLWs3ksvQxME7O/2yS7kKhdYX08g/Y?=
 =?us-ascii?Q?nPPu0JbeBDOo3ySy7Qs8//klaReiGGhoZhyh4jK0BkUnNw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8afb0bdf-a803-4439-e4df-08d90c4b9686
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2021 02:48:24.0137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02WJa4XPy/zR7wRxcS2HfwpnREkE4bJ9ex5wdlpMVTxMQyg9xtqdswEmj6/mcwxv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2664
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: lZuVhFGg2d5w6epQG3icOYsip4xD0I87
X-Proofpoint-ORIG-GUID: lZuVhFGg2d5w6epQG3icOYsip4xD0I87
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-01_02:2021-04-30,2021-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxlogscore=856 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105010017
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 30, 2021 at 08:50:36AM +0200, Christian Brauner wrote:
> On Thu, Apr 29, 2021 at 08:22:03PM -0700, Roman Gushchin wrote:
> > On Thu, Apr 29, 2021 at 02:01:10PM +0200, Christian Brauner wrote:
> > > From: Christian Brauner <christian.brauner@ubuntu.com>
> > > 
> > > Give a brief overview of the cgroup.kill functionality.
> > > 
> > > Cc: Roman Gushchin <guro@fb.com>
> > > Cc: Tejun Heo <tj@kernel.org>
> > > Cc: cgroups@vger.kernel.org
> > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > ---
> > >  Documentation/admin-guide/cgroup-v2.rst | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > > 
> > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > > index 64c62b979f2f..c9f656a84590 100644
> > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > @@ -949,6 +949,23 @@ All cgroup core files are prefixed with "cgroup."
> > >  	it's possible to delete a frozen (and empty) cgroup, as well as
> > >  	create new sub-cgroups.
> > >  
> > > +  cgroup.kill
> > > +	A write-only single value file which exists in non-root cgroups.
> > > +	The only allowed value is "1".
> > > +
> > > +	Writing "1" to the file causes the cgroup and all descendant cgroups to
> > > +	be killed. This means that all processes located in the affected cgroup
> > > +	tree will be killed via SIGKILL.
> > > +
> > > +	Killing a cgroup tree will deal with concurrent forks appropriately and
> > > +	is protected against migrations. If callers require strict guarantees
> > > +	they can issue the cgroup.kill request after a freezing the cgroup via
> > > +	cgroup.freeze.
> > 
> > Hm, is it necessarily? What additional guarantees adds using the freezer?
> 
> Every new process that get's added is frozen. So even if the a process
> ends up escaping the cgroup.kill request somehow it will be frozen in
> the cgroup and can't itself fork again right away. So you could do:

Right, but how it can escape? I think one of the main reasons of introducing
a dedicated cgroup.kill interface is to avoid a necessity to use freezer
as a synchronization mechanism.

I'd just drop the sentence about the freezer here.

Thanks!
