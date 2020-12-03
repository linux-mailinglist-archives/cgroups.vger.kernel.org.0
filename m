Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911512CE03D
	for <lists+cgroups@lfdr.de>; Thu,  3 Dec 2020 21:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgLCU47 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Dec 2020 15:56:59 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57758 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726920AbgLCU46 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Dec 2020 15:56:58 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B3Ko4DL012258;
        Thu, 3 Dec 2020 12:56:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=facebook;
 bh=lZhekP6mzoq30SS4PB0VYyBPLQxAcW7fNLlIOLcDDXM=;
 b=myPDnIJuty09/yxOTKYj6q3XsAPVorxvakhG2bLvi2Fbve1i0ZhL6TZIbwhvLc5JO3AZ
 Z6O657zCLOIa1p/lDfu+dAJDt4B72aDOZb6bhEgwMwqTzPbnDB5Rt7OAaAjKe1XU0C0K
 Ke2hd1FZhwMx4kSCa4rWwp0nlSa+SM6EvuU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 355vfkgmj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Dec 2020 12:56:05 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Dec 2020 12:56:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDku5lueWvX4KsxqwD3cRi03MsEyBH5VdUCTbV6ZDqYwwBJ0yHu+NeGvvLvG1kMU6LAI51kxx8KRtY3QL6qrP7BNbAIfPUZ8v0hCJgFiUtSwRd5EkNk6WQTiiZS2AeFiI2FR73CNt1wy9Fk7+j7CGH60tFAgDSzuLXgNetTmYjyRI0BOwl/ZN8TwnrbdNrk52F17MDIim+SGDkQontD3+CNhffVIAKtf9klWeQzwgoEPj82l86PCqUI5hJ/LL02fOjGDyefL+vScm4uQPswl/wc4KQWQgRSycsudeI4k7M/0JF6+YP8UTlGs90ermhMN8WmJXatjwO3RTh+LYXTsMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g64YEGb67PwKMMN54hySbYYWQ254ZpUKKU3PgzcbiM8=;
 b=HeduWMommsPTsloiBgJKk2W0BHz3LVYOwbITT4ra6ymkXogngL+WXoEGrYG0tT1eQaYiBMsLUiF/BQqTuhhewUVeH7p0xjL/1jJSWksF1JdXwmlR5GX6Zt1NMFFOWeMSmSDE8TT5bXja5+A6SImfP7hraUAMJs3BG175TiC2eN2SKeADe1Qz83dXYSPewaZNdE3J9DEk8PRBJRRqLVOJjRAWQ7Wc9F3fLMLGDYLPe3hFq33BxkA864JB9Elh08vuTjNKGBGfcJM76X9oumCAerB0nIoeiIKFV0B0sDJN2/juipLPTkh/oHrPJQWrInHtSeWGErYmOJerZ1p0urrcYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g64YEGb67PwKMMN54hySbYYWQ254ZpUKKU3PgzcbiM8=;
 b=IBj9L44tANL9OUkQQq4U3ZcZIHkxaHjyy6ZOG41w4QKjYe/xZ+x5hU+udmyLsIaiFpAlX3PjMNWL3VtTsaWXP4R9dKWdnwx0SJ/JWPJieSFbdPfNg6gBnQ6kYHj2/yFp7linhyWNsvxjxzxz8dlTJ4seWyWt/kEGjo3rbyYmZqo=
