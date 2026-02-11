Return-Path: <cgroups+bounces-13854-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOxnJqdWjGm9lQAAu9opvQ
	(envelope-from <cgroups+bounces-13854-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 11:15:03 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E02E51233C1
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 11:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD4C1302593F
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 10:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472F6366DCC;
	Wed, 11 Feb 2026 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WLEQ6pei";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Oj+kXqiN"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D91B331A5F;
	Wed, 11 Feb 2026 10:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770804896; cv=fail; b=uC2+RdNR4HK7azNdxjDrmJ8bXW8nhkwOpZf5TnR0CBkT00qeXAnosq0u7KA8EvIdrGmtV3W6ZoGgl4DMVjK5Xjw4q9CeevfHqWSg9MGJdYKcMskBtiEvn1oeSPZix/po7a8qjOxItMj9vGqVCl/d5vTDCfduy5K+gb2iAs0fw6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770804896; c=relaxed/simple;
	bh=vd3FtpKxb3bB9BUX+MyFHuAInpdSUemHQDa5AaKKmok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uCGu4u0OFrigLSYVU8gkYwwlyM59Dcc7X9f53Z2C7hXp1Imte+qKXMAJNe/OTU1WbkuAQ7L1ycp4anez3FkBCOEzcr5aclNYYyJrUD6XrwML7DNov9HpefrcTQfB13iq7nG/zmtmynzrcJl4n+44FAhGNyW3I+FxljKxXcaPSR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WLEQ6pei; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Oj+kXqiN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61B9wNqf1815499;
	Wed, 11 Feb 2026 10:14:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=VUF4zGjKdKtqB/4mxr
	dEjDZ2MDWT58hrl+yYD9l12R4=; b=WLEQ6pei8AsbHkJxe5u3y0obQJnvNnP/95
	495jpZyVVGyFoKG5DraTBYNn92U1O5onfeR9oovb8gepVB7eyopFN0hSRiO2LMEn
	1zHa507lvgVKuosLAIC4pSZ0X8apybFgI27tWFKBZ2xQAEWgqet9SAgcCATgCo+k
	3mtSKu6+sWL5HT7NvCKZpDmjfA3fBPQplWnGpG9A+UNk++MfwE0cOIZgN0Qqt5eU
	6dIuIGFE7ahVp402fX7nvw4W7JbFzeFCHCjSB6Tka0MaYyR+2Mvay68FgZYyFim4
	7m6CnfpCuJv2bVQBlq0Tp1ltHTmL/1Wsd1dsg7SA0YtIvAi/Y2FQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xh8wnd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 10:14:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61B8bqYZ033798;
	Wed, 11 Feb 2026 10:14:28 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012032.outbound.protection.outlook.com [40.107.200.32])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c82464a94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 10:14:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYhZjDTEfMcqJbI4G5sgVvsi6/W9lhu+6vb5PRNUJYELaLv4sQWkiGxnDvMWl0SkzSQDdFK2FlxL29/Z6q5ummtX0wQfvy5kX1ZTRJT4Mok4byNpkoF7H4604txiBHOg79y2QSE6UmdwPrtI+OAR5nsuQmWopGAW5JTfl4LuLPHu5CwEq1D0lXnbJTWOeka5WSz4z1Ni4arjvE2ps9bcpsYsYPToeZXVrjXant0qbhMPg6TFKUG/UnNDcPiRReey6RQRvwnz53n3fooetSTjvIosfrNrNkZAnmMkriaXMmuaWQzbAogg8Dbi6aDVwDuANGwUoyj8jVkTjj9K91qW2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUF4zGjKdKtqB/4mxrdEjDZ2MDWT58hrl+yYD9l12R4=;
 b=W3txCO6ztVUP+qvhAOn/9uZM9+X3h+4v+OQMiqaRahe1Cs6M5O/2xyc1EZVfP8w7eqgsKPNBZOc2W0MvQtZGS1x9FqL19pDqxGJQSaJ7ieWOeMB8KZtD5WP9zy+DJAljQiM2xRFS+HoDQ0M5EcHg/e6m5LV3kp+l0WOGK353h3jhGtFzmoBw6P+Q08tzPw7p3qSrx4aXVPvyD6sYbtGyyUr+RpdcZy2A4jxLZljjedDq/uy6ykYC/diWN21BOTSMsFHAwKvMGGafNvath0Pfazq0xjRtxa4HRHR5UtgszgcHm4YJIjI+7Ej8Kgl6JqLO4dQ2gT4C6CncdtIQJAwRDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUF4zGjKdKtqB/4mxrdEjDZ2MDWT58hrl+yYD9l12R4=;
 b=Oj+kXqiN0ED7UvuzhQ16qknndDKNkn1h/ytr7rzvsAAYhpVxWVoa/QWF1pSK49BsRmt61tYRMq/iFrbxLyRF1EV/Oxz6jPQAGxix2TQr1FnLRkqdCRg/zuv//F8ItSvChDw0AXLNW4D6DTlTYh1IRLUNkAGkm7e2buHg5RsG+hc=
