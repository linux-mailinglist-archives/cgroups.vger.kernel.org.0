Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B46D59BAA9
	for <lists+cgroups@lfdr.de>; Mon, 22 Aug 2022 09:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiHVHxg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Aug 2022 03:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiHVHxf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 Aug 2022 03:53:35 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49D5101D0
        for <cgroups@vger.kernel.org>; Mon, 22 Aug 2022 00:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661154812; x=1692690812;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/cLs6QSxHIHeFFORrNEC0WPTviPNmoicENWCSKdqZ/A=;
  b=XYk0W5Ot+dORDE0aArxKlk39/8L9sl4Q9hZXWFModNbLFX14olycni9X
   T6Wpr6KqyfQfnkbs+YEdZkencoCkHthJI5iEea6DVUromRA0nX5oKQvXQ
   DDoFjB+sXWzCnO3uJFVWIQedXoof35TOG1ENO0qkGGt/6HxRuDU+bsfBQ
   mlZM7/4NSWW9j4gdr/ljH93RtCgdhyYx8QpusaNZbn+x1qDz1Svofwhz0
   3MJffB3hnsecs3ErPXZIc7Sj1og6dtVCuz3OhKF53aKbzVENJpdHoHlPz
   3Omh3wAvwusyAKdHV1jHXOaEtEMI7zs33mF8uV6ZIzjTUiIixuvHW3GAN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="290905088"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="290905088"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 00:53:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="638084806"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 22 Aug 2022 00:53:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 22 Aug 2022 00:53:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 22 Aug 2022 00:53:31 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 22 Aug 2022 00:53:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eipdklvsLbqdw2MonCCQduuk3PYj/7IpQ0LsfQFdsjVZMiuq8eD2uru3i/XzqJ9kphKdcObiSjfkEBxuy1zpVKQtnDHOZDWDdd9PMTCPoSzM92SlLLwG4KOKpG6O9X1IhXGm37hJuISyFzsmucVT309urGW1J048koJKrAYkeymJim2WSvf0ZVFuVEpp2UIDADboKdCI2JxwiW6Mk9ik/ymIMEbvGxUmMBQ/IrN+Ca6ZJxb07J7L0ty+wOo2pcesukcte0gyfIcZWyymjQ7woL8epYPhx52IelNksp0Y3/SRoIX9GZmdFMvDTpELg/ZYJAZLxidywFSbuit5ryG9Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIDDECUWeIJCcbh1Qom0XaE9P3zB5qMbb9YWB1BYXYw=;
 b=ZHNtSlSVj/KcIUQgyqOluyqdOiGAl+lfGjArvXx3xUo6lGXJ2fi9N598cIkMpGbvhpbnd3Wm7LFYC/gHWqzJEY3hbaOkvE3k0cNYagOJzahscdyAaV8tZC7yWEU3bJRQZwIleQ0t3tZzCseW/L0SqhaKK08AO9m61bCXo3Zdgt/227TB1G3hr7RiQ6VZuag12s8XYPNCzI9HtmRrBBkltOisM05B+Ine9VoGu8w/3zhhzyZZB/BFVr+m2rh6ajZBkNNRTi7yU6uVInHU9iaWdV/b7aVCOykuGAWO3+tY0H5RBjqSmPj70trvjFMeXZD4bXmj5wmmXqLwZr7BoclwIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by MWHPR11MB1373.namprd11.prod.outlook.com (2603:10b6:300:25::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 07:53:29 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::d446:1cb8:3071:f4e8]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::d446:1cb8:3071:f4e8%6]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 07:53:29 +0000
Date:   Mon, 22 Aug 2022 15:52:51 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Tejun Heo <tj@kernel.org>
CC:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, <cgroups@vger.kernel.org>
Subject: Re: [PATCH] cgroup: cleanup the format of /proc/cgroups
Message-ID: <YwM108KQCiD7Lp3n@feng-clx>
References: <20220821073446.92669-1-feng.tang@intel.com>
 <YwMwlMv/tK3sRXbB@slm.duckdns.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YwMwlMv/tK3sRXbB@slm.duckdns.org>
X-ClientProxiedBy: SG2PR03CA0088.apcprd03.prod.outlook.com
 (2603:1096:4:7c::16) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9f08290-8500-4792-b3e1-08da841366cf
