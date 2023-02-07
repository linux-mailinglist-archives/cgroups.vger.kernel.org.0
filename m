Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF2368CB6E
	for <lists+cgroups@lfdr.de>; Tue,  7 Feb 2023 01:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBGAsd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 19:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBGAsc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 19:48:32 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D141824CB3
        for <cgroups@vger.kernel.org>; Mon,  6 Feb 2023 16:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675730911; x=1707266911;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xzpFg09Ej6GAiCD9RljIocNF+osY2wLKZY5C2xh0/Es=;
  b=OdvNrxy1cRUkCEzdJALr6Y7faM8gPp3Y57LoRpFR8NGYbVNwuXFqHpIv
   MhTmcNMQTO5Wg4SLb/HldGzuyduj7lU/HvahwoNDijHAXeLYq8SLOkMpE
   TkfcM6wI3JfZfNz/Td+mfSkfypbNcswQP2UqPX6TuwVhX3b/YJ+/+FjO2
   NGpQP1t5pufuW0DhU1S+4fYiW4hlyeTq+HB0iwI1YvmjEMuSOJCwyzHtT
   RdCl5zM2n9ds13/bXJEDHg1fMCETNvIC4JBwhf1lOpbr17+A7uWYADhW7
   6QBcSDn0kXQNm5mFWaJJro6QZ/KZUcuHShIMEw5JbiiZK+M3ReRIfr1Z3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="329377094"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="329377094"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 16:48:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="668586132"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="668586132"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2023 16:48:29 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 16:48:29 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 16:48:29 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 16:48:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lC9NJlPGZvYNpBncpFikIuRTGW8Xf5aVsS2dfVhTyNz4SBn86Utg3fVBdhokio95OkzZmkeC6J+uHewPx142/o1zj91AwX8Zsv+oEQdqcSpZxXG6RHMOVk9WLl33GMpTk+2eFPU++WDIgA0HF0vAerynUybkFhmyy45yHTTv/fhCWonsmKxgM/Guu5KnE6vOTyemrrKlDMavaniH9QceNNKU4xTq88rlTzSAmm9k4sSBY4aNSSRSibOL4r8DMWpane652zfrUVmG6ubgP1oYwwyfZ7Ic9tPhvtaGu3B/m4ytTEunkutSdnBvRJFs+ZjO6Urgd4hrAj66uoKxzTQL5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzpFg09Ej6GAiCD9RljIocNF+osY2wLKZY5C2xh0/Es=;
 b=MeS3/CVAeAKasxhzuBTHdMsTmky/hRVpqFWn9efStynqzdibJvmghBBRXIrHt0Jruqh5W3ETwvg4tP4yHXG19cFQgBF3nk8BzNaCWypoBcNQfTZxTluuqsk0SiGsPVkgaskKR3rRspAmq4HlqAxFO9/HoA8skH5Of1KbJnorrboQjrAF7VdMZKq7OldVACiLW3c60OFqsUciTON/3aB0p74P29cYXkLtTKz3unjdDG/izB76fJIcfHLAXR4LDNgKZtjv0Zewipmz2yqboGTCOh0ZS9PKo3LKJNkCvYt/1Fr74Lk+O4c7w75Ev2seyLxgnTF0iIp9DXujoqwPI4vcIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH3PR11MB7298.namprd11.prod.outlook.com (2603:10b6:610:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 00:48:17 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1%8]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 00:48:17 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Tejun Heo <tj@kernel.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "Thomas, Ramesh" <ramesh.thomas@intel.com>
Subject: RE: Using cgroup membership for resource access control?
Thread-Topic: Using cgroup membership for resource access control?
Thread-Index: AQHZOnPnbooDlMFe40SoGw64NHt7aa7Cc06AgAADK8CAABqzgIAAFOSg
Date:   Tue, 7 Feb 2023 00:48:16 +0000
Message-ID: <SJ1PR11MB6083BE9581BA00F3B9833C8FFCDB9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <Y+FvQbfTdcTe9GVu@agluck-desk3.sc.intel.com>
 <Y+F0NA9iI0zlONz7@slm.duckdns.org> <Y+F0mXS9z0flDhf7@slm.duckdns.org>
 <SJ1PR11MB6083C61BCA70A31F8C0F12ECFCDA9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y+GNp4VA1T9pV6nM@slm.duckdns.org>
