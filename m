Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E420F4A4CAD
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 18:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380681AbiAaRCE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 12:02:04 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:64698 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380092AbiAaRCB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 12:02:01 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20VGnN9g019529;
        Mon, 31 Jan 2022 09:02:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=dqWZiyrAtQfsRnyQvy9/KIobXqyxeLef1Rz2DWYEAk8=;
 b=m7TUlZSornpCB7rOJ8dVCugFgJSFwmefM8zlDqUS3m65nGxni8Ye7JjztubSQVmg+nYt
 HStFi3hOiVYVhI5cUJGV0VRIJ0SQoGkVLatSVS9Mv13NpruLgxshFLb/YxOmB2KsDddb
 JFnhUcEKc24DqnPAaXXo68ccRnvXI2PVbdo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dxer3swt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 31 Jan 2022 09:02:00 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 09:01:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkFNIQ6byw4QDgOG4jkoLHbU3UxK/JFxpD1HsQyID1Nx/A3KF2r9BqU8iLIK/G1ypajVyL98tJiK35YKMKO3XA1n83Wf9v3IWy4HyLs7IsKuLlIiUcnbplubiOUS4NSsWaak/NTSni8cl2Y1yLAztSB9gTk6E9EmF/TXIBRYL4gQUygJZlJ4p8Rr2dYIeh3z0oQmG4ZibaVJco1q8+KlOuet+hTrrIGTRugL6kNVoTI5xnhln2/+45KK2EceLyP1mgyAiwoYLaNfNRPjM0sBiFAE+9yNt3usFxeEqEmVyIXqjaP/N2NIUaLeIF1ii+yb0FRh1/njDstuSQ4F49b73w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqWZiyrAtQfsRnyQvy9/KIobXqyxeLef1Rz2DWYEAk8=;
 b=IeILZOakZ77BcaaOVaMsxTgCq3ME7k+vT7AiYmStZJ4WKi095omHGzQcffxrXUnYmK2IherLZCqJ1T//a1rue0aI7CEBJtMJIixg6yrU1Jd261lhi60zj6bRypJlI2jrMnxGFxTqeseEgrODyaSCF37lLOwTEVnvcxjmDSJB38ejZvX3+JZ9F3HVdMAAmZWqwyeAfpoKc5lLd9FAdv5S3SKlCLZR8ihZrN1KQuHFvx2kckhh9wuwZWrehZ1FByNAFCKbFNWWz5FITi2TlfUsevXWbUJQJwPbgTqPfIXfsg/fCz5rzHbYiLtjrwzxfFi3QqD8SguPvo4ihsVX9Njd2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by CH2PR15MB3654.namprd15.prod.outlook.com (2603:10b6:610:e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22; Mon, 31 Jan
 2022 17:01:57 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2%3]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 17:01:57 +0000
Date:   Mon, 31 Jan 2022 09:01:54 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Alexander Egorenkov <egorenar@linux.ibm.com>
CC:     <cgroups@vger.kernel.org>
Subject: Re: LTP test suite triggers LOCKDEP_CIRCULAR on linux-next
Message-ID: <YfgWAuzAo2WDyPH+@carbon.dhcp.thefacebook.com>
References: <87mtjzslv7.fsf@oc8242746057.ibm.com>
 <YeI78TMjU12qRmQ8@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YeI78TMjU12qRmQ8@carbon.dhcp.thefacebook.com>
X-ClientProxiedBy: MWHPR04CA0039.namprd04.prod.outlook.com
 (2603:10b6:300:ee::25) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c1a6814-310d-443e-1e73-08d9e4db63c4
