Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39742AC313
	for <lists+cgroups@lfdr.de>; Mon,  9 Nov 2020 19:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgKISAr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Nov 2020 13:00:47 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54860 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729987AbgKISAq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Nov 2020 13:00:46 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A9HxONh027922;
        Mon, 9 Nov 2020 10:00:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=X4D8oL7DS3umIxJWzscItQ/Iato6n+wr5sxRrOHo1to=;
 b=ZxmuIdRG1zD4j1Sw0Doq7wtkaZGtlVLbjDOAtkKnYMPytUiODNhThzkNgAhJ+Hm0KvpQ
 NXkTi2jgXQ5ZWCeLn9w7VNKSJ/6kNJdibNNDGQJot5Pf+dwE6LlPSRXoZ53UYcRosGdS
 swTx/T1amuMHlc7qgnAjURAACapDM5NibUw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34pcqs5xtf-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 Nov 2020 10:00:33 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 9 Nov 2020 10:00:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GF9X6+ag/+GwC23wel2eWFVTRynRQjZYMGNFjenbyGIFAl4FjrbzOshkEq/x2ynaV01et0ykNUMpAEx/9A9yrpbrbT3sT9RKHvXdlzGLdnGfXf6zoAknetjNproZ/8a5UAqrL87QJTGr1n8en+AJMVl3TEqK26mUmM80z6KUM8XKb1hj2VAQwNtO2gE14dy3Lu4zuuhR2f37CA4sHEkvXqd3n/kIvOul2gUvosurgu4KPVPIkwcrm005D3nHnh/HS8UhEU4U/Q6/5nMYFXHGyn4TlDGrnnQqR8TK+aIU0b7TVHjZkB+RYZFPO32n0K2LctYDUIduhKMoiYNRybYENw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4D8oL7DS3umIxJWzscItQ/Iato6n+wr5sxRrOHo1to=;
 b=jBOToBuwxN6+1NIBll+z/8J3q9hIsCBCbI8RW+26kiirVM/BDI+qrzS5D7zel6zxmHHn+kt2XlgH73ugOVDd+87LhgaLxyMy9sqv54JK4PfywhMSA6MnYsX+4SkofryiSkwHtkZsTK3IdwfFPfYJmJANc68c7m+K0eaXvvm4VLZZf39Ux7opBNTQhlNCScjUijUhzyCQ/8qZi+RboB/aOBy6xbE4iTZ1SDpIvAF76OBdfR2KZ2ErtHG9LMinQ1I9bHQ3VVqR+yYiizaJbA++/Xcryy0VCrWWRVlh3ZsshD8+Cr/ExYvkj7qKJNDAv8mDmAvrxXwRcYNjaaxEAfXd2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4D8oL7DS3umIxJWzscItQ/Iato6n+wr5sxRrOHo1to=;
 b=AVyvgduDKdLh6u5MJhXK3UAzO5zUsmC8Uk1TXY1rpHjZwxcq7UZR0Mi0maqxm4sKHoQPuRSxwTsmY8TxEnhjcyrk5BXM8lLxctNQz2WW4HHgpm0wHcq3c3sKGMu92+k/PFFFC27IivKDgK+rQSUBk5T0DNWZ7IXcUTtcHcMix18=
