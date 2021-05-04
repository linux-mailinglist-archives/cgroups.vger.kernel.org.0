Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02281372F50
	for <lists+cgroups@lfdr.de>; Tue,  4 May 2021 20:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhEDSBt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 May 2021 14:01:49 -0400
Received: from mail-mw2nam12on2083.outbound.protection.outlook.com ([40.107.244.83]:19585
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230285AbhEDSBs (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 4 May 2021 14:01:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmNpu9UT0d4FQDwxy93P9PB/ZSUoSyR7DImgaLwa+Y4/NfdLyoyoMCkK2xNMYfQxHdBnBBS4FV9RGIg/zsI5JfNTVVy8BoQ4jGzcaAeXJzygdCQrE5yltZhrZPc3GKM+JJa/mZiR4pmG3FAZ5BCpeLpiRtHI7yjyBEvlLUV6IKNGOiKSzHqjTeRjxmgSYKxF1H9sS4GY6PlXjsTzufluZE5L6OAO3h9GyVcMuS+sVD9M8eqMWDLYfyvOVtUeZgHzjmWETNx7eAjC1tjWxgSU9uU19Pa5X9VqiMVAUCYE7qsQxSlFQDkuYUOZBygbpEiCEvYcdMCBKvIa65lmN25AcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tES7OamPG2yhB1EsQjtDi+wmW2DPq3IAhbWd332A87w=;
 b=g5VKMtT46muXRiukkP235bFYGji9c8D0kFVSjAl6d+i5a/nY4AwstnEyVAjxNINrvNneKaBFuTWk/CUuFUJGyI3savG1IWGmIG8/WuBoKzE7z250rQMEg1L2Aq9qO3OvOuXwCDn9jPspm8pJyG8pagu1oy+Gc05zDz5kKVUL8Gj8REC9PdjRR61FrnIwmJZ19lOisrUyBfZbo3t9d7cN+Bs8xhyM8ZoVElkRyVwAEF3qJrFDUOpKEa/8lrMEEypg7m6YYYGnXgAKnghKU23As+oayj9SCCbAnikJIiIuGaStHIEHoYHRYolYo5dzkQGGkT6OyOxMnLNVzgSCE23nDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tES7OamPG2yhB1EsQjtDi+wmW2DPq3IAhbWd332A87w=;
 b=pCoR8RpzDIRFKAgAqVijxTfGIfVEEiXzE3iq5fP0oum8pe7jbZHPP7h8I41gXArpj8OozCYE8K4NyI19ZmfIORliZ0F60tM0zffvoqib2XXFhf77YspOEcfExLL6iZD+pKZm9k7FKw2PKRceVBbWKEvRfVqVRsGFOux21OFNG8RBUK3Uz9Z9U1mnN3I7TNpbGaGl/DHX90BIOwslNu5zyfTEyaoELCTpLMt5rkAo4NYWvjVfUSaIX3hGouMAGYgY4ORTyQcEsPOdekYzSi1RhryurLVEFqkZ6xsL6MH9O2jozpfilax6t9Pmrw2Wclc097fHWMbfay/rTzPTS1//5g==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BY5PR12MB4067.namprd12.prod.outlook.com (2603:10b6:a03:212::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Tue, 4 May
 2021 18:00:52 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::81ef:d824:43ae:aef5]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::81ef:d824:43ae:aef5%4]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 18:00:52 +0000
