Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9108330FBE2
	for <lists+cgroups@lfdr.de>; Thu,  4 Feb 2021 19:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239281AbhBDSrf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Feb 2021 13:47:35 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52766 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239320AbhBDSqi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 Feb 2021 13:46:38 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 114IOeBJ009789;
        Thu, 4 Feb 2021 10:45:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=n01RPg3dbG9s+6rokXNj955+ScFUZdwv9Sh/7kue/PI=;
 b=htbSuhbKE2hY+UliGcsbu4VpxM2d4Uj26mLnvG/mSEobX0D+4qJysUpAJb0nrMl6RGnk
 adRjhOQ60kG0qVmS++oJErTKpm6MUv4xfRhaHxHguEBqz6Y47n6E5Ey7V+HbvqwLPSmB
 C5M2P8xp62myRY8Gc1ZoUgrJcGgOlXxUiMg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36fcs64h64-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 04 Feb 2021 10:45:26 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 4 Feb 2021 10:45:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dM6Se5Sv/6MSR1xjgBts8S/dZwBkaGMPM299FVuZLRkqHZkxsUAZ0d2Hh+uiiru086+DCgIA1SxXgQr/s053R+gAC7hkRz7c1GMbTzAEdAANmHzz9SIuhSw/c70ovAhprteT9/rQNGwDUYiqvNiDIECSosCEGNbo9h69+y7pj/bvY6Q8hXvxk4Wpr+OD/tVescgCTOnsk0xOZGaer4yRqmYz9aDcLzfWGnHjk/ywXiFt1vh8To0jnm6zVodNB4fnjRlP/RSP5/q1cb1J9/bNpG2c+Z/RhbB5iRyjy/GpbrNG4dav0FOIVLGgHKU73942Eo9f/HhYiAiyAnPpJU6rDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n01RPg3dbG9s+6rokXNj955+ScFUZdwv9Sh/7kue/PI=;
 b=QANrbBVQKiyYaoepM8vAnBOQa6Mk8HoMQHYPUj/K+OdYyKn3xMe3TBQuyvd0KcG1arQ/Ef0EjeoCju1dZA2iNES/+xA1xCOCYwn5X3IoUXqbISF17yy/sKkQzRN98sQiG23pi3vx+Dv1SdRQkKqX2qtn68Ll1WcVpFzRMREX0djmKBOu01cHka6lHecNJOM21nsEdNyxg0pK6qJdlAOz4ZZw2TXCVzapOZuyiIkcI1xr6rgOy8eq0y3nhOB5WzuT/Ckja3g+xUDzk/vH1lILjOAgVeRWu3mkmuCkNNgDmu16B9ySM7FwCsgLTU5emY9AKm7J0YD9x/UOFuN7tcDFVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n01RPg3dbG9s+6rokXNj955+ScFUZdwv9Sh/7kue/PI=;
 b=NZLctum1uviEgeWh41yirPqslx4TYb6qPx2dKoXp3w/Qf3bxj2a6vUtiLPmvzHVBmsMLhI2kKi6fhNMQk+6w0JIuiOYEZvRrO6szSd478OWjz/bRVbLRFbKB65mK1vnP9QVfB1cNqMup6zbF6QYKjChPPbbhMczAACoZRJZPlCg=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4187.namprd15.prod.outlook.com (2603:10b6:a03:2e4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Thu, 4 Feb
 2021 18:45:24 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3805.028; Thu, 4 Feb 2021
 18:45:24 +0000
Date:   Thu, 4 Feb 2021 10:45:20 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        <linux-mm@kvack.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH 6/7] mm: memcontrol: switch to rstat
Message-ID: <20210204184520.GC1837780@carbon.DHCP.thefacebook.com>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
 <20210202184746.119084-7-hannes@cmpxchg.org>
 <20210203014726.GE1812008@carbon.dhcp.thefacebook.com>
 <YBwgOHL8dTjJpnKU@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBwgOHL8dTjJpnKU@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:b3b1]
