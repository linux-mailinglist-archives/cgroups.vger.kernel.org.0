Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884FB2AAD5C
	for <lists+cgroups@lfdr.de>; Sun,  8 Nov 2020 21:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgKHUVp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 8 Nov 2020 15:21:45 -0500
Received: from mail-eopbgr760075.outbound.protection.outlook.com ([40.107.76.75]:63478
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727570AbgKHUVp (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 8 Nov 2020 15:21:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M99dUAmJJqQNmkUZzqMlVZihsFWkY19YXDkriQovAERBD3X4P1kklIifNgy+YMcqdy+ypnm/7sVlraz3EWNL0A4eqrjn6f3K65b1oyWo0C975YnCeTG6KHA4um5NzXixWc1Gjj7IDw1kzT3WKl7+l8tyC/o51cWW+3M9JA0c2+s6233j+o2kuHtyRZEl4bg10pNqvvYdNXcf6IaWjhNDNv7xJ5o41GjcFgcw4xUHlfcT/rugBOESF5cdEslpaNm2/kRZUsgd1Cdu22r98QFSuRVwM/w5BaLPLZxMBOk40GXg8qnaw2xJdX4Zo6phRiihTAGS9cJsTaF1rNzagXG79A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLAK9FzJCGbK3dUFfXIe7ExR8HpHqLU6wJAyh2n3a8E=;
 b=Iqo0pD7gUs9EuyqjUopzXW0OGL2dHv/1pm9SB1plUJBkUi08Ee8XaGWDhbxeZL/joX4C0ogyc0Vc1w28V8bZ8whH7DHgOZ1K4RycLLalZ9r7L2bYLtrBQj1EP4bMspdPCem07Rm2BU/OLgdfQSOq3sgysVpA6SMVTLnRRhFS05loGquDiSaxJfZPr38lt4f57xekY1823Hj+j7GdOflIRPSwyMsWfafd2m+VGCow2aBaCET1GPqZ+vmFwMITCO1YiCBQJoSe/w63ILEWGOmLiozrDIa92+HPWoD6fxAlTGIJq8kaSNkoQgpXFLAIDxf/5330hULEi8dEjlxQ9MzZ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLAK9FzJCGbK3dUFfXIe7ExR8HpHqLU6wJAyh2n3a8E=;
 b=Dx78A9ir6aY3bdQdLCnUrMBn6iCJGjt5fW7JuKAJqMkZWxnaD1Sayzc3TJRN6uwL5Jpy8sAQjINriHtWV//yYyUmmB8Tv3L8iBbx82mt5ZauBtKKaA62E+JiAB/S2ok4UF8kPn6S+oskB+9a51tuwYradc9qxBS+Wd/RlGGNM5k=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR1101MB2091.namprd11.prod.outlook.com (2603:10b6:4:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sun, 8 Nov
 2020 20:21:42 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40%4]) with mapi id 15.20.3541.024; Sun, 8 Nov 2020
 20:21:42 +0000
Subject: Re: [PATCH 0/4] RFC: support for global CPU list abbreviations
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Li Zefan <lizefan@huawei.com>
References: <20201108160816.896881-1-paul.gortmaker@windriver.com>
 <20201108180222.GA17637@paulmck-ThinkPad-P72>
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
Message-ID: <ca462940-c81d-d968-c870-e1a991331522@windriver.com>
Date:   Sun, 8 Nov 2020 15:21:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201108180222.GA17637@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.212.229.210]
X-ClientProxiedBy: YT1PR01CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::24) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.25.35.34] (24.212.229.210) by YT1PR01CA0085.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Sun, 8 Nov 2020 20:21:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eca0c73a-3749-46c8-11d5-08d88423e828
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2091:
X-Microsoft-Antispam-PRVS: <DM5PR1101MB2091FA83077347C4D536D23783EB0@DM5PR1101MB2091.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qpp4EALCv43EKNhQ6Yidypc6kUf8lIipn6jY1CibsM6+5qfJ5moWC/kVYOZP5BLJ5yjlxpzBvzitFFPGJ5+KkjNmnMXXYOzPNq/YXysH6LNcTc/4t61nnFPYeYmwXLuDPBxd43vUilUgRuLULfUlWU5FThheedCUzRD59Pt+4ZYbu2zpSDTyzu6Z2WqkLMnNu+99FjAh9xtCnlUUjlHX/fdjo4syvd2/MU3KFgha/7Lx1MPStBoznX2+kxYV/bshkgKeC/ED1YOLPPmNBM8sQgxua1GnfudQHF8x3pCPZ4kYAduyvMdLQdDxVVFvfhAZ+41dG6DUOq11EuqfnmymA3Lp6Eb2oJh+9KZQOr+uQZThASWvRozIgpfijlRqs1xc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(39830400003)(396003)(346002)(2906002)(8936002)(478600001)(66946007)(4326008)(54906003)(956004)(36756003)(44832011)(52116002)(86362001)(53546011)(2616005)(66556008)(66476007)(31686004)(16526019)(4744005)(26005)(6486002)(6916009)(8676002)(316002)(31696002)(16576012)(186003)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: CsPQm/23+SOuVR79We/6KFU0amBE/oLVROZ0hzhn27/0bYi63PKLPfYGId7tpusvJQcvU6gPulGK2MIgJU5hWcKXx1hjLCEsFLq/BCf8wqTnQcDWpZVQ+EMFofQhIJnOUwiYm6Q4mT/yVw2/EtIHNFArRJftzFdchlVOSk3frQjm8r2hLPU0L0ZkDcC1APZguJ6XwuAirp2YxPa5dEZxR2r3hgZzXBKMJrTvGFMbQvsdh0LIw963dKKEr2R7QBJkfyuwLrvaXlCujiFcqvp3IVlhjCpinx9vYyuHjZ9v306oa7okqUUd9Z8otL1OWVKssYlvJXEATxzAJyz17HL/qbcUy6D6NK0QFWZw9r56KAy80wnff/lzAyujRKwJNAWL53k8co2b7JUsZ9esLyIl49gHXRhYBB+VgHh6j2mHDZVxCQf5NaRjwfgqQchUDDRCNGASnJI3DBBJDZ8Y9EaWh9XBtG7N4iuBW0H2dkpW3UI07smkkVdFVOZiCuEuR2215Vg49ylJufdmsPWMqdQtb84S1W+3xkxGGKU9O2FRA0uSdRxu3lsw6jFvKi9UcBvF1SFZVT++a7hJrE7y02EOyXY9Vmv6/XmUKgGcE1iPRTDhXvcM9Pc/uPNJk0o4I6a6X2l3B774i2yXyRePQjSP6w==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca0c73a-3749-46c8-11d5-08d88423e828
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2020 20:21:42.7692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sntfQfOJUdto3zevSCeJgyEFt5YMTliMuxXfDDELzOmGNpLTzzDKF1nyxeLxaXiunPvLLm9271tJR8quKXQYftHfx8vjtRWEWoEDVNVSoH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2091
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2020-11-08 1:02 p.m., Paul E. McKenney wrote:

 > Or I can carry them if you wish.  My expected changes in response to
 > this series are shown below, and are also what I used to test it.

Thanks Paul - that would get linux-next exposure w/o me pestering sfr.
If nobody else has objections, having them in rcu-next would be great.

Paul.
--