Authentication-Results: 163.com; dkim=none (message not signed)
 header.d=none;163.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3141.namprd15.prod.outlook.com (2603:10b6:a03:f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.23; Mon, 9 Nov
 2020 18:00:27 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3541.025; Mon, 9 Nov 2020
 18:00:27 +0000
Date:   Mon, 9 Nov 2020 10:00:21 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Hui Su <sh_def@163.com>
CC:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <mhocko@kernel.org>, <vdavydov.dev@gmail.com>,
        <shakeelb@google.com>, <laoar.shao@gmail.com>,
        <chris@chrisdown.name>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm/memcontrol:rewrite mem_cgroup_page_lruvec()
Message-ID: <20201109180021.GC2285866@carbon.dhcp.thefacebook.com>
References: <20201108143731.GA74138@rlk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201108143731.GA74138@rlk>
X-Originating-IP: [2620:10d:c090:400::5:b4d0]
X-ClientProxiedBy: CO2PR04CA0094.namprd04.prod.outlook.com
 (2603:10b6:104:6::20) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:b4d0) by CO2PR04CA0094.namprd04.prod.outlook.com (2603:10b6:104:6::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 18:00:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f66f729-dd98-4b3a-7736-08d884d956c7
X-MS-TrafficTypeDiagnostic: BYAPR15MB3141:
X-Microsoft-Antispam-PRVS: <BYAPR15MB31414D6E4269978B98CF3C9EBEEA0@BYAPR15MB3141.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WE6/0Jx31C3zssjvvQsBkHgBMIIwpii1+mxWHJUvCf4hdQTipspwkOluo7uulrtvdot7Xz2fcncRcJkXzYVntPajToTsjiLhWLfy0qMY5meCnTAUHAei9sjraIoL/Hz62I9cHFWN0a9BuPNwbT86VyuHVehfeFoeWFwzKVl5ec+rta8o3espXaOc27Fv0YdteU1BsHIdV7S/fmxiOb3giVy9N39V84Bz6tCkhHUoWlrQM8EjKroFLpodjAJpZ48Bsl8ymyMEAzA6moNmPnKNrGDBsoVeHsdxtcDSupzC68i/T9IZmBvpZU718JWgUbis2etmTc0x1iVgr7zsX4MgXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(376002)(396003)(366004)(1076003)(6666004)(4744005)(6506007)(52116002)(33656002)(55016002)(2906002)(16526019)(7696005)(478600001)(7416002)(186003)(9686003)(66476007)(66556008)(66946007)(316002)(4326008)(6916009)(5660300002)(8676002)(8936002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ssGh4Lbv0IHfRaLE+KDA0ztdtpPNAflzrS8mlGuezDRTnz44ph4UbvEKng09YknGPfinLUrdeCY2l+R/WqATvWbUe5AFbd2iayzKVcf//mH26ux5eyLJ1R00/EJpKhv63fkwgZD/aSsA49mr9ggccxFlXzCLPtlMDobtCjuCXOmOvfTQ/tZxaq4gTpklunJFn3UXAElUQYShXyLL0VTPfnUf80gbD28DmVgfKBr+FUWH4qAbalROPTj7Xd/diJGYp0Ow1WCQE07mlHTo5Ncye0dijXP3gJjsZqKdvG0GaQPfq53fatWCyjwMWN7dH9cSdflcKqQoHSffGvv1MQmn2k2XF4mKVq0xWzpzxB0bMqcC6ZlARbaOdJ+j0vag0Burwy7Rq5kRHuvlNsfnsL+yWxhmuPMpsyL2xTrIC8nsk7AogrSpotecADkVvR+s1pqhURxtNOkFWCzTwyaDgiEOmEf9sl6Jk5RLzDVKvaD8TpBSWocjQPTk8xCPhm1g/MsosrbHl67o4Jp3QvhI2SN85qvOG3hwV70YlXmgYHpWnqiUog3i1B69LsewL+bTdW3ebrrPd3a5a1DK7lYUaoN0+8fYc6FXD9+9WqDrSKFMWwbQQrkXabGTZrJurZHCWGYKYi2iCOUbV0uHnFXn/bJ6n/gd+/hlVhHS/8VGal0YtG0=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f66f729-dd98-4b3a-7736-08d884d956c7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 18:00:27.5115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1q6BkfStgC1tovGj6rcfsMZQoL1cEG6h4m8egd+hoR6V12WBbtdcK6k65IhlwQH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3141
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-09_11:2020-11-05,2020-11-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 mlxlogscore=848 suspectscore=1 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011090125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Nov 08, 2020 at 10:37:31PM +0800, Hui Su wrote:
> mem_cgroup_page_lruvec() in memcontrol.c and
> mem_cgroup_lruvec() in memcontrol.h is very similar
> except for the param(page and memcg) which also can be
> convert to each other.
> 
> So rewrite mem_cgroup_page_lruvec() with mem_cgroup_lruvec().
> 
> v1->v2:
> use page_memcg() instead of 'page->mem_cgroup'.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Hui Su <sh_def@163.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