X-ClientProxiedBy: MWHPR01CA0030.prod.exchangelabs.com (2603:10b6:300:101::16)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:b3b1) by MWHPR01CA0030.prod.exchangelabs.com (2603:10b6:300:101::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Thu, 4 Feb 2021 18:45:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94ee9d0d-3577-41ff-eb99-08d8c93d082c
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR15MB418739A01911DBA806A44A20BEB39@SJ0PR15MB4187.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IxN11fBDeBQAxeqC1DeStx8Pi/luP/OlbJbWTEdVvEQzRZBINdOpLYSpIuspXEH/bw+ltIEF+upojU5hj97aSx4X0CtQYIIXvzGjxLQ/C+t/uFI0Jd+3Ug2Y+L1JzFWjERdFePN6I3F72lUsM6wdrXYDIuwcgCX+VdqtOUuaVaUrKz03ebGTFT0Ge6HUl9QHMKa7raLuTMUG2Ay7+usCVo0+ZjHOz0/tLopfmqLwnP6Fy37RUAKsxoKqx/PlpEOU8yBgUqtUwcHVoN1ay+PTM5kGvKFGeOBjsCtqMt2OEecjElErZIhDHIRAXaSSGTuM7FoCa7Wonco+3jjlHlXff7c5sYBaO4KZays+VqCx4Tuq3jH/HJqsOdQePgYAmngd6w6K/spS7M91XKbvflnqz71XgJ1jQJjUd3wHepiHWQuQIkDNlfg2btTYj8bUnDsVU1lp4Cv+6ylYUKbqTNDuDHqq0eiSC34luKK3KpRPlcws1BU8xSoQ8iviV797ONW1AGuzGTOm9NJ4mBDrZbkofw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(39860400002)(366004)(376002)(5660300002)(2906002)(66946007)(66476007)(86362001)(316002)(33656002)(52116002)(16526019)(9686003)(54906003)(4326008)(6506007)(8936002)(1076003)(478600001)(7696005)(186003)(66556008)(6916009)(8676002)(83380400001)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/MEfIhN6JSIoAYfoJhTiDeJSXwse3dMA3UboSYNKIGPYtuQy80lUezYcwIhZ?=
 =?us-ascii?Q?RvuZfCODpQbyZgab58BAMUtMJQ+Or42rB04pQwbj8Tx0T+usiYWdFjItb1Yn?=
 =?us-ascii?Q?G54WhyyQlwDl78dzAZfH7MELfoRdlhakjm8fnXhNlmCHYjUOmrlEnJxXagSs?=
 =?us-ascii?Q?yQTeBDz5cl20lIcAKKw1VQ2D2SrVkXXeyhkRJ6paPKOI9k8kGw2VoBiN0F+A?=
 =?us-ascii?Q?JXYZYnqOU/Ah6ZLPc/0jZNOAJ+E7ERgS6hugEFEh+8h1wtH+pPC6uX5FYk/4?=
 =?us-ascii?Q?gPd2fLYtbS9Mnhi/21P9sOxv2kYYcQePtQYsq7GRxcpbTLFoq59mxCVJmK55?=
 =?us-ascii?Q?nHSY8BbiQRZ9HsnSS3myctki1HIMWKU9qwyziopRyY13ie6zEijMtNIwiLJm?=
 =?us-ascii?Q?FKSGMlabJ9839St31PWbIxOo2PQKj0cl7Vldc34WDeqUfrs12Egd4MonbAAg?=
 =?us-ascii?Q?fQIsUTn4HSTEgWlfoN1wsRafBN2uEIN8DOiGOayYMf0s/7O2a1k9UcWAPfi3?=
 =?us-ascii?Q?n90Ox4ifIuBpv7PU31ARN3qNmDglGXqpck9enumFJ8iW/WbVUNhSsBmHgBdy?=
 =?us-ascii?Q?TXsCXE/uQjxORUh8qzIKSp/WxN5DWqbS2ezlJGfCFuleyHJhPAGAsbjk04WP?=
 =?us-ascii?Q?9av/ioVWGrOupBMozMt19heWwwYEIF53Y1BtVbfUZcg5LDXzIcrhx6RvuVv9?=
 =?us-ascii?Q?qQ6XYtgha+yJx9B/cDtoD5jeTJT2deYDbVAqi8Oj/pt+p43TWhM4BeC8jlHT?=
 =?us-ascii?Q?4nx3y3zLrXv2ZAxiIWHRo01hEaln5UTVOTwvlpq+bEbaRI/LNqUVrnh7+MRX?=
 =?us-ascii?Q?CFWm/QkeFjgemT2ebiub+y5tAU8888cZX+B686n7QkrYGPlajOMzEkN+L+YN?=
 =?us-ascii?Q?4o5/0iFtunYBCWW3JJVK2YKE4Ft1oLw5e1ds7oikh/Hw8IDZUL/17QFrYkYl?=
 =?us-ascii?Q?tZNGnxRKfFyquCGIAYBjCJ4/IvGEV2X22OB45dqJjXcsTwOX7I1xUFflXJLi?=
 =?us-ascii?Q?Oza10nCUoUhxTxtXA1gLe7KzEyWt2pDdlXfR2qDlPvP3IlBGyzaToPG2ONOR?=
 =?us-ascii?Q?M+zXdkzm7tMM28XsLgD/s6oNUQ+R504Uz7LgrLPkCJQf5w+xZ7k=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ee9d0d-3577-41ff-eb99-08d8c93d082c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 18:45:24.1793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVExVVNrTuNQrAf8T6wWH0i953qDmnq5sF528HGchBw/waKTOWbs7QQl4pva2cxk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4187
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_09:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 clxscore=1015 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040112
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 04, 2021 at 11:26:32AM -0500, Johannes Weiner wrote:
> On Tue, Feb 02, 2021 at 05:47:26PM -0800, Roman Gushchin wrote:
> > On Tue, Feb 02, 2021 at 01:47:45PM -0500, Johannes Weiner wrote:
> > >  	for_each_node(node) {
> > >  		struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
> > > +		unsigned long stat[NR_VM_NODE_STAT_ITEMS] = {0, };
> >                                                               ^^
> > I'd drop the comma here. It seems that "{0}" version is way more popular
> > over the mm code and in the kernel in general.
> 
> Is there a downside to the comma? I'm finding more { 0, } than { 0 }
> in mm code, and at least kernel-wide it seems both are acceptable
> (although { 0 } is more popular overall).

{ 0 } is more obvious and saves a character. The "problem" with comma
version is that { 1, } and { 0, } have a different meaning.

It seems like 13 (no comma) vs 11 (comma) in the mm code:
[guro@carbon mm]$ pwd
/home/guro/linux/mm
[guro@carbon mm]$ ag --nofilename "\{0\}"
DEFINE_PER_CPU(struct vm_event_state, vm_event_states) = {{0}};

	return (swp_entry_t) {0};

	unsigned long stat[MEMCG_NR_STAT] = {0};

	swp_entry_t entry = (swp_entry_t){0};
[guro@carbon mm]$ ag --nofilename "\{ 0 \}"
	struct cleancache_filekey key = { .u.key = { 0 } };
	struct cleancache_filekey key = { .u.key = { 0 } };
	struct cleancache_filekey key = { .u.key = { 0 } };
	struct cleancache_filekey key = { .u.key = { 0 } };

	unsigned long stack_entries[KFENCE_STACK_DEPTH] = { 0 };

	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
	DECLARE_BITMAP(tmp, SUBSECTIONS_PER_SECTION) = { 0 };
	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };

	unsigned long nr_zone_taken[MAX_NR_ZONES] = { 0 };
[guro@carbon mm]$ ag --nofilename "\{ 0, \}"
	int global_zone_diff[NR_VM_ZONE_STAT_ITEMS] = { 0, };
	int global_numa_diff[NR_VM_NUMA_STAT_ITEMS] = { 0, };
	int global_node_diff[NR_VM_NODE_STAT_ITEMS] = { 0, };
	int global_zone_diff[NR_VM_ZONE_STAT_ITEMS] = { 0, };
	int global_numa_diff[NR_VM_NUMA_STAT_ITEMS] = { 0, };
	int global_node_diff[NR_VM_NODE_STAT_ITEMS] = { 0, };
	unsigned long count[MIGRATE_TYPES] = { 0, };

	struct memory_failure_entry entry = { 0, };

	unsigned long nr_skipped[MAX_NR_ZONES] = { 0, };
	unsigned long zone_boosts[MAX_NR_ZONES] = { 0, };

	unsigned long count[MIGRATE_TYPES] = { 0, };

> 
> I don't care much either way. I can change it in v2 if there is one.

Sure, of course it's not worth a separate version.

Thanks!