Authentication-Results: linux-vserver.org; dkim=none (message not signed)
 header.d=none;linux-vserver.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2871.namprd15.prod.outlook.com (2603:10b6:a03:b4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.31; Thu, 3 Dec
 2020 20:56:03 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3632.019; Thu, 3 Dec 2020
 20:56:03 +0000
Date:   Thu, 3 Dec 2020 12:55:59 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
CC:     Yafang Shao <laoar.shao@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: Regression from 5.7.17 to 5.9.9 with memory.low cgroup
 constraints
Message-ID: <20201203205559.GD1571588@carbon.DHCP.thefacebook.com>
References: <20201125123956.61d9e16a@hemera>
 <20201125182103.GA840171@carbon.dhcp.thefacebook.com>
 <20201203120936.4cadef43@hemera.lan.sysophe.eu>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20201203120936.4cadef43@hemera.lan.sysophe.eu>
X-Originating-IP: [2620:10d:c090:400::5:fcbd]
X-ClientProxiedBy: CO2PR04CA0189.namprd04.prod.outlook.com
 (2603:10b6:104:5::19) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:fcbd) by CO2PR04CA0189.namprd04.prod.outlook.com (2603:10b6:104:5::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Thu, 3 Dec 2020 20:56:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9672e2d2-20b2-4b38-a1b6-08d897cdd8e3
X-MS-TrafficTypeDiagnostic: BYAPR15MB2871:
X-Microsoft-Antispam-PRVS: <BYAPR15MB287163CA826BD4CDDBC4A8A6BEF20@BYAPR15MB2871.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6YAf+GznefamIL+YhFr5crY+gxpMm1Lf8Wbq1MwhsiAh4Nqm/VVV7FzgI/4CDpmojIWYFI070a31V/6e29813U82gdh6xAVlS6e0KwTRqp0O0nyHEY0kmtXqZ8/m4fkrVotbjq3buvRzs9sLCKY5bijWfkpEro1X/ell8WsBlZ5ztZ/Tottc0O1zKDTCz0yNKcslB2f59iwGKJWABOQh+dRKh6Z0kmH9VAPoWvLql/4O/RhbuDq9ttGaTGVQaBr2aRKuHm086vnYXGXdtCXaE8SZy7Q/btKuZ2xYw4zapxLMuO813P+Xiads/1gJuS2vVpy1E5WhIlyJQp+iD80lJ9HID8yVjyp8Zr5sdrMp6RN+KTguzjJYDzSJd3z3SUN9rqUUWHnEoItlXWvCvULp+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(366004)(136003)(396003)(8676002)(9686003)(4326008)(6916009)(6666004)(8936002)(316002)(478600001)(66476007)(66556008)(55016002)(86362001)(2906002)(66946007)(186003)(7696005)(966005)(6506007)(16526019)(83380400001)(66574015)(52116002)(5660300002)(54906003)(1076003)(33656002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?v/Lm1FoxUuctWbj2XIfHmbwCqI3rpZULsF6vjto35KFjzeFu4Bw4/cWmAC?=
 =?iso-8859-1?Q?3UBC354wwIhu85nv3eikOrWARHzBPxzGvM3e+lYS+Ah+NG7rczm1z7HJru?=
 =?iso-8859-1?Q?5MbSlTRB84UpLzyOpN+J2n82d/r6Efwf2j2kq+NutP5nwq6Z80GPn7EBTx?=
 =?iso-8859-1?Q?flDkn/IMLZNr5rzeaQHA3PaWk6KS5oIgqRJxnDrvPHZHX6NbNFgrJgf7FK?=
 =?iso-8859-1?Q?8PvXwitXGuP/E2NSadAq3vMZM2SI6QegFr/t3N4+jcVWxCs/AWcYtiFZwg?=
 =?iso-8859-1?Q?zMi8ROVnLE8p/j1zAaFtI0URVFEypvTetx6hqZ8CKFjdpHiw/bTCFX1os0?=
 =?iso-8859-1?Q?s8U6b+M1lahJD2PhgIThhSxnMmB95btcmUZJUDXUaoWGRLGuticM1JFaID?=
 =?iso-8859-1?Q?OGJ+4GLEQnzcZomWB6WW0tCw39ZgOIhCwx46CION0BZp0jqmuwYBikmqVB?=
 =?iso-8859-1?Q?MSEStza5l/jQcObRxB1G5hctJiaibjwrjieZyoa2szUu7i/MZw/0lhz6Jz?=
 =?iso-8859-1?Q?Q4DH2zNsX8KJbpjLH/IH3aSGbTkuAYvDJpyIg8oB8GsH9qekIm0PAfB/2D?=
 =?iso-8859-1?Q?Y1T6eAc5hX/8MVE7vv2pkNeHDVGkxGggLNNwmHn6yX8SgWe4PE/lFuykQg?=
 =?iso-8859-1?Q?xxt9WqmRG1oPfWw8xI2PK4MjWI85uovLSywGo0Rf+I1127vSbRdnCt5J2D?=
 =?iso-8859-1?Q?Yhoj/3CFuVB/2bDu1yYI8A5xjKliFmcjDEtc1nbIIKr2mLhRB8g7ctGid3?=
 =?iso-8859-1?Q?/ieLqZ8SIx5kcHSKf5QrDmcxuqNKQ1oLXp6Kp5Z/3TPJMfmcctwINe3nXZ?=
 =?iso-8859-1?Q?fJQteZRynWTq4aOycaS9r8k74ePoJ+CuDGmWJdVwFcMoc+APIG6ZUhQQnO?=
 =?iso-8859-1?Q?u0OjTFTXvGjcvUEbLO3Cr+eOgCtJ36B5y7hMssez9vHRH7LWip3l0taf26?=
 =?iso-8859-1?Q?k6MacoLVO+CZsUax+bppQltIf0ytXR5wXkufZYqpWp0d+2kGZNaQoICW4E?=
 =?iso-8859-1?Q?DagI26DacaTL3gFTh20EJbak9khR/Wgdfe2iuHxgeMf/dbEvifjElHed2j?=
 =?iso-8859-1?Q?1A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9672e2d2-20b2-4b38-a1b6-08d897cdd8e3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2020 20:56:03.8250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6K9immVANcTDHlw7dxR9bKFt3jQkiQu9399Onvvh+ptbSgSGs9b2hmwcN+tLlKm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2871
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_12:2020-12-03,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012030122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Dec 03, 2020 at 12:09:36PM +0100, Bruno Prémont wrote:
> Hello Roman,
> 
> Sorry for having taken so much time to reply, I've only had the
> opportunity to deploy the patch on Tuesday morning for testing and
> now two days later the trashing occurred again.
> 
> > diff --git a/mm/slab.h b/mm/slab.h
> > index 6cc323f1313a..ef02b841bcd8 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -290,7 +290,7 @@ static inline struct obj_cgroup *memcg_slab_pre_alloc_hook(struct kmem_cache *s,
> >  
> >         if (obj_cgroup_charge(objcg, flags, objects * obj_full_size(s))) {
> >                 obj_cgroup_put(objcg);
> > -               return NULL;
> > +               return (struct obj_cgroup *)-1UL;
> >         }
> >  
> >         return objcg;
> > @@ -501,9 +501,13 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
> >                 return NULL;
> >  
> >         if (memcg_kmem_enabled() &&
> > -           ((flags & __GFP_ACCOUNT) || (s->flags & SLAB_ACCOUNT)))
> > +           ((flags & __GFP_ACCOUNT) || (s->flags & SLAB_ACCOUNT))) {
> >                 *objcgp = memcg_slab_pre_alloc_hook(s, size, flags);
> >  
> > +               if (unlikely(*objcgp == (struct obj_cgroup *)-1UL))
> > +                       return NULL;
> > +       }
> > +
> >         return s;
> >  }
> 
> Seems your proposed patch didn't really help.

Anyway, thank you for testing! Actually your report helped me to reveal and
fix this problem, so thank you!

In the meantime Yang Shi discovered a problem related slab shrinkers,
which is to some extent similar to what you describe: under certain conditions
large amounts of slab memory can be completely excluded from the reclaim process.

Can you, please, check if his fix will solve your problem?
Here is the final version: https://www.spinics.net/lists/stable/msg430601.html .

> 
> 
> 
> Compared to initial occurrence I do now have some more details (all but
> /proc/slabinfo since boot) and according to /proc/slabinfo a good deal
> of reclaimable slabs seem to be dentries (and probably
> xfs_inode/xfs_ifork related to them) - not sure if those are assigned
> to cgroups or not-accounted and not seen as candidate for reclaim...
> 
> xfs_buf           444908 445068    448   36    4 : tunables    0    0    0 : slabdata  12363  12363      0
> xfs_bui_item           0      0    232   35    2 : tunables    0    0    0 : slabdata      0      0      0
> xfs_bud_item           0      0    200   40    2 : tunables    0    0    0 : slabdata      0      0      0
> xfs_cui_item           0      0    456   35    4 : tunables    0    0    0 : slabdata      0      0      0
> xfs_cud_item           0      0    200   40    2 : tunables    0    0    0 : slabdata      0      0      0
> xfs_rui_item           0      0    712   46    8 : tunables    0    0    0 : slabdata      0      0      0
> xfs_rud_item           0      0    200   40    2 : tunables    0    0    0 : slabdata      0      0      0
> xfs_icr                0    156    208   39    2 : tunables    0    0    0 : slabdata      4      4      0
> xfs_ili           1223169 1535904    224   36    2 : tunables    0    0    0 : slabdata  42664  42664      0
> xfs_inode         12851565 22081140   1088   30    8 : tunables    0    0    0 : slabdata 736038 736038      0
> xfs_efi_item           0    280    456   35    4 : tunables    0    0    0 : slabdata      8      8      0
> xfs_efd_item           0    280    464   35    4 : tunables    0    0    0 : slabdata      8      8      0
> xfs_buf_item           7    216    296   27    2 : tunables    0    0    0 : slabdata      8      8      0
> xf_trans               0    224    288   28    2 : tunables    0    0    0 : slabdata      8      8      0
> xfs_ifork         12834992 46309928     72   56    1 : tunables    0    0    0 : slabdata 826963 826963      0
> xfs_da_state           0    224    512   32    4 : tunables    0    0    0 : slabdata      7      7      0
> xfs_btree_cur          0    224    256   32    2 : tunables    0    0    0 : slabdata      7      7      0
> xfs_bmap_free_item      0    230     88   46    1 : tunables    0    0    0 : slabdata      5      5      0
> xfs_log_ticket         4    296    216   37    2 : tunables    0    0    0 : slabdata      8      8      0
> fat_inode_cache        0      0    744   44    8 : tunables    0    0    0 : slabdata      0      0      0
> fat_cache              0      0     64   64    1 : tunables    0    0    0 : slabdata      0      0      0
> mnt_cache            114    180    448   36    4 : tunables    0    0    0 : slabdata      5      5      0
> filp                6228  15582    384   42    4 : tunables    0    0    0 : slabdata    371    371      0
> inode_cache         6669  16016    608   26    4 : tunables    0    0    0 : slabdata    616    616      0
> dentry            8092159 15642504    224   36    2 : tunables    0    0    0 : slabdata 434514 434514      0
> 
> 
> 
> The full collected details are available at
>   https://faramir-fj.hosting-restena.lu/cgmon-20201203.txt 
> (please take a copy as that file will not stay there forever)
> 
> A visual graph of memory evolution is available at
>   https://faramir-fj.hosting-restena.lu/system-memory-20201203.png 
> with reboot on Tuesday morning and steady increase of slabs starting
> Webnesday evening correlating with start of backup until trashing
> started at about 3:30 and the large drop in memory being me doing
>   echo 2 > /proc/sys/vm/drop_caches
> which stopped the trashing as well.
> 
> 
> Against what does memcg attempt reclaim when it tries to satisfy a CG's
> low limit? Only against siblings or also against root or not-accounted?
> How does it take into account slabs where evictable entries will cause
> unevictable entries to be freed as well?

Low limits are working by excluding some portions of memory from the reclaim,
not by adding a memory pressure to something else.

> 
> > > My setup, server has 64G of RAM:
> > >   root
> > >    + system        { min=0, low=128M, high=8G, max=8G }
> > >      + base        { no specific constraints }
> > >      + backup      { min=0, low=32M, high=2G, max=2G }
> > >      + shell       { no specific constraints }
> > >   + websrv         { min=0, low=4G, high=32G, max=32G }
> > >   + website        { min=0, low=16G, high=40T, max=40T }
> > >     + website1     { min=0, low=64M, high=2G, max=2G }
> > >     + website2     { min=0, low=64M, high=2G, max=2G }
> > >       ...
> > >   + remote         { min=0, low=1G, high=14G, max=14G }
> > >     + webuser1     { min=0, low=64M, high=2G, max=2G }
> > >     + webuser2     { min=0, low=64M, high=2G, max=2G }
> > >       ...
> 
> Also interesting is that backup which is forced into 2G
> (system/backup CG) causes amount of slabs assigned to websrv CG to
> increase until that CG has almost only slab entries assigned to it to
> fill 16G, like file cache being reclaimed but not slab entries even if
> there is almost no file cache left and tons of slabs.
> What I'm also surprised is the so much memory remains completely unused
> (instead of being used for file caches).
> 
> According to the documentation if I didn't get it wrong any limits of
> child CGs (e.g. webuser1...) are applied up to what their parent's
> limits allow. Thus, if looking at e.g. remote -> webuser1... even if I
> have 1000 webuserN they wont "reserve" 65G for themselves via
> memory.low limit when their parent sets memory.low to 1G?
> Or does this depend on on CG mount options (memory_recursiveprot)?

It does. What you're describing is the old (!memory_recursiveprot) behavior.

Thanks!
