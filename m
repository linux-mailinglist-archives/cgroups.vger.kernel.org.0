Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44566332FC0
	for <lists+cgroups@lfdr.de>; Tue,  9 Mar 2021 21:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhCIUS4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Mar 2021 15:18:56 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12652 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230431AbhCIUSn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 Mar 2021 15:18:43 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 129KDO2g012018;
        Tue, 9 Mar 2021 12:18:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=b15VZGEsdp5KSPZp6Etr9P3PCYHsVwaLa8IbfsH2JCA=;
 b=qxZ58tPkhB+nrGTHC8LN/W2p21Ciw2FgEWUrH6AvT9Qu3eAhFk2bYZyKlk/YIJaBK3Dt
 ctsm/lkG36VvTv8TzSJZkJ4X3b76mdB0q1BeRT4/vua9PQJ/6x8DD56BXRH3D4gOZYwv
 omobY96LMmAYygxy7nSFYvpmSBWIP/85U8k= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 374tamw2ma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Mar 2021 12:18:36 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Mar 2021 12:18:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmICj1nJuK/7cqSj70jG1kJ6bWXO++ELgEzR7IaAgn2691XLR8hC/vquMtLy0fnIEHvWcBwWo4NoMaBE2pUaTJqQwOPfoSjtzv9Dooc5Zy44NNwTEr0WiG5H/TeAib51caG3ydiSKmhMGVos21lsWV6YbWFkQfmwWAOX3sOpI27ttWI1tXHQhqoVl1320a7mUu0skEXCRVNl5gIxI9nOBmZVCXFW88hsdAenvSlSjWJemuKZip1BTYAyXxyETHw8htr16VvpYd9kgjGIqHp57d2SRDCkBTDz89/MGTkqCD9A4m3jVpc/38xTupkTP3U3ridOtp2DegYskhMt9yimKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b15VZGEsdp5KSPZp6Etr9P3PCYHsVwaLa8IbfsH2JCA=;
 b=cEKdzva0UDEM4A5vYv83+X8Leckgvj7/ysWsC/kc+TeBVS4G1W2SHk3SurPZJePO7OXf74fr0OG7C4t4xeRCgnLyQqrhd5upseBroCrSEUnvdVstSA1GV8axHFgTV+hEk2iTMjnMK4RcqePm/QSx565PkeQOX691gyuxqiDVWsqzrg8KBuaL8QlPXzv6MFy5eQ5Rf/ViZPPcxhq3m/oPgSpXuGN6eRM6Y0/JZoGVeslALvbY4vmLAhOSpbViiYhqNxu33/DyiAnNxtejbj54UgSXFY92KsCB0hQZzs5qPiEMmgUFZQO0/z2V+cYyI10eubcVYhLPgSlB9g/4g13nJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2760.namprd15.prod.outlook.com (2603:10b6:a03:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.29; Tue, 9 Mar
 2021 20:18:34 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 20:18:33 +0000
Date:   Tue, 9 Mar 2021 12:18:28 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Vasily Averin <vvs@virtuozzo.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH 1/9] memcg: accounting for allocations called with
 disabled BH
Message-ID: <YEfYFIlRH0+0XWwT@carbon.dhcp.thefacebook.com>
References: <18a0ae77-89ff-2679-ab19-378e38ce2be2@virtuozzo.com>
 <CALvZod4QiAhjgQOGO4KYCs4-GjUmqb6th+4tr8nQ+bPumGFzNg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALvZod4QiAhjgQOGO4KYCs4-GjUmqb6th+4tr8nQ+bPumGFzNg@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:1c77]