Received: from DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) by
 BL4PR10MB8231.namprd10.prod.outlook.com (2603:10b6:208:4e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 11 Feb
 2026 10:14:25 +0000
Received: from DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::81bc:4372:aeda:f71d]) by DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::81bc:4372:aeda:f71d%5]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 10:14:25 +0000
Date: Wed, 11 Feb 2026 19:14:18 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Dev Jain <dev.jain@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 1/4] memcg: use mod_node_page_state to update stats
Message-ID: <aYxWekRpQ2w4J_R8@hyeyoo>
References: <05aec69b-8e73-49ac-aa89-47b371fb6269@arm.com>
 <aYOuCmjQ5lGm8Mup@linux.dev>
 <4847c300-c7bb-4259-867c-4bbf4d760576@arm.com>
 <aYQuj6Ot-JS4tXvY@hyeyoo>
 <7df681ae0f8254f09de0b8e258b909eaacafadf4@linux.dev>
 <b77dc11e-fe09-4f0c-a912-d05faa01ff1c@arm.com>
 <aYtbevHEwx_3fn0Q@linux.dev>
 <5a6782f3-d758-4d9c-975b-5ae4b5d80d4e@arm.com>
 <aYxDkkDI4mk3r011@hyeyoo>
 <aYxIr5neJP8wBdZg@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYxIr5neJP8wBdZg@linux.dev>