Date:   Tue, 4 May 2021 15:00:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Auger Eric <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210504180050.GB1370958@nvidia.com>
References: <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210422121020.GT1370958@nvidia.com>
 <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210423114944.GF1370958@nvidia.com>
 <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210426123817.GQ1370958@nvidia.com>
 <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210504084148.4f61d0b5@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504084148.4f61d0b5@jacob-builder>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAPR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:208:329::35) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAPR03CA0090.namprd03.prod.outlook.com (2603:10b6:208:329::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Tue, 4 May 2021 18:00:52 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ldzLm-000XJA-HA; Tue, 04 May 2021 15:00:50 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0b3456b-1dd2-4322-d232-08d90f268e5a
X-MS-TrafficTypeDiagnostic: BY5PR12MB4067:
X-Microsoft-Antispam-PRVS: <BY5PR12MB406795A89B5B407532E40FCEC25A9@BY5PR12MB4067.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5pGOoH6MvliesIB5f7UBBHXtZ1tyrUFS+FmO3RfDSypVMTwzBr6z7AvlEjMCZTxlvY6L3rtrhZxZjSEtSOVw7ja0UvfjW5yPCjpFFC5imZWEVuKaVXARQt2j7OQaCdKzIuQMKDKVn+wgqVQX+OFefneOjB/yz1LXgFdC1IcUdtoj+KUVGxa69cUWcXkp9hsWU1pkMaI54VCqMCaXgXeYzCfRR9iA65a4z7GBfLOZryiqEHriVlzQThc6+rPfgLq2GcpYZdSUzZWTdEHhu7H2qBuFABk5Uug0ZvmMiPzO/07uUBfCqYsQFjOLYpu19dunXP8sG4NXTKuunlfW1eVfgQui6xEyLyHbspSX3OAUaO8iCYwwXVk3vm+vWUMyp68E2k4B7cld+093YD6RgKjxZz37+oC2fmcvEoNiR0S7aJz4vMTFDJn7RTA49Xgaoq4dRhto0za/oE1YP1Pdfa9RT87LLFhwAyDJrB4QebjlxzrTFUW5SWjG5aX/RekxLPyzW9cmjSX+svSrDj/WcBNbfmGUGIH9JZJqmG0KJgo1OFuH+aREpqI5KelHVVlqixtzIc1fNtbAhZrcK5zS3ef4+04qSvNSupWKvmd4PTEqUPc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(478600001)(26005)(4326008)(33656002)(1076003)(5660300002)(2906002)(9786002)(66946007)(66476007)(86362001)(36756003)(2616005)(186003)(8676002)(8936002)(83380400001)(6916009)(7416002)(9746002)(426003)(316002)(54906003)(38100700002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iaY2CYjaLXDy5p9iIQURMD6Vsgr1M3WZhs3S7NjLgYufl/gLO8VTwGMvrvst?=
 =?us-ascii?Q?In9jNjOX8rBydBljNubQZWvVVRavZDdYxKOATIxlaixS1r/AiYbuZH8FT9zO?=
 =?us-ascii?Q?JHJsl7Ttl/ydMIcu4fkyhvVwqfZ9fguVz8Y3j60fN0OFWOA6A92MUWap0nMg?=
 =?us-ascii?Q?+Kc4WOm0tNXKQIeCvkfz3FehifjpYIHSHRDIIKm9tm4dhEF36EYCZ4S+aSpM?=
 =?us-ascii?Q?2Ud9n2YT7xiupCW8DF4P9puRs0VhED9XhIT+1tssHZE8K9RhuhysIyA8WuBi?=
 =?us-ascii?Q?KT0dNwBFrMS+p2kP6yEjjoPLeXiPZW6lGYi3Btw5M1sPt6p16503RmBR9vx+?=
 =?us-ascii?Q?vj5+Baz3HCEWLhqZ719HScJb3GpJzg04JVhXWlnBij+5QCXCFut7waQEPq2q?=
 =?us-ascii?Q?0B8N7hLZfVQEdeZmyPvp1mdEBddFKVzwmwELAZDtedeQIcCbDVEEMtv1fEBg?=
 =?us-ascii?Q?mssLRypsIEwdKRJeEK+OKxiy+UgmB/WZS34FcwoIgVT7TqADTpwmbzJDxrR4?=
 =?us-ascii?Q?Ib8Jj4bYRUMCWEEXvtZEMsj9s18mpSFYN+DJ/XOGWBkNbqkNAXZaCzj7hqo3?=
 =?us-ascii?Q?E+GXBEhHF04cEapc5cNimWDkDRapxwDkIeyyBWF+gpoNSiqJJ1K4BwJ54/WW?=
 =?us-ascii?Q?yXOcSBCHgMylTha/V18Jv/U2Mt6EauPaHKFiizFMDD+v05V0eOwUksqKywSa?=
 =?us-ascii?Q?Fk3uLdYMGKKRlY9dCJMMtPMtXmT2tJGcSOliB9sAhZSL2Sp3WrXZB//QSjjF?=
 =?us-ascii?Q?UzbYIZqaDV3SYmjgS2MieyyozlEALSk5xKERiZtTDq1LxoKYcT8SNXXulR8H?=
 =?us-ascii?Q?43T7ERqiQXH4McI8FovmXJ5eiumiJAYfjWF254DKA4Nfyn5w+k4K/1mCWJgw?=
 =?us-ascii?Q?4Md1OjPRm9+4I/hDlskM0n/OUYJtkzB1/JD/5YailV6p/JyjRGXVZQMBxIAv?=
 =?us-ascii?Q?5Cj0lZ48oThrKUE7P0pMQ4LHGDtMnGRgpb2Njbz+AqeJY/r8goTDTacmb8IC?=
 =?us-ascii?Q?XFEJ9bkQb02MHnePKe1iO4qIaKdHm4hyX3jx4EXqR9Kb5ekIDN9Rj7WrLvC7?=
 =?us-ascii?Q?xpoKhvi35332RJQ1p6pQBfkyUOhjRG4rRoIS0PPWEF6BqRk1OwszlkbiLdsR?=
 =?us-ascii?Q?MKHNKCrr5DNwaCkEqIu5NI0Q+Zhd7vKUpZmy+9N7NzeWdaFFCN4kFrgm1kEs?=
 =?us-ascii?Q?1AxUZ94EQp+htAX6KxStjye6a5pSAaSnty1+3TZGfcnnME/ikcKemvJBmWfm?=
 =?us-ascii?Q?h/LXyXFdl8hOidqoTh9EyL13lO+Vcb74tkk1YdzYPTw53o5fY9ysJEKHOET0?=
 =?us-ascii?Q?U5ZucBzdfq2kaSlCZ1odxDNX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b3456b-1dd2-4322-d232-08d90f268e5a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 18:00:52.3744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWpAzv8dPFPy9NwXobWlQBST8JDIIAMZRS5lfcJvKL/3xElwOaRsA9BevUmasAt2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 04, 2021 at 08:41:48AM -0700, Jacob Pan wrote:
> > > 
> > > (also looking at ioasid.c, why do we need such a thin and odd wrapper
> > > around xarray?)
> > >   
> > 
> > I'll leave it to Jean and Jacob.

> Could you elaborate?

I mean stuff like this:

int ioasid_set_data(ioasid_t ioasid, void *data)
{
        struct ioasid_data *ioasid_data;
        int ret = 0;

        spin_lock(&ioasid_allocator_lock);
        ioasid_data = xa_load(&active_allocator->xa, ioasid);
        if (ioasid_data)
                rcu_assign_pointer(ioasid_data->private, data);
        else
                ret = -ENOENT;
        spin_unlock(&ioasid_allocator_lock);

        /*
         * Wait for readers to stop accessing the old private data, so the
         * caller can free it.
         */
        if (!ret)
                synchronize_rcu();

        return ret;
}
EXPORT_SYMBOL_GPL(ioasid_set_data);

It is a weird way to use xarray to have a structure which
itself is just a wrapper around another RCU protected structure.

Make the caller supply the ioasid_data memory, embedded in its own
element, get rid of the void * and rely on XA_ZERO_ENTRY to hold
allocated but not active entries.

Make the synchronize_rcu() the caller responsiblity, and callers
should really be able to use call_rcu()

Jason