X-MS-TrafficTypeDiagnostic: CH2PR15MB3654:EE_
X-Microsoft-Antispam-PRVS: <CH2PR15MB36543B8481DB8F089EC04B9EBE259@CH2PR15MB3654.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UB4e3WaUD7G7hB1fSSxa+ghB/MIZCSBe2bu24bhnvWNSqwiziYZXpsxW0Xw3j9moj3q1YKdE5LUziswghbFMwByCJW6hoFmG6IUOmVEv4VMJC3cpc2LFokzCiedpLj9LRs85YtXXl+YuR74DpQ3HZD+iUxHDAxXEJTt2gel2H7veKm/ELJxIX0Vitu72LTZcswfb1FyA8UoR58dPjl1hSraMeyeTzy8ESHRlSMcowFfT7gBr/2q0Z7J+oodbw45aRWHJ0L+1MjAj0BMV+WrvrqrL5lpw54wuwgegwHnWl0oXYpOuu9SjinfksFK73ZKV+Ceg3FxmUePJfnb0QIWO8uM6imm8t+axH52u87j4KEneIzB7W9UmhMmZp5XRiueoDA2ghRzqoUnFFlVrcfFMxXoKBc5ZW4TJTsQgDhmnTxT9o1xLRKTuDxdiwD+U597ik4H3vpECYJYMXKowZaxSX/HyUKR3NXgBITbJHmYUHErLq3G0jusD1i3QLbHR94fO3XBtJRdWANmKQWnpY1jLakwYdwaTK2gT7rJvkZXkYiyhQ2zIUqucpdxDcBDd/tdT+AhLpjUimTbhxfdaXv0yymm/jHpQiJjZ4ydbwjvJhDO6w5cnN3uEhgS74sFHIUZSdrjFdeuTFOAtvPxZgteEHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(6506007)(6512007)(6666004)(508600001)(52116002)(5660300002)(6486002)(4326008)(2906002)(6916009)(8676002)(316002)(86362001)(38100700002)(8936002)(66476007)(66946007)(66556008)(186003)(558084003)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nDofrZlRpK2IyH41B7sOXs2z0SzoZHwdKHUmZFUbmO/kMuXIkPy75eBG4+zj?=
 =?us-ascii?Q?OPzh4WRVSJU5jLHYDgVGTkyFlxsLMdvkAY8Mov0dwSSnfvp2KTUd3vPHdwP9?=
 =?us-ascii?Q?PiO2FZyS+V6T0DUNJ59RCBtiikEjuTCS5MQPkByAubrgKlrDTIcxdQAIQncn?=
 =?us-ascii?Q?jjBqu0+rB2JaYZXS0iaAeiccggFb1RIvAdyAhGXmcV12Qhq3LpkShCaH+oAc?=
 =?us-ascii?Q?16uYjOEO5GL3lbyW7US2j6sU+jSFDNuNT6GMOpgYGAvXPs3QxJnPSLGFagRf?=
 =?us-ascii?Q?4hUdYYU90XidR6Ob/l9GQU9BQ/NIesELMCuxTbdGzh6tEiXuIZvYA0rQwspS?=
 =?us-ascii?Q?zOQ/IHjIL2S4Jr6JgBdEG3Ao3Exjt0sILyh7JW1DmscLNmaLBo9MJqJPKQDf?=
 =?us-ascii?Q?NhvPpbHFeEQnqMyqamzXFj6CApllekpOylYeScKjBRqU/ddeq6nPnA+9Hus9?=
 =?us-ascii?Q?GUs0nhxhpk1y1aJ26ZpCOQpYT50jdC+G1UNis1D85GXS/FghUJwHl9i6c5UV?=
 =?us-ascii?Q?r5WGmMK31E+hOMw0NK5SB0RduuefNQOjJD4PX3AGxy96vy8XjV+ehYsBsvRd?=
 =?us-ascii?Q?WC+zhYjyUeUdbBByRsvs6ULDt67g4k2yVGW7rowGdCTC7UxJeNE7SKUkCtSl?=
 =?us-ascii?Q?BBnI/gEN4wNXJ+fg3QHQESSBtibasKqbdkjKIAeLqQ+7aLsPYWlGOdOc/5mJ?=
 =?us-ascii?Q?X+km9DK5sE1VqR3nD3rK3aRWPKnFiEef5mm3EU5IaoDBIBWTmhfCD2zq4Hoc?=
 =?us-ascii?Q?hCr8RHV/13YrUJ43gKG4VMKTFMDRgWehPjHtOWdDp/ySnvYppw4+8ArlqPVR?=
 =?us-ascii?Q?IduEFq6jK8MRFBdcYmdlaDYL54UnR4qa+WZKpvfaKz/coEn31OnHdcZRzZGN?=
 =?us-ascii?Q?4VQ1LrUJmkpoul4aljIBVcKwr8a5gDtjA/a5uJuJgyrHXMZz8vKR/N4fGiE8?=
 =?us-ascii?Q?JvBtm6U7SsYz6qWYhsKq1lu26NiqCMC6EjyfdR6oFIH7HHgzbeLH5EciFNw1?=
 =?us-ascii?Q?egA7Nfeld95uQZlTkBH9AzmIWVJoXXXme2d8GfW/JyAJVaPBB104mJYn3yzZ?=
 =?us-ascii?Q?+rvqf5dA+zxF/EuD0D3kLHagCespvfSoDbvhrfWf9IR9sAkah53sniTclOrf?=
 =?us-ascii?Q?4pIEwdIqBF0OOl8066odut5TQdF67Oc0McxYPGkzHWHk7njvjirI8Bh4I8oP?=
 =?us-ascii?Q?IOSWQ/J8HB/aZXOzwEoraSxvM3uLkbudAqsDV3FP4caV9IPXCyiqUJwW+sBJ?=
 =?us-ascii?Q?k7RXUI3i7m14/7s4FGGTHAp7umhtcKVxlTXqEThrfSm0RJjkO2neetU01NaG?=
 =?us-ascii?Q?/4u1y59zJuJT7WmT9LJOA1yM6UKzND9RBynwRLLFiXN2TDflI8fVnI163/0w?=
 =?us-ascii?Q?qgbpaNIE+qQz/bRcGs+M7KFI6F88+AWy8kM8xbws49FUUDyWsIMsA0Y6WHE5?=
 =?us-ascii?Q?99wVB5wTvYruSJ0RJmnoMZf1NYatczexrt86PIn2OSTJ8mLFkcKi5GbsWgtk?=
 =?us-ascii?Q?Tj6Tx/P/WDM9Tz+r97gPJpVvN1iWFd3PGIhmztNFVLoPOEpT3S9ldH+f9yfb?=
 =?us-ascii?Q?H+BqEfK64eyE28uzGXOlOkC6t05igfpnhfzyAa1v?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1a6814-310d-443e-1e73-08d9e4db63c4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 17:01:57.3497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUm5Ky3W59genyEBijPlhnGPGXgMYoqPD8GQpv/hOy45p/BsP/TY0hwYDhz/Gmoa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3654
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: wPqnUbfVBE8QYFPDYOsMQoqzIZu4HYHn
X-Proofpoint-ORIG-GUID: wPqnUbfVBE8QYFPDYOsMQoqzIZu4HYHn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_07,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 mlxlogscore=712 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310111
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 14, 2022 at 07:13:53PM -0800, Roman Gushchin wrote:
> On Thu, Jan 13, 2022 at 04:20:44PM +0100, Alexander Egorenkov wrote:
> 
> Hi Alexander!
> 
> Can you, please, check if the following patch is fixing the problem for you?
> 
> Thanks a lot in advance!

Friendly ping.

Thanks!
