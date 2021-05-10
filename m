Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBFF379453
	for <lists+cgroups@lfdr.de>; Mon, 10 May 2021 18:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhEJQod (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 May 2021 12:44:33 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:15738 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231684AbhEJQoc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 May 2021 12:44:32 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14AGY2AO018327;
        Mon, 10 May 2021 09:43:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=rrhlUjnD6bW9ponz5bLx07YD8kJYtj+nkd59IW5qQh0=;
 b=eyOkPaWU8zIt3GEf1JBDYLZRNakId2LVFo1YjobMDEkr4PeD5TKDW+gXjPpOuPPRigCR
 TRMM/dEoZulAslHh2QkHKZs5ESd34hRUcIyNiQJr9u0WFraFPbtwUPxYY89dt4RheSdC
 rppMBZDRD/e7A86tR7mvq6pJ9tR7VNHphp0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38drfvh0gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 10 May 2021 09:43:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 10 May 2021 09:43:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrpU/cyvXguGGRMR6NERkkh7IXmAFJs+QMFBQdAYL6DstlZ7wKCMC6sMJ6mnjqJYgM0Y0ifoagih0IzbkzqeUtSMI1ggYQZJL/DGRHCvmL0XAWgHYNNmHzPLpt2hJ1oOalae8XU6qg93Ywy5xO3gn8z1QlC8/gX+wv4HNP2YiOrc1G9QL9iBAiA1VSVevbBV0WhYrd6ayOIGJIp05Sus0kyvk2rdpqiuiV7rjCABL6jTeIGvYQOEFOfzb5a5ekreVrMR70cmpqv+vYSc3SRwiTHl+/DkRY6PCtRqzt4FNhV5dIPJnXzzOjCcF/h7rHnRSu7bN7oaxNw0B8/psYykuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrhlUjnD6bW9ponz5bLx07YD8kJYtj+nkd59IW5qQh0=;
 b=lpELwvhFY3Vxc2dXdlDiGu3sbWjTg+8pxr3ZmfLgnE3AyeqplVv6cYUkLRHr0T1u0sHE76lakP5hgwbjOaSj8zb9MO55wgA3WwzdniTCDL6pODn4CRdCI7YHlReR5tYfzP6RTIL7ROFPC4h8auUtszAGgIr6xIaZg6kStSqSNozpOEcjWVhIFp73X476G5rgh8e3IY8eASunoSvbPRXRea5riFC9PntyZgOd+pjjeDdq6PEEGas+VmNNlB8M79bfCUzEfsOLz8HQdkJlfk2yjXnY0IoZKJwe9oJQJ7NKspyT8e0tixcaGnXQl5oKJt19uQjQM86DrtroiWFUCfLWEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: lwn.net; dkim=none (message not signed)
 header.d=none;lwn.net; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4219.namprd15.prod.outlook.com (2603:10b6:a03:2ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Mon, 10 May
 2021 16:43:08 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 16:43:08 +0000
Date:   Mon, 10 May 2021 09:43:03 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Jonathan Corbet <corbet@lwn.net>
CC:     Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, <containers@lists.linux.dev>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Serge Hallyn <serge@hallyn.com>
Subject: Re: [PATCH v3 1/5] cgroup: introduce cgroup.kill
Message-ID: <YJlilxwEoZS01+RE@carbon.DHCP.thefacebook.com>
References: <20210508121542.1269256-1-brauner@kernel.org>
 <874kfaha3t.fsf@meer.lwn.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <874kfaha3t.fsf@meer.lwn.net>
X-Originating-IP: [2620:10d:c090:400::5:2495]
X-ClientProxiedBy: CO2PR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:102:2::29) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:2495) by CO2PR05CA0061.namprd05.prod.outlook.com (2603:10b6:102:2::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.11 via Frontend Transport; Mon, 10 May 2021 16:43:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6eacc6dd-97bc-4469-57f5-08d913d2b0c5
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4219:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB42191BAE0A6834D96FCE8DD0BE549@SJ0PR15MB4219.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o+YxB2TTuHItZY1RPc5hROtnLxryMy8Jc+k8UiGvwHkKApkfDMxlQtZFb4d4pvfXTs6kzLa9/xnBHkRXc4EkO/jHgkzYkWZ+9x5jjdQiMhRfZd9n04Y0Mj1/NlNPXutJmkFH4v4H7ePBuqFiThp8iF0lXoxW7psJWPoWIcJdSiwuZxKvgblxzNFCpqUCYfRd3O3HTv+H8zm1Xo9q+0Pv+1N2q7AQhBOpuk5VqgOYGkcV67HpPwoSrERzEM/VtKAUczxZCCCanracnD43v40xzhkRP3WbeC7MqKf/agTsfetfIb4KEp8C6+CVAG2ptlCot/5VjQHJwJcNDvYMQVXWju//+q+hfSH/KV1cpqDlF/ZvhnleRSSSCdIwqVIIePNE3WwKeMnX0yemxbsBnsfJyVzqAKzIRWmfV1KOncV1D5qaI+yrG7GfSzy/LYSgg94U+tuXo8YU/+evNhQObLYsDDwz9bde28HqxY4jLZ/glY2bcYlxoVKZfuwyI9Oc5NGQu5RmK0ksC44Zxu0SuQJZ01j2sWv9DgD7FkAORAnFna34TE3tdTTM7FcVnYN83PY/pySBBjeMip9RrZ25tAUO30WZ3Qs/va5WcsyBLkP6ru1aP/L0rjTvujCiRKu2c9RGdAo2M+lhLY45Sr6ramvkrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(8936002)(7416002)(54906003)(6666004)(478600001)(38100700002)(5660300002)(186003)(16526019)(4326008)(6916009)(6506007)(55016002)(86362001)(8676002)(9686003)(7696005)(52116002)(2906002)(66946007)(66556008)(66476007)(316002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?b6y3ktXrlUmjSWQ/TQT3ObolBkYmhlfFCuXa7JnUOoKT/7Cqu3i4450Tcumk?=
 =?us-ascii?Q?pJxc5DAoUAOVtf5lAAw6mD5w2BCBqhZImE3JpUz5pVMWyOpz7LcgZM6YubrQ?=
 =?us-ascii?Q?MTvHu+K/qiLMTIAf/0la402les/qnhNzBlEOOe7bC9whMwT5o9quVFbGX/aZ?=
 =?us-ascii?Q?s+ochfOZ4dyWrkaHooy6KeqUXw+PLYg493lOfGkZ3Ec6qOS+0v5ei9X+bIMS?=
 =?us-ascii?Q?0FLTnhDCq/TEw9FsyFrkZ1YGJ6uaDgJe74ibaIn9HjAKbaIbE2p8LvwDs2MP?=
 =?us-ascii?Q?3f7EvCEELcIvD/VJdIK4cjqG5RFNmY5yAjRzGYuEOD0WTH/5lQP/Sj5VqnrH?=
 =?us-ascii?Q?LHaV1CCG5/kXmP3aVl5PsJ7+GOF0FTeuTT2M05fDwLFWSkjqH3U+TnWD8zI/?=
 =?us-ascii?Q?WkuyC/MK0xwUCNULRDJnJWB1rbJZa0El+Xy1Zpoh4qNpip1gnUorF4DcexAp?=
 =?us-ascii?Q?6+BrOfV0soTX/ZuNU2T3pFqZmQtGstIqp39T7FnlgBXq1Avfa52gX9g7Tpsn?=
 =?us-ascii?Q?JsfL7fO91PaW0jS0PmPZJ/ImwXxsKQgITbyOXYi3ozizh7dtPtXdSYb6YqJ3?=
 =?us-ascii?Q?beb6vPBooWTazBAT+xdNevo6/XMRzt58ougjuN7C4wDWznTYhvoRX3D2VArH?=
 =?us-ascii?Q?iyjyA9qa5eiBPQSsth0B+n0NMQ5Pj4Zi9l/85mIINhuwGdyZUJW/xK3L8ysZ?=
 =?us-ascii?Q?KSZiBv8+NrTC9PpPYczmpXPoGMuJy464LK/LFAxhuQ9A1b8f7edZzOLHOI/t?=
 =?us-ascii?Q?PnydSnKBJW+SpMN+pOJhv2yztOjwPRpZx2OgqqTuBfbemjtfzZxKdfwGBoUU?=
 =?us-ascii?Q?UnXPk+02qu5RSSdBJ2XIPkBwZJLGENDuPfx2vckYln3B8kwFZRKsW8dFLYIq?=
 =?us-ascii?Q?ugoPePvYzSQfz4X0sKtw/IHJZP0hNoN5K13ZE/QORgW0BKW920s2Kt8ZmjPK?=
 =?us-ascii?Q?fucok4WlL9MpgsIQLaDd7F+36YokCP+zQLN+rcUvMBWFa/t9PfDA6Reuj2Jx?=
 =?us-ascii?Q?xRvIIL0lEn1fnoRmiRJa2pDXdkhFrBnFwG50xbAeNdFVO3H/eFU4vJ9gWRI8?=
 =?us-ascii?Q?8Usa8gG6aGjQ65GPg3pphn7uyEHHkrwCQSmaMxL7eLczfcM3fxe11kqb7jtv?=
 =?us-ascii?Q?MlvvRHjvedJ+Xs2S0Woxgf+amQxBS4jkk/cstxM6YSx16koeiJOeH0/z6HbE?=
 =?us-ascii?Q?yifwFLuoodkbGayy6OGvlVXh+Di+nzymN6eADv/fkqhTvZodY2of73CiNpNS?=
 =?us-ascii?Q?c/dxMUpIj3W5yGB/Z2X8MnGhHXEjx+p7n2OLKsSOaHU0CDgFodsFTyAHCi5D?=
 =?us-ascii?Q?EM0DsPW8T1uuhL/8geWtWGwJ9SH99ypDwQQ7FeYhhGJYVQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eacc6dd-97bc-4469-57f5-08d913d2b0c5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 16:43:08.0601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Su7LjLcba/6Pz54ehlDgTRkja6LMiOYj9I8AaBR0vV7xXEo1QSBDigRZ/vhe1dek
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4219
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: fw1e-AwgZQkgJUqWqPhKE0LPT-hrb2LU
X-Proofpoint-ORIG-GUID: fw1e-AwgZQkgJUqWqPhKE0LPT-hrb2LU
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-10_11:2021-05-10,2021-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxscore=0 impostorscore=0 bulkscore=0 spamscore=0 mlxlogscore=774
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100113
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 10, 2021 at 09:39:02AM -0600, Jonathan Corbet wrote:
> Christian Brauner <brauner@kernel.org> writes:
> 
> > Introduce the cgroup.kill file. It does what it says on the tin and
> > allows a caller to kill a cgroup by writing "1" into cgroup.kill.
> > The file is available in non-root cgroups.
> 
> So I feel like I'm missing something fundamental here...perhaps somebody
> can supply a suitable cluebat.  It seems inevitable to me that, sooner
> or later, somebody will surely wish that this mechanism could send a
> signal other than SIGKILL, but this interface won't allow that.  Even if
> you won't want to implement an arbitrary signal now, it seems like
> defining the interface to require writing "9" rather than "1" would
> avoid closing that option off in the future.
> 
> I assume there's some reason why you don't want to do that, but I'm to
> slow to figure out what it is...?

I think the consensus was that most signals are a process/thread-level thing
and are rarely sent to more than one process, so sending them to all processes
in a cgroup is never required. So far nobody came with any real-life use case
behind SIGKILL. SIGSTOP/SIGCONT could be that case, but the cgroup v2 freezer
is doing virtually the same and eliminates this need.

Even SIGTERM which is often used before SIGKILL as a grateful termination
attempt has to be sent to a proper process in the cgroup (e.g. container-level
init or the main process in the workload).

If a new case will arise, it will be possible to introduce a new interface
file, but it looks very unlikely that there will be many such cases to justify
a more generic interface. On the other side keeping it boolean makes it more
consistent with the rest of the cgroup v2 api.

Thanks!