X-ClientProxiedBy: MW2PR16CA0070.namprd16.prod.outlook.com
 (2603:10b6:907:1::47) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:1c77) by MW2PR16CA0070.namprd16.prod.outlook.com (2603:10b6:907:1::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 20:18:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ed5e811-3710-44ba-ee85-08d8e3388370
X-MS-TrafficTypeDiagnostic: BYAPR15MB2760:
X-Microsoft-Antispam-PRVS: <BYAPR15MB27606D5468318806410AA64EBE929@BYAPR15MB2760.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AVaPqOwWkv7yJJwreAX0xnYBbijelBcNe5dLDgOtrLfDynd6aGB8hlYEyBrQNorHjzhIlMYZR7lINCbvxe7hoJZkhaQqXaVNFSNOkhknDdqey3QQmI4hTb1+MP3EOH+L5fh+nFYZNfxwURSLLzwpYTT49P3cBqTUCb5giX+PEThR4E4GrijFzqX/Joob3uFHYjbHGysC71g3gF3HnqSBjclaPUridHra9sQCpM0aBsWRasBBIHCqk9zdvHyx2Q+CMpi/HRamZT1EL5Jz2GyWChq5Xt3s5h/xw3lZ20/SiJ5RPsqtcr2C/VunFli3wID00+DeyHLYYSI58UE/OQPN188zL0jxpDhodCNNRN6F4O5gd22nUtE6xn/rrBHPW1UPFlL0Cl/zR9vkyqKbELTBcQyVzXMIFM3nq41QBfxlGW5uRq3EqlNOhyvwSC0cCoL/2MWgqLKqGooYVpaUxk1d7PwIvVi5bVWr16ZDM0LhlOfobihBSu9ISQzQwp/GIr18CNhiNFrXV/8mdjcJ7XLxfLXUnz9VctbjnSE9GKAaRwObHv8uNY9e5B1sxNbH8K8Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(396003)(136003)(66556008)(53546011)(6666004)(66476007)(7696005)(66946007)(2906002)(4326008)(6916009)(6506007)(186003)(16526019)(52116002)(86362001)(5660300002)(8676002)(83380400001)(15650500001)(4744005)(316002)(55016002)(9686003)(478600001)(8936002)(54906003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?U6KZpNaovkJtWViUXDsI0pJ13HAfAlRWpwgMGQjQ71IxG5uuf/8aAcDT6LpR?=
 =?us-ascii?Q?n5FNAL98Sok0ZNQeYl5y/Jr2UtOQHrq8gzSLeghxU7PQfJKOpYDAOzm9hxvR?=
 =?us-ascii?Q?nPpUIokxyD2rKbnwSDwqIhCCQIWch7HplVsdCtKJpBCfi3pDiRu1ptr07eOv?=
 =?us-ascii?Q?PolhklZC7SQirJRFxa9k68JwLrjTnOjRG8f/EsULWdcgAu2r9Swj5rUO+BC8?=
 =?us-ascii?Q?l6A98Thb00D5o54cuj3zJeWsoec7jlomHcoe+IxMRFpPAl9/G8vMr+hzvWy1?=
 =?us-ascii?Q?c7svKArwPQ/Uy8/4ykc+KgBsylPjCF9hppX52Kmehp8InnuxJdgWAWBiJmQy?=
 =?us-ascii?Q?hMOYBN68WJuY+5smlI280OUrh2LC8RioyBqGyURvBe4E8xXf7joXWjkU6au4?=
 =?us-ascii?Q?SMht3MOqn04/EgG/dPGOJEshZ/HVcnEONsUTY89IET5qDsMEmhdgRZVgIFTH?=
 =?us-ascii?Q?tX2tC3gvTEjDfgLmNrRDCWiF6xKQyKj9AddHALFPknli8xHIPA3R1YsxvV0F?=
 =?us-ascii?Q?1r5jFsrCoObKBjngEGlCaXM7vi/Epr0Inu9QD6caH9Hkuks2wSGUAmGuEmie?=
 =?us-ascii?Q?ucyjk/2XvgRjPMiE6l7uNM4kqO90vx2ON6TnJkPtj4wgNmJZLCtkAFIDqjDR?=
 =?us-ascii?Q?RzWmMKaTwtpWOF7v3O0b6e43I6pT2i18FBrPkklyAWL3DTicQ6kU3926XFWi?=
 =?us-ascii?Q?3oeJmILzDPtqjASgDOF4/3mw+NFOnUJhx5m4CHbxOQrHFJL7hcK72A5FXoAM?=
 =?us-ascii?Q?7QO15qM3WKGIZyHWdPDOjS3dpLoCTk1yBhokqww3AvfM6k009T7kmD9ZmNFI?=
 =?us-ascii?Q?mHNB/cbmsZDY61gEAy+nVhuP8cJAX9CkyYxb7dv8wBsi9mBaqvycoopjHgRt?=
 =?us-ascii?Q?J0dnu+TOO0cKlWWrD8I/p55V5hr/Uzz5Dv8Lu3ixWoHL55PrrSm9hyNS4+sL?=
 =?us-ascii?Q?iOEIcyZRWXK2aZ3IWICc1Wjp8VvlYRa2sdQq7vpkwk8ysaJpAiU9CKgOyFeM?=
 =?us-ascii?Q?NMLT3A0QLFFaclSMYJZ6NyNTuosZJ28l44c99RnjYQaBiqnD0xMD7EDtF6Vh?=
 =?us-ascii?Q?NkCw33KwVKrkDodsmOLo98JxJQB7f4ITKFepRV9EEf36utG4Hr+HUr2pOb1D?=
 =?us-ascii?Q?feDfFoiN9B9We2filVrefxAiH5BCKehbmcwU0HEYqGdIFvgKqYZ+BvwAMOyQ?=
 =?us-ascii?Q?XGNOlrKJfzdoU8nVSQ1PnHEdgqPweqLgWHEkOMRSk3U5yF4UMzgvQmPVtKfl?=
 =?us-ascii?Q?ySqxmK0glqySURP2RfLLPQTvdi+zur6tUJYd90h6ZNDCMrkwvjkFvE7lV+kw?=
 =?us-ascii?Q?IcxtTOAjWOppRA66QOHJEHd8e8AvSTxWR8EU5hAjb9dvzw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed5e811-3710-44ba-ee85-08d8e3388370
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 20:18:33.7914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFsHNUs/ToDva45ybp3sSvV4yDVJYq0Zxt+vAQhK3nwZdKNHVQhCqavZkYGsEtfx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2760
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-09_15:2021-03-09,2021-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=963 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103090098
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 09, 2021 at 11:39:41AM -0800, Shakeel Butt wrote:
> On Tue, Mar 9, 2021 at 12:04 AM Vasily Averin <vvs@virtuozzo.com> wrote:
> >
> > in_interrupt() check in memcg_kmem_bypass() is incorrect because
> > it does not allow to account memory allocation called from task context
> > with disabled BH, i.e. inside spin_lock_bh()/spin_unlock_bh() sections
> >
> > Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> 
> In that file in_interrupt() is used at other places too. Should we
> change those too?

Yes, it seems so. Let me prepare a fix (it seems like most of them were
introduced by me).

Thanks!