X-ClientProxiedBy: SE2P216CA0020.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::11) To DS0PR10MB7341.namprd10.prod.outlook.com
 (2603:10b6:8:f8::22)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7341:EE_|BL4PR10MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c9bf3b-2560-463e-c633-08de6956552d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qoPBKvFEd3CXXPzJXh4qDEK8/0WLXDV8AjJY0Z1WV8lfNmXk2eo4yodiR7ol?=
 =?us-ascii?Q?72vMdNhHn+Kq+Ggr4E4IGYdcsaj1RkVCdc0HwQ3sR94uRQ5O2PhiQah7vA8b?=
 =?us-ascii?Q?BY0MlEL3RISWPTLAE+j3QbUhtPR2tZT9yeBT0jtXyD4oHAMl+VeeLDne2BeI?=
 =?us-ascii?Q?pRinkPVqsOUxEGu2/miPfRvRjamRESy/CiBYjjbaYg0AZtIvA9r0VFxPN6ul?=
 =?us-ascii?Q?viR00nFbdsY5WBlDT8sct8dXwsGHDuUuI2tzht6yYk3t8Nj9kcPBpZg25PkQ?=
 =?us-ascii?Q?fVJD8stQhG4nIg71PCsoRdCmTdVzzbzx4vVR21t/0VQd5TqbGOjRodZ6Cz/2?=
 =?us-ascii?Q?2gdKKsDSn8UfJWMPZYg4Mdc0jCob+5ybtb5e1BbX0wNLbRKo09CxMyQUM5Sz?=
 =?us-ascii?Q?YpiN6sq8Won+vKxZo0Qd/wO4PcVFBlx5xKSQH9TuOoib4GC9fzFEFuejb2QW?=
 =?us-ascii?Q?3aeQNaptHS9LynHwpSxlbKFP4fz2iR0j+xVT/zC/Jwa70ZRDlrpuIq5ikshR?=
 =?us-ascii?Q?vfnKQxLX7MSYUpowJxU4+JyIEJYVQfRbxe2pBeo4opNfP5zbgmDhyJGofMXw?=
 =?us-ascii?Q?c7YtJ36tOOYC88P6Je8StUTyIhK8wocMmKXZ2+J7GQzP5CyMPQcv+5VQIG3k?=
 =?us-ascii?Q?bj8GXf2HgfUplg/kGNnA885efbO88cnygNAEEnVhupYEe/EF2i/Rps7Voqjd?=
 =?us-ascii?Q?9gv3qIIUs/kiSGYxga3W1BTD7VBzCMAk9jJtsG5vELCMXJv18iKo9wz95+w0?=
 =?us-ascii?Q?vKw613X90TsHjhdM1VujlZJ2YqC0Xz0U8/2UsFIQwYUXwSjL8PWhH1fiIUdf?=
 =?us-ascii?Q?h1sDvNCEkdQnfICLADb9K3VXgGolQxLZV3lBVy48tA1Lw1TXC9z6ymB0uemJ?=
 =?us-ascii?Q?nvHJT1SI5m6FDc1ZqEZzFHKxvwgjTQ7osbyEdBsznzBtKOoa5PzGBCkkHMif?=
 =?us-ascii?Q?8Zwr8l4eHkXTbFs7PS2WBdPAsccGU/7GY1NlbAzR755MICrwamqDqJPYxoGm?=
 =?us-ascii?Q?q6M49kyWb6FdyVgg0BmCtNlBzH6TaXa1uhDXCFxZcqYKWi2t6Sa5YZgoVG5i?=
 =?us-ascii?Q?G8lWK6D1TgzauDY8gzIHoaQkGDZRobkpkZD6T1jc6ZqRgX9JEYVRfZD2c++u?=
 =?us-ascii?Q?NvfdQIKUjig5xulWyByNLttwA3eIZudyjOlx9daS8p52VUsCKYB6aFsBbdnH?=
 =?us-ascii?Q?EFzpe6HsOlP6YpEmQm7Zb2WRoYhvbh1DytAsbAQUgHXFGy0bKWKTCOmBdPoa?=
 =?us-ascii?Q?gtusbsfIFPZ22oZq67maFYdermU+bsVCfkodJMQkZvoXUbmqKmvBSRkOOBvM?=
 =?us-ascii?Q?4CEfeXk2RmxilISviHbCY8geLziypsRlV/20q+a0hi81qMvQMXITtw5NgpCS?=
 =?us-ascii?Q?VAQllL1zi8dlUYzh6hzTaUMUDKUvrh2xSa2r2xs7M+TyfprZkk7edBvbViC4?=
 =?us-ascii?Q?tf1cx/qHAe4yqvVJr5nlkP79itgll4h+83IK29PaPrrsgMxq8PUo2WUSdH4M?=
 =?us-ascii?Q?VxeQTvdTfD4GKyBZTUZC4KX2Ohg8EdeBGH8MTofuSOaxYdykhGBL/IVAddLp?=
 =?us-ascii?Q?UprY59xc3rk2Vy3HCxQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7341.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?So0pDTwpJ187UOY+OXo+alFumfb6c6vtL/3eQaiU1yjZzxFQMMgqIFOkAs7f?=
 =?us-ascii?Q?6ukEx1I1dXAXEVgXXQHL1y7jy5ocDvsfiX/DY47fmBnBFQjo9e5cAkGwkCMD?=
 =?us-ascii?Q?RvRayhKMhNhJwItYrGfWOLQfVvl19MLf7JC5/3wjN6ddk7z9GJSBtCymt9KI?=
 =?us-ascii?Q?WEzi10sezHviWjAjbp+xsYLckFIfydm/AUEMp7OLjhq5T0Bp4uKq5XmhQcwG?=
 =?us-ascii?Q?l/+/aXUXyd44WEvB8Z2krCQEtJY4C7lIT/9qorOzq5UMuR8oGq5qkR2jD+tn?=
 =?us-ascii?Q?ZnmelqDyakh5fjeX1vF/2FeDqs5qbw6wyCVPJhib9eleRvpUm2OkESDe16yf?=
 =?us-ascii?Q?1oDUuDETcWEUMNdDAjua77yv9rNDnYzWqs4rXgBHMNNnIqELyU5cbjUmzSVC?=
 =?us-ascii?Q?Jn4aY56N3rA/23Z8fM5YkG/yVcmFgh6WaMg+/zvVIK/gxv4PeqrsDFchYc3j?=
 =?us-ascii?Q?771yuV/hmSI9i7oHxvhy0MOCqNvSa30MPRRZIuppiZhJqyjwTXdupU04IAOn?=
 =?us-ascii?Q?KEVf9UEDulxpseCPPwmgvixpCccnIL69kn4BYJdW9K4+ntQ7YR6FOwGY9lZE?=
 =?us-ascii?Q?f0zowlBmcbts+i7WI4K0O/2l/kYh4QceDv+J85lMaNvJU3GmznXjduIem8/2?=
 =?us-ascii?Q?2Ca9YyPEhUB9hP5il78DcZzaaNSimPloyNJIjQrJ/NEaLPGtHrJZKzKR9ALW?=
 =?us-ascii?Q?YJqDNeHpNaA397GBlH0dojEYF39J0PMkUj2pYslL2BfXlknyqGHtPfaAqfjS?=
 =?us-ascii?Q?uUQv2QgVpDP1TZ+Zvldd6MZdQ8xlDgwxc91RRsOjD6HW3OTKSxJ+pcUvrpP+?=
 =?us-ascii?Q?sfO8RW4ja5zZBJESvrsEZzIJ2hqCle9sGRdFER2Pbsftv1LSnxTmrVMx+6OQ?=
 =?us-ascii?Q?ozohxgLJ7GsbU9FLdMLZpczxDgWRxoFR8OyAFKvyS/gn9ccyg4FnYlW5bfrL?=
 =?us-ascii?Q?wer3i+VMxsRz8s+mms4BiwzLb5RamcMeZdJyiZvpxlPdKudVXNehCkWPKwYi?=
 =?us-ascii?Q?/gMS86KRATitU0HqCVV/ju+rlO0FoKo6OMOFeZmcvzo8CYkLzTcJI3C+xM6T?=
 =?us-ascii?Q?HCJziI5+kXEJfFRLPP42nvCIuzsSQh75sj/AZNahAXckcYKwLpHsWHIlNEaG?=
 =?us-ascii?Q?Ys01jfa7D+v3f910DTHzOKzmWyfAc/gyYPh1i2LByn791V/xe9HaUEcd7JGT?=
 =?us-ascii?Q?QapvwQchoGN/fpgMJP4OK+lSB0U0Ex/FbIBE2aU1K8zetKL0eeebDsou9SHz?=
 =?us-ascii?Q?WicL8hUC/Jjdy11MZHAWgBFjOVh0HpfCsrEL7qM5hiHEm9yFfatvxsV6RJw2?=
 =?us-ascii?Q?cxrRG7P8m/HYCXjb7BUQSriVc1DEhJN5OonYts2mTEFVhoO+2gPj0KNKEvK2?=
 =?us-ascii?Q?kGDnbkSaIVIXP3b61/WXyINKcw92HKOvICeIoJC3czF0WOFaq3c12Rq3PqIM?=
 =?us-ascii?Q?d2xZS2UAmA+IIwL+n4Hb3D5RZ4HbPzygHsUpKmjJyoCPbsuBvJKNmjbI0ZWa?=
 =?us-ascii?Q?ZwA1yNwSxOjrqw+xzuCZanUerHFGgCXSpFv0nkETjHMixb2PegPdWROo8Fyu?=
 =?us-ascii?Q?zi+OOJDzG6pc5YBlz8rKw2n03o3dzp7L2md/Huwl7M0lF7Z7Sgg/JSaxROSn?=
 =?us-ascii?Q?AHojnZXQkoFjAUWb7VD8ZePkguH2pSYg9guMzgofedI3nAKDzNg5eNRfPm0n?=
 =?us-ascii?Q?l3qmxsGg8/TffXiIeqKrdPJwPdptTvzMScTI8TG55zYpwnKEqTCoxj2sy+ah?=
 =?us-ascii?Q?4p1aN5R5rQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7VKUTmQk6f7xD6sBGKSEP/5nkrK2BBSkIYjIyb6AkrarSs+M3KJMYBc1W4GqIgGxtwFEVWxypYlkY2xJ3mm/E+kUUFUMgsXpRt2wgg8l1Fr/F8F/I/uymfj6YjiUfKY3y8lHogfIWa9TNvNT8MHLCn1vzcaTVOAFLforacQSvNoHrqWkAFQNscilMq2fY7VApzc0UF9ziqAoTmywGGo+c6dZo0hJ9DIJrDq6zXwh6zz4ntbwdbWzvdYFoSRohoLKgUDCEq+mLFEQgrvUIii8PQoIkm9hHZ3MTyUXmP5vdxWekAWaODN3SyGlBnukv5mYbvdGN6AsAhG/CkCan2ZQvq64fNywyARs9U7t0nZw2h86HY5rG3q2Zs38GYNvoctAJUqYQEAnL42k4Db4DezxUbBBq0EeAO/9qqQwY7Y8kGeASFpmEW1DShH/6vkt9+p7xG9B3zoH7wLUWOwqQa44dYXkx8BW0aH6dZGxGrR5hO7vnTc63HlUJ9MHdy14K6Rcp/bMhtnw9cQd5zZg0FCWkNLb9bZNz1dV+C6OpQcUPM52i1H5ZtZY80fo2zSb8TAqwGG8M4GrAD233uduY7Yz47P8+pee8NvRrFAagzNTI50=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c9bf3b-2560-463e-c633-08de6956552d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7341.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 10:14:25.3415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6AsCz19131zlmjKG4EE633bF4N+/zlGsSpwLU2sne8Pv3k41q/HwakqRs38DLerhnKapomk5CcnyGT8lv8oIxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR10MB8231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602110083