In-Reply-To: <Y+GNp4VA1T9pV6nM@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH3PR11MB7298:EE_
x-ms-office365-filtering-correlation-id: 9064de59-a982-43b7-d2e8-08db08a50045
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GFvwH5/PhmHuYrldosCPGFpW2RvAQTurKt4rs3LJnFdqFy/nrKKNmEBxxWtnizVCIQ8T8M+WHycO6bWYkerY/XXHD4MxaURZMEViNzH+sxuVvjyYf2l6hcJml/wDZgWToHcb+woANPr50CzNNtUvFhW5yozdcNXGiCAStpqQqaxbhFEApwVcg3r1xVd06HP/WzOn8O7bcwzjQLVport/cwM5LD9XVQd5wF3A/pDTacclaNxttKO1yUgHvMETWRDCB/hi7fnlg4nGidCL+Z0zK738OQ3a3kDTRCRLOje+0IPB/fiv8lRexkk8Sasc9XJYAn+elNL+LkbkJWzMpWzbtPTcObclI6TnqCjWyIInuQ1Z5VljjDPtEvIiwWZX7nY3UxUPRl5IUnx2VWYp9I9NGYSL84BPNvXJ7RLanQ4NIm2qzCNVeJnUzxlh5sa9HiuDccxjNbfun++jMm4AUsoLeRK/J/pVvoil3/m+OD/F0045g8eqyEkQDXHgYe8cHGweh7rVYVtDH3pwigWcDbDWf5mIOLhDlGYGPtHHaJ2Ae534s6aiMby6nz5im54v8td7h/KRICPZfrkRmPmPrmcyRVk3qsAW9DfPL3iQNQUwjUnwthj+uWdIELhdsvYTEp+K3a+Yye/0vdbZWfUXiD0RH9xowTgdY/Fjj8fnNYHw0iqihUnCYyFbqoH9iY9kgHZz38UAjAW/ehKh3ypYyaZJJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199018)(38070700005)(83380400001)(66946007)(82960400001)(122000001)(38100700002)(55016003)(64756008)(66556008)(8936002)(41300700001)(66446008)(66476007)(6916009)(4326008)(76116006)(8676002)(2906002)(52536014)(4744005)(6506007)(26005)(107886003)(186003)(9686003)(71200400001)(54906003)(316002)(478600001)(7696005)(86362001)(5660300002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dtJ2olh94tQz3uDy0dVaYyXXwiGvekkw03+D7qscGSznYhaO03f83FhTacig?=
 =?us-ascii?Q?EBcARTkEEIRZOwpGZhekHXhFnIk39mau3u7cWuLbWw/69UuNctZ1JJMmekGu?=
 =?us-ascii?Q?IG4Dxfk/WOjZw2qTZ2MqBpg+I6Q53RMgwA3L8nyk0a36LTS4Je3fwrcYzFrq?=
 =?us-ascii?Q?MNWEcKisWsG75Gai/dsvNBOLxTIp6+iIBn2NhSE5SftFYxswTQot8B5GVvJW?=
 =?us-ascii?Q?1Ab+2+uN2ezuNcZ80is5PUUZTyR9DYfB9gJO567Jgg0zPgX/JiaTei/g1f3I?=
 =?us-ascii?Q?5Y+JbuPBzroUBgMDukJJHRBwtLcWd5PaVq3o36nfzU8A4Q5HJMYZ6ImJkWvh?=
 =?us-ascii?Q?WR0Bjzm5n/ucPhP1m0xzWQiVhEIwTPEL4GxbEU7cVOf7QNgDb8WBBEPCWXxm?=
 =?us-ascii?Q?TbT04KI1PSlLXeu1FJ13vhCLaPAbkeDWinbP/SlQ9pW9o9ug8EIuPqg7I73v?=
 =?us-ascii?Q?z+gStVMMUcPPTW2rUpFaP8OrnNmU4qS1Oo6+s2nA/MCX9j637CIbhAELN4Gi?=
 =?us-ascii?Q?HD90bIRg9bnV7s+InMZd2/vfxwJJ201d1P1CC1/SFKE9Q5f6Aj3O7V0CiG9A?=
 =?us-ascii?Q?ehHGQq57ECicwGx1RfhXM2TM80zd7MfAyn6Z5FuYzzcG3jHUk7+5vxTvSzD3?=
 =?us-ascii?Q?P314rYUC5seM6v7iTVUIsZQF09QkdfJ5SpzYG9BjW05PNFHC9Dm78R7I+DLs?=
 =?us-ascii?Q?AtIY+JhW05YRuL2v+JsplfsZKhDQ1Y0jSV1JuFoAYOmjwUaB+2ZmL73xs16G?=
 =?us-ascii?Q?EdaEAYYryHcPJpE/To5mT8+ZDfbd4hLMLdW1FWBOKRfyPYHqWpTdOxizbt61?=
 =?us-ascii?Q?X/LWjSBNnVlUL1LmSKy+r9R4F1qU3592GaUjrw4iPW6xfhQeQ1hb270lLM8u?=
 =?us-ascii?Q?4jH/+abXl6REnDGi1EyDgvH33oQtT384+bVBiQIfJN/UmvH2xoTcP/I/eCJD?=
 =?us-ascii?Q?8mpxa4fenWamb68Bd8GFTHHMe32/8++PEvQ+JBJnJ3Pfunkyti9Zx33bKAst?=
 =?us-ascii?Q?Jxw/cs3eqUrrUG7NNLNDkD8q2VqKteDJ+LkHkITRaTdBkNQ7lOksWufGBTRE?=
 =?us-ascii?Q?aGcrnQTXdhVrLcNIhSKSzozXHnHkZkNi8vXo36RWmIATXwbE3PtdMewQIfVQ?=
 =?us-ascii?Q?8UmHFZbSkib5APt2QufS78bxKe/AWNz6zjYQV9swMGKucp3+f0odU3W3GDFq?=
 =?us-ascii?Q?oLEKYjo5QBLtlZ2eQckScLCEIkYUqBLbdA2Wnu/dxSKtRsHk9s2SAzJ0lp9/?=
 =?us-ascii?Q?mybsv1OVRlox4z2BF+1+bsLOdovaz2tQ9FGqGKeyXh10b845ZXKp6muMkr2U?=
 =?us-ascii?Q?fBKpRxdYxqNoNRKrNyFSvvDAz1PmAdSHC++YSPgYmrjiB4sBvZQixJBBn3Cz?=
 =?us-ascii?Q?PTNLNG4AzOhSNgcHxwCcZHaG+bE7n6a8wCYvg8OkkLg27UOHdKQ71grFlMKE?=
 =?us-ascii?Q?mte6HsuVk1Ac8KfSTA3ilNOuImSUsl8SHIeouDNIb+QLDMbAwkNP70i16kaH?=
 =?us-ascii?Q?Zvhp+catH+yQftBY2psVbJmtQoU+ipkpXGqYPuhYXmsQVGiwe5N/NyrySDZG?=
 =?us-ascii?Q?u02y0FKGItsLrL1qQxMRJZ0Qv+mQ8Xm5Pjr71u2a?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9064de59-a982-43b7-d2e8-08db08a50045
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 00:48:16.9790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZQahftPZoALyQXkJoqtBXFzdET/MXlffoP0YKM+9bIl95dlmAJs2QcG4IvbnHCyv54UtrHppHwopViOIxEfTqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7298
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> I'm not sure it'd be a good idea to introduce a whole new mode of access
> control for this when it's something which can be addressed with more
> conventional mechanisms. Maybe it's a bit more upfront work but one-off
> security / naming mechanism feels like they'd have a reasonable chance to
> cause long term headaches.

Being the first to do something is always risky. But thanks for looking at =
my ideas.
I'm going to take your advice and try to build on existing mechanisms inste=
ad
of creating a new thing.

-Tony
