Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2803A22888B
	for <lists+cgroups@lfdr.de>; Tue, 21 Jul 2020 20:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgGUSvJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Jul 2020 14:51:09 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:21468 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727000AbgGUSvI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Jul 2020 14:51:08 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06LInZ1H030107;
        Tue, 21 Jul 2020 11:50:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=4s+vd1Qc9vSJKOvGKojMsuSCa8vtZBJEKSLRiGpxA3w=;
 b=cDnJ+ovuuciqwx/l19WDmRARlx5xsi75yxvZ7+yvbHmqb5U7LFDS/e3MwwAcvsmrfvTd
 7xvnMf2aQ9AsFEXz/lpZN7ikZ3QQvODpYFEXZv/n0jCjdxIHmmnHjcZk+fJCSgslzgXR
 xSnIvQz498MfVUtpiDRSGufnOa+dp1sk2qg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32bxkmnfk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Jul 2020 11:50:05 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 21 Jul 2020 11:50:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjkCpZ+uZ78KoEI9yIZlfoO/QmfOda6FJZLZo9FQTrzdGV8BlJbxh95JPzV6p9ci8WwckvF0V+F+K8v+u7JLoP/SjduS/SSCV+DGt4iUA6xCzHsFQHwLY3yytu7W+WMMhANvAN8LFeTdBI8MRUR4SzctP4KRKs08T97ksmKvQpoUOktugJe+Ev4gsxbd8Ic+/4h8l9ZV0TVf21CqCEpImB95ozS9j7JA4LSLEQXPihXFf3OFBqkAF++7SLB/4geKpiY0lxxO6kxEiM26akTQetBW51Onp1sFxjra2Qvcr15fPanwe3AVzkYTPT7HOf4nk/Uul8DSQI/mMXJFMLCa3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8M/cBuC1UyRRanrQRIl6K2fS1SHf26nXYrCdKmFdo1w=;
 b=MoCv3QbKUKzj3yhlfgTcDDlATEUI7x2e5xVVQf5wHD4P+QOowDMUdCtWDgSf4Fw0dmC4UT4NUQoqec+YwsoeJ6SBD2EChPE4pol6MQrcyCJc289jYdz5qV2GJRkNiM6YVnp4BH3zFpt6cpo9s8UHuZfOU5lhS6ZUHfv+6tI8W9oo1jWrIYFMcxcvwOlZNyRnUMuIk8NPIIVo0feYQJ9EeFeXdXZRhOT+05Ioqpvb84IM8Q2Et4urrjRQsgCOOKP1XfSO9rj3vkemdfNyUPpsGu3jy2hGkNBPqB2P6FwMcy2WqTXxundmTtHDoXSLXyTpDz8C5nszo757WfMZxMI4jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8M/cBuC1UyRRanrQRIl6K2fS1SHf26nXYrCdKmFdo1w=;
 b=eVR13tM6LmOUJtBI+kf7aLDL7nNl3ZWaG9CrWmDURhrh0/dCO7Iw/VvmvlBmw/d3vILOSa+EJbNV1nm4yp69su+sDf4y7W+GE6Gz7r8s5USmOT/9WGrxu2gxsdGBe+Yrt+/I53fqSesrhdlAIKkPmj6UqHNL5me5gl6cr0oI7X4=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3032.namprd15.prod.outlook.com (2603:10b6:a03:ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Tue, 21 Jul
 2020 18:50:02 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3195.026; Tue, 21 Jul 2020
 18:50:02 +0000
Date:   Tue, 21 Jul 2020 11:49:59 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     jingrui <jingrui@huawei.com>, "tj@kernel.org" <tj@kernel.org>,
        Lizefan <lizefan@huawei.com>,
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
Message-ID: <20200721184959.GA8266@carbon.DHCP.thefacebook.com>
References: <2E04DD7753BE0E4ABABF0B664610AD6F2620CAF7@dggeml528-mbx.china.huawei.com>
 <20200721174126.GA271870@cmpxchg.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200721174126.GA271870@cmpxchg.org>
X-ClientProxiedBy: BY3PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:a03:255::22) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:cfe6) by BY3PR10CA0017.namprd10.prod.outlook.com (2603:10b6:a03:255::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.19 via Frontend Transport; Tue, 21 Jul 2020 18:50:01 +0000
X-Originating-IP: [2620:10d:c090:400::5:cfe6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c79e7a70-b69a-48e5-7f34-08d82da6e033
X-MS-TrafficTypeDiagnostic: BYAPR15MB3032:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3032EF737B208BC0DA8A50A4BE780@BYAPR15MB3032.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x2jkWD3qI4mc8/hZg1GEBqPnjkFz9ig6yl7zx7A/RTjP3rJxGhKV3ZhRtfr/745fVrPfv/dvQF4ISl1pwLl8w3X6+MFeAxYvEl6DOTf3Go4bUnDOs66XEXU4aY3GbbFTlMhojQtImzZtkJr94xAENZfAiLpWxfyeuGF0yjH7DsuRrEsrY985jwHiMjYaJHtBRUhJbAhuvhWooKElBaAX0TOebJ6Ry5eFa6TrHIXlIL/sqrXXO62fxEBzj6LmZrlNcMUtcNxCrzRk3J90nSQ2Y4fqsfwn0z4b8mil9ZtxYIo3yN3NuFWs4A6hA3WoBb5VQOA6X898RBoHi7lxK1YmyIT8tdx29Sw0VPM3pkmLHKb4K+nAjWzRCF+B2Wl1EMHTPAurwLkcTBiTgm4tXzYjSS7fcKeXoWHNLLTWTQTBwslkFqOZRzxojo8gwdDQ1j7N1cYEeXFmwcrhEbCHEfMvgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(55016002)(9686003)(6916009)(498600001)(8676002)(186003)(66556008)(966005)(7696005)(6506007)(66476007)(52116002)(66946007)(83380400001)(16526019)(33656002)(54906003)(1076003)(7416002)(8936002)(5660300002)(4326008)(2906002)(86362001)(17423001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 4WCQOa9sKGotPeizdFQTeUY6x2Q390urivMWNjmmiHgWQpD6nOedb3Z0383f+fhCtgizepreSAs4Hf7ru5OHM6lulgHqoTdiWkyhtheFdrg5pw5Ou0vyKHWFnPWVssW3mgqv5q73FE5bFEM2Bj4IUfPBrsekGQ9hkpWpKvvAPigvMim0ycczmJWV16uPeJR9p+Ydi9nxxdbmsL6BBwd8pxjdKU0SU0k6oUeWjGfGa6ULm7TMF4FlhKMf0Qs4oNlu5w2ueWQjfzDYTE97GcHiCXWiMPskm3+fOx6A8GWo8swQuZWJHsJs5PbH+HzzWbgocYqNS4cb+vxPg5FF6Pu5usap8W0xq5OpDEDATUq8s7oquQS2VK6FUK8M6taXFTVY0DH4tQ+he+4p6gEuui7I+zwm22OqgrU4e/ulq3K9OCdCPRd+9NFS5pGET1IABya8p8tlu088NEDhoyVjJ+GUW+1jZNSROQlZkFcQfL99pvC+uU5keN88f1Ljtfg3s5ZBspd/lQIxLO51gyp4K/9/tw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c79e7a70-b69a-48e5-7f34-08d82da6e033
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 18:50:02.5225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntfcFz1D3j7Mo8evoAhckKH9MA4biLJAK6dNkWIHeXkTjh/nZmWu2nIoJOIrdgRB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3032
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_14:2020-07-21,2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 adultscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007210125
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 21, 2020 at 01:41:26PM -0400, Johannes Weiner wrote:
> On Tue, Jul 21, 2020 at 11:19:52AM +0000, jingrui wrote:
> > Cc: Johannes Weiner <hannes@cmpxchg.org> ; Michal Hocko <mhocko@kernel.org>; Vladimir Davydov <vdavydov.dev@gmail.com>
> > 
> > Thanks.
> > 
> > ---
> > PROBLEM: cgroup cost too much memory when transfer small files to tmpfs.
> > 
> > keywords: cgroup PERCPU/memory cost too much.
> > 
> > description:
> > 
> > We send small files from node-A to node-B tmpfs /tmp directory using sftp. On
> > node-B the systemd configured with pam on like below.
> > 
> > cat /etc/pam.d/password-auth | grep systemd
> > -session     optional      pam_systemd.so
> > 
> > So when transfer a file, a systemd session is created, that means a cgroup is
> > created, then file saved at /tmp will associated with a cgroup object. After
> > file transferred, session and cgroup-dir will be removed, but the file in /tmp
> > still associated with the cgroup object. The PERCPU memory in cgroup/css object
> > cost a lot(about 0.5MB/per-cgroup-object) on 200/cpus machine.
> 
> CC Roman who had a patch series to free all this extended (percpu)
> memory upon cgroup deletion:
> 
> https://lore.kernel.org/patchwork/cover/1050508/
> 
> It looks like it never got merged for some reason.

The mentioned patchset can make the problem less noticeable, but can't solve it completely.
It has never been merged, because the dying cgroup problem was mostly solved by other methods:
slab memory reparenting and various reclaim fixes. So there was no more reason to complicate
the code to release the memcg memory early.

The overhead of creating and destroying a new memory cgroup for a transfer of a small
file will be noticeable anyway. So IMO the solution is to use a single cgroup for all
transfers. I don't know if systemd supports such mode out of the box, but it shouldn't
be hard to add it.

But also I wonder if we need a special tmpfs mount option, something like "noaccount".
Not only for this specific case, but also for the case when tmpfs is extensively
shared between multiple cgroups or if it's used to pass some data from one cgroup
to another, or if we care about the performance more than about the accounting;
in other words for cases where the accounting makes more harm than good.

Thanks!