X-Authority-Analysis: v=2.4 cv=YbOwJgRf c=1 sm=1 tr=0 ts=698c5684 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=5HfSyctdvlnlvKIfFqIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 4lyWe7Ji13YfzbRkD9otvsa_lUaSoi_x
X-Proofpoint-GUID: 4lyWe7Ji13YfzbRkD9otvsa_lUaSoi_x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA4NCBTYWx0ZWRfX5sVXvQzlwkUX
 ic8CC0S4L51hPCVLxfRwQ5iCkmPPmygvUdOz0+0xIT46Jwuxo3OMdVneGpYrEvQl+TjbDad0alI
 46AiDfYQn7yui2QSn5WoOGNe8yDJ0xjsGXi09EfYswT6GdMCPYWhMBBu3TXIVFpnhsKw69/rAB1
 6NGRZq9ToL3z5rJOgDe6gWz+mPC0WEPs3voKtCfk9s0fps7YvTc1evtq4h37kywGxWxDqHNqSCK
 8g/jaIkR5e2C1YfVu2xhp4jcf7qYFHQzyv+dq23rH011mCE8mbbj/Z0X1EAdKvSKLIvJAZeKqqs
 ZiNwX7uxlCmIPKjxKbzfHb8i30d69O1ye3ZIDRG9whBCpAPigJse2EUE7Qorub4TK4A2XGQndV1
 spIiNHjSAw5TpiIwtLnUxGNJB8Uy+OpZZ0avotxKdlqlTE8E8l3aC0xzZsb8iDwgYmiHJLk4+qs
 ED8HtyRU2k6SrD3VgFw==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13854-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E02E51233C1
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 01:24:35AM -0800, Shakeel Butt wrote:
> On Wed, Feb 11, 2026 at 05:53:38PM +0900, Harry Yoo wrote:
> > On Wed, Feb 11, 2026 at 01:07:40PM +0530, Dev Jain wrote:
> > > 
> > > On 10/02/26 9:59 pm, Shakeel Butt wrote:
> > > > On Tue, Feb 10, 2026 at 01:08:49PM +0530, Dev Jain wrote:
> > > > [...]
> > > >>> Oh so it is arm64 specific issue. I tested on x86-64 machine and it solves
> > > >>> the little regression it had before. So, on arm64 all this_cpu_ops i.e. without
> > > >>> double underscore, uses LL/SC instructions. 
> > > >>>
> > > >>> Need more thought on this. 
> > > >>>
> > > >>>>> Also can you confirm whether my analysis of the regression was correct?
> > > >>>>>  Because if it was, then this diff looks wrong - AFAIU preempt_disable()
> > > >>>>>  won't stop an irq handler from interrupting the execution, so this
> > > >>>>>  will introduce a bug for code paths running in irq context.
> > > >>>>>
> > > >>>> I was worried about the correctness too, but this_cpu_add() is safe
> > > >>>> against IRQs and so the stat will be _eventually_ consistent?
> > > >>>>
> > > >>>> Ofc it's so confusing! Maybe I'm the one confused.
> > > >>> Yeah there is no issue with proposed patch as it is making the function
> > > >>> re-entrant safe.
> > > >> Ah yes, this_cpu_add() does the addition in one shot without read-modify-write.
> > > >>
> > > >> I am still puzzled whether the original patch was a bug fix or an optimization.
> > > > The original patch was a cleanup patch. The memcg stats update functions
> > > > were already irq/nmi safe without disabling irqs and that patch did the
> > > > same for the numa stats. Though it seems like that is causing regression
> > > > for arm64 as this_cpu* ops are expensive on arm64. 
> > > >
> > > >> The patch description says that node stat updation uses irq unsafe interface.
> > > >> Therefore, we had foo() calling __foo() nested with local_irq_save/restore. But
> > > >> there were code paths which directly called __foo() - so, your patch fixes a bug right
> > > > No, those places were already disabling irqs and should be fine.
> > > 
> > > Please correct me if I am missing something here. Simply putting an
> > > if (!irqs_disabled()) -> dump_stack() in __lruvec_stat_mod_folio, before
> > > calling __mod_node_page_state, reveals:
> > > 
> > > [ 6.486375] Call trace:
> > > [ 6.486376] show_stack+0x20/0x38 (C)
> > > [ 6.486379] dump_stack_lvl+0x74/0x90
> > > [ 6.486382] dump_stack+0x18/0x28
> > > [ 6.486383] __lruvec_stat_mod_folio+0x160/0x180
> > > [ 6.486385] folio_add_file_rmap_ptes+0x128/0x480
> > > [ 6.486388] set_pte_range+0xe8/0x320
> > > [ 6.486389] finish_fault+0x260/0x508
> > > [ 6.486390] do_fault+0x2d0/0x598
> > > [ 6.486391] __handle_mm_fault+0x398/0xb60
> > > [ 6.486393] handle_mm_fault+0x15c/0x298
> > > [ 6.486394] __get_user_pages+0x204/0xb88
> > > [ 6.486395] populate_vma_page_range+0xbc/0x1b8
> > > [ 6.486396] __mm_populate+0xcc/0x1e0
> > > [ 6.486397] __arm64_sys_mlockall+0x1d4/0x1f8
> > > [ 6.486398] invoke_syscall+0x50/0x120
> > > [ 6.486399] el0_svc_common.constprop.0+0x48/0xf0
> > > [ 6.486400] do_el0_svc+0x24/0x38
> > > [ 6.486400] el0_svc+0x34/0xf0
> > > [ 6.486402] el0t_64_sync_handler+0xa0/0xe8
> > > [ 6.486404] el0t_64_sync+0x198/0x1a0
> > > 
> > > Indeed finish_fault() takes a PTL spin lock without irq disablement.
> > 
> > That indeed looks incorrect to me.
> > I was assuming __foo() is always called with IRQs disabled!
> 
> Not necessarily. For stats which never get updated in IRQ context, can
> be updated using __foo() with just premption disabled.

Ah, thanks. I was missing that aspect.

-- 
Cheers,
Harry / Hyeonggon