X-MS-TrafficTypeDiagnostic: MWHPR11MB1373:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: StF70hS3XRx89T3O06JIv/bxA3fekivjak7xaoXoNpncWH2BGDMH90dGgUjbp1r/YQspLkikPn/HhAEVID8nxs27UrnjJOnWe5VBalAH/y6ZfOpsIGd611Qv45gvj37sIabNkWpuLAfHNdB3Q9uZy2PwVJKk6NjqdLhwnITRFd0cYHYm1KLDw9BNIjizynLumEIpNqyDZfKzGf5Ey1nc+4f3brhXz+FK7TMGFXqynMo1H8dhInGZQpKrI6GTM1VBt6qZaoph9H9J+6aon258mvqKV9gwt2Azh5dHZXFlUt4db512D8zXw5yHlOvDwkYho1bkLpVs/CMVNMpLCgVrA7GCdyyOaT/TshWkkywWZtVHQgwsPGwXD1ZSBbWeHVbYvL0SFeKtrd/5NeqeZn7T/svk+LmGNMsRYipcdzJoCpR6tA9Ajl7Kd/4qEiR0eQvzGUgiYi7hEEJWiknWQeX7Jxb+p97lrvH1NjcibzcLfF9aMikEoQePuUAckka9AJ6vwoiLV/a33qWWTmTm2BThMyW1slokaRQNgAoPI+QaPmT1qGynI8P+GPOy9h7CFmaKtYFaar01nS5sEfN9CBvELPb+V1SkTB+Jka7M+QdoeV38xdKWNmD+z/o0Rr78dct160AaE/QrdK8nYwrI2+31yzhXYaUBzOX0P2nkXIhfHWIhyyOCf1qon5xrrD0qBNOkIAciMKcVNxh8JsCLgvx9pQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(39860400002)(346002)(376002)(366004)(396003)(316002)(4744005)(478600001)(6916009)(54906003)(8936002)(5660300002)(33716001)(6486002)(41300700001)(44832011)(4326008)(66556008)(66476007)(8676002)(66946007)(6666004)(6506007)(186003)(38100700002)(83380400001)(2906002)(6512007)(9686003)(26005)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JrciVrajaLMwQcrddhZAAw0AqMILMQz0C0NwOZL/PUH8Jk749TBFq5NGd52Y?=
 =?us-ascii?Q?xM+ywbHdtVQ/m2Pzs7RtNfrfMXAiJOAOkN3jlr2plYjuqkihHhXe5rYwI1lk?=
 =?us-ascii?Q?nhr+aF4ephEMONSlYhPp0+jr0q5+i0f5nH7r3COQq4KX6x8Z1EV7KsuDLyrP?=
 =?us-ascii?Q?UDCArAHj4zFk53N2M2N3nqiT07/z2g223k2NUxF9RJ2GTKtyfKKdyvqqLAl9?=
 =?us-ascii?Q?aDNL3GzQ8zaHcn3vxW5t3XxMZiqB0yRV1AqvK1brWpStxHVG3pnA4qqupyzb?=
 =?us-ascii?Q?a1N29ZG4xZpxh0zASjibJ1JlSHNdGgYkpxe+hCJowWo1LU8h3IjNWzTA6cw5?=
 =?us-ascii?Q?3I1wgnXDviOTKXxjxdlEljfqOhI0eghvYf9tM44LJjygKTLeY1GvhGnyK5yA?=
 =?us-ascii?Q?N63x+St7AkKQTUEYukwKcwxvDVUEBvyH115i5oowh3A6WlR5CByKa64a3Jb2?=
 =?us-ascii?Q?netRQXSwc6Eb0os2D5tLPuhbiJX9cbjGkyCl3+uyX33nxCHbETR+suhSjQNE?=
 =?us-ascii?Q?CgSaqfOixTNtUtrhSyl8X659Pp8LFGFgr/GXJ2t9W7yGsFn/bigmkKiF6es6?=
 =?us-ascii?Q?2u+RJ6cJZbTLb4+106XN9C8d9KsvUjp3mrr/MOkpZT3LPrkjIFSCu3/s5Mtu?=
 =?us-ascii?Q?Nb6u1ByrQ8p8wmBeSUaKpvztyOFvPyKDGi+AkxReGI3EhUoqjgqvcX5sRZof?=
 =?us-ascii?Q?p5EGpsiDEZCzFO7cdhktnh877aniX3SfOcbFkN3U6nzmoJUt5DZz6cSwiX5h?=
 =?us-ascii?Q?vdfy2EdvSh024bridoHNkQBHWwlYzEFK/Rw05MoX4Vzbsv+ikJWjYfT/uBLx?=
 =?us-ascii?Q?9LcG3SfrCc5s0doH5WioJ9/gFr/+a93LVS3MBhllA6eW6H6VCZdA/pqyMfZt?=
 =?us-ascii?Q?+5cFHnAomtLSSfqVAs7RkUO2oNmmdYqvlGB8TbaxjAdS8ocGUv8hZ7OL1yPm?=
 =?us-ascii?Q?mb1EX5qXzxmVoZWpjt9eB39OENDVYRM7ek33iYLABl/7ocaVjUzitS2CWYBx?=
 =?us-ascii?Q?BYU5qqCWah9FZVK11m1QZm4H+JQiQuQ19zvqYg2IlLLjgBAcRnQUmtEWUleQ?=
 =?us-ascii?Q?laJAaTdKoQSK6a0qhmeeHZUCWmwU97L+jZZmGvTfkq/JkBlEu5GUSy+EqV/d?=
 =?us-ascii?Q?UeOAH2YZwusnj3oZ51kbx3bQNgwQyNzTcUSHx3YNfW3fyIKdZeW+DCnFpZEM?=
 =?us-ascii?Q?RE6urBRFOVpXHGkV9AV4rMnj9Nfii5968II27TYqBx2KQmTGSUoRzZLHpfPl?=
 =?us-ascii?Q?rQgC7loVHHni6Yp2QEcbb5hQojI5IJ8ydQS8AZkaomTLGqPUOv6gxTQcxzHI?=
 =?us-ascii?Q?B9wMqeWptlnfdWf2r6uORoJXFe7r5jonT6KB21bJhpoDwi5pqTcFP3LwumV1?=
 =?us-ascii?Q?h35GhP+lqFvliqAbRfBfDZV8c0cBCqUmgcI9PsNzE0fJW06P/U3VTYwsXh1D?=
 =?us-ascii?Q?ecPs+EBFfKOP2Z/26rnqZUIO9YohJS3HZAj6NmXnCmQ+rXYit05atlNcI6Dp?=
 =?us-ascii?Q?KXq36wEi9HXoOUMIYdQ/8V+ITmhZMXSe6kn1p0n5pMCfYigszxmFWIGAJFs2?=
 =?us-ascii?Q?UYPLZ4L0SnTWIE9kOzFTc1xwUJiN4HR1ATY0d0vK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f08290-8500-4792-b3e1-08da841366cf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 07:53:29.1260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXnhqjLC9dq37WR+Ylr2oM6C/mi1K5Lpdv9knOMwA/IoJM0vCW05LUGWaIm7SE+eTa6FaFpKY8phiK1NcW09WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1373
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Aug 21, 2022 at 09:30:28PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Sun, Aug 21, 2022 at 03:34:46PM +0800, Feng Tang wrote:
> > Currrent /proc/cgroup output is like:
> > 
> >   #subsys_name	hierarchy	num_cgroups	enabled
> >   cpuset	6	1	1
> >   cpu	4	7	1
> >   cpuacct	4	7	1
> >   blkio	8	7	1
> >   memory	9	7	1
> >   ...
> > 
> > Add some indentation to make it more readable without any functional
> > change:
> 
> So, this has been suggested a couple times before and I fully agree that the
> file is really ugly. In the past, we didn't pull the trigger on it for two
> reasons - 1. It is user-visible functional change in that it can break
> really dumb parsers 2. the file is only useful for cgroup1 which has been in
> mostly maintenance mode for many years now. I don't feel that strongly
> either way but still kinda lean towards just leaving it as-is.
 
Ok, makes sense to me. Thanks for the explaination!

Thanks,
Feng


> Thanks.
> 
> -- 
> tejun
